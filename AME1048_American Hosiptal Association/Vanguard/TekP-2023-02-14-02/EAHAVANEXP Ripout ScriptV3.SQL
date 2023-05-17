/**********************************************************************************

EAHAVANEXP: Vanguard 401K Export

FormatCode:     EAHAVANEXP
Project:        Vanguard 401K Export
Client ID:      AME1048
Date/time:      2023-05-16 09:36:14.277
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP2DB01
Database:       ULTIPRO_WPAHA
Web Filename:   AME1048_72359_EEHISTORY_EAHAVANEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EAHAVANEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EAHAVANEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EAHAVANEXP'


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
WHERE FormatCode = 'EAHAVANEXP'
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
WHERE ExpFormatCode = 'EAHAVANEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EAHAVANEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EAHAVANEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EAHAVANEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EAHAVANEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EAHAVANEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EAHAVANEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EAHAVANEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EAHAVANEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EAHAVANEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EAHAVANEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEAHAVANEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAHAVANEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAHAVANEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAHAVANEXP];
GO
IF OBJECT_ID('U_EAHAVANEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_Trailer];
GO
IF OBJECT_ID('U_EAHAVANEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_PEarHist];
GO
IF OBJECT_ID('U_EAHAVANEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_PDedHist];
GO
IF OBJECT_ID('U_EAHAVANEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_Header];
GO
IF OBJECT_ID('U_EAHAVANEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_File];
GO
IF OBJECT_ID('U_EAHAVANEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_EEList];
GO
IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Record') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_drvTbl_Record];
GO
IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Participant') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_drvTbl_Participant];
GO
IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Loans') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_drvTbl_Loans];
GO
IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Hours') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_drvTbl_Hours];
GO
IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Email') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_drvTbl_Email];
GO
IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Contribution') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_drvTbl_Contribution];
GO
IF OBJECT_ID('U_EAHAVANEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAHAVANEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EAHAVANEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAHAVANEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAHAVANEXP','Vanguard 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EAHAVANEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','11','H','01','1',NULL,'Header Zeroes',NULL,NULL,'"00000000000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','3','H','01','2',NULL,'Header Indicator',NULL,NULL,'"HDR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','8','H','01','3',NULL,'Format',NULL,NULL,'"drvFormat"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','6','H','01','4',NULL,'Plan Number',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','8','H','01','5',NULL,'Date',NULL,NULL,'"drvDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','6','H','01','6',NULL,'Time',NULL,NULL,'"drvTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','7','H','01','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHAVANEXPZ0','31','H','01','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','6','D','10','1',NULL,'Plan Id',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','9','D','10','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','3','D','10','3',NULL,'Record Type',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','22','D','10','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','30','D','10','5',NULL,'Name',NULL,NULL,'"drvName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','2','D','10','6',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','30','D','10','7',NULL,'Address Line One',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHAVANEXPZ0','30','D','10','8',NULL,'Address Line Two',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAHAVANEXPZ0','18','D','10','9',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAHAVANEXPZ0','3','D','10','10',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAHAVANEXPZ0','9','D','10','11',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAHAVANEXPZ0','1','D','10','12',NULL,'Foreign Address Flag',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAHAVANEXPZ0','13','D','10','13',NULL,'Employee Number',NULL,NULL,'"drvEmpNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAHAVANEXPZ0','4','D','10','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAHAVANEXPZ0','10','D','10','15',NULL,'Location',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAHAVANEXPZ0','8','D','10','16',NULL,'Birth Date',NULL,NULL,'"drvDateofBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAHAVANEXPZ0','8','D','10','17',NULL,'Employment Date',NULL,NULL,'"drvEmploymentDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAHAVANEXPZ0','8','D','10','18',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAHAVANEXPZ0','8','D','10','19',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAHAVANEXPZ0','8','D','10','20',NULL,'Alternate Vesting Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAHAVANEXPZ0','8','D','10','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAHAVANEXPZ0','8','D','10','22',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAHAVANEXPZ0','1','D','10','23',NULL,'Termination Reason Code',NULL,NULL,'"drvTerminationReasonCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAHAVANEXPZ0','1','D','10','24',NULL,'Send Kit Indicator',NULL,NULL,'"drvSendKitIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAHAVANEXPZ0','8','D','10','25',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EAHAVANEXPZ0','4','D','10','26',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EAHAVANEXPZ0','1','D','10','27',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EAHAVANEXPZ0','2','D','10','28',NULL,'Payroll Freq For Loan Amortization',NULL,NULL,'"6"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EAHAVANEXPZ0','34','D','10','29',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EAHAVANEXPZ0','10','D','10','30',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EAHAVANEXPZ0','10','D','10','31',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EAHAVANEXPZ0','1','D','10','32',NULL,'Highly Compensated Flag',NULL,NULL,'"drvHighlyCompFlag"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EAHAVANEXPZ0','8','D','10','33',NULL,'Effective Date',NULL,NULL,'"drvEffectiveDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EAHAVANEXPZ0','24','D','10','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EAHAVANEXPZ0','8','D','10','35',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EAHAVANEXPZ0','1','D','10','36',NULL,'Change Type',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EAHAVANEXPZ0','8','D','10','37',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EAHAVANEXPZ0','1','D','10','38',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EAHAVANEXPZ0','1','D','10','39',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EAHAVANEXPZ0','3','D','10','40',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EAHAVANEXPZ0','30','D','10','41',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EAHAVANEXPZ0','3','D','10','42',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EAHAVANEXPZ0','30','D','10','43',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EAHAVANEXPZ0','24','D','10','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EAHAVANEXPZ0','3','D','10','45',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EAHAVANEXPZ0','30','D','10','46',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EAHAVANEXPZ0','3','D','10','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EAHAVANEXPZ0','30','D','10','48',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EAHAVANEXPZ0','5','D','10','49',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EAHAVANEXPZ0','7','D','10','50',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EAHAVANEXPZ0','1','D','10','51',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EAHAVANEXPZ0','1','D','10','52',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EAHAVANEXPZ0','1','D','10','53',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EAHAVANEXPZ0','1','D','10','54',NULL,'Gender Code',NULL,NULL,'"drvGender "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EAHAVANEXPZ0','8','D','10','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EAHAVANEXPZ0','8','D','10','56',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EAHAVANEXPZ0','2','D','10','57',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EAHAVANEXPZ0','9','D','10','58',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EAHAVANEXPZ0','1','D','10','59',NULL,'LOA Type',NULL,NULL,'"drvLOAType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EAHAVANEXPZ0','8','D','10','60',NULL,'LOA Begin Date',NULL,NULL,'"drvLOABeginDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EAHAVANEXPZ0','8','D','10','61',NULL,'LOA End Date',NULL,NULL,'"drvLOAEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EAHAVANEXPZ0','8','D','10','62',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EAHAVANEXPZ0','1','D','10','63',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EAHAVANEXPZ0','3','D','10','64',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EAHAVANEXPZ0','30','D','10','65',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EAHAVANEXPZ0','3','D','10','66',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EAHAVANEXPZ0','30','D','10','67',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EAHAVANEXPZ0','3','D','10','68',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EAHAVANEXPZ0','30','D','10','69',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EAHAVANEXPZ0','3','D','10','70',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EAHAVANEXPZ0','30','D','10','71',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EAHAVANEXPZ0','3','D','10','72',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EAHAVANEXPZ0','30','D','10','73',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EAHAVANEXPZ0','3','D','10','74',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EAHAVANEXPZ0','30','D','10','75',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EAHAVANEXPZ0','3','D','10','76',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EAHAVANEXPZ0','30','D','10','77',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EAHAVANEXPZ0','3','D','10','78',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EAHAVANEXPZ0','30','D','10','79',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EAHAVANEXPZ0','42','D','10','80',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','6','D','20','1',NULL,'Plan Id',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','9','D','20','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','3','D','20','3',NULL,'Record Type',NULL,NULL,'"B"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','22','D','20','4',NULL,'Filler',NULL,NULL,'""','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','8','D','20','5',NULL,'Payroll End Date',NULL,NULL,'"drvPayrollEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','8','D','20','6',NULL,'PRS Override Payroll End Date',NULL,NULL,'"drvPRSOverridePayrollEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','10','D','20','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHAVANEXPZ0','4','D','20','8',NULL,'Contribution Source 1',NULL,NULL,'"drvContributionSource1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAHAVANEXPZ0','10','D','20','9',NULL,'Contribution Amount 1',NULL,NULL,'"drvContributionAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAHAVANEXPZ0','10','D','20','10',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAHAVANEXPZ0','4','D','20','11',NULL,'Contribution Source 2',NULL,NULL,'"drvContributionSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAHAVANEXPZ0','10','D','20','12',NULL,'Contribution Amount 2',NULL,NULL,'"drvContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAHAVANEXPZ0','10','D','20','13',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAHAVANEXPZ0','4','D','20','14',NULL,'Contribution Source 3',NULL,NULL,'"drvContributionSource3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAHAVANEXPZ0','10','D','20','15',NULL,'Contribution Amount 3',NULL,NULL,'"drvContributionAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAHAVANEXPZ0','10','D','20','16',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAHAVANEXPZ0','4','D','20','17',NULL,'Contribution Source 4',NULL,NULL,'"drvContributionSource4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAHAVANEXPZ0','10','D','20','18',NULL,'Contribution Amount 4',NULL,NULL,'"drvContributionAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAHAVANEXPZ0','10','D','20','19',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAHAVANEXPZ0','4','D','20','20',NULL,'Contribution Source 5',NULL,NULL,'"drvContributionSource5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAHAVANEXPZ0','10','D','20','21',NULL,'Contribution Amount 5',NULL,NULL,'"drvContributionAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EAHAVANEXPZ0','10','D','20','22',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EAHAVANEXPZ0','4','D','20','23',NULL,'Contribution Source 6',NULL,NULL,'"drvContributionSource6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EAHAVANEXPZ0','10','D','20','24',NULL,'Contribution Amount 6',NULL,NULL,'"drvContributionAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EAHAVANEXPZ0','610','D','20','25',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','6','D','30','1',NULL,'Plan Id',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','9','D','30','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','3','D','30','3',NULL,'Record Type',NULL,NULL,'"C"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','22','D','30','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','88','D','30','5',NULL,'Contribution Source 1',NULL,NULL,'"drvContributionSource1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','1','D','30','6',NULL,'Contribution Total Amount 1',NULL,NULL,'"drvContributionTotalAmt1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','1','D','30','7',NULL,'Contribution Source 2',NULL,NULL,'"drvContributionSource2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHAVANEXPZ0','1','D','30','8',NULL,'Contribution Amount 2',NULL,NULL,'"drvContributionAmount2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAHAVANEXPZ0','1','D','30','9',NULL,'Contribution Source 3',NULL,NULL,'"drvContributionSource3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAHAVANEXPZ0','1','D','30','10',NULL,'Contribution Amount 3',NULL,NULL,'"drvContributionAmount3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAHAVANEXPZ0','1','D','30','11',NULL,'Contribution Source 4',NULL,NULL,'"drvContributionSource4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAHAVANEXPZ0','1','D','30','12',NULL,'Contribution Amount 4',NULL,NULL,'"drvContributionAmount4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAHAVANEXPZ0','1','D','30','13',NULL,'Contribution Source 5',NULL,NULL,'"drvContributionSource5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAHAVANEXPZ0','1','D','30','14',NULL,'Contribution Amount 5',NULL,NULL,'"drvContributionAmount5"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EAHAVANEXPZ0','1','D','30','15',NULL,'Contribution Source 6',NULL,NULL,'"drvContributionSource6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EAHAVANEXPZ0','1','D','30','16',NULL,'Contribution Amount 6',NULL,NULL,'"drvContributionAmount6"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EAHAVANEXPZ0','251','D','30','17',NULL,'Unused Contribution Sources',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EAHAVANEXPZ0','4','D','30','18',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EAHAVANEXPZ0','10','D','30','19',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EAHAVANEXPZ0','1','D','30','20',NULL,'Pretax Limit Override',NULL,NULL,'"1"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EAHAVANEXPZ0','109','D','30','21',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','6','D','40','1',NULL,'Plan Id',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','9','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','3','D','40','3',NULL,'Record Type',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','22','D','40','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','3','D','40','5',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','8','D','40','6',NULL,'Payroll End Date 1',NULL,NULL,'"drvPayrollEndr8"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','10','D','40','7',NULL,'Payment Amount 1',NULL,NULL,'"drvPaymentAmount1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHAVANEXPZ0','210','D','40','8',NULL,'Loan Number Payroll End DatePayment',NULL,NULL,'"drvLoanEndPn2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAHAVANEXPZ0','3','D','40','9',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAHAVANEXPZ0','8','D','40','10',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAHAVANEXPZ0','10','D','40','11',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAHAVANEXPZ0','268','D','40','12',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','6','D','50','1',NULL,'Plan Id',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','9','D','50','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','3','D','50','3',NULL,'Record Type',NULL,NULL,'"K"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','22','D','50','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','4','D','50','5',NULL,'Source Code',NULL,NULL,'"AA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','4','D','50','6',NULL,'Process Code',NULL,NULL,'"VMAP"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','2','D','50','7',NULL,'Frequency',NULL,NULL,'"01"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHAVANEXPZ0','2','D','50','8',NULL,'Compensation Code',NULL,NULL,'"LP"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EAHAVANEXPZ0','8','D','50','9',NULL,'Payroll Start Date',NULL,NULL,'"drvPayrollStartDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EAHAVANEXPZ0','8','D','50','10',NULL,'Payroll End Date',NULL,NULL,'"drvPayrollEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EAHAVANEXPZ0','13','D','50','11',NULL,'Compensation/Hours Amount',NULL,NULL,'"drvCompHoursAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EAHAVANEXPZ0','1','D','50','12',NULL,'Trailing Sign',NULL,NULL,'"+"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EAHAVANEXPZ0','17','D','50','13',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EAHAVANEXPZ0','101','D','50','14',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','6','D','60','1',NULL,'Plan Id',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','9','D','60','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','3','D','60','3',NULL,'Record Type',NULL,NULL,'"X"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','22','D','60','4',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','140','D','60','5',NULL,'Work Email Address',NULL,NULL,'"drvWorkEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','140','D','60','6',NULL,'Personal Email Address',NULL,NULL,'"drvPersonalEmail"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','140','D','60','7',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EAHAVANEXPZ0','40','D','60','8',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EAHAVANEXPZ0','11','T','90','1',NULL,'Trailer Nines',NULL,NULL,'"99999999999"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EAHAVANEXPZ0','4','T','90','2',NULL,'Trailer Indicator',NULL,NULL,'"TRLR"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EAHAVANEXPZ0','6','T','90','3',NULL,'Plan Number',NULL,NULL,'"093552"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EAHAVANEXPZ0','8','T','90','4',NULL,'Date',NULL,NULL,'"drvDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EAHAVANEXPZ0','6','T','90','5',NULL,'Time',NULL,NULL,'"drvTime"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EAHAVANEXPZ0','10','T','90','6',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EAHAVANEXPZ0','35','T','90','7',NULL,'Filler',NULL,NULL,'"093552"','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EAHAVANEXP_20230516.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',0UZKN',NULL,NULL,NULL,'Vanguard 401K Export On Demand','202304199','EMPEXPORT','ONDEM_XOE',NULL,'EAHAVANEXP',NULL,NULL,NULL,'202304199','Apr 11 2023  2:45PM','Apr 11 2023  2:45PM','202304041',NULL,'','','202304041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',0UZKN',NULL,NULL,NULL,'Vanguard 401K Export-Sched','202304199','EMPEXPORT','SCH_EAHAVA',NULL,'EAHAVANEXP',NULL,NULL,NULL,'202304199','Apr 11 2023  2:45PM','Apr 11 2023  2:45PM','202304041',NULL,'','','202304041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',0UZKN',NULL,NULL,NULL,'Vanguard 401K Export-Test','202304211','EMPEXPORT','TEST_XOE','May 16 2023 12:00AM','EAHAVANEXP',NULL,NULL,NULL,'202304211','Apr 21 2023 12:00AM','Apr 14 2023 12:00AM','202304211',NULL,'','','202304211',dbo.fn_GetTimedKey(),NULL,'us3kEpAME1048',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHAVANEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHAVANEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHAVANEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHAVANEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHAVANEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHAVANEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAHAVANEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','H01','dbo.U_EAHAVANEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','D10','dbo.U_EAHAVANEXP_drvTbl_Record',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','D20','dbo.U_EAHAVANEXP_drvTbl_Participant',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','D30','dbo.U_EAHAVANEXP_drvTbl_Contribution',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','D40','dbo.U_EAHAVANEXP_drvTbl_Loans',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','D50','dbo.U_EAHAVANEXP_drvTbl_Hours',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','D60','dbo.U_EAHAVANEXP_drvTbl_Email',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAHAVANEXP','T90','dbo.U_EAHAVANEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EAHAVANEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EAHAVANEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAHAVANEXP] (
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
-- Create table U_EAHAVANEXP_DedList
-----------

IF OBJECT_ID('U_EAHAVANEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EAHAVANEXP_drvTbl_Contribution
-----------

IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Contribution') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_drvTbl_Contribution] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] varchar(1) NOT NULL,
    [drvContributionSource1] varchar(209) NOT NULL,
    [drvContributionTotalAmt1] varchar(1) NOT NULL,
    [drvContributionSource2] varchar(1) NOT NULL,
    [drvContributionAmount2] varchar(1) NOT NULL,
    [drvContributionSource3] varchar(1) NOT NULL,
    [drvContributionAmount3] varchar(1) NOT NULL,
    [drvContributionSource4] varchar(1) NOT NULL,
    [drvContributionAmount4] varchar(1) NOT NULL,
    [drvContributionSource5] varchar(1) NOT NULL,
    [drvContributionAmount5] varchar(1) NOT NULL,
    [drvContributionSource6] varchar(1) NOT NULL,
    [drvContributionAmount6] varchar(1) NOT NULL
);

-----------
-- Create table U_EAHAVANEXP_drvTbl_Email
-----------

IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Email') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_drvTbl_Email] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvPersonalEmail] varchar(50) NULL
);

-----------
-- Create table U_EAHAVANEXP_drvTbl_Hours
-----------

IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Hours') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_drvTbl_Hours] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPayrollStartDate] varchar(34) NULL,
    [drvPayrollEndDate] varchar(34) NULL,
    [drvCompHoursAmt] varchar(24) NULL
);

-----------
-- Create table U_EAHAVANEXP_drvTbl_Loans
-----------

IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Loans') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_drvTbl_Loans] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPayrollEndr8] varchar(30) NULL,
    [drvPaymentAmount1] varchar(25) NULL,
    [drvLoanEndPn2] varchar(1) NOT NULL
);

-----------
-- Create table U_EAHAVANEXP_drvTbl_Participant
-----------

IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Participant') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_drvTbl_Participant] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvPayrollEndDate] varchar(30) NULL,
    [drvPRSOverridePayrollEndDate] varchar(30) NULL,
    [drvContributionSource1] varchar(3) NULL,
    [drvContributionAmount1] varchar(25) NULL,
    [drvContributionSource2] varchar(3) NULL,
    [drvContributionAmount2] varchar(25) NULL,
    [drvContributionSource3] varchar(3) NULL,
    [drvContributionAmount3] varchar(25) NULL,
    [drvContributionSource4] varchar(3) NULL,
    [drvContributionAmount4] varchar(25) NULL,
    [drvContributionSource5] varchar(3) NULL,
    [drvContributionAmount5] varchar(25) NULL,
    [drvContributionSource6] varchar(3) NULL,
    [drvContributionAmount6] varchar(25) NULL
);

-----------
-- Create table U_EAHAVANEXP_drvTbl_Record
-----------

IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Record') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_drvTbl_Record] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(204) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvEmpNo] char(9) NULL,
    [drvDateofBirth] varchar(30) NULL,
    [drvEmploymentDate] varchar(30) NULL,
    [drvTerminationDate] varchar(30) NULL,
    [drvTerminationReasonCode] varchar(1) NULL,
    [drvSendKitIndicator] varchar(1) NULL,
    [drvRehireDate] varchar(30) NULL,
    [drvHighlyCompFlag] varchar(1) NOT NULL,
    [drvEffectiveDate] varchar(30) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvLOAType] varchar(1) NOT NULL,
    [drvLOABeginDate] varchar(1) NOT NULL,
    [drvLOAEndDate] varchar(1) NOT NULL
);

-----------
-- Create table U_EAHAVANEXP_EEList
-----------

IF OBJECT_ID('U_EAHAVANEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EAHAVANEXP_File
-----------

IF OBJECT_ID('U_EAHAVANEXP_File') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EAHAVANEXP_Header
-----------

IF OBJECT_ID('U_EAHAVANEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_Header] (
    [drvFormat] varchar(8) NOT NULL,
    [drvDate] varchar(8) NULL,
    [drvTime] varchar(4) NULL
);

-----------
-- Create table U_EAHAVANEXP_PDedHist
-----------

IF OBJECT_ID('U_EAHAVANEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [Pdh401P] money NULL,
    [Pdh401KA] money NULL,
    [Pdh401KC] money NULL,
    [Pdh401R] money NULL,
    [Pdh401RC] money NULL,
    [Pdh401ER] money NULL,
    [PdhLoan] money NULL
);

-----------
-- Create table U_EAHAVANEXP_PEarHist
-----------

IF OBJECT_ID('U_EAHAVANEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL
);

-----------
-- Create table U_EAHAVANEXP_Trailer
-----------

IF OBJECT_ID('U_EAHAVANEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EAHAVANEXP_Trailer] (
    [drvDate] varchar(8) NULL,
    [drvTime] varchar(4) NULL,
    [drvRecordCount] varchar(24) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAHAVANEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: American Hospital Association

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 04/11/2023
Service Request Number: TekP-2023-02-14-02 

Purpose: Vanguard 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAHAVANEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAHAVANEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAHAVANEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAHAVANEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAHAVANEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHAVANEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHAVANEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAHAVANEXP', 'SCH_EAHAVA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAHAVANEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EAHAVANEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(4);

    -- Set FormatCode
    SELECT @FormatCode = 'EAHAVANEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108),':',SPACE(0))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EAHAVANEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAHAVANEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401ER,401K1,401K2,401KA,401KC,401P,401PN,401R,401RC';

    IF OBJECT_ID('U_EAHAVANEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAHAVANEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    ----==========================================
    ---- BDM Section
    ----==========================================
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
    IF OBJECT_ID('U_EAHAVANEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,Pdh401P      = SUM(CASE WHEN PdhDedCode IN ('401P') THEN ISNULL(PdhEECurAmt,0) ELSE 0 END)
        ,Pdh401KA     = SUM(CASE WHEN PdhDedCode IN ('401KA') THEN ISNULL(PdhEECurAmt,0)  ELSE 0 END)
        ,Pdh401KC     = SUM(CASE WHEN PdhDedCode IN ('401KC') THEN ISNULL(PdhEECurAmt,0) ELSE 0 END)        
        ,Pdh401R      = SUM(CASE WHEN PdhDedCode IN ('401R') THEN ISNULL(PdhEECurAmt,0)  ELSE 0 END)
        ,Pdh401RC     = SUM(CASE WHEN PdhDedCode IN ('401RC') THEN ISNULL(PdhEECurAmt,0) ELSE 0  END)
        ,Pdh401ER     = SUM(CASE WHEN PdhDedCode IN ('401ER') THEN ISNULL(PdhERCurAmt,0)  ELSE 0 END)
        ,PdhLoan     = SUM(CASE WHEN PdhDedCode IN  ('401K1','401K2') THEN ISNULL(PdhEECurAmt,0)  ELSE 0 END)
    INTO dbo.U_EAHAVANEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAHAVANEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EAHAVANEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodEndDate       = Max(PrgPeriodEndDate)
     
    INTO dbo.U_EAHAVANEXP_PEarHist
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
    -- DETAIL RECORD - U_EAHAVANEXP_drvTbl_Record
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Record','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_drvTbl_Record;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvName = UPPER(Concat(EepNameLast,', ',EepNameFirst, ' ', Left(EepNameMiddle, 1)))
        ,drvAddressLine1 = Upper(EepAddressLine1)
        ,drvAddressLine2 = Upper(EepAddressLine2)
        ,drvCity = Upper(EepAddressCity)
        ,drvState = Upper(EepAddressState)
        ,drvZipCode = EepAddressZipCode
        ,drvEmpNo = EecEmpNo
        ,drvDateofBirth = Convert(Varchar,EepDateOfBirth, 112)
        ,drvEmploymentDate = Convert(Varchar,EecDateOfOriginalHire, 112)
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN Convert(Varchar,EecDateOfTermination , 112) END
        ,drvTerminationReasonCode = CASE When EecEmplStatus = 'T' AND EecTermReason IN ('100','101','102','103','104','105','106','107','108','110','214')  THEN '0'
                                         When EecEmplStatus = 'T' AND EecTermReason = '202'  THEN '4'
                                         When EecEmplStatus = 'T' AND EecTermReason = '109' THEN '5'
                                         When EecEmplStatus = 'T' AND EecTermReason = '203' THEN '6'
                                         When EecEmplStatus = 'T' THEN '0'
                                        END

        ,drvSendKitIndicator = CASE When EecEmplStatus = 'T' and  EecTermreason = '203' THEN '1'  
                                    When EecEmplStatus = 'T' and  EecTermreason <> '203' THEN '2' 
                                END

        ,drvRehireDate = Convert(Varchar,EecDateOfBenefitSeniority, 112)   --20230503 -update to pass EecDateOfBenefitSeniority per client request. KAE --CASE When EecDateOfOriginalHire  <> EecDateOfLastHire THEN Convert(Varchar,EecDateOfLastHire, 112) END 
        ,drvHighlyCompFlag = CASE WHEN EecIsHighlyComp  = 'Y' THEN 'Y' ELSE 'N' END
        ,drvEffectiveDate = Convert(Varchar,EecDateOfLastHire, 112)
        ,drvMaritalStatus = CASE WHEN  EepMaritalStatus  = 'S' THEN '1'
                                 When EepMaritalStatus = 'M' THEN '2'
                                 Else '0'
                                END

        ,drvGender = CASE WHEN  EepGender  = 'M' THEN '1'
                          When EepGender = 'F' THEN '2'
                        Else '0'
                    END
        ,drvLOAType = ''     --CASE When EecEmplStatus = 'L' AND EshEmplStatusReason = '207' THEN 'M' - 20230503 - Per the client, LOA are not tracked in UKG. Do not send on the file. KAE
                               --When EecEmplStatus = 'L' AND EshEmplStatusReason <> '207' THEN 'O'
                               --END

        ,drvLOABeginDate = '' --CASE When EecEmplStatus = 'L' THEN Convert(Varchar,EecEmplStatusStartDate, 112) END  - 20230503 - Per the client, LOA are not tracked in UKG. Do not send on the file. KAE
        ,drvLOAEndDate = ''  --CASE WHEN  EecEmplStatus = 'L' THEN Convert(Varchar,EshStatusStopDate, 112) END  - 20230503 - Per the client, LOA are not tracked in UKG. Do not send on the file. KAE
    INTO dbo.U_EAHAVANEXP_drvTbl_Record
    FROM dbo.U_EAHAVANEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EAHAVANEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN (
                SELECT EshEEID, EshCOID,  EshEmplStatus, EshStatusStartDate, EshStatusStopDate ,EshEmplStatusReason
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus,EshEmplStatusReason, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L') AS LOA_Dates 
                WHERE RN = 1) AS EshDates 
        ON EshEEID = xEEID 
        AND EshCOID = xCOID
    JOIN dbo.U_EAHAVANEXP_PEarHist  WITH (NOLOCK)
        ON PehEEID = XEEID
    JOIN dbo.U_EAHAVANEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
    WHERE (ISNULL(Pdh401ER,0) <> 0 or ISNULL((Pdh401RC),0) <> 0 or ISNULL(Pdh401KC,0) <> 0 or ISNULL(Pdh401KA,0)<> 0 or ISNULL(Pdh401P, 0) <> 0  or ISNULL(Pdh401R,0) <> 0)
       
    ;
   
    ---------------------------------
    -- DETAIL RECORD - U_EAHAVANEXP_drvTbl_Participant
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Participant','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_drvTbl_Participant;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvPayrollEndDate = Convert(Varchar,PrgPeriodEndDate, 112)
        ,drvPRSOverridePayrollEndDate = Convert(Varchar, PrgPayDate, 112)
        ,drvContributionSource1 = CASE WHEN ISNULL(Pdh401P,0) <> 0.00 THEN 'AAA' END
        ,drvContributionAmount1 = CASE WHEN ISNULL(Pdh401P,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401P, '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(Pdh401P,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401P, '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource2 = CASE WHEN ISNULL(Pdh401KA,0) <>  0.00 THEN 'GGG' END
        ,drvContributionAmount2 = CASE WHEN ISNULL(Pdh401KA,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KA, '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(Pdh401KA,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KA, '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource3 = CASE WHEN ISNULL(Pdh401KC,0) <>  0.00 THEN 'JJJ' END
        ,drvContributionAmount3 = CASE WHEN ISNULL(Pdh401KC,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KC, '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(Pdh401KC,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KC, '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource4 = CASE WHEN ISNULL(Pdh401R,0) <>  0.00 THEN 'NRB' END
        ,drvContributionAmount4 = CASE WHEN ISNULL(Pdh401R,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401R, '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(Pdh401R,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401R, '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource5 = CASE WHEN ISNULL(Pdh401RC,0) <>  0.00 THEN 'NRC' END
        ,drvContributionAmount5 = CASE WHEN ISNULL(Pdh401RC,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401RC, '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(Pdh401RC,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401RC, '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource6 = CASE WHEN ISNULL(Pdh401ER,0) <> 0.00  THEN 'DDD' END
        ,drvContributionAmount6 =  CASE WHEN ISNULL(Pdh401ER,0) > 0 THEN dbo.dsi_fnpadzero(Replace(Pdh401ER, '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(Pdh401ER,0) < 0 THEN dbo.dsi_fnpadzero(Replace(Pdh401ER, '.', ''), 9, 0) + '-'
                                    END    
    INTO dbo.U_EAHAVANEXP_drvTbl_Participant
    FROM dbo.U_EAHAVANEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
  LEFT JOIN dbo.U_dsi_BDM_EAHAVANEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EAHAVANEXP_PEarHist  WITH (NOLOCK)
        ON PehEEID = XEEID
    JOIN dbo.U_EAHAVANEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
   WHERE (ISNULL(Pdh401ER,0) <> 0 or ISNULL((Pdh401RC),0) <> 0 or ISNULL(Pdh401KC,0) <> 0 or ISNULL(Pdh401KA,0)<> 0 or ISNULL(Pdh401P, 0) <> 0  or ISNULL(Pdh401R,0) <> 0)
    
     ;
    ---------------------------------
    -- DETAIL RECORD - U_EAHAVANEXP_drvTbl_Contribution
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Contribution','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_drvTbl_Contribution;


       SELECT    
         drvEEID = ''
        ,drvCoID = ''
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = ''
        ,drvContributionSource1 =  Concat(drvContributionSource1 + ' ' +  Cast(drvContributionTotalAmt1 as varchar),+ '' + 
                                       drvContributionSource2 + ' ' +  Cast(drvContributionAmount2 as varchar), + '' + 
                                       drvContributionSource3 + ' ' +  Cast(drvContributionAmount3 as varchar), + '' +
                                       drvContributionSource4 + ' ' +  Cast(drvContributionAmount4 as varchar), + '' +
                                       drvContributionSource5 + ' ' +  Cast(drvContributionAmount5 as varchar), + '' +
                                       drvContributionSource6  + ' ' +  Cast(drvContributionAmount6 as varchar))
        ,drvContributionTotalAmt1 =''
        ,drvContributionSource2 = ''
        ,drvContributionAmount2 = ''
        ,drvContributionSource3 = ''
        ,drvContributionAmount3 = ''
        ,drvContributionSource4 = ''
        ,drvContributionAmount4 =''
        ,drvContributionSource5 = ''
        ,drvContributionAmount5 = ''
        ,drvContributionSource6 = ''
        ,drvContributionAmount6 = ''
   
  INTO dbo.U_EAHAVANEXP_drvTbl_Contribution 
   
   FROM (SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = ''
        ,drvContributionSource1 = CASE WHEN ISNULL(sum(Pdh401P),0)<> 0.00 THEN 'AAA' END  
        ,drvContributionTotalAmt1 = Cast(CASE WHEN ISNULL(SUm(Pdh401P),0) > 0.00 THEN dbo.dsi_fnpadzero(Replace(SUM(Pdh401P), '.', ''), 9, 0) + '+'
                                         WHEN ISNULL(sum(Pdh401P),0) < 0.00 THEN dbo.dsi_fnpadzero(Replace(sum(Pdh401P), '.', ''), 9, 0) + '-'
                                    END    as Varchar)
         ,drvContributionSource2 = CASE WHEN ISNULL(sum(Pdh401KA),0) <>  0.00 THEN 'GGG' END
        ,drvContributionAmount2 = CASE WHEN ISNULL(sum(Pdh401KA),0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(sum(Pdh401KA), '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(sum(Pdh401KA),0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(sum(Pdh401KA), '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource3 = CASE WHEN ISNULL(sum(Pdh401KC),0) <>  0.00 THEN 'JJJ' END
        ,drvContributionAmount3 = CASE WHEN ISNULL(sum(Pdh401KC),0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(sum(Pdh401KC), '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(sum(Pdh401KC),0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(sum(Pdh401KC), '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource4 = CASE WHEN ISNULL(SUM(Pdh401R),0) <>  0.00 THEN 'NRB' END
        ,drvContributionAmount4 = CASE WHEN ISNULL(SUM(Pdh401R),0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(SUM(Pdh401R), '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(SUM(Pdh401R),0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(SUM(Pdh401R), '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource5 = CASE WHEN ISNULL(SUM(Pdh401RC),0) <>  0.00 THEN 'NRC' END
        ,drvContributionAmount5 = CASE WHEN ISNULL(SUM(Pdh401RC),0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(SUM(Pdh401RC), '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(SUM(Pdh401RC),0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(SUM(Pdh401RC), '.', ''), 9, 0) + '-'
                                    END    
        ,drvContributionSource6 = CASE WHEN ISNULL(SUM(Pdh401ER),0) <> 0.00  THEN 'DDD' END
        ,drvContributionAmount6 = CASE WHEN ISNULL(SUM(Pdh401ER),0) > 0 THEN dbo.dsi_fnpadzero(Replace(SUM(Pdh401ER), '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(SUM(Pdh401ER),0) < 0 THEN dbo.dsi_fnpadzero(Replace(SUM(Pdh401ER), '.', ''), 9, 0) + '-'
                                    END    
   -- INTO dbo.U_EAHAVANEXP_drvTbl_Contribution
    FROM dbo.U_EAHAVANEXP_PEarHist  WITH (NOLOCK)
       
    JOIN dbo.U_EAHAVANEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = PehEEID
        WHERE (ISNULL(Pdh401ER,0) <> 0 or ISNULL((Pdh401RC),0) <> 0 or ISNULL(Pdh401KC,0) <> 0 or ISNULL(Pdh401KA,0)<> 0 or ISNULL(Pdh401P, 0) <> 0  or ISNULL(Pdh401R,0) <> 0)
        )a
       
 --   SELECT DISTINCT
 --        drvEEID = xEEID
 --       ,drvCoID = xCoID
 --       --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
 --       ,drvInitialSort = ''
 --       ,drvSubSort = ''
 --       -- standard fields above and additional driver fields below
 --       ,drvSSN = eepSSN
 --       ,drvContributionSource1 = CASE WHEN ISNULL(Pdh401P,0)<> 0.00 THEN 'AAA' END
 --       ,drvContributionTotalAmt1 = CASE WHEN ISNULL(Pdh401P,0) > 0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401P, '.', ''), 9, 0) + '+'
    --                                     WHEN ISNULL(Pdh401P,0) < 0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401P, '.', ''), 9, 0) + '-'
    --                                END    
 --        ,drvContributionSource2 = CASE WHEN ISNULL(Pdh401KA,0) <>  0.00 THEN 'GGG' END
 --       ,drvContributionAmount2 = CASE WHEN ISNULL(Pdh401KA,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KA, '.', ''), 9, 0) + '+'
    --                                   WHEN ISNULL(Pdh401KA,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KA, '.', ''), 9, 0) + '-'
    --                                END    
 --       ,drvContributionSource3 = CASE WHEN ISNULL(Pdh401KC,0) <>  0.00 THEN 'JJJ' END
 --       ,drvContributionAmount3 = CASE WHEN ISNULL(Pdh401KC,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KC, '.', ''), 9, 0) + '+'
    --                                   WHEN ISNULL(Pdh401KC,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401KC, '.', ''), 9, 0) + '-'
    --                                END    
 --       ,drvContributionSource4 = CASE WHEN ISNULL(Pdh401R,0) <>  0.00 THEN 'NRB' END
 --       ,drvContributionAmount4 = CASE WHEN ISNULL(Pdh401R,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401R, '.', ''), 9, 0) + '+'
    --                                   WHEN ISNULL(Pdh401R,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401R, '.', ''), 9, 0) + '-'
    --                                END    
 --       ,drvContributionSource5 = CASE WHEN ISNULL(Pdh401RC,0) <>  0.00 THEN 'NRC' END
 --       ,drvContributionAmount5 = CASE WHEN ISNULL(Pdh401RC,0) >  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401RC, '.', ''), 9, 0) + '+'
    --                                   WHEN ISNULL(Pdh401RC,0) <  0.00 THEN dbo.dsi_fnpadzero(Replace(Pdh401RC, '.', ''), 9, 0) + '-'
    --                                END    
 --       ,drvContributionSource6 = CASE WHEN ISNULL(Pdh401ER,0) <> 0.00  THEN 'DDD' END
 --       ,drvContributionAmount6 = CASE WHEN ISNULL(Pdh401ER,0) > 0 THEN dbo.dsi_fnpadzero(Replace(Pdh401ER, '.', ''), 9, 0) + '+'
    --                                   WHEN ISNULL(Pdh401ER,0) < 0 THEN dbo.dsi_fnpadzero(Replace(Pdh401ER, '.', ''), 9, 0) + '-'
    --                                END    
 --   INTO dbo.U_EAHAVANEXP_drvTbl_Contribution
 --   FROM dbo.U_EAHAVANEXP_EEList WITH (NOLOCK)
 --   JOIN dbo.EmpPers WITH (NOLOCK)
 --       ON EepEEID = xEEID
    --JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
 --       ON EecEEID = xEEID 
 --       AND EecCoID = xCoID
 --   LEFT JOIN dbo.U_dsi_BDM_EAHAVANEXP WITH (NOLOCK)
 --       ON BdmEEID = xEEID 
 --       AND BdmCoID = xCoID
    --JOIN dbo.U_EAHAVANEXP_PEarHist  WITH (NOLOCK)
 --       ON PehEEID = XEEID
    --Left JOIN dbo.U_EAHAVANEXP_PDedHist WITH (NOLOCK)
    --    ON PdhEEID = XEEID
 --       WHERE (ISNULL(Pdh401ER,0) <> 0 or ISNULL(Pdh401RC,0) <> 0 or ISNULL(Pdh401KC,0) <> 0 or ISNULL(Pdh401KA,0)<> 0 or ISNULL(Pdh401P, 0) <> 0  or ISNULL(Pdh401R,0) <> 0)
    --    AND (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO' and (ISNULL(Pdh401ER,0) <> 0 or ISNULL(Pdh401RC,0) <> 0 or ISNULL(Pdh401KC,0) <> 0 or ISNULL(Pdh401KA,0)<> 0 or ISNULL(Pdh401P, 0) <> 0 )or ISNULL(Pdh401R,0) <> 0))
    --    --and  xeeid ='8UT1SE0001T0'
    --  ; 
  
    ---------------------------------
    -- DETAIL RECORD - U_EAHAVANEXP_drvTbl_Loans
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Loans','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_drvTbl_Loans;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvPayrollEndr8 = Convert(Varchar,PrgPeriodEndDate, 112)
        ,drvPaymentAmount1 = CASE WHEN ISNULL(PdhLoan, 0) > 0 THEN dbo.dsi_fnpadzero(Replace(PdhLoan, '.', ''), 9, 0) + '+'
                                       WHEN ISNULL(PdhLoan, 0) < 0 THEN dbo.dsi_fnpadzero(Replace(PdhLoan, '.', ''), 9, 0) + '-'
                                    END    
        ,drvLoanEndPn2 = ''
      
    INTO dbo.U_EAHAVANEXP_drvTbl_Loans
    FROM dbo.U_EAHAVANEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_dsi_BDM_EAHAVANEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EAHAVANEXP_PEarHist  WITH (NOLOCK)
        ON PehEEID = XEEID
    JOIN dbo.U_EAHAVANEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
     WHERE  (ISNULL(PdhLoan, 0) <> 0)
       
    ;
    ;
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAHAVANEXP_drvTbl_Hours
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Hours','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_drvTbl_Hours;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
          ,drvPayrollStartDate = Cast(Left(@RunDate, 4)as varchar) + '0101'
        ,drvPayrollEndDate = Cast(Left(@RunDate, 4)as varchar)   + '1231'
        ,drvCompHoursAmt = Case WHEN EecPayPeriod = 'B' THEN dbo.dsi_fnpadzero(Replace((cast(EecScheduledWorkHrs * EecHourlyPayRate as decimal(16,2))* 26),'.',''),13,0) END

    INTO dbo.U_EAHAVANEXP_drvTbl_Hours
    FROM dbo.U_EAHAVANEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EAHAVANEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_EAHAVANEXP_PEarHist  WITH (NOLOCK)
        ON PehEEID = XEEID
    JOIN dbo.U_EAHAVANEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
     WHERE (ISNULL(Pdh401ER,0) <> 0 or ISNULL((Pdh401RC),0) <> 0 or ISNULL(Pdh401KC,0) <> 0 or ISNULL(Pdh401KA,0)<> 0 or ISNULL(Pdh401P, 0) <> 0  or ISNULL(Pdh401R,0) <> 0)
     ;
    ---------------------------------
    -- DETAIL RECORD - U_EAHAVANEXP_drvTbl_Email 
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_drvTbl_Email ','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_drvTbl_Email ;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
       -- ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvWorkEmail = UPPER(EepAddressEMail)
        ,drvPersonalEmail = UPPER(eepAddressEMailAlternate)
    INTO dbo.U_EAHAVANEXP_drvTbl_Email 
    FROM dbo.U_EAHAVANEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.U_dsi_BDM_EAHAVANEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EAHAVANEXP_PEarHist  WITH (NOLOCK)
        ON PehEEID = XEEID
    JOIN dbo.U_EAHAVANEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = XEEID
     WHERE (ISNULL(EepAddressEMail, '') <> '' OR ISNULL(eepAddressEMailAlternate,'') <> '') 
        AND (ISNULL(Pdh401ER,0) <> 0 or ISNULL((Pdh401RC),0) <> 0 or ISNULL(Pdh401KC,0) <> 0 or ISNULL(Pdh401KA,0)<> 0 or ISNULL(Pdh401P, 0) <> 0  or ISNULL(Pdh401R,0) <> 0)
     ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_Header;
    SELECT DISTINCT
         drvFormat = 'SFF     '
        ,drvDate = @RunDate
        ,drvTime = @RunTime
    INTO dbo.U_EAHAVANEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EAHAVANEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EAHAVANEXP_Trailer;
    SELECT DISTINCT
         drvDate = @RunDate
        ,drvTime = @RunTime
        ,drvRecordCount = dbo.dsi_fnpadzero((Select Count(*) FROM dbo.U_EAHAVANEXP_drvTbl_Email WITH (NOLOCK)) + (Select Count(*) FROM dbo.U_EAHAVANEXP_drvTbl_Hours WITH (NOLOCK)) + (Select Count(*) FROM dbo.U_EAHAVANEXP_drvTbl_Record WITH (NOLOCK))
         + (Select Count(*) FROM dbo.U_EAHAVANEXP_drvTbl_Loans WITH (NOLOCK)) + (Select Count(*) FROM dbo.U_EAHAVANEXP_drvTbl_Contribution WITH (NOLOCK)) + (Select Count(*) FROM dbo.U_EAHAVANEXP_drvTbl_Participant WITH (NOLOCK)), 10, 0)
    INTO dbo.U_EAHAVANEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEAHAVANEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAHAVANEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EAHAVANEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304041'
       ,expStartPerControl     = '202304041'
       ,expLastEndPerControl   = '202304199'
       ,expEndPerControl       = '202304199'
WHERE expFormatCode = 'EAHAVANEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAHAVANEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAHAVANEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EAHAVANEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EAHAVANEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EAHAVANEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAHAVANEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EAHAVANEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EAHAVANEXP', 'UseFileName', 'V', 'Y'


-- End ripout