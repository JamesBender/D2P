/**********************************************************************************

ESUNAMERIC: Sunlife Health Export

FormatCode:     ESUNAMERIC
Project:        Sunlife Health Export
Client ID:      USG1000
Date/time:      2021-11-30 17:08:18.277
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_YOSHI
Web Filename:   USG1000_12634_EEHISTORY_ESUNAMERIC_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESUNAMERIC_SavePath') IS NOT NULL DROP TABLE dbo.U_ESUNAMERIC_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESUNAMERIC'


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
WHERE FormatCode = 'ESUNAMERIC'
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
WHERE ExpFormatCode = 'ESUNAMERIC'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESUNAMERIC')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESUNAMERIC'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESUNAMERIC'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESUNAMERIC'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESUNAMERIC'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESUNAMERIC'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESUNAMERIC'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESUNAMERIC'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESUNAMERIC'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESUNAMERIC'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESUNAMERIC_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUNAMERIC_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNAMERIC') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNAMERIC];
GO
IF OBJECT_ID('U_ESUNAMERIC_File') IS NOT NULL DROP TABLE [dbo].[U_ESUNAMERIC_File];
GO
IF OBJECT_ID('U_ESUNAMERIC_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUNAMERIC_EEList];
GO
IF OBJECT_ID('U_ESUNAMERIC_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNAMERIC_drvTbl];
GO
IF OBJECT_ID('U_ESUNAMERIC_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESUNAMERIC_DedList];
GO
IF OBJECT_ID('U_ESUNAMERIC_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESUNAMERIC_AuditFields];
GO
IF OBJECT_ID('U_ESUNAMERIC_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESUNAMERIC_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESUNAMERIC') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESUNAMERIC];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','ESUNAMERIC','Sunlife Health Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','N','S','N','ESUNAMERICZ0','N','Jan  1 1900 12:00AM','C','N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','1','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','1',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','2','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','3','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','3',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','4','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','4',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','5','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','5',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','6','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','6',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','7','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','7',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','8','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','8',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','9','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','9',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN or Employee ID"','10','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','10',NULL,'SSN or Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Date of Birth"','11','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','11',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Eligible Salary"','12','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','12',NULL,'Benefit Eligible Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Termination Date"','13','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','13',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Termination Date"','14','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','14',NULL,'Benefit Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Day Worked"','15','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','15',NULL,'Last Day Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Basic Life Amount"','16','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','16',NULL,'Employee Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Basic AD&D Amount"','17','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','17',NULL,'Employee Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Basic Life Amount"','18','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','18',NULL,'Spouse Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Basic AD&D Amount"','19','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','19',NULL,'Spouse Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Basic Life Amount"','20','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','20',NULL,'Child Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Basic AD&D Amount"','21','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','21',NULL,'Child Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Voluntary Life Amt"','22','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','22',NULL,'Employee Voluntary Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Voluntary AD&D Amt"','23','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','23',NULL,'Employee Voluntary AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Voluntary Life Amount"','24','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','24',NULL,'Spouse Voluntary Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Voluntary AD&D Amount"','25','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','25',NULL,'Spouse Voluntary AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Voluntary Life Amount"','26','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','26',NULL,'Child Voluntary Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Voluntary AD&D Amount"','27','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','27',NULL,'Child Voluntary AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Amount"','28','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','28',NULL,'LTD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Amount"','29','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','29',NULL,'STD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Accident Amount"','30','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','30',NULL,'Employee Accident Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Accident Amount"','31','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','31',NULL,'Spouse Accident Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Accident Amount"','32','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','32',NULL,'Child Accident Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Critical Illness Amt"','33','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','33',NULL,'Employee Critical Illness Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Critical Illness Amt"','34','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','34',NULL,'Spouse Critical Illness Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Critical Illness Amount"','35','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','35',NULL,'Child Critical Illness Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hospital Indemnity"','36','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','36',NULL,'Hospital Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Cancer Indemnity"','37','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','37',NULL,'Employee Cancer Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Cancer Indemnity"','38','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','38',NULL,'Spouse Cancer Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Cancer Indemnity"','39','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','39',NULL,'Child Cancer Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status"','40','(''DA''=''T,'')','ESUNAMERICZ0','50','H','01','40',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked per week"','41','(''DA''=''T'')','ESUNAMERICZ0','50','H','01','41',NULL,'Hours Worked per week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','1','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','1',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','2','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','2',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd1"','3','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','3',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd2"','4','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','4',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','5','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','5',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','6','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','6',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','7','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','7',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','8','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','8',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','9','(''UA''=''T,'')','ESUNAMERICZ0','50','D','10','9',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','10','(''UA''=''T,'')','ESUNAMERICZ0','51','D','10','10',NULL,'SSN or Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDOB"','11','(''UD101''=''T,'')','ESUNAMERICZ0','52','D','10','11',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEligSal"','12','(''UA''=''T,'')','ESUNAMERICZ0','53','D','10','12',NULL,'Benefit Eligible Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTermDt"','13','(''UD101''=''T,'')','ESUNAMERICZ0','54','D','10','13',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenTermDt"','14','(''UD101''=''T,'')','ESUNAMERICZ0','54','D','10','14',NULL,'Benefit Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastWorked"','15','(''UD101''=''T,'')','ESUNAMERICZ0','54','D','10','15',NULL,'Last Day Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBLAmt"','16','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','16',NULL,'Employee Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBADDAmt"','17','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','17',NULL,'Employee Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','18',NULL,'Spouse Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','19',NULL,'Spouse Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','20',NULL,'Child Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','21',NULL,'Child Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpVolLifeAmt"','22','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','22',NULL,'Employee Voluntary Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpVolADDAmt"','23','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','23',NULL,'Employee Voluntary AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpoVolLifeAmt"','24','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','24',NULL,'Spouse Voluntary Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpoVolADDAmt"','25','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','25',NULL,'Spouse Voluntary AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChiVolLifeAmt"','26','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','26',NULL,'Child Voluntary Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChiVolADDAmt"','27','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','27',NULL,'Child Voluntary AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','28',NULL,'LTD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','29',NULL,'STD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','30',NULL,'Employee Accident Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','31',NULL,'Spouse Accident Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','32',NULL,'Child Accident Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','33',NULL,'Employee Critical Illness Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','34',NULL,'Spouse Critical Illness Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','35',NULL,'Child Critical Illness Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','36',NULL,'Hospital Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','37',NULL,'Employee Cancer Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','38',NULL,'Spouse Cancer Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''T,'')','ESUNAMERICZ0','54','D','10','39',NULL,'Child Cancer Indemnity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','40','(''UA''=''T,'')','ESUNAMERICZ0','54','D','10','40',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorkedPerWk"','41','(''UA''=''T'')','ESUNAMERICZ0','54','D','10','41',NULL,'Hours Worked per week',NULL,NULL);

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESUNAMERIC_20211130.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Health Export','202111309','EMPEXPORT','ONDEM_XOE',NULL,'ESUNAMERIC',NULL,NULL,NULL,'202111309','Nov 30 2021  4:07PM','Nov 30 2021  4:07PM','202111301',NULL,'','','202111301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Health Export-Sched','202111309','EMPEXPORT','SCH_ESUNAM',NULL,'ESUNAMERIC',NULL,NULL,NULL,'202111309','Nov 30 2021  4:07PM','Nov 30 2021  4:07PM','202111301',NULL,'','','202111301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sunlife Health Export-Test','202111309','EMPEXPORT','TEST_XOE',NULL,'ESUNAMERIC',NULL,NULL,NULL,'202111309','Nov 30 2021  4:07PM','Nov 30 2021  4:07PM','202111301',NULL,'','','202111301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNAMERIC','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNAMERIC','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNAMERIC','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNAMERIC','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNAMERIC','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNAMERIC','D10','dbo.U_ESUNAMERIC_drvTbl',NULL);

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
-- Create table U_dsi_BDM_ESUNAMERIC
-----------

IF OBJECT_ID('U_dsi_BDM_ESUNAMERIC') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESUNAMERIC] (
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
-- Create table U_ESUNAMERIC_Audit
-----------

IF OBJECT_ID('U_ESUNAMERIC_Audit') IS NULL
CREATE TABLE [dbo].[U_ESUNAMERIC_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audDedCodeChange] varchar(1) NOT NULL,
    [audStatChange] varchar(1) NOT NULL
);

-----------
-- Create table U_ESUNAMERIC_AuditFields
-----------

IF OBJECT_ID('U_ESUNAMERIC_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESUNAMERIC_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESUNAMERIC_DedList
-----------

IF OBJECT_ID('U_ESUNAMERIC_DedList') IS NULL
CREATE TABLE [dbo].[U_ESUNAMERIC_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESUNAMERIC_drvTbl
-----------

IF OBJECT_ID('U_ESUNAMERIC_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNAMERIC_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvAdd1] varchar(255) NULL,
    [drvAdd2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(12) NULL,
    [drvEmail] varchar(50) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmpDOB] datetime NULL,
    [drvBenEligSal] varchar(30) NULL,
    [drvEmpTermDt] varchar(30) NOT NULL,
    [drvBenTermDt] varchar(30) NOT NULL,
    [drvLastWorked] varchar(30) NOT NULL,
    [drvEmpBLAmt] varchar(30) NULL,
    [drvEmpBADDAmt] varchar(30) NULL,
    [drvEmpVolLifeAmt] varchar(30) NULL,
    [drvEmpVolADDAmt] varchar(30) NULL,
    [drvSpoVolLifeAmt] varchar(30) NULL,
    [drvSpoVolADDAmt] varchar(30) NULL,
    [drvChiVolLifeAmt] varchar(30) NULL,
    [drvChiVolADDAmt] varchar(30) NULL,
    [drvStatus] varchar(10) NOT NULL,
    [drvHrsWorkedPerWk] varchar(5) NOT NULL
);

-----------
-- Create table U_ESUNAMERIC_EEList
-----------

IF OBJECT_ID('U_ESUNAMERIC_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUNAMERIC_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESUNAMERIC_File
-----------

IF OBJECT_ID('U_ESUNAMERIC_File') IS NULL
CREATE TABLE [dbo].[U_ESUNAMERIC_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNAMERIC]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: American Excelsior

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 11/30/2021
Service Request Number: TekP-2021-09-17-0002

Purpose: Sunlife Health Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNAMERIC';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNAMERIC';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNAMERIC';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESUNAMERIC';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNAMERIC' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNAMERIC', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNAMERIC', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNAMERIC', 'SCH_ESUNAM';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNAMERIC';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESUNAMERIC', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESUNAMERIC';

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
    DELETE FROM dbo.U_ESUNAMERIC_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNAMERIC_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

	  --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFE,SUNLA,SUNLS,SUNLC';

    IF OBJECT_ID('U_ESUNAMERIC_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESUNAMERIC_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESUNAMERIC_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_AuditFields;
    CREATE TABLE dbo.U_ESUNAMERIC_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    -- Audit Fields
    INSERT INTO dbo.U_ESUNAMERIC_AuditFields VALUES ('EmpDed', 'EedDedCode');
    INSERT INTO dbo.U_ESUNAMERIC_AuditFields VALUES ('EmpDed', 'EedBenStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESUNAMERIC_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_Audit;
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
        ,audDedCodeChange = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedDedCode' AND ISNULL(audNewValue , '') <> '' THEN 'Y' ELSE 'N' END
        ,audStatChange = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenStatus' AND ISNULL(audNewValue, '') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESUNAMERIC_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESUNAMERIC_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESUNAMERIC_Audit ON dbo.U_ESUNAMERIC_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_ESUNAMERIC_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ESUNAMERIC_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESUNAMERIC_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESUNAMERIC_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNAMERIC_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvHomePhone = SUBSTRING(EepPhoneHomeNumber, 1, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + 
                  SUBSTRING(EepPhoneHomeNumber, 7, 4)
        ,drvEmail = EepAddressEMail
        ,drvSSN = SUBSTRING(EepSSN, 1, 3)+'-'+
                    SUBSTRING(EepSSN, 4, 2)+'-'+
                    SUBSTRING(EepSSN, 6, 4) 
        ,drvEmpDOB = EepDateOfBirth
        ,drvBenEligSal = CAST(REPLACE(EecAnnSalary, '.', '') AS VARCHAR)
        ,drvEmpTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END), 101), '')
        ,drvBenTermDt = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                WHEN EedBenStatus IN ('T', 'C') THEN EedBenStopDate END), 101), '')
        ,drvLastWorked = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END), 101), '')
        ,drvEmpBLAmt = CAST(REPLACE(glife.EedBenAmt, '.', '') AS VARCHAR)
        ,drvEmpBADDAmt = CAST(REPLACE(glife.EedBenAmt, '.', '') AS VARCHAR)
        ,drvEmpVolLifeAmt = CAST(REPLACE(sunla.EedBenAmt, '.', '') AS VARCHAR)
        ,drvEmpVolADDAmt = CAST(REPLACE(sunla.EedBenAmt, '.', '') AS VARCHAR)
        ,drvSpoVolLifeAmt = CAST(REPLACE(sunls.EedBenAmt, '.', '') AS VARCHAR)
        ,drvSpoVolADDAmt = CAST(REPLACE(sunls.EedBenAmt, '.', '') AS VARCHAR)
        ,drvChiVolLifeAmt = CAST(REPLACE(sunlc.EedBenAmt, '.', '') AS VARCHAR)
        ,drvChiVolADDAmt = CAST(REPLACE(sunlc.EedBenAmt, '.', '') AS VARCHAR)
        ,drvStatus = CASE WHEN EecEmplStatus = 'T' AND EecTermReason <> '202' THEN 'Terminated'
                            WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'Retired' ELSE 'Active' END
        ,drvHrsWorkedPerWk = '40.00'
    INTO dbo.U_ESUNAMERIC_drvTbl
    FROM dbo.U_ESUNAMERIC_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.EmpDed WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EecCOID = xCOID
		AND EedDedCode IN ('GLIFE', 'SUNLA', 'SUNLS', 'SUNLC')
    JOIN dbo.U_ESUNAMERIC_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'GLIFE'
                GROUP BY EedEEID, EedCOID) glife ON glife.EedEEID = xEEID AND glife.EedCOID = xCOID
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'SUNLA'
                GROUP BY EedEEID, EedCOID) sunla ON sunla.EedEEID = xEEID AND sunla.EedCOID = xCOID    
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'SUNLS'
                GROUP BY EedEEID, EedCOID) sunls ON sunls.EedEEID = xEEID AND sunls.EedCOID = xCOID  
    LEFT JOIN (SELECT EedEEID, EedCOID, SUM(EedBenAmt) AS EedBenAmt
                FROM dbo.EmpDed WITH(NOLOCK)
                WHERE EedDedCode = 'SUNLC'
                GROUP BY EedEEID, EedCOID) sunlc ON sunlc.EedEEID = xEEID AND sunlc.EedCOID = xCOID  
    WHERE EedBenStatus IN ('T', 'C') 

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
ALTER VIEW dbo.dsi_vwESUNAMERIC_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESUNAMERIC_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESUNAMERIC%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202111231'
       ,expStartPerControl     = '202111231'
       ,expLastEndPerControl   = '202111309'
       ,expEndPerControl       = '202111309'
WHERE expFormatCode = 'ESUNAMERIC';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESUNAMERIC_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESUNAMERIC_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESUNAMERIC' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESUNAMERIC'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESUNAMERIC'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESUNAMERIC', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESUNAMERIC', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESUNAMERIC', 'UseFileName', 'V', 'Y'


-- End ripout