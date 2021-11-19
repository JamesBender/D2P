/**********************************************************************************

EDISPCRCOB: PCRK Holding Company COBRA Export

FormatCode:     EDISPCRCOB
Project:        PCRK Holding Company COBRA Export
Client ID:      PCR1000
Date/time:      2021-11-12 14:31:28.887
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP6DB02
Database:       ULTIPRO_WPPCRK
Web Filename:   PCR1000_VG436_EEHISTORY_EDISPCRCOB_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDISPCRCOB_SavePath') IS NOT NULL DROP TABLE dbo.U_EDISPCRCOB_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDISPCRCOB'


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
WHERE FormatCode = 'EDISPCRCOB'
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
WHERE ExpFormatCode = 'EDISPCRCOB'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDISPCRCOB')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDISPCRCOB'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDISPCRCOB'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDISPCRCOB'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDISPCRCOB'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDISPCRCOB'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDISPCRCOB'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDISPCRCOB'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDISPCRCOB'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDISPCRCOB'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDISPCRCOB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISPCRCOB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISPCRCOB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISPCRCOB];
GO
IF OBJECT_ID('U_EDISPCRCOB_File') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_File];
GO
IF OBJECT_ID('U_EDISPCRCOB_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_EEList];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBSTATEINSERT') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBSTATEINSERT];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBPLAN];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBMSRI') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBMSRI];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBEVENT') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBEVENT];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEPPLAN') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEPPLAN];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEP') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEP];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QB') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_QB];
GO
IF OBJECT_ID('U_EDISPCRCOB_drvTbl_NPM') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_drvTbl_NPM];
GO
IF OBJECT_ID('U_EDISPCRCOB_DepCount') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_DepCount];
GO
IF OBJECT_ID('U_EDISPCRCOB_DeathEvent') IS NOT NULL DROP TABLE [dbo].[U_EDISPCRCOB_DeathEvent];
GO
IF OBJECT_ID('U_dsi_BDM_EDISPCRCOB') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISPCRCOB];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISPCRCOB','PCRK Holding Company COBRA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EDISPCRCOBZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','H','01','1',NULL,'Version Line Identifier',NULL,NULL,'"[VERSION]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','H','01','2',NULL,'Version Number',NULL,NULL,'"1.1"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','10','1',NULL,'Record Identifier',NULL,NULL,'"[QB]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','10','2',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISPCRCOBZ0','50','D','10','3',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISPCRCOBZ0','50','D','10','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISPCRCOBZ0','50','D','10','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISPCRCOBZ0','50','D','10','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISPCRCOBZ0','50','D','10','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISPCRCOBZ0','50','D','10','8',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISPCRCOBZ0','50','D','10','9',NULL,'IndividualID',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISPCRCOBZ0','50','D','10','10',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISPCRCOBZ0','50','D','10','11',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISPCRCOBZ0','50','D','10','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISPCRCOBZ0','50','D','10','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISPCRCOBZ0','50','D','10','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISPCRCOBZ0','50','D','10','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISPCRCOBZ0','50','D','10','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISPCRCOBZ0','50','D','10','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISPCRCOBZ0','50','D','10','18',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISPCRCOBZ0','50','D','10','19',NULL,'PremiumAddressSameAsPrimary',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISPCRCOBZ0','50','D','10','20',NULL,'PremiumAddress1',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISPCRCOBZ0','50','D','10','21',NULL,'PremiumAddress2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDISPCRCOBZ0','50','D','10','22',NULL,'PremiumCity',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDISPCRCOBZ0','50','D','10','23',NULL,'PremiumStateOrProvince',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EDISPCRCOBZ0','50','D','10','24',NULL,'PremiumPostalCode',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EDISPCRCOBZ0','50','D','10','25',NULL,'PremiumCountry',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EDISPCRCOBZ0','50','D','10','26',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EDISPCRCOBZ0','50','D','10','27',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EDISPCRCOBZ0','50','D','10','28',NULL,'TobaccoUse',NULL,NULL,'"UNKNOWN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EDISPCRCOBZ0','50','D','10','29',NULL,'EmployeeType',NULL,NULL,'"UNKNOWN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EDISPCRCOBZ0','50','D','10','30',NULL,'EmployeePayrollType',NULL,NULL,'"UNKNOWN"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EDISPCRCOBZ0','50','D','10','31',NULL,'YearsOfService',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EDISPCRCOBZ0','50','D','10','32',NULL,'PremiumCouponType',NULL,NULL,'"COUPONBOOK"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EDISPCRCOBZ0','50','D','10','33',NULL,'UsesHCTC',NULL,NULL,'"FALSE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EDISPCRCOBZ0','50','D','10','34',NULL,'Active',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EDISPCRCOBZ0','50','D','10','35',NULL,'AllowMemberSSO',NULL,NULL,'"FALSE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EDISPCRCOBZ0','50','D','10','36',NULL,'BenefitGroup',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EDISPCRCOBZ0','50','D','10','37',NULL,'AccountStructure',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EDISPCRCOBZ0','50','D','10','38',NULL,'ClientSpecificData',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','20','1',NULL,'Record Identifier',NULL,NULL,'"[QBEVENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','20','2',NULL,'EventType',NULL,NULL,'"drvEventType"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISPCRCOBZ0','50','D','20','3',NULL,'EventDate',NULL,NULL,'"drvEventDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISPCRCOBZ0','50','D','20','4',NULL,'EnrollmentDate',NULL,NULL,'"drvEnrollmentDate"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISPCRCOBZ0','50','D','20','5',NULL,'EmployeeSSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISPCRCOBZ0','50','D','20','6',NULL,'EmployeeName',NULL,NULL,'"drvName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISPCRCOBZ0','50','D','20','7',NULL,'SecondEventOriginalFDOC',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','30','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','30','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISPCRCOBZ0','50','D','30','3',NULL,'CoverageLevel',NULL,NULL,'"drvCoverageLevel"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISPCRCOBZ0','50','D','30','4',NULL,'NumberOfUnits',NULL,NULL,'""','(''SS''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','40','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENT]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','40','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISPCRCOBZ0','50','D','40','3',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISPCRCOBZ0','50','D','40','4',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISPCRCOBZ0','50','D','40','5',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISPCRCOBZ0','50','D','40','6',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISPCRCOBZ0','50','D','40','7',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISPCRCOBZ0','50','D','40','8',NULL,'Email',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISPCRCOBZ0','50','D','40','9',NULL,'Phone',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISPCRCOBZ0','50','D','40','10',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISPCRCOBZ0','50','D','40','11',NULL,'AddressSameAsQB',NULL,NULL,'"drvIsAddressSame"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISPCRCOBZ0','50','D','40','12',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISPCRCOBZ0','50','D','40','13',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISPCRCOBZ0','50','D','40','14',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISPCRCOBZ0','50','D','40','15',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISPCRCOBZ0','50','D','40','16',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISPCRCOBZ0','50','D','40','17',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISPCRCOBZ0','50','D','40','18',NULL,'EnrollmentDate',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISPCRCOBZ0','50','D','40','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISPCRCOBZ0','50','D','40','20',NULL,'DOB',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISPCRCOBZ0','50','D','40','21',NULL,'IsQMCSO',NULL,NULL,'"drvISQMCO"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','50','1',NULL,'Record Identifier',NULL,NULL,'"[QBDEPENDENTPLANINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','50','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','60','1',NULL,'Record Identifier',NULL,NULL,'"[QBSTATEINSERTS]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','60','2',NULL,'StateSpecificDocumentName',NULL,NULL,'"drvStateSpecDocName"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','70','1',NULL,'Record Identifier',NULL,NULL,'"[QBPLANMEMBERSPECIFICRATEINITIAL]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','70','2',NULL,'PlanName',NULL,NULL,'"drvPlanName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISPCRCOBZ0','50','D','70','3',NULL,'Rate',NULL,NULL,'"drvRate"','(''UA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EDISPCRCOBZ0','50','D','80','1',NULL,'Version Line Identifier',NULL,NULL,'"[NPM]"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EDISPCRCOBZ0','50','D','80','2',NULL,'SSN',NULL,NULL,'"drvSSN"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EDISPCRCOBZ0','50','D','80','3',NULL,'IndividualIdentifier',NULL,NULL,'"drvEmpNo"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EDISPCRCOBZ0','50','D','80','4',NULL,'ClientName',NULL,NULL,'"drvClientName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EDISPCRCOBZ0','50','D','80','5',NULL,'ClientDivisionName',NULL,NULL,'"drvClientDivName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EDISPCRCOBZ0','50','D','80','80',NULL,'FirstName',NULL,NULL,'"drvNameFirst"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EDISPCRCOBZ0','50','D','80','7',NULL,'MiddleInitial',NULL,NULL,'"drvNameMiddle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EDISPCRCOBZ0','50','D','80','8',NULL,'LastName',NULL,NULL,'"drvNameLast"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EDISPCRCOBZ0','50','D','80','9',NULL,'Salutation',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EDISPCRCOBZ0','50','D','80','10',NULL,'Email',NULL,NULL,'"drvAddressEMail"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EDISPCRCOBZ0','50','D','80','11',NULL,'Phone',NULL,NULL,'"drvPhoneHomeNumber"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EDISPCRCOBZ0','50','D','80','12',NULL,'Phone2',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EDISPCRCOBZ0','50','D','80','13',NULL,'Address1',NULL,NULL,'"drvAddressLine1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EDISPCRCOBZ0','50','D','80','14',NULL,'Address2',NULL,NULL,'"drvAddressLine2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EDISPCRCOBZ0','50','D','80','15',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EDISPCRCOBZ0','50','D','80','16',NULL,'StateOrProvince',NULL,NULL,'"drvAddressState"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EDISPCRCOBZ0','50','D','80','17',NULL,'PostalCode',NULL,NULL,'"drvAddressZipCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EDISPCRCOBZ0','50','D','80','18',NULL,'Country',NULL,NULL,'""','(''SS''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EDISPCRCOBZ0','50','D','80','19',NULL,'Sex',NULL,NULL,'"drvGender"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EDISPCRCOBZ0','50','D','80','20',NULL,'UsesFamilyInAddress',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EDISPCRCOBZ0','50','D','80','21',NULL,'HasWaivedAllCoverage',NULL,NULL,'"FALSE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EDISPCRCOBZ0','50','D','80','22',NULL,'SendGRNotice',NULL,NULL,'"TRUE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EDISPCRCOBZ0','50','D','80','23',NULL,'Hire Date',NULL,NULL,'"drvHireDate"','(''UD101''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDISPCRCOB_20211112.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NPM/Cobra Export','202105259','EMPEXPORT','ONDEMAND','Nov  8 2017 12:00AM','EDISPCRCOB',NULL,NULL,NULL,'202105259','Oct 30 2017 12:00AM','Dec 30 1899 12:00AM','202105111',NULL,'','','202105111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N','MU7K1,MVM3U,MVM71,MVLY4,MUDKQ,MU7S2,MV8P2,MUBL8,MUBQI,MV8UA,MUDH8,MUDCZ,MUBX3,O8339,O836P,O8394,O83C0,O83EF,O83IH,O83JY,O83LY,O83NG,O83PU,O83RB,O83T1,NYGWS',NULL,NULL,NULL,'Scheduled Export','202111089','EMPEXPORT','SCH_PCRCOB','Nov  8 2021  2:52PM','EDISPCRCOB',NULL,NULL,NULL,'202111089','Nov  8 2021 12:00AM','Dec 30 1899 12:00AM','202111011','34','','','202111011',dbo.fn_GetTimedKey(),NULL,'us3aPiPCR1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Test NPM/Cobra Export','202111091','EMPEXPORT','TEST','Nov 11 2021  3:30PM','EDISPCRCOB',NULL,NULL,NULL,'202111091','Nov  9 2021 12:00AM','Dec 30 1899 12:00AM','202111021','66','','','202111021',dbo.fn_GetTimedKey(),NULL,'us3cPePCR1000',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISPCRCOB','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D10','dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D20','dbo.U_EDISPCRCOB_drvTbl_QBEVENT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D30','dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D40','dbo.U_EDISPCRCOB_drvTbl_QBDEP WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D50','dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D60','dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D70','dbo.U_EDISPCRCOB_drvTbl_QBMSRI WITH (NOLOCK)',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISPCRCOB','D80','dbo.U_EDISPCRCOB_drvTbl_NPM WITH (NOLOCK)',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EDISPCRCOB
-----------

IF OBJECT_ID('U_dsi_BDM_EDISPCRCOB') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISPCRCOB] (
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
-- Create table U_EDISPCRCOB_DeathEvent
-----------

IF OBJECT_ID('U_EDISPCRCOB_DeathEvent') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_DeathEvent] (
    [EeDeathId] char(12) NOT NULL,
    [IsSpouse] varchar(1) NULL
);

-----------
-- Create table U_EDISPCRCOB_DepCount
-----------

IF OBJECT_ID('U_EDISPCRCOB_DepCount') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_DepCount] (
    [DCEEID] char(12) NOT NULL,
    [DCCOID] char(5) NULL,
    [spouse_count] int NULL,
    [child_count] int NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_NPM
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_NPM') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_NPM] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressEMail] varchar(1) NOT NULL,
    [drvPhoneHomeNumber] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(11) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_QB
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QB') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QB] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvClientName] varchar(100) NULL,
    [drvClientDivName] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvSSN] varchar(11) NULL,
    [drvEmpNo] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_QBDEP
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEP') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEP] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] varchar(11) NULL,
    [drvRelationship] varchar(15) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvIsAddressSame] varchar(5) NOT NULL,
    [drvAddressLine1] varchar(1) NOT NULL,
    [drvAddressLine2] varchar(1) NOT NULL,
    [drvAddressCity] varchar(1) NOT NULL,
    [drvAddressState] varchar(1) NOT NULL,
    [drvAddressZipCode] varchar(1) NOT NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvISQMCO] varchar(5) NOT NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(33) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_QBDEPPLAN
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEPPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBDEPPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(33) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(38) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_QBEVENT
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBEVENT') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBEVENT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvEventType] varchar(29) NOT NULL,
    [drvEventDate] datetime NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvSSN] varchar(11) NULL,
    [drvName] varchar(201) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_QBMSRI
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBMSRI') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBMSRI] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvPlanName] varchar(33) NULL,
    [drvRate] money NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_QBPLAN
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBPLAN') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBPLAN] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvDedCode] char(5) NULL,
    [drvPlanName] varchar(33) NULL,
    [drvCoverageLevel] varchar(18) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(6) NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISPCRCOB_drvTbl_QBSTATEINSERT
-----------

IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBSTATEINSERT') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_drvTbl_QBSTATEINSERT] (
    [drvEEID] char(12) NOT NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NOT NULL,
    [drvStateSpecDocName] varchar(13) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] char(19) NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(208) NULL
);

-----------
-- Create table U_EDISPCRCOB_EEList
-----------

IF OBJECT_ID('U_EDISPCRCOB_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDISPCRCOB_File
-----------

IF OBJECT_ID('U_EDISPCRCOB_File') IS NULL
CREATE TABLE [dbo].[U_EDISPCRCOB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISPCRCOB]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: PCRK Holding Company

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 09/02/2021
Service Request Number: TekP-2021-07-22-0007

Purpose: PCRK Holding Company COBRA Export

Revision History
----------------
09/14/2021 by AP:
        - QB Record: Changed client division name.
        - QBPLANMEMBERSPECIFICREATEINITIAL Record: Updated rate logic.

10/05/2021 by AP:
        - Updated DEATH event insert into BDM for 203 for dependents.

10/14/2021 by AP:
        - Adjusted logic for DEATH once again and applied clean up to QBDEPENDENT QBDEPPLAN section.
        - Added DELETE statement to remove employees >= 26.

10/29/2021 by AP:
        - Fixed death scenario where both spouse and employee where showing as QB.
        - Fixed dependent at max age showing records for QBDEP and QBDEPPLAN.
        - Set UPDATE statement to clean up coverage level.
        - Cleaned up DELETE statement for INELIGIBLEDEPENDENTS >= 26.
        - Added DELETE statement to clean up BDM table for TEST employess.

11/05/2021 by AP:
        - Updated cobra reason for death to 210 in BDM output.
        - Removed 203 from QBPLAN.

11/08/2021 by AP:
        - Updated Coverage Level CASE STATEMENT order.

11/12/2021 by AP:
		- Updated CASE STATEMENT for U_EDISPCRCOB_drvTbl_QBPLAN to include BdmBenOption <> 'EE' for child >= 1.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EDISPCRCOB';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISPCRCOB' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'SCH_PCRCOB';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISPCRCOB', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISPCRCOB';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EDISPCRCOB', @AllObjects = 'Y', @IsWeb = 'Y';
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
    SET @FormatCode = 'EDISPCRCOB';

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
    DELETE FROM dbo.U_EDISPCRCOB_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
      AND xEEID IN (SELECT xEEID FROM dbo.U_EDISPCRCOB_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','X'); -- DedIsCobraCovered = 'Y'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','4'); -- All new enrollees where no previous plan exists
   -- INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,SPX');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'rRelationshipsDomPartner','DMP, DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Run BDM for QB
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    ---- 203 death insert employee
    --INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    --([BdmRecType]
    --,[BdmCOID]
    --,[BdmEEID]
    --,[BdmDepRecID]
    --,[BdmSystemID]
    --,[BdmRunID]
    --,[BdmDedRowStatus]
    --,[BdmRelationship]
    --,[BdmDateOfBirth]
    --,[BdmDedCode]
    --,[BdmBenOption]
    --,[BdmBenStartDate]
    --,[BdmBenStopDate]
    --,[BdmBenStatusDate]
    --,[BdmDateOFCobraEvent]
    --,[BdmChangeReason]
    --,[BdmCobraReason]
    --,[BdmStartDate]
    --,[BdmStopDate]
    --,[BdmIsPQB]
    --)
    --SELECT DISTINCT 'EMP'
    --,EecCOID
    --,EecEEID
    --,NULL
    --,NULL
    --,'QB'
    --,'Data inserted for 203 term reason'
    --,'Emp'
    --,EepDateOfBirth
    --,DedDedCode
    --,EedBenOption
    --,EedBenStartDate
    --,EedBenStopDate
    --,EedBenStatusDate
    --,EedBenStatusDate
    --,'203'
    --,'203'
    --,EedStartDate
    --,EedStopDate
    --,'Y'
    --FROM dbo.EmpComp WITH(NOLOCK)
    --JOIN dbo.u_dsi_bdm_EmpDeductions WITH(NOLOCK)
    --ON EecEEID = EedEEID
    --AND EecCOID = EedCOID
    --JOIN dbo.EmpPers WITH(NOLOCK)
    --ON EecEEID = EepEEID
    --WHERE EedValidForExport = 'N'
    --AND EedFormatCode = 'EDISPCRCOB'
    ----AND eeceeid = 'DTCQW5000040'
    --AND EecTermReason = '203'

    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
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
    SELECT DISTINCT rectype = 'DEP'
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
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason in ('204')
    AND DbnBenStopDate BETWEEN @StartDate AND @EndDate
    AND dbnValidForExport = 'N'

    -- Dependent values for 201 event
    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ( [BdmRecType]
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
    SELECT DISTINCT rectype = 'DEP'
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
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason IN ('201')
    and DbnBenstopdate BETWEEN @startdate AND @enddate
    AND dbnValidForExport = 'N'

    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
    ( [BdmRecType]
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
    SELECT DISTINCT rectype = 'DEP'
    ,EdhCoid
    ,EdhEEID
    ,DbnDepRecID
    ,DbnDepRecID
    ,'QB'
    ,'Data Inserted for 203 Chg reason'
    ,DbnRelationship
    ,DbnDateOfBirth
    ,EdhDedCode
    ,'EE' -- Takes the place of the employeee.
    ,EdhBenStartDate
    ,EdhBenStopDate
    ,EdhBenStatusDate
    ,EdhBenStatusDate
    ,'210'
    ,'210'
    ,EdhStartDate
    ,EdhStopDate
    ,'Y'
    FROM dbo.emphded WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
    ON dbneeid = edheeid
    AND dbnformatcode = 'EDISPCRCOB'
    WHERE edhChangeReason IN ('210')
    and DbnBenstopdate BETWEEN @startdate AND @enddate
    AND dbnValidForExport = 'N'

    --DELETE FROM dbo.U_dsi_BDM_EDISPCRCOB WHERE BdmDedCode not in (SELECT DedCode FROM dbo.U_EDISPCRCOB_DedList)

    ---- SEE IF EMPLOYEE OF DEATH EVENT HAS A SPOUSE TO USE FURTHER DOWN IN THE CODE AS A FLAG ----

    IF OBJECT_ID('U_EDISPCRCOB_DeathEvent') IS NOT NULL
    DROP TABLE dbo.U_EDISPCRCOB_DeathEvent;

    SELECT DISTINCT EecEEID AS EeDeathId, MAX(CASE WHEN DbnRelationship IN ('SPS', 'SPX', 'DMP', 'DP')  THEN '1' ELSE '0' END) AS IsSpouse
    INTO dbo.U_EDISPCRCOB_DeathEvent
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DNEAWV01IRX0'
    AND EecTermReason = '203'
    GROUP BY EecEEID

    -- 203 death insert dependent
    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
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
    SELECT DISTINCT 'DEP'
    ,EecCOID
    ,EecEEID
    ,DbnDepRecID
    ,NULL
    ,'QB'
    ,'Data inserted for 203 term reason'
    , DbnRelationship
    ,EepDateOfBirth
    ,DedDedCode
    ,DbnBenOption
    ,DbnBenStartDate
    ,DbnBenStopDate 
    ,DbnBenStatusDate
    ,DbnBenStatusDate
    ,'210'
    ,'210'
    ,NULL
    ,NULL
    ,'Y'
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = dbnEEID
    JOIN dbo.U_EDISPCRCOB_DeathEvent WITH(NOLOCK)
    ON EecEEID = EeDeathId
    AND IsSpouse = '1' -- SPOUSE FLAG
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DTCQW5000040'
    AND EecTermReason = '203'
    AND DbnRelationship IN ('SPS', 'SPX', 'DMP', 'DP')

     -- 203 death insert dependent
    INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
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
    SELECT DISTINCT 'DEP'
    ,EecCOID
    ,EecEEID
    ,DbnDepRecID
    ,NULL
    ,'QB'
    ,'Data inserted for 203 term reason'
    , DbnRelationship
    ,EepDateOfBirth
    ,DedDedCode
    ,DbnBenOption
    ,DbnBenStartDate
    ,DbnBenStopDate 
    ,DbnBenStatusDate
    ,DbnBenStatusDate
    ,'210'
    ,'210'
    ,NULL
    ,NULL
    ,'N'
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = dbnEEID
    JOIN dbo.U_EDISPCRCOB_DeathEvent WITH(NOLOCK)
    ON EecEEID = EeDeathId
    AND IsSpouse = '1' -- SPOUSE FLAG USED TO INSERT A 2ND RECORD FOR CHILD AS PQB = 'N'
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DTCQW5000040'
    AND EecTermReason = '203'
    AND DbnRelationship IN ('CHL', 'DPC', 'STC')

    ---- DELETE TEST EMPLOYEES FROM BDM ----
    DELETE dbo.[U_dsi_BDM_EDISPCRCOB]
    WHERE EXISTS  (SELECT DISTINCT EepEEID
                        FROM dbo.EmpPers
                        WHERE dbo.[U_dsi_BDM_EDISPCRCOB].bdmeeid = eepeeid
                        and LEFT(EepSSN, 3) = '999')

     INSERT INTO [dbo].[U_dsi_BDM_EDISPCRCOB]
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
    SELECT DISTINCT 'DEP'
    ,EecCOID
    ,EecEEID
    ,DbnDepRecID
    ,NULL
    ,'QB'
    ,'Data inserted for 203 term reason'
    , DbnRelationship
    ,EepDateOfBirth
    ,DedDedCode
    ,DbnBenOption
    ,DbnBenStartDate
    ,DbnBenStopDate 
    ,DbnBenStatusDate
    ,DbnBenStatusDate
    ,'210'
    ,'210'
    ,NULL
    ,NULL
    ,'Y'
    FROM dbo.EmpComp WITH(NOLOCK)
    JOIN dbo.u_dsi_bdm_DepDeductions WITH(NOLOCK)
    ON EecEEID = dbnEEID
    AND EecCOID = dbnCOID
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = dbnEEID
    JOIN dbo.U_EDISPCRCOB_DeathEvent WITH(NOLOCK)
    ON EecEEID = EeDeathId
    AND IsSpouse = '0' -- IF NO SPOUSE EXISTS THEN CHILD IS PQB
    WHERE DbnValidForExport = 'N'
    AND DbnFormatCode = 'EDISPCRCOB'
    --AND eeceeid = 'DTCQW5000040'
    AND EecTermReason = '203'
    AND DbnRelationship IN ('CHL', 'DPC', 'STC')
    ORDER BY DbnRelationship DESC

      -- Dependents Count
        IF OBJECT_ID('U_EDISPCRCOB_DepCount','U') IS NOT NULL 
        DROP TABLE dbo.U_EDISPCRCOB_DepCount;

        SELECT e.bdmeeid as DCEEID, e.bdmcoid AS DCCOID, count(distinct(s.bdmdateofbirth)) as spouse_count, count(distinct(c.bdmdateofbirth)) as child_count
        into dbo.U_EDISPCRCOB_DepCount
        FROM dbo.U_dsi_BDM_EDISPCRCOB e WITH(NOLOCK) 
        left JOIN dbo.U_dsi_BDM_EDISPCRCOB s WITH(NOLOCK) ON e.bdmeeid = s.bdmeeid  and s.bdmrelationship in ('sps', 'spx', 'dmp', 'dp')
        left join dbo.U_dsi_BDM_EDISPCRCOB c with(nolock) on e.bdmeeid = c.bdmeeid and c.bdmrelationship in ('chl', 'dpc', 'stc')

        group by e.bdmeeid, e.bdmcoid

    --==========================================
    -- Build driver tables
    --==========================================
    ------------------
    -- DETAIL RECORD - NPM Record
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_NPM') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_NPM;
    SELECT DISTINCT
         drvEEID            = BdmEEID
        ,drvCoID            = BdmCoID
        ,drvSSN             = eepSSN
        ,drvEmpNo           = ''
        ,drvClientName      = CONVERT(varchar(100),'PCRK Employee Leasing Company LLC 40641')
        ,drvClientDivName   = CONVERT(varchar(50),'PCRK Employee Leasing Company LLC')
        ,drvNameFirst       = EepNameFirst
        ,drvNameMiddle      = LEFT(EepNameMiddle,1)
        ,drvNameLast        = EepNameLast
        ,drvAddressEMail    = ''
        ,drvPhoneHomeNumber = ''
        ,drvAddressLine1    = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2    = REPLACE(EepAddressLine2, ',', '')
        ,drvAddressCity     = EepAddressCity
        ,drvAddressState    = EepAddressState
        ,drvAddressZipCode  = EepAddressZipCode
        ,drvGender          = CASE WHEN EepGender = 'M' THEN 'M'
                                    WHEN EepGender = 'F' THEN 'F' 
                                ELSE 'U' END
        ,drvHireDate        = EecDateOfLastHire
        --ISNULL(CONVERT(VARCHAR, (CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END), 101), '')
        ,drvInitialSort     = '22'
        ,drvSubSort         = eepSSN
        ,drvSubSort2        = ''
        ,drvSubSort3        = ''
    INTO dbo.U_EDISPCRCOB_drvTbl_NPM
    FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    WHERE BdmRunID = 'NPM';

    ------------------
    -- QB DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QB') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QB;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = ISNULL(BdmDepRecID,'')
        ,drvClientName     = CONVERT(varchar(100),'PCRK Employee Leasing Company LLC 40641')
        ,drvClientDivName  = CONVERT(varchar(50),'PCRK Employee Leasing Company LLC')
        ,drvNameFirst      = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConNameFirst ELSE EepNameFirst END
        ,drvNameMiddle     = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN LEFT(ConNameMiddle, 1) ELSE LEFT(EepNameMiddle, 1) END
        ,drvNameLast       = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConNameLast ELSE EepNameLast END
        ,drvSSN            = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN SUBSTRING(ConSSN, 1, 3)+'-'+
                                                                                                                    SUBSTRING(ConSSN, 4, 2)+'-'+
                                                                                                                    SUBSTRING(ConSSN, 6, 4)  ELSE SUBSTRING(EepSSN, 1, 3)+'-'+
                                                                                                                                                    SUBSTRING(EepSSN, 4, 2)+'-'+
                                                                                                                                                    SUBSTRING(EepSSN, 6, 4)  END
        ,drvEmpNo          = ''
        ,drvAddressLine1   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN REPLACE(ConAddressLine1, ',', '') ELSE REPLACE(EepAddressLine1, ',', '') END
        ,drvAddressLine2   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN REPLACE(ConAddressLine2, ',', '') ELSE REPLACE(EepAddressLine2, ',', '') END
        ,drvAddressCity    = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConAddressCity ELSE EepAddressCity END
        ,drvAddressState   = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConAddressState ELSE EepAddressState END
        ,drvAddressZipCode = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConAddressZipCode ELSE EepAddressZipCode END
        ,drvGender         = CASE WHEN EepGender = 'M' OR ConGender = 'M' THEN 'M'
                                    WHEN EepGender = 'F' OR ConGender = 'F' THEN 'F' ELSE 'U' END
        ,drvDateOfBirth    = CASE WHEN BdmChangeReason IN ('201', 'LEVNT3', '204', '210', 'LEVNT4', '203') THEN ConDateOfBirth ELSE EepDateOfBirth END
        ,drvInitialSort    = '21'
        ,drvSubSort        = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                                  ELSE ISNULL(NULLIF(ConSSN,''),eepSSN) + CONVERT(char(8),ConDateOfBirth,112)
                             END
        ,drvSubSort2       = '1'
        ,drvSubSort3       = CASE WHEN BdmRecType = 'EMP' THEN '2'
                                  ELSE CONVERT(char(8),ConDateOfBirth,112) + RTRIM(ConNameLast) + ConNameFirst
                             END
    INTO dbo.U_EDISPCRCOB_drvTbl_QB
    FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = BdmEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBEVENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBEVENT') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBEVENT;
    SELECT DISTINCT
         drvEEID           = drvEEID
        ,drvCoID           = drvCoID
        ,drvDepRecID       = drvDepRecID
        ,drvEventType      = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') AND EecTermType = 'V' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') AND EecTermType = '' THEN 'TERMINATION'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '203' THEN 'DEATH'
                                    WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'RETIREMENT'
                                    WHEN EecEmplStatus = 'T' AND EecTermType = 'I' THEN 'INVOLUNTARYTERMINATION'
                                    WHEN Bdmcobrareason = '208' THEN 'RETIREMENT'
                                    WHEN Bdmcobrareason = '205' THEN 'MEDICARE'
                                    WHEN Bdmcobrareason IN ('204', 'LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                    WHEN bdmcobrareason IN ('201', 'LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                    WHEN bdmcobrareason IN ('203', '202') THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                    WHEN bdmcobrareason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                    ELSE 'TERMINATION'
                                END
        /*CASE WHEN EecTermReason = '202' THEN 'RETIREMENT'
                                  WHEN EecTermReason = '203' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'INELIGIBLEDEPENDENT'
                                  WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCELEGALSEPARATION'
                                  WHEN BdmCobraReason = '210' THEN 'DEATH'
                                  WHEN BdmCobraReason IN ('202','CHGRP') THEN 'LOSSOFELIGIBILITY'
                                  WHEN BdmCobraReason = '203' THEN 'REDUCTIONINHOURS-STATUSCHANGE'
                                  WHEN BdmCobraReason = '205' THEN 'MEDICARE'
                                  WHEN BdmCobraReason = '206' THEN 'REDUCTIONINHOURS-ENDOFLEAVE'
                                  WHEN BdmCobraReason = '207' THEN 'USERRA-REDUCTIONINHOURS'
                                  WHEN BdmCobraReason = '208' THEN 'RETIREMENT'
                                  WHEN BdmCobraReason = '209' THEN 'WORKSTOPPAGE'
                                  ELSE 'TERMINATION'
                             END */
        ,drvEventDate      = CASE WHEN EecEmplStatus = 'T' AND EecTermReason NOT IN ('202', '203') THEN EecDateOfTermination
                                    WHEN EecEmplStatus = 'T' AND EecTermReason IN ('202', '203') AND BdmDateOfCOBRAEvent = '' THEN EecDateOfTermination
                                    WHEN BdmChangeReason IN ('LEVNT3', 'LEVNT4', '204', '210', '201') THEN edh.EdhEffDate 
                                ELSE BdmDateOfCOBRAEvent END
        ,drvEnrollmentDate = (SELECT MAX(BdmBenStartDate) FROM dbo.U_dsi_BDM_EDISPCRCOB a WITH(NOLOCK) WHERE a.bdmeeid = bdm.bdmeeid and a.bdmcoid = bdm.bdmcoid)
        ,drvSSN            = SUBSTRING(EepSSN, 1, 3)+'-'+
                                SUBSTRING(EepSSN, 4, 2)+'-'+
                                SUBSTRING(EepSSN, 6, 4) 
        ,drvName           = RTRIM(EepNameFirst) + ' ' + RTRIM(EepNameLast)
                            /*CASE WHEN BdmRecType = 'DEP' THEN RTRIM(EepNameFirst) + ' ' + EepNameLast
                                  ELSE ''
                             END */
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '1'
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBEVENT
    FROM dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
       AND EecCoID = drvCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN (SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDedCode
            ,BdmDepRecID
            ,BdmRecType
            ,BdmChangeReason
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
          FROM dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
          WHERE BdmRunID = 'QB'
            AND BdmIsPQB = 'Y'
          GROUP BY BdmEEID, BdmCoID, BdmDedCode, BdmDepRecID, BdmRecType, BdmChangeReason) BDM
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    OUTER APPLY (SELECT TOP 1 EdhEffDate FROM dbo.EmpHDed WITH(NOLOCK) 
    WHERE BdmDedCode = EdhDedCode and BdmCOID = EdhCOID and BdmEEID = EdhEEID ORDER BY EdhDateTimeCreated DESC) edh;

    ------------------
    -- QBPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBPLAN;
    SELECT DISTINCT
         drvEEID          = drvEEID
        ,drvCoID          = drvCoID
        ,drvDepRecID      = drvDepRecID
        ,drvDedCode       = BdmDedCode
        ,drvPlanName      = CASE BdmDedCode 
                                WHEN 'DENH' THEN 'MetLife Dental High DPPO'
                                WHEN 'DENL' THEN 'MetLife Dental Low DPPO'
                                WHEN 'VISH' THEN 'MetLife Vision High PPO'
                                WHEN 'VISL' THEN 'MetLife Vision Low PPO'
                                WHEN 'MEDU4' THEN 'UHC Medical Choice Plus PPO $1000'
                                WHEN 'MEDU3' THEN 'UHC Medical Choice Plus PPO $3000'
                                WHEN 'MEDU2' THEN 'UHC Medical Choice Plus PPO $6000'
                                WHEN 'MEDU1' THEN 'UHC Medical Choice Plus PPO $7150'
                                WHEN 'FSA' THEN 'WEX FSA' END
        /*CONVERT(varchar(50),'@PlanName')*/
        ,drvCoverageLevel = CASE WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count = 1
                                        THEN 'EE+CHILD'
                                WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count > 1
                                        THEN 'EE+CHILDREN'
                                WHEN BdmCobraReason IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmRelationship IN ('DMP', 'DP', 'SPS', 'SPX') AND child_count = 0
                                        THEN 'EE'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption IN ('EEF', 'EEDPF') THEN 'EE+FAMILY'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND child_count = 1 AND BdmBenOption <> 'EE' THEN 'EE+CHILD'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND child_count > 1 AND BdmBenOption <> 'EE' THEN 'EE+CHILDREN'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EEDP' THEN 'EE+DOMESTICPARTNER'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EES' THEN 'EE+SPOUSE'
                                WHEN BdmCobraReason NOT IN ('204', 'LEVNT4', '201', 'LEVNT3', '210') AND BdmDedCode IN ('DENH', 'DENL', 'VISH', 'VISL', 'MEDU4',
                                                    'MEDU3', 'MEDU2', 'MEDU1') AND BdmBenOption = 'EE' THEN 'EE'
                                WHEN BdmDedCode = 'FSA' THEN 'EE' 
                            END

                                
        -- CASE WHEN BdmDedCode IN ('MEDHD', 'MEDPP', 'DEN', 'VIS') THEN 
        --                         CASE WHEN BdmBenOption IN ('EE', 'EEP', 'EEMD') THEN 'EE'
        --                              WHEN BdmBenOption IN ('EEC1', 'EEC1MD', 'EEC1P') THEN 'EE+CHILD'
        --                              WHEN BdmBenOption IN ('EEC', 'EECP', 'EECMD') THEN 'EE+CHILDREN'
        --                              WHEN BdmBenOption IN ('EEDP', 'EEDPP', 'EEDMMD', 'EEDPNP') THEN 'EE+DOMESTICPARTNER'
        --                              WHEN BdmBenOption IN ('EEF', 'EEFP', 'EEFMD', 'EEF0', 'EEF0MD', 'EEF0P', 'EEDPFP', 'EEDPFN', 'EEDPNC', 'EEDFMD', 'EEDPN') THEN 'EE+FAMILY'
        --                              WHEN BdmBenOption IN ('EES', 'EESP', 'EESMD', 'EES0', 'EES0MD', 'EES0P') THEN 'EE+SPOUSE'
        --                         END
        --                     END
                /*CASE WHEN BdmDedType = 'FSA' THEN 'EE'
                                 WHEN BdmRecType = 'EMP' THEN
                                      CASE WHEN BdmBenOption IN ('@EEBenOpts') THEN 'EE'
                                           WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'EE+CHILDREN'
                                           WHEN BdmBenOption IN ('@ESPBenOpts') THEN 'EE+SPOUSE'
                                           WHEN BdmBenOption IN ('@EDPBenOpts') THEN 'EE+DOMESTICPARTNER'
                                           WHEN BdmBenOption IN ('@EEFAMBenOpts') THEN 'EE+FAMILY'
                                      END
                                 WHEN BdmRelationship IN ('@SPSRelationships','@DPRelationships') THEN
                                      CASE WHEN ISNULL(BdmNumChildren,0) = 1 THEN 'EE+1'
                                           WHEN ISNULL(BdmNumChildren,0) > 1 THEN 'EE+FAMILY'
                                           ELSE 'EE'
                                      END
                                 ELSE 'EE'
                            END */
        ,drvInitialSort   = '21'
        ,drvSubSort       = drvSubSort
        ,drvSubSort2      = '1' + BdmDedCode
        ,drvSubSort3      = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBPLAN
    FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
    JOIN dbo.U_EDISPCRCOB_DepCount WITH(NOLOCK)
        ON DCEEID = BdmEEID
        AND DCCOID = BdmCOID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y';

    ------------------
    -- QBDEPENDENT DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEP') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBDEP;
    SELECT DISTINCT
         drvEEID           = BdmEEID
        ,drvCoID           = BdmCoID
        ,drvDepRecID       = BdmDepRecID
        ,drvSSN            = SUBSTRING(ConSSN, 1, 3)+'-'+
                                SUBSTRING(ConSSN, 4, 2)+'-'+
                                SUBSTRING(ConSSN, 6, 4) 
        ,drvRelationship   = CASE WHEN BdmRelationship IN ('SPS', 'SPX') THEN 'SPOUSE'
                                  WHEN BdmRelationship IN ('DP', 'DMP') THEN 'DOMESTICPARTNER'
                                  ELSE 'CHILD'
                             END
        ,drvNameFirst      = ConNameFirst
        ,drvNameMiddle     = LEFT(ConNameMiddle,1)
        ,drvNameLast       = ConNameLast
        ,drvIsAddressSame  = CASE WHEN ConAddressIsDifferent = 'N' OR ConAddressLine1 IS NULL THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvAddressLine1   = ''
        ,drvAddressLine2   = ''
        ,drvAddressCity    = ''
        ,drvAddressState   = ''
        ,drvAddressZipCode = ''
        ,drvGender         = CASE WHEN ConGender = 'M' THEN 'M' 
                                    WHEN ConGender = 'F' THEN 'F'
                                    ELSE 'U' END
        ,drvDateOfBirth    = ConDateOfBirth
        ,drvISQMCO         = CASE WHEN BdmRelationship IN ('@QMCORelationships') THEN 'TRUE'
                                  ELSE 'FALSE'
                             END
        ,drvInitialSort    = '21'
        ,drvSubSort        = drvSubSort
        ,drvSubSort2       = '2' + CASE WHEN BdmRelationship IN ('SPS', 'SPX', 'DP', 'DMP') THEN 'A'
                                        ELSE 'B' + ISNULL(ConSSN,ConNameFirst)
                                   END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID
        ,drvSubSort3       = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBDEP
    FROM dbo.U_EDISPCRCOB_drvTbl_QB WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
    AND drvDepRecID <> ConSystemID
    --AND BdmIsPQB = 'N';

    ------------------
    -- QBDEPENDENTPLANINITIAL DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBDEPPLAN') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN;
    SELECT DISTINCT
         drvEEID        = BdmEEID
        ,drvCoID        = BdmCoID
        ,drvDepRecID    = BdmDepRecID
        ,drvDedCode     = BdmDedCode
        ,drvPlanName    = CASE BdmDedCode 
                                WHEN 'DENH' THEN 'MetLife Dental High DPPO'
                                WHEN 'DENL' THEN 'MetLife Dental Low DPPO'
                                WHEN 'VISH' THEN 'MetLife Vision High PPO'
                                WHEN 'VISL' THEN 'MetLife Vision Low PPO'
                                WHEN 'MEDU4' THEN 'UHC Medical Choice Plus PPO $1000'
                                WHEN 'MEDU3' THEN 'UHC Medical Choice Plus PPO $3000'
                                WHEN 'MEDU2' THEN 'UHC Medical Choice Plus PPO $6000'
                                WHEN 'MEDU1' THEN 'UHC Medical Choice Plus PPO $7150'
                                WHEN 'FSA' THEN 'WEX FSA' END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '2' + CASE WHEN BdmRelationship IN ('SPS', 'SPX', 'DP', 'DMP') THEN 'A'
                                     ELSE 'B' + RTRIM(ISNULL(ConSSN,ConNameFirst))
                                END + CONVERT(char(8),ISNULL(ConDateOfBirth,''),112) + ConSystemID + BdmDedCode
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND BdmDedCode = drvDedCode
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = BdmEEID
       AND ConSystemID = BdmDepRecID
    WHERE BdmRunID = 'QB'
    AND drvDepRecID <> ConSystemID
   --   AND BdmIsPQB = 'N';

     ------------------
    -- QBSTATEINSERTS DETAIL RECORD -- MN-CONTINSERT
    ------------------

    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBSTATEINSERT') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvStateSpecDocName = CASE EepAddressState 
                                WHEN 'CA' THEN 'CA-SRINSERT'
                                WHEN 'CT' THEN 'CT-SRINSERT'
                                WHEN 'OR' THEN 'OR-SRINSERT'
                                WHEN 'TX' THEN 'TX-SRINSERT'
                                WHEN 'NY' THEN 'NY-SRINSERT'
                                WHEN 'IL' THEN 'IL-SRINSERT'
                                WHEN 'RI' THEN 'RI-SRINSERT'
                                WHEN 'GA' THEN 'GA-SRINSERT'
                                WHEN 'VA' THEN 'VA-SRINSERT'
                                WHEN 'MN' THEN 'MN-CONTINSERT' -- 2ND INSERT BELOW
                                END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '4'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID 
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    WHERE BdmRunID = 'QB'
    AND EepAddressState IN ('CA', 'CT', 'OR', 'TX', 'NY', 'IL', 'RI', 'GA', 'VA', 'MN');

      ------------------
    -- QBSTATEINSERTS DETAIL RECORD -- MN-LIFEINSERT
    ------------------

    INSERT INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    SELECT DISTINCT
         drvEEID  
        ,drvCoID  
        ,drvDepRecID 
        ,drvStateSpecDocName = 'MN-LIFEINSERT'
        ,drvInitialSort 
        ,drvSubSort   
        ,drvSubSort2   
        ,drvSubSort3    
    --INTO dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT
    FROM dbo.U_EDISPCRCOB_drvTbl_QBSTATEINSERT WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
    ON EepEEID = drvEEID
    WHERE EepAddressState = 'MN'

    ------------------
    -- QBPLANMEMBERSPECIFICRATEINITIAL DETAIL RECORD
    ----------------
    IF OBJECT_ID('U_EDISPCRCOB_drvTbl_QBMSRI') IS NOT NULL
        DROP TABLE dbo.U_EDISPCRCOB_drvTbl_QBMSRI;
    SELECT DISTINCT
         drvEEID        = drvEEID
        ,drvCoID        = drvCoID
        ,drvDepRecID    = drvDepRecID
        ,drvPlanName    = drvPlanName
        ,drvRate        = BdmEEAmt
        --CASE WHEN EecPayPeriod = 'M' THEN BdmEEAmt
  --                             WHEN EecPayPeriod = 'S' THEN BdmEEAmt * 2
  --                             WHEN EecPayPeriod = 'B' THEN BdmEEAmt * 26/12
  --                             WHEN EecPayPeriod = 'W' THEN BdmEEAmt * 52/12
  --                        END
        ,drvInitialSort = '21'
        ,drvSubSort     = drvSubSort
        ,drvSubSort2    = '3'
        ,drvSubSort3    = drvSubSort3
    INTO dbo.U_EDISPCRCOB_drvTbl_QBMSRI
    FROM dbo.U_EDISPCRCOB_drvTbl_QBPLAN WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EDISPCRCOB WITH (NOLOCK)
        ON BdmEEID = drvEEID
       AND BdmCoID = drvCoID
       AND ISNULL(BdmDepRecID,'') = drvDepRecID
       AND BdmDedCode = drvDedCode
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = BdmEEID
       AND EecCoID = BdmCoID
    WHERE BdmRunID = 'QB'
      AND BdmIsPQB = 'Y'
      AND BdmDedType = 'FSA';

    ---- SET COVERAGE LEVEL = 'EE' FOR EMPLOYEES THAT HAVE INELIGIBLE DEPENDENT AS THE EVENT TYPE ----
    UPDATE dbo.U_EDISPCRCOB_drvTbl_QBPLAN
    SET drvCoverageLevel = 'EE'
    FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT a WITH(NOLOCK)
    WHERE a.drvEEID = dbo.U_EDISPCRCOB_drvTbl_QBPLAN.drvEEID
    AND a.drvCOID = dbo.U_EDISPCRCOB_drvTbl_QBPLAN.drvCOID
    AND a.drvEventType = 'INELIGIBLEDEPENDENT'
    AND dbo.U_EDISPCRCOB_drvTbl_QBPLAN.drvCoverageLevel IS NULL

    ---- REMOVE DEPENDENTS THAT ARE >= 26 FOR DEPENDENT TABLE ----
    DELETE dbo.U_EDISPCRCOB_drvTbl_QBDEP
    WHERE drvDepRecID = (SELECT DISTINCT BdmDepRecId
                            FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT a WITH(NOLOCK) JOIN dbo.u_dsi_bdm_EDISPCRCOB
                            ON a.drvEEID = bdmEEID
                            AND a.drvCOID = bdmCOID
                            JOIN dbo.Contacts b WITH(NOLOCK)
                            ON drvEEID = ConEEID
                            AND drvDepRecId = ConSystemId
                            WHERE a.drvEEID = drvEEID
                            AND a.drvCOID = drvCOID
                            AND DATEDIFF(year, ConDateOfBirth, drvEnrollmentDate ) >= 26 
                            AND  bdmrelationship in ('chl', 'dpc', 'stc')
                            AND a.drvEventType = 'INELIGIBLEDEPENDENT'
                            )

    ---- REMOVE DEPENDENTS THAT ARE >= 26 FOR DEPENDENT PLAN TABLE ----
    DELETE dbo.U_EDISPCRCOB_drvTbl_QBDEPPLAN
    WHERE drvDepRecID = (SELECT DISTINCT BdmDepRecId
                            FROM dbo.U_EDISPCRCOB_drvTbl_QBEVENT a WITH(NOLOCK) JOIN dbo.u_dsi_bdm_EDISPCRCOB
                            ON a.drvEEID = bdmEEID
                            AND a.drvCOID = bdmCOID
                            JOIN dbo.Contacts b WITH(NOLOCK)
                            ON drvEEID = ConEEID
                            AND drvDepRecId = ConSystemId
                            WHERE a.drvEEID = drvEEID
                            AND a.drvCOID = drvCOID
                            AND DATEDIFF(year, ConDateOfBirth, drvEnrollmentDate ) >= 26 
                            AND  bdmrelationship in ('chl', 'dpc', 'stc')
                            AND a.drvEventType = 'INELIGIBLEDEPENDENT'
                            )

    --DELETE u_dsi_bdm_EDISPCRCOB
    --WHERE BdmDepRecID = (SELECT DISTINCT CASE WHEN DATEDIFF(year, ConDateOfBirth, BdmBenStartDate ) >= 26 and bdmrelationship in ('chl', 'dpc', 'stc') then ConSystemID END
    --FROM dbo.Contacts WITH(NOLOCK)
    --WHERE    ConEEID = bdmEEID
    --AND ConSystemID = BdmDepRecID)
    ------------------------------------------


     --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'NWOS_EDISPCRCOB_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END
END;
/*
--Alter the View
ALTER VIEW dbo.dsi_vwEDISPCRCOB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISPCRCOB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISPCRCOB%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201601251'
   ,expStartPerControl     = '201601251'
   ,expLastEndPerControl   = '201602039'
   ,expEndPerControl       = '201602039'
WHERE expFormatCode = 'EDISPCRCOB'
  AND expExportCode LIKE 'TEST%';
*/
SET NOCOUNT OFF;
GO
CREATE VIEW dbo.dsi_vwEDISPCRCOB_Export AS
    SELECT TOP 2000000 Data
    FROM dbo.U_EDISPCRCOB_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, SubSort2, SubSort3, RecordSet;

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDISPCRCOB' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EDISPCRCOB'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EDISPCRCOB'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISPCRCOB', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDISPCRCOB', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDISPCRCOB', 'UseFileName', 'V', 'Y'


-- End ripout