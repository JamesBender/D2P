/**********************************************************************************

EUNUMCIEXP: UNUM Critical Illness Export

FormatCode:     EUNUMCIEXP
Project:        UNUM Critical Illness Export
Client ID:      YAS1000
Date/time:      2022-10-28 17:13:47.687
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB01
Database:       ULTIPRO_WPYAAMI
Web Filename:   YAS1000_1TTK5_EEHISTORY_EUNUMCIEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUNUMCIEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EUNUMCIEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUNUMCIEXP'


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
WHERE FormatCode = 'EUNUMCIEXP'
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
WHERE ExpFormatCode = 'EUNUMCIEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUNUMCIEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUNUMCIEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUNUMCIEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUNUMCIEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUNUMCIEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUNUMCIEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUNUMCIEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUNUMCIEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUNUMCIEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUNUMCIEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUNUMCIEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNUMCIEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNUMCIEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMCIEXP];
GO
IF OBJECT_ID('U_EUNUMCIEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCIEXP_File];
GO
IF OBJECT_ID('U_EUNUMCIEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCIEXP_EEList];
GO
IF OBJECT_ID('U_EUNUMCIEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCIEXP_drvTbl];
GO
IF OBJECT_ID('U_EUNUMCIEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCIEXP_DedList];
GO
IF OBJECT_ID('U_EUNUMCIEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCIEXP_AuditFields];
GO
IF OBJECT_ID('U_EUNUMCIEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUNUMCIEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUNUMCIEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUNUMCIEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUNUMCIEXP','UNUM Critical Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EUNUMCIEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMCIEXPZ0','50','H','01','1',NULL,'eEnroll2',NULL,NULL,'"eEnroll2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMCIEXPZ0','50','H','01','2',NULL,'POLICY',NULL,NULL,'"POLICY"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMCIEXPZ0','50','H','01','3',NULL,'DIVISION',NULL,NULL,'"DIVISION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMCIEXPZ0','50','H','01','4',NULL,'MEMBER ID',NULL,NULL,'"MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMCIEXPZ0','50','H','01','5',NULL,'DOH',NULL,NULL,'"DOH"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMCIEXPZ0','50','H','01','6',NULL,'TERM DATE',NULL,NULL,'"TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMCIEXPZ0','50','H','01','7',NULL,'TERM REASON',NULL,NULL,'"TERM REASON"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMCIEXPZ0','50','H','01','8',NULL,'NEW MEMBER ID',NULL,NULL,'"NEW MEMBER ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMCIEXPZ0','50','H','01','9',NULL,'FIRST NAME',NULL,NULL,'"FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMCIEXPZ0','50','H','01','10',NULL,'MIDDLE NAME',NULL,NULL,'"MIDDLE NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMCIEXPZ0','50','H','01','11',NULL,'LAST NAME',NULL,NULL,'"LAST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMCIEXPZ0','50','H','01','12',NULL,'SUFFIX',NULL,NULL,'"SUFFIX"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMCIEXPZ0','50','H','01','13',NULL,'GENDER',NULL,NULL,'"GENDER"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMCIEXPZ0','50','H','01','14',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMCIEXPZ0','50','H','01','15',NULL,'EMAIL ADDRESS',NULL,NULL,'"EMAIL ADDRESS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMCIEXPZ0','50','H','01','16',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"SPOUSE FIRST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMCIEXPZ0','50','H','01','17',NULL,'SPOUSE MIDDLE NAME',NULL,NULL,'"SPOUSE MIDDLE NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMCIEXPZ0','50','H','01','18',NULL,'SPOUSE LAST NAME',NULL,NULL,'"SPOUSE LAST NAME"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMCIEXPZ0','50','H','01','19',NULL,'SPOUSE SUFFIX',NULL,NULL,'"SPOUSE SUFFIX"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMCIEXPZ0','50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL,'"SPOUSE GDR"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMCIEXPZ0','50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL,'"SPOUSE DOB"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMCIEXPZ0','50','H','01','22',NULL,'SPOUSE SSN',NULL,NULL,'"SPOUSE SSN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMCIEXPZ0','50','H','01','23',NULL,'SPOUSE EFF DATE',NULL,NULL,'"SPOUSE EFF DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMCIEXPZ0','50','H','01','24',NULL,'SPOUSE TERM DATE',NULL,NULL,'"SPOUSE TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMCIEXPZ0','50','H','01','25',NULL,'CLASS',NULL,NULL,'"CLASS"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMCIEXPZ0','50','H','01','26',NULL,'SIGNATURE DATE',NULL,NULL,'"SIGNATURE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMCIEXPZ0','50','H','01','27',NULL,'EFFECTIVE DATE',NULL,NULL,'"EFFECTIVE DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMCIEXPZ0','50','H','01','28',NULL,'ADD TYPE',NULL,NULL,'"ADD TYPE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMCIEXPZ0','50','H','01','29',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMCIEXPZ0','50','H','01','30',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMCIEXPZ0','50','H','01','31',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMCIEXPZ0','50','H','01','32',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMCIEXPZ0','50','H','01','33',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMCIEXPZ0','50','H','01','34',NULL,'BENEFIT ID',NULL,NULL,'"BENEFIT ID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMCIEXPZ0','50','H','01','35',NULL,'PLAN CODE',NULL,NULL,'"PLAN CODE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMCIEXPZ0','50','H','01','36',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"BENEFIT QUALIFYING DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMCIEXPZ0','50','H','01','37',NULL,'BENEFIT TERM DATE',NULL,NULL,'"BENEFIT TERM DATE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMCIEXPZ0','50','H','01','38',NULL,'BENEFIT SELECTION',NULL,NULL,'"BENEFIT SELECTION"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUNUMCIEXPZ0','50','D','10','1',NULL,'eEnroll2',NULL,NULL,'"drvEnroll2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUNUMCIEXPZ0','50','D','10','2',NULL,'POLICY',NULL,NULL,'"707908"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUNUMCIEXPZ0','50','D','10','3',NULL,'DIVISION',NULL,NULL,'"0001"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUNUMCIEXPZ0','50','D','10','4',NULL,'MEMBER ID',NULL,NULL,'"drvMemberId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUNUMCIEXPZ0','50','D','10','5',NULL,'DOH',NULL,NULL,'"drvDateOfHire"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUNUMCIEXPZ0','50','D','10','6',NULL,'TERM DATE',NULL,NULL,'"drvTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUNUMCIEXPZ0','50','D','10','7',NULL,'TERM REASON',NULL,NULL,'"drvTermReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUNUMCIEXPZ0','50','D','10','8',NULL,'NEW MEMBER ID',NULL,NULL,'"drvNewMemberId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUNUMCIEXPZ0','50','D','10','9',NULL,'FIRST NAME',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUNUMCIEXPZ0','50','D','10','10',NULL,'MIDDLE NAME',NULL,NULL,'"drvNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUNUMCIEXPZ0','50','D','10','11',NULL,'LAST NAME',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUNUMCIEXPZ0','50','D','10','12',NULL,'SUFFIX',NULL,NULL,'"drvNameSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUNUMCIEXPZ0','50','D','10','13',NULL,'GENDER',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUNUMCIEXPZ0','50','D','10','14',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUNUMCIEXPZ0','50','D','10','15',NULL,'EMAIL ADDRESS',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUNUMCIEXPZ0','50','D','10','16',NULL,'SPOUSE FIRST NAME',NULL,NULL,'"drvSpouseNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUNUMCIEXPZ0','50','D','10','17',NULL,'SPOUSE MIDDLE NAME',NULL,NULL,'"drvSpouseNameMiddle"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUNUMCIEXPZ0','50','D','10','18',NULL,'SPOUSE LAST NAME',NULL,NULL,'"drvSpouseNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUNUMCIEXPZ0','50','D','10','19',NULL,'SPOUSE SUFFIX',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUNUMCIEXPZ0','50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL,'"drvSpouseGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUNUMCIEXPZ0','50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL,'"drvSpouseDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUNUMCIEXPZ0','50','D','10','22',NULL,'SPOUSE SSN',NULL,NULL,'"drvSpouseSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUNUMCIEXPZ0','50','D','10','23',NULL,'SPOUSE EFF DATE',NULL,NULL,'"drvSpouseEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUNUMCIEXPZ0','50','D','10','24',NULL,'SPOUSE TERM DATE',NULL,NULL,'"drvSpouseTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUNUMCIEXPZ0','50','D','10','25',NULL,'CLASS',NULL,NULL,'"0010"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUNUMCIEXPZ0','50','D','10','26',NULL,'SIGNATURE DATE',NULL,NULL,'"drvSignatureDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUNUMCIEXPZ0','50','D','10','27',NULL,'EFFECTIVE DATE',NULL,NULL,'"drvEffectiveDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUNUMCIEXPZ0','50','D','10','28',NULL,'ADD TYPE',NULL,NULL,'"drvAddType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUNUMCIEXPZ0','50','D','10','29',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUNUMCIEXPZ0','50','D','10','30',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUNUMCIEXPZ0','50','D','10','31',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvQualifingDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUNUMCIEXPZ0','50','D','10','32',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUNUMCIEXPZ0','50','D','10','33',NULL,'BENEFIT SELECTION',NULL,NULL,'"Y"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUNUMCIEXPZ0','50','D','10','34',NULL,'BENEFIT ID',NULL,NULL,'"drvBenefitId2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUNUMCIEXPZ0','50','D','10','35',NULL,'PLAN CODE',NULL,NULL,'"drvPlanCode2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUNUMCIEXPZ0','50','D','10','36',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL,'"drvQualifingDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUNUMCIEXPZ0','50','D','10','37',NULL,'BENEFIT TERM DATE',NULL,NULL,'"drvBenefitTermDate2"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUNUMCIEXPZ0','50','D','10','38',NULL,'BENEFIT SELECTION',NULL,NULL,'"Y"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUNUMCIEXP_20221028.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202210289','EMPEXPORT','OEACTIVE',NULL,'EUNUMCIEXP',NULL,NULL,NULL,'202210289','Mar 31 2022  9:57AM','Mar 31 2022  9:57AM','202208011',NULL,'','','202228011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202210289','EMPEXPORT','OEPASSIVE',NULL,'EUNUMCIEXP',NULL,NULL,NULL,'202210289','Mar 31 2022  9:57AM','Mar 31 2022  9:57AM','202208011',NULL,'','','202228011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UNUM Critical Illness Export','202210289','EMPEXPORT','ONDEM_XOE',NULL,'EUNUMCIEXP',NULL,NULL,NULL,'202210289','Mar 31 2022  9:57AM','Mar 31 2022  9:57AM','202208011',NULL,'','','202228011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',XNTA4,XNV4Y,XNRPH',NULL,NULL,NULL,'UNUM Critical Illness Ex-Sched','202210289','EMPEXPORT','SCH_EUNUMC',NULL,'EUNUMCIEXP',NULL,NULL,NULL,'202210289','Mar 31 2022  9:57AM','Mar 31 2022  9:57AM','202208011',NULL,'','','202228011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','XNTA4,XNV4Y,XNRPH',NULL,NULL,NULL,'UNUM Critical Illness Ex-Test','202210289','EMPEXPORT','TEST_XOE','Apr 27 2022 10:11AM','EUNUMCIEXP',NULL,NULL,NULL,'202210289','Apr 27 2022 12:00AM','Dec 30 1899 12:00AM','202208011','81','','','202228011',dbo.fn_GetTimedKey(),NULL,'us3cBeYAS1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCIEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCIEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCIEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCIEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCIEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNUMCIEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMCIEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNUMCIEXP','D10','dbo.U_EUNUMCIEXP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUNUMCIEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EUNUMCIEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUNUMCIEXP] (
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
-- Create table U_EUNUMCIEXP_Audit
-----------

IF OBJECT_ID('U_EUNUMCIEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EUNUMCIEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audFullTimePartTimeChange] varchar(1) NOT NULL
);

-----------
-- Create table U_EUNUMCIEXP_AuditFields
-----------

IF OBJECT_ID('U_EUNUMCIEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUNUMCIEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EUNUMCIEXP_DedList
-----------

IF OBJECT_ID('U_EUNUMCIEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUNUMCIEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUNUMCIEXP_drvTbl
-----------

IF OBJECT_ID('U_EUNUMCIEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUNUMCIEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvEnroll2] int NOT NULL,
    [drvMemberId] char(11) NULL,
    [drvDateOfHire] datetime NULL,
    [drvTermDate] datetime NULL,
    [drvTermReason] varchar(2) NULL,
    [drvNewMemberId] char(11) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvSpouseNameFirst] varchar(100) NULL,
    [drvSpouseNameMiddle] varchar(50) NULL,
    [drvSpouseNameLast] varchar(100) NULL,
    [drvSpouseGender] char(1) NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvSpouseSSN] char(11) NULL,
    [drvSpouseEffectiveDate] datetime NULL,
    [drvSpouseTermDate] datetime NULL,
    [drvSignatureDate] datetime NULL,
    [drvEffectiveDate] datetime NULL,
    [drvAddType] varchar(1) NULL,
    [drvBenefitId] varchar(2) NULL,
    [drvPlanCode] varchar(6) NULL,
    [drvQualifingDate] datetime NULL,
    [drvBenefitTermDate] datetime NULL,
    [drvBenefitId2] varchar(2) NULL,
    [drvPlanCode2] varchar(6) NULL,
    [drvQualifingDate2] datetime NULL,
    [drvBenefitTermDate2] datetime NULL
);

-----------
-- Create table U_EUNUMCIEXP_EEList
-----------

IF OBJECT_ID('U_EUNUMCIEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNUMCIEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUNUMCIEXP_File
-----------

IF OBJECT_ID('U_EUNUMCIEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUNUMCIEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNUMCIEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Yaskawa America

Created By: James Bender
Business Analyst: Curlin Beck
Create Date: 03/31/2022
Service Request Number: TekP-2021-10-18-10

Purpose: UNUM Critical Illness Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters      10/14/2022     TekP-2021-10-18-10    Added a consolidated BDM query and adjusted case statements 

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUNUMCIEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUNUMCIEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUNUMCIEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUNUMCIEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUNUMCIEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCIEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCIEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCIEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCIEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUNUMCIEXP', 'SCH_EUNUMC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUNUMCIEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUNUMCIEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUNUMCIEXP';

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
    DELETE FROM dbo.U_EUNUMCIEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUNUMCIEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    --SET @DedList = 'MED,DEN,VIS';
    SET @DedList = 'MMCI1,MMCI2,MMCI3,MMCS1,MMCS2,MMCS3';



    IF OBJECT_ID('U_EUNUMCIEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCIEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUNUMCIEXP_DedList
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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUNUMCIEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCIEXP_AuditFields;
    CREATE TABLE dbo.U_EUNUMCIEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
   
   -- Employee Deduction/Benefit Information
   -- INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpDed','EedDedCode');
    --INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpDed','EedBenStopDate');

    -- Employee Information
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_EUNUMCIEXP_AuditFields VALUES ('Contacts','ConAddressZipCode');
 
    
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUNUMCIEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCIEXP_Audit;
    
       SELECT  audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
        ,audFullTimePartTimeChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecFullTimeOrPartTime' AND ISNULL(audNewValue, '') = 'P' AND ISNULL(audOldValue, '') = 'F' THEN 'Y' ELSE 'N' END
    INTO dbo.U_EUNUMCIEXP_Audit
    FROM dbo.U_EUNUMCIEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EUNUMCIEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
     -- AND ISNULL(audNewValue,'') <> ''  -- Had to change because BZ96EL0040K0 was showing termed in audit and was active
      AND ((audFieldName = 'EedBenStatus' and audKey3Value IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3')) or (audFieldName <> 'EedBenStatus' and ISNULL(audNewValue,'') <> ''));

     -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EUNUMCIEXP_Audit ON dbo.U_EUNUMCIEXP_Audit (audEEID,audCOID);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_EUNUMCIEXP_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EUNUMCIEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUNUMCIEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUNUMCIEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUNUMCIEXP_drvTbl;
   
 SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''-- row_number() over (partition by drveeid, drvdateofhire order by drveeid ,drvtermdate desc)
        -- standard fields above and additional driver fields below
        ,drvEnroll2 = 0
        ,drvMemberId = EepSSN
        ,drvDateOfHire = EecDateOfLastHire
        ,drvTermDate =    CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                               WHEN MMCI1thru3 IS NOT NULL  AND EecEmplStatus <> 'T' AND MMCI1thru3_StopDate IS NOT NULL THEN MMCI1thru3_StopDate 
                               WHEn MMCS1thru3 IS NOT NULL AND EecEmplStatus <> 'T' AND MMCS1thru3_StopDate IS NOT NULL THEN MMCS1thru3_StopDate 
                        END
        ,drvTermReason =    CASE WHEN EecEmplStatus = 'T' AND  EecTermReason = '203' THEN 'DT'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RT'
                            WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('203','202') THEN 'TE'
                            WHEN EecEmplStatus <> 'T' AND ALLCODES = 'ALL'  AND BENEFIT_STOPDATE IS NOT NULL THEN 'DC'
                            END
        ,drvNewMemberId = CASE WHEN ISNULL(EepOldSSN, '') <> '' THEN EepSSN END
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvNameLast = EepNameLast
        ,drvNameSuffix = EepNameSuffix
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvEmailAddress = EepAddressEMail
        ,drvSpouseNameFirst = CASE WHEN MMCS1thru3 IS NOT NULL THEN (select Top 1 ConNameFirst from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN ConNameFirst END
        ,drvSpouseNameMiddle = CASE WHEN MMCS1thru3 IS NOT NULL THEN (select Top 1 ConNameMiddle from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END 
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN ConNameMiddle END
        ,drvSpouseNameLast = CASE WHEN MMCS1thru3 IS NOT NULL THEN  (select Top 1 ConNameLast from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID)  END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN ConNameLast END
        ,drvSpouseGender = CASE WHEN MMCS1thru3 IS NOT NULL THEN  (select Top 1 ConGender from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID)  END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN ConGender END
        ,drvSpouseDateOfBirth = CASE WHEN MMCS1thru3 IS NOT NULL THEN (select Top 1 ConDateOfBirth from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN ConDateOfBirth END
        ,drvSpouseSSN = CASE WHEN MMCS1thru3 IS NOT NULL THEN (select Top 1 ConSsn from Contacts where ConRelationship In ('SPS','DP') and ConEEID = xEEID) END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN ConSSN END
        ,drvSpouseEffectiveDate = CASE WHEN MMCS1thru3 IS NOT NULL THEN MMCS1thru3_StartDate END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN Sp_Bdm.BdmSpouseStartDate END
        ,drvSpouseTermDate = CASE WHEN MMCS1thru3 IS NOT NULL THEN MMCS1thru3_StopDate END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN Sp_Bdm.BdmSpouseEndDate END
        ,drvSignatureDate = Signature_Date  
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN MaxBenStartDate END

         ,drvEffectiveDate = CASE WHEN audRehire = 'Y' THEN EecDateOfLastHire
                                WHEN audTerm = 'Y' THEN EecDateOfTermination
                                WHEN audSalaryChange = 'Y' and EecDateofOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire -- MW added and EecDateofOriginalHire <> EecDateOfLastHire
                                ELSE BENEFIT_STARTDATE
                            END
        ,drvAddType = CASE WHEN EecFullTimeOrPartTime = 'F' AND EjhFullTimeOrPartTime = 'P' THEN 'O' END
        ,drvBenefitId = CASE WHEN MMCI1thru3 IS NOT NULL THEN 'K1' END
        ,drvPlanCode =  CASE WHEN MMCI1 is not null THEN 'FLAT01'
                             WHEN MMCI2 is not null THEN 'FLAT02'
                             WHEN MMCI3 is not null THEN 'FLAT03'
                        END
        ,drvQualifingDate = CASE WHEN MMCI1thru3 IS NOT NULL  AND MMCI1thru3_ChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','103','105','107','109','112','113','201','202','203','204','300','302','303') THEN MMCI1thru3_BenefitDate END
        ,drvBenefitTermDate =  CASE WHEN MMCI1thru3 IS NOT NULL  AND EecEmplStatus <> 'T' THEN MMCI1thru3_StopDate END
        ,drvBenefitId2 = CASE WHEN MMCS1thru3 IS NOT NULL THEN 'K2' END
                    --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN 'K2' END
        ,drvPlanCode2 =  CASE WHEN MMCS1 IS NOT NULL THEN 'FLAT06'
                              WHEN MMCS2 IS NOT NULL THEN 'FLAT07'
                              WHEN MMCS3 IS NOT NULL THEN 'FLAT08'
                         END
                        --CASE WHEN Sp_Bdm.BdmSpouseInd IS NOT NULL THEN Sp_Bdm.BdmPlanCode END
        ,drvQualifingDate2 = CASE WHEN MMCS1thru3 IS NOT NULL AND MMCS1thru3_ChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','103','105','107','109','112','113','201','202','203','204','300','302','303') THEN MMCS1thru3_BenefitDate END
        ,drvBenefitTermDate2 =  CASE WHEN MMCS1thru3 IS NOT NULL AND MMCS1thru3_StopDate IS NOT NULL THEN MMCS1thru3_StopDate END
                                
    INTO dbo.U_EUNUMCIEXP_drvTbl
    FROM dbo.U_EUNUMCIEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
  --  JOIN dbo.U_dsi_BDM_EUNUMCIEXP WITH (NOLOCK) 
  --      ON BdmEEID = xEEID 
  --      AND BdmCoID = xCoID
  --      AND BdmRecType = 'EMP' 
        --And BdmDedCode IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3')
        --AND BdmBenStartDate >= '1/1/2022'
    --LEFT JOIN (
    --            SELECT BdmEEID, BdmCOID
    --                ,MAX(CASE WHEN BdmDedCode IN ('MMCS1','MMCS2','MMCS3') THEN 'Spouse' END) AS BdmSpouseInd
    --                ,MAX(CASE WHEN BdmDedCode IN ('MMCS1','MMCS2','MMCS3') THEN BdmBenStartDate END) AS BdmSpouseStartDate
    --                ,MAX(CASE WHEN BdmDedCode IN ('MMCS1','MMCS2','MMCS3') THEN BdmBenStopDate END) AS BdmSpouseEndDate
    --                ,MAX(
    --                        CASE WHEN BdmDedCode IN ('MMCSI1') THEN 'FLAT06' 
    --                        WHEN BdmDedCode = 'MMCS2' THEN 'FLAT07' 
    --                        WHEN BdmDedCode = 'MMCS3' THEN 'FLAT08'
    --                        END) AS BdmPlanCode
    --            FROM dbo.U_dsi_BDM_EUNUMCIEXP WITH (NOLOCK) 
    --            GROUP BY BdmEEID, BdmCOID) AS Sp_Bdm
    --    ON xEEID = Sp_Bdm.BdmEEID
    --    AND xCOID = Sp_Bdm.BdmCOID
    --LEFT JOIN dbo.Contacts WITH (NOLOCK)
    --    ON xEEID = ConEEID
    --    AND BdmDepRecId = ConSystemId
    --    AND ConRelationship IN ('SPS','DP')
    --LEFT JOIN (
    --            SELECT BdmEEID AS MaxEEID, BdmCOID AS MaxCOID
    --                ,MAX(BdmBenStartDate) as MaxBenStartDate
    --            FROM dbo.U_dsi_BDM_EUNUMCIEXP WITH (NOLOCK)
    --            GROUP BY BdmEEID, BdmCOID) AS MaxBDM
    --    ON MaxEEID = xEEID
    --    AND MaxCOID = xCOID
  JOIN (Select Distinct  EedEEID AS MaxBdmEEID, Eedcoid AS MaxBdmCOID   -- MW Added to get Max Case and stop duplicating rows on output
                                   
            ,MMCI1 = MAX((CASE WHEN EedDedCode  IN ('MMCI1') then EedDedCode  END))
            ,MMCI1_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCI1') then  EedEEEligDate END))
            ,MMCI1_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCI1') then  EedBenStartDate END))
            ,MMCI1_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCI1') then  EedBenStopDate END))
            ,MMCI1_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCI1') then  EedBenAmt  END))
            ,MMCI1_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCI1') then  EdhChangeReason END))

            
            ,MMCI2 = MAX((CASE WHEN EedDedCode  IN ('MMCI2') then EedDedCode  END))
            ,MMCI2_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCI2') then  EedEEEligDate END))
            ,MMCI2_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCI2') then  EedBenStartDate END))
            ,MMCI2_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCI2') then  EedBenStopDate END))
            ,MMCI2_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCI2') then   EedBenAmt END))
            ,MMCI2_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCI2') then  EdhChangeReason END))

            
            ,MMCI3 = MAX((CASE WHEN EedDedCode  IN ('MMCI3') then EedDedCode  END))
            ,MMCI3_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCI3') then  EedEEEligDate END))
            ,MMCI3_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCI3') then  EedBenStartDate END))
            ,MMCI3_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCI3') then  EedBenStopDate END))
            ,MMCI3_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCI3') then   EedBenAmt  END))
            ,MMCI3_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCI3') then  EdhChangeReason END))

            ,MMCI1thru3 = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3') then EedDedCode  END))
            ,MMCI1thru3_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3') then  EedEEEligDate END))
            ,MMCI1thru3_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3') then  EedBenStartDate END))
            ,MMCI1thru3_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3') then  EedBenStopDate END))
            ,MMCI1thru3_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3') then  EedBenAmt  END))
            ,MMCI1thru3_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3') then  EdhChangeReason END))

            ,MMCS1 = MAX((CASE WHEN EedDedCode  IN ('MMCS1') then EedDedCode  END))
            ,MMCS1_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCS1') then  EedEEEligDate END))
            ,MMCS1_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCS1') then  EedBenStartDate END))
            ,MMCS1_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCS1') then  EedBenStopDate END))
            ,MMCS1_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCS1') then  EedBenAmt END))
            ,MMCS1_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCS1') then  EdhChangeReason END))
            
            ,MMCS2 = MAX((CASE WHEN EedDedCode  IN ('MMCS2') then EedDedCode  END))
            ,MMCS2_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCS2') then  EedEEEligDate END))
            ,MMCS2_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCS2') then  EedBenStartDate END))
            ,MMCS2_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCS2') then  EedBenStopDate END))
            ,MMCS2_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCS2') then   EedBenAmt  END))
            ,MMCS2_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCS2') then  EdhChangeReason END))

            ,BENEFIT_STARTDATE = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3') then  EedBenStartDate END))
            ,BENEFIT_STOPDATE = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3') then  EedBenStopDate END))
            ,MMCS3 = MAX((CASE WHEN EedDedCode  IN ('MMCS3') then EedDedCode  END))
            ,MMCS3_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCS3') then  EedEEEligDate END))
            ,MMCS3_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCS3') then  EedBenStartDate END))
            ,MMCS3_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCS3') then  EedBenStopDate END))
            ,MMCS3_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCS3') then   EedBenAmt END))
            ,MMCS3_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCS3') then  EdhChangeReason END))
            ,MMCS3_BenOption = MAX((CASE WHEN EedDedCode  IN ('MMCS3') then  bdmBenOption END))

            ,Signature_Date = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3') then  EedBenStartDate END)) 
            ,ALLCODES = MAX((CASE WHEN EedDedCode  IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3')  THEN 'ALL'  END))
            ,MMCS1thru3 = MAX((CASE WHEN EedDedCode  IN ('MMCS1','MMCS2','MMCS3') then EedDedCode  END))
            ,MMCS1thru3_BenefitDate = MAX((CASE WHEN EedDedCode  IN ('MMCS1','MMCS2','MMCS3') then  EedEEEligDate END))
            ,MMCS1thru3_StartDate = MAX((CASE WHEN EedDedCode  IN ('MMCS1','MMCS2','MMCS3') then  EedBenStartDate END))
            ,MMCS1thru3_StopDate = MAX((CASE WHEN EedDedCode  IN ('MMCS1','MMCS2','MMCS3') then  EedBenStopDate END))
            ,MMCS1thru3_EEAmt = MAX((CASE WHEN EedDedCode  IN ('MMCS1','MMCS2','MMCS3') then  EedBenAmt  END))
            ,MMCS1thru3_ChangeReason = MAX((CASE WHEN EedDedCode  IN ('MMCS1','MMCS2','MMCS3') then  EdhChangeReason END))
            
                      
            FROM dbo.u_dsi_bdm_EmpDeductions WITH (NOLOCK)
            Join U_dsi_BDM_EUNUMCIEXP  WITH (NOLOCK)
                ON BdmDedCode = EedDedCode 
                AND bdmeeid = EedEEID
            JOIN dbo.EmpHDed WITH (NOLOCK)
                ON edhEEID = EedEEID
                AND EdhDedCode= EedDedCode
            where  EedDedCode IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3')
                            AND EedFormatCode = 'EUNUMCIEXP'
                          --  and bdmeeid = 'BZ96AE00D0K0'
                        
            GROUP BY EedEEID,Eedcoid
                     
    ) as BdmConsolidated 
        ON MaxBdmEEID = xEEID 
        AND MaxBdmCOID = xCoID
    LEFT JOIN dbo.U_EUNUMCIEXP_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID

    LEFT JOIN (
            SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhFullTimeOrPartTime
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhJObCode, EjhFLSACategory, EjhJobEffDate, EjhWeeklyHours, EjhFullTimeOrPartTime, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EecJobCode 
    --LEFT JOIN (
    --        SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
    --        FROM (
    --                SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
    --                FROM dbo.EmpHDed a WITH (NOLOCK)
    --                JOIN dbo.BenChRsn WITH (NOLOCK)
    --                    ON EdhChangeReason = BchCode
    --                WHERE EdhDedCode IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3') 
    --                    AND edhChangeReason IN ('LEVNT2','LEVNT3','LEVNT4','LEVNT5','103','105','107','109','112','113','201','202','203','204','300','302','303')
    --            ) AS X
    --        WHERE RN = 1) AS Edh
    --    ON EdhEEID = xEEID
    --    AND EdhCoID = xCOID  
    JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedDedCode  IN ('MMCI1','MMCI2','MMCI3','MMCS1','MMCS2','MMCS3')
    WHERE (EecEmplStatus <> 'T' OR (audTerm = 'Y' AND AudDateTime IS NOT NULL AND AudDateTime BETWEEN @StartDate AND @EndDate))
  
    ;


    UPDATE dbo.U_EUNUMCIEXP_drvTbl
        SET drvEnroll2 = (SELECT COUNT(*) FROM dbo.U_EUNUMCIEXP_drvTbl)


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
ALTER VIEW dbo.dsi_vwEUNUMCIEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUNUMCIEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EUNUMCIEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202208011'
       ,expStartPerControl     = '202228011'
       ,expLastEndPerControl   = '202210289'
       ,expEndPerControl       = '202210289'
WHERE expFormatCode = 'EUNUMCIEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUNUMCIEXP_Export AS      SELECT TOP 200000000 Data FROM dbo.U_EUNUMCIEXP_File WITH (NOLOCK)     ORDER BY RIGHT(RecordSet,2), InitialSort  

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUNUMCIEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUNUMCIEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUNUMCIEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMCIEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUNUMCIEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUNUMCIEXP', 'UseFileName', 'V', 'Y'


-- End ripout