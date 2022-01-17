/**********************************************************************************


>>>>>> NOTE: this ripout is cloned from EWWCOBRA


EWWCOBRTST: WageWorks COBRA

FormatCode:     EWWCOBRTST
Project:        WageWorks COBRA
Client ID:      MAJ1001
Date/time:      2022-01-13 20:12:14.180
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW1WUP5DB01
Database:       ULTIPRO_WPMJS
Web Filename:   MAJ1001_JO8UK_EEHISTORY_EWWCOBRTST_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EWWCOBRTST_SavePath') IS NOT NULL DROP TABLE dbo.U_EWWCOBRTST_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EWWCOBRTST'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EWWCOBRTST')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EWWCOBRTST'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EWWCOBRTST'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EWWCOBRTST'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EWWCOBRTST'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EWWCOBRTST'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EWWCOBRTST'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EWWCOBRTST'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EWWCOBRTST'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EWWCOBRTST'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEWWCOBRTST_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEWWCOBRTST_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EWWCOBRTST') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EWWCOBRTST];
GO
IF OBJECT_ID('U_EWWCOBRTST_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_trlTbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_Totals') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_Totals];
GO
IF OBJECT_ID('U_EWWCOBRTST_partTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_partTbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_Header') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_Header];
GO
IF OBJECT_ID('U_EWWCOBRTST_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_hdrTbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_File') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_File];
GO
IF OBJECT_ID('U_EWWCOBRTST_EEList') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_EEList];
GO
IF OBJECT_ID('U_EWWCOBRTST_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_drvTbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_drv40Tbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_drv40Tbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_drv30Tbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_drv30Tbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_drv10Tbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_drv10Tbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_DepTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_DepTbl];
GO
IF OBJECT_ID('U_EWWCOBRTST_DedList') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_DedList];
GO
IF OBJECT_ID('U_EWWCOBRTST_covTbl') IS NOT NULL DROP TABLE [dbo].[U_EWWCOBRTST_covTbl];
GO
IF OBJECT_ID('U_dsi_BDM_EWWCOBRTST') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EWWCOBRTST];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EWWCOBRTST','WageWorks COBRA TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','600','S','N','E3YQSE000020','N','Dec 11 2015  2:10PM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3YQSE000020','1','H','01','1',NULL,'',NULL,NULL,'"H"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3YQSE000020','12','H','01','2',NULL,'',NULL,NULL,'"drvEmployerID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3YQSE000020','3','H','01','14',NULL,'',NULL,NULL,'"drvCounter"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3YQSE000020','8','H','01','17',NULL,'',NULL,NULL,'"getdate()"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3YQSE000020','3','H','01','25',NULL,'',NULL,NULL,'"4.2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3YQSE000020','1','H','01','28',NULL,'',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3YQSE000020','25','H','01','29',NULL,'',NULL,NULL,'"UltiPro"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3YQSE000020','543','H','01','54',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3YQSE000020','1','H','01','597',NULL,'',NULL,NULL,'"X"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3YQSE000020','3','H','01','598',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3YQSE000020','1','D','02','1',NULL,'',NULL,NULL,'"B"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3YQSE000020','11','D','02','2',NULL,'',NULL,NULL,'"drvbenssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3YQSE000020','2','D','02','13',NULL,'',NULL,NULL,'"drvServiceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3YQSE000020','12','D','02','15',NULL,'',NULL,NULL,'"drvEmployerID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3YQSE000020','11','D','02','27',NULL,'',NULL,NULL,'"drvssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3YQSE000020','20','D','02','38',NULL,'',NULL,NULL,'"drvEmpNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3YQSE000020','11','D','02','58',NULL,'',NULL,NULL,'"drvbenssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3YQSE000020','25','D','02','69',NULL,'',NULL,NULL,'"drvnamefirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3YQSE000020','25','D','02','94',NULL,'',NULL,NULL,'"drvnamelast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3YQSE000020','1','D','02','119',NULL,'',NULL,NULL,'"drvnamemi"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E3YQSE000020','40','D','02','120',NULL,'',NULL,NULL,'"drvaddr1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E3YQSE000020','40','D','02','160',NULL,'',NULL,NULL,'"drvaddr2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E3YQSE000020','25','D','02','200',NULL,'',NULL,NULL,'"drvcity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E3YQSE000020','2','D','02','225',NULL,'',NULL,NULL,'"drvstate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E3YQSE000020','15','D','02','227',NULL,'',NULL,NULL,'"drvzipcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E3YQSE000020','3','D','02','242',NULL,'',NULL,NULL,'"USA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E3YQSE000020','20','D','02','245',NULL,'',NULL,NULL,'"drvphone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E3YQSE000020','20','D','02','265',NULL,'',NULL,NULL,'"drvbusphone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E3YQSE000020','80','D','02','285',NULL,'',NULL,NULL,'"drvemail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E3YQSE000020','8','D','02','365',NULL,'',NULL,NULL,'"drvdateofbirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E3YQSE000020','1','D','02','373',NULL,'',NULL,NULL,'"drvgender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E3YQSE000020','1','D','02','374',NULL,'',NULL,NULL,'"drvmaritalstatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E3YQSE000020','1','D','02','375',NULL,'',NULL,NULL,'"drvrelationship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E3YQSE000020','1','D','02','376',NULL,'',NULL,NULL,'"drvstudent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E3YQSE000020','1','D','02','377',NULL,'',NULL,NULL,'"N"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','E3YQSE000020','3','D','02','378',NULL,'',NULL,NULL,'"drvbenetype"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','E3YQSE000020','8','D','02','381',NULL,'',NULL,NULL,'"drvstopdate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','E3YQSE000020','8','D','02','389',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','E3YQSE000020','3','D','02','397',NULL,'',NULL,NULL,'"drvqereason"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','E3YQSE000020','8','D','02','400',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','E3YQSE000020','8','D','02','408',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','E3YQSE000020','8','D','02','416',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','E3YQSE000020','12','D','02','424',NULL,'',NULL,NULL,'"drvGroupedBy1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','E3YQSE000020','12','D','02','436',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','E3YQSE000020','12','D','02','448',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','E3YQSE000020','8','D','02','460',NULL,'',NULL,NULL,'"drvHireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','E3YQSE000020','12','D','02','468',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','E3YQSE000020','3','D','02','480',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','E3YQSE000020','1','D','02','483',NULL,'',NULL,NULL,'"drvStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','E3YQSE000020','8','D','02','484',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','E3YQSE000020','8','D','02','492',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','E3YQSE000020','1','D','02','500',NULL,'',NULL,NULL,'"drvSubsidyTransFlg"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','E3YQSE000020','8','D','02','501',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','E3YQSE000020','10','D','02','509',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','E3YQSE000020','10','D','02','519',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','E3YQSE000020','10','D','02','529',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','E3YQSE000020','10','D','02','539',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','E3YQSE000020','10','D','02','549',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','E3YQSE000020','1','D','02','559',NULL,'',NULL,NULL,'"drvReasonID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','E3YQSE000020','1','D','02','560',NULL,'',NULL,NULL,'"drvInitRights"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','E3YQSE000020','36','D','02','561',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','E3YQSE000020','1','D','02','597',NULL,'',NULL,NULL,'"X"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','E3YQSE000020','2','D','02','598',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3YQSE000020','1','D','03','1',NULL,'',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3YQSE000020','11','D','03','2',NULL,'',NULL,NULL,'"drvbenssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3YQSE000020','11','D','03','13',NULL,'',NULL,NULL,'"drvssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3YQSE000020','11','D','03','24',NULL,'',NULL,NULL,'"drvdepssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3YQSE000020','2','D','03','35',NULL,'',NULL,NULL,'"drvdepseq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3YQSE000020','25','D','03','37',NULL,'',NULL,NULL,'"drvnamefirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3YQSE000020','25','D','03','62',NULL,'',NULL,NULL,'"drvnamelast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3YQSE000020','1','D','03','87',NULL,'',NULL,NULL,'"drvnamemi"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3YQSE000020','40','D','03','88',NULL,'',NULL,NULL,'"drvdaddr1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3YQSE000020','40','D','03','128',NULL,'',NULL,NULL,'"drvdaddr2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E3YQSE000020','25','D','03','168',NULL,'',NULL,NULL,'"drvdcity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E3YQSE000020','2','D','03','193',NULL,'',NULL,NULL,'"drvdstate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E3YQSE000020','15','D','03','195',NULL,'',NULL,NULL,'"drvdzip"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E3YQSE000020','3','D','03','210',NULL,'',NULL,NULL,'"USA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E3YQSE000020','20','D','03','213',NULL,'',NULL,NULL,'"drvdhomephone"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E3YQSE000020','20','D','03','233',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E3YQSE000020','80','D','03','253',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E3YQSE000020','8','D','03','333',NULL,'',NULL,NULL,'"drvdateofbirth"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E3YQSE000020','1','D','03','341',NULL,'',NULL,NULL,'"drvgender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E3YQSE000020','1','D','03','342',NULL,'',NULL,NULL,'"drvrelationship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E3YQSE000020','1','D','03','343',NULL,'',NULL,NULL,'"drvstudent"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E3YQSE000020','1','D','03','344',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E3YQSE000020','252','D','03','345',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E3YQSE000020','1','D','03','597',NULL,'',NULL,NULL,'"X"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E3YQSE000020','2','D','03','598',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3YQSE000020','1','D','04','1',NULL,'',NULL,NULL,'"C"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3YQSE000020','11','D','04','2',NULL,'',NULL,NULL,'"drvbenssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3YQSE000020','11','D','04','13',NULL,'',NULL,NULL,'"drvssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3YQSE000020','12','D','04','24',NULL,'',NULL,NULL,'"drvdedcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3YQSE000020','2','D','04','36',NULL,'',NULL,NULL,'"drvplanseq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3YQSE000020','3','D','04','38',NULL,'',NULL,NULL,'"drvcovclass"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3YQSE000020','8','D','04','41',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3YQSE000020','8','D','04','49',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3YQSE000020','7','D','04','57',NULL,'',NULL,NULL,'"drvbenrate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3YQSE000020','7','D','04','64',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E3YQSE000020','12','D','04','71',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E3YQSE000020','8','D','04','83',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E3YQSE000020','12','D','04','91',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E3YQSE000020','494','D','04','103',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E3YQSE000020','1','D','04','597',NULL,'',NULL,NULL,'"X"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E3YQSE000020','2','D','04','598',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3YQSE000020','1','D','05','1',NULL,'',NULL,NULL,'"P"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3YQSE000020','11','D','05','2',NULL,'',NULL,NULL,'"drvbenssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3YQSE000020','11','D','05','13',NULL,'',NULL,NULL,'"drvssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3YQSE000020','11','D','05','24',NULL,'',NULL,NULL,'"drvmemssn"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3YQSE000020','2','D','05','35',NULL,'',NULL,NULL,'"drvdepseq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3YQSE000020','12','D','05','37',NULL,'',NULL,NULL,'"drvdedcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3YQSE000020','2','D','05','49',NULL,'',NULL,NULL,'"drvplanseq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3YQSE000020','8','D','05','51',NULL,'',NULL,NULL,'"drvWaitStartDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3YQSE000020','8','D','05','59',NULL,'',NULL,NULL,'"drvCovStartDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3YQSE000020','8','D','05','67',NULL,'',NULL,NULL,'"drvCovEndDt"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E3YQSE000020','522','D','05','75',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E3YQSE000020','1','D','05','597',NULL,'',NULL,NULL,'"X"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E3YQSE000020','2','D','05','598',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E3YQSE000020','1','T','06','1',NULL,'',NULL,NULL,'"T"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E3YQSE000020','12','T','06','2',NULL,'',NULL,NULL,'"drvEmployerID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E3YQSE000020','12','T','06','14',NULL,'',NULL,NULL,'"drvtotrec"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E3YQSE000020','12','T','06','26',NULL,'',NULL,NULL,'"drvtotben"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E3YQSE000020','12','T','06','38',NULL,'',NULL,NULL,'"drvtotdep"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E3YQSE000020','12','T','06','50',NULL,'',NULL,NULL,'"drvtotcov"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E3YQSE000020','12','T','06','62',NULL,'',NULL,NULL,'"drvtotpart"','(''UN00''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E3YQSE000020','523','T','06','74',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E3YQSE000020','1','T','06','597',NULL,'',NULL,NULL,'"X"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E3YQSE000020','2','T','06','598',NULL,'',NULL,NULL,'"spaces"','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EWWCOBRTST_20220113.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'WageWorks COBRA Export','201908099','EMPEXPORT','ONDEMAND','Aug 13 2019  2:01PM','EWWCOBRTST',NULL,NULL,NULL,'201908099','Aug  9 2019 12:00AM','Dec 30 1899 12:00AM','201907311','41',NULL,NULL,'201907311',dbo.fn_GetTimedKey(),NULL,'ULTI_WPMJS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'WageWorks COBRA','201904309','EMPEXPORT','SCHEDULED','Aug  8 2018  4:19PM','EWWCOBRTST',NULL,NULL,NULL,'202201079','Nov 22 2016 12:00AM','Dec 30 1899 12:00AM','202112311','2',NULL,NULL,'201904011',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','201908099','EMPEXPORT','TEST','May 17 2019  2:17PM','EWWCOBRTST',NULL,NULL,NULL,'201908099','May 17 2019 12:00AM','Dec 30 1899 12:00AM','201907301','23',NULL,NULL,'201907301',dbo.fn_GetTimedKey(),NULL,'ULTI_WPMJS',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','ExportDescription','C','WageWorks COBRA');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','Filenameseq','C','142');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','Filenum','C','142');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','InitialSort','C','drveessn');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','MaxFileLength','C','654');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','SubSort','C','drvconssn');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','SystemID','V','E3YQSE000020');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EWWCOBRTST','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBRTST','H01','dbo.U_EWWCOBRTST_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBRTST','D02','dbo.U_EWWCOBRTST_drvTbl','drvrectype in (''1'',''2'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBRTST','D03','dbo.U_EWWCOBRTST_depTbl','drvrectype in (''3'')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBRTST','D04','dbo.U_EWWCOBRTST_covTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBRTST','D05','dbo.U_EWWCOBRTST_partTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EWWCOBRTST','T06','dbo.U_EWWCOBRTST_totals',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EWWCOBRTST
-----------

IF OBJECT_ID('U_dsi_BDM_EWWCOBRTST') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EWWCOBRTST] (
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
-- Create table U_EWWCOBRTST_covTbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_covTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_covTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] char(12) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drveessn] char(11) NULL,
    [drvconssn] varchar(30) NULL,
    [drvssn] varchar(11) NULL,
    [drvbenssn] varchar(11) NULL,
    [drvdedcode] varchar(6) NOT NULL,
    [drvplanseq] varchar(2) NOT NULL,
    [drvcovclass] varchar(3) NULL,
    [drvbenrate] varchar(1) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_DedList
-----------

IF OBJECT_ID('U_EWWCOBRTST_DedList') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_DepTbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_DepTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_DepTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] char(12) NOT NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drveessn] char(11) NULL,
    [drvconssn] char(11) NULL,
    [drvbenssn] varchar(11) NULL,
    [drvssn] varchar(11) NULL,
    [drvdepssn] varchar(42) NULL,
    [drvnamelast] varchar(100) NULL,
    [drvnamefirst] varchar(100) NULL,
    [drvnamemi] varchar(1) NULL,
    [drvdaddr1] varchar(255) NULL,
    [drvdaddr2] varchar(255) NULL,
    [drvdcity] varchar(255) NULL,
    [drvdstate] varchar(255) NULL,
    [drvdzip] varchar(50) NULL,
    [drvdhomephone] varchar(50) NULL,
    [drvdateofbirth] datetime NULL,
    [drvgender] char(1) NULL,
    [drvrelationship] varchar(1) NOT NULL,
    [drvstudent] char(1) NULL,
    [drvfilenum] int NULL,
    [drvdepseq] varchar(2) NULL
);

-----------
-- Create table U_EWWCOBRTST_drv10Tbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_drv10Tbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_drv10Tbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecType] varchar(1) NOT NULL,
    [drvSSNIQB] varchar(1) NOT NULL,
    [drvServiceCode] varchar(1) NOT NULL,
    [drvEmployerID] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployerKey] varchar(1) NOT NULL,
    [drvQBSSN] char(11) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleInit] varchar(1) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(1) NOT NULL,
    [drvCountry] char(3) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvBusinessPhone] varchar(1) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvRelationshipToEmployee] varchar(1) NOT NULL,
    [drvFTStudent] varchar(1) NOT NULL,
    [drvMedicareFlag] varchar(1) NOT NULL,
    [drvBeneficiaryType] varchar(1) NOT NULL,
    [drvCOBRAQEDate] varchar(1) NOT NULL,
    [drvBillDate] varchar(1) NOT NULL,
    [drvCOBRAEndDate] varchar(1) NOT NULL,
    [drvGraceDate] varchar(1) NOT NULL,
    [drvGroupedBy1] varchar(1) NOT NULL,
    [drvGroupedBy2] varchar(1) NOT NULL,
    [drvGroupedBy3] varchar(1) NOT NULL,
    [drvHireCvgStartDate] varchar(1) NOT NULL,
    [drvAnnualSalary] varchar(1) NOT NULL,
    [drvEmployeeClass] varchar(1) NOT NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvSevBeginDate] varchar(1) NOT NULL,
    [drvSevEndDate] varchar(1) NOT NULL,
    [drvSubsidyTransferFlag] varchar(1) NOT NULL,
    [drvCOBRAEndDateOverride] varchar(1) NOT NULL,
    [drvMiscField1] varchar(1) NOT NULL,
    [drvMiscField2] varchar(1) NOT NULL,
    [drvMiscField3] varchar(1) NOT NULL,
    [drvMiscField4] varchar(1) NOT NULL,
    [drvMiscField5] varchar(1) NOT NULL,
    [drvReasonIDForInitialRights] varchar(1) NOT NULL,
    [drvIncludeSpouseOnIR] varchar(1) NOT NULL,
    [drvAOID] varchar(1) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_drv30Tbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_drv30Tbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_drv30Tbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecType] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvPlanID] varchar(1) NOT NULL,
    [drvPlanSeqNum] varchar(1) NOT NULL,
    [drvCoverageClassID] varchar(1) NOT NULL,
    [drvPlanBeginDt] varchar(1) NOT NULL,
    [drvPlanEndDt] varchar(1) NOT NULL,
    [drvBeneficiaryRate] varchar(1) NOT NULL,
    [drvBenefitCredit] varchar(1) NOT NULL,
    [drvEERateFlg] varchar(1) NOT NULL,
    [drvClientPaidThruDt] varchar(1) NOT NULL,
    [drvSubsidyCalcValue] varchar(1) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_drv40Tbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_drv40Tbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_drv40Tbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecType] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvParticipantSSN] char(11) NULL,
    [drvDepSeq] varchar(1) NOT NULL,
    [drvPlanID] varchar(1) NOT NULL,
    [drvPlanSeqNum] varchar(1) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_drvTbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_drvTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] char(12) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drveessn] char(11) NULL,
    [drvconssn] varchar(30) NULL,
    [drvssn] varchar(11) NULL,
    [drvbenssn] varchar(11) NULL,
    [drvservicecode] varchar(2) NOT NULL,
    [drvempno] varchar(1) NOT NULL,
    [drvEmployerID] varchar(24) NULL,
    [drvdepssn] varchar(11) NULL,
    [drvnamefirst] varchar(100) NULL,
    [drvnamelast] varchar(100) NULL,
    [drvnamemi] varchar(1) NULL,
    [drvaddr1] varchar(255) NULL,
    [drvaddr2] varchar(255) NULL,
    [drvcity] varchar(255) NULL,
    [drvstate] varchar(255) NULL,
    [drvzipcode] varchar(50) NULL,
    [drvphone] varchar(14) NULL,
    [drvbusphone] varchar(14) NULL,
    [drvemail] varchar(50) NULL,
    [drvdateofbirth] datetime NULL,
    [drvgender] char(1) NULL,
    [drvmaritalstatus] varchar(1) NOT NULL,
    [drvrelationship] varchar(1) NOT NULL,
    [drvstudent] varchar(1) NOT NULL,
    [drvbenetype] varchar(3) NOT NULL,
    [drvstopdate] varchar(8) NULL,
    [drvqereason] varchar(3) NOT NULL,
    [drvBillDate] varchar(1) NOT NULL,
    [drvGroupedBy1] char(6) NULL,
    [drvHireDate] varchar(30) NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvSubsidyTransFlg] varchar(1) NOT NULL,
    [drvReasonID] varchar(1) NOT NULL,
    [drvInitRights] varchar(1) NOT NULL,
    [drvfilenum] int NULL,
    [drvdepseq] varchar(2) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_EEList
-----------

IF OBJECT_ID('U_EWWCOBRTST_EEList') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EWWCOBRTST_File
-----------

IF OBJECT_ID('U_EWWCOBRTST_File') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(600) NULL
);

-----------
-- Create table U_EWWCOBRTST_hdrTbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_hdrTbl] (
    [drvRecType] varchar(1) NOT NULL,
    [drvEmployerID] varchar(1) NOT NULL,
    [drvFileNumber] varchar(1) NOT NULL,
    [drvFileDate] varchar(1) NOT NULL,
    [drvEDIVersion] varchar(1) NOT NULL,
    [drvSpecVersion] varchar(1) NOT NULL,
    [drvSystemLabel] varchar(1) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_Header
-----------

IF OBJECT_ID('U_EWWCOBRTST_Header') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_Header] (
    [drvCounter] varchar(3) NULL,
    [drvEmployerID] varchar(24) NULL
);

-----------
-- Create table U_EWWCOBRTST_partTbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_partTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_partTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drveessn] char(11) NULL,
    [drvconssn] varchar(30) NULL,
    [drvbenssn] varchar(11) NULL,
    [drvssn] varchar(11) NULL,
    [drvmemssn] varchar(11) NULL,
    [drvdepseq] varchar(2) NOT NULL,
    [drvdedcode] varchar(6) NOT NULL,
    [drvplanseq] varchar(2) NOT NULL,
    [drvWaitStartDt] varchar(1) NOT NULL,
    [drvCovStartDt] varchar(1) NOT NULL,
    [drvCovEndDt] varchar(1) NOT NULL
);

-----------
-- Create table U_EWWCOBRTST_Totals
-----------

IF OBJECT_ID('U_EWWCOBRTST_Totals') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_Totals] (
    [drvEmployerID] varchar(24) NULL,
    [drvtotrec] int NULL,
    [drvtotben] int NULL,
    [drvtotdep] int NULL,
    [drvtotcov] int NULL,
    [drvtotpart] int NULL
);

-----------
-- Create table U_EWWCOBRTST_trlTbl
-----------

IF OBJECT_ID('U_EWWCOBRTST_trlTbl') IS NULL
CREATE TABLE [dbo].[U_EWWCOBRTST_trlTbl] (
    [drvEmployerID] varchar(1) NOT NULL,
    [drvRecType] varchar(1) NOT NULL,
    [drvRowCount] varchar(1) NOT NULL,
    [drvBenRecCount] varchar(1) NOT NULL,
    [drvDepRecCount] varchar(1) NOT NULL,
    [drvCvgRecCount] varchar(1) NOT NULL,
    [drvPartRecCount] varchar(1) NOT NULL
);
GO
/*
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EWWCOBRTST'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EWWCOBRTST',getdate(),'P','V1.VK'
*/

CREATE procedure [dbo].[dsi_sp_BuildDriverTables_EWWCOBRTST]
@systemid char(12)
as

/*************************************************************************************************
Client Name: Majestic Steel USA, Inc

Created By: Cissie Vines
Business Analyst: TaMia Mendez
Create Date: 04/04/2019
Service Request Number: SR-2019-00226819

Purpose: WageWorks Cobra Export

Revision History
----------------
Update By           Date           Request Num        Desc
B'Nai Jackson        02/18/2020        PR-336992          Updated Stop Date field

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EWWCOBRTST';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EWWCOBRTST';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EWWCOBRTST';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EWWCOBRTST';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EWWCOBRTST' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBRTST', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBRTST', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EWWCOBRTST', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EWWCOBRTST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EWWCOBRTST', @AllObjects = 'Y', @IsWeb = 'Y';

*************************************************************************************************/

/*
--Data Set 02 = B record
--Data Set 03 = D record
--Data Set 04 = C record
--Data Set 05 = P record
select * from dbo.U_EWWCOBRTST_drvTbl  --Data Set 02 = B record
select * from dbo.U_EWWCOBRTST_depTbl  --Data Set 03 = D record
select * from dbo.U_EWWCOBRTST_covTbl  --Data Set 04 = C record
select * from dbo.U_EWWCOBRTST_partTbl --Data Set 05 = P record
select * from dbo.U_EWWCOBRTST_Header
select * from dbo.U_EWWCOBRTST_totals
*/

    /***************************
    GET DATE PARAMETERS
    ****************************/
    DECLARE
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200),
        @EmployerID char(5);

    SELECT

        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @EndDate = CONVERT(DATETIME, LEFT(endpercontrol , 8) +  ' ' + '08:00:00.000' ),
        @StartDate = CONVERT(DATETIME, LEFT(startpercontrol , 8) +  ' ' + '08:00:00.000' ),
        @FormatCode = formatcode,
        @ExportCode = Exportcode,
        @Exportfile = ExportFile
    FROM dbo.U_Dsi_Parameters
    WHERE SystemID = @SystemID;

-- get file sequence and filename
declare @filenameseq integer;
declare @filenum integer;

select @filenameseq = cast(cfgvalue as integer) +1 --+ 2
from dbo.u_dsi_configuration
where formatcode = @formatcode and cfgname = 'Filenameseq';

select @filenum = cast(cfgvalue as integer) + 1
from dbo.u_dsi_configuration
where formatcode = 'EWWCOBRTST' and cfgname = 'Filenum';

SET @EmployerID = '57090'

-----------
-- Set test EEID
-----------

-- Only focus on test scenarios for now. wchong 5/24/18, test EE filter removed 8/8/18 wchong
--DELETE FROM U_EWWCOBRTST_EEList WHERE xEEID NOT IN (
--'CAD7QR0000K0',
--'CAD8230000K0',
--'CAD87W0000K0',
--'CAD8CN0060K0',
--'CAD8GO0070K0'
--);



if object_id('U_ECOBAPPIN_EEList') is not null
    drop table dbo.U_ECOBAPPIN_EEList;

select distinct
    xCOID = xcoid,
    xEEID = xeeid
into dbo.u_ECOBAPPIN_EEList
from dbo.u_EWWCOBRTST_EEList;

--BDM COBRA
DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = 'ECOBAPPIN';

--INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'DedCodes','HDHP,PPO,DEN,VIS,FSA'); 
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'StartDateTime',@StartDate);
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'EndDateTime',@EndDate);
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'TermSelectionOption','AuditDate');
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'UseCobraCoveredDeds', 'Y');

INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'RelationshipsSpouse', 'SPS');
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'RelationshipsChild', 'CHL,STC');
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'RelationshipsDomPartner', 'DP');
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'RelationshipsDPChild', 'DPC');

--COBRA BDM IN Inserts:
--*********************
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'NewEnrolleeType', '2');
-- This triggers the new enrollee module
-- 1> All new enrollees
-- 2> All new enrollees with no previous plan in their current company; company transfers are disallowed
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'NewEnrolleeIncludeEmps', 'Y');
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'NewEnrolleeDeps', '1') --Include SP and DP as dependents
INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'NewEnrolleeExcludeDeps', '1')
--INSERT INTO U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'ExclFutureDatedStartDates', 'Y'); --A.S. 08/28/2020 comment out
--1:08 PM Cissie Vines: INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'NewEnrolleeType', '1')
--1:08 PM Cissie Vines: INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'NewEnrolleeDeps', '1')
--INSERT INTO dbo.U_dsi_bdm_Configuration VALUES ('ECOBAPPIN', 'NewEnrolleeExcludeDeps', '1')
EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable 'ECOBAPPIN';
--select * from  dbo.U_EWWCOBRTST_drvTbl where drvservicecode = 'BN' and drvconssn > '' 

-- Create Deduction List--BDM COBRA
DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','HDHP,PPO,DEN,VIS,FSA'); 
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate);
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'UseCobraCoveredDeds', 'Y');

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDomPartner', 'DP');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDPChild', 'DPC');

--COBRA BDM QE Inserts:
--*********************
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraType', '4'); --Pull Cobra reasons from EepCobraReason and ConCobraReason
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraDate', '3'); --Pull Cobra dates from EepDateofCobraEvent and ConDateofCobraEvent
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraType', '2'); --Pull Cobra reasons from EmpHDed and ConCobraReason
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraDate', '2'); --Pull Cobra dates from Benefit Stop Date (EedBenStopDate)
INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
--INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','Contacts_DependentCOBRAReason');  
-- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConDateofCobraEventPCF','Contacts_COBRAQualifyingDate');  
EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

--Fix BDM for Employee Deaths, Valid Dependents, Invalid EE's:
DECLARE @CobraPQBType              VARCHAR(1);
DECLARE @RelationshipsSpouse       VARCHAR(256);
DECLARE @RelationshipsChild        VARCHAR(256);
SELECT @CobraPQBType = CONVERT(VARCHAR(1), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraPQBType';
SELECT @RelationshipsSpouse = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsSpouse';
SELECT @RelationshipsChild = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsChild';
SET @CobraPQBType            = dbo.dsi_bdm_fn_Trim(@CobraPQBType);
SET @RelationshipsSpouse     = dbo.dsi_bdm_fn_Trim(@RelationshipsSpouse);
SET @RelationshipsChild      = dbo.dsi_bdm_fn_Trim(@RelationshipsChild);

UPDATE U_dsi_bdm_EmpDeductions
   SET EedValidForExport = 'N',
       EedDedRowStatus   = 'Benefit change reason not valid for Cobra'
  FROM U_dsi_bdm_EmpDeductions
  LEFT JOIN U_dsi_bdm_ChangeReasons WITH (NOLOCK) ON ChgFormatCode = @FormatCode AND EedCobraReason = ChgChangeReason AND ChgTarget = 'EMP'
WHERE EedFormatCode = @FormatCode
   AND EedValidForExport = 'Y'
   AND eedCobraReason in ('210','205');

-----------------------
-- Set the PQB flags
-----------------------

-- Spouses
UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = DbnRelationship
WHERE DbnFormatCode = @FormatCode
   AND DbnValidForExport = 'Y'
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = DbnEEID);


         --select dbneeid, DbnIsPQB from   dbo.U_dsi_BDM_DepDeductions where dbnformatcode = 'EWWCOBRTST' and DBNEEID in  ('CNBYOB000020', 'CL49M1000020', 'CL49IX00G020' , 'CL49LI004020' ,  'CL49M1000020');

-- Children

UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions a
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsChild) ON item = a.DbnRelationship
WHERE a.DbnFormatCode = @FormatCode
   AND a.DbnValidForExport = 'Y'
   AND a.DbnIsChildOldest = CASE
                               WHEN @CobraPQBType = '1' THEN a.DbnIsChildOldest -- ALL children are PQB
                               ELSE 'Y'
                            END
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = a.DbnEEID)
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_DepDeductions b
                     JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = b.DbnRelationship
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.DbnEEID = a.DbnEEID);

--*******************END BDM FIX SECTION*********************************

--Update Benefit Option for Dependent PQB record:
--send EE as benefit option when coverage was EE + Child or EE + Spouse, and Dependent lost coverage.
UPDATE U_dsi_bdm_DepDeductions
    set dbnbenoption = 'EE'
from U_dsi_bdm_DepDeductions a
WHERE DbnFormatCode = @FormatCode
    AND DbnValidForExport = 'Y'
    AND dbnispqb = 'Y'
    and dbnbenoption in ('EE','EEF','EES','EE1','EE2','EEC')
    AND NOT EXISTS(SELECT 1 FROM U_dsi_bdm_DepDeductions b
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.dbnispqb <> 'Y'
                      AND b.DbnEEID = a.DbnEEID);
/*
--Valid Benefit Options
select distinct bnocode, bnodescription from empded join dedcode on eeddedcode = deddedcode
join benopt on bnocode = eedbenoption where dediscobracovered = 'Y'
*/

--Fix the PQB Record Benefit Option on deduction codes, where the PQB has dependents, and shouldn't be EE coverage offering
declare @PQBLoop1 int, @PQBLoop2 int;

set @PQBLoop1 = 0;
set @PQBLoop2 = (select count(*) from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

--select @PQBLoop1, @PQBLoop2

while @PQBLoop1 < @PQBLoop2
BEGIN

declare @dbndeprecid char(12), @dbneeid char(12);
set @dbndeprecid = (select top 1 dbndeprecid from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

set @dbneeid = (select distinct dbneeid from dbo.u_dsi_bdm_DepDeductions where dbndeprecid = @dbndeprecid);

update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions
where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnisPQB = 'Y'
    and dbnBenOption = 'EE' and dbndepRecid = @dbndeprecid;

set @PQBLoop1 = @PQBLoop1 + 1;
END;

--Update the Non-PQB records to have correct coverage:
update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb <> 'Y'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb = 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid
            and b.dbnbenoption <> d.dbnbenoption
            and dbnbenoption <> 'EE');

-- Build PQB Record for Employee
if object_id('U_EWWCOBRTST_drvTbl') is not null
    drop table dbo.U_EWWCOBRTST_drvTbl;
     
SELECT DISTINCT
    drveeid = eeid,
    drvcoid = coid,
    drvdepid = cast('' as char(12)),
    drvrectype = '2',
    drveessn = eepssn,
    drvconssn = cast('' as varchar),
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),  --EE SSN
    --standard above
    drvbenssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),  --SSN (IQB) / QB SSN
    drvservicecode = 'BC',
    drvempno = '',
    drvEmployerID = dbo.dsi_fnPadZero(@EmployerID,12,0),
    drvdepssn = cast(' ' as varchar(11)),
    drvnamefirst = CASE WHEN LEN(eepnamefirst) = 1 THEN EepNamePreferred ELSE EepNameFirst END,
    drvnamelast = eepnamelast,
    drvnamemi = substring(eepnamemiddle,1,1),
    drvaddr1 = eepaddressline1,
    drvaddr2 = eepaddressline2,
    drvcity = eepaddresscity,
    drvstate = eepaddressstate,
    drvzipcode = case when len(rtrim(eepaddresszipcode)) < 6 then eepaddresszipcode
        else substring(eepaddresszipcode,1,5) + '-' + substring(eepaddresszipcode,6,4) end,
    drvphone = case when isnull(rtrim(eepphonehomenumber),'') <> '' then
        '(' + substring(eepphonehomenumber,1,3) + ') ' + substring(eepphonehomenumber,4,3) +
        '-' + substring(eepphonehomenumber,7,4) else '' end,
    drvbusphone = case when isnull(rtrim(eecphonebusinessnumber),'') <> '' then
        '(' + substring(eecphonebusinessnumber,1,3) + ') ' + substring(eecphonebusinessnumber,4,3) +
        '-' + substring(eecphonebusinessnumber,7,4) else '' end,
    drvemail = IIF(ISNULL(eepaddressemail,'')='',eepaddressemail,IIF(ISNULL(eepaddressemailalternate,'')='',eepaddressemailalternate,'')),
    drvdateofbirth = eepdateofbirth,
    drvgender = eepgender,
    drvmaritalstatus = IIF(EepMaritalStatus = 'M','M','S'),
    /*case when eepmaritalstatus = 'Z' then 'U'
                    when eepmaritalstatus in ('S','W') then 'S'
                    when eepmaritalstatus in ('M') then 'M'
                    when eepmaritalstatus in ('D') then 'D'
                     else 'U' end,*/
    drvrelationship = 'E',
    drvstudent = 'N', --'',
    drvbenetype = '001',
    drvstopdate = CONVERT(VARCHAR(8),CobraDate,112),--02/18/20 BJ
    --CASE WHEN EecEmplStatus = 'T' THEN CONVERT(VARCHAR(8),EecDateOfTermination, 112)
                       --ELSE CONVERT(VARCHAR(8),CobraDate,112)
                  --END,  --cobra date = max(eedDateofCobraEvent); date type 2 = EedBenStopDate
    drvqereason = case --when eecemplstatus = 'A' then ''  
                        when eedcobrareason in ('200') then '001'
                        when eedcobrareason in ('208') then '005'
                        when eedcobrareason in ('202','203','209','CHGRP') then '008'
                        when eedcobrareason in ('210') then '002'    
                        when eedcobrareason in ('105','204','206') then '003'  --when eedcobrareason in ('204') then '003'
                        when eedcobrareason in ('107','201','LEVNT3') then '009'  --when eedcobrareason in ('201') then '009'
                        when eedcobrareason in ('205') then '011'
                        when eedcobrareason in ('207') then '051'
                        
                        when eectermreason in ('200') then '028' --when eectermreason in ('200') then '004'
                        when eectermreason in ('201') then '028'
                        when eectermreason in ('202') then '005'
                        when eectermreason in ('203') then '002'
                    else '001' end,
    drvBillDate = '',                  
    drvGroupedBy1 = EecLocation,
    
    -- This is the same as Coverage Start Date
    drvHireDate = cast('' as varchar),    --dedstartdate,  (for initial notice, not QE)  -- CONVERT(VARCHAR(8),EecDateOfLastHire,112),
    drvStatus = 'N',
    drvSubsidyTransFlg = 'N',
    drvReasonID = '',
    drvInitRights = '',     --Initial Notification Record
    drvfilenum = @filenum,
    drvdepseq = '  '  --cast('  ' as integer)

INTO  dbo.U_EWWCOBRTST_drvTbl
from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join (select distinct eedeeid eeid, eedcoid coid, eedCobraReason, max(eedDateofCobraEvent) CobraDate
            from dbo.u_dsi_bdm_EmpDeductions
            where eedFormatCode = @FormatCode and eedvalidforexport = 'Y'
            group by eedeeid, eedcoid, eedCobraReason) ee on xeeid = eeid and xcoid = coid
  where xFormatCode = @FormatCode;

--Build PQB Record if PQB is dependent
INSERT INTO  dbo.U_EWWCOBRTST_drvTbl    
SELECT    DISTINCT
    drveeid = dbneeid,
    drvcoid = dbncoid,
    drvdepid = dbndeprecid,
    drvrectype = '2',
    drveessn = conssn,
    drvconssn = cast('' as varchar),
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4), --Employee's SSN
    drvbenssn = CASE WHEN ISNULL(ConSSN,'') = '' THEN 'D'+ CONVERT(VARCHAR,(row_number() over(partition by coneeid order by condateofbirth)-1))  + EepSSN  --check for ConSSN repeating digit??
                    ELSE substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4) END,    --SSN (IQB) / QB SSN
    drvservicecode = 'BC',
    drvempno = '',
    drvEmployerID = dbo.dsi_fnPadZero(@EmployerID,12,0),
    drvdepssn = cast(' ' as varchar(11)),    
    drvnamefirst = connamefirst,
    drvnamelast = connamelast,
    drvnamemi = substring(connamemiddle,1,1),
    drvaddr1 = case when ConAddressIsDifferent = 'Y' then ConAddressLine1 else eepaddressline1 end,
    drvaddr2 = case when ConAddressIsDifferent = 'Y' then ConAddressLine2 else eepaddressline2 end,
    drvcity = case when ConAddressIsDifferent = 'Y' then ConAddresscity else eepaddresscity end,
    drvstate = case when ConAddressIsDifferent = 'Y' then ConAddressstate else eepaddressstate end,
    drvzipcode = case when ConAddressIsDifferent = 'Y' and len(rtrim(conaddresszipcode)) < 6 then conaddresszipcode
                when ConAddressIsDifferent = 'Y' and len(rtrim(conaddresszipcode)) > 6  then substring(conaddresszipcode,1,5) + '-' + substring(conaddresszipcode,6,4)
                when ConAddressIsDifferent <> 'Y' and len(rtrim(eepaddresszipcode)) < 6 then eepaddresszipcode
                when ConAddressIsDifferent <> 'Y' and len(rtrim(eepaddresszipcode)) > 6  then substring(eepaddresszipcode,1,5) + '-' + substring(eepaddresszipcode,6,4) end,
    drvphone = ConPhoneHomeNumber,
    drvbusphone = space(10),
    drvemail = ConEmailAddr, --space(10),
    drvdateofbirth = condateofbirth,
    drvgender = congender,
    drvmaritalstatus = 'U',
    drvrelationship = case when conrelationship in ('SPS','DP') then 'S'
                           --when ConRelationship = 'DP' THEN 'P'
                        else  'C' end,
    drvstudent = conisstudent,
    drvbenetype = '001',    --cast('' as varchar),
    drvstopdate = convert(char(8),CobraDate,112),
    drvqereason = case --when eecemplstatus = 'A' then ''  
                        when dbncobrareason in ('200') then '001'
                        when dbncobrareason in ('208') then '005'
                        when dbncobrareason in ('202','203','209','CHGRP') then '008'
                        when dbncobrareason in ('210') then '002'    
                        when dbncobrareason in ('105','204','206') then '003'  --when eedcobrareason in ('204') then '003'
                        when dbncobrareason in ('107','201','LEVNT3') then '009'  --when eedcobrareason in ('201') then '009'
                        when dbncobrareason in ('205') then '011'
                        when dbncobrareason in ('207') then '051'
                        when eectermreason in ('200') then '028' --when eectermreason in ('200') then '004'
                        when eectermreason in ('201') then '028'
                        when eectermreason in ('202') then '005'
                        when eectermreason in ('203') then '002'
                    else '001' end,
    drvBillDate = '',
    drvGroupedBy1 = EecLocation,
    drvHireDate = cast('' as varchar),    --dedstartdate,
    drvStatus = 'N',
    drvSubsidyTransFlg = 'N',
    drvReasonID = '',
    drvInitRights = '',
    drvfilenum = @filenum,
    drvdepseq = '  ' -- cast('' as integer)--qseqno

from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, dbnCobraReason, max(dbnDateofCobraEvent) CobraDate
            from dbo.u_dsi_bdm_DepDeductions
            where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y' and dbnispqb = 'Y'
            group by dbneeid, dbncoid, dbndeprecid, dbncobrareason) pqb on xeeid = pqb.eeid and xcoid = pqb.coid
    join (select distinct dbneeid, dbncoid, dbndeprecid,
            row_number() over(partition by dbneeid
            order by case when conrelationship in ('SPS','DP') then '1' else '2' end) qseqno
            from dbo.u_dsi_bdm_DepDeductions
            join contacts on dbndeprecid = consystemid
            where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
            and dbnispqb = 'Y') dp on xeeid = dbneeid and xcoid = dbncoid and pqb.depid = dbndeprecid
    join contacts on dbndeprecid = consystemid
  where xFormatCode = @FormatCode;

--Build Family Member Record when not PQB
if object_id('U_EWWCOBRTST_DepTbl') is not null
    drop table dbo.U_EWWCOBRTST_DepTbl;

select    DISTINCT
    drveeid = dbneeid,
    drvcoid = dbncoid,
    drvdepid = dbndeprecid,
    drvrectype = '3',  
    drveessn = isnull(pqb.ssn,eepssn),
    drvconssn = conssn,
    drvbenssn = case when pqb.ssn is not null then SUBSTRING(pqb.SSN,1,3)+'-'+SUBSTRING(pqb.SSN,4,2)+'-'+SUBSTRING(pqb.SSN,6,4)
            else substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4) end,--QB SSN
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),--EE SSN
            --case when pqb.ssn is not null then SUBSTRING(pqb.SSN,1,3)+'-'+SUBSTRING(pqb.SSN,4,2)+'-'+SUBSTRING(pqb.SSN,6,4)
            --else substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4) end,
    drvdepssn =  CASE WHEN ISNULL(ConSSN,'') = '' THEN 'D'+ CONVERT(VARCHAR,(row_number() over(partition by coneeid order by condateofbirth)-1))  + EepSSN
                    ELSE substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4) END,    
    drvnamelast = connamelast,
    drvnamefirst = connamefirst,
    drvnamemi = substring(connamemiddle,1,1),
    drvdaddr1 = case when ConAddressIsDifferent = 'Y' then ConAddressLine1 else '' end,
    drvdaddr2 = case when ConAddressIsDifferent = 'Y' then ConAddressLine2 else '' end,
    drvdcity = case when ConAddressIsDifferent = 'Y' then ConAddresscity else '' end,
    drvdstate = case when ConAddressIsDifferent = 'Y' then ConAddressstate else '' end,
    drvdzip = case when ConAddressIsDifferent = 'Y' and len(rtrim(conaddresszipcode)) < 6 then conaddresszipcode
                       when ConAddressIsDifferent = 'Y' and len(rtrim(conaddresszipcode)) > 6  then substring(conaddresszipcode,1,5) + '-' + substring(conaddresszipcode,6,4)
                  ELSE '' END,
    drvdhomephone = ConPhoneHomeNumber,        
    drvdateofbirth = condateofbirth,
    drvgender = congender,
    drvrelationship = case when conrelationship in ('SPS','DP') then 'S'
                        else  'C' end,
    --select * from codes where codtable = 'relation'
    drvstudent = conisstudent,
    drvfilenum = @filenum,
    drvdepseq = Right('00' + Cast((row_number() over(partition by coneeid order by condateofbirth)) As varchar(2)),2) --dbo.dsi_fnPadZero((row_number() over(partition by coneeid order by condateofbirth)),2,0) --qseqno

INTO dbo.U_EWWCOBRTST_DepTbl    --select * from  dbo.U_EWWCOBRTST_DepTbl
from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join (select distinct dbneeid, dbncoid, dbndeprecid
            from dbo.u_dsi_bdm_DepDeductions
            where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y' and dbnispqb <> 'Y') dp on xeeid = dbneeid and xcoid = dbncoid
    join contacts on dbndeprecid = consystemid
    --left join (select distinct coneeid eeid, consystemid depid,
    --        row_number() over(partition by coneeid
    --        order by condateofbirth) qseqno    
    --        from contacts) con on con.eeid = dbneeid and con.depid = dbndeprecid
    left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
  where xFormatCode = @FormatCode;

--Build Coverage Record for PQB
if object_id('U_EWWCOBRTST_covTbl') is not null
    drop table dbo.U_EWWCOBRTST_covTbl;
    
Select distinct    
    drveeid = eedeeid,
    drvcoid = eedcoid,
    drvdepid = cast('' as char(12)),
    drvrectype = 'C',        --'4'
    drveessn = eepssn,
    drvconssn = cast('' as varchar),
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvbenssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvdedcode = CASE 
                         WHEN EedDedCode = 'DENT' THEN '459480'
                         WHEN EedDedCode = 'VIS' THEN '404516'
                         WHEN EedDedCode = 'MDEXC' THEN '404501' 
                         WHEN EedDedCode = 'MDHSA' THEN '404503'
                         WHEN EedDedCode = 'MDPPO' THEN '404507'
                         ELSE ''
                      END,
    drvplanseq = CASE -- Plan Seq Num: According to WW, this is just a unique 2 digit ID per plan that we can create/assign
                         WHEN EedDedCode = 'MDEXC' THEN '10' 
                         WHEN EedDedCode = 'MDHSA' THEN '20'
                         WHEN EedDedCode = 'MDPPO' THEN '30'
                         WHEN EedDedCode = 'DENT' THEN '40'
                         WHEN EedDedCode = 'VIS' THEN '50'                         
                         ELSE ''
                      END,
    drvcovclass = CASE                    
                    WHEN EedBenOption IN ('EE','TBEE') THEN '001'
                    WHEN EedBenOption IN ('EES','EEDP','TBEES') THEN '002'
                    WHEN EedBenOption IN ('EEC','TBEEC') THEN '003'
                    WHEN EedBenOption IN ('EEF','EEDPF','FAM','TBEEF') THEN '004'                    
                   END,

    drvbenrate = '' --case when deddedtype = 'FSA' then convert(varchar(7),eedeegoalamt/12) else null end            

into    dbo.U_EWWCOBRTST_covTbl
from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join dbo.u_dsi_bdm_EmpDeductions
            on eedFormatCode = @FormatCode and eedvalidforexport = 'Y' and xeeid = eedeeid and xcoid = eedcoid
  where xFormatCode = @FormatCode;

--Dependent is PQB Coverage Records
insert into    dbo.U_EWWCOBRTST_covTbl
Select distinct    
    drveeid = dbneeid,
    drvcoid = dbncoid,
    drvdepid = dbndeprecid,
    drvrectype = 'C',        --'4'
    drveessn = conssn,
    drvconssn = cast('' as varchar),
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    /*CASE WHEN ISNULL(ConSSN,'') = '' THEN 'D0' + EepSSN ELSE substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4) END, */
    drvbenssn = CASE WHEN ISNULL(ConSSN,'') = '' THEN 'D'+ CONVERT(VARCHAR,(row_number() over(partition by coneeid order by condateofbirth)-1))  + EepSSN
                    ELSE substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4) END,    
    drvdedcode =CASE 
                         WHEN DbnDedCode = 'DENT' THEN '459480'
                         WHEN DbnDedCode = 'VIS' THEN '404516'
                         WHEN DbnDedCode = 'MDEXC' THEN '404501' 
                         WHEN DbnDedCode = 'MDHSA' THEN '404503'
                         WHEN DbnDedCode = 'MDPPO' THEN '404507'
                         ELSE ''
                      END,
    drvplanseq = CASE -- Plan Seq Num: According to WW, this is just a unique 2 digit ID per plan that we can create/assign
                         WHEN DbnDedCode = 'MDEXC' THEN '10' 
                         WHEN DbnDedCode = 'MDHSA' THEN '20'
                         WHEN DbnDedCode = 'MDPPO' THEN '30'
                         WHEN DbnDedCode = 'DENT' THEN '40'
                         WHEN DbnDedCode = 'VIS' THEN '50'  
                         ELSE ''
                      END,
    drvcovclass =  CASE  WHEN DbnBenOption IN ('EE','TBEE') THEN '001'
                         WHEN DbnBenOption IN ('EES','EEDP','TBEES') THEN '002'
                         WHEN DbnBenOption IN ('EEC','TBEEC') THEN '003'
                         WHEN DbnBenOption IN ('EEF','EEDPF','FAM','TBEEF') THEN '004'                    
                      ELSE 
                          CASE WHEN dbnRelationship IN ('SPS','DP') AND NDPch.NdpNumCh > 0 THEN '003'
                          ELSE '001' END
                          END,  
                                  
    drvbenrate = '' -- case when deddedtype = 'FSA' then convert(varchar(7),dedeegoalamt/12) else null end            

from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join dbo.u_dsi_bdm_DepDeductions
            on dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y' and dbnispqb = 'Y'  -- THis is per Leigh Lamb 8-13-2019 at the vendor request
            and xeeid = dbneeid and xcoid = dbncoid
    -- Subselect of BDM for count of SP for non-EE PQB
           LEFT JOIN  (SELECT  NdpEEID    = dbnEEID
                          ,NdpDedCode = dbnDedCode
                          ,NdpNumCH = COUNT(1)
                       FROM (SELECT DISTINCT DbnEEID, DbnDepRecID, DbnDedCode
                                 FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
                                 WHERE DbnFormatCode = @FormatCode and DbnValidForExport = 'Y' 
                                 AND DbnRelationship NOT IN ('SPS','DP')) NDPC
                       GROUP BY dbnEEID, dbnDedCode) NDPCh
                       ON NDPCh.NdpEEID = dbnEEID
                       AND NDPCh.NdpDedCode = dbnDedCode
           -- Subselect of BDM for count of CH for non-EE PQB
           LEFT JOIN (SELECT  NdpEEID    = dbnEEID
                          ,NdpDedCode = dbnDedCode
                          ,NdpNumSP = COUNT(1)
                       FROM (SELECT DISTINCT DbnEEID, DbnDepRecID, DbnDedCode
                                 FROM dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
                                 WHERE DbnFormatCode = @FormatCode and DbnValidForExport = 'Y' 
                                 --AND DbnIsPQB = 'N'
                                 AND DbnRelationship IN ('SPS','DP')) NDPS
                       GROUP BY dbnEEID, dbnDedCode) NDPSp
                       ON NDPSp.NdpEEID = dbnEEID
                       AND NDPSp.NdpDedCode = dbnDedCode
    join contacts on dbndeprecid = consystemid
  where xFormatCode = @FormatCode;

--select * from dbo.U_EWWCOBRTST_covTbl

--Build Participant Record for PQB
if object_id('U_EWWCOBRTST_partTbl') is not null
    drop table dbo.U_EWWCOBRTST_partTbl;
    
Select distinct    
    drveeid = eedeeid,
    drvcoid = eedcoid,
    drvdepid = cast(null as varchar),
    drvrectype = '5',
    drveessn = eepssn,
    drvconssn = cast('' as varchar),
    drvbenssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvmemssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvdepseq = '  ', --0,--qseqno,
    drvdedcode =CASE 
                         WHEN EedDedCode = 'DENT' THEN '459480'
                         WHEN EedDedCode = 'VIS' THEN '404516'
                         WHEN EedDedCode = 'MDEXC' THEN '404501' 
                         WHEN EedDedCode = 'MDHSA' THEN '404503'
                         WHEN EedDedCode = 'MDPPO' THEN '404507'
                         ELSE ''
                      END,
    drvplanseq =  CASE -- Plan Seq Num: According to WW, this is just a unique 2 digit ID per plan that we can create/assign
                         WHEN EedDedCode = 'MDEXC' THEN '10' 
                         WHEN EedDedCode = 'MDHSA' THEN '20'
                         WHEN EedDedCode = 'MDPPO' THEN '30'
                         WHEN EedDedCode = 'DENT' THEN '40'
                         WHEN EedDedCode = 'VIS' THEN '50'
                         ELSE ''
                      END,
    drvWaitStartDt = '',--eecdateoforiginalhire,
    drvCovStartDt = '',--eedbenstartdate,
    drvCovEndDt = ''--coalesce(eecdateoftermination,eedbenstopdate)

into    dbo.U_EWWCOBRTST_partTbl
from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join dbo.u_dsi_bdm_EmpDeductions on eedFormatCode = @FormatCode
        and eedvalidforexport = 'Y' and xeeid = eedeeid and xcoid = eedcoid
  where xFormatCode = @FormatCode;

--Dependent is PQB - add dependents to Participant table

INSERT into dbo.U_EWWCOBRTST_partTbl
Select distinct    
    drveeid = dbneeid,
    drvcoid = dbncoid,
    drvdepid = dbndeprecid,
    drvrectype = '5',
    drveessn = conssn,
    drvconssn = conssn,
    drvbenssn = CASE WHEN ISNULL(ConSSN,'') = '' THEN 'D'+ CONVERT(VARCHAR,(row_number() over(partition by coneeid order by condateofbirth)-1))  + EepSSN
                    ELSE substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4) END,    --SSN (IQB)
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),--EE SSN
    drvmemssn = CASE WHEN ISNULL(ConSSN,'') = '' THEN 'D'+ CONVERT(VARCHAR,(row_number() over(partition by coneeid order by condateofbirth)-1))  + EepSSN
                    ELSE substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4) END,    --Participant SSN
    drvdepseq = '  ',--0,--qseqno,
    drvdedcode = CASE 
                         WHEN DbnDedCode = 'DENT' THEN '459480'
                         WHEN DbnDedCode = 'VIS' THEN '404516'
                         WHEN DbnDedCode = 'MDEXC' THEN '404501' 
                         WHEN DbnDedCode = 'MDHSA' THEN '404503'
                         WHEN DbnDedCode = 'MDPPO' THEN '404507'                         
                         ELSE ''
                      END,
    drvplanseq = CASE -- Plan Seq Num: According to WW, this is just a unique 2 digit ID per plan that we can create/assign
                         WHEN DbnDedCode = 'MDEXC' THEN '10' 
                         WHEN DbnDedCode = 'MDHSA' THEN '20'
                         WHEN DbnDedCode = 'MDPPO' THEN '30'
                         WHEN DbnDedCode = 'DENT' THEN '40'
                         WHEN DbnDedCode = 'VIS' THEN '50'  
                         ELSE ''
                      END,
    drvWaitStartDt = '',--eecdateoforiginalhire,
    drvCovStartDt = '',--dbnbenstartdate,
    drvCovEndDt = ''--coalesce(eecdateoftermination,dbnbenstopdate)        --3/23/10

from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
        and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
    left join (select drveeid, drvcoid, drvdepid, drvdepseq qseqno from dbo.U_EWWCOBRTST_DepTbl) seq on seq.drvdepid = dbndeprecid and drveeid = xeeid and drvcoid = xcoid
    join contacts on dbndeprecid = consystemid
  where xFormatCode = @FormatCode;

--add dependents to Participant table

INSERT into dbo.U_EWWCOBRTST_partTbl
Select distinct    
    drveeid = dbneeid,
    drvcoid = dbncoid,
    drvdepid = dbndeprecid,
    drvrectype = '5',
    drveessn = isnull(pqb.ssn,eepssn),
    drvconssn = conssn,
    drvbenssn = CASE WHEN EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_DepDeductions WHERE dbnFormatCode = @FormatCode AND dbnvalidforexport = 'Y' AND dbnispqb = 'Y' AND dbneeid = xEEID AND xcoid = dbncoid) --Dep is PQB
                        THEN CASE WHEN pqb.SSN IS NULL THEN 'D0' + EepSSN
                                  ELSE SUBSTRING(pqb.SSN,1,3) + '-' + SUBSTRING(pqb.SSN,4,2) + '-' + SUBSTRING(pqb.SSN,6,4)  --QB DEP SSN
                             END
                        ELSE substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4)  --EE IS PQB
                 END,
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4), --EE SSN
    drvmemssn =  CASE WHEN ISNULL(ConSSN,'') = '' THEN 'D'+ CONVERT(VARCHAR,(row_number() over(partition by coneeid order by condateofbirth)-1))  + EepSSN
                    ELSE substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4) END,    --Participant SSN
    drvdepseq =  '0',
    drvdedcode =  CASE 
                          WHEN DbnDedCode = 'DENT' THEN '459480'
                         WHEN DbnDedCode = 'VIS' THEN '404516'
                         WHEN DbnDedCode = 'MDEXC' THEN '404501' 
                         WHEN DbnDedCode = 'MDHSA' THEN '404503'
                         WHEN DbnDedCode = 'MDPPO' THEN '404507' 
                         ELSE ''
                      END,
    drvplanseq = CASE -- Plan Seq Num: According to WW, this is just a unique 2 digit ID per plan that we can create/assign
                         WHEN DbnDedCode = 'MDEXC' THEN '10' 
                         WHEN DbnDedCode = 'MDHSA' THEN '20'
                         WHEN DbnDedCode = 'MDPPO' THEN '30'
                         WHEN DbnDedCode = 'DENT' THEN '40'
                         WHEN DbnDedCode = 'VIS' THEN '50'
                         ELSE ''
                      END,
    drvWaitStartDt = '',--eecdateoforiginalhire,
    drvCovStartDt = '',--dbnbenstartdate,
    drvCovEndDt = ''--coalesce(eecdateoftermination,dbnbenstopdate)        --3/23/10

from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
        and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
    join (select drveeid, drvcoid, drvdepid, drvdepseq qseqno from dbo.U_EWWCOBRTST_DepTbl) seq on seq.drvdepid = dbndeprecid and drveeid = xeeid and drvcoid = xcoid
    join contacts on dbndeprecid = consystemid
    left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
  where xFormatCode = @FormatCode;

--select * from dbo.U_EWWCOBRTST_partTbl

--     General/Initial Notice Inserts:
INSERT INTO  dbo.U_EWWCOBRTST_drvTbl
SELECT DISTINCT
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as char(12)),
    drvrectype = '1',
    drveessn = eepssn,
    drvconssn = cast('' as varchar),
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    --standard above
    drvbenssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvservicecode = 'BN',--Field 3
    drvempno = '',
    drvEmployerID = dbo.dsi_fnPadZero(@EmployerID,12,0),
    drvdepssn = cast(' ' as varchar(11)),
    drvnamefirst = eepnamefirst,
    drvnamelast = eepnamelast,
    drvnamemi = substring(eepnamemiddle,1,1),
    drvaddr1 = eepaddressline1,
    drvaddr2 = eepaddressline2,
    drvcity = eepaddresscity,
    drvstate = eepaddressstate,
    drvzipcode = case when len(rtrim(eepaddresszipcode)) < 6 then eepaddresszipcode
        else substring(eepaddresszipcode,1,5) + '-' + substring(eepaddresszipcode,6,4) end,
    drvphone = case when isnull(rtrim(eepphonehomenumber),'') <> '' then
        '(' + substring(eepphonehomenumber,1,3) + ') ' + substring(eepphonehomenumber,4,3) +
        '-' + substring(eepphonehomenumber,7,4) else '' end,
    drvbusphone = case when isnull(rtrim(eecphonebusinessnumber),'') <> '' then
        '(' + substring(eecphonebusinessnumber,1,3) + ') ' + substring(eecphonebusinessnumber,4,3) +
        '-' + substring(eecphonebusinessnumber,7,4) else '' end,
    drvemail = eepaddressemail,
    drvdateofbirth = eepdateofbirth,
    drvgender = eepgender,
    drvmaritalstatus = case when eepmaritalstatus = 'Z' then 'U'
                    when eepmaritalstatus in ('S','W') then 'S'
                    when eepmaritalstatus in ('M') then 'M'
                    when eepmaritalstatus in ('D') then 'D'
                     else 'U' end,
    drvrelationship = 'E',
    drvstudent = 'N',
    drvbenetype = '010',--Field 26
    drvstopdate = '',--CobraDate,
    drvqereason = '000',
    drvBillDate = '',
--                    case when datepart(dd, eepdateofcobraevent) between '1' and '15' then
--                    convert(varchar(2), datepart(mm, eepdateofcobraevent)) + '/15/' + convert(varchar(4), datepart(yyyy, eepdateofcobraevent))
--                  else
--                    case when datepart(mm, eepdateofcobraevent) = '2' then '02/28/' + convert(varchar(4), datepart(yyyy, eepdateofcobraevent))
--                         when datepart(mm, eepdateofcobraevent) in ('1','3','5','7','8','10','12') then convert(varchar(2), datepart(mm, eepdateofcobraevent)) + '/31/' + convert(varchar(4), datepart(yyyy, eepdateofcobraevent))
--                    else convert(varchar(2), datepart(mm, eepdateofcobraevent)) + '/30/' + convert(varchar(4), datepart(yyyy, eepdateofcobraevent))
--                    end
--                  end,
    drvGroupedBy1 = EecLocation,
    drvHireDate = convert(char(8),CobraDate,112),  --(for initial notice, not QE) --Field 36
    drvStatus = 'X', --Field 39
    drvSubsidyTransFlg = 'N', --field 42
    drvReasonID = case when dp.eeid is not null then '4' else '1' end,--49
    drvInitRights = case when dp.eeid is not null then 'Y' else 'N' end,--50
    --IF Employee AND Spouse are being added at the same time, then 'Y'
--Else 'N'

--COBRA Record
--Space

    drvfilenum = @filenum,
    drvdepseq = cast('' as integer)

from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join (select distinct eedeeid eeid, eedcoid coid, eedCobraReason, max(eedbenstartdate) CobraDate
            from dbo.u_dsi_bdm_EmpDeductions
            where eedFormatCode = 'ECOBAPPIN' and eedvalidforexport = 'Y'
            group by eedeeid, eedcoid, eedCobraReason) ee on xeeid = ee.eeid and xcoid = ee.coid
    left join (select distinct dbneeid eeid, dbncoid coid
            from dbo.u_dsi_bdm_DepDeductions
            where dbnFormatCode = 'ECOBAPPIN' and dbnvalidforexport = 'Y') dp on xeeid = dp.eeid and xcoid = dp.coid
  where xFormatCode = 'ECOBAPPIN' and eecdateoflasthire < getdate();

  
--General/Initial Notice Inserts (Spouse Only):
INSERT INTO  dbo.U_EWWCOBRTST_drvTbl
SELECT DISTINCT
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as char(12)),
    drvrectype = '1',
    drveessn = eepssn,
    drvconssn = conssn,
    drvssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    --standard above
    drvbenssn = substring(eepssn,1,3) + '-' + substring(eepssn,4,2) + '-' + substring(eepssn,6,4),
    drvservicecode = 'BN',--Field 3
    drvempno = '',
    drvEmployerID = dbo.dsi_fnPadZero(@EmployerID,12,0),
    drvdepssn = substring(conssn,1,3) + '-' + substring(conssn,4,2) + '-' + substring(conssn,6,4),
    drvnamelast = connamelast,
    drvnamefirst = connamefirst,
    drvnamemi = substring(connamemiddle,1,1),
    drvaddr1 = conaddressline1,
    drvaddr2 = conaddressline2,
    drvcity = conaddresscity,
    drvstate = conaddressstate,
    drvzipcode = case when len(rtrim(conaddresszipcode)) < 6 then conaddresszipcode
        else substring(conaddresszipcode,1,5) + '-' + substring(conaddresszipcode,6,4) end,
    drvphone = case when isnull(rtrim(conphonehomenumber),'') <> '' then
        '(' + substring(conphonehomenumber,1,3) + ') ' + substring(conphonehomenumber,4,3) +
        '-' + substring(conphonehomenumber,7,4) else '' end,
    drvbusphone = case when isnull(rtrim(eecphonebusinessnumber),'') <> '' then
        '(' + substring(eecphonebusinessnumber,1,3) + ') ' + substring(eecphonebusinessnumber,4,3) +
        '-' + substring(eecphonebusinessnumber,7,4) else '' end,
    drvemail = eepaddressemail,
    drvdateofbirth = condateofbirth,
    drvgender = congender,
    drvmaritalstatus = case when eepmaritalstatus = 'Z' then 'U'
                    when eepmaritalstatus in ('S','W') then 'S'
                    when eepmaritalstatus in ('M') then 'M'
                    when eepmaritalstatus in ('D') then 'D'
                     else 'U' end,
    drvrelationship = case when conrelationship in ('SPS','HUS','WIF','DMP','DP') then 'S'
                        else  'C' end,
    drvstudent = conisstudent,
    drvbenetype = '010',--Field 26
    drvstopdate = '',--CobraDate,
    drvqereason = '000',
    drvBillDate = '',
    drvGroupedBy1 = EecLocation,
    drvHireDate = convert(char(8),CobraDate,112),  --(for initial notice, not QE) --Field 36
    drvStatus = 'X', --Field 39
    drvSubsidyTransFlg = 'N',
    drvReasonID = '4',--49
    drvInitRights = 'N',--50 --IF Employee AND Spouse are being added at the same time, then 'Y'
--Else 'N'

--COBRA Record
--Space

    drvfilenum = @filenum,
    drvdepseq = cast('' as integer)

from dbo.u_dsi_bdm_EElist
    join emppers on eepeeid = xeeid
    JOIN EmpComp on xeeid = eeceeid and xcoid = eeccoid
        and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
    join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid, dbnCobraReason, max(dbnbenstartdate) CobraDate
            from dbo.u_dsi_bdm_DepDeductions join contacts on dbndeprecid = consystemid
            where dbnFormatCode = 'ECOBAPPIN' and dbnvalidforexport = 'Y'
            and conrelationship in ('SPS','HUS','WIF','DMP','DP')
            group by dbneeid, dbncoid, dbndeprecid, dbnCobraReason) ee on xeeid = ee.eeid and xcoid = ee.coid
    join contacts on dbndeprecid = consystemid
  where xFormatCode = 'ECOBAPPIN' and eecdateoflasthire < getdate()
  


  
--Use this code to fix the EmpSSN on the Dependents of PQB's who are not the EE record
declare @Loop1 int, @Loop2 int,  @depid char(12), @eeid char(12), @pqbid char(12), @ssn char(12), @ssnhyphen char(12);
set @Loop1 = 0;
set @Loop2 = (select count(*) from dbo.U_EWWCOBRTST_depTbl
where drveessn not in (select distinct drveessn from dbo.U_EWWCOBRTST_drvTbl));

WHILE @Loop1 < @Loop2
BEGIN
set @depid = (select top 1 drvdepid from dbo.U_EWWCOBRTST_depTbl where drveessn not in (select distinct drveessn from dbo.U_EWWCOBRTST_drvTbl));
set @eeid = (select drveeid from dbo.U_EWWCOBRTST_depTbl where drvdepid = @depid);

--declare @LName char(25), @FName char(25), @MInit char(1), @Gender char(6)
set @pqbid = (select top 1 drvdepid from dbo.U_EWWCOBRTST_drvTbl where drvrectype = '2' and drveeid = @eeid);

select @ssn = drveessn,
    @ssnhyphen = drvssn

from dbo.U_EWWCOBRTST_drvTbl
where drvdepid = @pqbid;

update dbo.U_EWWCOBRTST_depTbl
    set drveessn = @ssn,
        drvbenssn = @ssnhyphen,
        drvssn = @ssnhyphen

from dbo.U_EWWCOBRTST_depTbl
where drvdepid = @depid
    and drveeid = @eeid;

set @Loop1 = @Loop1 + 1;
END;


/*
--Run this query afterwards, to verify the update statement worked

--Should return 0 records:
select eepnamelast, eepnamefirst,drvssn, *
from dbo.U_EWWCOBRTST_depTbl join emppers on eepeeid = drveeid
where drveessn not in (select distinct drveessn from dbo.U_EWWCOBRTST_drvTbl)

*/

--Build Total Record
if object_id('U_EWWCOBRTST_Totals') is not null
    drop table dbo.U_EWWCOBRTST_Totals;

select
    drvEmployerID = dbo.dsi_fnPadZero(@EmployerID,12,0),
    drvtotrec = totben + totdep + totcov + totpart,
    drvtotben = totben,
    drvtotdep = totdep,
    drvtotcov = totcov,
    drvtotpart = totpart
into dbo.U_EWWCOBRTST_Totals

from (select count(*) totben from dbo.U_EWWCOBRTST_drvTbl where drvrectype in ('1','2')) ben
left join (select isnull(count(*),0) totdep from dbo.U_EWWCOBRTST_depTbl where drvrectype in ('3')) dep on 1 = 1
left join (select isnull(count(*),0) totcov from dbo.U_EWWCOBRTST_covTbl) cov on 1 = 1
left join (select isnull(count(*),0) totpart from dbo.U_EWWCOBRTST_partTbl) part on 1 = 1;

--select * from dbo.U_EWWCOBRTST_Totals

--Build Header Record
if object_id('U_EWWCOBRTST_Header') is not null
    drop table dbo.U_EWWCOBRTST_Header;

select drvCounter  = right(dbo.dsi_fnPadZero(@filenameseq,10,'0'),3),
        drvEmployerID = dbo.dsi_fnPadZero(@EmployerID,12,0)
into dbo.U_EWWCOBRTST_Header;

-- Set FileName

if (dbo.dsi_fnVariable('EWWCOBRTST','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'WW_COBRA_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'EWWCOBRTST';

-- This block was enabled on 8/8/18 because we need the file name to pull the sequence value in the header. wchong
-- This block was re-disabled on 8/22/18 wchong

  --update dbo.U_dsi_Parameters
  --  set ExportFile =  @EmployerID + case when @exportcode = 'TEST' then 'TST'
  --          else right(dbo.dsi_fnPadZero(@filenameseq,10,'0'),3) end + '.DAT'
  --  where FormatCode = @formatcode



update dbo.u_dsi_configuration
set cfgvalue = @filenum
where formatcode = @formatcode and cfgname = 'Filenum'
    and @exportcode <> 'TEST';

update dbo.u_dsi_configuration
set cfgvalue = @filenameseq
where formatcode = @formatcode and cfgname = 'Filenameseq'
    and @exportcode <> 'TEST';

/* Alter the View
 ALTER  View dbo.dsi_vwEWWCOBRTST_Export as
select top 2000000  Data from dbo.U_EWWCOBRTST_File with (nolock)
         order by case when substring(RecordSet,1,1) = 'H' then 1
                when substring(Data,1,1) = 'B' then 2
                when substring(Data,1,1) = 'D' then 3
                when substring(Data,1,1) = 'C' then 4
                when substring(Data,1,1) = 'P' then 5
                when substring(RecordSet,1,1) = 'T' then 9 else 3 end,InitialSort, Subsort,substring(recordset,2,2)
                /*
                  order by case when substring(RecordSet,1,1) = 'H' then 1
                when substring(Data,1,1) = 'B' then 2
                when substring(Data,1,1) = 'D' then 3
                when substring(Data,1,1) = 'C' then 4
                when substring(Data,1,1) = 'P' then 5
                when substring(RecordSet,1,1) = 'T' then 9 else 3 end,InitialSort, Subsort,substring(recordset,2,2)
                */
select expformatcode, expexportcode,expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'EWWCOBRTST'


--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201904011'
       ,expStartPerControl     = '201904011'
       ,expLastEndPerControl   = '201904309'
       ,expEndPerControl       = '201904309'
WHERE expFormatCode = 'EWWCOBRTST';
*/

--testing

--dsi_sp_testswitchbox_v2 'EWWCOBRTST', 'EWWCOBRTST'
--dsi_sp_testswitchbox_v2 'EWWCOBRTST', 'TEST'
GO
CREATE  View dbo.dsi_vwEWWCOBRTST_Export as
select top 2000000  Data from dbo.U_EWWCOBRTST_File with (nolock)
         order by case when substring(RecordSet,1,1) = 'H' then 1
                when substring(Data,1,1) = 'B' then 2
                when substring(Data,1,1) = 'D' then 3
                when substring(Data,1,1) = 'C' then 4
                when substring(Data,1,1) = 'P' then 5
                when substring(RecordSet,1,1) = 'T' then 9 else 3 end,InitialSort, Subsort,substring(recordset,2,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EWWCOBRTST' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWWCOBRTST', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EWWCOBRTST', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EWWCOBRTST', 'UseFileName', 'V', 'Y'


-- End ripout