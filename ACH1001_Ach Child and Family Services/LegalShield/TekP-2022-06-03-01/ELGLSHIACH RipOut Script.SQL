/**********************************************************************************

ELGLSHIACH: LegalShield Export

FormatCode:     ELGLSHIACH
Project:        LegalShield Export
Client ID:      ACH1001
Date/time:      2022-07-29 16:40:09.120
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP5DB02
Database:       ULTIPRO_WPACHS
Web Filename:   ACH1001_XTE10_EEHISTORY_ELGLSHIACH_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELGLSHIACH_SavePath') IS NOT NULL DROP TABLE dbo.U_ELGLSHIACH_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELGLSHIACH'


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
WHERE FormatCode = 'ELGLSHIACH'
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
WHERE ExpFormatCode = 'ELGLSHIACH'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELGLSHIACH')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELGLSHIACH'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELGLSHIACH'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELGLSHIACH'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELGLSHIACH'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELGLSHIACH'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELGLSHIACH'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELGLSHIACH'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELGLSHIACH'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELGLSHIACH'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELGLSHIACH_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELGLSHIACH_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELGLSHIACH') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELGLSHIACH];
GO
IF OBJECT_ID('U_ELGLSHIACH_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ELGLSHIACH_Trailer];
GO
IF OBJECT_ID('U_ELGLSHIACH_Header') IS NOT NULL DROP TABLE [dbo].[U_ELGLSHIACH_Header];
GO
IF OBJECT_ID('U_ELGLSHIACH_File') IS NOT NULL DROP TABLE [dbo].[U_ELGLSHIACH_File];
GO
IF OBJECT_ID('U_ELGLSHIACH_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELGLSHIACH_EEList];
GO
IF OBJECT_ID('U_ELGLSHIACH_drvMemberTbl') IS NOT NULL DROP TABLE [dbo].[U_ELGLSHIACH_drvMemberTbl];
GO
IF OBJECT_ID('U_ELGLSHIACH_drvDependentTbl') IS NOT NULL DROP TABLE [dbo].[U_ELGLSHIACH_drvDependentTbl];
GO
IF OBJECT_ID('U_ELGLSHIACH_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELGLSHIACH_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ELGLSHIACH') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELGLSHIACH];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELGLSHIACH','LegalShield Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ELGLSHIACHZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELGLSHIACHZ0','50','H','01','1',NULL,'Record Type',NULL,NULL,'"R"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELGLSHIACHZ0','50','H','01','2',NULL,'File Date',NULL,NULL,'"drvFileDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELGLSHIACHZ0','50','H','01','3',NULL,'Transmitter Name',NULL,NULL,'"drvTransName"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELGLSHIACHZ0','50','D','10','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELGLSHIACHZ0','50','D','10','2',NULL,'Mbr Coverage Eff-Date',NULL,NULL,'"drvMbrCoverageEffDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELGLSHIACHZ0','50','D','10','3',NULL,'Mbr Last Name',NULL,NULL,'"drvMbrLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELGLSHIACHZ0','50','D','10','4',NULL,'Mbr First Name',NULL,NULL,'"drvMbrFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELGLSHIACHZ0','50','D','10','5',NULL,'Mbr Middle Initial',NULL,NULL,'"drvMbrMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELGLSHIACHZ0','50','D','10','6',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELGLSHIACHZ0','50','D','10','7',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELGLSHIACHZ0','50','D','10','8',NULL,'Address Line 3',NULL,NULL,'"drvAddressLine3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELGLSHIACHZ0','50','D','10','9',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELGLSHIACHZ0','50','D','10','10',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELGLSHIACHZ0','50','D','10','11',NULL,'Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELGLSHIACHZ0','50','D','10','12',NULL,'Mbr Number',NULL,NULL,'"drvMbrNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELGLSHIACHZ0','50','D','10','13',NULL,'Mbr DOB',NULL,NULL,'"drvMbrDOB"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELGLSHIACHZ0','50','D','10','14',NULL,'Mbr Home Phone',NULL,NULL,'"drvMbrHomePhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELGLSHIACHZ0','50','D','10','15',NULL,'Mbr Work Phone',NULL,NULL,'"drvMbrWorkPhone"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELGLSHIACHZ0','50','D','10','16',NULL,'Mbr Work Phone Ext.',NULL,NULL,'"drvMbrWorkPhoneExt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELGLSHIACHZ0','50','D','10','17',NULL,'Mbr Group #',NULL,NULL,'"drvMbrGroupNum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELGLSHIACHZ0','50','D','10','18',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELGLSHIACHZ0','50','D','10','19',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELGLSHIACHZ0','50','D','10','20',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELGLSHIACHZ0','50','D','10','21',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELGLSHIACHZ0','50','D','10','22',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELGLSHIACHZ0','50','D','10','23',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELGLSHIACHZ0','50','D','10','24',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELGLSHIACHZ0','50','D','10','25',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELGLSHIACHZ0','50','D','10','26',NULL,'Activity Flag',NULL,NULL,'"drvActivityFlag"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELGLSHIACHZ0','50','D','10','27',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELGLSHIACHZ0','50','D','10','28',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELGLSHIACHZ0','50','D','10','29',NULL,'Member Pay Period',NULL,NULL,'"drvMemberPayPeriod"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELGLSHIACHZ0','50','D','10','30',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELGLSHIACHZ0','50','D','10','31',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELGLSHIACHZ0','50','D','10','32',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ELGLSHIACHZ0','50','D','10','33',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ELGLSHIACHZ0','50','D','10','34',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ELGLSHIACHZ0','50','D','10','35',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ELGLSHIACHZ0','50','D','10','36',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ELGLSHIACHZ0','50','D','10','37',NULL,'Filler',NULL,NULL,'""','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ELGLSHIACHZ0','50','D','10','38',NULL,'Termination Date',NULL,NULL,'"drvTerminationDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ELGLSHIACHZ0','50','D','10','39',NULL,'Termination Reason',NULL,NULL,'"drvTerminationReason"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ELGLSHIACHZ0','50','D','10','40',NULL,'Billing Division Code',NULL,NULL,'"drvBillingDivisionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ELGLSHIACHZ0','50','D','10','41',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ELGLSHIACHZ0','50','D','10','42',NULL,'Member Coverage Code',NULL,NULL,'"drvMemberCoverageCode"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELGLSHIACHZ0','50','D','20','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELGLSHIACHZ0','50','D','20','2',NULL,'Eff Date',NULL,NULL,'"drvEffDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELGLSHIACHZ0','50','D','20','3',NULL,'Dep Last Name',NULL,NULL,'"drvDepLastName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELGLSHIACHZ0','50','D','20','4',NULL,'Dep First Name',NULL,NULL,'"drvDepFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELGLSHIACHZ0','50','D','20','5',NULL,'Dep Middle Initial',NULL,NULL,'"drvDepMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELGLSHIACHZ0','50','D','20','6',NULL,'Relationship Indv',NULL,NULL,'"drvRelationshipIndv"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELGLSHIACHZ0','50','D','20','7',NULL,'Mbr Number',NULL,NULL,'"drvMbrNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELGLSHIACHZ0','50','D','20','8',NULL,'Dep DOB',NULL,NULL,'"drvDepDOB"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELGLSHIACHZ0','50','D','20','9',NULL,'Suffix',NULL,NULL,'"drvSuffix"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELGLSHIACHZ0','50','T','90','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELGLSHIACHZ0','50','T','90','2',NULL,'File Date',NULL,NULL,'"drvFileDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELGLSHIACHZ0','50','T','90','3',NULL,'Transmitter Name',NULL,NULL,'"drvTransName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELGLSHIACHZ0','50','T','90','4',NULL,'Count of Records',NULL,NULL,'"drvCountofRecords"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELGLSHIACH_20220729.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202207109','EMPEXPORT','OEACTIVE',NULL,'ELGLSHIACH',NULL,NULL,NULL,'202207109','Jul 10 2022  3:22PM','Jul 10 2022  3:22PM','202207101',NULL,'','','202207101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202207109','EMPEXPORT','OEPASSIVE',NULL,'ELGLSHIACH',NULL,NULL,NULL,'202207109','Jul 10 2022  3:22PM','Jul 10 2022  3:22PM','202207101',NULL,'','','202207101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LegalShield Export','202207109','EMPEXPORT','ONDEM_XOE',NULL,'ELGLSHIACH',NULL,NULL,NULL,'202207109','Jul 10 2022  3:22PM','Jul 10 2022  3:22PM','202207101',NULL,'','','202207101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LegalShield Export-Sched','202207109','EMPEXPORT','SCH_ELGLSH',NULL,'ELGLSHIACH',NULL,NULL,NULL,'202207109','Jul 10 2022  3:22PM','Jul 10 2022  3:22PM','202207101',NULL,'','','202207101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'LegalShield Export-Test','202207281','EMPEXPORT','TEST_XOE','Jul 28 2022 12:00AM','ELGLSHIACH',NULL,NULL,NULL,'202207281','Jul 28 2022 12:00AM','Dec 30 1899 12:00AM','202207141',NULL,'','','202207141',dbo.fn_GetTimedKey(),NULL,'us3cPeACH1001',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELGLSHIACH','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELGLSHIACH','H01','dbo.U_ELGLSHIACH_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELGLSHIACH','D10','dbo.U_ELGLSHIACH_drvMemberTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELGLSHIACH','D20','dbo.U_ELGLSHIACH_drvDependentTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELGLSHIACH','T90','dbo.U_ELGLSHIACH_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ELGLSHIACH
-----------

IF OBJECT_ID('U_dsi_BDM_ELGLSHIACH') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELGLSHIACH] (
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
-- Create table U_ELGLSHIACH_DedList
-----------

IF OBJECT_ID('U_ELGLSHIACH_DedList') IS NULL
CREATE TABLE [dbo].[U_ELGLSHIACH_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ELGLSHIACH_drvDependentTbl
-----------

IF OBJECT_ID('U_ELGLSHIACH_drvDependentTbl') IS NULL
CREATE TABLE [dbo].[U_ELGLSHIACH_drvDependentTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvEffDate] datetime NULL,
    [drvDepLastName] varchar(8000) NULL,
    [drvDepFirstName] varchar(8000) NULL,
    [drvDepMiddleInitial] varchar(1) NULL,
    [drvRelationshipIndv] varchar(2) NULL,
    [drvMbrNumber] char(11) NULL,
    [drvDepDOB] datetime NULL,
    [drvSuffix] varchar(30) NULL
);

-----------
-- Create table U_ELGLSHIACH_drvMemberTbl
-----------

IF OBJECT_ID('U_ELGLSHIACH_drvMemberTbl') IS NULL
CREATE TABLE [dbo].[U_ELGLSHIACH_drvMemberTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvMbrCoverageEffDate] datetime NULL,
    [drvMbrLastName] varchar(8000) NULL,
    [drvMbrFirstName] varchar(8000) NULL,
    [drvMbrMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvPostalCode] varchar(8000) NULL,
    [drvMbrNumber] char(11) NULL,
    [drvMbrDOB] datetime NULL,
    [drvMbrHomePhone] varchar(50) NULL,
    [drvMbrWorkPhone] varchar(1) NOT NULL,
    [drvMbrWorkPhoneExt] varchar(1) NOT NULL,
    [drvMbrGroupNum] varchar(6) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvActivityFlag] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvMemberPayPeriod] varchar(2) NOT NULL,
    [drvTerminationDate] varchar(1) NOT NULL,
    [drvTerminationReason] varchar(1) NOT NULL,
    [drvBillingDivisionCode] varchar(1) NOT NULL,
    [drvSuffix] varchar(30) NULL,
    [drvMemberCoverageCode] varchar(2) NULL
);

-----------
-- Create table U_ELGLSHIACH_EEList
-----------

IF OBJECT_ID('U_ELGLSHIACH_EEList') IS NULL
CREATE TABLE [dbo].[U_ELGLSHIACH_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELGLSHIACH_File
-----------

IF OBJECT_ID('U_ELGLSHIACH_File') IS NULL
CREATE TABLE [dbo].[U_ELGLSHIACH_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_ELGLSHIACH_Header
-----------

IF OBJECT_ID('U_ELGLSHIACH_Header') IS NULL
CREATE TABLE [dbo].[U_ELGLSHIACH_Header] (
    [drvFileDate] varchar(8) NULL,
    [drvTransName] varchar(29) NOT NULL
);

-----------
-- Create table U_ELGLSHIACH_Trailer
-----------

IF OBJECT_ID('U_ELGLSHIACH_Trailer') IS NULL
CREATE TABLE [dbo].[U_ELGLSHIACH_Trailer] (
    [drvRecordType] varchar(1) NOT NULL,
    [drvFileDate] varchar(8) NULL,
    [drvTransName] varchar(29) NOT NULL,
    [drvCountofRecords] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELGLSHIACH]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ACH Child and Family Services

Created By: Marco Lagrosa / Marie Waters
Business Analyst: Cheryl Petitti
Create Date: 07/10/2022
Service Request Number: 

Purpose: LegalShield Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELGLSHIACH';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELGLSHIACH';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELGLSHIACH';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELGLSHIACH';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELGLSHIACH' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELGLSHIACH', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELGLSHIACH', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELGLSHIACH', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELGLSHIACH', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELGLSHIACH', 'SCH_ELGLSH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELGLSHIACH';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELGLSHIACH', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8);

    -- Set FormatCode
    SELECT @FormatCode = 'ELGLSHIACH';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ELGLSHIACH_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELGLSHIACH_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LEGAL,IDSHD,LSID,LSIDG';

    IF OBJECT_ID('U_ELGLSHIACH_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELGLSHIACH_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELGLSHIACH_DedList
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

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELGLSHIACH_drvMemberTbl
    ---------------------------------
    IF OBJECT_ID('U_ELGLSHIACH_drvMemberTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELGLSHIACH_drvMemberTbl;
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1' + eepssn
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'M'
        ,drvMbrCoverageEffDate = CASE WHEN  BdmDedCode IN ('LEGAL', 'IDSHD', 'LSID', 'LSIDG') THEN bdmbenstartdate END
        ,drvMbrLastName = REPLACE(EepNameLast, ',', '')
        ,drvMbrFirstName = REPLACE(EepNameFirst, ',', '')
        ,drvMbrMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = REPLACE(EepAddressLine2, ',', '')
        ,drvAddressLine3 = ''
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvPostalCode = REPLACE(EepAddressZipCode, '=', '')
        ,drvMbrNumber = eepssn
        ,drvMbrDOB = EepDateOfBirth
        ,drvMbrHomePhone = EepPhoneHomeNumber
        ,drvMbrWorkPhone = ''
        ,drvMbrWorkPhoneExt = ''
        ,drvMbrGroupNum = '204125'
        ,drvEmployeeID = EecEmpNo
        ,drvActivityFlag = ''
        ,drvEmailAddress = EepAddressEMail
        ,drvMemberPayPeriod = '26'
        ,drvTerminationDate = '' --CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationReason = '' -- CASE WHEN EecEmplStatus = 'T' THEN EecTermReason END
        ,drvBillingDivisionCode = ''
        ,drvSuffix = CASE WHEN EepNameSuffix =  'Z' THEN '' ELSE EepNameSuffix END
        ,drvMemberCoverageCode = CASE WHEN BdmDedCode = 'LEGAL' THEN 'NB'
                                      WHEN BdmDedCode = 'IDSHD' and BdmBenOption = 'EE' THEN 'P4'
                                      WHEN BdmDedCode = 'IDSHD' and BdmBenOption <> 'EE' THEN 'P5'
                                      WHEN BdmDedCode IN ('LSID', 'LSIDG') and BdmBenOption = 'EE' THEN 'P6'
                                      WHEN BdmDedCode IN ('LSID', 'LSIDG') and BdmBenOption <> 'EE' THEN  'P7'
                                     END
    INTO dbo.U_ELGLSHIACH_drvMemberTbl
    FROM dbo.U_ELGLSHIACH_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ELGLSHIACH WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRecType = 'EMP'
        WHERE EecEEType <> 'TES' AND EecEmplStatus <> 'T' AND EecEmplStatus = 'A' 
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ELGLSHIACH_drvDependentTbl
    ---------------------------------
    IF OBJECT_ID('U_ELGLSHIACH_drvDependentTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELGLSHIACH_drvDependentTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '1' + eepssn
        ,drvSubSort = Case When conrelationship IN ('SPS', 'DP', 'LP')  THen '1' Else '2' END
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = 'D'
        ,drvEffDate = CASE WHEN BdmDedCode IN ('LEGAL', 'IDSHD', 'LSID', 'LSIDG') THEN Bdmbenstartdate END
        ,drvDepLastName = REPLACE(ConNameLast, ',' ,'')
        ,drvDepFirstName = REPLACE(ConNameFirst, ',' ,'')
        ,drvDepMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvRelationshipIndv = CASE WHEN conrelationship IN ('SPS', 'DP', 'LP') THEN 'SP' 
                                    WHEN conrelationship IN ('CHL', 'COD', 'DCH', 'DPC', 'STC') THEN 'DP' 
                                END
        ,drvMbrNumber = eepssn
        ,drvDepDOB = ConDateOfBirth
        ,drvSuffix = Case WHEN ConNameSuffix = 'Z' THEN '' ELSE ConNameSuffix END
    INTO dbo.U_ELGLSHIACH_drvDependentTbl
    FROM dbo.U_ELGLSHIACH_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_ELGLSHIACH WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND bdmRecType = 'DEP'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        WHERE EecEEType <> 'TES' AND EecEmplStatus <> 'T' and EecEmplStatus = 'A' 
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELGLSHIACH_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ELGLSHIACH_Header;
    SELECT DISTINCT
         drvFileDate = @Rundate
        ,drvTransName = 'ACH Child and Family Services'
    INTO dbo.U_ELGLSHIACH_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ELGLSHIACH_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ELGLSHIACH_Trailer;
    SELECT DISTINCT
         drvRecordType = 'T'
        ,drvFileDate = @Rundate
        ,drvTransName = 'ACH Child and Family Services'
        ,drvCountofRecords = (select count(*) cnt from dbo.U_ELGLSHIACH_drvDependentTbl) + (select count(*) cnt from dbo.U_ELGLSHIACH_drvMemberTbl)
    INTO dbo.U_ELGLSHIACH_Trailer
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
ALTER VIEW dbo.dsi_vwELGLSHIACH_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELGLSHIACH_File (NOLOCK)
    ORDER BY InitialSort, SubSort, RIGHT(RecordSet,2)

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELGLSHIACH%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202207031'
       ,expStartPerControl     = '202207031'
       ,expLastEndPerControl   = '202207109'
       ,expEndPerControl       = '202207109'
WHERE expFormatCode = 'ELGLSHIACH';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELGLSHIACH_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELGLSHIACH_File WITH (NOLOCK)
     ORDER BY  InitialSort, SubSort, RIGHT(RecordSet,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELGLSHIACH' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELGLSHIACH'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELGLSHIACH'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELGLSHIACH', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELGLSHIACH', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELGLSHIACH', 'UseFileName', 'V', 'Y'


-- End ripout