/**********************************************************************************

EMCPCOBRQB: MCP Cobra QB Export

FormatCode:     EMCPCOBRQB
Project:        MCP Cobra QB Export
Client ID:      MOU1003
Date/time:      2022-08-18 10:25:36.700
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB01
Database:       ULTIPRO_WPMCPL
Web Filename:   MOU1003_6O5TG_EEHISTORY_EMCPCOBRQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMCPCOBRQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EMCPCOBRQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMCPCOBRQB'


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
WHERE FormatCode = 'EMCPCOBRQB'
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
WHERE ExpFormatCode = 'EMCPCOBRQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMCPCOBRQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMCPCOBRQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMCPCOBRQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMCPCOBRQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMCPCOBRQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMCPCOBRQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMCPCOBRQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMCPCOBRQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMCPCOBRQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMCPCOBRQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMCPCOBRQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMCPCOBRQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMCPCOBRQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMCPCOBRQB];
GO
IF OBJECT_ID('U_EMCPCOBRQB_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_PEarHist];
GO
IF OBJECT_ID('U_EMCPCOBRQB_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_PDedHist];
GO
IF OBJECT_ID('U_EMCPCOBRQB_File') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_File];
GO
IF OBJECT_ID('U_EMCPCOBRQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_EEList];
GO
IF OBJECT_ID('U_EMCPCOBRQB_Edh_WorkingTable') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_Edh_WorkingTable];
GO
IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL];
GO
IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QB];
GO
IF OBJECT_ID('U_EMCPCOBRQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMCPCOBRQB_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMCPCOBRQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMCPCOBRQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMCPCOBRQB','MCP Cobra QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EMCPCOBRQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPCOBRQBZ0','50','H','01','1',NULL,'VersionIndicator',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPCOBRQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL,'"1.1"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPCOBRQBZ0','50','D','10','1',NULL,'QB Indicator',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPCOBRQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"Mountain Capital Partners"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMCPCOBRQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"Mountain Capital Partners"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMCPCOBRQBZ0','50','D','10','4',NULL,'C',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMCPCOBRQBZ0','50','D','10','5',NULL,'EmployeeFirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMCPCOBRQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMIddleInit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMCPCOBRQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMCPCOBRQBZ0','50','D','10','8',NULL,'EmployeeSSN',NULL,NULL,'"drvSsn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMCPCOBRQBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvIndividualId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMCPCOBRQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMCPCOBRQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMCPCOBRQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMCPCOBRQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMCPCOBRQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMCPCOBRQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMCPCOBRQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMCPCOBRQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMCPCOBRQBZ0','50','D','10','18',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMCPCOBRQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMCPCOBRQBZ0','50','D','10','20',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMCPCOBRQBZ0','50','D','10','21',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMCPCOBRQBZ0','50','D','10','22',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMCPCOBRQBZ0','50','D','10','23',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMCPCOBRQBZ0','50','D','10','24',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMCPCOBRQBZ0','50','D','10','25',NULL,NULL,NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMCPCOBRQBZ0','50','D','10','26',NULL,'Gender',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMCPCOBRQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMCPCOBRQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMCPCOBRQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMCPCOBRQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMCPCOBRQBZ0','50','D','10','31',NULL,NULL,NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMCPCOBRQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMCPCOBRQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMCPCOBRQBZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMCPCOBRQBZ0','50','D','10','35',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMCPCOBRQBZ0','50','D','10','36',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMCPCOBRQBZ0','50','D','10','37',NULL,NULL,NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPCOBRQBZ0','50','D','20','1',NULL,'QB Event Indicator',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPCOBRQBZ0','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMCPCOBRQBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMCPCOBRQBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMCPCOBRQBZ0','50','D','20','5',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSsn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMCPCOBRQBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMCPCOBRQBZ0','50','D','20','7',NULL,NULL,NULL,NULL,'" "','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMCPCOBRQBZ0','50','D','20','8',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMCPCOBRQBZ0','50','D','20','9',NULL,NULL,NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPCOBRQBZ0','50','D','30','1',NULL,'QBPAININITIAL Indicator',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPCOBRQBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMCPCOBRQBZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMCPCOBRQBZ0','50','D','30','4',NULL,NULL,NULL,NULL,'""','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPCOBRQBZ0','50','D','40','1',NULL,'QBDEPENDENT Indicator',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPCOBRQBZ0','50','D','40','2',NULL,'Dep SSN',NULL,NULL,'"drvSsn"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMCPCOBRQBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMCPCOBRQBZ0','50','D','40','4',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMCPCOBRQBZ0','50','D','40','5',NULL,'Dep First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMCPCOBRQBZ0','50','D','40','6',NULL,'Dep-MiddleInitial',NULL,NULL,'"drvNameMiddleInit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMCPCOBRQBZ0','50','D','40','7',NULL,'Dep- Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMCPCOBRQBZ0','50','D','40','8',NULL,'Dep- Email',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMCPCOBRQBZ0','50','D','40','9',NULL,'Dep-Phone',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMCPCOBRQBZ0','50','D','40','10',NULL,'Dep-Phone2',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMCPCOBRQBZ0','50','D','40','11',NULL,'Dep AddressSameAsQB',NULL,NULL,'"drvAddressSameAsQB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMCPCOBRQBZ0','50','D','40','12',NULL,'Dep-Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMCPCOBRQBZ0','50','D','40','13',NULL,'Dep-Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMCPCOBRQBZ0','50','D','40','14',NULL,'Dep City',NULL,NULL,'"drvAddressCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMCPCOBRQBZ0','50','D','40','15',NULL,'Dep State',NULL,NULL,'"drvAddressState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMCPCOBRQBZ0','50','D','40','16',NULL,'Dep Zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMCPCOBRQBZ0','50','D','40','17',NULL,NULL,NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMCPCOBRQBZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMCPCOBRQBZ0','50','D','40','19',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMCPCOBRQBZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMCPCOBRQBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMCPCOBRQBZ0','50','D','50','1',NULL,'QBDEPENDENTPLANINITIAL Ind',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMCPCOBRQBZ0','50','D','50','2',NULL,'Dep Plan  Name',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMCPCOBRQB_20220818.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202208059','EMPEXPORT','OEACTIVE',NULL,'EMCPCOBRQB',NULL,NULL,NULL,'202208059','Aug  5 2022  1:35PM','Aug  5 2022  1:35PM','202208051',NULL,'','','202208051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202208059','EMPEXPORT','OEPASSIVE',NULL,'EMCPCOBRQB',NULL,NULL,NULL,'202208059','Aug  5 2022  1:35PM','Aug  5 2022  1:35PM','202208051',NULL,'','','202208051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'202208059','EMPEXPORT','ONDEM_XOE',NULL,'EMCPCOBRQB',NULL,NULL,NULL,'202208059','Aug  5 2022  1:35PM','Aug  5 2022  1:35PM','202208051',NULL,'','','202208051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'202208059','EMPEXPORT','SCH_EMCPCO',NULL,'EMCPCOBRQB',NULL,NULL,NULL,'202208059','Aug  5 2022  1:35PM','Aug  5 2022  1:35PM','202208051',NULL,'','','202208051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,NULL,'202208059','EMPEXPORT','TEST_XOE',NULL,'EMCPCOBRQB',NULL,NULL,NULL,'202208059','Aug  5 2022  1:35PM','Aug  5 2022  1:35PM','202208051',NULL,'','','202208051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','InitialSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','SubSort2','C','drvSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','SubSort3','C','drvSort4');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMCPCOBRQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPCOBRQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPCOBRQB','D10','dbo.U_EMCPCOBRQB_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPCOBRQB','D20','dbo.U_EMCPCOBRQB_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPCOBRQB','D30','dbo.U_EMCPCOBRQB_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPCOBRQB','D40','dbo.U_EMCPCOBRQB_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMCPCOBRQB','D50','dbo.U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMCPCOBRQB
-----------

IF OBJECT_ID('U_dsi_BDM_EMCPCOBRQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMCPCOBRQB] (
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
-- Create table U_EMCPCOBRQB_DedList
-----------

IF OBJECT_ID('U_EMCPCOBRQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMCPCOBRQB_drvTbl_QB
-----------

IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvNameFirst] varchar(6000) NULL,
    [drvNameMIddleInit] varchar(1) NULL,
    [drvNameLast] varchar(6000) NULL,
    [drvSsn] char(11) NULL,
    [drvIndividualId] char(9) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(6002) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EMCPCOBRQB_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(12) NULL,
    [drvSort4] int NOT NULL,
    [drvSsn] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL
);

-----------
-- Create table U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL
-----------

IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(12) NULL,
    [drvSort4] int NOT NULL,
    [drvPlanName] varchar(32) NULL
);

-----------
-- Create table U_EMCPCOBRQB_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] int NOT NULL,
    [edhChangeReason] char(6) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSsn] char(11) NULL,
    [drvEmployeeName] varchar(201) NULL
);

-----------
-- Create table U_EMCPCOBRQB_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] char(5) NULL,
    [drvSort4] varchar(2) NOT NULL,
    [drvPlanName] varchar(31) NULL,
    [drvCoverageLevel] varchar(18) NULL
);

-----------
-- Create table U_EMCPCOBRQB_Edh_WorkingTable
-----------

IF OBJECT_ID('U_EMCPCOBRQB_Edh_WorkingTable') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_Edh_WorkingTable] (
    [EdhEEID] char(12) NOT NULL,
    [EdhCoID] char(5) NOT NULL,
    [EdhDedCode] char(5) NOT NULL,
    [EdhChangeReason] char(6) NULL,
    [EdhEffDate] datetime NULL
);

-----------
-- Create table U_EMCPCOBRQB_EEList
-----------

IF OBJECT_ID('U_EMCPCOBRQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMCPCOBRQB_File
-----------

IF OBJECT_ID('U_EMCPCOBRQB_File') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EMCPCOBRQB_PDedHist
-----------

IF OBJECT_ID('U_EMCPCOBRQB_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_PDedHist] (
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
-- Create table U_EMCPCOBRQB_PEarHist
-----------

IF OBJECT_ID('U_EMCPCOBRQB_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMCPCOBRQB_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMCPCOBRQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mountain Capital Partners

Created By: Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 08/05/2022
Service Request Number: TekP-2022-06-28-02

Purpose: MCP Cobra QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMCPCOBRQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMCPCOBRQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMCPCOBRQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMCPCOBRQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMCPCOBRQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPCOBRQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPCOBRQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPCOBRQB', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPCOBRQB', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMCPCOBRQB', 'SCH_EMCPCO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMCPCOBRQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMCPCOBRQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMCPCOBRQB';

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
    DELETE FROM dbo.U_EMCPCOBRQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMCPCOBRQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
     
     DELETE FROM dbo.U_EMCPCOBRQB_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE eecEEType IN('TES')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DNTL, VIS, HDHP, HLTH';

    IF OBJECT_ID('U_EMCPCOBRQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMCPCOBRQB_DedList
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


    --- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode; 
    
    -- Run BDM for Cobra
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
-- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  -- only used for NPM/QB combined files
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – 
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB', '201,204,210,LEVNT3,LEVNT4'); -- Add valid dependent edhchangereasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC,DPC') --- update to the child relationship codes
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); --- update to the domestic partner relationship code
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); -- same for all files



    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
  ---==========================================
 --   -- Insert into BDM Reason code 201 and 204
 --   --==========================================
    INSERT INTO [dbo].[U_dsi_BDM_EMCPCOBRQB]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    SELECT rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhBenStatusDate
        ,'204'
        ,'204'
        ,EdhStartDate
        ,EdhStopDate
        ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
    FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND dbnformatcode = 'EMCPCOBRQB'
    WHERE edhChangeReason in ('204') 
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
        AND dbnValidForExport = 'N'

    INSERT INTO [dbo].[U_dsi_BDM_EMCPCOBRQB]
    (    [BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
    )
    Select rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,EdhBenStartDate
        ,EdhBenStopDate
        ,EdhBenStatusDate
        ,EdhBenStatusDate
        ,'201'
        ,'201'
        ,EdhStartDate
        ,EdhStopDate
        ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND dbnformatcode = 'EMCPCOBRQB'
    WHERE edhChangeReason IN ('201') 
        and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'

    Delete from dbo.U_dsi_BDM_EMCPCOBRQB where bdmdedcode not in (Select dedcode from U_EMCPCOBRQB_DedList)


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMCPCOBRQB_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_PDedHist;
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
    INTO dbo.U_EMCPCOBRQB_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMCPCOBRQB_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMCPCOBRQB_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_PEarHist;
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
    INTO dbo.U_EMCPCOBRQB_PEarHist
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
    DECLARE @JcbDedCodes TABLE (DedCode VARCHAR(5));

    INSERT INTO @JcbDedCodes VALUES ('DNTL'),('VIS'),('HDHP'),('HLTH'); 
    IF OBJECT_ID('U_EMCPCOBRQB_Edh_WorkingTable','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_Edh_WorkingTable;
    SELECT EdhEEID, EdhCoID, EdhDedCode, EdhChangeReason, EdhEffDate
    INTO dbo.U_EMCPCOBRQB_Edh_WorkingTable
    FROM    (
                SELECT EDHEEID, EdhCOID, EdhDedCode, edhChangeReason, EdhEffDate, ROW_NUMBER() OVER(PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS rn 
                FROM dbo.EmpHDed a WITH (NOLOCK)
                WHERE EdhDedCode IN ('DNTL', 'VIS', 'HDHP', 'HLTH') 
                    AND edhChangeReason IN ('204', 'LEVNT4', '210', '201', '205', '200', '203', '206')
            ) AS T
    WHERE rn = 1;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMCPCOBRQB_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID --'' --EdhChangeReason 
        ,drvSort2 = 1
        ,drvSort3 = '' --BdmRecType
        ,drvSort4 = '' --ConRelationship + ' -- ' + BdmCobraReason
        -- standard fields above and additional driver fields below
        ,drvNameFirst = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN dbo.dsi_fnRemoveChars('.,/-',ConNameFirst) ELSE dbo.dsi_fnRemoveChars('.,/-',EepNameFirst)END
        ,drvNameMIddleInit = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN LEFT(EepNameMiddle, 1) ELSE LEFT(EepNameMiddle,1) END
        ,drvNameLast = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201')THEN dbo.dsi_fnRemoveChars('.,/-',ConNameLast) ELSE dbo.dsi_fnRemoveChars('.,/-',EepNameLast) END
        ,drvSsn = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN ConSSN ELSE EepSsn END
        ,drvIndividualId = EecEmpNo
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvAddressLine1 = '"' + CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN dbo.dsi_fnRemoveChars('.,/-',ConAddressLine1) ELSE dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1) END + '"'
        ,drvAddressLine2 = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN dbo.dsi_fnRemoveChars('.,/-',ConAddressLine2) ELSE dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2) END
        ,drvAddressCity = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN EdhChangeReason IN ('LEVNT4', '204', '210', '201') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvGender = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') and ConGender = 'M' THEN 'M'
                          WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') and ConGender = 'F' THEN 'F'
                         ELSE 
                         CASE WHEN EepGender = 'M' THEN 'M'
                              WHEN EepGender = 'F' THEN 'F' 
                              WHEN EepGender not in ('M','F') and ConGender not in ('M','F') THEN 'U'
                             END
                        END
        ,drvDateOfBirth = CASE WHEN EdhChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') THEN ConDateOfBirth ELSE EepDateOfBirth END
    INTO dbo.U_EMCPCOBRQB_drvTbl_QB
    FROM dbo.U_EMCPCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    Left JOIN dbo.U_dsi_BDM_EMCPCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_EMCPCOBRQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    --WHERE (BdmRecType = 'EMP' AND BdmCobraReason NOT IN ('210'))
       -- OR (ConRelationship IN ('SPS') AND BdmCobraReason IN ('210'))
    ;
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMCPCOBRQB_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_drvTbl_QBEVENT;
     SELECT DISTINCT
            drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID --ISNULL(BdmCobraReason, '**') + ' -- ' + ISNULL(EepCobraReason, '*')
        ,drvSort2 =  3 
        ,drvSort3 = '' --ConNameFirst
        ,drvSort4 = 1
        ,edhChangeReason
        ,drvEventType = CASE WHEN EecEmplStatus = 'T' AND EdhChangeReason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION' 
                             WHEN EecEmplStatus  = 'T' AND EecTermReason  = '203' THEN 'DEATH'
                             WHEN EecEmplStatus = 'T' AND EdhChangeReason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                             WHEN EecEmplStatus = 'T' AND EdhChangeReason = '205' THEN 'MEDICARE'
                             WHEN EecEmplStatus  = 'T' AND EecTermReason NOT IN ( '202', ' 203') and eectermtype = 'V' THEN 'TERMINATION'
                             WHEN EecEmplStatus  = 'T' AND EecTermReason NOT IN ( '202', ' 203') and eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                             WHEN EecEmplStatus  = 'T' AND EdhChangeReason = '208' AND EecTermReason = '202' THEN 'RETIREMENT' 
                             WHEN EecEmplStatus = 'T' AND EdhChangeReason in ('203' , '202' ) THEN  'REDUCTIONINHOURS-STATUSCHANGE' 
                             WHEN edhChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                          
                        END
        ,drvEventDate = CASE WHEN EecEmplStatus = 'T' and EecTermReason  not in ( '202', '203') THEN EecDateOfTermination
                             WHEN EecEmplStatus = 'T' and EecTermReason  in ( '202', '203') and BdmDateOfCOBRAEvent is not null THEN EecDateOfTermination
                             WHEN edhChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210', '201') THEN edheffdate
                            ELSE  eepDateOfCOBRAEvent
                        END
        ,drvEnrollmentDate = EecDateOfLastHire
        ,drvEmployeeSsn = eepSSN
        ,drvEmployeeName = eepnamefirst + ' ' + eepnamelast
    INTO dbo.U_EMCPCOBRQB_drvTbl_QBEVENT
    FROM dbo.U_EMCPCOBRQB_EEList WITH (NOLOCK)
   JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
 
   Left JOIN (
        SELECT BdmEEID, BdmCOID, BdmBenStartDate, BdmDateOfCOBRAEvent, BdmDepRecId, BdmDedCode, BdmCobraReason
        FROM (
            SELECT BdmEEID, BdmCOID, BdmBenStartDate, BdmRecType, BdmDedType, BdmDedCode, BdmDateOfCOBRAEvent, BdmCobraReason, BdmDepRecId
                ,ROW_NUMBER() OVER(PARTITION BY BdmEEID, BdmCOID ORDER BY 
                                                                        CASE WHEN BdmDedType = 'MED' THEN 1
                                                                            WHEN BdmDedType = 'DEN' THEN 2
                                                                            WHEN BdmDedType = 'VIS' THEN 3
                                                                            ELSE 4
                                                                        END, 
                                                                    BdmRecType DESC) AS RN
            FROM dbo.U_dsi_BDM_EMCPCOBRQB WITH (NOLOCK)) AS T
            WHERE RN = 1) AS BDM_Consolidated
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
        --AND a.EdhChangeReason IN ('204', 'LEVNT4', '210', '201')
   JOIN dbo.U_EMCPCOBRQB_Edh_WorkingTable a
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMCPCOBRQB_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
         ,drvSort1 = xEEID --BdmDedCode
        ,drvSort2 = 3 --BdmBenOption
        ,drvSort3 = BdmDedCode
        ,drvSort4 = '01' --'2' +
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('DNTL') THEN 'Ameritas Dental Plan'
                            WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('VIS') THEN 'Ameritas Vision Plan'
                            WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HDHP') THEN 'EBMS Consumer HDHP Medical Plan'
                            WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HLTH') THEN 'EBMS PPO Medical Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('DNTL') THEN 'Ameritas Dental Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('VIS') THEN 'Ameritas Vision Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HDHP') THEN 'EBMS Consumer HDHP Medical Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HLTH') THEN 'EBMS PPO Medical Plan'
                           
                        END
        ,drvCoverageLevel =    CASE WHEN BdmCobraReason IN ('210') THEN
                                CASE WHEN BdmRelationship IN ('SPS','DP') AND (SELECT COUNT(*) FROM dbo.U_dsi_BDM_EMCPCOBRQB B WITH (NOLOCK) WHERE BdmEEID = B.BdmEEID AND B.BdmRelationship IN ('CH','CHL','DPC','STC','DCH')) > 0 THEN 'EE+CHILDREN'
                                    WHEN BdmRelationship IN ('CH','CHL','DPC','STC','DCH') THEN 'EE+CHILDREN'
                                    ELSE 'EE'
                                END
                            ELSE
                                CASE WHEN bdmChangeReason IN ('204','LEVNT4','201','302','LEVNT3') OR (EecEmplStatus ='T' AND EecTermReason = '203') THEN 'EE'
                                    WHEN BdmDedCode = 'FSA' THEN 'EE'
                                    WHEN BdmBenOption = 'EE' THEN 'EE'
                                    WHEN BdmBenOption = 'EEC' THEN 'EE+CHILDREN'
                                    WHEN BdmBenOption = 'EDP' THEN 'EE+DOMESTICPARTNER'
                                    WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'EE+FAMILY'
                                    WHEN BdmBenOption = 'EES' THEN 'EE+SPOUSE'
                                END
                            END
    INTO dbo.U_EMCPCOBRQB_drvTbl_QBPLANINITIAL
    FROM dbo.U_EMCPCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EMCPCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EMCPCOBRQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
      Where isnull(CASE WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('DNTL') THEN 'Ameritas Dental Plan'
                            WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('VIS') THEN ' Ameritas Vision Plan'
                            WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HDHP') THEN ' EBMS Consumer HDHP Medical Plan'
                            WHEN bdmChangeReason IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HLTH') THEN 'EBMS PPO Medical Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('DNTL') THEN 'Ameritas Dental Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('VIS') THEN ' Ameritas Vision Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HDHP') THEN ' EBMS Consumer HDHP Medical Plan'
                            WHEN bdmChangeReason NOT IN ('LEVNT3','LEVNT4', '204', '210', '201') AND BdmDedCode IN ('HLTH') THEN 'EBMS PPO Medical Plan'
                           
                        END,'') <> ''
     
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMCPCOBRQB_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
          drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = 1
        -- standard fields above and additional driver fields below
        ,drvSsn = ConSSN
        ,drvRelationship =    CASE WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                                WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                                WHEN ConRelationship IN ('CHL', 'DPC', 'STC') THEN 'CHILD'
                            END
        ,drvNameFirst = ConNameFirst
        ,drvNameMiddleInit = LEFT(ConNameMiddle,1)
        ,drvNameLast = ConNameLast
        ,drvAddressSameAsQB =    CASE WHEN ConAddressIsDifferent = 'N' THEN 'TRUE' ELSE 'FALSE' END
        ,drvAddressLine1 =    CASE WHEN ConAddressIsDifferent = 'Y' THEN dbo.dsi_fnRemoveChars('.,/-',ConAddressLine1) END
        ,drvAddressLine2 = CASE WHEN ConAddressIsDifferent = 'Y' THEN dbo.dsi_fnRemoveChars('.,/-',ConAddressLine2) END
        ,drvAddressCity = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressCity END
        ,drvAddressState = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressState END
        ,drvAddressZipCode = CASE WHEN ConAddressIsDifferent = 'Y' THEN ConAddressZipCode END
        ,drvGender = Case WHEN ConGender in ('M', 'F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth = ConDateOfBirth
    INTO dbo.U_EMCPCOBRQB_drvTbl_QBDEPENDENT
    FROM dbo.U_EMCPCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EMCPCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecId
    JOIN dbo.U_EMCPCOBRQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    WHERE EdhChangeReason NOT IN ('LEVNT4', '204', '201', '210') 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL;
    SELECT DISTINCT
       drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = BdmDepRecId
        ,drvSort4 = 2
        -- standard fields above and additional driver fields below
        ,drvPlanName =    CASE WHEN BdmDedCode IN ('DNTL') THEN 'Ameritas Dental Plan'
                            WHEN BdmDedCode IN ('HDHP') THEN ' EBMS Consumer HDHP Medical Plan'
                            WHEN BdmDedCode IN ('HLTH') THEN 'EBMS PPO Medical Plan'
                            WHEN BdmDedCode IN ('VIS') THEN 'Ameritas Vision Plan'
                        END 
    INTO dbo.U_EMCPCOBRQB_drvTbl_QBDEPENDENTPLANINITIAL
    FROM dbo.U_EMCPCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EMCPCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType <> 'EMP'
    JOIN dbo.U_EMCPCOBRQB_Edh_WorkingTable
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    WHERE EdhChangeReason NOT IN ('LEVNT4', '204', '201', '210') 
    and   isnull( CASE WHEN BdmDedCode IN ('DNTL') THEN 'Ameritas Dental Plan'
                            WHEN BdmDedCode IN ('HDHP') THEN ' EBMS Consumer HDHP Medical Plan'
                            WHEN BdmDedCode IN ('HLTH') THEN 'EBMS PPO Medical Plan'
                            WHEN BdmDedCode IN ('VIS') THEN 'Ameritas Vision Plan'
                        END , '') <> ''
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
ALTER VIEW dbo.dsi_vwEMCPCOBRQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMCPCOBRQB_File (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3,RIGHT(RecordSet,2);

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMCPCOBRQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202207291'
       ,expStartPerControl     = '202207291'
       ,expLastEndPerControl   = '202208059'
       ,expEndPerControl       = '202208059'
WHERE expFormatCode = 'EMCPCOBRQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMCPCOBRQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMCPCOBRQB_File (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3,RIGHT(RecordSet,2);

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMCPCOBRQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMCPCOBRQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMCPCOBRQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMCPCOBRQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMCPCOBRQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMCPCOBRQB', 'UseFileName', 'V', 'Y'


-- End ripout