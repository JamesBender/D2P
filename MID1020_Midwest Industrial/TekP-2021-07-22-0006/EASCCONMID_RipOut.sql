/**********************************************************************************

EASCCONMID: Ascensus 401k Cont Export

FormatCode:     EASCCONMID
Project:        Ascensus 401k Cont Export
Client ID:      MID1020
Date/time:      2022-02-15 20:17:18.297
Ripout version: 7.4
Export Type:    Web
Status:         Production
Environment:    EWP
Server:         EW2WUP4DB03
Database:       ULTIPRO_WPMIDI
Web Filename:   MID1020_E7F11_EEHISTORY_EASCCONMID_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EASCCONMID_SavePath') IS NOT NULL DROP TABLE dbo.U_EASCCONMID_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EASCCONMID'


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
WHERE FormatCode = 'EASCCONMID'
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
WHERE ExpFormatCode = 'EASCCONMID'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EASCCONMID')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EASCCONMID'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EASCCONMID'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EASCCONMID'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EASCCONMID'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EASCCONMID'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EASCCONMID'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EASCCONMID'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EASCCONMID'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EASCCONMID'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEASCCONMID_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASCCONMID_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASCCONMID') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASCCONMID];
GO
IF OBJECT_ID('U_EASCCONMID_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_Trailer];
GO
IF OBJECT_ID('U_EASCCONMID_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_PEarHist];
GO
IF OBJECT_ID('U_EASCCONMID_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_PDedHist];
GO
IF OBJECT_ID('U_EASCCONMID_Header') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_Header];
GO
IF OBJECT_ID('U_EASCCONMID_File') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_File];
GO
IF OBJECT_ID('U_EASCCONMID_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_EEList];
GO
IF OBJECT_ID('U_EASCCONMID_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_drvTbl];
GO
IF OBJECT_ID('U_EASCCONMID_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASCCONMID_DedList];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EASCCONMID','Ascensus 401k Cont Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EASCCONMIDZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASCCONMIDZ0','3','H','01','1',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASCCONMIDZ0','2','H','01','4',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASCCONMIDZ0','11','H','01','6',NULL,NULL,NULL,NULL,'"Soc. Sec #"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASCCONMIDZ0','1','H','01','17',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASCCONMIDZ0','20','H','01','18',NULL,NULL,NULL,NULL,'"Last Name"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASCCONMIDZ0','1','H','01','38',NULL,NULL,NULL,NULL,'"MI"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASCCONMIDZ0','1','H','01','39',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASCCONMIDZ0','15','H','01','40',NULL,NULL,NULL,NULL,'"First Name"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASCCONMIDZ0','12','H','01','55',NULL,NULL,NULL,NULL,'"Pay Period Gross Compensation"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASCCONMIDZ0','12','H','01','67',NULL,NULL,NULL,NULL,'"YTD Gross Compensation"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASCCONMIDZ0','12','H','01','79',NULL,NULL,NULL,NULL,'"Hours "','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASCCONMIDZ0','12','H','01','91',NULL,NULL,NULL,NULL,'"EE Contribution"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASCCONMIDZ0','12','H','01','103',NULL,NULL,NULL,NULL,'"ER Match"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASCCONMIDZ0','12','H','01','115',NULL,NULL,NULL,NULL,'"Profit Sharing"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASCCONMIDZ0','12','H','01','127',NULL,NULL,NULL,NULL,'"Specific-Contribution"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EASCCONMIDZ0','12','H','01','139',NULL,NULL,NULL,NULL,'"Specific-Contribution"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EASCCONMIDZ0','12','H','01','151',NULL,NULL,NULL,NULL,'"Specific-Contribution"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EASCCONMIDZ0','12','H','01','163',NULL,NULL,NULL,NULL,'"Loan 1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EASCCONMIDZ0','12','H','01','175',NULL,NULL,NULL,NULL,'"Loan 2"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EASCCONMIDZ0','12','H','01','187',NULL,NULL,NULL,NULL,'"Loan 3"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EASCCONMIDZ0','12','H','01','199',NULL,NULL,NULL,NULL,'"Loan 4"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EASCCONMIDZ0','12','H','01','211',NULL,NULL,NULL,NULL,'"Loan 5"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASCCONMIDZ0','5','H','02','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASCCONMIDZ0','12','H','02','6',NULL,NULL,NULL,NULL,'"drvCont"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASCCONMIDZ0','20','H','02','18',NULL,NULL,NULL,NULL,'"drvClientNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASCCONMIDZ0','2','H','02','38',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASCCONMIDZ0','15','H','02','40',NULL,NULL,NULL,NULL,'"drvClientName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASCCONMIDZ0','12','H','02','55',NULL,NULL,NULL,NULL,'"drvSiteCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASCCONMIDZ0','12','H','02','67',NULL,NULL,NULL,NULL,'"drvPayrollBeginDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASCCONMIDZ0','12','H','02','79',NULL,NULL,NULL,NULL,'"drvPayrollEndDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASCCONMIDZ0','12','H','02','91',NULL,NULL,NULL,NULL,'"drvPayrollEffectiveDate"','(''UDMDY''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASCCONMIDZ0','120','H','02','103',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASCCONMIDZ0','3','D','10','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASCCONMIDZ0','2','D','10','4',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASCCONMIDZ0','11','D','10','6',NULL,NULL,NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASCCONMIDZ0','1','D','10','17',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASCCONMIDZ0','20','D','10','18',NULL,NULL,NULL,NULL,'"drvNameLast"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASCCONMIDZ0','1','D','10','38',NULL,NULL,NULL,NULL,'"drvNameMiddle"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASCCONMIDZ0','1','D','10','39',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASCCONMIDZ0','15','D','10','40',NULL,NULL,NULL,NULL,'"drvNameFirst"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASCCONMIDZ0','12','D','10','55',NULL,NULL,NULL,NULL,'"drvPayPerGrossComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASCCONMIDZ0','12','D','10','67',NULL,NULL,NULL,NULL,'"drvGrossYTDComp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASCCONMIDZ0','12','D','10','79',NULL,NULL,NULL,NULL,'"drvPayPerHours"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASCCONMIDZ0','12','D','10','91',NULL,NULL,NULL,NULL,'"drvEmp401Contrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASCCONMIDZ0','12','D','10','103',NULL,NULL,NULL,NULL,'"drvEmprMatchContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASCCONMIDZ0','12','D','10','115',NULL,NULL,NULL,NULL,'"drvProfitShareContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASCCONMIDZ0','12','D','10','127',NULL,NULL,NULL,NULL,'"drvRothContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EASCCONMIDZ0','12','D','10','139',NULL,NULL,NULL,NULL,'"drvClientDataFld1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EASCCONMIDZ0','12','D','10','151',NULL,NULL,NULL,NULL,'"drvClientDataFld2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EASCCONMIDZ0','12','D','10','163',NULL,NULL,NULL,NULL,'"drvLoanPay1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EASCCONMIDZ0','12','D','10','175',NULL,NULL,NULL,NULL,'"drvLoanPay2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EASCCONMIDZ0','12','D','10','187',NULL,NULL,NULL,NULL,'"drvLoanPay3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EASCCONMIDZ0','12','D','10','199',NULL,NULL,NULL,NULL,'"drvLoanPay4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EASCCONMIDZ0','12','D','10','211',NULL,NULL,NULL,NULL,'"drvLoanPay5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EASCCONMIDZ0','3','T','90','1',NULL,NULL,NULL,NULL,'"drvRecordType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EASCCONMIDZ0','2','T','90','4',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EASCCONMIDZ0','7','T','90','6',NULL,NULL,NULL,NULL,'"drvDetailRecCnt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EASCCONMIDZ0','42','T','90','13',NULL,NULL,NULL,NULL,'"filler"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EASCCONMIDZ0','12','T','90','55',NULL,NULL,NULL,NULL,'"drvPayPerGrossCompTot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EASCCONMIDZ0','12','T','90','67',NULL,NULL,NULL,NULL,'"drvGrossYTDCompTot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EASCCONMIDZ0','12','T','90','79',NULL,NULL,NULL,NULL,'"drvPayPerHoursTot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EASCCONMIDZ0','12','T','90','91',NULL,NULL,NULL,NULL,'"drvEmp401ContribTot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EASCCONMIDZ0','12','T','90','103',NULL,NULL,NULL,NULL,'"drvEmprMatchContribTot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EASCCONMIDZ0','12','T','90','115',NULL,NULL,NULL,NULL,'"drvProfitShareContribTot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EASCCONMIDZ0','12','T','90','127',NULL,NULL,NULL,NULL,'"drvRothContribTot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EASCCONMIDZ0','12','T','90','139',NULL,NULL,NULL,NULL,'"drvClientDataFld1Tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EASCCONMIDZ0','12','T','90','151',NULL,NULL,NULL,NULL,'"drvClientDataFld2Tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EASCCONMIDZ0','12','T','90','163',NULL,NULL,NULL,NULL,'"drvLoanPay1Tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EASCCONMIDZ0','12','T','90','175',NULL,NULL,NULL,NULL,'"drvLoanPay2Tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EASCCONMIDZ0','12','T','90','187',NULL,NULL,NULL,NULL,'"drvLoanPay3Tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EASCCONMIDZ0','12','T','90','199',NULL,NULL,NULL,NULL,'"drvLoanPay4Tot"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EASCCONMIDZ0','12','T','90','211',NULL,NULL,NULL,NULL,'"drvLoanPay5Tot"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EASCCONMID_20220215.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ascensus 401k Cont Export','201710269','EMPEXPORT','EASCCONMID',NULL,'EASCCONMID',NULL,NULL,NULL,'201710269','Oct 26 2017 11:07AM','Oct 26 2017 11:07AM','201710261',NULL,'','','201710261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','ZCBOZ',NULL,NULL,NULL,'Test Purposes Only','202110211','EMPEXPORT','TEST','Nov 12 2021  3:45PM','EASCCONMID',NULL,NULL,NULL,'202110211','Oct 21 2021 12:00AM','Oct 16 2021 12:00AM','202110211','209','','','202110211',dbo.fn_GetTimedKey(),NULL,'us3rVaMID1020',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONMID','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONMID','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONMID','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONMID','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONMID','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASCCONMID','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONMID','H01','None','Ignore');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONMID','H02','dbo.U_EASCCONMID_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONMID','D10','dbo.U_EASCCONMID_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASCCONMID','T90','dbo.U_EASCCONMID_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EASCCONMID_DedList
-----------

IF OBJECT_ID('U_EASCCONMID_DedList') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EASCCONMID_drvTbl
-----------

IF OBJECT_ID('U_EASCCONMID_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRecordType] varchar(3) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvPayPerGrossComp] varchar(24) NULL,
    [drvGrossYTDComp] varchar(24) NULL,
    [drvPayPerHours] varchar(24) NULL,
    [drvEmp401Contrib] varchar(24) NULL,
    [drvEmprMatchContrib] varchar(24) NULL,
    [drvProfitShareContrib] varchar(24) NULL,
    [drvRothContrib] varchar(24) NULL,
    [drvClientDataFld1] varchar(1) NOT NULL,
    [drvClientDataFld2] varchar(1) NOT NULL,
    [drvLoanPay1] varchar(24) NULL,
    [drvLoanPay2] varchar(24) NULL,
    [drvLoanPay3] varchar(24) NULL,
    [drvLoanPay4] varchar(24) NULL,
    [drvLoanPay5] varchar(24) NULL
);

-----------
-- Create table U_EASCCONMID_EEList
-----------

IF OBJECT_ID('U_EASCCONMID_EEList') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EASCCONMID_File
-----------

IF OBJECT_ID('U_EASCCONMID_File') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);

-----------
-- Create table U_EASCCONMID_Header
-----------

IF OBJECT_ID('U_EASCCONMID_Header') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_Header] (
    [drvRecordType] varchar(3) NOT NULL,
    [drvCont] varchar(12) NOT NULL,
    [drvClientNo] varchar(6) NULL,
    [drvClientName] varchar(15) NULL,
    [drvSiteCode] varchar(1) NOT NULL,
    [drvPayrollBeginDate] datetime NULL,
    [drvPayrollEndDate] datetime NULL,
    [drvPayrollEffectiveDate] varchar(1) NOT NULL
);

-----------
-- Create table U_EASCCONMID_PDedHist
-----------

IF OBJECT_ID('U_EASCCONMID_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhPerControl] varchar(8) NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);

-----------
-- Create table U_EASCCONMID_PEarHist
-----------

IF OBJECT_ID('U_EASCCONMID_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCOID] char(5) NOT NULL,
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

-----------
-- Create table U_EASCCONMID_Trailer
-----------

IF OBJECT_ID('U_EASCCONMID_Trailer') IS NULL
CREATE TABLE [dbo].[U_EASCCONMID_Trailer] (
    [drvRecordType] varchar(3) NOT NULL,
    [drvDetailRecCnt] int NULL,
    [drvPayPerGrossCompTot] varchar(24) NULL,
    [drvGrossYTDCompTot] varchar(24) NULL,
    [drvPayPerHoursTot] varchar(24) NULL,
    [drvEmp401ContribTot] varchar(24) NULL,
    [drvEmprMatchContribTot] varchar(24) NULL,
    [drvProfitShareContribTot] int NOT NULL,
    [drvRothContribTot] varchar(24) NULL,
    [drvClientDataFld1Tot] int NOT NULL,
    [drvClientDataFld2Tot] int NOT NULL,
    [drvLoanPay1Tot] varchar(24) NULL,
    [drvLoanPay2Tot] varchar(24) NULL,
    [drvLoanPay3Tot] varchar(24) NULL,
    [drvLoanPay4Tot] money NULL,
    [drvLoanPay5Tot] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASCCONMID]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name:        Midwest Industrial

Created By:             Justin Sheppard
Business Analyst:         Justin Sheppard
Create Date:             01/07/2020
Service Request Number: XXX

Purpose: Ascensus 401k Cont Export

Revision History
----------------
10/22/2021 by AP:
        - Added ERPRO deduction code.

11/10/2021 by AP:
        - Adjusted profit sharing field.

02/15/2022 by AP:
		- Confirmed that EPRO is populating for columns 115-126 on the contribution file.
		- Adjusted LoanPay4 amount to pre-update logic.
		- Adjusted trailer record for drvProfitShareContrib.


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASCCONMID';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASCCONMID';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASCCONMID';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASCCONMID';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASCCONMID' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONMID', 'EASCCONMID';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASCCONMID', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EASCCONMID', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@ClientNumber        VARCHAR(6)
            ,@ClientName         VARCHAR(15);

    -- Set FormatCode
    SELECT @FormatCode = 'EASCCONMID';
    SELECT @ClientNumber = '217771';
    SELECT @ClientName = 'MIDWEST';

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
    --Exclude Contractors and Interns
    DELETE dbo.U_EASCCONMID_EEList
    FROM dbo.U_EASCCONMID_EEList
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = xEEID and EecCOID = xCOID
    WHERE eecEEType in ('CON')


    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    --DELETE FROM dbo.U_EASCCONMID_EEList
    --WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID);
    --AND xEEID IN (SELECT xEEID FROM dbo.U_EASCCONMID_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================

    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401KF,401KP,R401F,R401P,ER401,401L,401L2,401L3,ERPRO';

    IF OBJECT_ID('U_EASCCONMID_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONMID_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASCCONMID_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables 
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EASCCONMID_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONMID_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhPerControl  = LEFT(PdhPerControl,8)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401KF','401KP') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('R401F','R401P') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('ER401') THEN PdhERCurAmt ELSE 0.00 END)
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('xxx','xxx') THEN PdhEECurAmt ELSE 0.00 END)
        --,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401L') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401L2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401L3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('ERPRO') THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('XXX') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
     INTO dbo.U_EASCCONMID_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EASCCONMID_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE PdhPerControl between @StartPerControl and @EndPerControl
    GROUP BY PdhEEID, PdhCOID, LEFT(PdhPerControl,8)
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EASCCONMID_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONMID_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehCOID
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
    INTO dbo.U_EASCCONMID_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    --AND PehEarnCode NOT IN ('HSAER','FLXRE','CAR')
    GROUP BY PehEEID,PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EASCCONMID_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EASCCONMID_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONMID_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'DTL'
        ,drvSSN                 = eepSSN
        ,drvNameLast             = EepNameLast
        ,drvNameMiddle             = LEFT(EepNameMiddle,1)
        ,drvNameFirst             = EepNameFirst
        ,drvPayPerGrossComp     = dbo.dsi_fnPadZero(PehCurAmt,12,2)
        ,drvGrossYTDComp         = dbo.dsi_fnPadZero(PehCurAmtYTD,12,2)
        ,drvPayPerHours         = dbo.dsi_fnPadZero(PehCurHrs,12,2)
        ,drvEmp401Contrib         = dbo.dsi_fnPadZero(PdhSource1+PdhSource4,12,2)
        ,drvEmprMatchContrib     = dbo.dsi_fnPadZero(PdhSource3,12,2)
        ,drvProfitShareContrib     = dbo.dsi_fnPadZero(PdhSource9, 12,2)
        ,drvRothContrib         = dbo.dsi_fnPadZero(PdhSource2,12,2)
        ,drvClientDataFld1         = ''
        ,drvClientDataFld2         = ''
        ,drvLoanPay1             = dbo.dsi_fnPadZero(PdhSource6,12,2)
        ,drvLoanPay2             = dbo.dsi_fnPadZero(PdhSource7,12,2)
        ,drvLoanPay3             = dbo.dsi_fnPadZero(PdhSource8,12,2)
        ,drvLoanPay4             = dbo.dsi_fnPadZero(PdhSource10,12,2)  -- Backup production file uses 'XXX' dedcode for pdh
		--dbo.dsi_fnPadZero(PdhSource9,12,2)
        ,drvLoanPay5             = dbo.dsi_fnPadZero(PdhSource10,12,2)
    INTO dbo.U_EASCCONMID_drvTbl
    FROM dbo.U_EASCCONMID_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID and Eeccoid = xcoid
    LEFT JOIN dbo.U_EASCCONMID_PEarHist on xeeid = Peheeid and xcoid = Pehcoid
    LEFT JOIN dbo.U_EASCCONMID_PDedHist on xeeid = Pdheeid and xcoid = Pdhcoid 
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASCCONMID_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONMID_Header;
    SELECT DISTINCT
         drvRecordType                 = 'HDR'
        ,drvCont                     = 'Contribution'
        ,drvClientNo                 = @ClientNumber
        ,drvClientName                 = @ClientName
        ,drvSiteCode                 = 'A' 
        ,drvPayrollBeginDate         = @StartDate
        ,drvPayrollEndDate             = @EndDate
        ,drvPayrollEffectiveDate     = ''
    INTO dbo.U_EASCCONMID_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASCCONMID_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EASCCONMID_Trailer;
    SELECT DISTINCT
         drvRecordType                = 'TOT'
        ,drvDetailRecCnt             = dtlcount
        ,drvPayPerGrossCompTot         = dbo.dsi_fnPadZero(ppsal,12,2)
        ,drvGrossYTDCompTot         = dbo.dsi_fnPadZero(ssal,12,2)
        ,drvPayPerHoursTot             = dbo.dsi_fnPadZero(thrs,12,0)
        ,drvEmp401ContribTot         = dbo.dsi_fnPadZero(fsal,12,2)
        ,drvEmprMatchContribTot     = dbo.dsi_fnPadZero(msal,12,2)
        ,drvProfitShareContribTot     = dbo.dsi_fnPadZero(psct,12,2)
        ,drvRothContribTot             = dbo.dsi_fnPadZero(rsal,12,2)
        ,drvClientDataFld1Tot         = 0
        ,drvClientDataFld2Tot         = 0
        ,drvLoanPay1Tot             = dbo.dsi_fnPadZero(l1sal,12,2)
        ,drvLoanPay2Tot             = dbo.dsi_fnPadZero(l2sal,12,2)
        ,drvLoanPay3Tot             = dbo.dsi_fnPadZero(l3sal,12,2)
        ,drvLoanPay4Tot             = l4sal
        ,drvLoanPay5Tot             = l5sal
    INTO dbo.U_EASCCONMID_Trailer
    FROM (select count(*) dtlcount,
            sum(cast(drvPayPerGrossComp as money)) ppsal, sum(cast(drvGrossYTDComp as money)) ssal,
            sum(cast(drvPayPerHours as money)) thrs, sum(cast(drvEmp401Contrib as money)) fsal,
            sum(cast(drvEmprMatchContrib as money)) msal, sum(cast(drvRothContrib as money)) rsal,
            sum(cast(drvLoanPay1 as money)) l1sal, sum(cast(drvLoanPay2 as money)) l2sal,
            sum(cast(drvLoanPay3 as money)) l3sal, sum(cast(drvLoanPay4 as money)) l4sal,
            sum(cast(drvLoanPay5 as money)) l5sal, sum(cast(drvProfitShareContrib as money)) psct
        from dbo.U_EASCCONMID_drvTbl ) cnt;
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_AscContBridge_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_AscContBridge_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'AscContBridge_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEASCCONMID_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EASCCONMID_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASCCONMID%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201710191'
       ,expStartPerControl     = '201710191'
       ,expLastEndPerControl   = '201710269'
       ,expEndPerControl       = '201710269'
WHERE expFormatCode = 'EASCCONMID';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASCCONMID_Export AS
    SELECT TOP 200000000 Data FROM dbo.U_EASCCONMID_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EASCCONMID' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EASCCONMID'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EASCCONMID'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASCCONMID', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EASCCONMID', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EASCCONMID', 'UseFileName', 'V', 'Y'


-- End ripout