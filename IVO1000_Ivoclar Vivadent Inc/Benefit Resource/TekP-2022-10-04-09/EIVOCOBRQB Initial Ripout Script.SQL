/**********************************************************************************

EIVOCOBRQB: BR COBRA QB Export

FormatCode:     EIVOCOBRQB
Project:        BR COBRA QB Export
Client ID:      USG1000
Date/time:      2023-02-09 18:45:25.833
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EZ24
Server:         EZ2SUP4DB01
Database:       ULTIPRO_BETHB
Web Filename:   USG1000_73487_EEHISTORY_EIVOCOBRQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    \\ez2sup4db01\ultiprodata\[Name]\Exports\

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIVOCOBRQB_SavePath') IS NOT NULL DROP TABLE dbo.U_EIVOCOBRQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIVOCOBRQB'


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
WHERE FormatCode = 'EIVOCOBRQB'
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
WHERE ExpFormatCode = 'EIVOCOBRQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIVOCOBRQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIVOCOBRQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIVOCOBRQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIVOCOBRQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIVOCOBRQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIVOCOBRQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIVOCOBRQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIVOCOBRQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIVOCOBRQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIVOCOBRQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIVOCOBRQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIVOCOBRQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIVOCOBRQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIVOCOBRQB];
GO
IF OBJECT_ID('U_EIVOCOBRQB_File') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_File];
GO
IF OBJECT_ID('U_EIVOCOBRQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_EEList];
GO
IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE];
GO
IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBPLANINITIAL];
GO
IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL];
GO
IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBDEPENDENT];
GO
IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QB];
GO
IF OBJECT_ID('U_EIVOCOBRQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_DedList];
GO
IF OBJECT_ID('U_EIVOCOBRQB_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_AuditFields];
GO
IF OBJECT_ID('U_EIVOCOBRQB_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIVOCOBRQB_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIVOCOBRQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIVOCOBRQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIVOCOBRQB','BR COBRA QB Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EIVOCOBRQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVOCOBRQBZ0','50','H','01','1',NULL,'RecordType',NULL,NULL,'"[VERSION]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVOCOBRQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL,'"1.2"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVOCOBRQBZ0','50','D','10','1',NULL,'RecordType',NULL,NULL,'"[QB]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVOCOBRQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"drvClentName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIVOCOBRQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIVOCOBRQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'"drvSalutation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIVOCOBRQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIVOCOBRQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIVOCOBRQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIVOCOBRQBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIVOCOBRQBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvIndividualID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIVOCOBRQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIVOCOBRQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIVOCOBRQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'"drvPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIVOCOBRQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIVOCOBRQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIVOCOBRQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIVOCOBRQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIVOCOBRQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIVOCOBRQBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIVOCOBRQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"drvPremiumAddressAsPrimary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIVOCOBRQBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIVOCOBRQBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIVOCOBRQBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIVOCOBRQBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIVOCOBRQBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIVOCOBRQBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EIVOCOBRQBZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EIVOCOBRQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EIVOCOBRQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"drvTobaccoUse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EIVOCOBRQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"drvEEType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EIVOCOBRQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EIVOCOBRQBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EIVOCOBRQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EIVOCOBRQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EIVOCOBRQBZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EIVOCOBRQBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"FALSE"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EIVOCOBRQBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EIVOCOBRQBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EIVOCOBRQBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EIVOCOBRQBZ0','50','D','10','39',NULL,'SSOIdentifier',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EIVOCOBRQBZ0','50','D','10','40',NULL,'PlanCategory',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVOCOBRQBZ0','50','D','20','1',NULL,'RecordType',NULL,NULL,'"[QBEVENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVOCOBRQBZ0','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIVOCOBRQBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIVOCOBRQBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIVOCOBRQBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIVOCOBRQBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIVOCOBRQBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVOCOBRQBZ0','50','D','30','1',NULL,'RecordType',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVOCOBRQBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIVOCOBRQBZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIVOCOBRQBZ0','50','D','30','4',NULL,'NumberOfUnit',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVOCOBRQBZ0','50','D','40','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVOCOBRQBZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIVOCOBRQBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIVOCOBRQBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIVOCOBRQBZ0','50','D','40','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIVOCOBRQBZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIVOCOBRQBZ0','50','D','40','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIVOCOBRQBZ0','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIVOCOBRQBZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIVOCOBRQBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIVOCOBRQBZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvAddressSameAsQB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIVOCOBRQBZ0','50','D','40','12',NULL,'Address1',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIVOCOBRQBZ0','50','D','40','13',NULL,'Address2',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIVOCOBRQBZ0','50','D','40','14',NULL,'City',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIVOCOBRQBZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIVOCOBRQBZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIVOCOBRQBZ0','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIVOCOBRQBZ0','50','D','40','18',NULL,'EnrollmentDate ',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIVOCOBRQBZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIVOCOBRQBZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIVOCOBRQBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"FALSE"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVOCOBRQBZ0','50','D','50','1',NULL,'RecordType',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVOCOBRQBZ0','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIVOCOBRQBZ0','50','D','60','1',NULL,'RecordTypeRateInitial',NULL,NULL,'"drvRecordTypeMembSpecRateInit"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIVOCOBRQBZ0','50','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIVOCOBRQBZ0','50','D','60','3',NULL,'Rate',NULL,NULL,'""','(SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIVOCOBRQB_20230209.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BR COBRA QB Export','202302099','EMPEXPORT','ONDEM_XOE',NULL,'EIVOCOBRQB',NULL,NULL,NULL,'202302099','Feb  9 2023  6:11PM','Feb  9 2023  6:11PM','202302091',NULL,'','','202302091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BR COBRA QB Export-Sched','202302099','EMPEXPORT','SCH_EIVOCO',NULL,'EIVOCOBRQB',NULL,NULL,NULL,'202302099','Feb  9 2023  6:11PM','Feb  9 2023  6:11PM','202302091',NULL,'','','202302091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BR COBRA QB Export-Test','202302099','EMPEXPORT','TEST_XOE',NULL,'EIVOCOBRQB',NULL,NULL,NULL,'202302099','Feb  9 2023  6:11PM','Feb  9 2023  6:11PM','202302091',NULL,'','','202302091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVOCOBRQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVOCOBRQB','ExportPath','V','\\ez2sup4db01\ultiprodata\[Name]\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVOCOBRQB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVOCOBRQB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVOCOBRQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIVOCOBRQB','UseFileName','V','N');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVOCOBRQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVOCOBRQB','D10','dbo.U_EIVOCOBRQB_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVOCOBRQB','D20','dbo.U_EIVOCOBRQB_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVOCOBRQB','D30','dbo.U_EIVOCOBRQB_drvTbl_QBPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVOCOBRQB','D40','dbo.U_EIVOCOBRQB_drvTbl_QBDEPENDENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVOCOBRQB','D50','dbo.U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIVOCOBRQB','D60','dbo.U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE',NULL);

-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- U_dsi_Translations_v3 inserts
-----------


-----------
-- Create table U_dsi_BDM_EIVOCOBRQB
-----------

IF OBJECT_ID('U_dsi_BDM_EIVOCOBRQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIVOCOBRQB] (
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
-- Create table U_EIVOCOBRQB_Audit
-----------

IF OBJECT_ID('U_EIVOCOBRQB_Audit') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL
);

-----------
-- Create table U_EIVOCOBRQB_AuditFields
-----------

IF OBJECT_ID('U_EIVOCOBRQB_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIVOCOBRQB_DedList
-----------

IF OBJECT_ID('U_EIVOCOBRQB_DedList') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EIVOCOBRQB_drvTbl_QB
-----------

IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvClentName] varchar(16) NOT NULL,
    [drvClientDivisionName] varchar(16) NOT NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvIndividualID] varchar(1) NOT NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvPhone2] varchar(50) NULL,
    [drvAddress1] varchar(8000) NULL,
    [drvAddress2] varchar(8000) NULL,
    [drvCity] varchar(8000) NULL,
    [drvState] varchar(8000) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvPremiumAddressAsPrimary] varchar(4) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEEType] char(3) NULL
);

-----------
-- Create table U_EIVOCOBRQB_drvTbl_QBDEPENDENT
-----------

IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvAddressSameAsQB] varchar(1) NOT NULL,
    [drvSex] varchar(1) NOT NULL,
    [drvDOB] datetime NULL
);

-----------
-- Create table U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL
-----------

IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanName] varchar(1) NOT NULL
);

-----------
-- Create table U_EIVOCOBRQB_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEventType] varchar(1) NOT NULL,
    [drvEventDate] varchar(1) NOT NULL,
    [drvEnrollmentDate] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(1) NOT NULL
);

-----------
-- Create table U_EIVOCOBRQB_drvTbl_QBPLANINITIAL
-----------

IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBPLANINITIAL') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBPLANINITIAL] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPlanName] varchar(1) NOT NULL,
    [drvCoverageLevel] varchar(1) NOT NULL
);

-----------
-- Create table U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE
-----------

IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordTypeMembSpecRateInit] varchar(1) NOT NULL,
    [drvPlanName] varchar(1) NOT NULL
);

-----------
-- Create table U_EIVOCOBRQB_EEList
-----------

IF OBJECT_ID('U_EIVOCOBRQB_EEList') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIVOCOBRQB_File
-----------

IF OBJECT_ID('U_EIVOCOBRQB_File') IS NULL
CREATE TABLE [dbo].[U_EIVOCOBRQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIVOCOBRQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ivoclar Vivadent Inc

Created By: Marie Waters
Business Analyst: Curlin Beck
Create Date: 02/09/2023
Service Request Number: TekP-2022-10-04-09

Purpose: BR COBRA QB Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIVOCOBRQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIVOCOBRQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIVOCOBRQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIVOCOBRQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIVOCOBRQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVOCOBRQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVOCOBRQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIVOCOBRQB', 'SCH_EIVOCO';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIVOCOBRQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIVOCOBRQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIVOCOBRQB';

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
    DELETE FROM dbo.U_EIVOCOBRQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIVOCOBRQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


     --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIVOCOBRQB_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_AuditFields;
    CREATE TABLE dbo.U_EIVOCOBRQB_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIVOCOBRQB_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_Audit;
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
    INTO dbo.U_EIVOCOBRQB_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIVOCOBRQB_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIVOCOBRQB_Audit ON dbo.U_EIVOCOBRQB_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    DELETE FROM dbo.U_EIVOCOBRQB_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EIVOCOBRQB_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MED1,MED3,MED10,MED11,MED12,MED4,MED5,MED7,FSA,DEN1,DEN2';

    IF OBJECT_ID('U_EIVOCOBRQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIVOCOBRQB_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
        DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

        -- Required parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSELECTionOption','AuditDate');

--- COBRA parameters
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    --    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');  -- only used for NPM/QB combined files
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups – 
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists – 
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest) – include this line if deps are sent as QB and not the employee.  If the EE is sent as the QB even for non-EE events indicate this up above in question #3.
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB', '201,204,210,LEVNT3,LEVNT4') -- Add valid dependent edhchangereasons
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp', '201,204,210,LEVNT3,LEVNT4') ;-- Invalidate employee when Cobra Reason is a dependent PQB reason – Add valid dependent edhchangereasons (should be same as previous line above)
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death".  Add the Death employment term reason (eectermreason)
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons – used when clients have Platform Configurable fields.  Add any other field names the client is using.
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS'); -- update to the spouse relationship code
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild', 'CHL,CRT,DIS,DPC,GRC,STC'); -- update to the child relationship codes
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP'); -- update to the domestic partner relationship code

        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard'); -- same for all files   -- Non-Required parameters
          

        -- Run BDM for QB
        EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable_v2 @FormatCode;
   
     -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --====================================================
 --   -- Insert into BDM Reason code 200/203/DEA (Death)
 --            SPS or 1st child is EMP
 --=====================================================
        
        INSERT INTO [dbo].[U_dsi_BDM_EIVOCOBRQB]
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
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
        )
        Select Distinct 
            rectype =  'DEP' 
            ,EdhCoid
            ,EdhEEID
            ,consystemID
            ,consystemID
            ,'QB'
            ,'Data Inserted for 200/203 (Death)'
            ,ConRelationship
            ,ConDateOfBirth
            ,EdhDedCode
            ,EdhBenOption
            ,EdhBenStatus
            ,dbnbenstartdate
            ,dbnbenstopdate
            ,dbnBenStatusDate
            ,EecDateofTermination
            ,''
            ,dbncobrareason 
            ,dbnbenstartdate
            ,DbnBenStopDate
            ,'Y'
            ,'Y'
            ,'Y'
         
            FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EIVOCOBRQB'
       JOIN EmpComp WITH (NOLOCK)
        ON dbnEEID = EecEEID
         JOIN dbo.contacts WITH (NOLOCK)
            ON ConEEID = edheeid 
     Where  dbncobrareason = '210'
       -- AND EecTermReason in ('D','203')
        AND edhbenstatus = 'A'
        and edhbenoption <> 'EE'
        and EecEEType <> 'EE'


      ---========================================================================
 --   -- Insert into BDM Reason code 201 (Dependent at Max Age) - Only show EE
 -- --======================================================================

    INSERT INTO [dbo].[U_dsi_BDM_EIVOCOBRQB]
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
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
           ,[BdmIsCobraCovered]
           ,[BdmSessionID]
    )
        Select distinct
        'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 (Dep at Max Age Dep/Loss of elig)'
        ,'Emp'
        ,EepDateofBirth
        ,DbnDedCode
        ,DbnBenStatus
        ,DbnBenStatus
        ,EdhBenStartDate
        ,DbnBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,DbnBenStopDate
        ,'Y'
        ,'Y'
         ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
      FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = edheeid 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON dbneeid = edheeid 
        AND DbnCoID = EdhCoID
        AND EdhDedCode = DbnDedCode
        AND EdhBenOption = DbnBenOption
        AND dbnformatcode = 'EIVOCOBRQB'
    WHERE edhchangereason IN ('201','LEVNT3') 
      and DbnBenstopdate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N'
            AND DbnBenStatus IN ('T')
          

--    ========================================================================
 --  Insert into BDM Reason code 204 / LEVNT4 (Divorce/Separation) 
 --  ======================================================================
    INSERT INTO [dbo].[U_dsi_BDM_EIVOCOBRQB]
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
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmDateOFCobraEvent]
           ,[BdmChangeReason]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]
            ,[BdmIsCobraCovered]
            ,[BdmEEAmt]
    )
    SELECT Distinct rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 204/LEVNT4 (Divorce/Separation)'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,DbnBenOption
        ,DbnBenStatus
        ,EdhBenStartDate
        --,EdhBenStopDate
        ,DbnBenStopDate
        ,EdhBenStatusDate
        ,EdhEffDate
        ,edhChangeReason
        ,edhChangeReason
        ,EdhStartDate
        ,EdhStopDate
        ,CASE WHEN DbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
        ,'Y'
        ,edheeamt
   FROM dbo.emphded WITH (NOLOCK)
        JOIN dbo.U_dsi_BDM_DepDeductions 
            ON dbneeid = edheeid 
            AND DbnCoID = EdhCoID
            AND EdhDedCode = DbnDedCode
            AND EdhBenOption = DbnBenOption
            AND dbnformatcode = 'EIVOCOBRQB'
    WHERE edhChangeReason in ('204','LEVNT4') 
        AND DbnRelationShip = 'SPS'
        AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
        AND dbnValidForExport = 'N'

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIVOCOBRQB_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_drvTbl_QB;
        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvClentName = 'Ivoclar Vivadent'
        ,drvClientDivisionName = 'Ivoclar Vivadent'
        ,drvSalutation = ''
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvSSN = eepSSN
        ,drvIndividualID = ''
        ,drvEmail = EepAddressEmailAlternate
        ,drvPhone = EepPhoneHomeNumber
        ,drvPhone2 = efoPhoneNumber
        ,drvAddress1 = Replace(EepAddressLine1,',', '')
        ,drvAddress2 = REPLACE(EepAddressLine2,',', '')
        ,drvCity = REPLACE(EepAddressCity,',', '')
        ,drvState = REPLACE(EepAddressState,',', '')
        ,drvPostalCode = EepAddressZipCode
        ,drvPremiumAddressAsPrimary = 'TRUE'
        ,drvGender = EepGender
        ,drvDOB = EepDateOfBirth
        ,drvTobaccoUse = Case WHEN EepIsSmoker = 'Y' THEN  'YES' 
                              WHEN EepIsSmoker = 'N' THEN  'NO' 
                              else  'UNKNOWN'
                             END
        ,drvEEType = EecEEType
    INTO dbo.U_EIVOCOBRQB_drvTbl_QB
    FROM dbo.U_EIVOCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON efoeeid =Xeeid
        and efoPhoneType = 'CEL'
    JOIN dbo.U_dsi_BDM_EIVOCOBRQB WITH (NOLOCK)
             ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        and BdmIsPQB ='Y'
        AND BdmRecType = 'EMP'
   
    JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode = bdmDedCode
    Where (edhChangeReason  Not IN ('LEVNT3','LEVNT4','204','210','201') or BdmCobraReason  NOT IN ('LEVNT3','LEVNT4','204','210','201'))
  
  
  INSERT INTO dbo.U_EIVOCOBRQB_drvTbl_QB
        (
          drvEEID 
        ,drvCoID 
        ,drvDepRecID 
        ,drvInitialSort 
        ,drvSubSort
        
        ,drvClentName
        ,drvClientDivisionName 
        ,drvSalutation 
        ,drvFirstName 
        ,drvMiddleInitial
        ,drvLastName 
        ,drvSSN 
        ,drvIndividualID 
        ,drvEmail
        ,drvPhone 
        ,drvPhone2 
        ,drvAddress1 
        ,drvAddress2 
        ,drvCity 
        ,drvState 
        ,drvPostalCode 
        ,drvPremiumAddressAsPrimary
        ,drvGender 
        ,drvDOB 
        ,drvTobaccoUse 
        ,drvEEType 

        )


        SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  '1' + xEEID + '1'
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvClentName = 'Ivoclar Vivadent'
        ,drvClientDivisionName = 'Ivoclar Vivadent'
        ,drvSalutation = ''
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvSSN = ConSSN
        ,drvIndividualID = ''
        ,drvEmail = ''
        ,drvPhone = ''
        ,drvPhone2 = ''
        ,drvAddress1 = ConAddressLine1
        ,drvAddress2 = ConAddressLine2
        ,drvCity = ConAddressCity
        ,drvState = ConAddressState
        ,drvPostalCode = ConAddressZipCode
        ,drvPremiumAddressAsPrimary = 'TRUE'
        ,drvGender = ConGender
        ,drvDOB = ConDateOfBirth
        ,drvTobaccoUse = 'UNKNOWN'
        ,drvEEType = EecEEType
  --  INTO dbo.U_EKLJOCOBQB_QB_drvTbl
    FROM dbo.U_EKLJOCOBQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EKLJOCOBQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
        and BdmIsPQB ='Y'
        AND BdmRecType <> 'EMP'
    JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
     JOIN dbo.EmpHDed WITH (NOLOCK)
        ON edhEEID = xEEID
        AND EdhDedCode = bdmDedCode
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIVOCOBRQB_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  '1' + xEEID + '1'
        ,drvSubSort = '1'
        -- standard fields above and additional driver fields below
        ,drvEventType = ''
        ,drvEventDate = ''
        ,drvEnrollmentDate = ''
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = ''
    INTO dbo.U_EIVOCOBRQB_drvTbl_QBEVENT
    FROM dbo.U_EIVOCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
  
     JOIN (SELECT
                 BdmEEID
                ,BdmCoID
                ,BdmDepRecID
                ,BdmRecType
                ,BdmChangeReason = MAX(BdmChangeReason)
                ,BdmCobraReason = MAX(BdmCobraReason)
                ,BdmBenStartDate = MIN(BdmBenStartDate)
                ,BdmBenStopDate = MAX(BdmBenStopDate)
                ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
                ,BdmUSGDate1 = MAX(BdmUSGDate1)
                ,BdmStopDate = Max(bdmstopdate)
              FROM dbo.U_dsi_BDM_EIVOCOBRQB WITH (NOLOCK)
            Where BdmRunId = 'QB'
              GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
      LEFT JOIN (
            SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent 
            FROM (
                    SELECT EdhEEID, EdhCOID, EdhEffDate,edhChangeReason, BchIsCobraQualifiedEvent, ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID ORDER BY EdhEffDate desc) AS RN
                    FROM dbo.EmpHDed a WITH (NOLOCK)
                    JOIN dbo.BenChRsn WITH (NOLOCK)
                        ON EdhChangeReason = BchCode
                    WHERE EdhDedCode IN ('MED30','MED63','DEN','VIS')
                        AND edhChangeReason IN ('LEVNT3','LEVNT4','204','210','201')
                ) AS X
            WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCoID = xCOID  
    ;
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIVOCOBRQB_drvTbl_QBPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_drvTbl_QBPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1' + xEEID + '2'
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BdmDedcode = 'MED1'  THEN 'Lifestyle Plan'
                            WHEN BdmDedcode = 'MED3'  THEN 'First Choice Plan'
                            WHEN BdmDedcode = 'MED10' THEN 'HDHP WNY'
                            WHEN BdmDedcode = 'MED11' THEN 'HDHP'
                            WHEN BdmDedcode = 'MED12' THEN 'HDHP'
                            WHEN BdmDedcode = 'MED4' THEN 'POS Medical Plan'
                            WHEN BdmDedcode = 'MED5' THEN 'POS Medical Plan'
                            WHEN BdmDedcode = 'MED7 ' THEN 'POS Medical Plan'

                            WHEN BdmDedcode = 'FSA' THEN  'BRI FSA'
                            WHEN BdmDedcode = 'DEN1' THEN  'Dental'
                            WHEN BdmDedcode = 'DEN2' THEN  'Dental'
                        END
        ,drvCoverageLevel = ''   
                                --        EE, EE+FAMILY, 
                                --(Over age dep, Divorce or Death)
                                --If edhChangeReason = 204, LEVNT4, 201, LEVNT3 or 210 and
                                --If bdmrelationship = SPS and 1 CHL,DPC,STC or DCH send EE+FAMILY
                                --If bdmrelationship = SPS and more than 1 CHL,DPC,STC or DCH send EE+FAMILY
                                --If bdmrelationship = more than 1 CHL,DPC,STC or DCH send EE+CHILDREN
                                --else send EE
                                --else
                                --If edhChangeReason is not 204, LEVNT4, 201, LEVNT3 or 210 and bdmrelationship IN (‘CHL’,’SPS’,’DPC’,’DP’,’STC’) send EE+FAMILY else EE else
                                --If FSA send EE
    INTO dbo.U_EIVOCOBRQB_drvTbl_QBPLANINITIAL
    FROM dbo.U_EIVOCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EIVOCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'QB'
        and bdmIsPQB = 'Y'
    ;
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIVOCOBRQB_drvTbl_QBDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_drvTbl_QBDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort ='1' + xEEID + '4' + BdmDepRecId + '1'  
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvRelationship = CASE WHEN conrelationship IN ( 'CHL', 'DA', 'DPC', 'SON' , 'STC')  THEN  'CHILD' ELSE conrelationship  END
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvAddressSameAsQB = 'TRUE'
        ,drvSex = ConGender
        ,drvDOB = ConDateOfBirth
    INTO dbo.U_EIVOCOBRQB_drvTbl_QBDEPENDENT
    FROM dbo.U_EIVOCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EIVOCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunID = 'QB'
     JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        WHERE  BdmIsPQB = 'N'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL
    ---------------------------------
    IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort  ='1' + xEEID + '4' + BdmDepRecId + '1'  
        ,drvSubSort = '5'
        -- standard fields above and additional driver fields below
        ,drvPlanName = CASE WHEN BdmDedcode = 'MED1'  THEN 'Lifestyle Plan'
                            WHEN BdmDedcode = 'MED3'  THEN 'First Choice Plan'
                            WHEN BdmDedcode = 'MED10' THEN 'HDHP WNY'
                            WHEN BdmDedcode = 'MED11' THEN 'HDHP'
                            WHEN BdmDedcode = 'MED12' THEN 'HDHP'
                            WHEN BdmDedcode = 'MED4' THEN 'POS Medical Plan'
                            WHEN BdmDedcode = 'MED5' THEN 'POS Medical Plan'
                            WHEN BdmDedcode = 'MED7 ' THEN 'POS Medical Plan'
                            WHEN BdmDedcode = 'FSA' THEN  'BRI FSA'
                            WHEN BdmDedcode = 'DEN1' THEN  'Dental'
                            WHEN BdmDedcode = 'DEN2' THEN  'Dental'
                        END
    INTO dbo.U_EIVOCOBRQB_drvTbl_QBDEPPLANINITIAL
    FROM dbo.U_EIVOCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EIVOCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId <> 'NPM'
        AND BdmIsPQB = 'N'  
    JOIN dbo.contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE
    ---------------------------------
    IF OBJECT_ID('U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE','U') IS NOT NULL
        DROP TABLE dbo.U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort =  '1' + xEEID +  '6'
        ,drvSubSort = '6'
        -- standard fields above and additional driver fields below
        ,drvRecordTypeMembSpecRateInit = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvPlanName = CASE WHEN BdmdedCode= 'FSA'  then  'BRI FSA' END
    INTO dbo.U_EIVOCOBRQB_drvTbl_QBPLANMEMSPCRATE
    FROM dbo.U_EIVOCOBRQB_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EIVOCOBRQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmdedCode= 'FSA' 

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
ALTER VIEW dbo.dsi_vwEIVOCOBRQB_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIVOCOBRQB_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIVOCOBRQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202302021'
       ,expStartPerControl     = '202302021'
       ,expLastEndPerControl   = '202302099'
       ,expEndPerControl       = '202302099'
WHERE expFormatCode = 'EIVOCOBRQB';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIVOCOBRQB_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIVOCOBRQB_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIVOCOBRQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIVOCOBRQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIVOCOBRQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIVOCOBRQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIVOCOBRQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIVOCOBRQB', 'UseFileName', 'V', 'Y'


-- End ripout