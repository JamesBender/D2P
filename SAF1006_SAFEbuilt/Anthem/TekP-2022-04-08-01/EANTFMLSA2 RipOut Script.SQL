/**********************************************************************************

EANTFMLSA2: Anthem Life Compass v2

FormatCode:     EANTFMLSA2
Project:        Anthem Life Compass v2
Client ID:      SAF1006
Date/time:      2022-06-09 10:45:37.577
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    NWP
Server:         NW1WUP3DB02
Database:       ULTIPRO_WPSAFEB
Web Filename:   SAF1006_4I7VG_EEHISTORY_EANTFMLSA2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EANTFMLSA2_SavePath') IS NOT NULL DROP TABLE dbo.U_EANTFMLSA2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EANTFMLSA2'


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
WHERE FormatCode = 'EANTFMLSA2'
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
WHERE ExpFormatCode = 'EANTFMLSA2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EANTFMLSA2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EANTFMLSA2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EANTFMLSA2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EANTFMLSA2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EANTFMLSA2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EANTFMLSA2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EANTFMLSA2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EANTFMLSA2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EANTFMLSA2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EANTFMLSA2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEANTFMLSA2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEANTFMLSA2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EANTFMLSA2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTFMLSA2];
GO
IF OBJECT_ID('U_EANTFMLSA2_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_Trailer];
GO
IF OBJECT_ID('U_EANTFMLSA2_HeaderW') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_HeaderW];
GO
IF OBJECT_ID('U_EANTFMLSA2_Header') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_Header];
GO
IF OBJECT_ID('U_EANTFMLSA2_File') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_File];
GO
IF OBJECT_ID('U_EANTFMLSA2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_EEList];
GO
IF OBJECT_ID('U_EANTFMLSA2_drvTbl_UDDT') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_drvTbl_UDDT];
GO
IF OBJECT_ID('U_EANTFMLSA2_drvTbl_LOB') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_drvTbl_LOB];
GO
IF OBJECT_ID('U_EANTFMLSA2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_drvTbl];
GO
IF OBJECT_ID('U_EANTFMLSA2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_DedList];
GO
IF OBJECT_ID('U_EANTFMLSA2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_AuditFields];
GO
IF OBJECT_ID('U_EANTFMLSA2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EANTFMLSA2_Audit];
GO
IF OBJECT_ID('U_dsi_EANTFMLSA2_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_EANTFMLSA2_EarnHist];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EANTFMLSA2','Anthem Life Compass v2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1500','S','N','EANTFMLSA2Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTFMLSA2Z0','44','H','01','1',NULL,NULL,NULL,NULL,'"drvWHeader"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTFMLSA2Z0','3','H','02','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTFMLSA2Z0','10','H','02','4',NULL,NULL,NULL,NULL,'"drvGroupNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTFMLSA2Z0','50','H','02','14',NULL,NULL,NULL,NULL,'"drvGroupName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTFMLSA2Z0','8','H','02','64',NULL,NULL,NULL,NULL,'"drvDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTFMLSA2Z0','6','H','02','72',NULL,NULL,NULL,NULL,'"drvTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTFMLSA2Z0','1','H','02','78',NULL,NULL,NULL,NULL,'"drvFullDelta"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTFMLSA2Z0','1422','H','02','79',NULL,NULL,NULL,NULL,'"drvfiller"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTFMLSA2Z0','3','D','10','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTFMLSA2Z0','50','D','10','4',NULL,NULL,NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTFMLSA2Z0','50','D','10','54',NULL,NULL,NULL,NULL,'"drvMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTFMLSA2Z0','50','D','10','104',NULL,NULL,NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTFMLSA2Z0','50','D','10','154',NULL,NULL,NULL,NULL,'"drvMaidenName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTFMLSA2Z0','8','D','10','204',NULL,NULL,NULL,NULL,'"drvEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTFMLSA2Z0','8','D','10','212',NULL,NULL,NULL,NULL,'"drvTermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANTFMLSA2Z0','20','D','10','220',NULL,NULL,NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EANTFMLSA2Z0','1','D','10','240',NULL,NULL,NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EANTFMLSA2Z0','8','D','10','241',NULL,NULL,NULL,NULL,'"drvDateofBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EANTFMLSA2Z0','10','D','10','249',NULL,NULL,NULL,NULL,'"drvGroupNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EANTFMLSA2Z0','8','D','10','259',NULL,NULL,NULL,NULL,'"drvGroupEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EANTFMLSA2Z0','8','D','10','267',NULL,NULL,NULL,NULL,'"drvSalEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EANTFMLSA2Z0','8','D','10','275',NULL,NULL,NULL,NULL,'"drvBillGroupEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EANTFMLSA2Z0','8','D','10','283',NULL,NULL,NULL,NULL,'"drvClassEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EANTFMLSA2Z0','8','D','10','291',NULL,NULL,NULL,NULL,'"drvBillClassEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EANTFMLSA2Z0','120','D','10','299',NULL,NULL,NULL,NULL,'"drvERName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EANTFMLSA2Z0','10','D','10','419',NULL,NULL,NULL,NULL,'"drvBillGroupNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EANTFMLSA2Z0','100','D','10','429',NULL,NULL,NULL,NULL,'"drvBillGroupName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EANTFMLSA2Z0','5','D','10','529',NULL,NULL,NULL,NULL,'"drvClassNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EANTFMLSA2Z0','80','D','10','534',NULL,NULL,NULL,NULL,'"drvClassDesc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EANTFMLSA2Z0','10','D','10','614',NULL,NULL,NULL,NULL,'"drvSalary"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EANTFMLSA2Z0','1','D','10','624',NULL,NULL,NULL,NULL,'"drvSalaryFreq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EANTFMLSA2Z0','3','D','10','625',NULL,NULL,NULL,NULL,'"drvHrsWorks"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EANTFMLSA2Z0','3','D','10','628',NULL,NULL,NULL,NULL,'"drvEligibilityStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EANTFMLSA2Z0','8','D','10','631',NULL,NULL,NULL,NULL,'"drvDateofHire"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EANTFMLSA2Z0','10','D','10','639',NULL,NULL,NULL,NULL,'"drvJoinGroupDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EANTFMLSA2Z0','50','D','10','649',NULL,NULL,NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EANTFMLSA2Z0','50','D','10','699',NULL,NULL,NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EANTFMLSA2Z0','50','D','10','749',NULL,NULL,NULL,NULL,'"drvAddressLine3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EANTFMLSA2Z0','50','D','10','799',NULL,NULL,NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EANTFMLSA2Z0','2','D','10','849',NULL,NULL,NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EANTFMLSA2Z0','12','D','10','851',NULL,NULL,NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EANTFMLSA2Z0','15','D','10','863',NULL,NULL,NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EANTFMLSA2Z0','15','D','10','878',NULL,NULL,NULL,NULL,'"drvFaxNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EANTFMLSA2Z0','40','D','10','893',NULL,NULL,NULL,NULL,'"drvAddressEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EANTFMLSA2Z0','1','D','10','933',NULL,NULL,NULL,NULL,'"drvSmoker"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EANTFMLSA2Z0','1','D','10','934',NULL,NULL,NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EANTFMLSA2Z0','10','D','10','935',NULL,NULL,NULL,NULL,'"drvBillClass"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EANTFMLSA2Z0','556','D','10','945',NULL,NULL,NULL,NULL,'"drvFiller"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTFMLSA2Z0','3','D','11','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTFMLSA2Z0','20','D','11','4',NULL,NULL,NULL,NULL,'"drvLOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTFMLSA2Z0','3','D','11','24',NULL,NULL,NULL,NULL,'"drvBenStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTFMLSA2Z0','8','D','11','27',NULL,NULL,NULL,NULL,'"drvEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTFMLSA2Z0','8','D','11','35',NULL,NULL,NULL,NULL,'"drvTermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTFMLSA2Z0','15','D','11','43',NULL,NULL,NULL,NULL,'"drvCovAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTFMLSA2Z0','2','D','11','58',NULL,NULL,NULL,NULL,'"drvBenSelectOpt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANTFMLSA2Z0','1441','D','11','60',NULL,NULL,NULL,NULL,'"drvFiller"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTFMLSA2Z0','3','D','12','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTFMLSA2Z0','30','D','12','4',NULL,NULL,NULL,NULL,'"drvType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTFMLSA2Z0','300','D','12','34',NULL,NULL,NULL,NULL,'"drvValue"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTFMLSA2Z0','20','D','12','334',NULL,NULL,NULL,NULL,'"drvLOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTFMLSA2Z0','8','D','12','354',NULL,NULL,NULL,NULL,'"drvEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTFMLSA2Z0','1139','D','12','362',NULL,NULL,NULL,NULL,'"drvFiller"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTFMLSA2Z0','3','D','13','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTFMLSA2Z0','8','D','13','4',NULL,NULL,NULL,NULL,'"drvConDateofBirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTFMLSA2Z0','50','D','13','12',NULL,NULL,NULL,NULL,'"drvConFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EANTFMLSA2Z0','50','D','13','62',NULL,NULL,NULL,NULL,'"drvConMiddleName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EANTFMLSA2Z0','50','D','13','112',NULL,NULL,NULL,NULL,'"drvConLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EANTFMLSA2Z0','50','D','13','162',NULL,NULL,NULL,NULL,'"drvConMaidenName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EANTFMLSA2Z0','1','D','13','212',NULL,NULL,NULL,NULL,'"drvConGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EANTFMLSA2Z0','2','D','13','213',NULL,NULL,NULL,NULL,'"drvConRelation"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EANTFMLSA2Z0','8','D','13','215',NULL,NULL,NULL,NULL,'"drvConEligDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EANTFMLSA2Z0','8','D','13','223',NULL,NULL,NULL,NULL,'"drvConTermDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EANTFMLSA2Z0','20','D','13','231',NULL,NULL,NULL,NULL,'"drvConSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EANTFMLSA2Z0','1','D','13','251',NULL,NULL,NULL,NULL,'"drvConSmoker"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EANTFMLSA2Z0','5','D','13','252',NULL,NULL,NULL,NULL,'"drvConClassNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EANTFMLSA2Z0','20','D','13','257',NULL,NULL,NULL,NULL,'"drvConLOB"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EANTFMLSA2Z0','8','D','13','277',NULL,NULL,NULL,NULL,'"drvConEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EANTFMLSA2Z0','15','D','13','285',NULL,NULL,NULL,NULL,'"drvConCovAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EANTFMLSA2Z0','2','D','13','300',NULL,NULL,NULL,NULL,'"drvConBenSelectOpt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EANTFMLSA2Z0','1199','D','13','302',NULL,NULL,NULL,NULL,'"drvfiller"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EANTFMLSA2Z0','3','T','90','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EANTFMLSA2Z0','10','T','90','4',NULL,NULL,NULL,NULL,'"drvTotalRecords"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EANTFMLSA2Z0','1487','T','90','14',NULL,NULL,NULL,NULL,'"drvFiller"','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EANTFMLSA2_20220609.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',V7CQG,CWMD1',NULL,NULL,NULL,'Active Open Enrollment Export','202206279','EMPEXPORT','OEACTIVE','May 21 2019 12:00AM','EANTFMLSA2',NULL,NULL,NULL,'202206279','Jun 27 2017 12:00AM','Dec 30 1899 12:00AM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSAFEB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',V7CQG,CWMD1',NULL,NULL,NULL,'Passive Open Enrollment Export','202206279','EMPEXPORT','OEPASSIVE','May 17 2019 12:00AM','EANTFMLSA2',NULL,NULL,NULL,'202206279','Jun 27 2017 12:00AM','Dec 30 1899 12:00AM','202101011',NULL,'','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSAFEB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','V7CQG,CWMD1',NULL,NULL,NULL,'Anthem Life Compass','202206279','EMPEXPORT','ONDEMAND','Jul 23 2019 12:00AM','EANTFMLSA2',NULL,NULL,NULL,'202206279','Jul 23 2019 12:00AM','Dec 30 1899 12:00AM','202101011','10944','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSAFEB',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202206279','EMPEXPORT','TEST','Sep 17 2021 12:00AM','EANTFMLSA2',NULL,NULL,NULL,'202206279','Jun 29 2021 12:00AM','Dec 30 1899 12:00AM','202101011','16448','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSAFEB',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','SubSort','C','drvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTFMLSA2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSA2','H01','dbo.U_EANTFMLSA2_HeaderW',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSA2','H02','dbo.U_EANTFMLSA2_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSA2','D10','dbo.U_EANTFMLSA2_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSA2','D11','dbo.U_EANTFMLSA2_drvTbl_LOB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSA2','D12','dbo.U_EANTFMLSA2_drvTbl_UDDT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSA2','D13','dbo.U_EANTFMLSA2_drvTbl_Dep','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTFMLSA2','T90','dbo.U_EANTFMLSA2_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_EANTFMLSA2_EarnHist
-----------

IF OBJECT_ID('U_dsi_EANTFMLSA2_EarnHist') IS NULL
CREATE TABLE [dbo].[U_dsi_EANTFMLSA2_EarnHist] (
    [eeeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);

-----------
-- Create table U_EANTFMLSA2_Audit
-----------

IF OBJECT_ID('U_EANTFMLSA2_Audit') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EANTFMLSA2_AuditFields
-----------

IF OBJECT_ID('U_EANTFMLSA2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);

-----------
-- Create table U_EANTFMLSA2_DedList
-----------

IF OBJECT_ID('U_EANTFMLSA2_DedList') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EANTFMLSA2_drvTbl
-----------

IF OBJECT_ID('U_EANTFMLSA2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_drvTbl] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMaidenName] varchar(1) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvGroupNo] varchar(7) NOT NULL,
    [drvGroupEffDate] datetime NULL,
    [drvSalEffDate] datetime NULL,
    [drvBillGroupEffDate] datetime NULL,
    [drvClassEffDate] datetime NULL,
    [drvBillClassEffDate] datetime NULL,
    [drvERName] varchar(14) NOT NULL,
    [drvBillGroupNo] varchar(4) NOT NULL,
    [drvBillGroupName] varchar(1) NOT NULL,
    [drvClassNo] varchar(2) NOT NULL,
    [drvClassDesc] varchar(1) NOT NULL,
    [drvSalary] varchar(10) NULL,
    [drvSalaryFreq] varchar(1) NOT NULL,
    [drvHrsWorks] varchar(3) NULL,
    [drvEligibilityStatus] varchar(3) NOT NULL,
    [drvDateofHire] datetime NULL,
    [drvJoinGroupDate] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhoneHomeNumber] varchar(50) NULL,
    [drvFaxNumber] varchar(1) NOT NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvSmoker] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvBillClass] varchar(6) NULL,
    [drvFiller] varchar(1) NOT NULL
);

-----------
-- Create table U_EANTFMLSA2_drvTbl_LOB
-----------

IF OBJECT_ID('U_EANTFMLSA2_drvTbl_LOB') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_drvTbl_LOB] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvLOB] varchar(7) NULL,
    [drvBenStatus] varchar(3) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvCovAmt] varchar(1) NOT NULL,
    [drvBenSelectOpt] varchar(1) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);

-----------
-- Create table U_EANTFMLSA2_drvTbl_UDDT
-----------

IF OBJECT_ID('U_EANTFMLSA2_drvTbl_UDDT') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_drvTbl_UDDT] (
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvType] varchar(18) NOT NULL,
    [drvValue] varchar(50) NULL,
    [drvLOB] varchar(1) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvFiller] varchar(1) NOT NULL
);

-----------
-- Create table U_EANTFMLSA2_EEList
-----------

IF OBJECT_ID('U_EANTFMLSA2_EEList') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EANTFMLSA2_File
-----------

IF OBJECT_ID('U_EANTFMLSA2_File') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1500) NULL
);

-----------
-- Create table U_EANTFMLSA2_Header
-----------

IF OBJECT_ID('U_EANTFMLSA2_Header') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_Header] (
    [drvEEID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(3) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvGroupNo] varchar(7) NOT NULL,
    [drvGroupName] varchar(14) NOT NULL,
    [drvDate] varchar(30) NULL,
    [drvTime] varchar(8000) NULL,
    [drvFullDelta] varchar(1) NOT NULL,
    [drvfiller] varchar(1) NOT NULL
);

-----------
-- Create table U_EANTFMLSA2_HeaderW
-----------

IF OBJECT_ID('U_EANTFMLSA2_HeaderW') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_HeaderW] (
    [drvEEID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvWHeader] varchar(44) NULL
);

-----------
-- Create table U_EANTFMLSA2_Trailer
-----------

IF OBJECT_ID('U_EANTFMLSA2_Trailer') IS NULL
CREATE TABLE [dbo].[U_EANTFMLSA2_Trailer] (
    [drvEEID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvTotalRecords] int NULL,
    [drvFiller] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTFMLSA2]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: SAFEbuilt, LLC

Created By: Parsha Antara
Business Analyst: Jennifer Flood
Create Date: 05/16/2019
Service Request Number: SR-2019-00229158

Purpose: Anthem Life COMPASS Proprietary Standard Layout (1500 byte)


Revision History
----------------
Update By           Date              Request Num                Desc
B'Nai Jackson        04/27/2020        PR-343669                Added class codes & Updated Detail Record 200 & 210 fields
B'Nai Jackson        05/27/2020        PR-343669                Excluded Employee Type Codes of  “CON” and “BRD”
B'Nai Jackson        06/11/2020        PR-343669                Blank-out the Bill Class and Class Effective DAte field (temporary update)
Marco Lagrosa        09/22/2020        TekP-2020-09-18-0003     Remove employee under ACQ paygroup
Marco Lagrosa        12/28/2020        TekP-2020-11-13-0001        Multiple updates for 
Ric Dreese           04/15/2021        SF21226889                Added class codes
Ric Dreese           05/25/2021        SF21673298                Class codes S077
David Niemann        08/13/2021        SF00316110                Added class codes
David Niemann        08/13/2021        SF00316110                Overhaul class code mapping based on Pay Group
Marie Waters         06/09/2022        TekP-2022-04-08-01        Code changes for HrsWorked, BillClass, and valuse fields for UDDT/CDR Record - 999

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANTFMLSA2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANTFMLSA2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANTFMLSA2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EANTFMLSA2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANTFMLSA2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSA2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSA2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSA2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTFMLSA2', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANTFMLSA2';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EANTFMLSA2', @AllObjects = 'Y', @IsWeb = 'Y'

select * from ascexp
\\us.saas\ew1\EW12\Downloads\V10\Exports\REDLC\EmployeeHistoryExport\
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
    SELECT @FormatCode = 'EANTFMLSA2';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EANTFMLSA2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANTFMLSA2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     -- Remove Terminated Employees - 9/17/21
    DELETE FROM dbo.U_EANTFMLSA2_EEList
    FROM dbo.U_EANTFMLSA2_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    where eecemplstatus = 'T'
    and xeeid NOT IN (select audkey1value
                        from vw_AuditeeData 
                        where audfieldname = 'eecdateoftermination'
                        and auddatetime between @StartDate and @EndDate)

    --remove test employees
    DELETE FROM dbo.U_EANTFMLSA2_EEList
    FROM dbo.U_EANTFMLSA2_EEList
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    WHERE 
    --(EecEmplStatus = 'T' AND eecdateoftermination + 7 < @EndDate)
       eepssn like '999%'
    or eepssn like '000%'
    or eeceetype in ('tes','z','CON','BRD')--05/27/20 BJ
    ; 
    --Marco Lagrosa        09/22/2020        TekP-2020-09-18-0003         Remove employee under ACQ paygroup
    --IF @ExportCode like 'TEST%' 
    --    BEGIN
    --Delete from dbo.U_EANTFMLSA2_EEList where xeeid in (Select eeceeid from vw_int_EmpComp where eecpaygroup = 'ACQ') 
    --    END

 

      --Audit Table
    IF OBJECT_ID('U_EANTFMLSA2_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_AuditFields;
    CREATE TABLE dbo.U_EANTFMLSA2_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EANTFMLSA2_AuditFields VALUES ('EmpComp','EecFulltimeorParttime');    
    INSERT INTO dbo.U_EANTFMLSA2_AuditFields VALUES ('EmpComp','EecOrgLvl3');    

    
    
    -- Create audit table
    IF OBJECT_ID('U_EANTFMLSA2_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EANTFMLSA2_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EANTFMLSA2_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EANTFMLSA2_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EANTFMLSA2_Audit ON dbo.U_EANTFMLSA2_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================

    -- Build earnings for last 12 months (for hours reporting)
    
if object_id('U_dsi_EANTFMLSA2_EarnHist') is not null
  drop table dbo.U_dsi_EANTFMLSA2_EarnHist

SELECT
    xEEID eeeid,
    xCOID ecoid,
--    pehearncode eearncode,
    SUM(ISNULL(pehCurAmt,0)) AS eamt,
    SUM(ISNULL(pehCurHrs,0)) AS ehrs

    INTO dbo.U_dsi_EANTFMLSA2_EarnHist
        from dbo.u_EANTFMLSA2_EELIST 
    JOIN vw_int_PEarHist (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND pehearncode in ('HOLW','OT','REG','DOT') 
        AND pehpaydate BETWEEN (@EndDate - 365) and @EndDate
    GROUP BY xEEID,xCOID--,pehearncode
    
---------------------------------
    -- HEADER W RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSA2_HeaderW','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_HeaderW;
    SELECT DISTINCT
    drvEEID = ''
    ,drvInitialSort = '1'
    ,drvSubSort2 = ''
        ,drvWHeader = CASE WHEN @ExportCode like 'TEST%' THEN CAST('_W-SOF_:fmlprop:ca45063z:FML Proprietary:T::' AS VARCHAR(44))
                      ELSE     CAST('_W-SOF_:fmlprop:ca45063z:FML Proprietary:P::' AS VARCHAR(44)) END   
    INTO dbo.U_EANTFMLSA2_HeaderW
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSA2_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_Header;
    SELECT DISTINCT
    drvEEID = ''
    ,drvInitialSort = '1.5'
    ,drvSubSort2 = ''
        ,drvRecordType = '100'
        ,drvGroupNo = 'W41345F'
        ,drvGroupName = 'SAFEbuilt, LLC'
        ,drvDate = CONVERT(VARCHAR, GETDATE(),112)
        ,drvTime = REPLACE(CONVERT (VARCHAR(8),GETDATE(), 108),':','')
        ,drvFullDelta = '1'
        ,drvfiller = ''
    INTO dbo.U_EANTFMLSA2_Header
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSA2_drvTbl
    --Detail Member Record - 200
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSA2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_drvTbl;
    SELECT DISTINCT
        drvInitialSort = '2'
        , drvSubSort2 = '2'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '200'
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvMaidenName = ''
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvSSN = eepSSN
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvGroupNo = 'W41345F'
        ,drvGroupEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvSalEffDate = CASE
                            WHEN ISNULL(RateDate,'') <> '' AND RateDate > '20190801' THEN RateDate--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
                            WHEN ISNULL(RateDate,'') <> '' AND RateDate <= '20190801' THEN '20190801'
                            WHEN EecDateofLastHire > '20190701' THEN EecDateofLastHire--05/06/20 BJ - Replace EecDateofOriginalHire
                        ELSE '20190801' END
        ,drvBillGroupEffDate =CASE
                            WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
                        ELSE '20190801' END
        ,drvClassEffDate =    CASE WHEN  PatTimeFullTimeChanges.Found is not null then 
                                CASE
                                WHEN PatTimeFullTimeChanges.ChangeDate > EecDateofLastHire or PatTimeFullTimeChanges.ChangeDate > '20190801' THEN PatTimeFullTimeChanges.ChangeDate    -- MML - 12/28/2020 - Added Logic for the ClassEffDate
                                WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire
                                ELSE '20190801'
                                END
                             END --06/11/20 BJ
                            --CASE
       --                     WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
       --                 ELSE '20190801' END
        ,drvBillClassEffDate = CASE WHEN  OrgLevel3Changes.Found is not null then 
                                CASE
                                WHEN OrgLevel3Changes.ChangeDate > EecDateofLastHire or OrgLevel3Changes.ChangeDate > '20190801' THEN OrgLevel3Changes.ChangeDate    -- MML - 12/28/2020 - Added Logic for the ClassEffDate
                                WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire
                                ELSE '20190801'
                                END
                             END --'' --06/11/20 BJ    
        --CASE
  --                          WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
  --                      ELSE '20190801' END
        ,drvERName = 'SAFEbuilt, LLC'
        ,drvBillGroupNo = '0000'--CASE WHEN EecDedGroupCode = 'CGA' THEN '0001' ELSE '0000' END--04/27/20 BJ REMOVED
        ,drvBillGroupName = ''
        ,drvClassNo = CASE  WHEN EecFulltimeorParttime = 'F' and (Select top 1 LocAddressState from location where locCode = eeclocation) <> 'CA' THEN '01'
                            WHEN EecFulltimeorParttime in( 'P','F') and ( Select top 1 LocAddressState from location where locCode = eeclocation) = 'CA' THEN '02'
                            WHEN EecFulltimeorParttime in( 'P') THEN '02'

                            ELSE ''
                      END
        ,drvClassDesc = ''
        ,drvSalary = RIGHT('0000000000' + CONVERT(VARCHAR,CAST((EecAnnSalary*100) as INT)),10)
        ,drvSalaryFreq = '7'
        ,drvHrsWorks = LEFT(REPLACE( (EecScheduledWorkHrs / 2), '.', ''), 3) 
                        --CASE
      --                      WHEN EecPayPeriod = 'B' THEN CAST(CAST((EecScheduledWorkHrs*26)/52 AS INT) AS VARCHAR)+ ' '
      --                      WHEN EecPayPeriod = 'M' THEN CAST(CAST((EecScheduledWorkHrs*12)/52 AS INT) AS VARCHAR)+ ' '
      --                      WHEN EecPayPeriod = 'S' THEN CAST(CAST((EecScheduledWorkHrs*24)/52 AS INT) AS VARCHAR)+ ' '
      --                  END
        ,drvEligibilityStatus = CASE
                                    WHEN EecEmplStatus = 'T' THEN '337'
                                ELSE '336' END
        ,drvDateofHire = eecDateofLastHire
        ,drvJoinGroupDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhoneHomeNumber = EepPhoneHomeNumber
        ,drvFaxNumber = ''
        ,drvAddressEmail = EepAddressEMail
        ,drvSmoker = '' --EepIsSmoker
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus IN ('M','S') THEN eepMaritalStatus ELSE '' END
        ,drvBillClass = CASE when eecPayGroup = 'SAFEB' AND  eeclocation <>  'CA'  then 'SAFE'
                             when eecPayGroup =  'CGA'  AND  eeclocation <>  'CA'  then 'CGA'
                             when eecPayGroup =  'ACQ'  AND  eeclocation <>  'CA'  then 'ACQ'
                             when eecPayGroup =  'IWCG' AND  eeclocation <>  'CA'  then 'IWCG'
                             when eecPayGroup = 'SAFEB' AND  eeclocation =   'CA'  then 'SAF0'
                             when eecPayGroup =  'CGA'  AND  eeclocation =   'CA'  then 'CGA0'
                             when eecPayGroup =  'ACQ'  AND  eeclocation =   'CA'  then 'ACQ0'
                             when eecPayGroup =  'IWCG' AND  eeclocation =   'CA'  then 'IWC0'
                        else eecpayGroup
                        END
                            --= CASE eecPayGroup                                                                    --9/13/21 new mapping!  00316110
       --                     when 'SAFEB' then 'SAFE'
       --                     when 'CGA' then 'CGA'
       --                     when 'ACQ' then 'ACQ'
       --                     when 'IWCG' then 'IWCG'
       --                 else eecpayGroup
       --                 END
                        /*CASE
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ACCTN'         THEN 'S005'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ADMIN'         THEN 'S006'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ATLNT'         THEN 'S007'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BAYVL'         THEN 'S008'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BUILDC'        THEN 'F001'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BUSDV'         THEN 'S009'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CASTL'         THEN 'S010'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CEI'           THEN 'F002'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CENTE'         THEN 'S013'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CECHI'         THEN 'S012'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CENTRAL WI'    THEN 'S067'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CGA MARKETING' THEN 'F108'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OPCOO'         THEN 'S051'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CLVND'         THEN 'S014'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CODIR'         THEN 'S016'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CODOP'         THEN 'S017'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'COAST'         THEN 'S015'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CODECO'        THEN 'F003'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'COLUM'         THEN 'S018'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'COMPAN'        THEN 'F004'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CONSTR'        THEN 'F005'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CRNST'         THEN 'S019'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CWIDE'         THEN 'S011'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DATA'          THEN 'F006'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DECAT'         THEN 'S020'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DENVE'         THEN 'S021'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'DETRT'         THEN 'S022'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'EAGLE'         THEN 'S023'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ENGINE'        THEN 'F007'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ESGIL'         THEN 'S024'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ESOP'          THEN 'F008'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'EXECUT'        THEN 'F009'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FIRES'         THEN 'S025'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FLBOM'         THEN 'F100'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MTFMS'         THEN 'F103'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FTLOFF'        THEN 'F010'
                           WHEN vw_int_EmpComp.EecOrgLvl3 in ('FTLTRA','FTLTRF')        THEN 'F011'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GADIR'         THEN 'S026'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GADOP'         THEN 'S027'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GLNVW'         THEN 'S028'
                           WHEN vw_int_EmpComp.EecOrgLvl3 in ('GOVSVS','GOVERN')        THEN 'F012'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GRBAY'         THEN 'S029'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'GULFC'         THEN 'F013'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HAMTK'         THEN 'S030'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HRPRW'         THEN 'S031'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HRTFD'         THEN 'S032'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HLNDB'         THEN 'F101'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '000HR'         THEN 'S001'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ILDIR'         THEN 'S034'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ILBOM'         THEN 'S033'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'INDOOR'        THEN 'F014'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '000IT'         THEN 'S002'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'INKF'          THEN 'F015'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'JOHNS'         THEN 'S035'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'KINGC'         THEN 'S036'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'KUTZM'         THEN 'S037'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'LANDSC'        THEN 'F016'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MADSN'         THEN 'S039'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MADHT'         THEN 'S038'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MALRD'         THEN 'S040'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MENOM'         THEN 'S041'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MERIT'         THEN 'S042'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MIBOM'         THEN 'S043'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MIDIR'         THEN 'S044'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MIDOP'         THEN 'S045'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MILTN'         THEN 'S046'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MTINC'         THEN 'F104'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MTCPP'         THEN 'F102'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MUSKN'         THEN 'S047'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NOCOR'         THEN 'S048'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NOFLO'         THEN 'F105'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NOSHR'         THEN 'S050'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'NORTH'         THEN 'S049'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OKCHB'         THEN 'F106'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ONSITE'        THEN 'F017'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ORANG'         THEN 'F107'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PARKS'         THEN 'F019'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PHNIX'         THEN 'S052'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PLANNI'        THEN 'F020'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '00PMO'         THEN 'S003'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ROSWL'         THEN 'S053'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ROYAL'         THEN 'S054'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '00SGA'         THEN 'S004'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SCBOM'         THEN 'S055'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SOFTWA'        THEN 'F021'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SRNTO'         THEN 'S067'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SOCHI'         THEN 'S056'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SOUTH'         THEN 'S057'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'STATE'         THEN 'S058'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SURVEY'        THEN 'F022'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'TRAIN'         THEN 'S059'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'TROYM'         THEN 'S060'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WAKSH'         THEN 'S061'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WESTOS'        THEN 'F023'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WIBOM'         THEN 'S062'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WIDOP'         THEN 'S063'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WINDS'         THEN 'S064'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WINST'         THEN 'S065'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WIXOM'         THEN 'S066'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WPBENG'         THEN 'F026'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WPBOFF'        THEN 'F024'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'WPBSUR'        THEN 'F025'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OPSMTN'        THEN 'F018'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDSPC'        THEN 'S068'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '07M'        THEN 'F108'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CTLWI'        THEN 'S069'
                           --04/20/20 BJ:
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'OPSMTN'        THEN 'F018'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '07M'        THEN 'F108'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'STHGA'        THEN 'S057'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDSPC'        THEN 'S068'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'CTLWI'        THEN 'S069'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'FIN05'        THEN 'FN05'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'HR05'        THEN 'HR05'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'ACMGT'        THEN 'ACMT'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'SALOP'        THEN 'SAOP'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MKTNG'        THEN 'MKTG'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDS01'        THEN 'BDS1'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'BDS03'        THEN 'BDS3'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '00COO'        THEN '00CO'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'PPS01'        THEN 'PPS1'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '000DC'        THEN '00DC'
                           WHEN vw_int_EmpComp.EecOrgLvl3 = 'MACON'        THEN 'M001'
                           --WHEN vw_int_EmpComp.EecOrgLvl3 = 'ACQ'        THEN 'ACQ1'--04/27/20 BJ REMOVED
                            --Added by MML : 12/28/2020
                           WHEN vw_int_EmpComp.EecOrgLvl3 = '000IW' THEN 'IWOH'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'CAADM' THEN 'I001'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'CBADM' THEN 'I002'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'CENTR' THEN 'I003'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'ELKGR' THEN 'I004'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'EV000' THEN 'I005'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'IWMKG' THEN 'I006'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'LAKEF' THEN 'I007'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'NOCAL' THEN 'I008'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'PERRI' THEN 'I009'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'POMON' THEN 'I010'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'SOCAL' THEN 'I011'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'UCMER' THEN 'I012'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'VBLWF' THEN 'SBVW'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'VENTR' THEN 'I013'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'WILDO' THEN 'I014'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'WINCO' THEN 'I015'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'CENTX' THEN 'S070'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'DATEC' THEN 'S071'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'SDEVL' THEN 'S072'
                            --SF21226889 4/15/2021 addedd
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'BOZEM' THEN 'S073'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'OHDOP' THEN 'S074'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'DALTEC' THEN 'S075'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'MACON' THEN 'S076'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'BOSTO' THEN 'S077'
                            --00316110 8/13/21 and 8/16/21
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'WADOP' THEN 'S078'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'NPR'   THEN 'S079'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'COPLN' THEN 'F020'
                            WHEN vw_int_EmpComp.EecOrgLvl3 = 'MNSPT' THEN 'S080'

                           ELSE '0000'
                        END
                        */
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSA2_drvTbl
    FROM dbo.U_EANTFMLSA2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (SELECT ejhEEID, ejhCOID, MAX(EjhJobEffDate) as RateDate
                    FROM vw_int_EmpHJob  WITH (NOLOCK)
                    WHERE EjhIsRateChange = 'Y'
                    GROUP BY ejhEEID, ejhCOID) EJH
        ON EJH.ejhEEID = xEEID
        AND EJH.ejhCOID = xCOID
    LEFT JOIN (Select distinct audkey1Value as eeid,AudKey2Value as coid, 'A' as Found,audDateTime as ChangeDate from U_EANTFMLSA2_Audit  WITH (NOLOCK) where audFieldName = 'EecFullTimeOrPartTime' and audOldValue is not null and audnewvalue is not null)
        as PatTimeFullTimeChanges
         ON PatTimeFullTimeChanges.eeid = xEEID
        AND PatTimeFullTimeChanges.coid = xCOID 

    LEFT JOIN (Select distinct audkey1Value as eeid,AudKey2Value as coid, 'A' as Found,audDateTime as ChangeDate from U_EANTFMLSA2_Audit  WITH (NOLOCK) where audFieldName = 'EecOrgLvl3' and audOldValue is not null and audnewvalue is not null)
        as OrgLevel3Changes
         ON OrgLevel3Changes.eeid = xEEID
        AND OrgLevel3Changes.coid = xCOID 
    Left Join dbo.Location  WITH (NOLOCK)
         ON LocCode = EecLocation
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSA2_drvTbl_LOB
    --Detail Member Line of Business Record - 210
    ---------------------------------

    --FML Segment
    IF OBJECT_ID('U_EANTFMLSA2_drvTbl_LOB','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_drvTbl_LOB;
    SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = CAST('FML' as varchar(7))
        --CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'FML' ELSE 'STD-Sal' END
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
                    --CASE
                    --        WHEN EecFulltimeorParttime = 'F' THEN '01'
     --                       WHEN EecFulltimeorParttime = 'P' THEN '03'
     --               ELSE '' END
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSA2_drvTbl_LOB
    FROM dbo.U_EANTFMLSA2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
        
   
    ;

    --STD Segment
    INSERT INTO dbo.U_EANTFMLSA2_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = 'STD-Sal'
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecFullTimeOrPartTime = 'F'--06/09/20 BJ
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
        and (Select top 1 LocAddressState from location where locCode = eeclocation) <> 'CA' --Added my MML 01/04/2020
        --AND Cast(EecScheduledWorkHrs/2 as money) >= '30'
    ;

    --04/27/20 BJ Added:
      --PFLSM/PFLSF Segment (NY MAnadated Paid Family Leave - Male or Female)
    INSERT INTO dbo.U_EANTFMLSA2_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = case when eepgender = 'M' then 'PFLSM' when eepgender = 'F' then 'PFLSF' end
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecWCState = 'NY'
        AND EecOrgLvl3 <> 'ACQ'
    LEFT JOIN dbo.EmpPers with (NOLOCK) on EepEEID = EecEEID 

    --04/27/20 BJ Added:
      --DBLSM/DBLSF Segment (NY MAnadated STD - Male or Female)
    INSERT INTO dbo.U_EANTFMLSA2_drvTbl_LOB
      SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '3'
         ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '210'
        ,drvLOB = case when eepgender = 'M' then 'DBLSM' when eepgender = 'F' then 'DBLSF' end
        ,drvBenStatus = CASE
                            WHEN EecEmplStatus = 'T' THEN '349'
                        ELSE '348' END
        ,drvEffDate = CASE WHEN EecDateofLastHire > '20190801' THEN EecDateofLastHire ELSE '20190801' END--04/28/20 BJ --20190701--05/06/20 BJ - Replace EecDateofOriginalHire
        ,drvTermDate = CASE WHEN EecEmplStatus <> 'A' THEN EecDateOfTermination END
        ,drvCovAmt = ''
        ,drvBenSelectOpt = ''
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
        AND EecWCState = 'NY'--04/27/20 BJ
        AND EecOrgLvl3 <> 'ACQ'--04/27/20 BJ
    LEFT JOIN dbo.EmpPers with (NOLOCK) on EepEEID = EecEEID ----04/27/20 BJ


    ;
    ---------------------------------
    -- DETAIL RECORD - U_EANTFMLSA2_drvTbl_UDDT
    --Detail UDDT/CDR Record - 999
    ---------------------------------
    
    IF OBJECT_ID('U_EANTFMLSA2_drvTbl_UDDT','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_drvTbl_UDDT;
    SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_PRM_CNT_EMAIL' --Supervisor Email
        ,drvValue = CAST(eepAddressEmail AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate --what date should be used as effective date
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSA2_drvTbl_UDDT
    FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EE WITH (NOLOCK)
        ON drvEEID = EE.eecEEID and drvCOID = EE.eecCOID
    LEFT JOIN dbo.vw_int_EmpComp SUP WITH (NOLOCK)
        ON EE.EecSupervisorID = SUP.EecEEID
    LEFT JOIN dbo.EmpPers WITH (NOLOCK)
        ON SUP.EecEEID = eepeeid


    UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = DR.drvEEID
        ,drvCoID = DR.drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_HR_CNT_EMAIL' --HR Contact Email
        ,drvValue = HR.eepAddressEMail --dbo.dsi_fnlib_GetSupervisorField_v2('', drvEEID, 'AddressEMail')
        --CAST('hr.forms@safeb.net' AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = DR.drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_drvTbl DR WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = DR.drvEEID
        AND EecCoID = DR.drvCoID
    JOIN (Select  eecempno , eepAddressEMail 
            FROM EmpPers WITH (NOLOCK)
            JOIN EmpComp WITH (NOLOCK) 
             ON EecEEID = EepEEID 
         ) HR ON HR.eecempno = EECUDFIELD03

        UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_FT' --Fulltime or Parttime
        ,drvValue = CAST(CASE
                        WHEN EecFullTimeorPartTime = 'F' THEN '1'
                    ELSE '0' END AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp 
        ON eecEEID = drvEEID AND EecCOID = drvCOID

            UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_WRK_ST' --Work State
        ,drvValue = CAST(eecWCState  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp 
        ON eecEEID = drvEEID AND EecCOID = drvCOID

            UNION

    --    SELECT DISTINCT
    --     drvInitialSort = '2'
    --     ,drvSubSort2 = '5'
    --    ,drvEEID = drvEEID
    --    ,drvCoID = drvCoID
    --    ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
    --    -- standard fields above and additional driver fields below
    --    ,drvRecordType = '999'
    --    ,drvType = 'UDDT_YR_HRS' --Hrs Last 12 Mo
    --    ,drvValue = CAST(CAST(ehrs as INT) AS VARCHAR)
    --    ,drvLOB = ''
    --    ,drvEffDate = drvEffDate
    --    ,drvFiller = ''
    --FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)
    --JOIN dbo.U_dsi_EANTFMLSA2_EarnHist
    --    ON eeeid = drvEEID and ecoid = drvCOID


    SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_YR_HRS' --Hrs Last 12 Mo
        ,drvValue = CAST(CAST(SUM(PehCurHrs)  as INT) AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)
    JOIN dbo.PearHist WITH (NOLOCK)
        ON Peheeid = drvEEID and pehcoid = drvCOID
        Join EarnCode WITH (NOLOCK) 
        ON ErnEarnCode = pehEarnCode and ErnInclInTotalHoursWorked = 'Y'
        WHERE PehPerControl BETWEEN FORMAT(DATEADD(year, -1, GETDATE()), 'yyyyMMdd') + '1' AND @EndPerControl
        Group by drvEEID, drvCoID, drvEffDate,pehEarnCode 
    

                UNION

        SELECT DISTINCT
         drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_ORG_CD' --Bill Group Number
        ,drvValue = drvBillGroupNo
        --CAST('0000'  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)

                UNION

        SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_EMP_TYP' --Emp Type System Code
        ,drvValue = CAST('SUPR'   AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)
    JOIN vw_int_EmpComp
        ON drvEEID = eecEEID and drvCOID = eecCOID

                UNION

        SELECT DISTINCT
        drvInitialSort = '2'
         ,drvSubSort2 = '5'
        ,drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = '999'
        ,drvType = 'UDDT_ORG_TYP' --Org Type System Code
        ,drvValue = CAST('WORK'  AS VARCHAR)
        ,drvLOB = ''
        ,drvEffDate = drvEffDate
        ,drvFiller = ''
    FROM dbo.U_EANTFMLSA2_drvTbl WITH (NOLOCK)

    ;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTFMLSA2_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EANTFMLSA2_Trailer;
    SELECT DISTINCT
         drvEEID = ''
         ,drvInitialSort = '3'
         ,drvSubSort2 = ''
        ,drvRecordType = '300'
        ,drvTotalRecords = (SELECT COUNT(*) FROM dbo.U_EANTFMLSA2_drvTbl) + (SELECT COUNT(*) FROM dbo.U_EANTFMLSA2_drvTbl_LOB) + /*(SELECT COUNT(*) FROM dbo.U_EANTFMLSA2_drvTbl_Dep) +*/ 2
        ,drvFiller = ''
    INTO dbo.U_EANTFMLSA2_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_EANTFMLSA2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_EANTFMLSA2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'EANTFMLSA2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEANTFMLSA2_Export AS
    SELECT TOP 20000000 
    CASE WHEN RecordSet = 'H01' THEN SUBSTRING(Data,1,44)
        WHEN RecordSet <> 'H01' THEN Data
        END as Data
    
    FROM dbo.U_EANTFMLSA2_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, SubSort2;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EANTFMLSA2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101011'
       ,expStartPerControl     = '202101011'
       ,expLastEndPerControl   = '202206279'
       ,expEndPerControl       = '202206279'
WHERE expFormatCode = 'EANTFMLSA2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEANTFMLSA2_Export AS
    SELECT TOP 20000000 
    CASE WHEN RecordSet = 'H01' THEN SUBSTRING(Data,1,44)
        WHEN RecordSet <> 'H01' THEN Data
        END as Data
    FROM dbo.U_EANTFMLSA2_File (NOLOCK)
    ORDER BY  InitialSort, SubSort, SubSort2;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EANTFMLSA2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EANTFMLSA2'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EANTFMLSA2'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EANTFMLSA2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EANTFMLSA2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EANTFMLSA2', 'UseFileName', 'V', 'Y'


-- End ripout