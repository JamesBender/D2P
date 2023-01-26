/**********************************************************************************

ECPIMETEXP: MetLife Dent/Accident/Critical Illness Export

FormatCode:     ECPIMETEXP
Project:        MetLife Dent/Accident/Critical Illness Export
Client ID:      ECP1000
Date/time:      2023-01-25 08:30:13.950
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    E23
Server:         E2SUP3DB05
Database:       ULTIPRO_ECPI
Web Filename:   ECP1000_59685_EEHISTORY_ECPIMETEXP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ECPIMETEXP_SavePath') IS NOT NULL DROP TABLE dbo.U_ECPIMETEXP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ECPIMETEXP'


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
WHERE FormatCode = 'ECPIMETEXP'
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
WHERE ExpFormatCode = 'ECPIMETEXP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ECPIMETEXP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ECPIMETEXP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ECPIMETEXP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ECPIMETEXP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ECPIMETEXP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ECPIMETEXP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ECPIMETEXP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ECPIMETEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ECPIMETEXP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ECPIMETEXP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwECPIMETEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECPIMETEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECPIMETEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECPIMETEXP];
GO
IF OBJECT_ID('U_ECPIMETEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_Trailer];
GO
IF OBJECT_ID('U_ECPIMETEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_Header];
GO
IF OBJECT_ID('U_ECPIMETEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_File];
GO
IF OBJECT_ID('U_ECPIMETEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_EEList];
GO
IF OBJECT_ID('U_ECPIMETEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_drvTbl];
GO
IF OBJECT_ID('U_ECPIMETEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_DedList];
GO
IF OBJECT_ID('U_ECPIMETEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_AuditFields];
GO
IF OBJECT_ID('U_ECPIMETEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECPIMETEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ECPIMETEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECPIMETEXP];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECPIMETEXP','MetLife Dent/Accident/Critical Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ECPIMETEXPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECPIMETEXPZ0','1','H','01','1',NULL,'Record Type',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECPIMETEXPZ0','50','H','01','2',NULL,'Entity Name',NULL,NULL,'"drvEntityName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECPIMETEXPZ0','8','H','01','52',NULL,'Date File Created',NULL,NULL,'"drvDateFileCreated"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECPIMETEXPZ0','1','H','01','60',NULL,'Changes Only Indicator',NULL,NULL,'"drvChangesonlyInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECPIMETEXPZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL,'"drvTransactionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECPIMETEXPZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL,'"drvCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ECPIMETEXPZ0','11','D','10','9',NULL,'Employee SSN',NULL,NULL,'"drvEmployeeSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ECPIMETEXPZ0','11','D','10','20',NULL,'Member SSN',NULL,NULL,'"drvMemberSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ECPIMETEXPZ0','9','D','10','31',NULL,'Personel ID',NULL,NULL,'"drvPersonelID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ECPIMETEXPZ0','20','D','10','40',NULL,'Last name',NULL,NULL,'"drvLastname"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ECPIMETEXPZ0','12','D','10','60',NULL,'First name',NULL,NULL,'"drvFirstname"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ECPIMETEXPZ0','1','D','10','72',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ECPIMETEXPZ0','8','D','10','73',NULL,'Birth date',NULL,NULL,'"drvBirthdate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ECPIMETEXPZ0','1','D','10','81',NULL,'Marital status',NULL,NULL,'"drvMaritalstatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ECPIMETEXPZ0','1','D','10','82',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ECPIMETEXPZ0','2','D','10','83',NULL,'Relationship',NULL,NULL,'"drvRelationship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ECPIMETEXPZ0','8','D','10','85',NULL,'Date of hire',NULL,NULL,'"drvDateofhire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ECPIMETEXPZ0','1','D','10','93',NULL,'Foreign address indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ECPIMETEXPZ0','32','D','10','94',NULL,'Street address I',NULL,NULL,'"drvStreetaddressI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ECPIMETEXPZ0','32','D','10','126',NULL,'Street address II',NULL,NULL,'"drvStreetaddress2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ECPIMETEXPZ0','21','D','10','158',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ECPIMETEXPZ0','2','D','10','179',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ECPIMETEXPZ0','9','D','10','181',NULL,'Zip code',NULL,NULL,'"drvZipcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ECPIMETEXPZ0','3','D','10','190',NULL,'Country code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ECPIMETEXPZ0','2','D','10','193',NULL,'Employee work state',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ECPIMETEXPZ0','10','D','10','195',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ECPIMETEXPZ0','40','D','10','205',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ECPIMETEXPZ0','9','D','10','245',NULL,'Salary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ECPIMETEXPZ0','1','D','10','254',NULL,'Salary Mode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ECPIMETEXPZ0','8','D','10','255',NULL,'Salary Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ECPIMETEXPZ0','1','D','10','263',NULL,'Employee [work] status code',NULL,NULL,'"drvEmployeeworkstatuscode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ECPIMETEXPZ0','8','D','10','264',NULL,'Employee [work] status code effective date',NULL,NULL,'"drvEmpworkstatuscodeeffdate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ECPIMETEXPZ0','1','D','10','272',NULL,'Federal Marital Tax Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ECPIMETEXPZ0','10','D','10','273',NULL,'Department',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ECPIMETEXPZ0','10','D','10','283',NULL,'Group ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ECPIMETEXPZ0','5','D','10','293',NULL,'Location ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ECPIMETEXPZ0','10','D','10','298',NULL,'Schedule ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ECPIMETEXPZ0','2','D','10','308',NULL,'Pay frequency',NULL,NULL,'"drvPayfrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ECPIMETEXPZ0','1','D','10','310',NULL,'Employee smoker status',NULL,NULL,'"drvEmployeesmokerstatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ECPIMETEXPZ0','1','D','10','311',NULL,'Spouse smoker status',NULL,NULL,'"drvSpousesmokerstatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ECPIMETEXPZ0','1','D','10','312',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ECPIMETEXPZ0','1','D','10','313',NULL,'Handicapped dependent indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ECPIMETEXPZ0','30','D','10','314',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ECPIMETEXPZ0','1','D','10','344',NULL,'Dental Coverage',NULL,NULL,'"drvDentalCoverage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ECPIMETEXPZ0','8','D','10','345',NULL,'Coverage effective date',NULL,NULL,'"drvCoverageeffectivedateDen"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ECPIMETEXPZ0','8','D','10','353',NULL,'Coverage end date',NULL,NULL,'"drvCoverageenddateDen"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ECPIMETEXPZ0','7','D','10','361',NULL,'Report/group number',NULL,NULL,'"drvReportgroupnumberDen"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ECPIMETEXPZ0','4','D','10','368',NULL,'Subcode',NULL,NULL,'"drvSubcodeDen"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ECPIMETEXPZ0','4','D','10','372',NULL,'Branch',NULL,NULL,'"drvBranchDen"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ECPIMETEXPZ0','2','D','10','376',NULL,'Plan code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ECPIMETEXPZ0','1','D','10','378',NULL,'Coverage Status',NULL,NULL,'"drvCoverageStatusDen"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ECPIMETEXPZ0','1','D','10','379',NULL,'Members Covered Code',NULL,NULL,'"drvMembersCoveredCodeDen"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ECPIMETEXPZ0','2','D','10','380',NULL,'COBRA indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ECPIMETEXPZ0','1','D','10','382',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ECPIMETEXPZ0','8','D','10','383',NULL,'Facility ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ECPIMETEXPZ0','2','D','10','391',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ECPIMETEXPZ0','1','D','10','393',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ECPIMETEXPZ0','1030','D','10','394',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ECPIMETEXPZ0','2','D','10','1424',NULL,'Accident Insurance',NULL,NULL,'"drvAccidentInsurance"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ECPIMETEXPZ0','8','D','10','1426',NULL,'Coverage effective date',NULL,NULL,'"drvCoverageeffectivedateAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ECPIMETEXPZ0','8','D','10','1434',NULL,'Coverage end date',NULL,NULL,'"drvCoverageenddateAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ECPIMETEXPZ0','7','D','10','1442',NULL,'Report/group number',NULL,NULL,'"drvReportgroupnumberAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','ECPIMETEXPZ0','4','D','10','1449',NULL,'Subcode',NULL,NULL,'"drvSubcodeAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','ECPIMETEXPZ0','4','D','10','1453',NULL,'Branch',NULL,NULL,'"drvBranchAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','ECPIMETEXPZ0','1','D','10','1457',NULL,'Coverage Status',NULL,NULL,'"drvCoverageStatusAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','ECPIMETEXPZ0','1','D','10','1458',NULL,'Members covered code',NULL,NULL,'"drvMemberscoveredcodeAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','ECPIMETEXPZ0','1','D','10','1459',NULL,'Enrollment status',NULL,NULL,'"drvEnrollmentstatusAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','ECPIMETEXPZ0','2','D','10','1460',NULL,'Voluntary Cancel Indicator',NULL,NULL,'"drvVoluntaryCancelIndicatorAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','ECPIMETEXPZ0','1','D','10','1462',NULL,'Takeover Indicator',NULL,NULL,'"drvTakeoverIndicatorAcc"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','ECPIMETEXPZ0','77','D','10','1463',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','ECPIMETEXPZ0','2','D','10','1540',NULL,'Employee Critical Illness Attained Age',NULL,NULL,'"drvEmpCriticalIllsAttainedAge"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','ECPIMETEXPZ0','8','D','10','1542',NULL,'Coverage effective date',NULL,NULL,'"drvCoverageeffectivedateEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','ECPIMETEXPZ0','8','D','10','1550',NULL,'Coverage end date',NULL,NULL,'"drvCoverageenddateEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','ECPIMETEXPZ0','7','D','10','1558',NULL,'Report/group number',NULL,NULL,'"drvReportgroupnumberEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','ECPIMETEXPZ0','4','D','10','1565',NULL,'Subcode',NULL,NULL,'"drvSubcodeEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','ECPIMETEXPZ0','4','D','10','1569',NULL,'Branch',NULL,NULL,'"drvBranchEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','ECPIMETEXPZ0','1','D','10','1573',NULL,'Coverage Status',NULL,NULL,'"drvCoverageStatusEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','ECPIMETEXPZ0','1','D','10','1574',NULL,'Members covered code',NULL,NULL,'"drvMemberscoveredcodeEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','ECPIMETEXPZ0','1','D','10','1575',NULL,'Enrollment status',NULL,NULL,'"drvEnrollmentstatusEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','ECPIMETEXPZ0','8','D','10','1576',NULL,'Benefit amount',NULL,NULL,'"drvBenefitamountEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','ECPIMETEXPZ0','2','D','10','1584',NULL,'Voluntary Cancel Indicator',NULL,NULL,'"drvVoluntaryCancelIndicatorEmpCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','ECPIMETEXPZ0','1','D','10','1586',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','ECPIMETEXPZ0','19','D','10','1587',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','ECPIMETEXPZ0','2','D','10','1606',NULL,'Dependent Critical Illness Attained Age',NULL,NULL,'"drvDepCriticalIllAttainedAge"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','ECPIMETEXPZ0','8','D','10','1608',NULL,'Coverage effective date',NULL,NULL,'"drvCoverageeffectivedateDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','ECPIMETEXPZ0','8','D','10','1616',NULL,'Coverage end date',NULL,NULL,'"drvCoverageenddateDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','ECPIMETEXPZ0','7','D','10','1624',NULL,'Report/group number',NULL,NULL,'"drvReportgroupnumberDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','ECPIMETEXPZ0','4','D','10','1631',NULL,'Subcode',NULL,NULL,'"drvSubcodeDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','ECPIMETEXPZ0','4','D','10','1635',NULL,'Branch',NULL,NULL,'"drvBranchDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','ECPIMETEXPZ0','1','D','10','1639',NULL,'Coverage Status',NULL,NULL,'"drvCoverageStatusDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','ECPIMETEXPZ0','1','D','10','1640',NULL,'Members covered code',NULL,NULL,'"drvMemberscoveredcodeDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','ECPIMETEXPZ0','1','D','10','1641',NULL,'Enrollment status',NULL,NULL,'"drvEnrollmentstatusDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','ECPIMETEXPZ0','8','D','10','1642',NULL,'Benefit amount',NULL,NULL,'"drvBenefitamountDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','ECPIMETEXPZ0','2','D','10','1650',NULL,'Voluntary Cancel Indicator',NULL,NULL,'"drvVoluntaryCancelIndicatorDepCI"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','ECPIMETEXPZ0','1','D','10','1652',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','ECPIMETEXPZ0','19','D','10','1653',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ECPIMETEXPZ0','1','T','90','1',NULL,'Record Type',NULL,NULL,'"Z"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ECPIMETEXPZ0','8','T','90','2',NULL,'Total Record Count',NULL,NULL,'"drvTotalRecordCount"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ECPIMETEXP_20230125.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202301249','EMPEXPORT','OEACTIVE',NULL,'ECPIMETEXP',NULL,NULL,NULL,'202301249','Dec 13 2022  6:41AM','Dec 13 2022  6:41AM','202301171',NULL,'','','202301171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202301249','EMPEXPORT','OEPASSIVE',NULL,'ECPIMETEXP',NULL,NULL,NULL,'202301249','Dec 13 2022  6:41AM','Dec 13 2022  6:41AM','202301171',NULL,'','','202301171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'202301249','EMPEXPORT','ONDEM_XOE',NULL,'ECPIMETEXP',NULL,NULL,NULL,'202301249','Dec 13 2022  6:41AM','Dec 13 2022  6:41AM','202301171',NULL,'','','202301171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'202301249','EMPEXPORT','SCH_ECPIME',NULL,'ECPIMETEXP',NULL,NULL,NULL,'202301249','Dec 13 2022  6:41AM','Dec 13 2022  6:41AM','202301171',NULL,'','','202301171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,NULL,'202301249','EMPEXPORT','TEST_XOE',NULL,'ECPIMETEXP',NULL,NULL,NULL,'202301249','Dec 13 2022  6:41AM','Dec 13 2022  6:41AM','202301171',NULL,'','','202301171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECPIMETEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECPIMETEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECPIMETEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECPIMETEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECPIMETEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECPIMETEXP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECPIMETEXP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECPIMETEXP','H01','dbo.U_ECPIMETEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECPIMETEXP','D10','dbo.U_ECPIMETEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECPIMETEXP','T90','dbo.U_ECPIMETEXP_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ECPIMETEXP
-----------

IF OBJECT_ID('U_dsi_BDM_ECPIMETEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECPIMETEXP] (
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
-- Create table U_ECPIMETEXP_Audit
-----------

IF OBJECT_ID('U_ECPIMETEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL,
    [audTerminated] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audBenAmt] nvarchar(2000) NULL,
    [audEEEligDate] nvarchar(2000) NULL
);

-----------
-- Create table U_ECPIMETEXP_AuditFields
-----------

IF OBJECT_ID('U_ECPIMETEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ECPIMETEXP_DedList
-----------

IF OBJECT_ID('U_ECPIMETEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ECPIMETEXP_drvTbl
-----------

IF OBJECT_ID('U_ECPIMETEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(14) NULL,
    [drvTransactionCode] varchar(1) NOT NULL,
    [drvCustomerNumber] varchar(7) NULL,
    [drvEmployeeSSN] varchar(24) NULL,
    [drvMemberSSN] varchar(24) NULL,
    [drvPersonelID] varchar(1) NOT NULL,
    [drvLastname] varchar(131) NULL,
    [drvFirstname] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvBirthdate] varchar(8000) NULL,
    [drvMaritalstatus] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvRelationship] varchar(2) NOT NULL,
    [drvDateofhire] varchar(8000) NULL,
    [drvStreetaddressI] varchar(255) NULL,
    [drvStreetaddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipcode] varchar(50) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEmployeeworkstatuscode] varchar(1) NULL,
    [drvEmpworkstatuscodeeffdate] varchar(8000) NULL,
    [drvPayfrequency] varchar(2) NULL,
    [drvEmployeesmokerstatus] varchar(1) NOT NULL,
    [drvSpousesmokerstatus] varchar(1) NOT NULL,
    [drvDentalCoverage] varchar(1) NULL,
    [drvCoverageeffectivedateDen] varchar(8000) NULL,
    [drvCoverageenddateDen] varchar(8000) NULL,
    [drvReportgroupnumberDen] varchar(6) NULL,
    [drvSubcodeDen] varchar(4) NULL,
    [drvBranchDen] varchar(4) NULL,
    [drvCoverageStatusDen] varchar(1) NULL,
    [drvMembersCoveredCodeDen] varchar(1) NULL,
    [drvAccidentInsurance] varchar(2) NULL,
    [drvCoverageeffectivedateAcc] varchar(8000) NULL,
    [drvCoverageenddateAcc] varchar(8000) NULL,
    [drvReportgroupnumberAcc] varchar(7) NULL,
    [drvSubcodeAcc] varchar(4) NULL,
    [drvBranchAcc] varchar(4) NULL,
    [drvCoverageStatusAcc] varchar(1) NULL,
    [drvMemberscoveredcodeAcc] varchar(1) NULL,
    [drvEnrollmentstatusAcc] varchar(1) NULL,
    [drvVoluntaryCancelIndicatorAcc] varchar(2) NULL,
    [drvTakeoverIndicatorAcc] varchar(1) NOT NULL,
    [drvEmpCriticalIllsAttainedAge] varchar(2) NULL,
    [drvCoverageeffectivedateEmpCI] varchar(8000) NULL,
    [drvCoverageenddateEmpCI] varchar(8000) NULL,
    [drvReportgroupnumberEmpCI] varchar(6) NULL,
    [drvSubcodeEmpCI] varchar(4) NULL,
    [drvBranchEmpCI] varchar(4) NULL,
    [drvCoverageStatusEmpCI] varchar(1) NULL,
    [drvMemberscoveredcodeEmpCI] varchar(1) NULL,
    [drvEnrollmentstatusEmpCI] varchar(1) NULL,
    [drvBenefitamountEmpCI] varchar(24) NULL,
    [drvVoluntaryCancelIndicatorEmpCI] varchar(2) NULL,
    [drvDepCriticalIllAttainedAge] varchar(2) NULL,
    [drvCoverageeffectivedateDepCI] varchar(8000) NULL,
    [drvCoverageenddateDepCI] varchar(8000) NULL,
    [drvReportgroupnumberDepCI] varchar(7) NULL,
    [drvSubcodeDepCI] varchar(4) NULL,
    [drvBranchDepCI] varchar(4) NULL,
    [drvCoverageStatusDepCI] varchar(1) NULL,
    [drvMemberscoveredcodeDepCI] varchar(1) NULL,
    [drvEnrollmentstatusDepCI] varchar(1) NULL,
    [drvBenefitamountDepCI] varchar(24) NULL,
    [drvVoluntaryCancelIndicatorDepCI] varchar(2) NULL
);

-----------
-- Create table U_ECPIMETEXP_EEList
-----------

IF OBJECT_ID('U_ECPIMETEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ECPIMETEXP_File
-----------

IF OBJECT_ID('U_ECPIMETEXP_File') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);

-----------
-- Create table U_ECPIMETEXP_Header
-----------

IF OBJECT_ID('U_ECPIMETEXP_Header') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_Header] (
    [drvEntityName] varchar(24) NOT NULL,
    [drvDateFileCreated] varchar(8000) NULL,
    [drvChangesonlyInd] varchar(1) NOT NULL
);

-----------
-- Create table U_ECPIMETEXP_Trailer
-----------

IF OBJECT_ID('U_ECPIMETEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECPIMETEXP_Trailer] (
    [drvTotalRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECPIMETEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: ECPI University 

Created By: Marie Waters
Business Analyst: Kim Ephraim
Create Date: 12/13/2022
Service Request Number: TekP-2022-10-31-05

Purpose: MetLife Dent/Accident/Critical Illness Export

Revision History
----------------
Update By           Date           Request Num        Desc
Kim Ephraim        01/24/2023     SR-2022-000XXXXX   update Group Number and Subcode logic to correct details.
Marie Waters       01/25/2023      TekP-2022-10-31-05  Added Payfrequency column and adjusted for updated logic for BranchAcc field.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECPIMETEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECPIMETEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECPIMETEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECPIMETEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECPIMETEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECPIMETEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECPIMETEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECPIMETEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECPIMETEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECPIMETEXP', 'SCH_ECPIME';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECPIMETEXP';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ECPIMETEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(4)
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'ECPIMETEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108),':',SPACE(0))
        ,@FileMinCovDate  = '1/1/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECPIMETEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECPIMETEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


 
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DPPOL,DPPOH,MACCL,MACCH,CIEE1,CIES1,CIEC1,CIEF1,CIEE2,CIES2,CIEC2,CIEF2';

    IF OBJECT_ID('U_ECPIMETEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECPIMETEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECPIMETEXP_DedList
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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECPIMETEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECPIMETEXP_AuditFields;
    CREATE TABLE dbo.U_ECPIMETEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
  -- Employee Information
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpDed','BdmDedCode');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpDed','BdmBenOption');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpDed','EedBdmBenStartDate');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('EmpDed','EedBdmBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('DepBPlan','DbnBdmBenStartDate');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('DepBPlan','DbnBdmBenStopDate');
    -- Deduction/Benefit Information
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('DedCode','DedBenAmt');
    INSERT INTO dbo.U_ECPIMETEXP_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECPIMETEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECPIMETEXP_Audit;
   
   SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('BdmBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBdmBenStartDate','DbnBdmBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBdmBenStopDate','DbnBdmBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTerminated = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' AND ISNULL(audOldValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN 'Y' ELSE 'N' END
        ,audBenAmt = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenAmount' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN audOldValue ELSE audNewValue END
        ,audEEEligDate = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedEEEligDate' AND ISNULL(audOldValue,'') <> ISNULL(audNewValue,'') THEN audOldValue ELSE audNewValue END
    INTO dbo.U_ECPIMETEXP_Audit
    FROM dbo.U_ECPIMETEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ECPIMETEXP_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_ECPIMETEXP_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_ECPIMETEXP_DedList))
    );
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECPIMETEXP_Audit ON dbo.U_ECPIMETEXP_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
     IF (@Exportcode LIKE ('%Changes%'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_ECPIMETEXP_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECPIMETEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1
        AND (audDedChange = 'Y'
        OR audBenOptionChange = 'Y'
        OR audNameChange = 'Y'
        OR audDemoChange = 'Y'
        OR audNewlyEnroll = 'Y'
        OR audTermPlan = 'Y'
        or audTerminated = 'Y')
        );
    END;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECPIMETEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECPIMETEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECPIMETEXP_drvTbl;
   SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvTransactionCode =  CASE BdmRecType
                                 WHEN 'EMP' THEN 'E'
                                 ELSE 'D'
                             END
        ,drvCustomerNumber = CASE WHEN DEN_DedCode IS NOT NULL THEN '0246188'
                                  WHEN SELECT_DedCode IS NOT NULL THEN '9246188'
                                END
        ,drvEmployeeSSN = CASE WHEN (left(eepSSN, 3) IN ('888', '999') or eepSSN ='111111111') THEN '00000000000' ELSE dbo.dsi_fnpadzero(eepSSN,11,0) END
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN  (left(eepSSN, 3) IN ('888', '999') or eepSSN ='111111111') THEN '00000000000' ELSE dbo.dsi_fnpadzero(eepSSN,11,0) END
                            ELSE CASE
                                WHEN BdmRecType = 'DEP' THEN CASE WHEN (left(conSSN, 3) IN ('888', '999') or conSSN ='111111111') THEN '0000000000' ELSE dbo.dsi_fnpadzero(CONSSN,11,0) END
                              END
                              END
        ,drvPersonelID = ''
    
        ,drvLastname = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN Ltrim(Rtrim(EepNameSuffix)) NOT IN ( 'Z') THEN EepNameLast + ' ' +  EepNameSuffix    ELSE EepNameLast END
                            ELSE 
                          CASE WHEN BdmRecType = 'DEP' THEN CASE WHEN Ltrim(Rtrim(ConNameSuffix)) <> 'Z' THEN ConNameLast + ' ' +  ConNameSuffix     ELSE ConNameLast END
                            END
                        END
        ,drvFirstname = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvMiddleInitial = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvBirthdate = REPLACE(CONVERT (CHAR(10),CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END, 101),'/','')
        ,drvMaritalstatus = CASE WHEN BdmRecType = 'EMP'  and ISNULL(EepMaritalStatus, '') NOT IN  ( 'Z' , '') THEN EepMaritalStatus
                                 WHEN BdmRecType = 'EMP'  and ISNULL(EepMaritalStatus, '') In ( 'Z' , '')  THEN 'U' 
                                 When ConRelationship = 'SPS' THEN 'M'ELSE 'S' END



        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvRelationship = CASE WHEN ConRelationship IN ('DP','SPS') THEN '01'
                                WHEN ConRelationship IN ('CHL','STC','DPC','DCH') THEN '02'
                                ELSE '00'
                                END
        ,drvDateofhire = CASE WHEN BdmRecType = 'EMP' THEN REPLACE(CONVERT (CHAR(10),EecDateOfLastHire, 101),'/','') END
        ,drvStreetaddressI = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 END
        ,drvStreetaddress2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 END
        ,drvCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity END
        ,drvState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState END 
        ,drvZipcode = CASE WHEN BdmRecType = 'EMP' THEN  EepAddressZipCode END
        ,drvPhoneNumber = CASE WHEN BdmRecType = 'EMP' THEN EepPhoneHomeNumber END
        ,drvEmailAddress = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail END
        ,drvEmployeeworkstatuscode = CASE When ALL_DedCode IS NOT NULL THEN
                                                 CASE WHEN Eecemplstatus = 'T' AND Eectermreason = '203' THEN 'D' 
                                                      WHEN Eecemplstatus = 'T' AND Eectermreason = '202' THEN 'R'
                                                      WHEN Eecemplstatus = 'T' and Eectermreason NOT IN ( '202', '203') THEN 'T'
                                                      WHEN Eecemplstatus = 'L' THEN 'L'
                                                     ELSE 'A'
                                                    END
                                                END
        ,drvEmpworkstatuscodeeffdate = REPLACE(CONVERT (CHAR(10), CASE WHEN BdmRecType = 'EMP' AND EecEmplStatus = 'T' THEN EecDateOfTermination Else EecEmplStatusStartDate END, 101),'/','')
        ,drvPayfrequency = CASE WHEN PgrPayFrequency ='S' THEN '24'
                                WHEN PgrPayFrequency ='B' THEN '26'
                            END
        ,drvEmployeesmokerstatus = CASE WHEN BdmRecType = 'EMP' AND FAMILL_DedCode  IS NOT NULL AND  EepISSmoker = 'Y' THEN 'S' Else 'N' END
        ,drvSpousesmokerstatus = CASE WHEN BdmRecType = 'DEP' AND ConRelationship IN ('DP','SPS') AND EEILL_DedCode IS NOT NULL AND ConISSmoker = 'Y' THEN 'S' Else 'N' END
        ,drvDentalCoverage = CASE  WHEN  DEN_DedCode IS NOT NULL THEN 'D' END
        ,drvCoverageeffectivedateDen = CASE  WHEN  DEN_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10), dbo.dsi_fnGetMinMaxDates('MAX', DEN_BenStartDate, @FileMinCovDate), 101),'/','') END
        ,drvCoverageenddateDen = CASE  WHEN BdmRecType = 'EMP' AND DEN_DedCode IS NOT NULL THEN  REPLACE(CONVERT (CHAR(10),  DEN_BenStopDate, 101),'/','') 
                                    WHEN BdmRecType = 'DEP' AND DEN_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),  DEN_BenStopDate, 101),'/','') 
                                    END
        ,drvReportgroupnumberDen = CASE  WHEN DEN_DedCode IS NOT NULL THEN  '318620' END
        ,drvSubcodeDen = CASE  WHEN DEN_DedCode IS NOT NULL THEN  '0001' END
        ,drvBranchDen = CASE WHEN DEN_DedCode IN  ('DPPOH') THEN '0001'
                          WHEN DEN_DedCode IN  ('DPPOL') THEN '0002'
                         END
        ,drvCoverageStatusDen = CASE  WHEN DEN_DedCode IS NOT NULL THEN 'A' END
        ,drvMembersCoveredCodeDen = CASE When DEN_DedCode IS NOT NULL THEN 
                                    Case When DEN_BdmBenOption = 'EEONLY' THEN '1'
                                         When DEN_BdmBenOption = 'EECHD'  THEN '2'
                                         When DEN_BdmBenOption = 'EESP'   THEN '3'
                                         When DEN_BdmBenOption = 'EEFAM'  THEN '4'
                                        END
                                    END
        ,drvAccidentInsurance = CASE WHEN  Acc_DedCode IS NOT NULL THEN 'AH' END
        ,drvCoverageeffectivedateAcc = CASE WHEN  Acc_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10), dbo.dsi_fnGetMinMaxDates('MAX', Acc_BenStopDate, @FileMinCovDate), 101),'/','') END
        ,drvCoverageenddateAcc = CASE WHEN  Acc_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),  Acc_BenStopDate, 101),'/','') END
        ,drvReportgroupnumberAcc = CASE WHEN  Acc_DedCode IS NOT NULL THEN '0246474' END ---'AH' END incorrect Group Number. 01242023
        ,drvSubcodeAcc = CASE WHEN  Acc_DedCode IS NOT NULL THEN '0001' END ----'AH' END  --incorrect subcode. KAE 01242023
        ,drvBranchAcc = CASE WHEN  MACCL_DedCode IS NOT NULL THEN '0001' 
                             WHEN  MACCH_DedCode IS NOT NULL THEN '0003' END
        ,drvCoverageStatusAcc = CASE WHEN  Acc_DedCode IS NOT NULL THEN 'A' END
        ,drvMemberscoveredcodeAcc = CASE WHEN  Acc_DedCode IS NOT NULL THEN 
                                    Case When Acc_BdmBenOption = 'EEONLY' THEN '1'
                                         When Acc_BdmBenOption = 'EECHD'  THEN '2'
                                         When Acc_BdmBenOption = 'EESP'   THEN '3'
                                         When Acc_BdmBenOption = 'EEFAM'  THEN '4'
                                        END
                                    END
        ,drvEnrollmentstatusAcc = CASE WHEN  Acc_DedCode IS NOT NULL THEN 'P' END
        ,drvVoluntaryCancelIndicatorAcc = CASE WHEN BdmRecType = 'EMP' AND eecemplstatus = 'A' AND Acc_DedCode IS NOT NULL AND Acc_Bdmbenstatus <> 'A' THEN 'CE' END
        ,drvTakeoverIndicatorAcc =  ''
        ,drvEmpCriticalIllsAttainedAge = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN 'GE' END
        ,drvCoverageeffectivedateEmpCI =  CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10), dbo.dsi_fnGetMinMaxDates('MAX', EEILL_BenStartDate, @FileMinCovDate), 101),'/','') END
        ,drvCoverageenddateEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),  EEILL_BenStopDate, 101),'/','')  END
        ,drvReportgroupnumberEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN '246475' END
        ,drvSubcodeEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL  THEN '0001' END
        ,drvBranchEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN '0001' END
        ,drvCoverageStatusEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN 'A' END
        ,drvMemberscoveredcodeEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL AND EEILL_BdmBenOption = 'EEONLY' Then '1' END
        ,drvEnrollmentstatusEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN 'P' END
        ,drvBenefitamountEmpCI = CASE WHEN BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(REPLACE( BcaBenAmtCalcCI,'.', ''),0)),9,0) END
                                
        ,drvVoluntaryCancelIndicatorEmpCI = CASE WHEN eecemplstatus = 'A'  AND BdmRecType = 'EMP' AND EEILL_DedCode IS NOT NULL AND EEILL_Bdmbenstatus <> 'A' THEN 'CE' END
        ,drvDepCriticalIllAttainedAge = CASE WHEN FAMILL_DedCode IS NOT NULL  THEN 'GD' END
        ,drvCoverageeffectivedateDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10), dbo.dsi_fnGetMinMaxDates('MAX',  FAMILL_BenStartDate, @FileMinCovDate), 101),'/','') END
        ,drvCoverageenddateDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN REPLACE(CONVERT (CHAR(10),  FAMILL_BenStopDate, 101),'/','')  END
        ,drvReportgroupnumberDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN '0246475' END
        ,drvSubcodeDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN '0001' END
        ,drvBranchDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN '0001' END
        ,drvCoverageStatusDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN 'A' END
        ,drvMemberscoveredcodeDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL  AND FAMILL_BdmBenOption = 'EEFAM' THEN '4' END
        ,drvEnrollmentstatusDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN 'P' END
        ,drvBenefitamountDepCI = CASE WHEN FAMILL_DedCode IS NOT NULL THEN dbo.dsi_fnpadzero((ISNULL(REPLACE( BcaBenAmtCalcCD,'.', ''),0)),9,0) END
        ,drvVoluntaryCancelIndicatorDepCI = CASE WHEN eecemplstatus = 'A'  AND FAMILL_DedCode IS NOT NULL AND FAMILL_BdmBenStatus <> 'A' THEN 'CE' END
    INTO dbo.U_ECPIMETEXP_drvTbl
    FROM dbo.U_ECPIMETEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    JOIN (
            SELECT Distinct Bdmeeid AS BdmEEID, BdmCOID AS BdmCOID, BdmRecType, BdmDepRecId
                ,MAX(CASE WHEN BdmDedCode IN ('CIEE1','CIEE2')  THEN BdmDedCode END) AS EEILL_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH')  THEN BdmDedCode END) AS DEN_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH')  THEN BdmDedCode END) AS Acc_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL')  THEN BdmDedCode END) AS MACCL_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MACCH')  THEN BdmDedCode END) AS MACCH_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2')   THEN BdmDedCode END) AS FAMILL_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH','MACCL','MACCH','CIEE1','CIEE2','CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2') THEN BdmDedCode END) AS ALL_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH','CIEE1','CIEE2','CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2') THEN BdmDedCode END) AS SELECT_DedCode

                ,MAX(CASE WHEN BdmDedCode IN ('CIEE1','CIEE2')  THEN BdmBenStartDate END) AS EEILL_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH')  THEN BdmBenStartDate END) AS DEN_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH')  THEN BdmBenStartDate END) AS Acc_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2')  THEN BdmBenStartDate END) AS FAMILL_BenStartDate

                ,MAX(CASE WHEN BdmDedCode IN ('CIEE1','CIEE2') THEN BdmBenStopDate END) AS EEILL_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH') THEN BdmBenStopDate END) AS DEN_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH') THEN BdmBenStopDate END) AS Acc_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2')   THEN BdmBenStopDate END) AS FAMILL_BenStopDate
                
                ,MAX(CASE WHEN BdmDedCode IN ('CIEE1','CIEE2') THEN Left(Replace((DedBenAmtRateOrPct * .10),'.', ''),5) END) AS EEILL_BdmEECalcRateOrPct
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH') THEN Left(Replace((DedBenAmtRateOrPct  * .10),'.', ''),5) END) AS DEN_BdmEECalcRateOrPct
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH') THEN Left(Replace((DedBenAmtRateOrPct  * .10),'.', ''),5) END) AS Acc_BdmEECalcRateOrPct
                ,MAX(CASE WHEN BdmDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2')  THEN Left(Replace((d.DedEECalcRateOrPct ),'.', ''),5) END) AS FAMILL_BdmEECalcRateOrPct

                ,MAX(CASE WHEN BdmDedCode IN ('CIEE1','CIEE2') THEN BdmBenStatus END) AS EEILL_BdmBenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH') THEN BdmBenStatus END) AS DEN_BdmBenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH') THEN BdmBenStatus END) AS Acc_BdmBenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2') THEN BdmBenStatus END) AS FAMILL_BdmBenStatus

                ,MAX(CASE WHEN BdmDedCode IN ('CIEE1','CIEE2') THEN BdmBenOption END) AS EEILL_BdmBenOption
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH') THEN BdmBenOption END) AS DEN_BdmBenOption
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH') THEN BdmBenOption END) AS Acc_BdmBenOption
                ,MAX(CASE WHEN BdmDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2') THEN BdmBenOption END) AS FAMILL_BdmBenOption

                ,MAX(CASE WHEN BdmDedCode IN ('CIEE1','CIEE2')THEN BdmEEAmt  END)  AS EEILL_BdmBenAmt
                ,MAX(CASE WHEN BdmDedCode IN ('DPPOL','DPPOH')   THEN BdmEEAmt END) AS DEN_BdmBenAmt
                ,MAX(CASE WHEN BdmDedCode IN ('MACCL','MACCH')  THEN BdmEEAmt END) AS Acc_BdmBenAmt
               
                ,MAX(CASE WHEN BdmDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2')  THEN BdmEEAmt END) AS FAMILL_EEAmt    
         FROM dbo.U_dsi_BDM_ECPIMETEXP WITH (NOLOCK)
         JOIN dbo.DedCode d WITH (NOLOCK)
             ON BdmDedCode = d.DedDedCode
            Where  BdmBenStatus = 'A'
            GROUP BY BdmEEID, BdmCOID, BdmRecType, BdmDepRecId
            ) BDM
         ON BdmEEID = XEEID
         and BdmCOID = XCOID
    --JOIN dbo.U_dsi_BDM_ECPIMETEXP WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
   LEFT JOIN (SELECT BcaEEID, BcaCOID, SUM(BcaBenAmtCalc) AS BcaBenAmtCalcCI
                FROM dbo.U_dsi_bdm_BenCalculationAmounts WITH(NOLOCK)
                WHERE BcaDedCode IN ('CIEE1','CIEE2')
                and BcaFormatCode ='ECPIMETEXP'
                GROUP BY BcaEEID, BcaCOID) CI ON CI.BcaEEID = xEEID AND CI.BcaCOID = xCOID
   LEFT JOIN (SELECT BcaEEID, BcaCOID, SUM(BcaBenAmtCalc) AS BcaBenAmtCalcCD
                    FROM dbo.U_dsi_bdm_BenCalculationAmounts WITH(NOLOCK)
                    WHERE BcaDedCode IN ('CIEF1','CIEF2','CIES1','CIES2','CIEC1','CIEC2')
                    and BcaFormatCode ='ECPIMETEXP'
                    GROUP BY BcaEEID, BcaCOID) CD ON CD.BcaEEID = xEEID AND CD.BcaCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON xEEID = ConEEID
      AND BdmDepRecId = ConSystemId
    LEFT JOIN dbo.U_ECPIMETEXP_Audit  WITH (NOLOCK)
        ON AudEEID = XEEID
        and AudCOID = XCOID
    Where EecEEType <> 'TES' and (EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' and audTerminated = 'Y'AND AudDateTime BETWEEN  @StartDate  AND @EndDate  ))
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECPIMETEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ECPIMETEXP_Header;
    SELECT DISTINCT
         drvEntityName = 'Novateur Education, Inc.'
        ,drvDateFileCreated = REPLACE(CONVERT (CHAR(10),@RunDate, 101),'/','')
        ,drvChangesonlyInd = CASE WHEN (@Exportcode LIKE ('%Changes%')) THEN 'Y' ELSE 'N' END
    INTO dbo.U_ECPIMETEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ECPIMETEXP_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECPIMETEXP_Trailer;
    SELECT DISTINCT
         drvTotalRecordCount = (Select count(*) from dbo.U_ECPIMETEXP_drvTbl)
    INTO dbo.U_ECPIMETEXP_Trailer
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
ALTER VIEW dbo.dsi_vwECPIMETEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECPIMETEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ECPIMETEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301011'
       ,expStartPerControl     = '202301011'
       ,expLastEndPerControl   = '202301099'
       ,expEndPerControl       = '202301099'
WHERE expFormatCode = 'ECPIMETEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECPIMETEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECPIMETEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ECPIMETEXP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ECPIMETEXP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ECPIMETEXP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECPIMETEXP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ECPIMETEXP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ECPIMETEXP', 'UseFileName', 'V', 'Y'


-- End ripout