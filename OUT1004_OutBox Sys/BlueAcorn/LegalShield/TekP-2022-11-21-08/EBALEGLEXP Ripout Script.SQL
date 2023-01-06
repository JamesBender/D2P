/**********************************************************************************

EBALEGLEXP: LegalShield Export

FormatCode:     EBALEGLEXP
Project:        LegalShield Export
Client ID:      OUT1004
Date/time:      2023-01-06 13:22:19.720
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP1DB03
Database:       ULTIPRO_WPOUTB
Web Filename:   OUT1004_VA7H4_EEHISTORY_EBALEGLEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EBALEGLEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_EBALEGLEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EBALEGLEXP'


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
WHERE FormatCode = 'EBALEGLEXP'
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
WHERE ExpFormatCode = 'EBALEGLEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EBALEGLEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EBALEGLEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EBALEGLEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EBALEGLEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EBALEGLEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EBALEGLEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EBALEGLEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EBALEGLEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EBALEGLEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EBALEGLEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEBALEGLEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBALEGLEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBALEGLEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBALEGLEXP];
GO
IF OBJECT_ID('U_EBALEGLEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_Trailer];
GO
IF OBJECT_ID('U_EBALEGLEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_Header];
GO
IF OBJECT_ID('U_EBALEGLEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_File];
GO
IF OBJECT_ID('U_EBALEGLEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_EEList];
GO
IF OBJECT_ID('U_EBALEGLEXP_drvTbl_M') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_drvTbl_M];
GO
IF OBJECT_ID('U_EBALEGLEXP_drvTbl_D') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_drvTbl_D];
GO
IF OBJECT_ID('U_EBALEGLEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_DedList];
GO
IF OBJECT_ID('U_EBALEGLEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_AuditFields];
GO
IF OBJECT_ID('U_EBALEGLEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBALEGLEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBALEGLEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBALEGLEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBALEGLEXP','LegalShield Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','EBALEGLEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBALEGLEXPZ0','1','H','01','1',NULL,'Record Type',NULL,NULL,'"R"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBALEGLEXPZ0','8','H','01','2',NULL,'File Date',NULL,NULL,'"drvFileDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBALEGLEXPZ0','50','H','01','3',NULL,'Transmitter Name',NULL,NULL,'"drvTransName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBALEGLEXPZ0','1','D','10','1',NULL,'Record Type',NULL,NULL,'"M"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBALEGLEXPZ0','8','D','10','2',NULL,'Mbr Coverage Eff-Date',NULL,NULL,'"drvMbrCoverageEffDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBALEGLEXPZ0','20','D','10','3',NULL,'Mbr Last Name',NULL,NULL,'"drvMbrLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBALEGLEXPZ0','18','D','10','4',NULL,'Mbr First Name',NULL,NULL,'"drvMbrFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBALEGLEXPZ0','1','D','10','5',NULL,'Mbr Middle Initial',NULL,NULL,'"drvMbrMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBALEGLEXPZ0','30','D','10','6',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBALEGLEXPZ0','30','D','10','7',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBALEGLEXPZ0','30','D','10','8',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBALEGLEXPZ0','25','D','10','9',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EBALEGLEXPZ0','2','D','10','10',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EBALEGLEXPZ0','12','D','10','11',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EBALEGLEXPZ0','11','D','10','12',NULL,'Mbr Number',NULL,NULL,'"drvMbrNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EBALEGLEXPZ0','8','D','10','13',NULL,'Mbr DOB',NULL,NULL,'"drvMbrDOB"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EBALEGLEXPZ0','10','D','10','14',NULL,'Mbr Home Phone',NULL,NULL,'"drvMbrHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EBALEGLEXPZ0','10','D','10','15',NULL,'Mbr Work Phone',NULL,NULL,'"drvMbrWorkPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EBALEGLEXPZ0','5','D','10','16',NULL,'Mbr Work Phone Ext.',NULL,NULL,'"drvMbrWorkPhoneExt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EBALEGLEXPZ0','7','D','10','17',NULL,'Mbr Group #',NULL,NULL,'"drvMbrGroupNum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EBALEGLEXPZ0','9','D','10','18',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EBALEGLEXPZ0','2','D','10','19',NULL,'Member Coverage Code',NULL,NULL,'"drvCoverageCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EBALEGLEXPZ0','15','D','10','20',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EBALEGLEXPZ0','9','D','10','21',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EBALEGLEXPZ0','4','D','10','22',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EBALEGLEXPZ0','2','D','10','23',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EBALEGLEXPZ0','4','D','10','24',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EBALEGLEXPZ0','25','D','10','25',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EBALEGLEXPZ0','1','D','10','26',NULL,'Activity Flag',NULL,NULL,'"drvActivityFlag"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EBALEGLEXPZ0','50','D','10','27',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EBALEGLEXPZ0','6','D','10','28',NULL,'Filler',NULL,NULL,'"drvFiller"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EBALEGLEXPZ0','2','D','10','29',NULL,'Member Pay Period',NULL,NULL,'"drvMemberPayPeriod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EBALEGLEXPZ0','2','D','10','30',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EBALEGLEXPZ0','10','D','10','31',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EBALEGLEXPZ0','10','D','10','32',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EBALEGLEXPZ0','16','D','10','33',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EBALEGLEXPZ0','6','D','10','34',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EBALEGLEXPZ0','20','D','10','35',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EBALEGLEXPZ0','20','D','10','36',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EBALEGLEXPZ0','1','D','10','37',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EBALEGLEXPZ0','8','D','10','38',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EBALEGLEXPZ0','1','D','10','39',NULL,'Termination Reason',NULL,NULL,'"drvTerminationReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EBALEGLEXPZ0','10','D','10','40',NULL,'Billing Division Code',NULL,NULL,'"drvBillingDivisionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EBALEGLEXPZ0','3','D','10','41',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EBALEGLEXPZ0','3','D','10','42',NULL,'Member Coverage Code',NULL,NULL,'"drvMemberCoverageCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBALEGLEXPZ0','1','D','20','1',NULL,'Record Type',NULL,NULL,'"D"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBALEGLEXPZ0','8','D','20','2',NULL,'Eff Date',NULL,NULL,'"drvEffDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBALEGLEXPZ0','50','D','20','3',NULL,'Dep Last Name',NULL,NULL,'"drvDepLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBALEGLEXPZ0','7','D','20','4',NULL,'Dep First Name',NULL,NULL,'"drvDepFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EBALEGLEXPZ0','1','D','20','5',NULL,'Dep Middle Initial',NULL,NULL,'"drvDepMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EBALEGLEXPZ0','2','D','20','6',NULL,'Relationship Indv',NULL,NULL,'"drvRelationshipIndv"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EBALEGLEXPZ0','11','D','20','7',NULL,'Mbr Number',NULL,NULL,'"drvMbrNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EBALEGLEXPZ0','8','D','20','8',NULL,'Dep DOB',NULL,NULL,'"drvDepDOB"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EBALEGLEXPZ0','3','D','20','9',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EBALEGLEXPZ0','1','T','90','1',NULL,'Record Type',NULL,NULL,'"T"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EBALEGLEXPZ0','8','T','90','2',NULL,'File Date',NULL,NULL,'"drvFileDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EBALEGLEXPZ0','50','T','90','3',NULL,'Transmitter Name',NULL,NULL,'"drvTransName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EBALEGLEXPZ0','7','T','90','4',NULL,'Count of Records',NULL,NULL,'"drvCountofRecords"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EBALEGLEXP_20230106.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202301159','EMPEXPORT','OEACTIVE',NULL,'EBALEGLEXP',NULL,NULL,NULL,'202301159','Jan  6 2023 12:41PM','Jan  6 2023 12:41PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202301159','EMPEXPORT','OEPASSIVE',NULL,'EBALEGLEXP',NULL,NULL,NULL,'202301159','Jan  6 2023 12:41PM','Jan  6 2023 12:41PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LegalShield Export','202301159','EMPEXPORT','ONDEM_XOE',NULL,'EBALEGLEXP',NULL,NULL,NULL,'202301159','Jan  6 2023 12:41PM','Jan  6 2023 12:41PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LegalShield Export-Sched','202301159','EMPEXPORT','SCH_EBALEG',NULL,'EBALEGLEXP',NULL,NULL,NULL,'202301159','Jan  6 2023 12:41PM','Jan  6 2023 12:41PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'LegalShield Export-Test','202301159','EMPEXPORT','TEST_XOE',NULL,'EBALEGLEXP',NULL,NULL,NULL,'202301159','Jan  6 2023 12:41PM','Jan  6 2023 12:41PM','202212301',NULL,'','','202212301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBALEGLEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBALEGLEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBALEGLEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBALEGLEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBALEGLEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBALEGLEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBALEGLEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBALEGLEXP','H01','dbo.U_EBALEGLEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBALEGLEXP','D10','dbo.U_EBALEGLEXP_drvTbl_M',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBALEGLEXP','D20','dbo.U_EBALEGLEXP_drvTbl_D',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBALEGLEXP','T90','dbo.U_EBALEGLEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EBALEGLEXP
-----------

IF OBJECT_ID('U_dsi_BDM_EBALEGLEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBALEGLEXP] (
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
-- Create table U_EBALEGLEXP_Audit
-----------

IF OBJECT_ID('U_EBALEGLEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
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
-- Create table U_EBALEGLEXP_AuditFields
-----------

IF OBJECT_ID('U_EBALEGLEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EBALEGLEXP_DedList
-----------

IF OBJECT_ID('U_EBALEGLEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EBALEGLEXP_drvTbl_D
-----------

IF OBJECT_ID('U_EBALEGLEXP_drvTbl_D') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_drvTbl_D] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvEffDate] char(10) NULL,
    [drvDepLastName] varchar(8000) NULL,
    [drvDepFirstName] varchar(8000) NULL,
    [drvDepMiddleInitial] varchar(1) NULL,
    [drvRelationshipIndv] varchar(2) NULL,
    [drvMbrNumber] char(11) NULL,
    [drvDepDOB] char(10) NULL,
    [drvSuffix] varchar(1) NOT NULL
);

-----------
-- Create table U_EBALEGLEXP_drvTbl_M
-----------

IF OBJECT_ID('U_EBALEGLEXP_drvTbl_M') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_drvTbl_M] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvMbrCoverageEffDate] char(10) NULL,
    [drvMbrLastName] varchar(6000) NULL,
    [drvMbrFirstName] varchar(6000) NULL,
    [drvMbrMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(51) NULL,
    [drvMbrNumber] char(11) NULL,
    [drvMbrDOB] char(10) NULL,
    [drvMbrHomePhone] varchar(50) NULL,
    [drvMbrWorkPhone] varchar(50) NULL,
    [drvMbrWorkPhoneExt] varchar(10) NULL,
    [drvMbrGroupNum] varchar(6) NOT NULL,
    [drvCoverageCode] varchar(2) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvActivityFlag] varchar(1) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvMemberPayPeriod] varchar(2) NULL,
    [drvTerminationDate] char(10) NULL,
    [drvTerminationReason] varchar(1) NOT NULL,
    [drvBillingDivisionCode] varchar(1) NOT NULL,
    [drvSuffix] varchar(1) NOT NULL,
    [drvMemberCoverageCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EBALEGLEXP_EEList
-----------

IF OBJECT_ID('U_EBALEGLEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EBALEGLEXP_File
-----------

IF OBJECT_ID('U_EBALEGLEXP_File') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_EBALEGLEXP_Header
-----------

IF OBJECT_ID('U_EBALEGLEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_Header] (
    [drvFileDate] char(10) NULL,
    [drvTransName] varchar(14) NOT NULL
);

-----------
-- Create table U_EBALEGLEXP_Trailer
-----------

IF OBJECT_ID('U_EBALEGLEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EBALEGLEXP_Trailer] (
    [drvFileDate] char(10) NULL,
    [drvTransName] varchar(14) NOT NULL,
    [drvCountofRecords] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBALEGLEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Blue Acorn

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 01/06/2023
Service Request Number: TekP-2022-11-21-08

Purpose: LegalShield Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBALEGLEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBALEGLEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBALEGLEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBALEGLEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBALEGLEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBALEGLEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBALEGLEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBALEGLEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBALEGLEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBALEGLEXP', 'SCH_EBALEG';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBALEGLEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EBALEGLEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileRunDate       VARCHAR(8);

    -- Set FormatCode
    SELECT @FormatCode = 'EBALEGLEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileRunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBALEGLEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBALEGLEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBALEGLEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBALEGLEXP_AuditFields;
    CREATE TABLE dbo.U_EBALEGLEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EBALEGLEXP_AuditFields VALUES ('Empcomp','EecEmplStatus')

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBALEGLEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBALEGLEXP_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EBALEGLEXP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBALEGLEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBALEGLEXP_Audit ON dbo.U_EBALEGLEXP_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EBALEGLEXP_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBALEGLEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
      DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LEG';

    IF OBJECT_ID('U_EBALEGLEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBALEGLEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBALEGLEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@Dedlist);
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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode ;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBALEGLEXP_drvTbl_M
    ---------------------------------
    IF OBJECT_ID('U_EBALEGLEXP_drvTbl_M','U') IS NOT NULL
        DROP TABLE dbo.U_EBALEGLEXP_drvTbl_M;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvMbrCoverageEffDate = CONVERT(CHAR(10),BdmBenStartDate,112)
        ,drvMbrLastName = dbo.dsi_fnRemoveChars(',',EepNameLast)
        ,drvMbrFirstName = dbo.dsi_fnRemoveChars(',',EepNameFirst)
        ,drvMbrMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars(',',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars(',',EepAddressLine2)
        ,drvAddressLine3 = ''
        ,drvCity = dbo.dsi_fnRemoveChars(',',EepAddressCity)
        ,drvState = EepAddressState
        ,drvPostalCode = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-') ELSE EepAddressZipCode END
        ,drvMbrNumber = EepSSN
        ,drvMbrDOB = CONVERT(CHAR(10),EepDateOfBirth,112)
        ,drvMbrHomePhone = EepPhoneHomeNumber
        ,drvMbrWorkPhone = EecPhoneBusinessNumber
        ,drvMbrWorkPhoneExt = EecPhoneBusinessExt
        ,drvMbrGroupNum = '302521'
        ,drvCoverageCode = CASE WHEN BdmDedCode = 'LEG' AND BdmBenOption = 'EE' THEN 'NX' END
        ,drvEmployeeID = EecEmpNo
        ,drvActivityFlag = CASE  EecEmplStatus 
                                WHEN  'A' THEN 'A'
                                WHEN  'L' THEN 'L'
                                END
        ,drvEmailAddress = EepAddressEMail
        ,drvMemberPayPeriod = CASE EecPayPeriod
                                    WHEN 'W' THEN '52'
                                    WHEN 'B' THEN '26'
                                    WHEN 'S' THEN '24'
                                    WHEN 'M' THEN '12'
                                END
        ,drvTerminationDate = CONVERT(CHAR(10),CASE WHEN BdmDedCode = 'LEG' THEN BdmBenStopDate END,112)
        ,drvTerminationReason = ''--CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvBillingDivisionCode = ''
        ,drvSuffix = ''
        ,drvMemberCoverageCode = ''
    INTO dbo.U_EBALEGLEXP_drvTbl_M
    FROM dbo.U_EBALEGLEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBALEGLEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRecType = 'EMP'
    LEFT JOIN dbo.U_EBALEGLEXP_Audit WITH (NOLOCK)
        ON audEeid = Xeeid
        AND audCOID = XCOID
      WHERE EecEEType <> 'TES' AND ( EecEmplStatus <> 'T' OR  (EecEmplStatus = 'T' and auddatetime between @startdate and @EndDate))  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EBALEGLEXP_drvTbl_D
    ---------------------------------
    IF OBJECT_ID('U_EBALEGLEXP_drvTbl_D','U') IS NOT NULL
        DROP TABLE dbo.U_EBALEGLEXP_drvTbl_D;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvEffDate = CONVERT(CHAR(10),Bdmbenstartdate, 112) 
        ,drvDepLastName = REPLACE(CASE WHEN ISNULL(ConNameSuffix, '') NOT IN ('Z','') THEN (ConNameLast + ' ' + ConNameSuffix) ELSE ConNameLast END, ',' ,'')
        ,drvDepFirstName = REPLACE(ConNameFirst, ',' ,'')
        ,drvDepMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvRelationshipIndv = CASE WHEN conrelationship IN ('SPS', 'DP', 'LP') THEN 'SP' 
                                    WHEN conrelationship IN ('CHL', 'COD', 'DCH', 'DPC', 'STC') THEN 'DP' 
                                END
        ,drvMbrNumber = eepssn
        ,drvDepDOB = CONVERT(CHAR(10),ConDateOfBirth, 112)
        ,drvSuffix = ''
    INTO dbo.U_EBALEGLEXP_drvTbl_D
    FROM dbo.U_EBALEGLEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EBALEGLEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRecType = 'DEP'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        LEFT JOIN dbo.U_EBALEGLEXP_Audit WITH (NOLOCK)
        ON audEeid = Xeeid
        AND audCOID = XCOID
        WHERE EecEEType <> 'TES' AND ( EecEmplStatus <> 'T' OR  (EecEmplStatus = 'T' and auddatetime between @startdate and @EndDate)) 
    ;
     ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBALEGLEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EBALEGLEXP_Header;
    SELECT DISTINCT
         drvFileDate = CONVERT(CHAR(10),@FileRunDate, 112)
        ,drvTransName = 'Blue Acorn iCi'
    INTO dbo.U_EBALEGLEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EBALEGLEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EBALEGLEXP_Trailer;
    SELECT DISTINCT
         drvFileDate = CONVERT(CHAR(10),@FileRunDate, 112)
        ,drvTransName = 'Blue Acorn iCi'
        ,drvCountofRecords = (select count(*) cnt from dbo.U_EBALEGLEXP_drvTbl_D) + (select count(*) cnt from dbo.U_EBALEGLEXP_drvTbl_M)
    INTO dbo.U_EBALEGLEXP_Trailer
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
ALTER VIEW dbo.dsi_vwEBALEGLEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBALEGLEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EBALEGLEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301011'
       ,expStartPerControl     = '202301011'
       ,expLastEndPerControl   = '202301079'
       ,expEndPerControl       = '202301079'
WHERE expFormatCode = 'EBALEGLEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBALEGLEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBALEGLEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EBALEGLEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EBALEGLEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EBALEGLEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBALEGLEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EBALEGLEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EBALEGLEXP', 'UseFileName', 'V', 'Y'


-- End ripout