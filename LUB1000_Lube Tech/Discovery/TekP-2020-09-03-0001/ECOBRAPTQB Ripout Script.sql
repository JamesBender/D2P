/**********************************************************************************

ECOBRAPTQB: EBC QB Cobra Export

FormatCode:     ECOBRAPTQB
Project:        EBC QB Cobra Export
Client ID:      LUB1000
Date/time:      2022-06-09 04:22:08.170
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP2DB01
Database:       ULTIPRO_WPLUBT
Web Filename:   LUB1000_A5MKI_EEHISTORY_ECOBRAPTQB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECOBRAPTQB_SavePath') IS NOT NULL DROP TABLE dbo.U_ECOBRAPTQB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECOBRAPTQB'


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
WHERE FormatCode = 'ECOBRAPTQB'
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
WHERE ExpFormatCode = 'ECOBRAPTQB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECOBRAPTQB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECOBRAPTQB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECOBRAPTQB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECOBRAPTQB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECOBRAPTQB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECOBRAPTQB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECOBRAPTQB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECOBRAPTQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECOBRAPTQB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECOBRAPTQB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECOBRAPTQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOBRAPTQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOBRAPTQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBRAPTQB];
GO
IF OBJECT_ID('U_ECOBRAPTQB_Header') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_Header];
GO
IF OBJECT_ID('U_ECOBRAPTQB_File') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_File];
GO
IF OBJECT_ID('U_ECOBRAPTQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_EEList];
GO
IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBMEMRATE') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBMEMRATE];
GO
IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBDEPINIT') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBDEPINIT];
GO
IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QB];
GO
IF OBJECT_ID('U_ECOBRAPTQB_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECOBRAPTQB_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECOBRAPTQB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECOBRAPTQB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECOBRAPTQB','EBC QB Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECOBRAPTQBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOBRAPTQBZ0','50','H','01','1',NULL,'RecordID',NULL,NULL,'"drvRecordID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOBRAPTQBZ0','50','H','01','2',NULL,'VersionNumber',NULL,NULL,'"drvVersionNumber"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOBRAPTQBZ0','50','D','10','1',NULL,'RecordID',NULL,NULL,'"drvRecordID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOBRAPTQBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOBRAPTQBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivisionName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOBRAPTQBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'"drvSalutation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECOBRAPTQBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECOBRAPTQBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECOBRAPTQBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECOBRAPTQBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECOBRAPTQBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvIndividualID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECOBRAPTQBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECOBRAPTQBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECOBRAPTQBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'"drvPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECOBRAPTQBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECOBRAPTQBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECOBRAPTQBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECOBRAPTQBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECOBRAPTQBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECOBRAPTQBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECOBRAPTQBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"drvPremAddSameAsPrimary"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECOBRAPTQBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'"drvPremiumAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECOBRAPTQBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'"drvPremiumAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECOBRAPTQBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'"drvPremiumCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECOBRAPTQBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'"drvPremiumStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECOBRAPTQBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'"drvPremiumPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECOBRAPTQBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'"drvPremiumCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECOBRAPTQBZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECOBRAPTQBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECOBRAPTQBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"drvTobaccoUse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECOBRAPTQBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"drvEmployeeType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECOBRAPTQBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"drvEmployeePayrollType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECOBRAPTQBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'"drvYearsOfService"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECOBRAPTQBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"drvPremiumCouponType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECOBRAPTQBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"drvUsesHCTC"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECOBRAPTQBZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"drvActive"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECOBRAPTQBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"drvAllowMemberSSO"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECOBRAPTQBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'"drvBenefitGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECOBRAPTQBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'"drvAccountStructure"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECOBRAPTQBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'"drvClientSpecificData"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOBRAPTQBZ0','50','D','20','1',NULL,'RecordID',NULL,NULL,'"drvRecordID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOBRAPTQBZ0','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOBRAPTQBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOBRAPTQBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECOBRAPTQBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECOBRAPTQBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvEmployeeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECOBRAPTQBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'"drvSecondEventOriginalFDOC"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOBRAPTQBZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL,'"drvRecordIdentifierQBPL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOBRAPTQBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanNameQBPL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOBRAPTQBZ0','50','D','30','5',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevelQBPL"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOBRAPTQBZ0','50','D','30','6',NULL,'NumberOfUnits',NULL,NULL,'"drvNumberOfUnits"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOBRAPTQBZ0','50','D','40','1',NULL,'RecordId',NULL,NULL,'"drvRecordId"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOBRAPTQBZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOBRAPTQBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECOBRAPTQBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'"drvSalutation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECOBRAPTQBZ0','50','D','40','5',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECOBRAPTQBZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECOBRAPTQBZ0','50','D','40','7',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECOBRAPTQBZ0','50','D','40','8',NULL,'Email',NULL,NULL,'"drvEmail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECOBRAPTQBZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'"drvPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECOBRAPTQBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL,'"drvPhone2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECOBRAPTQBZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvAddressSameAsQB"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECOBRAPTQBZ0','50','D','40','12',NULL,'Address1',NULL,NULL,'"drvAddress1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECOBRAPTQBZ0','50','D','40','13',NULL,'Address2',NULL,NULL,'"drvAddress2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECOBRAPTQBZ0','50','D','40','14',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECOBRAPTQBZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL,'"drvStateOrProvince"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECOBRAPTQBZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECOBRAPTQBZ0','50','D','40','17',NULL,'Country',NULL,NULL,'"drvCountry"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECOBRAPTQBZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECOBRAPTQBZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvSex"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECOBRAPTQBZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECOBRAPTQBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"drvIsQMCSO"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOBRAPTQBZ0','50','D','50','1',NULL,'RecordID',NULL,NULL,'"drvRecordID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOBRAPTQBZ0','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECOBRAPTQBZ0','50','D','60','1',NULL,'RecordID',NULL,NULL,'"drvRecordID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECOBRAPTQBZ0','50','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECOBRAPTQBZ0','50','D','60','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECOBRAPTQB_20220609.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'EBC QB Cobra Export','202011119','EMPEXPORT','ONDEM_XOE',NULL,'ECOBRAPTQB',NULL,NULL,NULL,'202011119','Nov 11 2020  8:21AM','Nov 11 2020  8:21AM','201911041',NULL,'','','201911041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','BQ2L8,MVNEE,MVN6N,MVN97,MVNCJ,MVN3A',NULL,NULL,NULL,'EBC QB Cobra Export-Sched','202103039','EMPEXPORT','SCH_ECOBRA',NULL,'ECOBRAPTQB',NULL,NULL,NULL,'202206039','Nov 11 2020  8:21AM','Nov 11 2020  8:21AM','202205271',NULL,'','','202103031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','BQ2L8',NULL,NULL,NULL,'EBC QB Cobra Export-Test','202205271','EMPEXPORT','TEST_XOE','Jun  8 2022  4:25PM','ECOBRAPTQB',NULL,NULL,NULL,'202205271','May 27 2022 12:00AM','Dec 30 1899 12:00AM','202205211','39','','','202205211',dbo.fn_GetTimedKey(),NULL,'us3cPeLUB1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBRAPTQB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAPTQB','H01','dbo.U_ECOBRAPTQB_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAPTQB','D10','dbo.U_ECOBRAPTQB_drvTbl_QB',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAPTQB','D20','dbo.U_ECOBRAPTQB_drvTbl_QBEVENT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAPTQB','D30','dbo.U_ECOBRAPTQB_drvTbl_QBPLAN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAPTQB','D40','dbo.U_ECOBRAPTQB_drvTbl_QBDEP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAPTQB','D50','dbo.U_ECOBRAPTQB_drvTbl_QBDEPINIT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBRAPTQB','D60','dbo.U_ECOBRAPTQB_drvTbl_QBMEMRATE',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECOBRAPTQB
-----------

IF OBJECT_ID('U_dsi_BDM_ECOBRAPTQB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECOBRAPTQB] (
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
-- Create table U_ECOBRAPTQB_DedList
-----------

IF OBJECT_ID('U_ECOBRAPTQB_DedList') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECOBRAPTQB_drvTbl_QB
-----------

IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QB] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvRecordID] varchar(4) NOT NULL,
    [drvClientName] varchar(8000) NULL,
    [drvClientDivisionName] varchar(8000) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvIndividualID] char(9) NULL,
    [drvEmail] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(3) NULL,
    [drvPremAddSameAsPrimary] varchar(4) NOT NULL,
    [drvPremiumAddress1] varchar(1) NOT NULL,
    [drvPremiumAddress2] varchar(1) NOT NULL,
    [drvPremiumCity] varchar(1) NOT NULL,
    [drvPremiumStateOrProvince] varchar(1) NOT NULL,
    [drvPremiumPostalCode] varchar(1) NOT NULL,
    [drvPremiumCountry] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmployeeType] varchar(7) NOT NULL,
    [drvEmployeePayrollType] varchar(7) NOT NULL,
    [drvYearsOfService] varchar(1) NOT NULL,
    [drvPremiumCouponType] varchar(10) NOT NULL,
    [drvUsesHCTC] varchar(5) NOT NULL,
    [drvActive] varchar(4) NOT NULL,
    [drvAllowMemberSSO] varchar(5) NOT NULL,
    [drvBenefitGroup] varchar(1) NOT NULL,
    [drvAccountStructure] varchar(1) NOT NULL,
    [drvClientSpecificData] varchar(1) NOT NULL
);

-----------
-- Create table U_ECOBRAPTQB_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBDEP] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvRecordId] varchar(13) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvRelationship] varchar(15) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddressSameAsQB] varchar(5) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvEnrollmentDate] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvIsQMCSO] varchar(5) NOT NULL
);

-----------
-- Create table U_ECOBRAPTQB_drvTbl_QBDEPINIT
-----------

IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBDEPINIT') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBDEPINIT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvRecordID] varchar(24) NOT NULL,
    [drvPlanName] varchar(33) NULL
);

-----------
-- Create table U_ECOBRAPTQB_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvRecordID] varchar(9) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeName] varchar(201) NOT NULL,
    [drvSecondEventOriginalFDOC] varchar(1) NOT NULL
);

-----------
-- Create table U_ECOBRAPTQB_drvTbl_QBMEMRATE
-----------

IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBMEMRATE') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBMEMRATE] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvRecordID] varchar(33) NOT NULL,
    [drvPlanName] varchar(17) NULL,
    [drvRate] varchar(30) NULL
);

-----------
-- Create table U_ECOBRAPTQB_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_drvTbl_QBPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDepRecID] char(12) NULL,
    [drvRecordIdentifierQBPL] varchar(15) NOT NULL,
    [drvPlanNameQBPL] varchar(48) NULL,
    [drvCoverageLevelQBPL] varchar(11) NULL,
    [drvNumberOfUnits] varchar(30) NULL
);

-----------
-- Create table U_ECOBRAPTQB_EEList
-----------

IF OBJECT_ID('U_ECOBRAPTQB_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECOBRAPTQB_File
-----------

IF OBJECT_ID('U_ECOBRAPTQB_File') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_ECOBRAPTQB_Header
-----------

IF OBJECT_ID('U_ECOBRAPTQB_Header') IS NULL
CREATE TABLE [dbo].[U_ECOBRAPTQB_Header] (
    [drvRecordID] varchar(9) NOT NULL,
    [drvVersionNumber] varchar(3) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBRAPTQB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Lube Tech

Created By: Inshan Singh
Business Analyst: Cheryl Pettiti
Create Date: 11/06/2020
Service Request Number: TekP-2020-09-03-0001

Purpose: EBC QB Cobra Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECOBRAPTQB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECOBRAPTQB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECOBRAPTQB';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECOBRAPTQB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECOBRAPTQB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBRAPTQB', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBRAPTQB', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECOBRAPTQB', 'SCH_ECOBRA';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECOBRAPTQB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECOBRAPTQB', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECOBRAPTQB';

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
    DELETE FROM dbo.U_ECOBRAPTQB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECOBRAPTQB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove test employees
    IF @exportCode <> 'TEST_XOE'
    BEGIN
        DELETE FROM dbo.U_ECOBRAPTQB_EEList
        WHERE xEEID IN (select eeceeid from dbo.empcomp with (nolock) where eeceetype = 'TES')
    END

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LIFEC, DEN, DENSC, VIS, VISSC, MED4, MED6S, MED5, MED, GLIFE, GCICH, GRACC, GRCIL, GCISP, LIFEE, FSA, LIFES';
    --
    IF OBJECT_ID('U_ECOBRAPTQB_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECOBRAPTQB_DedList
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
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','1');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','1');

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then bdmChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4,205'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,203,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','206, 203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DA,DPC,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'GetChangeReason', 'Y')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AllowMultiDedType', 'Y')

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

     --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ECOBRAPTQB
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ECOBRAPTQB
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ECOBRAPTQB
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ECOBRAPTQB
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ECOBRAPTQB
        SET BdmUSGField1 = CONVERT(VARCHAR(20),DedEEBenAmt)
    FROM dbo.U_dsi_bdm_ECOBRAPTQB
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2
        WHERE  EedFormatCode = @FormatCode AND EedValidForExport = 'Y';;

    ----==========================================
    ---- Insert into BDM Reason code 201 and 204
    ----==========================================
    INSERT INTO [dbo].[U_dsi_BDM_ECOBRAPTQB]
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
        ,[BdmBenStartDate]
        ,[BdmBenStopDate]
        ,[BdmBenStatusDate]
        ,[BdmChangeReason]
        ,[BdmStartDate]
        ,[BdmStopDate]
        ,[BdmIsPQB]
        ,[BdmBenStatus]
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
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,EdhBenStatusDate
        ,'204'
        ,dbnBenStartDate
        ,dbnBenStopDate
        ,CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
        ,DbnBenStatus
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions 
        ON dbneeid = edheeid 
        AND dbnformatcode = 'ECOBRAPTQB'
        AND dbnDedCode = EdhDedCode
    WHERE edhChangeReason IN ('204') 
        AND dbnTVStartDate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N' -- 4/16/2021 change from edhBenstatusdate to dbnTVStartDate as changes weren't reliable using status date
        AND DbnBenStatus NOT IN ('C','W')
        AND DbnDedCode NOT IN  ('LIFEC','GCICH','GRACC','GCISP','GCISP','FSA','LIFES')

    INSERT INTO [dbo].[U_dsi_BDM_ECOBRAPTQB]
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
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmChangeReason]
    ,[BdmStartDate]
    ,[BdmStopDate]
    ,[BdmIsPQB]
    ,[BdmBenStatus]
    )
    SELECT rectype = 'DEP'
        ,EdhCoid
        ,EdhEEID
        ,DbnDepRecID
        ,DbnDepRecID
        ,'QB'
        ,'Data Inserted for 201 Chg reason'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,EdhDedCode
        ,dbnBenStartDate
        ,dbnBenStopDate
        ,edhBenStatusDate
        ,'201'
        ,dbnBenStartDate
        ,dbnBenStopDate
        ,'Y' 
        ,DbnBenStatus
    FROM dbo.EmpHDed WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions 
        ON dbneeid = edheeid 
        AND dbnformatcode = @FormatCode
        AND dbnrelationship  NOT IN  ('SPS','DP')
        AND dbnDedCode = EdhDedCode
    JOIN dbo.Contacts 
        ON DbnDepRecId = ConSystemId 
        AND ConIsDependent = 'Y'
    WHERE EdhChangeReason IN ('201') 
        AND dbnTVStartDate BETWEEN @startdate AND @enddate 
        AND dbnValidForExport = 'N' -- 4/16/2021 change from edhBenstatusdate to dbnTVStartDate as changes weren't reliable using status date
        AND DbnBenStatus NOT IN ('C','W','T')
        AND DbnDedCode NOT IN  ('LIFEC','GCICH','GRACC','GCISP','GCISP','FSA','LIFES')


 INSERT INTO [dbo].[U_dsi_BDM_ECOBRAPTQB]
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
    ,[BdmBenStartDate]
    ,[BdmBenStopDate]
    ,[BdmBenStatusDate]
    ,[BdmChangeReason]
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
    ,'Data Inserted for 210 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,dbnBenStartDate
    ,dbnBenStopDate
    ,edhBenStatusDate
    ,'210'
    ,dbnBenStartDate
    ,dbnBenStopDate
    ,CASE WHEN dbnRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
FROM dbo.emphded WITH (NOLOCK)
JOIN dbo.U_dsi_BDM_DepDeductions 
    ON dbneeid = edheeid 
    AND dbnformatcode = @formatcode
WHERE edhChangeReason IN ('210') 
    AND dbnTVStartDate BETWEEN @startdate AND @enddate 
    AND dbnValidForExport = 'N' -- 4/16/2021 change from edhBenstatusdate to dbnTVStartDate as changes weren't reliable using status date
    AND DbnDedCode NOT IN  ('LIFEC','GCICH','GRACC','GCISP','GCISP','FSA','LIFES')




 Delete from dbo.U_dsi_BDM_ECOBRAPTQB where bdmdedcode not in (Select dedcode from U_ECOBRAPTQB_DedList)
 Delete from U_dsi_BDM_ECOBRAPTQB where bdmrelationship = 'Z'


  Update dbo.U_dsi_BDM_ECOBRAPTQB set bdmNumSpouses = (select count(*) from U_dsi_BDM_ECOBRAPTQB A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'SPS' and A.bdmcoid = X.bdmcoid),
 bdmNumChildren = (select count(*) from U_dsi_BDM_ECOBRAPTQB A 
 where A.bdmeeid = X.bdmeeid and bdmRelationship = 'CHL' and A.bdmcoid = X.bdmcoid)
 from dbo.U_dsi_BDM_ECOBRAPTQB X where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 210 Chg reason')

 DELETE from  dbo.U_dsi_BDM_ECOBRAPTQB
 where BdmDedRowStatus IN ('Data Inserted for 204 Chg reason','Data Inserted for 201 Chg reason','Data Inserted for 210 Chg reason') and bdmBenStopDate is null 


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAPTQB_drvTbl_QB
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QB','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ISNULL(BdmDepRecID,'')
        ,drvSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
        -- standard fields above and additional driver fields below
        ,drvRecordID = '[QB]'
        ,drvClientName = [dbo].[fn_AddDoubleQuotes]('Lubrication Technologies, Inc.')
        ,drvClientDivisionName = [dbo].[fn_AddDoubleQuotes](
                                    CASE WHEN eeCCOID = 'MVN6N' THEN 'Lube-Tech & Partners, LLC (LTP)'
                                     WHEN eeCCOID = 'MVN97' THEN 'Lube-Tech Equipment Service (ESI)'
                                     WHEN EecCoID = 'MVNCJ'  then 'Lube-Tech Liquid Recycling, Inc. (LLR)'
                                     WHEN EecCoID = 'BQ2L8' then 'Lube-Tech Services, LLC (LTS)'
                                END
                                )
        ,drvSalutation = '' -- leave blank
        ,drvFirstName = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConNameFirst ELSE eepNameFirst END
        ,drvMiddleInitial = CASE WHEN  bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or  bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then LEFT(ConNameMiddle,1) ELSE LEFT(EepNameMiddle,1) END
        ,drvLastName = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConNameLast ELSE EepNameLast END 
        ,drvSSN = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConSSN ELSE eepSSN END  
        ,drvIndividualID = EecEmpNo 
        ,drvEmail = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConEmailAddr ELSE EepAddressEMail END    
        ,drvPhone = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConPhoneHomeNumber ELSE EepPhoneHomeNumber END    
        ,drvPhone2 = '' -- leave blank
        ,drvAddress1 = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConAddressLine1 ELSE EepAddressLine1 END     
        ,drvAddress2 = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConAddressLine2 ELSE EepAddressLine2 END       
        ,drvCity = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConAddressCity ELSE EepAddressCity END 
        ,drvStateOrProvince =  CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConAddressState ELSE EepAddressState END  
        ,drvPostalCode =  CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConAddressZipCode ELSE EepAddressZipCode END  
        ,drvCountry = CASE WHEN EepAddressCountry = 'USA' THEN '' ELSE CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConAddressCountry ELSE EepAddressCountry END  END
        ,drvPremAddSameAsPrimary = 'TRUE'
        ,drvPremiumAddress1 = '' -- leave blank
        ,drvPremiumAddress2 = '' -- leave blank
        ,drvPremiumCity = '' -- leave blank
        ,drvPremiumStateOrProvince = '' -- leave blank
        ,drvPremiumPostalCode = '' -- leave blank
        ,drvPremiumCountry = '' -- leave blank
        ,drvSex = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConGender  ELSE eepgender  END  
        ,drvDOB = CASE WHEN bdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201')or bdmCobraReason IN ('LEVNT3', 'LEVNT4', '204', '210' ,'201') then ConDateOfBirth  ELSE EepDateOfBirth  END    
        ,drvTobaccoUse = 'UNKNOWN'
        ,drvEmployeeType = 'UNKNOWN'
        ,drvEmployeePayrollType = 'UNKNOWN'
        ,drvYearsOfService = '' -- leave blank
        ,drvPremiumCouponType = 'COUPONBOOK'
        ,drvUsesHCTC = 'FALSE'
        ,drvActive = 'TRUE'
        ,drvAllowMemberSSO = 'FALSE'
        ,drvBenefitGroup = '' -- leave blank
        ,drvAccountStructure = '' -- leave blank
        ,drvClientSpecificData = '' -- leave blank
    INTO dbo.U_ECOBRAPTQB_drvTbl_QB
    FROM dbo.U_ECOBRAPTQB_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ECOBRAPTQB WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts with (nolock) 
    ON ConEEID = xEEID
       AND ConSystemID = BdmDepRecID
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = xCoID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
    Where bdmRunID = 'QB' and bdmIsPQB = 'Y'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAPTQB_drvTbl_QBEVENT
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBEVENT','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
        -- standard fields above and additional driver fields below
        ,drvRecordID = '[QBEVENT]'
        ,drvEventType = CASE
                            WHEN EecEmplStatus = 'T' and EecTermReason = '203' OR BdmCobraReason = '210' THEN 'DEATH' 
                            WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('202', '203') and eectermtype  = 'V' THEN 'TERMINATION'
                            WHEN EecEmplStatus = 'T' and eectermtype = 'I' THEN 'INVOLUNTARYTERMINATION'
                            WHEN bdmChangeReason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION' 
                            WHEN bdmChangeReason = '205' THEN 'MEDICARE'
                            WHEN bdmChangeReason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT' 
                            WHEN bdmChangeReason IN ('203', '202') THEN  'REDUCTIONINHOURS-STATUSCHANGE' 
                            WHEN bdmChangeReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE' 
                            else  'TERMINATION' 
                        END
        ,drvEventDate = BdmBenStopdate /*CASE 
                            WHEN  EecEmplStatus = 'T' and EecTermReason NOT IN ('202', '203')THEN EecDateOfTermination
                            WHEN  EecEmplStatus = 'T' and EecTermReason  IN ('202', '203')and eepDateOfCOBRAEvent  is NULL THEN EecDateOfTermination
                            WHEN  BdmChangeReason IN  ('LEVNT3', 'LEVNT4', '204', '210',  '201', '302') THEN bdmbenstatusdate
                            else  isnull(eepDateOfCOBRAEvent,bdmbenstatusdate)
                        END */

        ,drvEnrollmentDate =  case when bdmrectype = 'EMP' THEN bddate.bdmbenstartdate 
                                when bdmrectype = 'DEP' THEN bddate.bdmbenstartdate end   
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeName = CONCAT(Eepnamefirst, ' ', Eepnamelast)
        ,drvSecondEventOriginalFDOC = '' -- leave blank
    INTO dbo.U_ECOBRAPTQB_drvTbl_QBEVENT
       FROM dbo.U_ECOBRAPTQB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp with (nolock)
        ON EecEEID = drvEEID
        and EecCOID = drvCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN(
    SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmChangereason = MAX(BdmChangereason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
            ,BdmBenStatusDate = MAX(BdmBenStatusDate)
            ,BdmBenStopdate = MAX(BdmBenStopdate)
          from dbo.U_dsi_BDM_ECOBRAPTQB 
          where bdmRunID = 'QB' and bdmIsPQB = 'Y'
           GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType
    ) bdDate
        ON bdDate.BdmEEID = drvEEID 
        AND bdDate.BdmCoID = drvCOID 
    LEFT JOIN dbo.Contacts with (nolock)
    ON ConEEID = drvEEID
       AND ConSystemID = bdmDepRecID

    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = drvCOID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'

    ;


     --------------------------------- 
    -- DETAIL RECORD - U_ECOBRAPTQB_drvTbl_QBPLAN 
    --------------------------------- 
    IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCoID
        ,drvSort   = '21'
        ,drvSubSort       =  drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
        ,drvDepRecID = BdmDepRecID --CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRecordIdentifierQBPL = '[QBPLANINITIAL]'
        ,drvPlanNameQBPL = 
        CASE
                        WHEN BdmDedCode IN ('DEN', 'DENSC') then 'DELTA DENTAL - 4113' -- DDM
                        WHEN BdmDedCode IN ('VIS', 'VISSC') then 'EYEMED VISION' -- DDM
                        WHEN BdmDedCode IN ('MED4', 'MED6S') then 'HEALTH PARTNERS MEDICAL 2800 HDHP' -- DDM
                        WHEN BdmDedCode IN ('MED5', 'MED') then 'HEALTH PARTNERS MEDICAL 750' -- DDM
                        WHEN drvEventType NOT IN ('DEATH','DIVORCELEGALSEPARATION','INELIGIBLEDEPENDENT') THEN
                            CASE WHEN BdmDedCode IN ('LIFEC') then 'CHILD VOLUNTARY LIFE RATES'                        
                            WHEN BdmDedCode IN ('GCICH') then 'LIBERTY MUTUAL CHILD(REN) CRITICAL ILLNESS'
                            WHEN BdmDedCode IN ('GRACC') then 'LIBERTY MUTUAL GROUP ACCIDENT INDEMNITY'
                            WHEN BdmDedCode IN ('GCISP') and ConIsSmoker = 'N' then 'LIBERTY MUTUAL SP CRITICAL ILLNESS (NON-TOBACCO)'
                            WHEN BdmDedCode IN ('GCISP') and ConIsSmoker = 'Y' then 'LIBERTY MUTUAL SP CRITICAL ILLNESS (TOBACCO)'
                            WHEN BdmDedCode IN ('GCISP') and EepIsSmoker = 'N' then 'LIBERTY MUTUAL SP CRITICAL ILLNESS (NON-TOBACCO)'
                            WHEN BdmDedCode IN ('GCISP') and EepIsSmoker = 'Y' then 'LIBERTY MUTUAL SP CRITICAL ILLNESS (TOBACCO)'
                            WHEN BdmDedCode IN ('FSA')  then 'SELECTACCOUNT FSA'
                            WHEN BdmDedCode IN ('LIFES') then 'SPOUSE VOLUNTARY LIFE RATES'
                            WHEN bdmDedCode IN ('GRCIL') and EepIsSmoker = 'N' then 'LIBERTY MUTUAL QB CRITICAL ILLNESS (NON-TOBACCO)'
                            WHEN bdmDedCode IN ('GRCIL') and EepIsSmoker = 'Y' then 'LIBERTY MUTUAL QB CRITICAL ILLNESS (TOBACCO)'
                            WHEN bdmDedCode IN ('LIFEE' ) then 'QB VOLUNTARY LIFE RATES'
                            WHEN bdmDedCode IN ('GLIFE') then 'LIBERTY MUTUAL BASIC LIFE'
                            END
                       END
    
        ,drvCoverageLevelQBPL = CASE  
                                       WHEN BdmChangeReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210')
                                        or BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') THEN
                                        CASE WHEN BdmNumChildren = 1 AND BdmNumSpouses = 1 then 'EE+CHILD'
                                        WHEN BdmNumChildren > 1 AND BdmNumSpouses = 1 then 'EE+CHILDREN'
                                        ELSE 'EE'
                                        END
                                    WHEN bdmchangereason in ('201','204') THEN 'EE'
                                    WHEN bdmDedCode IN ('DEN', 'DENSC', 'VIS', 'VISSC', 'MED4', 'MED6S', 'MED5', 'MED', 'GRACC') and bdmBenOption IN ('EE') then 'EE'
                                    WHEN bdmDedCode IN ('DEN', 'DENSC', 'VIS', 'VISSC', 'MED4', 'MED6S', 'MED5', 'MED', 'GRACC') and bdmBenOption IN ('EES') then 'EE+SPOUSE'
                                    WHEN bdmDedCode IN ('DEN', 'DENSC', 'VIS', 'VISSC', 'MED4', 'MED6S', 'MED5', 'MED', 'GRACC') and bdmBenOption IN ('EEC') then 'EE+CHILDREN'
                                    WHEN bdmDedCode IN ('DEN', 'DENSC', 'VIS', 'VISSC', 'MED4', 'MED6S', 'MED5', 'MED', 'GRACC') and bdmBenOption IN ('EEF') then 'EE+FAMILY'
                                    WHEN bdmDedCode IN ('LIFEC') and bdmBenOption IN ('CL2K', 'CL5K', 'CL10') then 'CHILDONLY'
                                    --WHEN bdmDedCode IN ('GCICH') and bdmBenOption IN ('EEC') then 'CHILDONLY'
                                    WHEN bdmDedCode IN ('GCICH')  then 'CHILDONLY'  -- 1/12/2021 update to remove ben option check
                                    WHEN bdmDedCode IN ('GLIFE') and( bdmBenOption IN ('EE') or bdmbenoption is null or bdmbenoption in ('z')) then 'EE'
                                    WHEN bdmDedCode IN ('GRCIL') and bdmBenOption  IS NULL or bdmBenOption IN ('EE') then 'EE'
                                    WHEN bdmDedCode IN ('LIFEE') and bdmBenOption IS NULL  or bdmBenOption IN ('EE') then 'EE'
                                     WHEN bdmDedCode IN ('GCISP') and bdmBenOption IN ('EES') or  bdmDedCode IN ('GCISP') and  ISNULL(bdmBenOption,'') = '' then 'SPOUSEONLY'
                                    --WHEN bdmDedCode IN ('LIFES') and bdmBenOption IN ('EES') then 'SPOUSEONLY'
                                    WHEN bdmDedCode IN ('LIFES') then 'SPOUSEONLY'
                                    WHEN bdmDedCode IN ('FSA') and (bdmBenOption IN ('EE') or bdmBenoption is null) then 'EE'
                                    WHEN bdmDedCode IN ('FSA') and bdmBenOption IN ('EEF') then 'EE+FAMILY' 
                                END
                
        ,drvNumberOfUnits = CONVERT(VARCHAR, CASE WHEN BdmDedCode IN ('GLIFE', 'LIFEE', 'LIFEC', 'LIFES') THEN CONVERT(DECIMAL(10,0), CONVERT(NUMERIC, BdmUSGField1)/1000)  END)
    INTO dbo.U_ECOBRAPTQB_drvTbl_QBPLAN
    FROM dbo.U_ECOBRAPTQB_drvTbl_QBEvent WITH (NOLOCK)
        JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
        JOIN dbo.U_dsi_BDM_ECOBRAPTQB WITH (NOLOCK)
            ON BdmEEID = drvEEID
           AND BdmCoID = drvCoID
     LEFT JOIN dbo.Contacts with (nolock)
        ON ConEEID =  drvDepRecID
        WHERE BdmIsPQB = 'Y'    
    ;
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = drvEEID
    --JOIN dbo.U_dsi_BDM_ECOBRAPTQB WITH (NOLOCK)
    --    ON bdmEEID = drvEEID
    --    AND bdmCOID = drvCOID
    --LEFT JOIN (SELECT  NdpEEID    = BdmEEID
    --                ,NdpDedCode = BdmDedCode
    --                ,NdpNumDeps = COUNT(1)
    --        FROM (SELECT DISTINCT BdmEEID, BdmDepRecID, BdmDedCode
    --                FROM dbo.U_dsi_BDM_ECOBRAPTQB WITH (NOLOCK)                     WHERE BdmIsPQB = 'N') NDEP
    --        GROUP BY BdmEEID, BdmDedCode) NDP
    --ON NdpEEID = BdmEEID
    --AND NdpDedCode = BdmDedCode
    --LEFT JOIN dbo.Contacts with (nolock)
    --ON ConEEID = drvEEID
    --   AND ConSystemID = bdmDepRecID
    --WHERE bdmRunID = 'QB' and bdmIsPQB = 'Y'; 

    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAPTQB_drvTbl_QBDEP
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBDEP','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
        -- standard fields above and additional driver fields below
        ,drvRecordId = '[QBDEPENDENT]'
        ,drvSSN = ConSSN
        ,drvRelationship = CASE
                            WHEN ConRelationship = 'SPS' THEN 'SPOUSE'
                            WHEN ConRelationship = 'DP' THEN 'DOMESTICPARTNER'
                            WHEN ConRelationship IN ('CHL', 'DIS', 'DPC','STC') THEN 'CHILD' 
                           END
        ,drvSalutation = '' -- leave blank
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvLastName = ConNameLast
        ,drvEmail = '' --leave blank
        ,drvPhone = '' --leave blank
        ,drvPhone2 = '' --leave blank
        ,drvAddressSameAsQB = CASE
                                WHEN ConAddressIsDifferent = 'N' THEN 'TRUE'
                                Else 'FALSE' 
                              END
        ,drvAddress1 = CASE WHEN ConAddressIsDifferent <> 'N' THEN ConAddressLine1 END
        ,drvAddress2 =CASE WHEN ConAddressIsDifferent <> 'N' THEN ConAddressLine2 END 
        ,drvCity = CASE WHEN ConAddressIsDifferent <> 'N' THEN ConAddressCity END
        ,drvStateOrProvince = CASE WHEN ConAddressIsDifferent <> 'N' THEN ConAddressState END
        ,drvPostalCode = CASE WHEN ConAddressIsDifferent <> 'N' THEN ConAddressZipCode END
        ,drvCountry = '' -- leave blank 
        ,drvEnrollmentDate = '' -- leave blank 
        ,drvSex = ConGender
        ,drvDOB = ConDateOfBirth
        ,drvIsQMCSO = 'FALSE'
    INTO dbo.U_ECOBRAPTQB_drvTbl_QBDEP
       FROM dbo.U_ECOBRAPTQB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID 
        AND EecCoID = drvCOID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN dbo.U_dsi_BDM_ECOBRAPTQB WITH (NOLOCK)
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCOID
    LEFT JOIN dbo.Contacts with (nolock) 
    ON ConEEID = drvEEID
       AND ConSystemID = BdmDepRecID
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = drvCOID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
     WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N'
      AND BdmDedCode NOT IN ('LIFEC','GCICH''GRACC','GCISP','GCISP','FSA','LIFES')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAPTQB_drvTbl_QBDEPINIT
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBDEPINIT','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_drvTbl_QBDEPINIT;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = BdmDepRecID--DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
        -- standard fields above and additional driver fields below
        ,drvRecordID = '[QBDEPENDENTPLANINITIAL]'
        ,drvPlanName = CASE
                        --WHEN BdmDedCode IN ('LIFEC') then 'CHILD VOLUNTARY LIFE RATES'
                        WHEN BdmDedCode IN ('DEN', 'DENSC') then 'DELTA DENTAL - 4113'
                        WHEN BdmDedCode IN ('VIS', 'VISSC') then 'EYEMED VISION'
                        WHEN BdmDedCode IN ('MED4', 'MED6S') then 'HEALTH PARTNERS MEDICAL 2800 HDHP'
                        WHEN BdmDedCode IN ('MED5', 'MED') then 'HEALTH PARTNERS MEDICAL 750'
                        --WHEN BdmDedCode IN ('GCICH') then 'LIBERTY MUTUAL CHILD(REN) CRITICAL ILLNESS'
                        ---WHEN BdmDedCode IN ('GRACC') then 'LIBERTY MUTUAL GROUP ACCIDENT INDEMNITY'
                        --WHEN BdmDedCode IN ('GCISP') and ConIsSmoker = 'N' then 'LIBERTY MUTUAL SP CRITICAL ILLNESS (NON-TOBACCO)'
                        --WHEN BdmDedCode IN ('GCISP') and ConIsSmoker = 'Y' then 'LIBERTY MUTUAL SP CRITICAL ILLNESS (TOBACCO)'
                        --WHEN BdmDedCode IN ('FSA')  then 'SELECTACCOUNT FSA'
                        --WHEN BdmDedCode IN ('LIFES') then 'SPOUSE VOLUNTARY LIFE RATES'
                        -- 'LIFEC','GCICH''GRACC','GCISP','GCISP','FSA','LIFES'
                       END
    INTO dbo.U_ECOBRAPTQB_drvTbl_QBDEPINIT
       --FROM dbo.U_ECOBRAPTQB_drvTbl_QB WITH (NOLOCK)
FROM dbo.U_ECOBRAPTQB_drvTbl_QBDEP
    JOIN dbo.U_dsi_BDM_ECOBRAPTQB WITH (NOLOCK)
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCOID
    --JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    --    ON DbnEEID = drvEEID 
    --    AND DbnCoID = drvCOID
    --    AND DbnFormatCode = @FormatCode 
    --    AND DbnValidForExport = 'Y'
JOIN dbo.Contacts with (nolock)
    ON ConEEID = drvEEID
       AND ConSystemID = BdmDepRecID
WHERE BdmIsPQB = 'N' and BdmRunID = 'QB'
    AND BdmDedCode NOT IN ('LIFEC','GCICH''GRACC','GCISP','GCISP','FSA','LIFES')
       ; 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ECOBRAPTQB_drvTbl_QBMEMRATE
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAPTQB_drvTbl_QBMEMRATE','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_drvTbl_QBMEMRATE;
    SELECT DISTINCT
         drvEEID = drvEEID
        ,drvCoID = drvCOID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
        -- standard fields above and additional driver fields below
        ,drvRecordID = '[QBPLANMEMBERSPECIFICRATEINITIAL]'
        ,drvPlanName = CASE WHEN bdmDedCode = 'FSA' THEN  'SELECTACCOUNT FSA'  END
        ,drvRate = CONVERT(VARCHAR,CONVERT(MONEY,(bdmEEAmt * 2)))
    INTO dbo.U_ECOBRAPTQB_drvTbl_QBMEMRATE
       FROM dbo.U_ECOBRAPTQB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_ECOBRAPTQB WITH (NOLOCK)
        ON BdmEEID = drvEEID 
        AND BdmCoID = drvCOID
    --JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
    --    ON EedEEID = xEEID 
    --    AND EedCoID = drvCOID
    --    AND EedFormatCode = @FormatCode 
    --    AND EedValidForExport = 'Y'
    WHERE bdmRunID = 'QB' and bdmIsPQB = 'Y'
    and BdmDedType = 'FSA' and BdmIsCobraCovered = 'Y';
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECOBRAPTQB_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECOBRAPTQB_Header;
    SELECT DISTINCT
         drvRecordID = '[VERSION]'
        ,drvVersionNumber = '1.1'
    INTO dbo.U_ECOBRAPTQB_Header
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
ALTER VIEW dbo.dsi_vwECOBRAPTQB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECOBRAPTQB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECOBRAPTQB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202205011'
       ,expStartPerControl     = '202205011'
       ,expLastEndPerControl   = '202205159'
       ,expEndPerControl       = '202205159'
WHERE expFormatCode = 'ECOBRAPTQB' and expExportCode = 'TEST_XOE';
--202103121    202103199
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECOBRAPTQB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_ECOBRAPTQB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECOBRAPTQB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECOBRAPTQB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECOBRAPTQB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECOBRAPTQB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECOBRAPTQB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECOBRAPTQB', 'UseFileName', 'V', 'Y'


-- End ripout