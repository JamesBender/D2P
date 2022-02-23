/**********************************************************************************

EGODNYPORT: NYLife Port and Convert Export

FormatCode:     EGODNYPORT
Project:        NYLife Port and Convert Export
Client ID:      GOO1026
Date/time:      2021-12-08 23:33:27.303
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPGDWKY
Web Filename:   GOO1026_C5004_EEHISTORY_EGODNYPORT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EGODNYPORT_SavePath') IS NOT NULL DROP TABLE dbo.U_EGODNYPORT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EGODNYPORT'


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
WHERE FormatCode = 'EGODNYPORT'
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
WHERE ExpFormatCode = 'EGODNYPORT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EGODNYPORT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EGODNYPORT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EGODNYPORT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EGODNYPORT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EGODNYPORT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EGODNYPORT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EGODNYPORT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EGODNYPORT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EGODNYPORT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EGODNYPORT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEGODNYPORT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEGODNYPORT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EGODNYPORT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGODNYPORT];
GO
IF OBJECT_ID('U_EGODNYPORT_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_Trailer];
GO
IF OBJECT_ID('U_EGODNYPORT_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_PEarHist];
GO
IF OBJECT_ID('U_EGODNYPORT_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_PDedHist];
GO
IF OBJECT_ID('U_EGODNYPORT_Header') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_Header];
GO
IF OBJECT_ID('U_EGODNYPORT_File') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_File];
GO
IF OBJECT_ID('U_EGODNYPORT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_EEList];
GO
IF OBJECT_ID('U_EGODNYPORT_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_drvTbl];
GO
IF OBJECT_ID('U_EGODNYPORT_DedList') IS NOT NULL DROP TABLE [dbo].[U_EGODNYPORT_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EGODNYPORT') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EGODNYPORT];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EGODNYPORT','NYLife Port and Convert Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EGODNYPORTZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGODNYPORTZ0','2','H','01','1',NULL,'drvFileHeaderIdentifier',NULL,NULL,'"drvFileHeaderIdentifier"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGODNYPORTZ0','1','H','01','2',NULL,'drvTestIndicator',NULL,NULL,'"drvTestIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGODNYPORTZ0','8','H','01','3',NULL,'drvFileCreationDate',NULL,NULL,'"drvFileCreationDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGODNYPORTZ0','35','H','01','4',NULL,'drvEmployerName',NULL,NULL,'"drvEmployerName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGODNYPORTZ0','418','H','01','5',NULL,'drvFiller',NULL,NULL,'"drvFiller"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGODNYPORTZ0','35','D','10','1',NULL,'drvEmployeeLastName',NULL,NULL,'"drvEmployeeLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGODNYPORTZ0','25','D','10','2',NULL,'drvEmployeeFirstName',NULL,NULL,'"drvEmployeeFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGODNYPORTZ0','9','D','10','3',NULL,'drvEmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGODNYPORTZ0','8','D','10','4',NULL,'drvEmployeeTerminationDate',NULL,NULL,'"drvEmployeeTerminationDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGODNYPORTZ0','35','D','10','5',NULL,'drvEmployeeMailAddress1',NULL,NULL,'"drvEmployeeMailAddress1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGODNYPORTZ0','35','D','10','6',NULL,'drvEmployeeMailAddress2',NULL,NULL,'"drvEmployeeMailAddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGODNYPORTZ0','30','D','10','7',NULL,'drvEmployeeMailCity',NULL,NULL,'"drvEmployeeMailCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGODNYPORTZ0','2','D','10','8',NULL,'drvEmployeeMailState',NULL,NULL,'"drvEmployeeMailState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGODNYPORTZ0','10','D','10','9',NULL,'drvEmployeeMailZipCode',NULL,NULL,'"drvEmployeeMailZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGODNYPORTZ0','30','D','10','10',NULL,'drvEmployeeCountry',NULL,NULL,'"drvEmployeeCountry"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGODNYPORTZ0','3','D','10','11',NULL,'drvClassCodeBasicLife',NULL,NULL,'"drvClassCodeBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGODNYPORTZ0','9','D','10','12',NULL,'drvEmpIssuedAmountBasicLife',NULL,NULL,'"drvEmpIssuedAmountBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGODNYPORTZ0','8','D','10','13',NULL,'drvEmployeeBasicLifeEndDate',NULL,NULL,'"drvEmployeeBasicLifeEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGODNYPORTZ0','9','D','10','14',NULL,'drvSpsIssuedAmountBasicLife',NULL,NULL,'"drvSpsIssuedAmountBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGODNYPORTZ0','8','D','10','15',NULL,'drvSpouseBasicLifeEndDate',NULL,NULL,'"drvSpouseBasicLifeEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGODNYPORTZ0','9','D','10','16',NULL,'drvChildIssuedAmountBasicLife',NULL,NULL,'"drvChildIssuedAmountBasicLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGODNYPORTZ0','8','D','10','17',NULL,'drvChildBasicLifeEndDate',NULL,NULL,'"drvChildBasicLifeEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGODNYPORTZ0','3','D','10','18',NULL,'drvClassCodeBasicADD',NULL,NULL,'"drvClassCodeBasicADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGODNYPORTZ0','9','D','10','19',NULL,'drvEmpIssuedAmountBasicADD',NULL,NULL,'"drvEmpIssuedAmountBasicADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGODNYPORTZ0','8','D','10','20',NULL,'drvEmployeeBasicADDEndDate',NULL,NULL,'"drvEmployeeBasicADDEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGODNYPORTZ0','9','D','10','21',NULL,'drvSpouseBasicADDEndDate',NULL,NULL,'"drvSpouseBasicADDEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGODNYPORTZ0','8','D','10','22',NULL,'drvChildIssuedAmountBasicADD',NULL,NULL,'"drvChildIssuedAmountBasicADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGODNYPORTZ0','9','D','10','23',NULL,'drvChildIssuedAmountBasicADD',NULL,NULL,'"drvChildIssuedAmountBasicADDDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGODNYPORTZ0','8','D','10','24',NULL,'drvChildBasicADDEndDate',NULL,NULL,'"drvChildBasicADDEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGODNYPORTZ0','3','D','10','25',NULL,'drvClassCodeVoluntaryLife',NULL,NULL,'"drvClassCodeVoluntaryLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGODNYPORTZ0','9','D','10','26',NULL,'drvEmpIssuedAmountVoluntaryLife',NULL,NULL,'"drvEmpIssuedAmountVoluntaryLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGODNYPORTZ0','8','D','10','27',NULL,'drvEmpVoluntaryLifeEndDate',NULL,NULL,'"drvEmpVoluntaryLifeEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGODNYPORTZ0','9','D','10','28',NULL,'drvSpsIssuedAmountVoluntaryLife',NULL,NULL,'"drvSpsIssuedAmountVoluntaryLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGODNYPORTZ0','8','D','10','29',NULL,'drvSpouseVoluntaryLifeEndDate',NULL,NULL,'"drvSpouseVoluntaryLifeEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGODNYPORTZ0','9','D','10','30',NULL,'drvChdIssuedAmountVoluntaryLife',NULL,NULL,'"drvChdIssuedAmountVoluntaryLife"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGODNYPORTZ0','8','D','10','31',NULL,'drvChildVoluntaryLifeEndDate',NULL,NULL,'"drvChildVoluntaryLifeEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGODNYPORTZ0','3','D','10','32',NULL,'drvClassCodeVoluntaryADD',NULL,NULL,'"drvClassCodeVoluntaryADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EGODNYPORTZ0','9','D','10','33',NULL,'drvEmpIssuedAmountVoluntaryADD',NULL,NULL,'"drvEmpIssuedAmountVoluntaryADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EGODNYPORTZ0','8','D','10','34',NULL,'drvEmpVoluntaryADDEndDate',NULL,NULL,'"drvEmpVoluntaryADDEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EGODNYPORTZ0','9','D','10','35',NULL,'drvSpsIssuedAmountVoluntaryADD',NULL,NULL,'"drvSpsIssuedAmountVoluntaryADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EGODNYPORTZ0','8','D','10','36',NULL,'drvSpouseVoluntaryADDEndDate',NULL,NULL,'"drvSpouseVoluntaryADDEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EGODNYPORTZ0','9','D','10','37',NULL,'drvChdIssuedAmountVoluntaryADD',NULL,NULL,'"drvChdIssuedAmountVoluntaryADD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EGODNYPORTZ0','8','D','10','38',NULL,'drvChildVoluntaryADDEndDate',NULL,NULL,'"drvChildVoluntaryADDEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EGODNYPORTZ0','3','D','10','39',NULL,'drvClassCodeLTD',NULL,NULL,'"drvClassCodeLTD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EGODNYPORTZ0','9','D','10','40',NULL,'drvEmpLTDMonthlyEarnings',NULL,NULL,'"drvEmpLTDMonthlyEarnings"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EGODNYPORTZ0','1','D','10','41',NULL,'drvJobClassification',NULL,NULL,'"drvJobClassification"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EGODNYPORTZ0','8','D','10','42',NULL,'drvEmpLTDCoverageBeginDate',NULL,NULL,'"drvEmpLTDCoverageBeginDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EGODNYPORTZ0','8','D','10','43',NULL,'drvEmployeeLTDEndDate',NULL,NULL,'"drvEmployeeLTDEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGODNYPORTZ0','9','T','90','1',NULL,'drvTotNumberofRecords',NULL,NULL,'"drvTotNumberofRecords"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGODNYPORTZ0','455','T','90','2',NULL,'drvFiller',NULL,NULL,'"drvFiller"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EGODNYPORT_20211208.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202109179','EMPEXPORT','OEACTIVE',NULL,'EGODNYPORT',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202109179','EMPEXPORT','OEPASSIVE',NULL,'EGODNYPORT',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NYLife Port and Convert File','202109179','EMPEXPORT','ONDEM_XOE',NULL,'EGODNYPORT',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NYLife Port and Convert -Sched','202109179','EMPEXPORT','SCH_EGODNY',NULL,'EGODNYPORT',NULL,NULL,NULL,'202109179','Sep 17 2021  6:35PM','Sep 17 2021  6:35PM','202109171',NULL,'','','202109171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'NYLife Port and Convert -Test','202112089','EMPEXPORT','TEST_XOE','Dec  8 2021 11:30PM','EGODNYPORT',NULL,NULL,NULL,'202112089','Dec  8 2021 12:00AM','Dec 30 1899 12:00AM','202110071','217','','','202110071',dbo.fn_GetTimedKey(),NULL,'us3mLaGOO1026',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','InitialSort','C','drvInitialsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGODNYPORT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGODNYPORT','H01','dbo.U_EGODNYPORT_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGODNYPORT','D10','dbo.U_EGODNYPORT_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGODNYPORT','T90','dbo.U_EGODNYPORT_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EGODNYPORT
-----------

IF OBJECT_ID('U_dsi_BDM_EGODNYPORT') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EGODNYPORT] (
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
-- Create table U_EGODNYPORT_DedList
-----------

IF OBJECT_ID('U_EGODNYPORT_DedList') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EGODNYPORT_drvTbl
-----------

IF OBJECT_ID('U_EGODNYPORT_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialsort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeTerminationDate] varchar(8) NULL,
    [drvEmployeeTerminationDateRaw] datetime NULL,
    [drvEmployeeMailAddress1] varchar(255) NULL,
    [drvEmployeeMailAddress2] varchar(255) NULL,
    [drvEmployeeMailCity] varchar(255) NULL,
    [drvEmployeeMailState] varchar(255) NULL,
    [drvEmployeeMailZipCode] varchar(50) NULL,
    [drvEmployeeCountry] varchar(2) NOT NULL,
    [drvClassCodeBasicLife] varchar(3) NOT NULL,
    [drvEmpIssuedAmountBasicLife] varchar(24) NULL,
    [drvEmpIssuedAmountBasicLifeRaw] money NULL,
    [drvEmployeeBasicLifeEndDate] varchar(8) NULL,
    [drvSpsIssuedAmountBasicLife] varchar(9) NOT NULL,
    [drvSpouseBasicLifeEndDate] varchar(8) NULL,
    [drvChildIssuedAmountBasicLife] varchar(9) NOT NULL,
    [drvChildBasicLifeEndDate] varchar(8) NULL,
    [drvClassCodeBasicADD] varchar(3) NOT NULL,
    [drvEmpIssuedAmountBasicADD] varchar(24) NULL,
    [drvEmployeeBasicADDEndDate] varchar(8) NULL,
    [drvSpouseBasicADDEndDate] varchar(9) NOT NULL,
    [drvChildIssuedAmountBasicADD] varchar(8) NOT NULL,
    [drvChildIssuedAmountBasicADDDate] varchar(9) NOT NULL,
    [drvChildBasicADDEndDate] varchar(9) NOT NULL,
    [drvClassCodeVoluntaryLife] varchar(3) NOT NULL,
    [drvEmpIssuedAmountVoluntaryLife] varchar(24) NULL,
    [drvEmpVoluntaryLifeEndDate] varchar(8) NULL,
    [drvSpsIssuedAmountVoluntaryLife] varchar(24) NULL,
    [drvSpouseVoluntaryLifeEndDate] varchar(8) NULL,
    [drvChdIssuedAmountVoluntaryLife] varchar(24) NULL,
    [drvChildVoluntaryLifeEndDate] varchar(8) NULL,
    [drvClassCodeVoluntaryADD] varchar(3) NOT NULL,
    [drvEmpIssuedAmountVoluntaryADDRaw] money NULL,
    [drvEmpIssuedAmountVoluntaryADD] varchar(24) NULL,
    [drvEmpVoluntaryADDEndDate] varchar(8) NULL,
    [drvSpsIssuedAmountVoluntaryADD] varchar(24) NULL,
    [drvSpouseVoluntaryADDEndDate] varchar(8) NULL,
    [drvChdIssuedAmountVoluntaryADD] varchar(24) NULL,
    [drvChildVoluntaryADDEndDate] varchar(8) NULL,
    [drvClassCodeLTD] varchar(3) NOT NULL,
    [drvEmpLTDMonthlyEarnings] varchar(9) NOT NULL,
    [drvJobClassification] varchar(1) NOT NULL,
    [drvEmpLTDCoverageBeginDate] varchar(8) NOT NULL,
    [drvEmployeeLTDEndDate] varchar(8) NOT NULL
);

-----------
-- Create table U_EGODNYPORT_EEList
-----------

IF OBJECT_ID('U_EGODNYPORT_EEList') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EGODNYPORT_File
-----------

IF OBJECT_ID('U_EGODNYPORT_File') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EGODNYPORT_Header
-----------

IF OBJECT_ID('U_EGODNYPORT_Header') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_Header] (
    [drvFileHeaderIdentifier] varchar(2) NOT NULL,
    [drvTestIndicator] varchar(1) NOT NULL,
    [drvFileCreationDate] datetime NOT NULL,
    [drvEmployerName] varchar(31) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);

-----------
-- Create table U_EGODNYPORT_PDedHist
-----------

IF OBJECT_ID('U_EGODNYPORT_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_PDedHist] (
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
-- Create table U_EGODNYPORT_PEarHist
-----------

IF OBJECT_ID('U_EGODNYPORT_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_PEarHist] (
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

-----------
-- Create table U_EGODNYPORT_Trailer
-----------

IF OBJECT_ID('U_EGODNYPORT_Trailer') IS NULL
CREATE TABLE [dbo].[U_EGODNYPORT_Trailer] (
    [drvTotNumberofRecords] varchar(24) NULL,
    [drvFiller] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGODNYPORT]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Goodwill

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 12/3/2021
Service Request Number: TekP-2021-08-10-0002

Purpose: NYLife Port and Convert Export

Revision History
----------------
Update By           Date           Request Num        Desc

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EGODNYPORT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EGODNYPORT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EGODNYPORT';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EGODNYPORT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EGODNYPORT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGODNYPORT', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGODNYPORT', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGODNYPORT', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGODNYPORT', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGODNYPORT', 'SCH_EDOENY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EGODNYPORT';

EXEC dbo._dsi_usp_ExportRipOut_V7_4 @FormatCode = 'EGODNYPORT', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EGODNYPORT';

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
    DELETE FROM dbo.U_EGODNYPORT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EGODNYPORT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    

    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFE,GLIFP,LIFEE,LIFES,LIFEC';

    IF OBJECT_ID('U_EGODNYPORT_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EGODNYPORT_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EGODNYPORT_DedList
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

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EGODNYPORT_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EGODNYPORT_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EGODNYPORT_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EGODNYPORT_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EGODNYPORT_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EGODNYPORT_PEarHist;
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
    INTO dbo.U_EGODNYPORT_PEarHist
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
    -- DETAIL RECORD - U_EGODNYPORT_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EGODNYPORT_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGODNYPORT_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialsort = eepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN
                                         CASE WHEN EecDateOfTermination IS NOT NULL THEN Convert(CHAR(8),EecDateOfTermination,112) ELSE '00000000' END
                                END
         ,drvEmployeeTerminationDateRaw = CASE WHEN EecEmplStatus = 'T' THEN
                                         EecDateOfTermination
                                END
        ,drvEmployeeMailAddress1 = EepAddressLine1
        ,drvEmployeeMailAddress2 = EepAddressLine2
        ,drvEmployeeMailCity = EepAddressCity
        ,drvEmployeeMailState = EepAddressState
        ,drvEmployeeMailZipCode = EepAddressZipCode
        ,drvEmployeeCountry = 'US'
        ,drvClassCodeBasicLife = CASE WHEN GLIFE is not null  THEN '001'
                                      WHEN GLIFP is not null  THEN '002'
                                    ELSE '000' END
        ,drvEmpIssuedAmountBasicLife = CASE WHEN GLIFP is not null THEN  dbo.dsi_fnpadzero((ISNULL(GLIFP_AMT*100,0)),9,0) 
                                            WHEN GLIFE is not null then dbo.dsi_fnpadzero((ISNULL((select Top 1 PdhDedCalcBasisAmt from pdedhist where pdheeid = xeeid and pdhcoid = xcoid and pdhdedcode = 'GLIFE')*100,0)),9,0) 
                                            ELSE '000000000' END
        ,drvEmpIssuedAmountBasicLifeRaw = CASE WHEN GLIFE is not null THEN   (select Top 1 PdhDedCalcBasisAmt from pdedhist where pdheeid = xeeid and pdhcoid = xcoid and pdhdedcode = 'GLIFE')
                                               WHEN GLIFP is not null THEN  GLIFP_AMT
                                          END
        ,drvEmployeeBasicLifeEndDate = CASE WHEN GLIFE IS NOT NULL and GLIFE_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFE_BenStopDate,112) 
                                             WHEN    GLIFP IS NOT NULL and GLIFP_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFP_BenStopDate,112) 
                                                ELSE '00000000' END
        ,drvSpsIssuedAmountBasicLife = CASE WHEN LIFE_REL_SPS IS not null then '000001000' ELSE '000000000' END
        ,drvSpouseBasicLifeEndDate = CASE WHEN GLIFE IS NOT NULL and GLIFE_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFE_BenStopDate,112) 
                                             WHEN    GLIFP IS NOT NULL and GLIFP_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFP_BenStopDate,112) 
                                                ELSE '00000000' END

        ,drvChildIssuedAmountBasicLife = CASE WHEN LIFE_REL_CHL IS not null then '000001000' ELSE '000000000' END
        ,drvChildBasicLifeEndDate = CASE WHEN GLIFE IS NOT NULL and GLIFE_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFE_BenStopDate,112) 
                                             WHEN    GLIFP IS NOT NULL and GLIFP_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFP_BenStopDate,112) 
                                                ELSE '00000000' END

        ,drvClassCodeBasicADD = CASE WHEN GLIFE is not null  THEN '001'
                                      WHEN GLIFP is not null  THEN '002'
                                    ELSE '000' END
        ,drvEmpIssuedAmountBasicADD = CASE WHEN GLIFP is not null THEN  dbo.dsi_fnpadzero((ISNULL(GLIFP_AMT*100,0)),9,0) 
                                            WHEN GLIFE is not null then dbo.dsi_fnpadzero((ISNULL((select Top 1 PdhDedCalcBasisAmt from pdedhist where pdheeid = xeeid and pdhcoid = xcoid and pdhdedcode = 'GLIFE')*100,0)),9,0) 
                                            ELSE '000000000' END

        ,drvEmployeeBasicADDEndDate = CASE WHEN GLIFE IS NOT NULL and GLIFE_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFE_BenStopDate,112) 
                                             WHEN    GLIFP IS NOT NULL and GLIFP_BenStopDate IS NOT NULL THEN Convert(CHAR(8),GLIFP_BenStopDate,112) 
                                                ELSE '00000000' END

        ,drvSpouseBasicADDEndDate = '000000000'
        ,drvChildIssuedAmountBasicADD = '00000000'
        ,drvChildIssuedAmountBasicADDDate = '000000000'
        ,drvChildBasicADDEndDate = '000000000'
        ,drvClassCodeVoluntaryLife =  CASE WHEN LIFEE is not null THEN '001'
                                    ELSE '000' END
        ,drvEmpIssuedAmountVoluntaryLife = CASE WHEN LIFEE is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFEE_AMT*100,0)),9,0) ELSE '000000000' END
        ,drvEmpVoluntaryLifeEndDate = CASE WHEN LIFEE IS NOT NULL and LIFEE_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFEE_BenStopDate,112) ELSE '00000000' END
        ,drvSpsIssuedAmountVoluntaryLife = CASE WHEN LIFS is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFS_AMT*100,0)),9,0) ELSE '000000000' END
        ,drvSpouseVoluntaryLifeEndDate = CASE WHEN LIFS IS NOT NULL and LIFS_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFS_BenStopDate,112) ELSE '00000000' END
        ,drvChdIssuedAmountVoluntaryLife =  CASE WHEN LIFC is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFC_AMT*100,0)),9,0) ELSE '000000000' END
        ,drvChildVoluntaryLifeEndDate = CASE WHEN LIFC IS NOT NULL and LIFC_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFC_BenStopdate,112) ELSE '00000000' END
        ,drvClassCodeVoluntaryADD =  CASE WHEN LIFEE is not null THEN '001'
                                    ELSE '000' END
        ,drvEmpIssuedAmountVoluntaryADDRaw = CASE WHEN LIFEE is not null THEN  LIFEE_AMT END
        ,drvEmpIssuedAmountVoluntaryADD = CASE WHEN LIFEE is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFEE_AMT*100,0)),9,0) ELSE '000000000' END
        ,drvEmpVoluntaryADDEndDate = CASE WHEN LIFEE IS NOT NULL and LIFEE_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFEE_BenStopDate,112) ELSE '00000000' END
        ,drvSpsIssuedAmountVoluntaryADD = CASE WHEN LIFS is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFS_AMT*100,0)),9,0) ELSE '000000000' END
        ,drvSpouseVoluntaryADDEndDate = CASE WHEN LIFS IS NOT NULL and LIFS_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFS_BenStopDate,112) ELSE '00000000' END
        ,drvChdIssuedAmountVoluntaryADD = CASE WHEN LIFC is not null THEN  dbo.dsi_fnpadzero((ISNULL(LIFC_AMT*100,0)),9,0) ELSE '000000000' END
        ,drvChildVoluntaryADDEndDate = CASE WHEN LIFC IS NOT NULL and LIFC_BenStopDate IS NOT NULL THEN Convert(CHAR(8),LIFC_BenStopdate,112) ELSE '00000000' END
        ,drvClassCodeLTD = '000'
        ,drvEmpLTDMonthlyEarnings = '000000000'
        ,drvJobClassification = '0'
        ,drvEmpLTDCoverageBeginDate = '00000000'
        ,drvEmployeeLTDEndDate = '00000000'
    INTO dbo.U_EGODNYPORT_drvTbl
    FROM dbo.U_EGODNYPORT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (Select 
                bdmeeid,
                bdmcoid, 
                GLIFE  = MAX( CASE WHEN bdmdedcode  = 'GLIFE' THEN 'AF' END),
                GLIFE_BenStopDate  = MAX( CASE WHEN bdmdedcode  = 'GLIFE' THEN bdmbenstopdate END),
                GLIFE_AMT = MAX(CASE WHEN Bcadedcode = 'GLIFE' THEN bcabenamtcalc END ),

                GLIFP  = MAX( CASE WHEN bdmdedcode  = 'GLIFP' THEN BdmDedCode END),
                GLIFP_BenStopDate  = MAX( CASE WHEN bdmdedcode  = 'GLIFP' THEN bdmbenstopdate END),
                GLIFP_AMT = MAX(CASE WHEN Bcadedcode = 'GLIFP' THEN bcabenamtcalc END ),
                LIFE_REL_SPS  = MAX( CASE WHEN bdmdedcode  IN ('GLIFE','GLIFP') and BdmRelationship IN ('SPS','DP') THEN '1' END),
                LIFE_REL_CHL  = MAX( CASE WHEN bdmdedcode  IN ('GLIFE','GLIFP') and BdmRelationship IN ('CHL', 'DIS', 'DPC', 'SGR' , 'STC' ) THEN '1' END),

                LIFEE  = MAX( CASE WHEN bdmdedcode IN ('LIFEE') THEN 'AC' END),
                LIFEE_AMT = MAX(CASE WHEN Bcadedcode IN ('LIFEE')  THEN bcabenamtcalc END ),
                LIFEE_BenStopDate  = MAX( CASE WHEN bdmdedcode  IN ('LIFEE') THEN bdmbenstopdate END),

                BAD  = MAX( CASE WHEN bdmdedcode IN ('AADD') THEN 'BAD' END),
                BAD_AMT = MAX(CASE WHEN Bcadedcode IN ('AADD')  THEN bcabenamtcalc END ),
                BAD_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('AADD')  THEN bdmbenstopdate END ),
                ADDCode  = MAX( CASE WHEN bdmdedcode IN ('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5') THEN 'AD' END),
                ADDCode_AMT = MAX(CASE WHEN Bcadedcode IN ('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5')  THEN bcabenamtcalc END ),
                ADDCode_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5')  THEN bdmbenstopdate END ),

                LIFS  = MAX( CASE WHEN bdmdedcode IN ('LIFES') THEN 'LIFS' END),
                LIFS_AMT = MAX(CASE WHEN Bcadedcode IN ('LIFES')  THEN bcabenamtcalc END ),
                LIFS_BenStopDate = MAX(CASE WHEN Bcadedcode IN ('LIFES')  THEN bdmbenstopdate END ),
                LIFC  = MAX( CASE WHEN bdmdedcode IN ('LIFC1', 'ALIFC') THEN 'LIFC' END),
                LIFC_AMT = MAX(CASE WHEN Bcadedcode IN ('LIFC1', 'ALIFC')  THEN bcabenamtcalc END ),
                LIFC_BenStopdate = MAX(CASE WHEN Bcadedcode IN ('LIFC1', 'ALIFC')  THEN bdmbenstopdate END )
               
            from dbo.U_dsi_BDM_EGODNYPORT WITH (NOLOCK) LEFT JOIN dbo.U_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
            on bcaeeid = bdmeeid and bcacoid = bdmcoid and bcadedcode = bdmdedcode
            Where bcaformatcode = @FormatCode
            group by bdmeeid,bdmcoid) as bdmconsolidated
        on bdmconsolidated.bdmcoid = xcoid
        and bdmconsolidated.bdmeeid =  xeeid
    
    ;

    Delete from dbo.U_EGODNYPORT_drvTbl where drvEmployeeTerminationDateRaw is null 

    Delete from dbo.U_EGODNYPORT_drvTbl where drvEmployeeTerminationDate is not null 
    and cast(drvEmployeeTerminationDate as datetime) < @StartDate 
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EGODNYPORT_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EGODNYPORT_Header;
    SELECT DISTINCT
         drvFileHeaderIdentifier = 'HD'
        ,drvTestIndicator = CASE WHEN @ExportCode LIKE 'TEST%' THEN 'T' ELSE 'P' END
        ,drvFileCreationDate = GETDATE()
        ,drvEmployerName = 'Goodwill Industries of Kentucky'
        ,drvFiller = ''
    INTO dbo.U_EGODNYPORT_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EGODNYPORT_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EGODNYPORT_Trailer;
    SELECT DISTINCT
         drvTotNumberofRecords = dbo.dsi_fnpadzero((ISNULL((Select count(*) from dbo.U_EGODNYPORT_drvTbl)  + 2,0)),9,0) 
        ,drvFiller = ''
    INTO dbo.U_EGODNYPORT_Trailer
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
ALTER VIEW dbo.dsi_vwEGODNYPORT_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EGODNYPORT_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EGODNYPORT%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202109101'
       ,expStartPerControl     = '202109101'
       ,expLastEndPerControl   = '202109179'
       ,expEndPerControl       = '202109179'
WHERE expFormatCode = 'EGODNYPORT';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEGODNYPORT_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EGODNYPORT_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EGODNYPORT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EGODNYPORT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EGODNYPORT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGODNYPORT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EGODNYPORT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGODNYPORT', 'UseFileName', 'V', 'Y'


-- End ripout