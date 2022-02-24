/**********************************************************************************

EDISCOBRAT: ZDiscovery Benefits Cobra Export

FormatCode:     EDISCOBRAT
Project:        ZDiscovery Benefits Cobra Export
Client ID:      USO1001
Date/time:      2022-02-23 21:15:01.553
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPUSOC
Web Filename:   USO1001_839B6_EEHISTORY_EDISCOBRAT_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDISCOBRAT_SavePath') IS NOT NULL DROP TABLE dbo.U_EDISCOBRAT_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDISCOBRAT'


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
WHERE FormatCode = 'EDISCOBRAT'
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
WHERE ExpFormatCode = 'EDISCOBRAT'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDISCOBRAT')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDISCOBRAT'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDISCOBRAT'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDISCOBRAT'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDISCOBRAT'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDISCOBRAT'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDISCOBRAT'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDISCOBRAT'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDISCOBRAT'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDISCOBRAT'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDISCOBRAT_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCOBRAT_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCOBRAT') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBRAT];
GO
IF OBJECT_ID('U_EDISCOBRAT_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_File];
GO
IF OBJECT_ID('U_EDISCOBRAT_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_EEList];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBPLAN2') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBPLAN2];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvSPMPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvSPMPLAN];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENTPLAN_Temp') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvSPMDEPENDENTPLAN_Temp];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENTPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvSPMDEPENDENTPLAN];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENT') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvSPMDEPENDENT];
GO
IF OBJECT_ID('U_EDISCOBRAT_drvSPM') IS NOT NULL DROP TABLE [dbo].[U_EDISCOBRAT_drvSPM];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCOBRAT') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCOBRAT];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCOBRAT','ZDiscovery Benefits Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','E45G3E000040','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.2"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','10','1',NULL,'Record Identifier',NULL,NULL,'"[QB]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','100','D','10','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E45G3E000040','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E45G3E000040','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E45G3E000040','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E45G3E000040','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E45G3E000040','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E45G3E000040','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E45G3E000040','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E45G3E000040','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E45G3E000040','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E45G3E000040','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E45G3E000040','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E45G3E000040','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E45G3E000040','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E45G3E000040','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E45G3E000040','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E45G3E000040','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E45G3E000040','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E45G3E000040','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','E45G3E000040','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','E45G3E000040','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','E45G3E000040','50','D','10','28',NULL,'Tobacco Use',NULL,NULL,'"drvTobacoUse"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','E45G3E000040','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"FTE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','E45G3E000040','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"drvEmpPayrollType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','E45G3E000040','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','E45G3E000040','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','E45G3E000040','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','E45G3E000040','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','E45G3E000040','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"FALSE"','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','E45G3E000040','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','E45G3E000040','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','E45G3E000040','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','20','1',NULL,'Record Identifier',NULL,NULL,'"[QBEVENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','30','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','35','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLAN]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','35','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','35','3',NULL,'Start Date',NULL,NULL,'"drvStartDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','50','D','35','4',NULL,'End Date',NULL,NULL,'"drvEndDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','50','D','35','5',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','50','D','35','6',NULL,'First Day Of COBRA',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','50','D','35','7',NULL,'Last Day Of COBRA',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E45G3E000040','50','D','35','8',NULL,'Cobra Duration Months',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E45G3E000040','50','D','35','9',NULL,'Days to Elect',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E45G3E000040','50','D','35','9',NULL,'Days To Make 1st Payment',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E45G3E000040','50','D','35','9',NULL,'Days To Make Subsequent Payments',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E45G3E000040','50','D','35','9',NULL,'Election Postmark Date',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E45G3E000040','50','D','35','9',NULL,'Last Date Rates Notified',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E45G3E000040','50','D','35','9',NULL,'Number Of Units',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E45G3E000040','50','D','35','9',NULL,'Send Plan Change Letter For Legacy',NULL,NULL,'"False"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E45G3E000040','50','D','35','9',NULL,'Plan Bundle Name',NULL,NULL,'"drvPlanBundleName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','40','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','50','D','40','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','50','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','50','D','40','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E45G3E000040','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E45G3E000040','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E45G3E000040','50','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E45G3E000040','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvIsAddressSame"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E45G3E000040','50','D','40','12',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E45G3E000040','50','D','40','13',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E45G3E000040','50','D','40','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E45G3E000040','50','D','40','15',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E45G3E000040','50','D','40','16',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E45G3E000040','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E45G3E000040','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E45G3E000040','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E45G3E000040','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E45G3E000040','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"drvISQMCO"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','50','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','60','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','60','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','60','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','70','1',NULL,'Version Line Identifier',NULL,NULL,'"[NPM]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','70','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','70','3',NULL,'IndividualIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','100','D','70','4',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','50','D','70','5',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','50','D','70','6',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','50','D','70','7',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E45G3E000040','50','D','70','8',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E45G3E000040','50','D','70','9',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E45G3E000040','50','D','70','10',NULL,'Email',NULL,NULL,'"drvAddressEMail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E45G3E000040','50','D','70','11',NULL,'Phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E45G3E000040','50','D','70','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E45G3E000040','50','D','70','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E45G3E000040','50','D','70','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E45G3E000040','50','D','70','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E45G3E000040','50','D','70','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E45G3E000040','50','D','70','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E45G3E000040','50','D','70','18',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E45G3E000040','50','D','70','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E45G3E000040','50','D','70','20',NULL,'UsesFamilyInAddress',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E45G3E000040','50','D','70','21',NULL,'HasWaivedAllCoverage',NULL,NULL,'"FALSE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E45G3E000040','50','D','70','22',NULL,'SendGRNotice',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E45G3E000040','50','D','70','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','73','1',NULL,'Version Line Identifier',NULL,NULL,'"[SPM]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','100','D','73','2',NULL,'Client Name',NULL,NULL,'"drvSPMClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','50','D','73','3',NULL,'Client Division Name',NULL,NULL,'"drvSPMDivisionName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','35','D','73','4',NULL,'Salutation',NULL,NULL,'"drvSPMSalutation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','50','D','73','5',NULL,'First Name',NULL,NULL,'"drvSPMFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','1','D','73','6',NULL,'Middle Initial',NULL,NULL,'"drvSPMMiddleName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','50','D','73','7',NULL,'Last Name',NULL,NULL,'"drvSPMLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E45G3E000040','11','D','73','8',NULL,'SSN',NULL,NULL,'"drvSPMSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E45G3E000040','50','D','73','9',NULL,'Individual ID',NULL,NULL,'"drvSPMIndId"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E45G3E000040','50','D','73','10',NULL,'Email',NULL,NULL,'"drvSPMEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E45G3E000040','10','D','73','11',NULL,'Phone',NULL,NULL,'"drvSPMPhone"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E45G3E000040','10','D','73','12',NULL,'Phone 2',NULL,NULL,'"drvSPMPhone2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E45G3E000040','50','D','73','13',NULL,'Address 1',NULL,NULL,'"drvSPMAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E45G3E000040','50','D','73','14',NULL,'Address 2',NULL,NULL,'"drvSPMAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E45G3E000040','50','D','73','15',NULL,'City',NULL,NULL,'"drvSPMCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E45G3E000040','50','D','73','16',NULL,'State Or Province',NULL,NULL,'"drvSPMStateProvince"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E45G3E000040','35','D','73','17',NULL,'Postal Code',NULL,NULL,'"drvSPMPostalCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E45G3E000040','50','D','73','18',NULL,'Country',NULL,NULL,'"drvSPMCountry"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E45G3E000040','1','D','73','19',NULL,'Sex',NULL,NULL,'"drvSPMSex"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E45G3E000040','10','D','73','20',NULL,'DOB',NULL,NULL,'"drvSPMDateofBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E45G3E000040','10','D','73','21',NULL,'Billing Start Date',NULL,NULL,'"drvSPMBillStartDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','E45G3E000040','10','D','73','22',NULL,'Billing End Date',NULL,NULL,'"drvSPMBillEndDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','E45G3E000040','35','D','73','23',NULL,'Billing Type',NULL,NULL,'"drvSPMBillingType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','E45G3E000040','35','D','73','24',NULL,'Billing Frequency',NULL,NULL,'"drvSPMBillFreq"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','E45G3E000040','5','D','73','25',NULL,'Is COBRA Eligible',NULL,NULL,'"drvSPMIsCobraElig"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','E45G3E000040','5','D','73','26',NULL,'Is COBRA Eligible At Termination',NULL,NULL,'"drvSPMIsCobraEligAtTerm"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','E45G3E000040','12','D','73','27',NULL,'Grace Period Nr Of Days',NULL,NULL,'"drvSPMGracePeriodNrDays"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','E45G3E000040','45','D','73','28',NULL,'SPM Grace Period Option Type',NULL,NULL,'"drvSPMGracePrdOptType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','E45G3E000040','5','D','73','29',NULL,'Is Legacy',NULL,NULL,'"drvSPMIsLegacy"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','E45G3E000040','35','D','73','30',NULL,'Tobacco Use',NULL,NULL,'"drvSPMTobaccoUse"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','E45G3E000040','10','D','73','31',NULL,'Enrollment Date',NULL,NULL,'"drvSPMEnrollmentDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','E45G3E000040','35','D','73','32',NULL,'Employee Type',NULL,NULL,'"drvSPMEmpType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','E45G3E000040','35','D','73','33',NULL,'Employee Payroll Type',NULL,NULL,'"drvSPMEmpPayType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','E45G3E000040','12','D','73','34',NULL,'Years Of Service',NULL,NULL,'"drvSPMYearsService"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','E45G3E000040','35','D','73','35',NULL,'Premium Coupon Type',NULL,NULL,'"drvSPMPremCouponType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','E45G3E000040','5','D','73','36',NULL,'Active',NULL,NULL,'"drvSPMActive"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','E45G3E000040','5','D','73','37',NULL,'Allow Member SSO',NULL,NULL,'"drvSPMAllowSSO"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','E45G3E000040','50','D','73','38',NULL,'Benefit Group',NULL,NULL,'"drvSPMBenGroup"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','E45G3E000040','50','D','73','39',NULL,'Account Structure',NULL,NULL,'"drvSPMAcctStrucure"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','E45G3E000040','50','D','73','40',NULL,'Client Custom Data',NULL,NULL,'"drvSPMClientCustData"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','E45G3E000040','50','D','73','41',NULL,'SSOIdentifier',NULL,NULL,'""','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','E45G3E000040','10','D','73','41',NULL,'Event Date',NULL,NULL,'"drvSPMEventDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','E45G3E000040','10','D','73','42',NULL,'Initial Grace Period Date',NULL,NULL,'"drvSPMInitGracePeriodDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','E45G3E000040','10','D','73','43',NULL,'Billing Period Seed Date',NULL,NULL,'"drvSPMBillingPeriodDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','E45G3E000040','10','D','73','44',NULL,'Second Billing Period Seed Date',NULL,NULL,'"drvSPM2ndBillingPeriodDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','E45G3E000040','100','D','73','45',NULL,'Plan Category',NULL,NULL,'"drvSPMPlanCategory"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','75','1',NULL,'Version Line Identifier',NULL,NULL,'"[SPMPLAN]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','75','2',NULL,'Plan Name',NULL,NULL,'"drvSPMLPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','10','D','75','3',NULL,'Start Date',NULL,NULL,'"drvSPMLStartDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','10','D','75','4',NULL,'End Date',NULL,NULL,'"drvSPMLEndDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','35','D','75','5',NULL,'Coverage Level',NULL,NULL,'"drvSPMLCovLevel"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','10','D','75','6',NULL,'First Day Of Coverage',NULL,NULL,'"drvSPMLFirstDay"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','10','D','75','7',NULL,'Last Day Of Coverage',NULL,NULL,'"drvSPMLLastDay"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E45G3E000040','10','D','75','8',NULL,'Last Date Rates Notified',NULL,NULL,'"drvSPMLLastDateNotified"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E45G3E000040','5','D','75','9',NULL,'Send Plan Change Letter For Legacy',NULL,NULL,'"drvSPMLSendPlanChange"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E45G3E000040','12','D','75','10',NULL,'Number Of Units',NULL,NULL,'"drvSPMLNumberUnits"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E45G3E000040','50','D','75','11',NULL,'Bundle Name',NULL,NULL,'"drvSPMLBundleName"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','80','1',NULL,'Version Line Identifier',NULL,NULL,'"[SPMDEPENDENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','11','D','80','2',NULL,'SSN',NULL,NULL,'"drvSPMDSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','35','D','80','3',NULL,'Relationship',NULL,NULL,'"drvSPMDRelationShip"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','35','D','80','4',NULL,'Salutation',NULL,NULL,'"drvSPMDSalutation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','50','D','80','5',NULL,'First Name',NULL,NULL,'"drvSPMDFirstName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','E45G3E000040','1','D','80','6',NULL,'Middle Initial',NULL,NULL,'"drvSPMDMiddleInitial"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','E45G3E000040','50','D','80','7',NULL,'Last Name',NULL,NULL,'"drvSPMDLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','E45G3E000040','50','D','80','8',NULL,'Email',NULL,NULL,'"drvSPMDEmail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','E45G3E000040','10','D','80','9',NULL,'Phone',NULL,NULL,'"drvSPMDPhone"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','E45G3E000040','10','D','80','10',NULL,'Phone 2',NULL,NULL,'"drvSPMDPhone2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','E45G3E000040','5','D','80','11',NULL,'Address Same As SPM',NULL,NULL,'"drvSPMDSameasSPM"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','E45G3E000040','50','D','80','12',NULL,'Address 1',NULL,NULL,'"drvSPMDAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','E45G3E000040','50','D','80','13',NULL,'Address 2',NULL,NULL,'"drvSPMDAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','E45G3E000040','50','D','80','14',NULL,'City',NULL,NULL,'"drvSPMDCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','E45G3E000040','50','D','80','15',NULL,'State Or Province',NULL,NULL,'"drvSPMDState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','E45G3E000040','35','D','80','16',NULL,'Postal Code',NULL,NULL,'"drvSPMDPostalCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','E45G3E000040','50','D','80','17',NULL,'Country',NULL,NULL,'"drvSPMDCountry"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','E45G3E000040','10','D','80','18',NULL,'Enrollment Date',NULL,NULL,'"drvSPMDEnrollmentdate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','E45G3E000040','1','D','80','19',NULL,'Sex',NULL,NULL,'"drvSPMDSex"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','E45G3E000040','10','D','80','20',NULL,'DOB',NULL,NULL,'"drvSPMDDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','E45G3E000040','5','D','80','21',NULL,'Is QMCSO',NULL,NULL,'"drvSPMDISQMCSO"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','E45G3E000040','50','D','85','1',NULL,'Version Line Identifier',NULL,NULL,'"[SPMDEPENDENTPLAN]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','E45G3E000040','50','D','85','2',NULL,'Plan Name',NULL,NULL,'"drvSPMDPPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','E45G3E000040','10','D','85','3',NULL,'Start Date',NULL,NULL,'"drvSPMDPStartDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','E45G3E000040','10','D','85','4',NULL,'End Date',NULL,NULL,'"drvSPMEndDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','E45G3E000040','5','D','85','5',NULL,'Uses First Day Of Coverage',NULL,NULL,'"drvSPMFirstDayOfCov"','(''UD101''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDISCOBRAT_20220223.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'ZNPM/Cobra Export','202002289','EMPEXPORT','ONDEMAND','Mar  2 2020  4:28PM','EDISCOBRAT',NULL,NULL,NULL,'202002289','Oct 30 2017 12:00AM','Dec 30 1899 12:00AM','202002141','3858',NULL,NULL,'202002141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'ZDiscovery COBRA','202011139','EMPEXPORT','SCH_DISC','Nov 19 2020 12:00AM','EDISCOBRAT',NULL,NULL,NULL,'202201149','Nov 13 2020 12:00AM','Dec 30 1899 12:00AM','202201071',NULL,NULL,NULL,'202011061',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'ZDiscovery COBRA - OLD','202201099','EMPEXPORT','SCHEDULED','Jan  9 2022 12:00AM','EDISCOBRAT',NULL,NULL,NULL,'202201099','Jan  9 2022 12:00AM','Dec 30 1899 12:00AM','202201011',NULL,NULL,NULL,'202201011',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','V5C6H,V5C45',NULL,NULL,NULL,'ZTest NPM/Cobra Export','202202179','EMPEXPORT','TEST','Feb  4 2022 12:00AM','EDISCOBRAT',NULL,NULL,NULL,'202202179','Feb  5 2022 12:00AM','Dec 30 1899 12:00AM','202202011','56','','','202202011',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCOBRAT','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D10','dbo.U_EDISCOBRAT_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D20','dbo.U_EDISCOBRAT_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D30','dbo.U_EDISCOBRAT_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D35','dbo.U_EDISCOBRAT_drvTbl_QBPLAN2 WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D40','dbo.U_EDISCOBRAT_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D50','dbo.U_EDISCOBRAT_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D60','dbo.U_EDISCOBRAT_drvTbl_QBMSRI WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D70','dbo.U_EDISCOBRAT_drvTbl_NPM WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D73','dbo.U_EDISCOBRAT_drvSPM WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D75','dbo.U_EDISCOBRAT_drvSPMPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D80','dbo.U_EDISCOBRAT_drvSPMDEPENDENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCOBRAT','D85','dbo.U_EDISCOBRAT_drvSPMDEPENDENTPLAN WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDISCOBRAT
-----------

IF OBJECT_ID('U_dsi_BDM_EDISCOBRAT') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCOBRAT] (
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
-- Create table U_EDISCOBRAT_drvSPM
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvSPM') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvSPM] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSPMClientName] varchar(58) NOT NULL,
    [drvSPMDivisionName] varchar(9) NOT NULL,
    [drvSPMSalutation] varchar(1) NOT NULL,
    [drvSPMFirstName] varchar(100) NULL,
    [drvSPMMiddleName] varchar(1) NULL,
    [drvSPMLastName] varchar(100) NULL,
    [drvSPMSSN] char(11) NULL,
    [drvSPMIndId] varchar(1) NOT NULL,
    [drvSPMEmail] varchar(1) NOT NULL,
    [drvSPMPhone] varchar(1) NOT NULL,
    [drvSPMPhone2] varchar(1) NOT NULL,
    [drvSPMAddressLine1] varchar(255) NULL,
    [drvSPMAddressLine2] varchar(255) NULL,
    [drvSPMCity] varchar(255) NULL,
    [drvSPMStateProvince] varchar(255) NULL,
    [drvSPMPostalCode] varchar(50) NULL,
    [drvSPMCountry] varchar(1) NOT NULL,
    [drvSPMSex] char(1) NULL,
    [drvSPMDateofBirth] datetime NULL,
    [drvSPMBillStartDate] datetime NULL,
    [drvSPMBillEndDateBefore] datetime NULL,
    [drvSPMBillEndDate] datetime NULL,
    [drvSPMBillingType] varchar(10) NULL,
    [drvSPMBillFreq] varchar(7) NOT NULL,
    [drvSPMIsCobraElig] varchar(4) NOT NULL,
    [drvSPMIsCobraEligAtTerm] varchar(4) NOT NULL,
    [drvSPMGracePeriodNrDays] varchar(1) NOT NULL,
    [drvSPMGracePrdOptType] varchar(13) NOT NULL,
    [drvSPMIsLegacy] varchar(5) NOT NULL,
    [drvSPMTobaccoUse] varchar(7) NOT NULL,
    [drvSPMEnrollmentDate] datetime NULL,
    [drvSPMEmpType] varchar(3) NOT NULL,
    [drvSPMEmpPayType] varchar(6) NOT NULL,
    [drvSPMYearsService] varchar(1) NOT NULL,
    [drvSPMPremCouponType] varchar(10) NOT NULL,
    [drvSPMActive] varchar(4) NOT NULL,
    [drvSPMAllowSSO] varchar(5) NOT NULL,
    [drvSPMBenGroup] varchar(1) NOT NULL,
    [drvSPMAcctStrucure] varchar(1) NOT NULL,
    [drvSPMClientCustData] varchar(1) NOT NULL,
    [drvSPMEventDate] datetime NULL,
    [drvSPMInitGracePeriodDate] varchar(1) NOT NULL,
    [drvSPMBillingPeriodDate] varchar(1) NOT NULL,
    [drvSPM2ndBillingPeriodDate] varchar(1) NOT NULL,
    [drvSPMPlanCategory] varchar(1) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDISCOBRAT_drvSPMDEPENDENT
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENT') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvSPMDEPENDENT] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSPMDSSN] char(11) NULL,
    [drvSPMDRelationShip] varchar(15) NULL,
    [drvSPMDSalutation] varchar(1) NOT NULL,
    [drvSPMDFirstName] varchar(100) NULL,
    [drvSPMDMiddleInitial] varchar(1) NULL,
    [drvSPMDLastName] varchar(100) NULL,
    [drvSPMDEmail] varchar(1) NOT NULL,
    [drvSPMDPhone] varchar(1) NOT NULL,
    [drvSPMDPhone2] varchar(1) NOT NULL,
    [drvSPMDSameasSPM] varchar(4) NOT NULL,
    [drvSPMDAddressLine1] varchar(255) NULL,
    [drvSPMDAddressLine2] varchar(255) NULL,
    [drvSPMDCity] varchar(255) NULL,
    [drvSPMDState] varchar(255) NULL,
    [drvSPMDPostalCode] varchar(50) NULL,
    [drvSPMDCountry] varchar(1) NOT NULL,
    [drvSPMDEnrollmentdate] varchar(1) NOT NULL,
    [drvSPMDSex] char(1) NULL,
    [drvSPMDDateOfBirth] datetime NULL,
    [drvSPMDISQMCSO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBRAT_drvSPMDEPENDENTPLAN
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENTPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvSPMDEPENDENTPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvSPMDPPlanName] varchar(50) NULL,
    [drvSPMDPStartDate] datetime NULL,
    [drvSPMEndDate] datetime NULL,
    [drvSPMFirstDayOfCov] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDISCOBRAT_drvSPMDEPENDENTPLAN_Temp
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENTPLAN_Temp') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvSPMDEPENDENTPLAN_Temp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvSPMDPPlanName] varchar(50) NULL,
    [drvSPMDPStartDate] datetime NULL,
    [drvSPMEndDate] datetime NULL,
    [drvSPMFirstDayOfCov] varchar(4) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDISCOBRAT_drvSPMPLAN
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvSPMPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvSPMPLAN] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSPMLPlanName] varchar(50) NULL,
    [drvSPMLStartDate] datetime NULL,
    [drvSPMLEndDate] varchar(1) NOT NULL,
    [drvSPMLCovLevel] varchar(9) NULL,
    [drvSPMLFirstDay] varchar(1) NOT NULL,
    [drvSPMLLastDay] varchar(1) NOT NULL,
    [drvSPMLLastDateNotified] varchar(1) NOT NULL,
    [drvSPMLSendPlanChange] varchar(5) NOT NULL,
    [drvSPMLNumberUnits] varchar(1) NOT NULL,
    [drvSPMLBundleName] varchar(1) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_NPM
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(9) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressEMail] varchar(1) NOT NULL,
    [drvPhoneHomeNumber] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvHireDate] varchar(1) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_QB
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(9) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvTobacoUse] varchar(7) NOT NULL,
    [drvEmpPayrollType] varchar(6) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NOT NULL,
    [drvRelationship] varchar(15) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(4) NOT NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_QBDEPPLAN
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvName] varchar(100) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDateOfTermination] datetime NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_QBMSRI
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(50) NULL,
    [drvRate] money NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL,
    [drvDateOfTermination] datetime NULL
);

-----------
-- Create table U_EDISCOBRAT_drvTbl_QBPLAN2
-----------

IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBPLAN2') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_drvTbl_QBPLAN2] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(50) NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] int NULL,
    [drvCoverageLevel] varchar(11) NULL,
    [drvPlanBundleName] varchar(50) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISCOBRAT_EEList
-----------

IF OBJECT_ID('U_EDISCOBRAT_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDISCOBRAT_File
-----------

IF OBJECT_ID('U_EDISCOBRAT_File') IS NULL
CREATE TABLE [dbo].[U_EDISCOBRAT_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCOBRAT]
    @SystemID char(12)
AS
--SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 02/27/2020
Service Request Number: TekP-2019-11-19-0001

Purpose: Discovery Benefits Cobra Export - Combined NPM/QB

Revision History
----------------
Update By            Date           Request Num            Desc
Darren Collard       01/17/2022     TekP-2021-10-07-0004   Update FSA plan name from "DBI FSA" to "WEX FSA" where term date > 12/31/2021
Darren Collard       02/04/2022     TekP-2021-10-07-0004   Do not delete dependent if the employee was updated after the start date

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCOBRAT';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCOBRAT';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCOBRAT';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISCOBRAT';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCOBRAT' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRAT', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRAT', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCOBRAT', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCOBRAT';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDISCOBRAT', @AllObjects = 'Y', @IsWeb = 'Y'

**********************************************************************************/
BEGIN
    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode varchar(10)
            ,@ExportCode varchar(10)
            ,@StartDate  datetime
            ,@EndDate    datetime;

    -- Initialize @FormatCode
    SET @FormatCode = 'EDISCOBRAT';

    -- Declare dates from Parameter file
    SELECT
         @ExportCode = ExportCode
        ,@StartDate  = LEFT(StartPerControl,8)
        ,@EndDate    = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List
    --==========================================
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDISCOBRAT_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCOBRAT_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- BDM Section for NPM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- NPM parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','NPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','2'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file

    -- Run BDM for NPM
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- BDM Section for QB
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

    -- COBRA parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','QB');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,210,LEVNT3,LEVNT4'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,210,LEVNT3,LEVNT4'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'DedCodes','EAHIM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RunID','SPM');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,STC,DCH');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;


INSERT INTO [dbo].[U_dsi_BDM_EDISCOBRAT]
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
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmCobraReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB]

    )
 Select DISTINCT rectype = 'DEP', EdhCoid, EdhEEID, DbnDepRecID, DbnDepRecID, 'QB', 'Data Inserted for 201 Chg reason', 
            DbnRelationship, DbnDateOfBirth, EdhDedCode, DbnBenStatus,  DbnBenStartDate, DbnBenStopDate, DbnBenStatusDate,'201'
            ,edhStartDate, edhStopDate, 'Y'
            from dbo.emphded with (nolock)
            JOIN dbo.U_dsi_BDM_DepDeductions on dbneeid = edheeid and dbnformatcode = @FormatCode AND edhDedCode = dbnDedCode
            WHERE edhChangeReason in ('201') 
            AND EdhEffDAte BETWEEN @StartDate AND @EndDate 
            AND dbnValidForExport = 'N'
            AND DedIsCobraCovered='Y'
            AND DbnBenStopDate IS NOT NULL


--    Delete from dbo.U_dsi_BDM_EDISCOBRAT where bdmRunID  = 'SPM' and bdmbenstatusdate < @StartDate 

    DELETE SPM
    FROM dbo.U_dsi_BDM_EDISCOBRAT AS SPM
    WHERE bdmRunID  = 'SPM' 
        AND bdmbenstatusdate < @StartDate 
        AND (bdmbenstopdate IS NULL OR NOT EXISTS (SELECT 1 
                                                   FROM dbo.U_dsi_BDM_EDISCOBRAT 
                                                   WHERE BdmEEID=SPM.BdmEEID 
                                                     AND Bdmbenstatusdate > @StartDate 
                                                     AND BdmRelationship='Emp')) --Do not delete dependent if the employee's benefit status was updated.

    --==========================================
    -- Build driver tables
    --==========================================
    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSSN             = eepSSN
        ,drvEmpNo           = EecEmpNo
        ,drvClientName      = CONVERT(varchar(100),'United States Olympic & Paralympic Committee (USOPC) 35566')
        ,drvClientDivName   = CASE WHEN eeccoid in ('EAHI') and eecorglvl1  = 'PARA' THEN 'EAHI PARA' 
                                  WHEN eeccoid in ('EAHI') and eecorglvl1  <> 'PARA' THEN 'EAHI'
                                  ELSE 'USOPC'
                             END
        ,drvNameFirst       = EepNameFirst
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = EepNameLast
        ,drvAddressEMail    = ''
        ,drvPhoneHomeNumber = ''
        ,drvAddressLine1    = EepAddressLine1
        ,drvAddressLine2    = EepAddressLine2
        ,drvAddressCity     = EepAddressCity
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = EepGender
        ,drvHireDate        = ''
        ,drvInitialSort     = '22'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCOBRAT_drvTbl_NPM
    FROM dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    WHERE BdmRunID = 'NPM'
    and bdmcoid in ('V5C45') ;

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'United States Olympic & Paralympic Committee (USOPC) 35566 ')
        ,drvClientDivName  = CASE WHEN eeccoid in ('EAHI') and eecorglvl1  = 'PARA' THEN 'EAHI PARA' 
                                  WHEN eeccoid in ('EAHI') and eecorglvl1  <> 'PARA' THEN 'EAHI'
                                  ELSE 'USOPC'
                             END
        ,drvNameFirst      = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                  ELSE ConNameFirst
                             END
        ,drvNameMiddle     = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                  ELSE LEFT(ConNameMiddle,1)
                             END
        ,drvNameLast       = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                  ELSE ConNameLast
                             END
        ,drvSSN            = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(ConSSN,'')
                             END
        ,drvEmpNo          = EecEmpNo
        ,drvAddressLine1   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine1
                                  ELSE ConAddressLine1
                             END
        ,drvAddressLine2   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressLine2
                                  ELSE ConAddressLine2
                             END
        ,drvAddressCity    = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressCity
                                  ELSE ConAddressCity
                             END
        ,drvAddressState   = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressState
                                  ELSE ConAddressState
                             END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode
                                  WHEN ConAddressLine1 IS NULL THEN EepAddressZipCode
                                  ELSE ConAddressZipCode
                             END
        ,drvGender         = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                  ELSE ConGender
                             END
        ,drvDateOfBirth    = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth
                                  ELSE ConDateOfBirth
                             END
        ,drvTobacoUse       = CASE WHEN EepIsSmoker = 'Y' THEN 'YES' 
                                   WHEN EepIsSmoker = 'N' THEN 'NO'
                                  ELSE 'UNKNOWN'
                              END 
        ,drvEmpPayrollType =  CASE WHEN EecSalaryOrHourly = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_EDISCOBRAT_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      and bdmcoid in ('V5C45') ;

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN ISNULL(EecTermReason,'') = '202' THEN 'RETIREMENT'
                                  WHEN ISNULL(EecTermReason,'') = '203' THEN 'DEATH'
                                  WHEN ISNULL(BdmCobraReason,'') IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN ISNULL(BdmCobraReason,'') IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN ISNULL(BdmCobraReason,'') = '210' THEN 'DEATH'
                                  WHEN ISNULL(BdmCobraReason,'') IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN ISNULL(BdmCobraReason,'') IN ('203','202') THEN 'REDUCTIONINHOURSSTATUSCHANGE '
                                  WHEN ISNULL(BdmCobraReason,'') = '205' THEN 'MEDICARE'
                                  WHEN ISNULL(BdmCobraReason,'') = '206' THEN 'REDUCTIONINHOURSENDOFLEAVE'
                                  WHEN ISNULL(BdmCobraReason,'') = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN ISNULL(BdmCobraReason,'') = '208' THEN 'RETIREMENT'
                                  WHEN ISNULL(BdmCobraReason,'') = '209' THEN 'WORKSTOPPAGE'
                                  WHEN ISNULL(EecEmplStatus,'') = 'T' and eectermtype  = 'I' THEN 'INVOLUNTARYTERMINATION'
                                  ELSE 'TERMINATION'
                             END
        ,drvEventDate      = CASE WHEN BdmCobraReason in ('204','201','LEVNT3','LEVNT4') THEN  ISNULL(BdmDateOfCOBRAEvent,BdmBenStopDate) ELSE BdmDateOfCOBRAEvent END
        ,drvEnrollmentDate = BdmBenStartDate
        ,drvSSN            = eepSSN
        ,drvName           = CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst)
                                  ELSE ''
                             END
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
        ,drvDateOfTermination = eecDateOfTermination
    INTO dbo.U_EDISCOBRAT_drvTbl_QBEVENT
    FROM dbo.U_EDISCOBRAT_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmBenStopDate = MAX(BdmBenStopDate)
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
          FROM dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       and bdmcoid in ('V5C45') ;

    ------------------
    -- QBPLAN DETAIL RECORD
    ------------------
    --IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBPLAN2') IS NOT NULL
    --    DROP TABLE dbo.U_EDISCOBRAT_drvTbl_QBPLAN2;
    --SELECT DISTINCT
    --     drvEEID          = drvEEID
    --    ,drvCoID          = drvCoID
    --    ,drvDepRecID      = drvDepRecID
    --    ,drvDedCode       = BdmDedCode
    --    ,drvPlanName      = CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
    --                             WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA')    THEN 'DBI FSA' 
    --                             WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
    --                             WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
    --                             WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'UMR/UHC Medical Stars PPO'  ELSE 'Highmark Medical Stars PPO' END
    --                             WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stripes HDHP' ELSE 'Highmark Medical Stripes HDHP' END
    --                        END))
    --    ,drvStartDate =  DateAdd(Day,1,bdmbenstopdate)
    --    ,drvEndDate = null

    --    ,drvCoverageLevel =  CASE  WHEN BdmDedCode in ('MDSW', 'MDSB', 'MDHDW' ,'MDHD')    THEN 
    --                                    CASE WHEN BdmBenOption in ('EE','EEW') THEN 'EE'
    --                                         WHEN BdmBenOption in ('EEC'  ,'EECW') THEN 'EE+CHILD'
    --                                         WHEN BdmBenOption in ('EECH'  ,'EECHW') THEN 'EE+CHILDREN'
    --                                         WHEN BdmBenOption in ('EEF', 'EEFW', 'EEDPF', 'EDPFW') THEN 'EE+FAMILY'
    --                                         WHEN BdmBenOption in ('EEDP', 'EDPW', 'EES', 'EESW') THEN 'EE+SPOUSE'
    --                                    END
    --                         END
    --    ,drvPlanBundleName = '' --CONVERT(varchar(50),(CASE 
                                 --WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stars PPO/ESI Rx'  ELSE 'Highmark Medical Stars PPO/ESI Rx' END
                                 --WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN  CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stripes HDHP/ESI Rx'  ELSE 'Highmark Medical Stripes HDHP/ESI Rx' END
                            --END))
    --    ,drvInitialSort   = '21'
    --    ,drvSubSort       = drvSubSort
    --    ,drvSubSort2      = '1' + BdmDedCode
    --    ,drvSubSort3      = drvSubSort3
    --INTO dbo.U_EDISCOBRAT_drvTbl_QBPLAN2
    --FROM dbo.U_EDISCOBRAT_drvTbl_QBEVENT WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
    --    ON BdmEEID = drvEEID
    --   AND BdmCoID = drvCoID
    --   AND ISNULL(BdmDepRecID,'') = drvDepRecID
    --LEFT JOIN (
    --    Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    --) A 
    --on A.eeid =  drvEEID
    --WHERE BdmRunID = 'QB'
    --  AND BdmIsPQB = 'Y' and bdmcoid in ('V5C45') 
    --  and BdmDedCode in ('MDSW', 'MDSB', 'MDHDW' ,'MDHD');


    --Section to add for RX
    --INSERT INTO U_EDISCOBRAT_drvTbl_QBPLAN2
    --SELECT DISTINCT
    --         drvEEID         
    --        ,drvCoID         
    --        ,drvDepRecID      
    --        ,drvDedCode       
    --        ,drvPlanName  = CASE WHEN drvPlanName in ('UMR/UHC Medical Stars PPO') THEN 'Express Scripts Inc Stars PPO Rx'
    --                             WHEN drvPlanName in ('UMR/UHC Medical Stripes HDHP') THEN 'Express Scripts Inc Stripes HDHP Rx'
    --                             WHEN drvPlanName in ('Highmark Medical Stripes HDHP') THEN 'Express Scripts Inc Stripes HDHP Rx'
    --                             WHEN drvPlanName in ('Highmark Medical Stars PPO') THEN 'Express Scripts Inc Stars PPO Rx'
    --                        END 
    --        ,drvStartDate
    --        ,drvEndDate
    --        ,drvCoverageLevel 
    --        ,drvPlanBundleName
    --        ,drvInitialSort  
    --        ,drvSubSort       
    --        ,drvSubSort2      
    --        ,drvSubSort3
    --FROM dbo.U_EDISCOBRAT_drvTbl_QBPLAN2
    --        WHERE drvPlanName in ('UMR/UHC Medical Stars PPO','UMR/UHC Medical Stripes HDHP','Highmark Medical Stars PPO','Highmark Medical Stripes HDHP')


     ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
                                 WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA') THEN IIF(drvDateOfTermination >= '1/1/2022','WEX FSA', 'DBI FSA')
                                 WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
                                 WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
                                 WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'UMR/UHC Medical Stars PPO'  ELSE 'Highmark Medical Stars PPO' END
                                 WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stripes HDHP' ELSE 'Highmark Medical Stripes HDHP' END
                                --WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN  CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stars PPO/ESI Rx'  ELSE 'Highmark Medical Stars PPO/ESI Rx' END
 
                                 --WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN   CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stripes HDHP/ESI Rx'  ELSE 'Highmark Medical Stripes HDHP/ESI Rx' END

                            END))
        ,drvCoverageLevel = CASE WHEN BdmDedType in( 'FSA','OT1','EAP') THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('ATH','EE','EEW') THEN 'EE'
                                           WHEN BdmDedCode in ('DEN','VIS','VIS1') and BdmBenOption in ('EEC', 'EES','EEDP') THEN 'EE+1'
                                           WHEN BdmDedCode in ('DEN','VIS','VIS1') and BdmBenOption in ('EECH') THEN 'EE+CHILDREN'
                                            WHEN BdmDedCode in ('DEN','VIS','VIS1') and BdmBenOption in ('EEF' , 'EEDPF') THEN 'EE+FAMILY'

                                           --WHEN BdmDedCode in ('DEN') and BdmBenOption in ('EECH', 'EEF' , 'EEDPF') THEN 'EE+2'
                                           WHEN BdmBenOption IN ('ATHC','EEC','EECW') THEN 'EE+CHILD'
                                           WHEN BdmBenOption IN ('ATHS','EEDP', 'EDPW', 'EES', 'EESW') THEN 'EE+SPOUSE'
                                           --WHEN BdmBenOption IN ('@EDPBenOpts') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('ATHF','EECH','EEF','EEDPF','EECHW', 'EEFW', 'EDPFW') THEN 'EE+FAMILY'
                                      END
                                 WHEN BdmRelationship IN ('SPS','DP') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+1'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+2'
                                           ELSE 'EE'
                                      END
                                 ELSE 'EE'
                            END
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
        ,drvDateOfTermination
    INTO dbo.U_EDISCOBRAT_drvTbl_QBPLAN
    FROM dbo.U_EDISCOBRAT_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y' and bdmcoid in ('V5C45');  -- and bdmdedcode in ('EAP', 'FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA', 'DEN', 'VIS' ,'VIS1');
    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = ISNULL(ConSSN,'')
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP') THEN 'DOMESTICPARTNER'
                                  WHEN BdmRelationship IN ('CHL','DCH','DPC','STC') THEN 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = 'True'
        ,drvAddressLine1   = ''
        ,drvAddressLine2   = ''
        ,drvAddressCity    = ''
        ,drvAddressState   = ''
        ,drvAddressZipCode = ''
        ,drvGender         = ConGender
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = 'False'
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISCOBRAT_drvTbl_QBDEP
    FROM dbo.U_EDISCOBRAT_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N'
      AND bdmcoid in ('V5C45');

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
                                 WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA') THEN IIF(drvDateOfTermination >= '1/1/2022','WEX FSA', 'DBI FSA') 
                                 WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
                                 WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
                                 WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'UMR/UHC Medical Stars PPO'  ELSE 'Highmark Medical Stars PPO' END
                                 WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stripes HDHP' ELSE 'Highmark Medical Stripes HDHP' END
                                 --WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN  CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stars PPO/ESI Rx'  ELSE 'Highmark Medical Stars PPO/ESI Rx' END

                                 --WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN   CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stripes HDHP/ESI Rx'  ELSE 'Highmark Medical Stripes HDHP/ESI Rx' END

                            END))
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS','DP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISCOBRAT_drvTbl_QBDEPPLAN
    FROM dbo.U_EDISCOBRAT_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'N'
      AND bdmcoid in ('V5C45')
      ;


   --Section to add for RX
    --INSERT INTO U_EDISCOBRAT_drvTbl_QBDEPPLAN
    --SELECT DISTINCT
    --     drvEEID       
    --    ,drvCoID       
    --    ,drvDepRecID    
    --    ,drvDedCode     
    --    ,drvPlanName    =      CASE WHEN drvPlanName in ('UMR/UHC Medical Stars PPO') THEN 'Express Scripts Inc Stars PPO Rx'
    --                             WHEN drvPlanName in ('UMR/UHC Medical Stripes HDHP') THEN 'Express Scripts Inc Stripes HDHP Rx'
    --                             WHEN drvPlanName in ('Highmark Medical Stripes HDHP') THEN 'Express Scripts Inc Stripes HDHP Rx'
    --                             WHEN drvPlanName in ('Highmark Medical Stars PPO') THEN 'Express Scripts Inc Stars PPO Rx'
    --                        END 
                
    --    ,drvInitialSort 
    --    ,drvSubSort     
    --    ,drvSubSort2   
    --    ,drvSubSort3   
    --    FROM U_EDISCOBRAT_drvTbl_QBDEPPLAN
    --    WHERE drvPlanName in ('UMR/UHC Medical Stars PPO','UMR/UHC Medical Stripes HDHP','Highmark Medical Stars PPO','Highmark Medical Stripes HDHP')

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    =  CONVERT(varchar(50),(CASE WHEN BdmDedCode in ('EAP')    THEN 'ComPsych EAP' 
                                 WHEN BdmDedCode in ('FSAL', 'FSALW', 'FSA', 'FSAW', 'HFSA')  THEN IIF(drvDateOfTermination >= '1/1/2022','WEX FSA', 'DBI FSA')
                                 WHEN BdmDedCode in ('DEN')    THEN 'United Concordia Dental Flex' 
                                 WHEN BdmDedCode in ('VIS', 'VIS1')    THEN 'VSP Vision' 
                                 --WHEN BdmDedCode in ('MDSW', 'MDSB')    THEN  CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stars PPO/ESI Rx'  ELSE 'Highmark Medical Stars PPO/ESI Rx' END

                                 --WHEN BdmDedCode in ('MDHDW', 'MDHD')    THEN   CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'UMR/UHC Medical Stripes HDHP/ESI Rx'  ELSE 'Highmark Medical Stripes HDHP/ESI Rx' END

                            END))
        ,drvRate        = CASE WHEN BDmDedcode in ('FSAL','FSALW','FSA','FSAW','HFSA ') THEN BdmEEAmt END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISCOBRAT_drvTbl_QBMSRI
    FROM dbo.U_EDISCOBRAT_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    LEFT JOIN (
        Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  drvEEID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';

 ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRAT_drvSPM
    --[SPM]
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvSPM','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvSPM;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSPMClientName = 'United States Olympic & Paralympic Committee (USOPC) 35566'
        ,drvSPMDivisionName =  CASE WHEN eeccoid in ('V5C6H') and Employee_AthleteType  = 'PARA' THEN 'EAHI PARA' 
                                  ELSE 'EAHI'
                             END
        ,drvSPMSalutation = ''
        ,drvSPMFirstName = EepNameFirst
        ,drvSPMMiddleName = LEFT(EepNameMiddle,1)
        ,drvSPMLastName = EepNameLast
        ,drvSPMSSN = eepSSN
        ,drvSPMIndId = ''
        ,drvSPMEmail = ''
        ,drvSPMPhone = ''
        ,drvSPMPhone2 = ''
        ,drvSPMAddressLine1 = EepAddressLine1
        ,drvSPMAddressLine2 = EepAddressLine2
        ,drvSPMCity = EepAddressCity
        ,drvSPMStateProvince = EepAddressState
        ,drvSPMPostalCode = EepAddressZipCode
        ,drvSPMCountry = ''
        ,drvSPMSex = EepGender
        ,drvSPMDateofBirth = EepDateOfBirth
        ,drvSPMBillStartDate = DateAdd(Day,1,bdmBenStopDate) ---CASE WHEN EecEmplStatus  = 'L' THEN DateAdd(Day,1,EecEmplStatusStartDate ) ELSE  DateAdd(Day,1,bdmBenStopDate)  END
        ,drvSPMBillEndDateBefore = CASE WHEN EecEmplStatus  = 'L' THEN (select Max(EshStatusStopDate) from EmpHStat where esheeid = xeeid) END
        ,drvSPMBillEndDate = CASE 
                                    WHEN EecEmplStatus = 'T' THEN DateAdd(Day,365,bdmBenStopDate)
                                    --WHEN EecEmplStatus = 'L' THEN DateAdd(Day,366,bdmBenStopDate)
                                    --WHEN EecEmplStatus = 'A' then (select Max(EshStatusStopDate) from EmpHStat where esheeid = xeeid) 
                            END
        ,drvSPMBillingType = CASE --WHEN EecEmplStatus = 'L' THEN 'LEAVEOFABSENCE' 
                                  WHEN EecEmplStatus = 'T' THEN 'PREMIUMPAY' 
                                END
        ,drvSPMBillFreq = 'MONTHLY'
        ,drvSPMIsCobraElig = 'True'
        ,drvSPMIsCobraEligAtTerm = 'True'
        ,drvSPMGracePeriodNrDays = ''
        ,drvSPMGracePrdOptType = 'CLIENTDEFAULT'
        ,drvSPMIsLegacy = 'FALSE'
        ,drvSPMTobaccoUse = 'UNKNOWN'
        ,drvSPMEnrollmentDate = (select Min(BdmBenStartDate) from U_dsi_BDM_EDISCOBRAT where bdmRunId = 'SPM' and bdmeeid = xeeid and bdmcoid = xcoid)
        ,drvSPMEmpType = 'FTE'
        ,drvSPMEmpPayType = CASE WHEN EecSalaryOrHourly  = 'S' THEN 'SALARY' ELSE 'HOURLY' END
        ,drvSPMYearsService = ''
        ,drvSPMPremCouponType = 'COUPONBOOK'
        ,drvSPMActive = 'True'
        ,drvSPMAllowSSO = 'False'
        ,drvSPMBenGroup = ''
        ,drvSPMAcctStrucure = ''
        ,drvSPMClientCustData = ''
        ,drvSPMEventDate = CASE --WHEN EecEmplStatus  = 'L' THEN DateAdd(Day,1,EecEmplStatusStartDate ) 
                                WHEN EecEmplStatus  = 'T' THEN DateAdd(Day,1,eecdateoftermination )
                                END
        ,drvSPMInitGracePeriodDate = ''
        ,drvSPMBillingPeriodDate = ''
        ,drvSPM2ndBillingPeriodDate = ''
        ,drvSPMPlanCategory = ''
        ,drvInitialSort     = '23'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = '1'
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCOBRAT_drvSPM
    FROM dbo.U_EDISCOBRAT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
       And eecemplstatus = 'T'
       --And eecemplstatus IN ('L','T')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
         LEFT JOIN  (
            Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
     on A.eeid =  xeeid
    JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID
    LEFT JOIN (Select * from (
        SELECT DISTINCT eshcoid,esheeid,eshEmplStatus as EmpStatus,
            ROW_NUMBER() OVER( PARTITION BY eshcoid,esheeid order by  eshdatetimecreated desc) as RowNum from dbo.EmpHStat 
        ) as EmpStatus
        Where RowNum = 1) as EStats
    on eshcoid =  BdmCOID
    and EshEEID =  bdmeeid
     WHERE  BdmRunID = 'SPM'
     AND BdmCOID in ('V5C6H')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRAT_drvSPMPLAN
    --[SPMPLAN]
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvSPMPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvSPMPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmdeprecid --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSPMLPlanName = CONVERT(VARCHAR(50),CASE WHEN BdmDedCode in ('EAHIM') and Employee_AthleteType not in ('PARA')  THEN  CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'Direct Bill UMR/UHC Medical EAHI' ELSE 'Direct Bill Highmark Medical EAHI' END
                                WHEN BdmDedCode in ('EAHIM') and Employee_AthleteType in ('PARA') THEN   CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'Direct Bill UMR/UHC Medical EAHI PARA' ELSE 'Direct Bill Highmark Medical EAHI PARA' END
                                    END)
                            
        ,drvSPMLStartDate = CASE --WHEN eecEmplStatus = 'L' THEN DateAdd(Day,1,EecEmplStatusStartDate) 
                                 WHEN eecEmplStatus = 'T' THEN DateAdd(Day,1,BdmBenStopDate) 
                            END
        ,drvSPMLEndDate = ''
        ,drvSPMLCovLevel = CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                 WHEN BdmBenOption IN ('ATH') THEN 'EE'
                                           WHEN BdmBenOption IN ('ATHC') THEN 'EE+CHILD'
                                           WHEN BdmBenOption IN ('ATHS') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('ATHF') THEN 'EE+FAMILY'
                            END
                        
        ,drvSPMLFirstDay = ''
        ,drvSPMLLastDay = ''
        ,drvSPMLLastDateNotified = ''
        ,drvSPMLSendPlanChange = 'False'
        ,drvSPMLNumberUnits = ''
        ,drvSPMLBundleName = '' --CASE WHEN BdmDedCode in ('EAHIM') and BdmCoid in ('V5C6H') THEN
                            --        CASE WHEN BdmBenOption in ('ATH','ATHC','ATHF','ATHS') and Employee_AthleteType not in ('PARA')  THEN  CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'DB UMR/UHC EAHI Med/ESI Rx' ELSE 'Highmark EAHI Med/ESI Rx' END
                            --             WHEN BdmBenOption in ('ATH','ATHC','ATHF','ATHS') and Employee_AthleteType in ('PARA') THEN   CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN 'DB UMR/UHC EAHI PARA Med/ESI Rx' ELSE 'Highmark EAHI PARA Med/ESI Rx' END

                            --        END
                            --END
        ,drvInitialSort     = '23'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = '2'
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCOBRAT_drvSPMPLAN
    FROM dbo.U_EDISCOBRAT_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
           And eecemplstatus = 'T'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN  (
            Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A 
    on A.eeid =  xeeid
    JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID
     WHERE  BdmRunID = 'SPM'
          AND BdmCOID in ('V5C6H')
         and bdmrectype = 'EMP'
    ;

    --Duplicate record for RX
    --INSERT INTO U_EDISCOBRAT_drvSPMPLAN
    --SELECT DISTINCT
    --     drvEEID 
    --    ,drvCoID
    --    ,drvDepRecID 
    --    -- standard fields above and additional driver fields below
    --    ,drvSPMLPlanName  = CASE WHEN drvSPMLPlanName IN ('Direct Bill UMR/UHC Medical EAHI') THEN 'Direct Bill ESI EAHI Continuance Rx'
    --                             WHEN drvSPMLPlanName IN ('Direct Bill UMR/UHC Medical EAHI PARA') THEN 'Direct Bill ESI EAHI PARA Continuance Rx'
    --                             WHEN drvSPMLPlanName IN ('Direct Bill Highmark Medical EAHI') THEN 'Direct Bill ESI EAHI Continuance Rx'
    --                             WHEN drvSPMLPlanName IN ('Direct Bill Highmark Medical EAHI PARA') THEN 'Direct Bill ESI EAHI PARA Continuance Rx'
    --                        END
    --    ,drvSPMLStartDate 
    --    ,drvSPMLEndDate 
    --    ,drvSPMLCovLevel 
                
    --    ,drvSPMLFirstDay 
    --    ,drvSPMLLastDay 
    --    ,drvSPMLLastDateNotified
    --    ,drvSPMLSendPlanChange 
    --    ,drvSPMLNumberUnits 
    --    ,drvSPMLBundleName 
    --    ,drvInitialSort     
    --    ,drvSubSort         
    --    ,drvSubSort2       
    --    ,drvSubSort3     
    --FROM dbo.U_EDISCOBRAT_drvSPMPLAN
    --WHERE drvSPMLPlanName IN ('Direct Bill UMR/UHC Medical EAHI','Direct Bill UMR/UHC Medical EAHI PARA','Direct Bill Highmark Medical EAHI','Direct Bill Highmark Medical EAHI PARA')

    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRAT_drvSPMDEPENDENT
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENT','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvSPMDEPENDENT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSPMDSSN = conssn
        ,drvSPMDRelationShip = CASE WHEN conrelationship  IN ('CHL', 'DCH', 'DPC' , 'STC' ) THEN 'CHILD'
                                   WHEN conrelationship  IN ('SPS' ) THEN 'SPOUSE'
                                WHEN conrelationship  IN ('DP' ) THEN 'DOMESTICPARTNER'
                               END
        ,drvSPMDSalutation = ''
        ,drvSPMDFirstName = ConNameFirst
        ,drvSPMDMiddleInitial = LEFT(ISNULL(ConNameMiddle,''),1)
        ,drvSPMDLastName = ConNameLast
        ,drvSPMDEmail = ''
        ,drvSPMDPhone = ''
        ,drvSPMDPhone2 = ''
        ,drvSPMDSameasSPM = 'True'
        ,drvSPMDAddressLine1 = EepAddressLine1
        ,drvSPMDAddressLine2 = EepAddressLine2
        ,drvSPMDCity = EepAddressCity
        ,drvSPMDState = EepAddressState
        ,drvSPMDPostalCode = EepAddressZipCode
        ,drvSPMDCountry = ''
        ,drvSPMDEnrollmentdate = ''
        ,drvSPMDSex = congender
        ,drvSPMDDateOfBirth = ConDateOfBirth
        ,drvSPMDISQMCSO = 'False'
        ,drvInitialSort     = '23'
        ,drvSubSort        = eepSSN
        ,drvSubSort2       = '3'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                            END
    INTO dbo.U_EDISCOBRAT_drvSPMDEPENDENT
    FROM dbo.U_EDISCOBRAT_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
           And eecemplstatus = 'T'

    JOIN dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID
        JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = bdmEEID
       AND ConSystemID = BdmDepRecID
     WHERE  BdmRunID = 'SPM' 
    AND BdmCOID in ('V5C6H')
    ;


    ---------------------------------
    -- DETAIL RECORD - U_EDISCOBRAT_drvSPMDEPENDENTPLAN
    ---------------------------------
    IF OBJECT_ID('U_EDISCOBRAT_drvSPMDEPENDENTPLAN','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCOBRAT_drvSPMDEPENDENTPLAN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ''
        -- standard fields above and additional driver fields below
        ,drvSPMDPPlanName = CONVERT(VARCHAR(50),CASE WHEN BdmDedCode in ('EAHIM') and Employee_AthleteType not in ('PARA')  THEN                   
                            CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'Direct Bill UMR/UHC Medical EAHI' ELSE 'Direct Bill Highmark Medical EAHI' END
                                WHEN BdmDedCode in ('EAHIM') and Employee_AthleteType in ('PARA') THEN                  
                            CASE WHEN DateAdd(Day,1,bdmbenstopdate) >= CAST('1/1/2021' as datetime) THEN  'Direct Bill UMR/UHC Medical EAHI PARA' ELSE 'Direct Bill Highmark Medical EAHI PARA' END

                                    END)
        ,drvSPMDPStartDate = BdmBenStartDate
        ,drvSPMEndDate = BdmBenStopDate
        ,drvSPMFirstDayOfCov = CASE WHEN BdmBenStartDate = (Select top 1 BdmBenStartDate from U_dsi_BDM_EDISCOBRAT where bdmeeid  = xeeid and bdmcoid = xcoid and bdmrectype = 'EMP') THEN 'TRUE' ELSE 'FALSE' END
        ,drvInitialSort     = '23'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = '4'
        ,drvSubSort3        = ''
    INTO dbo.U_EDISCOBRAT_drvSPMDEPENDENTPLAN
    FROM dbo.U_EDISCOBRAT_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
          And eecemplstatus = 'T'
LEFT JOIN  (
            Select * from [dbo].[fn_MP_CustomFields_EmpPers_Export](null,null,null,null)
    ) A on A.eeid =  xeeid

    JOIN (Select bdmdedcode,Max(BdmBenStartDate) as BdmBenStartDate , Max(BdmBenStopDate) as BdmBenStopDate,bdmeeid,bdmcoid from  dbo.U_dsi_BDM_EDISCOBRAT WITH (NOLOCK)      
        WHERE  BdmRunID = 'SPM' 
          AND BdmCOID in ('V5C6H')
        and bdmrectype = 'DEP' Group by  bdmdedcode,bdmeeid,bdmcoid ) bdmConsolidated
        ON bdmEEID = xEEID 
        AND BdmCOID = xCoID



    ;

    --Add new record for RX
 --       INSERT INTO U_EDISCOBRAT_drvSPMDEPENDENTPLAN
 --SELECT DISTINCT
 --        drvEEID 
 --       ,drvCoID 
 --       ,drvDepRecID
 --       -- standard fields above and additional driver fields below
 --       ,drvSPMDPPlanName  =     CASE WHEN drvSPMDPPlanName IN ('Direct Bill UMR/UHC Medical EAHI') THEN 'Direct Bill ESI EAHI Continuance Rx'
 --                                WHEN drvSPMDPPlanName IN ('Direct Bill UMR/UHC Medical EAHI PARA') THEN 'Direct Bill ESI EAHI PARA Continuance Rx'
 --                                WHEN drvSPMDPPlanName IN ('Direct Bill Highmark Medical EAHI') THEN 'Direct Bill ESI EAHI Continuance Rx'
 --                                WHEN drvSPMDPPlanName IN ('Direct Bill Highmark Medical EAHI PARA') THEN 'Direct Bill ESI EAHI PARA Continuance Rx'
 --                           END
 --       ,drvSPMDPStartDate
 --       ,drvSPMEndDate 
 --       ,drvSPMFirstDayOfCov 
 --       ,drvInitialSort     
 --       ,drvSubSort      
 --       ,drvSubSort2       
 --       ,drvSubSort3        

 --   FROM U_EDISCOBRAT_drvSPMDEPENDENTPLAN 
 --   WHERE drvSPMDPPlanName IN                             ('Direct Bill UMR/UHC Medical EAHI','Direct Bill UMR/UHC Medical EAHI PARA','Direct Bill Highmark Medical EAHI','Direct Bill Highmark Medical EAHI PARA')


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
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISCOBRAT_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCOBRAT_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefH
SELECT adhSystemId,* FROM dbo.AscDefh WHERE AdhformatCode = 'EDISCOBRAT'

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID = (SELECT adhSystemId FROM dbo.AscDefh WHERE AdhformatCode = 'EDISCOBRAT')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '202202011'
   ,expStartPerControl     = '202202011'
   ,expLastEndPerControl   = '202202179'
   ,expEndPerControl       = '202202179'
WHERE expFormatCode = 'EDISCOBRAT'
  AND expExportCode LIKE 'TEST%';
*/
--SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDISCOBRAT_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISCOBRAT_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDISCOBRAT' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDISCOBRAT'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDISCOBRAT'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCOBRAT', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDISCOBRAT', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISCOBRAT', 'UseFileName', 'V', 'Y'


-- End ripout