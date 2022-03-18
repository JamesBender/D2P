/**********************************************************************************

E457TR401K: Mission Square 457 Payroll Export

FormatCode:     E457TR401K
Project:        Mission Square 457 Payroll Export
Client ID:      TRI1018
Date/time:      2022-02-03 21:14:08.657
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP4DB02
Database:       ULTIPRO_WPTRNTY
Web Filename:   TRI1018_9B2D2_EEHISTORY_E457TR401K_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_E457TR401K_SavePath') IS NOT NULL DROP TABLE dbo.U_E457TR401K_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'E457TR401K'


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
WHERE FormatCode = 'E457TR401K'
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
WHERE ExpFormatCode = 'E457TR401K'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'E457TR401K')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'E457TR401K'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'E457TR401K'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'E457TR401K'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'E457TR401K'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'E457TR401K'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'E457TR401K'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'E457TR401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'E457TR401K'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'E457TR401K'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwE457TR401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwE457TR401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_E457TR401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E457TR401K];
GO
IF OBJECT_ID('U_E457TR401K_PlanRecTbl2') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PlanRecTbl2];
GO
IF OBJECT_ID('U_E457TR401K_PlanRecTbl1') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PlanRecTbl1];
GO
IF OBJECT_ID('U_E457TR401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PEarHist];
GO
IF OBJECT_ID('U_E457TR401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_PDedHist];
GO
IF OBJECT_ID('U_E457TR401K_LoanRecTbl4') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_LoanRecTbl4];
GO
IF OBJECT_ID('U_E457TR401K_LoanRecTbl3_Stage') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_LoanRecTbl3_Stage];
GO
IF OBJECT_ID('U_E457TR401K_LoanRecTbl3') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_LoanRecTbl3];
GO
IF OBJECT_ID('U_E457TR401K_LoanRecTbl2') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_LoanRecTbl2];
GO
IF OBJECT_ID('U_E457TR401K_LoanRecTbl1') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_LoanRecTbl1];
GO
IF OBJECT_ID('U_E457TR401K_File') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_File];
GO
IF OBJECT_ID('U_E457TR401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_EEList];
GO
IF OBJECT_ID('U_E457TR401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_DedList];
GO
IF OBJECT_ID('U_E457TR401K_ContRecTbl4') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_ContRecTbl4];
GO
IF OBJECT_ID('U_E457TR401K_ContRecTbl3') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_ContRecTbl3];
GO
IF OBJECT_ID('U_E457TR401K_ContRecTbl2') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_ContRecTbl2];
GO
IF OBJECT_ID('U_E457TR401K_ContRecTbl1') IS NOT NULL DROP TABLE [dbo].[U_E457TR401K_ContRecTbl1];
GO
IF OBJECT_ID('U_dsi_BDM_E457TR401K') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_E457TR401K];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','E457TR401K','Mission Square 457 Payroll Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','E457TR401KZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','10','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','10','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','10','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','4','D','10','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','9','D','10','5',NULL,'IRS Number',NULL,NULL,'"drvIRSNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','30','D','10','6',NULL,'Plan Name',NULL,NULL,'"drvPlanName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','24','D','10','7',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','1','D','10','8',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','20','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','20','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','20','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','4','D','20','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','9','D','20','5',NULL,'IRS Number',NULL,NULL,'"drvIRSNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','10','D','20','6',NULL,'Total Remittance',NULL,NULL,'"drvTotRemit"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','25','D','20','7',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','2','D','20','8',NULL,'Format Code',NULL,NULL,'"drvFormatCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E457TR401KZ0','6','D','20','9',NULL,'Filler',NULL,NULL,'"drvFiller3"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E457TR401KZ0','8','D','20','10',NULL,'Payroll Date',NULL,NULL,'"drvPayDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E457TR401KZ0','1','D','20','11',NULL,'Tax Year Indicator',NULL,NULL,'"drvTaxYear"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E457TR401KZ0','2','D','20','12',NULL,'Filler',NULL,NULL,'"drvFiller4"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E457TR401KZ0','1','D','20','13',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','30','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','30','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','30','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','4','D','30','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','9','D','30','5',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','30','D','30','6',NULL,'Participant Name',NULL,NULL,'"drvPartName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','24','D','30','7',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','1','D','30','8',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','40','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','40','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','40','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','2','D','40','4',NULL,'Insurance Provider',NULL,NULL,'"drvInsProvider"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','2','D','40','5',NULL,'Source Code for Cont Type',NULL,NULL,'"drvSourceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','9','D','40','6',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','10','D','40','7',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','1','D','40','8',NULL,'Tax Year Indicator',NULL,NULL,'"drvTaxYear"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E457TR401KZ0','4','D','40','9',NULL,'Fund ID',NULL,NULL,'"drvFundId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E457TR401KZ0','35','D','40','10',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E457TR401KZ0','4','D','40','11',NULL,'Location ID',NULL,NULL,'"drvLocId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E457TR401KZ0','1','D','40','12',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','50','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','50','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','50','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','4','D','50','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','9','D','50','5',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','30','D','50','6',NULL,'Participant Name',NULL,NULL,'"drvPartName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','24','D','50','7',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','1','D','50','8',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','60','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','60','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','60','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','2','D','60','4',NULL,'Insurance Provider',NULL,NULL,'"drvInsProvider"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','2','D','60','5',NULL,'Source Code for Cont Type',NULL,NULL,'"drvSourceCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','9','D','60','6',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','10','D','60','7',NULL,'Contribution Amount',NULL,NULL,'"drvContAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','1','D','60','8',NULL,'Tax Year Indicator',NULL,NULL,'"drvTaxYear"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E457TR401KZ0','4','D','60','9',NULL,'Fund ID',NULL,NULL,'"drvFundId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E457TR401KZ0','35','D','60','10',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E457TR401KZ0','4','D','60','11',NULL,'Location ID',NULL,NULL,'"drvLocId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E457TR401KZ0','1','D','60','12',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','70','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','70','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','70','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','4','D','70','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','9','D','70','5',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','30','D','70','6',NULL,'Participant Name',NULL,NULL,'"drvPartName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','24','D','70','7',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','1','D','70','8',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','80','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','80','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','80','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','1','D','80','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','3','D','80','5',NULL,'Loan Number',NULL,NULL,'"drvLoanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','9','D','80','6',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','10','D','80','7',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanRepAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','40','D','80','8',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E457TR401KZ0','4','D','80','9',NULL,'Loan Payoff Indicator',NULL,NULL,'"drvLoanPayIndic"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E457TR401KZ0','1','D','80','10',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','90','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','90','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','90','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','4','D','90','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','9','D','90','5',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','30','D','90','6',NULL,'Participant Name',NULL,NULL,'"drvPartName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','24','D','90','7',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','1','D','90','8',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E457TR401KZ0','6','D','91','1',NULL,'ICMA-RC Plan Num',NULL,NULL,'"drvICMA"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E457TR401KZ0','2','D','91','2',NULL,'Record Type',NULL,NULL,'"drvRecType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E457TR401KZ0','4','D','91','3',NULL,'Record Sequence',NULL,NULL,'"drvRecSeq"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E457TR401KZ0','1','D','91','4',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E457TR401KZ0','3','D','91','5',NULL,'Loan Number',NULL,NULL,'"drvLoanNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E457TR401KZ0','9','D','91','6',NULL,'Participant SSN',NULL,NULL,'"drvPartSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E457TR401KZ0','10','D','91','7',NULL,'Loan Repayment Amount',NULL,NULL,'"drvLoanRepAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E457TR401KZ0','40','D','91','8',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E457TR401KZ0','4','D','91','9',NULL,'Loan Payoff Indicator',NULL,NULL,'"drvLoanPayIndic"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E457TR401KZ0','1','D','91','10',NULL,'Format ID',NULL,NULL,'"drvFormatId"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'E457TR401K_20220203.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mission Square 457 Payroll Exp','202108189','EMPEXPORT','ONDEM_XOE',NULL,'E457TR401K',NULL,NULL,NULL,'202108189','Aug 18 2021  3:53PM','Aug 18 2021  3:53PM','202108181',NULL,'','','202108181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mission Square 457 Payro-Sched','202108189','EMPEXPORT','SCH_E457TR',NULL,'E457TR401K',NULL,NULL,NULL,'202108189','Aug 18 2021  3:53PM','Aug 18 2021  3:53PM','202108181',NULL,'','','202108181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Mission Square 457 Payro-Test','202201209','EMPEXPORT','TEST_XOE','Jan 20 2022  6:07PM','E457TR401K',NULL,NULL,NULL,'202201209','Jan 20 2022 12:00AM','Dec 30 1899 12:00AM','202201201','358','','','202201201',dbo.fn_GetTimedKey(),NULL,'us3aPiTRI1018',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E457TR401K','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D10','dbo.U_E457TR401K_PlanRecTbl1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D20','dbo.U_E457TR401K_PlanRecTbl2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D30','dbo.U_E457TR401K_ContRecTbl1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D40','dbo.U_E457TR401K_ContRecTbl2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D50','dbo.U_E457TR401K_ContRecTbl3',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D60','dbo.U_E457TR401K_ContRecTbl4',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D70','dbo.U_E457TR401K_LoanRecTbl1',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D80','dbo.U_E457TR401K_LoanRecTbl2',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D90','dbo.U_E457TR401K_LoanRecTbl4',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E457TR401K','D91','dbo.U_E457TR401K_LoanRecTbl3',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_E457TR401K
-----------

IF OBJECT_ID('U_dsi_BDM_E457TR401K') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_E457TR401K] (
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
-- Create table U_E457TR401K_ContRecTbl1
-----------

IF OBJECT_ID('U_E457TR401K_ContRecTbl1') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_ContRecTbl1] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartName] varchar(202) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_ContRecTbl2
-----------

IF OBJECT_ID('U_E457TR401K_ContRecTbl2') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_ContRecTbl2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvInsProvider] varchar(1) NOT NULL,
    [drvSourceCode] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvContAmt] varchar(10) NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvFundId] varchar(1) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvLocId] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_ContRecTbl3
-----------

IF OBJECT_ID('U_E457TR401K_ContRecTbl3') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_ContRecTbl3] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartName] varchar(202) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_ContRecTbl4
-----------

IF OBJECT_ID('U_E457TR401K_ContRecTbl4') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_ContRecTbl4] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvInsProvider] varchar(1) NOT NULL,
    [drvSourceCode] varchar(2) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvContAmt] varchar(10) NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvFundId] varchar(1) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvLocId] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_DedList
-----------

IF OBJECT_ID('U_E457TR401K_DedList') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_E457TR401K_EEList
-----------

IF OBJECT_ID('U_E457TR401K_EEList') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_E457TR401K_File
-----------

IF OBJECT_ID('U_E457TR401K_File') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_E457TR401K_LoanRecTbl1
-----------

IF OBJECT_ID('U_E457TR401K_LoanRecTbl1') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_LoanRecTbl1] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartName] varchar(202) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_LoanRecTbl2
-----------

IF OBJECT_ID('U_E457TR401K_LoanRecTbl2') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_LoanRecTbl2] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvLoanNum] varchar(3) NULL,
    [drvPartSSN] char(11) NULL,
    [drvLoanRepAmt] varchar(10) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvLoanPayIndic] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvRN] bigint NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_LoanRecTbl3
-----------

IF OBJECT_ID('U_E457TR401K_LoanRecTbl3') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_LoanRecTbl3] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvLoanNum] varchar(3) NULL,
    [drvPartSSN] char(11) NULL,
    [drvLoanRepAmt] varchar(10) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvLoanPayIndic] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvRN] bigint NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_E457TR401K_LoanRecTbl3_Stage
-----------

IF OBJECT_ID('U_E457TR401K_LoanRecTbl3_Stage') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_LoanRecTbl3_Stage] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvLoanNum] varchar(3) NULL,
    [drvPartSSN] char(11) NULL,
    [drvLoanRepAmt] varchar(10) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvLoanPayIndic] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvRN] bigint NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);

-----------
-- Create table U_E457TR401K_LoanRecTbl4
-----------

IF OBJECT_ID('U_E457TR401K_LoanRecTbl4') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_LoanRecTbl4] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartName] varchar(202) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_PDedHist
-----------

IF OBJECT_ID('U_E457TR401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
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
-- Create table U_E457TR401K_PEarHist
-----------

IF OBJECT_ID('U_E457TR401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PEarHist] (
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
-- Create table U_E457TR401K_PlanRecTbl1
-----------

IF OBJECT_ID('U_E457TR401K_PlanRecTbl1') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PlanRecTbl1] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvIRSNum] char(9) NULL,
    [drvPlanName] varchar(8) NOT NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);

-----------
-- Create table U_E457TR401K_PlanRecTbl2
-----------

IF OBJECT_ID('U_E457TR401K_PlanRecTbl2') IS NULL
CREATE TABLE [dbo].[U_E457TR401K_PlanRecTbl2] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvICMA] varchar(6) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvRecSeq] varchar(4) NOT NULL,
    [drvFiller1] varchar(1) NOT NULL,
    [drvIRSNum] char(9) NULL,
    [drvTotRemit] varchar(10) NULL,
    [drvFiller2] varchar(1) NOT NULL,
    [drvFormatCode] varchar(2) NOT NULL,
    [drvFiller3] varchar(1) NOT NULL,
    [drvPayDate] datetime NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvFiller4] varchar(1) NOT NULL,
    [drvFormatId] varchar(1) NOT NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E457TR401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Trinity River Authority of Texas

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 08/18/2021
Service Request Number: TekP-2021-07-27-0006

Purpose: Mission Square 457 Payroll Export

Revision History
----------------
08/27/2021 by AP:
        - Updated layout for plan record set.
        - Total remittance now shows TOTAL of all records.
        - Changed format of payroll date.
        - Fixed deduction codes for loan repayment amount and dataset.

09/01/2021 by AP:
        - Updated logic to update loan repayment amount.
        - Contribution lines fixed to show 1 record per employee.

09/03/2021 by AP:
        - Cleaned up logic to exclude those that don't have loans from the loan table (removed LEFT JOIN to PDedHist).
        - Total Remittance was updated to use PdhEECurAmt instead of PdhSource1 which was filtered on only certain ded codes.
        - Cleaned up the output for Total Remittance to be without the added 2 digits after the decimal. Clean up was also applied
          to the total loan amount field as well.
        - Provided LTRIM and RTRIM to names to make sure they populate as expected.

10/07/2021 by AP:
        - Updated structure for loan to show name -> loan and name -> loan
        - NOTE: D80 needs to be before D70 on grouping output.

10/11/2021 by AP:
        - Set source code for contribution type to BLANK.    
        
10/12/2021 by AP:
        - Adjusted code to fix glitch with name -> loan -> name (1,2,1,2) format.   

10/21/2021 by AP:
        - Fixed name problem in plan contrib record.
        - Added new ded codes and added new ded code mapping to contrib amounts.

01/20/2022 by AP:
        - Separated logic for contribution RT vs NON-RT.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'E457TR401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'E457TR401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'E457TR401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'E457TR401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'E457TR401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E457TR401K', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E457TR401K', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E457TR401K', 'SCH_E457TR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'E457TR401K';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'E457TR401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'E457TR401K';

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
    DELETE FROM dbo.U_E457TR401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_E457TR401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BEDA, BEDAC, BEDP, BEDPC, BEDPR, BDC1, BDC2, BDC3, BDC4, BDC5, BDC6, BDC7, BDC8, BDC9, BDC10, BDC11, BDC12, BDC13, BDC14, BDC15, BDC16,
                        BDC17, BDC18, BDC19, BDC20, BDC21, BDC22, BDC23, BDC24, BDC25, BDC26, BDC27, BDC28, BDC29, BDC30, BERA, BERAC, BERAP, BERPC, BERPR';

    IF OBJECT_ID('U_E457TR401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_E457TR401K_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_E457TR401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhDedCode
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('BEDA', 'BEDAC', 'DEDP', 'BEDPC', 'BEDPR','BERA', 'BERAC', 'BERAP', 'BERPC', 'BERPR') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_E457TR401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_E457TR401K_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCOID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_E457TR401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PEarHist;
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
    INTO dbo.U_E457TR401K_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID, PehCOID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_PlanRecTbl1 D10
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_PlanRecTbl1','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PlanRecTbl1;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '01'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvIRSNum = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvPlanName = '457 Plan'
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = '0'
        ,drvSubSort = '0'
    INTO dbo.U_E457TR401K_PlanRecTbl1
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_PlanRecTbl2 D20
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_PlanRecTbl2','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_PlanRecTbl2;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '01'
        ,drvRecSeq = '0002'
        ,drvFiller1 = ''
        ,drvIRSNum = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvTotRemit = RIGHT('0000000000' + REPLACE(CAST(CAST(SUM(PdhEECurAmt) AS DECIMAL(10,2)) AS VARCHAR), '.', ''), 10)
        --RIGHT('0000000000' + REPLACE(CAST(SUM(PdhSource1) AS VARCHAR), '.', ''), 10)
        ,drvFiller2 = ''
        ,drvFormatCode = '03'
        ,drvFiller3 = ''
        ,drvPayDate = MAX(PrgPayDate)
        ,drvTaxYear = ''
        ,drvFiller4 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = '0'
        ,drvSubSort = '0'
    INTO dbo.U_E457TR401K_PlanRecTbl2
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_ContRecTbl1 D30
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_ContRecTbl1','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_ContRecTbl1;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '02'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvPartSSN = EepSSN
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '3'
    INTO dbo.U_E457TR401K_ContRecTbl1
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
     JOIN (SELECT PdhEEID, PdhCOID
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode NOT IN ('BERA', 'BERAC', 'BERAP', 'BERPC', 'BERPR')
                --('BEDA', 'BEDAC', 'BEDP', 'BEDPC', 'BEDPR', 'BDC1', 'BDC2', 'BDC3', 'BDC4', 'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11', 'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16',
                        --'BDC17', 'BDC18', 'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25', 'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                ) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_ContRecTbl2 D40
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_ContRecTbl2','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_ContRecTbl2;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '02'
        ,drvRecSeq = '0002'
        ,drvInsProvider = ''
        ,drvSourceCode = ''--CASE WHEN Pdhdedcode IN ('BERA', 'BERAC', 'BERAP', 'BERPC', 'BERPR') THEN 'RT' END
        ,drvPartSSN = EepSSN
        ,drvContAmt = RIGHT('0000000000' + REPLACE(CAST(CAST(PdhSource1 AS DECIMAL(10,2)) AS VARCHAR), '.', ''), 10)
        ,drvTaxYear = ''
        ,drvFundId = ''
        ,drvFiller1 = ''
        ,drvLocId = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '4'
    INTO dbo.U_E457TR401K_ContRecTbl2
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN (SELECT PdhEEID, PdhDedCode, PdhCOID, SUM(PdhSource1) PdhSource1
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode NOT IN ('BERA', 'BERAC', 'BERAP', 'BERPC', 'BERPR')
                --('BEDA', 'BEDAC', 'BEDP', 'BEDPC', 'BEDPR', 'BDC1', 'BDC2', 'BDC3', 'BDC4', 'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11', 'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16',
                        --'BDC17', 'BDC18', 'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25', 'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                GROUP BY PdhEEID, PdhDedCode,PdhCOID) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    --JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    --ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
	WHERE PdhSource1 <> 0.00
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_ContRecTbl3 D50
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_ContRecTbl3','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_ContRecTbl3;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '02'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvPartSSN = EepSSN
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '5'
    INTO dbo.U_E457TR401K_ContRecTbl3
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
     JOIN (SELECT PdhEEID, PdhCOID
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode IN ('BERA', 'BERAC', 'BERAP', 'BERPC', 'BERPR')
                --('BEDA', 'BEDAC', 'BEDP', 'BEDPC', 'BEDPR', 'BDC1', 'BDC2', 'BDC3', 'BDC4', 'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11', 'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16',
                        --'BDC17', 'BDC18', 'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25', 'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                ) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    ;
     ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_ContRecTbl4 D60
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_ContRecTbl4','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_ContRecTbl4;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '02'
        ,drvRecSeq = '0002'
        ,drvInsProvider = ''
        ,drvSourceCode = 'RT'--CASE WHEN Pdhdedcode IN ('BERA', 'BERAC', 'BERAP', 'BERPC', 'BERPR') THEN 'RT' END
        ,drvPartSSN = EepSSN
        ,drvContAmt = RIGHT('0000000000' + REPLACE(CAST(CAST(PdhSource1 AS DECIMAL(10,2)) AS VARCHAR), '.', ''), 10)
        ,drvTaxYear = ''
        ,drvFundId = ''
        ,drvFiller1 = ''
        ,drvLocId = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '6'
    INTO dbo.U_E457TR401K_ContRecTbl4
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN (SELECT PdhEEID, PdhDedCode, PdhCOID, SUM(PdhSource1) PdhSource1
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode IN ('BERA', 'BERAC', 'BERAP', 'BERPC', 'BERPR')
                --('BEDA', 'BEDAC', 'BEDP', 'BEDPC', 'BEDPR', 'BDC1', 'BDC2', 'BDC3', 'BDC4', 'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11', 'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16',
                        --'BDC17', 'BDC18', 'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25', 'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                GROUP BY PdhEEID, PdhDedCode,PdhCOID) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    --JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    --ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
	WHERE PdhSource1 <> 0.00
    ;

    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_LoanRecTbl1 D70
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_LoanRecTbl1','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_LoanRecTbl1;

    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '03'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvPartSSN = EepSSN
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '7'
    INTO dbo.U_E457TR401K_LoanRecTbl1
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN (SELECT PdhEEID, PdhCOID
            FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
            WHERE PdhDedCode IN ('BDC1', 'BDC2', 'BDC3', 'BDC4',
                                    'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11',
                                    'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16', 'BDC17', 'BDC18',
                                    'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25',
                                    'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    --JOIN dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
    --ON PdhEEID = xEEID AND PdhCOID = xCOID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_LoanRecTbl2 D80
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_LoanRecTbl2','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_LoanRecTbl2;

    SELECT *,drvInitialSort = RTRIM(LTRIM(drvPartSSN))
        ,drvSubSort = '8'
    INTO dbo.U_E457TR401K_LoanRecTbl2
    FROM 
    (
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '03'
        ,drvRecSeq = '0002'
        ,drvFiller1 = ''
        ,drvLoanNum = CASE PdhDedCode
                        WHEN 'BDC1' THEN '001'
                        WHEN 'BDC2' THEN '002'
                        WHEN 'BDC3' THEN '003'
                        WHEN 'BDC4' THEN '004'
                        WHEN 'BDC5' THEN '005'
                        WHEN 'BDC6' THEN '006'
                        WHEN 'BDC7' THEN '007'
                        WHEN 'BDC8' THEN '008'
                        WHEN 'BDC9' THEN '009'
                        WHEN 'BDC10' THEN '010'
                        WHEN 'BDC11' THEN '011'
                        WHEN 'BDC12' THEN '012'
                        WHEN 'BDC13' THEN '013'
                        WHEN 'BDC14' THEN '014'
                        WHEN 'BDC15' THEN '015'
                        WHEN 'BDC16' THEN '016'
                        WHEN 'BDC17' THEN '017'
                        WHEN 'BDC18' THEN '018'
                        WHEN 'BDC19' THEN '019'
                        WHEN 'BDC20' THEN '020'
                        WHEN 'BDC21' THEN '021'
                        WHEN 'BDC22' THEN '022'
                        WHEN 'BDC23' THEN '023'
                        WHEN 'BDC24' THEN '024'
                        WHEN 'BDC25' THEN '025'
                        WHEN 'BDC26' THEN '026'
                        WHEN 'BDC27' THEN '027'
                        WHEN 'BDC28' THEN '028'
                        WHEN 'BDC29' THEN '029'
                        WHEN 'BDC30' THEN '030'
                    END
        ,drvPartSSN = EepSSN
        ,drvLoanRepAmt = RIGHT('0000000000' + REPLACE(CAST(CAST(PdhEECurAmt AS DECIMAL(10,2)) AS VARCHAR), '.', ''), 10)
        --RIGHT('0000000000' + REPLACE(CAST(PdhEECurAmt AS VARCHAR), '.', ''), 10) 
        ,drvFiller2 = ''
        ,drvLoanPayIndic = ''
        ,drvFormatId = '3'
        ,drvRN = ROW_NUMBER() OVER(PARTITION BY xEEID ORDER BY xEEID) 
  --  INTO dbo.U_E457TR401K_LoanRecTbl2
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    JOIN (SELECT PdhEEID, PdhCOID, PdhDedCode, SUM(PdhEECurAmt) PdhEECurAmt
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode IN ('BDC1', 'BDC2', 'BDC3', 'BDC4',
                                    'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11',
                                    'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16', 'BDC17', 'BDC18',
                                    'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25',
                                    'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                GROUP BY PdhEEID, PdhCOID, PdhDedCode) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    ) a
    WHERE drvRN = '1'
   
    ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_LoanRecTbl3_Stage D90
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_LoanRecTbl3_Stage','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_LoanRecTbl3_Stage;

   SELECT * ,drvInitialSort = RTRIM(LTRIM(drvPartSSN))
        ,drvSubSort = '91'
    INTO dbo.U_E457TR401K_LoanRecTbl3_Stage
    FROM 
    (
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '03'
        ,drvRecSeq = '0002'
        ,drvFiller1 = ''
        ,drvLoanNum = CASE PdhDedCode
                        WHEN 'BDC1' THEN '001'
                        WHEN 'BDC2' THEN '002'
                        WHEN 'BDC3' THEN '003'
                        WHEN 'BDC4' THEN '004'
                        WHEN 'BDC5' THEN '005'
                        WHEN 'BDC6' THEN '006'
                        WHEN 'BDC7' THEN '007'
                        WHEN 'BDC8' THEN '008'
                        WHEN 'BDC9' THEN '009'
                        WHEN 'BDC10' THEN '010'
                        WHEN 'BDC11' THEN '011'
                        WHEN 'BDC12' THEN '012'
                        WHEN 'BDC13' THEN '013'
                        WHEN 'BDC14' THEN '014'
                        WHEN 'BDC15' THEN '015'
                        WHEN 'BDC16' THEN '016'
                        WHEN 'BDC17' THEN '017'
                        WHEN 'BDC18' THEN '018'
                        WHEN 'BDC19' THEN '019'
                        WHEN 'BDC20' THEN '020'
                        WHEN 'BDC21' THEN '021'
                        WHEN 'BDC22' THEN '022'
                        WHEN 'BDC23' THEN '023'
                        WHEN 'BDC24' THEN '024'
                        WHEN 'BDC25' THEN '025'
                        WHEN 'BDC26' THEN '026'
                        WHEN 'BDC27' THEN '027'
                        WHEN 'BDC28' THEN '028'
                        WHEN 'BDC29' THEN '029'
                        WHEN 'BDC30' THEN '030'
                    END
        ,drvPartSSN = EepSSN
        ,drvLoanRepAmt = RIGHT('0000000000' + REPLACE(CAST(CAST(PdhEECurAmt AS DECIMAL(10,2)) AS VARCHAR), '.', ''), 10)
        --RIGHT('0000000000' + REPLACE(CAST(PdhEECurAmt AS VARCHAR), '.', ''), 10) 
        ,drvFiller2 = ''
        ,drvLoanPayIndic = ''
        ,drvFormatId = '3'
        ,drvRN = ROW_NUMBER() OVER(PARTITION BY xEEID ORDER BY xEEID) 
  --  INTO dbo.U_E457TR401K_LoanRecTbl2
    FROM dbo.U_E457TR401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = xEEID
    JOIN dbo.U_E457TR401K_PEarHist WITH(NOLOCK)
    ON PehEEID = xEEID AND PehCOID = xCOID
    JOIN (SELECT PdhEEID, PdhCOID, PdhDedCode, SUM(PdhEECurAmt) PdhEECurAmt
                FROM dbo.U_E457TR401K_PDedHist WITH(NOLOCK)
                WHERE PdhDedCode IN ('BDC1', 'BDC2', 'BDC3', 'BDC4',
                                    'BDC5', 'BDC6', 'BDC7', 'BDC8', 'BDC9', 'BDC10', 'BDC11',
                                    'BDC12', 'BDC13', 'BDC14', 'BDC15', 'BDC16', 'BDC17', 'BDC18',
                                    'BDC19', 'BDC20', 'BDC21', 'BDC22', 'BDC23', 'BDC24', 'BDC25',
                                    'BDC26', 'BDC27', 'BDC28', 'BDC29', 'BDC30')
                GROUP BY PdhEEID, PdhCOID, PdhDedCode) Pdh ON Pdh.PdhEEID = xEEID AND Pdh.PdhCOID = xCOID
    ) a
    WHERE drvRN = '2';

      ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_LoanRecTbl4 D91
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_LoanRecTbl4','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_LoanRecTbl4;

    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvICMA = '305037'
        ,drvRecType = '03'
        ,drvRecSeq = '0001'
        ,drvFiller1 = ''
        ,drvPartSSN = drvPartSSN
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst))
        ,drvFiller2 = ''
        ,drvFormatId = '3'
        ,drvInitialSort = RTRIM(LTRIM(EepSSN))
        ,drvSubSort = '9'
    INTO dbo.U_E457TR401K_LoanRecTbl4
    FROM dbo.U_E457TR401K_LoanRecTbl3_Stage a JOIN dbo.EmpPers b WITH(NOLOCK)
    ON a.drveeid = b.eepeeid

     ---------------------------------
    -- DETAIL RECORD - U_E457TR401K_LoanRecTbl3 
    ---------------------------------
    IF OBJECT_ID('U_E457TR401K_LoanRecTbl3','U') IS NOT NULL
        DROP TABLE dbo.U_E457TR401K_LoanRecTbl3;

    SELECT DISTINCT
         drvEEID
        ,drvCoID
        ,drvDepRecID 
        -- standard fields above and additional driver fields below
        ,drvICMA 
        ,drvRecType
        ,drvRecSeq
        ,drvFiller1
        ,drvLoanNum
        ,drvPartSSN 
        ,drvLoanRepAmt 
        --RIGHT('0000000000' + REPLACE(CAST(PdhEECurAmt AS VARCHAR), '.', ''), 10) 
        ,drvFiller2
        ,drvLoanPayIndic
        ,drvFormatId
        ,drvRN
        ,drvInitialSort
        ,drvSubSort
    INTO dbo.U_E457TR401K_LoanRecTbl3
    FROM dbo.U_E457TR401K_LoanRecTbl3_Stage WITH(NOLOCK) 
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
ALTER VIEW dbo.dsi_vwE457TR401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_E457TR401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'E457TR401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202108111'
       ,expStartPerControl     = '202108111'
       ,expLastEndPerControl   = '202108189'
       ,expEndPerControl       = '202108189'
WHERE expFormatCode = 'E457TR401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwE457TR401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_E457TR401K_File WITH (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'E457TR401K' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'E457TR401K'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'E457TR401K'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'E457TR401K', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'E457TR401K', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'E457TR401K', 'UseFileName', 'V', 'Y'


-- End ripout