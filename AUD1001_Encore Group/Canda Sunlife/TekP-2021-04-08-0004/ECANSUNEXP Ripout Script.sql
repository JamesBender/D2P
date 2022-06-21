/**********************************************************************************

ECANSUNEXP: Canada Sunlife XML Export

FormatCode:     ECANSUNEXP
Project:        Canada Sunlife XML Export
Client ID:      AUD1001
Date/time:      2022-06-10 04:53:54.180
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    N21
Server:         N2SUP1ST51
Database:       ULTIPRO_AUDV
Web Filename:   AUD1001_11893_EEHISTORY_ECANSUNEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECANSUNEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ECANSUNEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECANSUNEXP'


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
WHERE FormatCode = 'ECANSUNEXP'
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
WHERE ExpFormatCode = 'ECANSUNEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECANSUNEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECANSUNEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECANSUNEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECANSUNEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECANSUNEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECANSUNEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECANSUNEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECANSUNEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECANSUNEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECANSUNEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECANSUNEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECANSUNEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECANSUNEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECANSUNEXP];
GO
IF OBJECT_ID('U_ECANSUNEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_PEarHist];
GO
IF OBJECT_ID('U_ECANSUNEXP_Loader') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_Loader];
GO
IF OBJECT_ID('U_ECANSUNEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_File];
GO
IF OBJECT_ID('U_ECANSUNEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_EEList];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Salary];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_PersonLink];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Person];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Member];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Benefits];
GO
IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_drvTbl_Address];
GO
IF OBJECT_ID('U_ECANSUNEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECANSUNEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECANSUNEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECANSUNEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECANSUNEXP','Canada Sunlife XML Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECANSUNEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','H','01','1',NULL,'Envelope Header',NULL,NULL,'"<?xml version="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','H','01','2',NULL,'Envelope Header',NULL,NULL,'"1.0"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','H','01','3',NULL,'Envelope Header',NULL,NULL,'" encoding="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','H','01','4',NULL,'Envelope Header',NULL,NULL,'"ISO-8859-1"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','H','01','5',NULL,'Envelope Header',NULL,NULL,'"?>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','H','02','1',NULL,'File Header - Load',NULL,NULL,'"<Loader PolicyNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','H','02','2',NULL,'File Header',NULL,NULL,'"drvPolicyNum"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','H','02','3',NULL,'File Header',NULL,NULL,'" ClientName="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','H','02','4',NULL,'File Header',NULL,NULL,'"drvClientName"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','H','02','5',NULL,'File Header',NULL,NULL,'" ReportLanguageCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECANSUNEXPZ0','50','H','02','6',NULL,'File Header',NULL,NULL,'"drvReportLanguageCd"','(''UA''=''Q>'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','D','10','1',NULL,'Parent Level: Member (Start Loop)',NULL,NULL,'"<Member PolicyNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','D','10','2',NULL,'Employee - PolicyNum (Value)',NULL,NULL,'"drvPolicyNum"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','D','10','3',NULL,'Member - LocationNum',NULL,NULL,'" LocationNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','D','10','4',NULL,'Member - LocationNum (Value)',NULL,NULL,'"drvLocationNum"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','D','10','5',NULL,'Member - ClassNum',NULL,NULL,'" ClassNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECANSUNEXPZ0','50','D','10','6',NULL,'Member - ClassNum (Value)',NULL,NULL,'"drvClassNum"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECANSUNEXPZ0','50','D','10','7',NULL,'Member - PlanNum',NULL,NULL,'" PlanNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECANSUNEXPZ0','50','D','10','8',NULL,'Member - PlanNum (Value)',NULL,NULL,'"drvPlanNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECANSUNEXPZ0','50','D','10','9',NULL,'Member - CertificateNum',NULL,NULL,'" CertificateNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECANSUNEXPZ0','50','D','10','10',NULL,'Member - CertificateNum (Value)',NULL,NULL,'"drvCertificateNum"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECANSUNEXPZ0','50','D','10','11',NULL,'Member - PayrollNum',NULL,NULL,'" PayrollNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECANSUNEXPZ0','50','D','10','12',NULL,'Member - PayrollNum (Value)',NULL,NULL,'"drvPayrollNum"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECANSUNEXPZ0','50','D','10','13',NULL,'Member - EmploymentDt',NULL,NULL,'" EmploymentDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECANSUNEXPZ0','50','D','10','14',NULL,'Member - EmploymentDt (Value)',NULL,NULL,'"drvEmploymentDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECANSUNEXPZ0','50','D','10','15',NULL,'Member - WorkResidenceCd',NULL,NULL,'" WorkResidenceCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECANSUNEXPZ0','50','D','10','16',NULL,'Member - WorkResidenceCd (Value)',NULL,NULL,'"drvWorkResidenceCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECANSUNEXPZ0','50','D','10','17',NULL,'Member - Beneficiary',NULL,NULL,'" Beneficiary="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECANSUNEXPZ0','50','D','10','18',NULL,'Member - Beneficiary (Value)',NULL,NULL,'"drvBeneficiary"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECANSUNEXPZ0','50','D','10','19',NULL,'Member - Beneficiary',NULL,NULL,'" AltBillSort5="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECANSUNEXPZ0','50','D','10','20',NULL,'Member - Beneficiary (Value)',NULL,NULL,'"drvAltBillSort5"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECANSUNEXPZ0','50','D','10','21',NULL,'Member - StatusCd',NULL,NULL,'" StatusCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECANSUNEXPZ0','50','D','10','22',NULL,'Member - StatusCd (Value)',NULL,NULL,'"drvStatusCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECANSUNEXPZ0','50','D','10','23',NULL,'Member - TermDt',NULL,NULL,'" TermDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECANSUNEXPZ0','50','D','10','24',NULL,'Member - TermDt (Value)',NULL,NULL,'"drvTermDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECANSUNEXPZ0','50','D','10','25',NULL,'Member - TermReasonCd',NULL,NULL,'"drvTermReasnonCdHeader"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECANSUNEXPZ0','50','D','10','26',NULL,'Member - TermReasonCd (Value)',NULL,NULL,'"drvTermReasonCd"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECANSUNEXPZ0','50','D','10','27',NULL,'Member - UpdateFlag',NULL,NULL,'" UpdateFlag="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECANSUNEXPZ0','50','D','10','28',NULL,'Member - UpdateFlag (Value)',NULL,NULL,'"drvUpdateFlag"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECANSUNEXPZ0','50','D','10','29',NULL,'Member - ApplyDate',NULL,NULL,'" ApplyDate="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECANSUNEXPZ0','50','D','10','30',NULL,'Member - ApplyDate (Value)',NULL,NULL,'"drvApplyDate"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECANSUNEXPZ0','50','D','10','31',NULL,'Member - TransferFlg',NULL,NULL,'" TransferFlg="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECANSUNEXPZ0','50','D','10','32',NULL,'Member - TransferFlg (Value)',NULL,NULL,'"drvTransferFlg"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECANSUNEXPZ0','50','D','10','32',NULL,'Member - ReinstatementFlg',NULL,NULL,'" ReinstatementFlg="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECANSUNEXPZ0','50','D','10','34',NULL,'Member - ReinstatementFlg (Value)',NULL,NULL,'"drvReinstatementFlg"','(''UA''=''Q>'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','D','20','1',NULL,'Child Level: Person of Member (Start Loop)',NULL,NULL,'"<Person FirstNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','D','20','2',NULL,'Person - FirstNm (Value)',NULL,NULL,'"drvFirstNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','D','20','3',NULL,'Person - LastNm',NULL,NULL,'" LastNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','D','20','4',NULL,'Person - LastNm (Value)',NULL,NULL,'"drvLastNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','D','20','5',NULL,'Person - BirthDt',NULL,NULL,'" BirthDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECANSUNEXPZ0','50','D','20','6',NULL,'Person - BirthDt (Value)',NULL,NULL,'"drvBirthDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECANSUNEXPZ0','50','D','20','7',NULL,'Person - ResidenceCd',NULL,NULL,'" ResidenceCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECANSUNEXPZ0','50','D','20','8',NULL,'Person - ResidenceCd (Value)',NULL,NULL,'"drvResidenceCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECANSUNEXPZ0','50','D','20','9',NULL,'Person - GenderCd',NULL,NULL,'" GenderCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECANSUNEXPZ0','50','D','20','10',NULL,'Person - GenderCd (Value)',NULL,NULL,'"drvGenderCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECANSUNEXPZ0','50','D','20','11',NULL,'Person - SmokerFlg',NULL,NULL,'" SmokerFlg="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECANSUNEXPZ0','50','D','20','12',NULL,'Person - SmokerFlg (Value)',NULL,NULL,'"drvSmokerFlg"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECANSUNEXPZ0','50','D','20','13',NULL,'Person - DepTypeCd',NULL,NULL,'" DepTypeCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECANSUNEXPZ0','50','D','20','14',NULL,'Person - DepTypeCd (Value)',NULL,NULL,'"drvDepTypeCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECANSUNEXPZ0','50','D','20','15',NULL,'Person - LanguageCd',NULL,NULL,'" LanguageCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECANSUNEXPZ0','50','D','20','16',NULL,'Person - LanguageCd (Value)',NULL,NULL,'"drvLanguageCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECANSUNEXPZ0','50','D','20','17',NULL,'Person',NULL,NULL,'" />','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','D','30','1',NULL,'Child Level: Salary of Member (Start Loop)',NULL,NULL,'"<Salary SalaryDescCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','D','30','2',NULL,'Salary - SalaryDescCd (Value)',NULL,NULL,'"drvSalaryDescCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','D','30','3',NULL,'Salary - SalaryBasisCd',NULL,NULL,'" SalaryBasisCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','D','30','4',NULL,'Salary - SalaryBasisCd (Value)',NULL,NULL,'"drvSalaryBasisCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','D','30','5',NULL,'Salary - SalaryAmt',NULL,NULL,'" SalaryAmt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECANSUNEXPZ0','50','D','30','6',NULL,'Salary - SalaryAmt (Value)',NULL,NULL,'"drvSalaryAmt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECANSUNEXPZ0','50','D','30','9',NULL,'Salary - EffectiveDt',NULL,NULL,'" EffectiveDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECANSUNEXPZ0','50','D','30','10',NULL,'Salary - EffectiveDt (Value)',NULL,NULL,'"drvEffectiveDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECANSUNEXPZ0','50','D','30','11',NULL,'Salary',NULL,NULL,'" />"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','D','40','1',NULL,'Address - AddressTypeCd',NULL,NULL,'"<Address AddressTypeCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','D','40','2',NULL,'Address - AddressTypeCd (Value)',NULL,NULL,'"drvAddressTypeCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','D','40','3',NULL,'Address - AddressNm',NULL,NULL,'" AddressNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','D','40','4',NULL,'Address - AddressNm (Value)',NULL,NULL,'"drvAddressNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','D','40','5',NULL,'Address - StreetAddressNm',NULL,NULL,'" StreetAddressNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECANSUNEXPZ0','50','D','40','6',NULL,'Address - StreetAddressNm (Value)',NULL,NULL,'"drvStreetAddressNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECANSUNEXPZ0','50','D','40','7',NULL,'Address - SuiteNm',NULL,NULL,'" SuiteNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECANSUNEXPZ0','50','D','40','8',NULL,'Address - SuiteNm (Value)',NULL,NULL,'"drvSuiteNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECANSUNEXPZ0','50','D','40','9',NULL,'Address - CityNm',NULL,NULL,'" CityNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECANSUNEXPZ0','50','D','40','10',NULL,'Address - CityNm (Value)',NULL,NULL,'"drvCityNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECANSUNEXPZ0','50','D','40','11',NULL,'Address - StateOrProvCd',NULL,NULL,'" StateOrProvCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECANSUNEXPZ0','50','D','40','12',NULL,'Address - StateOrProvCd (Value)',NULL,NULL,'"drvStateOrProvCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECANSUNEXPZ0','50','D','40','13',NULL,'Address - PostalNum',NULL,NULL,'" PostalNum="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECANSUNEXPZ0','50','D','40','14',NULL,'Address - PostalNum (Value)',NULL,NULL,'"drvPostalNum"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECANSUNEXPZ0','50','D','40','15',NULL,'Address - CountryCd',NULL,NULL,'" CountryCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECANSUNEXPZ0','50','D','40','16',NULL,'Address - CountryCd (Value)',NULL,NULL,'"drvCountryCd"','(''UA''=''Q/>'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECANSUNEXPZ0','50','D','40','17',NULL,'Address',NULL,NULL,'"/>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','D','50','1',NULL,'Child Level: PersonLink of Member (Start Loop)',NULL,NULL,'"<PersonLink PersonLinkTypeCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','D','50','2',NULL,'PersonLink - PersonLinkTypeCd (Value)',NULL,NULL,'"drvPersonLinkTypeCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','D','50','3',NULL,'PersonLink - FirstNm',NULL,NULL,'"FirstNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','D','50','4',NULL,'PersonLink- FirstNm (Value)',NULL,NULL,'"drvFirstNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','D','50','5',NULL,'PersonLink- LastNm',NULL,NULL,'" LastNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECANSUNEXPZ0','50','D','50','6',NULL,'PersonLink- LastNm (Value)',NULL,NULL,'"drvLastNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECANSUNEXPZ0','50','D','50','7',NULL,'PersonLink- BirthDt',NULL,NULL,'" BirthDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECANSUNEXPZ0','50','D','50','8',NULL,'PersonLink- BirthDt (Value)',NULL,NULL,'"drvBirthDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECANSUNEXPZ0','50','D','50','9',NULL,'PersonLink- GenderCd',NULL,NULL,'" GenderCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECANSUNEXPZ0','50','D','50','10',NULL,'PersonLink - GenderCd (Value)',NULL,NULL,'"drvGenderCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECANSUNEXPZ0','50','D','50','11',NULL,'PersonLink - SmokerFlg',NULL,NULL,'" SmokerFlg="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECANSUNEXPZ0','50','D','50','12',NULL,'PersonLink - SmokerFlg (Value)',NULL,NULL,'"drvSmokerFlg"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECANSUNEXPZ0','50','D','50','13',NULL,'PersonLink - InSchoolFlg',NULL,NULL,'" InSchoolFlg="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECANSUNEXPZ0','50','D','50','14',NULL,'PersonLink - InSchoolFlg (Value)',NULL,NULL,'"drvInSchoolFlg"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECANSUNEXPZ0','50','D','50','15',NULL,'PersonLink - EffectiveDt',NULL,NULL,'" EffectiveDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECANSUNEXPZ0','50','D','50','16',NULL,'PersonLink - EffectiveDt (Value)',NULL,NULL,'"drvEffectiveDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECANSUNEXPZ0','50','D','50','17',NULL,'PersonLink - TermDt',NULL,NULL,'" TermDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECANSUNEXPZ0','50','D','50','18',NULL,'PersonLink - TermDt (Value)',NULL,NULL,'"drvTermDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECANSUNEXPZ0','50','D','50','19',NULL,'PersonLink - TermReasonCd',NULL,NULL,'"drvTermReasnonCdHeader"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECANSUNEXPZ0','50','D','50','20',NULL,'PersonLink - TermReasonCd (Value)',NULL,NULL,'"drvTermReasonCd"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECANSUNEXPZ0','50','D','50','21',NULL,'PersonLink - StatusCd',NULL,NULL,'" StatusCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECANSUNEXPZ0','50','D','50','22',NULL,'PersonLink - StatusCd (Value)',NULL,NULL,'"drvStatusCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECANSUNEXPZ0','50','D','50','23',NULL,'PersonLink - OldFirstNm',NULL,NULL,'" OldFirstNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECANSUNEXPZ0','50','D','50','24',NULL,'PersonLink - OldFirstNm (Value)',NULL,NULL,'"drvOldFirstNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECANSUNEXPZ0','50','D','50','25',NULL,'PersonLink',NULL,NULL,'"/>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','D','60','1',NULL,'Child Level: Benefits (Start Loop)',NULL,NULL,'"<Benefits BenefitType="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECANSUNEXPZ0','50','D','60','2',NULL,'Benefits - BenefitType (Value)',NULL,NULL,'"drvBenefitType"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECANSUNEXPZ0','50','D','60','3',NULL,'Benefits - FlexCodeNm',NULL,NULL,'" FlexCodeNm="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECANSUNEXPZ0','50','D','60','4',NULL,'Benefits - FlexCodeNm (Value)',NULL,NULL,'"drvFlexCodeNm"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECANSUNEXPZ0','50','D','60','5',NULL,'Benefits - DepTypeCd',NULL,NULL,'" DepTypeCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECANSUNEXPZ0','50','D','60','6',NULL,'Benefits - DepTypeCd (Value)',NULL,NULL,'"drvDepTypeCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECANSUNEXPZ0','50','D','60','7',NULL,'Benefits - EffectiveDt',NULL,NULL,'" EffectiveDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECANSUNEXPZ0','50','D','60','8',NULL,'Benefits - EffectiveDt (Value)',NULL,NULL,'"drvEffectiveDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECANSUNEXPZ0','50','D','60','13',NULL,'Benefits - StatusCd',NULL,NULL,'" StatusCd="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECANSUNEXPZ0','50','D','60','14',NULL,'Benefits - StatusCd (Value)',NULL,NULL,'"drvStatusCd"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECANSUNEXPZ0','50','D','60','15',NULL,'Benefits - TermReasonCd',NULL,NULL,'"drvTermReasnonCdHeader"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECANSUNEXPZ0','50','D','60','16',NULL,'Benefits - TermReasonCd (Value)',NULL,NULL,'"drvTermReasonCd"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECANSUNEXPZ0','50','D','60','17',NULL,'Benefits - TermDt',NULL,NULL,'" TermDt="','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECANSUNEXPZ0','50','D','60','18',NULL,'Benefits - TermDt (Value)',NULL,NULL,'"drvTermDt"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECANSUNEXPZ0','50','D','60','19',NULL,'Benefits - TermDt',NULL,NULL,'"/>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','D','70','1',NULL,'Parent Level: Member (End Loop)',NULL,NULL,'"</Member>"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECANSUNEXPZ0','50','T','90','1',NULL,'File Trailer',NULL,NULL,'"</Loader>"','(''DA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECANSUNEXP_20220610.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202108059','EMPEXPORT','OEACTIVE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202108059','EMPEXPORT','OEPASSIVE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Canada Sunlife XML Export','202108059','EMPEXPORT','ONDEM_XOE',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Canada Sunlife XML Expor-Sched','202108059','EMPEXPORT','SCH_ECANSU',NULL,'ECANSUNEXP',NULL,NULL,NULL,'202108059','Aug  5 2021 11:14AM','Aug  5 2021 11:14AM','202108051',NULL,'','','202108051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','0JWM2,2CVHL,LMQT8',NULL,NULL,NULL,'Canada Sunlife XML Expor-Test','202206019','EMPEXPORT','TEST_XOE','Jun  1 2022 12:09PM','ECANSUNEXP',NULL,NULL,NULL,'202206019','Jun  1 2022 12:00AM','Dec 30 1899 12:00AM','202205181','9440','','','202205181',dbo.fn_GetTimedKey(),NULL,'us3lKiAUD1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECANSUNEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','H02','dbo.U_ECANSUNEXP_Loader',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D10','dbo.U_ECANSUNEXP_drvTbl_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D20','dbo.U_ECANSUNEXP_drvTbl_Person',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D30','dbo.U_ECANSUNEXP_drvTbl_Salary',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D40','dbo.U_ECANSUNEXP_drvTbl_Address',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D50','dbo.U_ECANSUNEXP_drvTbl_PersonLink',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D60','dbo.U_ECANSUNEXP_drvTbl_Benefits',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','D70','dbo.U_ECANSUNEXP_drvTbl_Member',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECANSUNEXP','T90','None',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECANSUNEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ECANSUNEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECANSUNEXP] (
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
-- Create table U_ECANSUNEXP_DedList
-----------

IF OBJECT_ID('U_ECANSUNEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECANSUNEXP_drvTbl_Address
-----------

IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Address] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvAddressTypeCd] varchar(1) NOT NULL,
    [drvAddressNm] varchar(201) NULL,
    [drvStreetAddressNm] varchar(510) NULL,
    [drvSuiteNm] varchar(1) NOT NULL,
    [drvCityNm] varchar(255) NULL,
    [drvStateOrProvCd] varchar(2) NULL,
    [drvPostalNum] varchar(50) NULL,
    [drvCountryCd] varchar(1) NOT NULL
);

-----------
-- Create table U_ECANSUNEXP_drvTbl_Benefits
-----------

IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Benefits] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvBenefitType] varchar(3) NULL,
    [drvFlexCodeNm] varchar(1) NOT NULL,
    [drvDepTypeCd] varchar(1) NOT NULL,
    [drvEffectiveDt] varchar(10) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(3) NULL,
    [drvTermDt] varchar(10) NULL
);

-----------
-- Create table U_ECANSUNEXP_drvTbl_Member
-----------

IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Member] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvLocationNum] varchar(3) NULL,
    [drvClassNum] varchar(3) NULL,
    [drvPlanNm] varchar(3) NULL,
    [drvCertificateNum] char(10) NULL,
    [drvPayrollNum] varchar(1) NOT NULL,
    [drvEmploymentDt] varchar(10) NULL,
    [drvWorkResidenceCd] varchar(2) NULL,
    [drvBeneficiary] varchar(1) NOT NULL,
    [drvAltBillSort5] char(6) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvTermDt] varchar(10) NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(3) NULL,
    [drvUpdateFlag] varchar(5) NOT NULL,
    [drvApplyDate] varchar(10) NULL,
    [drvTransferFlg] varchar(8) NOT NULL,
    [drvReinstatementFlg] varchar(5) NOT NULL
);

-----------
-- Create table U_ECANSUNEXP_drvTbl_Person
-----------

IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Person] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvFirstNm] varchar(100) NULL,
    [drvLastNm] varchar(100) NULL,
    [drvBirthDt] varchar(10) NULL,
    [drvResidenceCd] varchar(2) NULL,
    [drvGenderCd] varchar(1) NOT NULL,
    [drvSmokerFlg] varchar(5) NOT NULL,
    [drvDepTypeCd] varchar(1) NOT NULL,
    [drvLanguageCd] varchar(1) NOT NULL
);

-----------
-- Create table U_ECANSUNEXP_drvTbl_PersonLink
-----------

IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_PersonLink] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvPersonLinkTypeCd] varchar(1) NULL,
    [drvFirstNm] varchar(100) NULL,
    [drvLastNm] varchar(100) NULL,
    [drvBirthDt] varchar(10) NULL,
    [drvGenderCd] char(1) NULL,
    [drvSmokerFlg] varchar(5) NOT NULL,
    [drvInSchoolFlg] varchar(1) NOT NULL,
    [drvEffectiveDt] varchar(1) NOT NULL,
    [drvTermDt] datetime NULL,
    [drvTermReasnonCdHeader] varchar(14) NULL,
    [drvTermReasonCd] varchar(1) NULL,
    [drvStatusCd] varchar(1) NOT NULL,
    [drvOldFirstNm] varchar(1) NOT NULL
);

-----------
-- Create table U_ECANSUNEXP_drvTbl_Salary
-----------

IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_drvTbl_Salary] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(12) NULL,
    [drvSalaryDescCd] varchar(1) NOT NULL,
    [drvSalaryBasisCd] varchar(1) NOT NULL,
    [drvSalaryAmt] nvarchar(4000) NULL,
    [drvEffectiveDt] varchar(10) NULL
);

-----------
-- Create table U_ECANSUNEXP_EEList
-----------

IF OBJECT_ID('U_ECANSUNEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECANSUNEXP_File
-----------

IF OBJECT_ID('U_ECANSUNEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ECANSUNEXP_Loader
-----------

IF OBJECT_ID('U_ECANSUNEXP_Loader') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_Loader] (
    [drvPolicyNum] varchar(6) NOT NULL,
    [drvClientName] varchar(36) NOT NULL,
    [drvReportLanguageCd] varchar(1) NOT NULL
);

-----------
-- Create table U_ECANSUNEXP_PEarHist
-----------

IF OBJECT_ID('U_ECANSUNEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECANSUNEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECANSUNEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Encore Group

Created By: James Bender
Business Analyst: Lea King
Create Date: 08/05/2021
Service Request Number: TekP-2021-04-08-0004

Purpose: Canada Sunlife XML Export

\\us.saas\N2\N21\AUD1001\Exports

Revision History
----------------
Update By           Date           Request Num        Desc
Marco Lagrosa       12/6/2021     SR-2021-000XXXXX   Updated Join on the person table

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECANSUNEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECANSUNEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECANSUNEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECANSUNEXP', 'SCH_ECANSU';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECANSUNEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECANSUNEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECANSUNEXP';

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
    DELETE FROM dbo.U_ECANSUNEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECANSUNEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECANSUNEXP_EEList WHERE xCOID IN (
        SELECT DISTINCT CmpCOID FROM dbo.Company WITH (NOLOCK) WHERE CmpCompanyCode NOT IN ('PSCA','ENCA','FMAV'))

    DELETE FROM dbo.U_ECANSUNEXP_EEList WHERE xEEID IN (
      SELECT DISTINCT eeceeid FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEmplStatus <> 'T' and EecUdField01 IS NULL)
    
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CEXSL,CDPL,COPLF,CADD,CXADD,CXADP,CSTD,CLTD,CDENT,CMED';

    IF OBJECT_ID('U_ECANSUNEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECANSUNEXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStartDates', 'Y')

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


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECANSUNEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_PEarHist;
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
    INTO dbo.U_ECANSUNEXP_PEarHist
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
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Member
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Member','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Member;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvPolicyNum = '103932'
        ,drvLocationNum =    CASE WHEN CmpCompanyCode = 'PSCA' THEN '001'
                                WHEN CmpCompanyCode = 'ENCA' THEN '002'
                                WHEN CmpCompanyCode = 'FMAV' THEN '003'
                            END
        ,drvClassNum =    CASE WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ1'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'UCAN' AND EepAddressState = 'QC' THEN 'UQ2'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ3'
                        END
        ,drvPlanNm =    CASE WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CHRLY' AND  EepAddressState = 'QC' THEN 'AQ1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B1'
                            WHEN CmpCompanyCode = 'PSCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ1'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ2'
                            WHEN CmpCompanyCode = 'ENCA' AND EecDedGroupCode = 'UCAN' AND EepAddressState = 'QC' THEN 'UQ2'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState <> 'QC' THEN 'A3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CHRLY' AND EepAddressState = 'QC' THEN 'AQ3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState <> 'QC' THEN 'B3'
                            WHEN CmpCompanyCode = 'FMAV' AND EecDedGroupCode = 'CSAL' AND EepAddressState = 'QC' THEN 'BQ3'
                        END
        ,drvCertificateNum = EecUdField01 -- 'TBD' -- select * from dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL)
        ,drvPayrollNum = ''
        ,drvEmploymentDt =    CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN CONVERT(VARCHAR(10),EecDateOfLastHire, 126) END
        ,drvWorkResidenceCd =    CASE LocAddressState
                                    WHEN 'NL' THEN '1'
                                    WHEN 'PE' THEN '2'
                                    WHEN 'NB' THEN '3'
                                    WHEN 'NS' THEN '4'
                                    WHEN 'ON' THEN '5'
                                    WHEN 'QC' THEN '6'
                                    WHEN 'MB' THEN '7'
                                    WHEN 'SK' THEN '8'
                                    WHEN 'AB' THEN '9'
                                    WHEN 'BC' THEN '10'
                                END
        ,drvBeneficiary = ''
        ,drvAltBillSort5 = EecLocation
        ,drvStatusCd = CASE WHEN EecEmplStatus = 'T' THEN '3' ELSE '1' END
        ,drvTermDt = CONVERT(VARCHAR(10),EecDateOfTermination, 126)
        ,drvTermReasnonCdHeader = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN ' TermReasonCd=' 
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' THEN ' TermReasonCd=' 
                            END
        ,drvTermReasonCd =    CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN '"6"' 
                                WHEN EecEmplStatus = 'T' AND EecTermReason <> '203' THEN '"2"'
                            END
        ,drvUpdateFlag = CASE WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN 'False' ELSE 'True' END
        ,drvApplyDate =    CONVERT(VARCHAR(10),
                                
                                CASE WHEN EjhReason = 'TRI' THEN 
                                        CASE WHEN EjhJobEffDate > DATEADD(YEAR, -1, GETDATE()) THEN EjhJobEffDate ELSE DATEADD(YEAR, 1, GETDATE()) END
                                    WHEN EecDateOfLastHire BETWEEN @StartDate AND @EndDate THEN 
                                        CASE WHEN EecDateOfLastHire > DATEADD(YEAR, -1, GETDATE()) THEN EecDateOfLastHire ELSE DATEADD(YEAR, 1, GETDATE()) END
                                    WHEN EecEmplStatus = 'T' THEN 
                                        CASE WHEN EecDateOfTermination > DATEADD(YEAR, -1, GETDATE()) THEN EecDateOfTermination ELSE DATEADD(YEAR, 1, GETDATE()) END
                                    ELSE 
                                        CASE WHEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire) > DATEADD(YEAR, -1, GETDATE()) THEN dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, GETDATE(), EecDateOfLastHire) ELSE GETDATE() END--DATEADD(YEAR, 1, GETDATE()) END
                                END
                                , 126)
        ,drvTransferFlg = 'Implicit'
        ,drvReinstatementFlg = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN 'True' ELSE 'False' END
    INTO dbo.U_ECANSUNEXP_drvTbl_Member
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN (
                SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate
                FROM (
                        SELECT EjhEEID, EjhCOID, EjhReason, EjhJobEffDate, ROW_NUMBER() OVER(PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                        FROM dbo.EmpHJob WITH (NOLOCK)) AS InnerEjh
                WHERE RN = 1) AS Ejh
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Person
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Person','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Person;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort =  xEEID
        -- standard fields above and additional driver fields below
        ,drvFirstNm = EepNameFirst
        ,drvLastNm = EepNameLast
        ,drvBirthDt = CONVERT(VARCHAR(10),EepDateOfBirth, 126)
        ,drvResidenceCd = CASE LocAddressState
                            WHEN 'NL' THEN '1'
                            WHEN 'PE' THEN '2'
                            WHEN 'NB' THEN '3'
                            WHEN 'NS' THEN '4'
                            WHEN 'ON' THEN '5'
                            WHEN 'QC' THEN '6'
                            WHEN 'MB' THEN '7'
                            WHEN 'SK' THEN '8'
                            WHEN 'AB' THEN '9'
                            WHEN 'BC' THEN '10'
                        END
        ,drvGenderCd = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvSmokerFlg = CASE WHEN EepIsSmoker = 'Y' THEN 'True' ELSE 'False' END
        ,drvDepTypeCd =    CASE WHEN DepTypeEEID IS NOT NULL THEN '3' ELSE '2' END
                        --CASE WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC') THEN '3' ELSE '2' END
        ,drvLanguageCd =    CASE WHEN EecLanguageCode = 'FR' THEN '2' ELSE '1' END                                
    INTO dbo.U_ECANSUNEXP_drvTbl_Person
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID    
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN (
                SELECT DISTINCT BdmEEID AS DepTypeEEID, BdmCOID AS DepTypeCOID
                FROM dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
                WHERE BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC')) AS DepType
        ON DepTypeEEID = xEEID
        AND DepTypeCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Salary
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Salary','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Salary;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvSalaryDescCd = '1'
        ,drvSalaryBasisCd = CASE WHEN EecSalaryOrHourly = 'S' THEN '1' ELSE '5' END
        ,drvSalaryAmt = FORMAT(EecAnnSalary, '#0.00')
                        --FORMAT(CASE WHEN EecSalaryOrHourly = 'S' THEN EecAnnSalary ELSE EecHourlyPayRate END, '#0.00')
        /*,drvHoursPerWeekAmt =    FORMAT(CASE WHEN EecSalaryOrHourly = 'H' AND PgrPayFrequency IN ('B','S') THEN PehCurHrs/2
                                    WHEN EecSalaryOrHourly = 'H' AND PgrPayFrequency IN ('W') THEN PehCurHrs
                                END, '#0.00')*/
        ,drvEffectiveDt = CONVERT(VARCHAR(10), dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, @EndDate, EecDateOfLastHire), 126)
    INTO dbo.U_ECANSUNEXP_drvTbl_Salary
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN dbo.U_ECANSUNEXP_PEarHist
        ON PehEEID = xEEID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Address
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Address','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Address;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvAddressTypeCd = '1'
        ,drvAddressNm = EepNameFirst + ' ' + EepNameLast
        ,drvStreetAddressNm = EepAddressLine1 + ISNULL(EepAddressLine2, '')
        ,drvSuiteNm = ''
        ,drvCityNm = EepAddressCity
        ,drvStateOrProvCd = CASE EepAddressState
                            WHEN 'NL' THEN '1'
                            WHEN 'PE' THEN '2'
                            WHEN 'NB' THEN '3'
                            WHEN 'NS' THEN '4'
                            WHEN 'ON' THEN '5'
                            WHEN 'QC' THEN '6'
                            WHEN 'MB' THEN '7'
                            WHEN 'SK' THEN '8'
                            WHEN 'AB' THEN '9'
                            WHEN 'BC' THEN '10'
                        END        
        ,drvPostalNum =    CASE WHEN EepAddressCountry = 'CAN' THEN LEFT(EepAddressZipCode, 3) + ' ' + RIGHT(RTRIM(EepAddressZipCode), 3)  ELSE EepAddressZipCode END
        ,drvCountryCd = '1'
    INTO dbo.U_ECANSUNEXP_drvTbl_Address
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_PersonLink
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_PersonLink','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_PersonLink;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvPersonLinkTypeCd =    CASE WHEN ConRelationship IN ('CVL','DOM','SPS') THEN '2'
                                    WHEN ConRelationship IN ('CHL','STC') THEN '3'
                                END
        ,drvFirstNm = ConNameFirst
        ,drvLastNm = ConNameLast
        ,drvBirthDt = CONVERT(VARCHAR(10), ConDateOfBirth, 126)
        ,drvGenderCd = ConGender
        ,drvSmokerFlg = CASE WHEN ConIsSmoker = 'Y' THEN 'True' ELSE 'False' END
        ,drvInSchoolFlg = ''
        ,drvEffectiveDt = ''
        ,drvTermDt = CASE WHEN EecEmplStatus = 'T' THEN BdmBenStopDate END
        ,drvTermReasnonCdHeader = CASE WHEN EecEmplStatus = 'T' THEN ' TermReasonCd='  END
        ,drvTermReasonCd = CASE WHEN EecEmplStatus = 'T' THEN '2' END
        ,drvStatusCd = CASE WHEN EecEmplStatus = 'T' THEN '3' ELSE '1' END
        ,drvOldFirstNm = ''
    INTO dbo.U_ECANSUNEXP_drvTbl_PersonLink
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECANSUNEXP_drvTbl_Benefits
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_drvTbl_Benefits','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_drvTbl_Benefits;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID
        -- standard fields above and additional driver fields below
        ,drvBenefitType =    CASE WHEN BdmDedCode = 'CEXSL' THEN '101'
                                WHEN BdmDedCode = 'CDPL' THEN '103'
                                WHEN BdmDedCode = 'COPLF' THEN '111'
                                WHEN BdmDedCode IN ('CADD','CXADD','CXADP') THEN '301'
                                WHEN BdmDedCode = 'CDENT' THEN '502'
                                WHEN BdmDedCode = 'CSTD' THEN '401'
                                WHEN BdmDedCode = 'CLTD' THEN '411'
                                WHEN BdmDedCode = 'CMED' THEN '512'
                            END
        ,drvFlexCodeNm = 'A'
        ,drvDepTypeCd =    CASE WHEN BdmDedCode = 'CDPL' THEN '3'
                            WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('FAMILY','FAMON','FAMQC') THEN '3'
                            WHEN BdmDedCode IN ('CDENT','CMED') AND BdmBenOption IN ('EEON','EEONLY','EEQC') THEN '2'
                            ELSE '1'
                        END
        ,drvEffectiveDt = CASE WHEN BdmBenStartDate BETWEEN @StartDate AND @EndDate THEN CONVERT(VARCHAR(10), BdmBenStartDate, 126) END
--        ,drvRequestedUnitsAmt = FORMAT(BdmEEAmt, '#0.00')
--        ,drvRequestedAmt = ''
        ,drvStatusCd = CASE WHEN BdmBenStatus <> 'A' THEN '3' ELSE '1' END
        ,drvTermReasnonCdHeader =    CASE WHEN EecEmplStatus = 'T' THEN 
                                        CASE WHEN BdmBenStatus <> 'A' THEN ' TermReasonCd='  END
                                    END
        ,drvTermReasonCd =  CASE WHEN EecEmplStatus = 'T' THEN 
                                CASE WHEN BdmBenStatus <> 'A' THEN '"1"' END
                            END
        ,drvTermDt = CONVERT(VARCHAR(10), BdmBenStopDate, 126)
    INTO dbo.U_ECANSUNEXP_drvTbl_Benefits
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ECANSUNEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE EecEmplStatus <> 'T'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECANSUNEXP_Loader','U') IS NOT NULL
        DROP TABLE dbo.U_ECANSUNEXP_Loader;
    SELECT DISTINCT
         drvPolicyNum = '103932'
        ,drvClientName = 'Audio Visual Services (Canada) Corp.'
        ,drvReportLanguageCd = '1'
    INTO dbo.U_ECANSUNEXP_Loader
    FROM dbo.U_ECANSUNEXP_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwECANSUNEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECANSUNEXP_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECANSUNEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110011'
       ,expStartPerControl     = '202110011'
       ,expLastEndPerControl   = '202111299'
       ,expEndPerControl       = '202111299'
WHERE expFormatCode = 'ECANSUNEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECANSUNEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECANSUNEXP_File (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, RecordSet, SubSort;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECANSUNEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECANSUNEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECANSUNEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECANSUNEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECANSUNEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECANSUNEXP', 'UseFileName', 'V', 'Y'


-- End ripout