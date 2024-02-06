/**********************************************************************************

EMETLIFONE: MetLife One Export

FormatCode:     EMETLIFONE
Project:        MetLife One Export
Client ID:      MET1011
Date/time:      2024-02-02 15:58:28.723
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP4DB03
Database:       ULTIPRO_WPMETRF
Web Filename:   MET1011_C80A2_EEHISTORY_EMETLIFONE_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EMETLIFONE_SavePath') IS NOT NULL DROP TABLE dbo.U_EMETLIFONE_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EMETLIFONE'


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
WHERE FormatCode = 'EMETLIFONE'
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
WHERE ExpFormatCode = 'EMETLIFONE'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EMETLIFONE')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EMETLIFONE'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EMETLIFONE'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EMETLIFONE'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EMETLIFONE'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EMETLIFONE'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EMETLIFONE'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EMETLIFONE'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EMETLIFONE'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EMETLIFONE'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEMETLIFONE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMETLIFONE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMETLIFONE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFONE];
GO
IF OBJECT_ID('U_EMETLIFONE_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_Trailer];
GO
IF OBJECT_ID('U_EMETLIFONE_Header') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_Header];
GO
IF OBJECT_ID('U_EMETLIFONE_File') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_File];
GO
IF OBJECT_ID('U_EMETLIFONE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_EEList];
GO
IF OBJECT_ID('U_EMETLIFONE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_drvTbl];
GO
IF OBJECT_ID('U_EMETLIFONE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_DedList];
GO
IF OBJECT_ID('U_EMETLIFONE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_AuditFields];
GO
IF OBJECT_ID('U_EMETLIFONE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMETLIFONE_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMETLIFONE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMETLIFONE];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMETLIFONE','MetLife One Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EMETLIFONEZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMETLIFONEZ0','1','H','01','1',NULL,'Record Type',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMETLIFONEZ0','50','H','01','2',NULL,'Entity Name',NULL,NULL,'"drvEnitityName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMETLIFONEZ0','8','H','01','52',NULL,'Date File Created',NULL,NULL,'"drvDateFileCreated"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMETLIFONEZ0','1','H','01','60',NULL,'Changes Only Indicator',NULL,NULL,'"drvChangesOnlyInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMETLIFONEZ0','1','D','10','1',NULL,'Transaction Code',NULL,NULL,'"drvTransactiionCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMETLIFONEZ0','7','D','10','2',NULL,'Customer Number',NULL,NULL,'"drvCustomerNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EMETLIFONEZ0','11','D','10','9',NULL,'Employee SSN',NULL,NULL,'"drvEmpSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EMETLIFONEZ0','11','D','10','20',NULL,'Member SSN',NULL,NULL,'"drvMemberSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EMETLIFONEZ0','9','D','10','31',NULL,'Personel ID',NULL,NULL,'"drvPersonelID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EMETLIFONEZ0','20','D','10','40',NULL,'Last name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EMETLIFONEZ0','12','D','10','60',NULL,'First name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EMETLIFONEZ0','1','D','10','72',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EMETLIFONEZ0','8','D','10','73',NULL,'Birth date',NULL,NULL,'"drvDateofBirth"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EMETLIFONEZ0','1','D','10','81',NULL,'Marital status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EMETLIFONEZ0','1','D','10','82',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EMETLIFONEZ0','2','D','10','83',NULL,'Relationship',NULL,NULL,'"drvRealationship"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EMETLIFONEZ0','8','D','10','85',NULL,'Date of hire',NULL,NULL,'"drvDateofHire"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EMETLIFONEZ0','1','D','10','93',NULL,'Foreign address indicator',NULL,NULL,'"drvForeignAddressInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EMETLIFONEZ0','32','D','10','94',NULL,'Street address I',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EMETLIFONEZ0','32','D','10','126',NULL,'Street address II',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EMETLIFONEZ0','21','D','10','158',NULL,'City',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EMETLIFONEZ0','2','D','10','179',NULL,'State',NULL,NULL,'"drvAddressState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EMETLIFONEZ0','9','D','10','181',NULL,'Zip code',NULL,NULL,'"drvAddressZipCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EMETLIFONEZ0','3','D','10','190',NULL,'Country code',NULL,NULL,'"drvCountryCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EMETLIFONEZ0','2','D','10','193',NULL,'Employee work state',NULL,NULL,'"drvWorkState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EMETLIFONEZ0','10','D','10','195',NULL,'Phone Number',NULL,NULL,'"drvPhoneNumber"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EMETLIFONEZ0','40','D','10','205',NULL,'Email Address',NULL,NULL,'"drvEmailAddress"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EMETLIFONEZ0','9','D','10','245',NULL,'Salary',NULL,NULL,'"drvSalary"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EMETLIFONEZ0','1','D','10','254',NULL,'Salary Mode',NULL,NULL,'"drvSalaryMode"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EMETLIFONEZ0','8','D','10','255',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffectiveDate"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EMETLIFONEZ0','1','D','10','263',NULL,'Employee [work] status code',NULL,NULL,'"drvWorkStatusCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EMETLIFONEZ0','8','D','10','264',NULL,'Employee [work] status code effective date',NULL,NULL,'"drvWorkStatusCodeEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EMETLIFONEZ0','1','D','10','272',NULL,'Federal Marital Tax Code',NULL,NULL,'"drvMaritalTaxCode"','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EMETLIFONEZ0','10','D','10','273',NULL,'Department',NULL,NULL,'"drvDepartment"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EMETLIFONEZ0','10','D','10','283',NULL,'Group ID',NULL,NULL,'"drvGroupID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EMETLIFONEZ0','5','D','10','293',NULL,'Location ID',NULL,NULL,'"drvLocationID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EMETLIFONEZ0','10','D','10','298',NULL,'Schedule ID',NULL,NULL,'"drvScheduleID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EMETLIFONEZ0','2','D','10','308',NULL,'Pay frequency',NULL,NULL,'"drvPayFrequency"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EMETLIFONEZ0','1','D','10','310',NULL,'Employee smoker status',NULL,NULL,'"drvEmpSmokerStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EMETLIFONEZ0','1','D','10','311',NULL,'Spouse smoker status',NULL,NULL,'"drvSpSmorkerStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EMETLIFONEZ0','1','D','10','312',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EMETLIFONEZ0','1','D','10','313',NULL,'Handicapped dependent indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EMETLIFONEZ0','30','D','10','314',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EMETLIFONEZ0','1','D','10','344',NULL,'Dental Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EMETLIFONEZ0','8','D','10','345',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EMETLIFONEZ0','8','D','10','353',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EMETLIFONEZ0','7','D','10','361',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EMETLIFONEZ0','4','D','10','368',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EMETLIFONEZ0','4','D','10','372',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EMETLIFONEZ0','2','D','10','376',NULL,'Plan code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EMETLIFONEZ0','1','D','10','378',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EMETLIFONEZ0','1','D','10','379',NULL,'Members Covered Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EMETLIFONEZ0','2','D','10','380',NULL,'COBRA indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EMETLIFONEZ0','1','D','10','382',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EMETLIFONEZ0','8','D','10','383',NULL,'Facility ID',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EMETLIFONEZ0','2','D','10','391',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EMETLIFONEZ0','1','D','10','393',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EMETLIFONEZ0','20','D','10','394',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EMETLIFONEZ0','2','D','10','414',NULL,'Vision Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EMETLIFONEZ0','8','D','10','416',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EMETLIFONEZ0','8','D','10','424',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EMETLIFONEZ0','7','D','10','432',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EMETLIFONEZ0','4','D','10','429',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EMETLIFONEZ0','4','D','10','443',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EMETLIFONEZ0','1','D','10','447',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EMETLIFONEZ0','1','D','10','448',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EMETLIFONEZ0','2','D','10','449',NULL,'COBRA indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EMETLIFONEZ0','1','D','10','451',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EMETLIFONEZ0','20','D','10','452',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EMETLIFONEZ0','2','D','10','472',NULL,'Short Term Disability Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EMETLIFONEZ0','8','D','10','474',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EMETLIFONEZ0','8','D','10','482',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EMETLIFONEZ0','7','D','10','490',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EMETLIFONEZ0','4','D','10','497',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EMETLIFONEZ0','4','D','10','501',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EMETLIFONEZ0','1','D','10','505',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EMETLIFONEZ0','1','D','10','506',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EMETLIFONEZ0','1','D','10','507',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EMETLIFONEZ0','1','D','10','508',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EMETLIFONEZ0','8','D','10','509',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EMETLIFONEZ0','1','D','10','517',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EMETLIFONEZ0','7','D','10','518',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EMETLIFONEZ0','4','D','10','525',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EMETLIFONEZ0','1','D','10','529',NULL,'STD Contributory Plan Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EMETLIFONEZ0','3','D','10','530',NULL,'STD Contributory Plan Percentage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EMETLIFONEZ0','3','D','10','533',NULL,'STD Contributory Pre-tax Percentage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EMETLIFONEZ0','20','D','10','536',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EMETLIFONEZ0','2','D','10','556',NULL,'Long Term Disability Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EMETLIFONEZ0','8','D','10','558',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EMETLIFONEZ0','8','D','10','566',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EMETLIFONEZ0','7','D','10','574',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EMETLIFONEZ0','4','D','10','581',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EMETLIFONEZ0','4','D','10','585',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EMETLIFONEZ0','1','D','10','589',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EMETLIFONEZ0','1','D','10','590',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EMETLIFONEZ0','1','D','10','591',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EMETLIFONEZ0','1','D','10','592',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EMETLIFONEZ0','8','D','10','593',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EMETLIFONEZ0','1','D','10','601',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EMETLIFONEZ0','7','D','10','602',NULL,'Salary',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EMETLIFONEZ0','4','D','10','609',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EMETLIFONEZ0','1','D','10','613',NULL,'LTD Contributory Plan Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EMETLIFONEZ0','3','D','10','614',NULL,'LTD Contributory Plan Percentage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EMETLIFONEZ0','3','D','10','617',NULL,'LTD Contributory Pre-tax Percentage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EMETLIFONEZ0','658','D','10','620',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EMETLIFONEZ0','2','D','10','1278',NULL,'Auto & Home',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EMETLIFONEZ0','8','D','10','1280',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EMETLIFONEZ0','8','D','10','1288',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EMETLIFONEZ0','7','D','10','1296',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EMETLIFONEZ0','4','D','10','1303',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EMETLIFONEZ0','4','D','10','1307',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EMETLIFONEZ0','1','D','10','1311',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EMETLIFONEZ0','1','D','10','1312',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EMETLIFONEZ0','1','D','10','1313',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EMETLIFONEZ0','3','D','10','1314',NULL,'GPC code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EMETLIFONEZ0','2','D','10','1317',NULL,'Paypoint',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EMETLIFONEZ0','3','D','10','1319',NULL,'Payroll deduction',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EMETLIFONEZ0','10','D','10','1322',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EMETLIFONEZ0','2','D','10','1332',NULL,'Pet coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EMETLIFONEZ0','8','D','10','1334',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EMETLIFONEZ0','8','D','10','1342',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EMETLIFONEZ0','7','D','10','1350',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EMETLIFONEZ0','4','D','10','1357',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EMETLIFONEZ0','4','D','10','1361',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EMETLIFONEZ0','1','D','10','1365',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EMETLIFONEZ0','1','D','10','1366',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EMETLIFONEZ0','1','D','10','1367',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EMETLIFONEZ0','10','D','10','1368',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EMETLIFONEZ0','2','D','10','1378',NULL,'MetLife Legal Plans',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EMETLIFONEZ0','8','D','10','1380',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EMETLIFONEZ0','8','D','10','1388',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EMETLIFONEZ0','7','D','10','1396',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EMETLIFONEZ0','4','D','10','1403',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EMETLIFONEZ0','4','D','10','1407',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EMETLIFONEZ0','1','D','10','1411',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EMETLIFONEZ0','1','D','10','1412',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EMETLIFONEZ0','1','D','10','1413',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EMETLIFONEZ0','10','D','10','1414',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EMETLIFONEZ0','2','D','10','1424',NULL,'Accident Insurance',NULL,NULL,'"drvAccidentIns"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EMETLIFONEZ0','8','D','10','1426',NULL,'Coverage effective date',NULL,NULL,'"drvAccCovEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EMETLIFONEZ0','8','D','10','1434',NULL,'Coverage end date',NULL,NULL,'"drvAccCovEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EMETLIFONEZ0','7','D','10','1442',NULL,'Report/group number',NULL,NULL,'"drvAccGroupNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EMETLIFONEZ0','4','D','10','1449',NULL,'Subcode',NULL,NULL,'"drvAccSubcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EMETLIFONEZ0','4','D','10','1453',NULL,'Branch',NULL,NULL,'"drvAccBranch"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EMETLIFONEZ0','1','D','10','1457',NULL,'Coverage Status',NULL,NULL,'"drvAccCovStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EMETLIFONEZ0','1','D','10','1458',NULL,'Members covered code',NULL,NULL,'"drvAccMemberCovCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EMETLIFONEZ0','1','D','10','1459',NULL,'Enrollment status',NULL,NULL,'"drvAccEnrollStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EMETLIFONEZ0','2','D','10','1460',NULL,'Voluntary Cancel Indicator',NULL,NULL,'"drvAccVolCancelInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EMETLIFONEZ0','1','D','10','1462',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EMETLIFONEZ0','19','D','10','1463',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EMETLIFONEZ0','2','D','10','1482',NULL,'Hospital Indemnity',NULL,NULL,'"drvHospitalIndemnity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EMETLIFONEZ0','8','D','10','1484',NULL,'Coverage effective date',NULL,NULL,'"drvHospCovEffDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EMETLIFONEZ0','8','D','10','1492',NULL,'Coverage end date',NULL,NULL,'"drvHospCovEndDate"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EMETLIFONEZ0','7','D','10','1500',NULL,'Report/group number',NULL,NULL,'"drvHospgroupNum"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EMETLIFONEZ0','4','D','10','1507',NULL,'Subcode',NULL,NULL,'"drvHospSubcode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EMETLIFONEZ0','4','D','10','1511',NULL,'Branch',NULL,NULL,'"drvHospBranch"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EMETLIFONEZ0','1','D','10','1515',NULL,'Coverage Status',NULL,NULL,'"drvHospCoverageStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EMETLIFONEZ0','1','D','10','1516',NULL,'Members covered code',NULL,NULL,'"drvHospCemEveD"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EMETLIFONEZ0','1','D','10','1517',NULL,'Enrollment status',NULL,NULL,'"drvHospEnrollmentstatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EMETLIFONEZ0','2','D','10','1518',NULL,'Voluntary Cancel Indicator',NULL,NULL,'"drvHospVolCancelInd"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EMETLIFONEZ0','1','D','10','1520',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EMETLIFONEZ0','19','D','10','1521',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EMETLIFONEZ0','2','D','10','1540',NULL,'Employee Critical Illness Attained Age',NULL,NULL,'"drvCrillEmpAttainedIge"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EMETLIFONEZ0','8','D','10','1542',NULL,'Coverage effective date',NULL,NULL,'"drvCrillCovEffDateEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EMETLIFONEZ0','8','D','10','1550',NULL,'Coverage end date',NULL,NULL,'"drvCrillCovEndDateEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EMETLIFONEZ0','7','D','10','1558',NULL,'Report/group number',NULL,NULL,'"drvCrillgroupNumEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EMETLIFONEZ0','4','D','10','1565',NULL,'Subcode',NULL,NULL,'"drvCrillSubcodeEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EMETLIFONEZ0','4','D','10','1569',NULL,'Branch',NULL,NULL,'"drvCrillBranchEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EMETLIFONEZ0','1','D','10','1573',NULL,'Coverage Status',NULL,NULL,'"drvCrillCoverageStatusEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EMETLIFONEZ0','1','D','10','1574',NULL,'Members covered code',NULL,NULL,'"drvCrillMembCovCodeEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EMETLIFONEZ0','1','D','10','1575',NULL,'Enrollment status',NULL,NULL,'"drvCrillEnrollmentstatusEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EMETLIFONEZ0','8','D','10','1576',NULL,'Benefit amount',NULL,NULL,'"drvCrillBenefitamountEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EMETLIFONEZ0','2','D','10','1584',NULL,'Voluntary Cancel Indicator',NULL,NULL,'"drvCrillVolCancelIndEmp"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EMETLIFONEZ0','1','D','10','1586',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EMETLIFONEZ0','19','D','10','1587',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EMETLIFONEZ0','2','D','10','1606',NULL,'Dependent Critical Illness Attained Age',NULL,NULL,'"drvCrillDepAttainedIge"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EMETLIFONEZ0','8','D','10','1608',NULL,'Coverage effective date',NULL,NULL,'"drvCrillCovEffDateDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EMETLIFONEZ0','8','D','10','1616',NULL,'Coverage end date',NULL,NULL,'"drvCrillCovEndDateDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EMETLIFONEZ0','7','D','10','1624',NULL,'Report/group number',NULL,NULL,'"drvCrillgroupNumDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EMETLIFONEZ0','4','D','10','1631',NULL,'Subcode',NULL,NULL,'"drvCrillSubcodeDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EMETLIFONEZ0','4','D','10','1635',NULL,'Branch',NULL,NULL,'"drvCrillBranchDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EMETLIFONEZ0','1','D','10','1639',NULL,'Coverage Status',NULL,NULL,'"drvCrillCoverageStatusDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EMETLIFONEZ0','1','D','10','1640',NULL,'Members covered code',NULL,NULL,'"drvCrillMembCovCodeDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EMETLIFONEZ0','1','D','10','1641',NULL,'Enrollment status',NULL,NULL,'"drvCrillEnrollmentstatusDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EMETLIFONEZ0','8','D','10','1642',NULL,'Benefit amount',NULL,NULL,'"drvCrillBenefitamountDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EMETLIFONEZ0','2','D','10','1650',NULL,'Voluntary Cancel Indicator',NULL,NULL,'"drvCrillVolCancelIndDep"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EMETLIFONEZ0','1','D','10','1652',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EMETLIFONEZ0','19','D','10','1653',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EMETLIFONEZ0','2','D','10','1672',NULL,'Employee Critical Illness Level Funded',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EMETLIFONEZ0','8','D','10','1674',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EMETLIFONEZ0','8','D','10','1682',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EMETLIFONEZ0','7','D','10','1690',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EMETLIFONEZ0','4','D','10','1697',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EMETLIFONEZ0','4','D','10','1701',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EMETLIFONEZ0','1','D','10','1705',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EMETLIFONEZ0','1','D','10','1706',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EMETLIFONEZ0','1','D','10','1707',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EMETLIFONEZ0','8','D','10','1708',NULL,'Benefit amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EMETLIFONEZ0','2','D','10','1716',NULL,'Voluntary Cancel Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EMETLIFONEZ0','1','D','10','1718',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EMETLIFONEZ0','19','D','10','1719',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EMETLIFONEZ0','2','D','10','1738',NULL,'Dependent Critical Illness Level Funded',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EMETLIFONEZ0','8','D','10','1740',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EMETLIFONEZ0','8','D','10','1748',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EMETLIFONEZ0','7','D','10','1756',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EMETLIFONEZ0','4','D','10','1763',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EMETLIFONEZ0','4','D','10','1767',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EMETLIFONEZ0','1','D','10','1771',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EMETLIFONEZ0','1','D','10','1772',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EMETLIFONEZ0','1','D','10','1773',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EMETLIFONEZ0','8','D','10','1774',NULL,'Benefit amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EMETLIFONEZ0','2','D','10','1782',NULL,'Voluntary Cancel Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EMETLIFONEZ0','1','D','10','1784',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EMETLIFONEZ0','19','D','10','1785',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EMETLIFONEZ0','2','D','10','1804',NULL,'Employee Critical Illness Cancer',NULL,NULL,'"drvEmpCancer"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EMETLIFONEZ0','8','D','10','1806',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EMETLIFONEZ0','8','D','10','1814',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EMETLIFONEZ0','7','D','10','1822',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EMETLIFONEZ0','4','D','10','1829',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EMETLIFONEZ0','4','D','10','1833',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EMETLIFONEZ0','1','D','10','1837',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EMETLIFONEZ0','1','D','10','1838',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EMETLIFONEZ0','1','D','10','1839',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EMETLIFONEZ0','8','D','10','1840',NULL,'Benefit amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EMETLIFONEZ0','2','D','10','1848',NULL,'Voluntary Cancel Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EMETLIFONEZ0','1','D','10','1850',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EMETLIFONEZ0','19','D','10','1851',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EMETLIFONEZ0','2','D','10','1870',NULL,'Dependent Critical Illness Cancer',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EMETLIFONEZ0','8','D','10','1872',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EMETLIFONEZ0','8','D','10','1880',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EMETLIFONEZ0','7','D','10','1888',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EMETLIFONEZ0','4','D','10','1895',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EMETLIFONEZ0','4','D','10','1899',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EMETLIFONEZ0','1','D','10','1903',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EMETLIFONEZ0','1','D','10','1904',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EMETLIFONEZ0','1','D','10','1905',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EMETLIFONEZ0','8','D','10','1906',NULL,'Benefit amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EMETLIFONEZ0','2','D','10','1914',NULL,'Voluntary Cancel Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EMETLIFONEZ0','1','D','10','1916',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EMETLIFONEZ0','19','D','10','1917',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EMETLIFONEZ0','2','D','10','1936',NULL,'Worksite Short Term Disability Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EMETLIFONEZ0','8','D','10','1938',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EMETLIFONEZ0','8','D','10','1946',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EMETLIFONEZ0','7','D','10','1954',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EMETLIFONEZ0','4','D','10','1961',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EMETLIFONEZ0','4','D','10','1965',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EMETLIFONEZ0','1','D','10','1969',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EMETLIFONEZ0','1','D','10','1970',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EMETLIFONEZ0','8','D','10','1971',NULL,'Benefit amount',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EMETLIFONEZ0','1','D','10','1979',NULL,'Takeover Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EMETLIFONEZ0','2','D','10','1980',NULL,'Voluntary Cancel Indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EMETLIFONEZ0','20','D','10','1982',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EMETLIFONEZ0','2','D','10','2002',NULL,'NY Paid Family Leave Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EMETLIFONEZ0','8','D','10','2004',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EMETLIFONEZ0','8','D','10','2012',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','EMETLIFONEZ0','7','D','10','2020',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','EMETLIFONEZ0','4','D','10','2027',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','EMETLIFONEZ0','4','D','10','2031',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','EMETLIFONEZ0','1','D','10','2035',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','EMETLIFONEZ0','1','D','10','2036',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','EMETLIFONEZ0','1','D','10','2037',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','EMETLIFONEZ0','20','D','10','2038',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','EMETLIFONEZ0','1','D','10','2058',NULL,'Job Status Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','EMETLIFONEZ0','8','D','10','2059',NULL,'Job Status (full time/part time) As of Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','EMETLIFONEZ0','2','D','10','2067',NULL,'Number of Federal Exemptions',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','EMETLIFONEZ0','3','D','10','2069',NULL,'Average Weekly Scheduled Work Hours',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','EMETLIFONEZ0','2','D','10','2073',NULL,'Wrk Wk Schedule',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','EMETLIFONEZ0','20','D','10','2074',NULL,'FILLER',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','EMETLIFONEZ0','2','D','10','2094',NULL,'Paid Family Leave Coverage Code',NULL,NULL,'"drvPaidFMLACovCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','EMETLIFONEZ0','8','D','10','2096',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','EMETLIFONEZ0','8','D','10','2104',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','EMETLIFONEZ0','7','D','10','2112',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','EMETLIFONEZ0','4','D','10','2119',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','EMETLIFONEZ0','4','D','10','2123',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','EMETLIFONEZ0','1','D','10','2127',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','EMETLIFONEZ0','1','D','10','2128',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','EMETLIFONEZ0','1','D','10','2129',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','EMETLIFONEZ0','20','D','10','2130',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','EMETLIFONEZ0','2','D','10','2150',NULL,'Paid Medical Leave Coverage Code',NULL,NULL,'"drvPaidMEDLACovCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','EMETLIFONEZ0','8','D','10','2152',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','EMETLIFONEZ0','8','D','10','2160',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','EMETLIFONEZ0','7','D','10','2168',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','EMETLIFONEZ0','4','D','10','2175',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','EMETLIFONEZ0','4','D','10','2179',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','EMETLIFONEZ0','1','D','10','2183',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','EMETLIFONEZ0','1','D','10','2184',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','EMETLIFONEZ0','1','D','10','2185',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','EMETLIFONEZ0','20','D','10','2186',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','EMETLIFONEZ0','2','D','10','2206',NULL,'Whole Life',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','EMETLIFONEZ0','8','D','10','2208',NULL,'Earliest Certificate effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','EMETLIFONEZ0','8','D','10','2216',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','EMETLIFONEZ0','7','D','10','2224',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','EMETLIFONEZ0','4','D','10','2231',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','EMETLIFONEZ0','4','D','10','2235',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','EMETLIFONEZ0','1','D','10','2239',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','EMETLIFONEZ0','1','D','10','2240',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('293','EMETLIFONEZ0','1','D','10','2241',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('294','EMETLIFONEZ0','9','D','10','2242',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('295','EMETLIFONEZ0','2','D','10','2251',NULL,'Vision Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('296','EMETLIFONEZ0','8','D','10','2253',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('297','EMETLIFONEZ0','8','D','10','2261',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('298','EMETLIFONEZ0','7','D','10','2269',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('299','EMETLIFONEZ0','4','D','10','2276',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('300','EMETLIFONEZ0','4','D','10','2280',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('301','EMETLIFONEZ0','1','D','10','2284',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('302','EMETLIFONEZ0','1','D','10','2285',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('303','EMETLIFONEZ0','2','D','10','2286',NULL,'COBRA indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('304','EMETLIFONEZ0','1','D','10','2288',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('305','EMETLIFONEZ0','20','D','10','2289',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('306','EMETLIFONEZ0','2','D','10','2309',NULL,'Vision Coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('307','EMETLIFONEZ0','8','D','10','2311',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('308','EMETLIFONEZ0','8','D','10','2319',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('309','EMETLIFONEZ0','7','D','10','2327',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('310','EMETLIFONEZ0','4','D','10','2334',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('311','EMETLIFONEZ0','4','D','10','2338',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('312','EMETLIFONEZ0','1','D','10','2342',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('313','EMETLIFONEZ0','1','D','10','2343',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('314','EMETLIFONEZ0','2','D','10','2344',NULL,'COBRA indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('315','EMETLIFONEZ0','1','D','10','2346',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('316','EMETLIFONEZ0','20','D','10','2347',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('317','EMETLIFONEZ0','2','D','10','2367',NULL,'Aura coverage',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('318','EMETLIFONEZ0','8','D','10','2369',NULL,'Coverage effective date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('319','EMETLIFONEZ0','8','D','10','2377',NULL,'Coverage end date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('320','EMETLIFONEZ0','7','D','10','2385',NULL,'Report/group number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('321','EMETLIFONEZ0','4','D','10','2392',NULL,'Subcode',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('322','EMETLIFONEZ0','4','D','10','2396',NULL,'Branch',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('323','EMETLIFONEZ0','1','D','10','2400',NULL,'Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('324','EMETLIFONEZ0','1','D','10','2401',NULL,'Members covered code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('325','EMETLIFONEZ0','1','D','10','2402',NULL,'Enrollment status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('326','EMETLIFONEZ0','20','D','10','2403',NULL,'Authorization Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('327','EMETLIFONEZ0','8','D','10','2423',NULL,'Authorization Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('328','EMETLIFONEZ0','20','D','10','2431',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EMETLIFONEZ0','1','T','90','1',NULL,'Record Type',NULL,NULL,'"Z"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EMETLIFONEZ0','8','T','90','2',NULL,'Total Record Count',NULL,NULL,'"drvTotalRecordCount"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EMETLIFONE_20240202.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',A1WFW',NULL,NULL,NULL,'MetLife ACC CI Hosp Active OE','202401029','EMPEXPORT','OEACTIVE',NULL,'EMETLIFONE',NULL,NULL,NULL,'202401029','Dec 27 2023  1:06PM','Dec 27 2023  1:06PM','202401011',NULL,'','','202401011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',A1WFW',NULL,NULL,NULL,'MetLife ACC CI Hosp Passive OE','202401029','EMPEXPORT','OEPASSIVE',NULL,'EMETLIFONE',NULL,NULL,NULL,'202401029','Dec 27 2023  1:06PM','Dec 27 2023  1:06PM','202401011',NULL,'','','202401011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,',A1WFW',NULL,NULL,NULL,'MetLife ACC CI Hosp On-Demand','202401029','EMPEXPORT','ONDEM_XOE',NULL,'EMETLIFONE',NULL,NULL,NULL,'202401029','Dec 27 2023  1:06PM','Dec 27 2023  1:06PM','202401011',NULL,'','','202401011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,'A1WFW',NULL,NULL,NULL,'MetLife ACC CI Hosp Sched','202401029','EMPEXPORT','SCH_EMETLI',NULL,'EMETLIFONE',NULL,NULL,NULL,'202401029','Dec 27 2023  1:06PM','Dec 27 2023  1:06PM','202401011',NULL,'','','202401011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',',A1WFW',NULL,NULL,NULL,'MetLife ACC CI Hosp Test','202401239','EMPEXPORT','TEST_XOE',NULL,'EMETLIFONE',NULL,NULL,NULL,'202401239','Dec 27 2023  1:06PM','Dec 27 2023  1:06PM','202401161',NULL,'','','202401161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFONE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFONE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFONE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFONE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFONE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFONE','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMETLIFONE','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFONE','H01','dbo.U_EMETLIFONE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFONE','D10','dbo.U_EMETLIFONE_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMETLIFONE','T90','dbo.U_EMETLIFONE_Trailer',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EMETLIFONE
-----------

IF OBJECT_ID('U_dsi_BDM_EMETLIFONE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMETLIFONE] (
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
-- Create table U_EMETLIFONE_Audit
-----------

IF OBJECT_ID('U_EMETLIFONE_Audit') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_Audit] (
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
-- Create table U_EMETLIFONE_AuditFields
-----------

IF OBJECT_ID('U_EMETLIFONE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EMETLIFONE_DedList
-----------

IF OBJECT_ID('U_EMETLIFONE_DedList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EMETLIFONE_drvTbl
-----------

IF OBJECT_ID('U_EMETLIFONE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvTransactiionCode] varchar(1) NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvMemberSSN] char(11) NULL,
    [drvPersonelID] char(9) NULL,
    [drvLastName] varchar(6000) NULL,
    [drvFirstName] varchar(6000) NULL,
    [drvMiddleInitial] varchar(6000) NULL,
    [drvDateofBirth] varchar(8000) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvRealationship] varchar(2) NULL,
    [drvDateofHire] varchar(8000) NULL,
    [drvForeignAddressInd] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(8000) NULL,
    [drvAddressCity] varchar(8000) NULL,
    [drvAddressState] varchar(8000) NULL,
    [drvAddressZipCode] varchar(6000) NULL,
    [drvCountryCode] varchar(1) NOT NULL,
    [drvWorkState] varchar(1) NOT NULL,
    [drvPhoneNumber] varchar(6000) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvWorkStatusCode] varchar(1) NULL,
    [drvWorkStatusCodeEffDate] varchar(8000) NULL,
    [drvDepartment] varchar(4) NULL,
    [drvGroupID] varchar(1) NOT NULL,
    [drvLocationID] varchar(4) NULL,
    [drvScheduleID] varchar(1) NOT NULL,
    [drvPayFrequency] varchar(2) NULL,
    [drvEmpSmokerStatus] varchar(1) NULL,
    [drvSpSmorkerStatus] varchar(1) NULL,
    [drvAccidentIns] varchar(2) NULL,
    [drvAccCovEffDate] varchar(8000) NULL,
    [drvAccCovEndDate] varchar(8000) NULL,
    [drvAccGroupNum] varchar(7) NULL,
    [drvAccSubcode] varchar(4) NULL,
    [drvAccBranch] varchar(4) NULL,
    [drvAccCovStatus] varchar(1) NULL,
    [drvAccMemberCovCode] varchar(1) NULL,
    [drvAccEnrollStatus] varchar(1) NULL,
    [drvAccVolCancelInd] varchar(2) NULL,
    [drvHospitalIndemnity] varchar(2) NULL,
    [drvHospCovEffDate] varchar(8000) NULL,
    [drvHospCovEndDate] varchar(8000) NULL,
    [drvHospgroupNum] varchar(7) NULL,
    [drvHospSubcode] varchar(4) NULL,
    [drvHospBranch] varchar(4) NULL,
    [drvHospCoverageStatus] varchar(1) NULL,
    [drvHospCemEveD] varchar(1) NULL,
    [drvHospEnrollmentstatus] varchar(1) NULL,
    [drvHospVolCancelInd] varchar(2) NULL,
    [drvCrillEmpAttainedIge] varchar(2) NULL,
    [drvCrillCovEffDateEmp] varchar(8000) NULL,
    [drvCrillCovEndDateEmp] varchar(8000) NULL,
    [drvCrillgroupNumEmp] varchar(7) NULL,
    [drvCrillSubcodeEmp] varchar(4) NULL,
    [drvCrillBranchEmp] varchar(4) NULL,
    [drvCrillCoverageStatusEmp] varchar(1) NULL,
    [drvCrillMembCovCodeEmp] varchar(1) NULL,
    [drvCrillEnrollmentstatusEmp] varchar(1) NULL,
    [drvCrillBenefitamountEmp] varchar(24) NULL,
    [drvCrillVolCancelIndEmp] varchar(2) NULL,
    [drvCrillDepAttainedIge] varchar(2) NULL,
    [drvCrillCovEffDateDep] varchar(8000) NULL,
    [drvCrillCovEndDateDep] varchar(8000) NULL,
    [drvCrillgroupNumDep] varchar(7) NULL,
    [drvCrillSubcodeDep] varchar(4) NULL,
    [drvCrillBranchDep] varchar(4) NULL,
    [drvCrillCoverageStatusDep] varchar(1) NULL,
    [drvCrillMembCovCodeDep] varchar(1) NULL,
    [drvCrillEnrollmentstatusDep] varchar(1) NULL,
    [drvCrillBenefitamountDep] varchar(24) NULL,
    [drvCrillVolCancelIndDep] varchar(2) NULL,
    [drvEmpCancer] varchar(1) NOT NULL,
    [drvPaidFMLACovCode] varchar(1) NOT NULL,
    [drvPaidMEDLACovCode] varchar(1) NOT NULL
);

-----------
-- Create table U_EMETLIFONE_EEList
-----------

IF OBJECT_ID('U_EMETLIFONE_EEList') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EMETLIFONE_File
-----------

IF OBJECT_ID('U_EMETLIFONE_File') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EMETLIFONE_Header
-----------

IF OBJECT_ID('U_EMETLIFONE_Header') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_Header] (
    [drvEnitityName] varchar(28) NOT NULL,
    [drvDateFileCreated] varchar(8000) NULL,
    [drvChangesOnlyInd] varchar(1) NOT NULL
);

-----------
-- Create table U_EMETLIFONE_Trailer
-----------

IF OBJECT_ID('U_EMETLIFONE_Trailer') IS NULL
CREATE TABLE [dbo].[U_EMETLIFONE_Trailer] (
    [drvTotalRecordCount] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMETLIFONE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Metropolitan Family Services

Created By: Marie Waters
Business Analyst: Dawn Ross
Create Date: 12/27/2023
Service Request Number: TekP-2023-10-27-01 

Purpose: MetLife One Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMETLIFONE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMETLIFONE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMETLIFONE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMETLIFONE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMETLIFONE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFONE', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFONE', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFONE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFONE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMETLIFONE', 'SCH_EMETLI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMETLIFONE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EMETLIFONE', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@MinCovDate        DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EMETLIFONE';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@MinCovDate      = '01/01/2024'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EMETLIFONE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMETLIFONE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMETLIFONE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFONE_AuditFields;
    CREATE TABLE dbo.U_EMETLIFONE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EMETLIFONE_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMETLIFONE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFONE_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audCOID= audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EMETLIFONE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMETLIFONE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMETLIFONE_Audit ON dbo.U_EMETLIFONE_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_EMETLIFONE_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMETLIFONE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MFS,MTLIF,MCCR,MCRI1,MCRI2,MECRI,MSCR1,MSCR2,MSCR3';

    IF OBJECT_ID('U_EMETLIFONE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFONE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMETLIFONE_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'RelationshipsSpouse','SPS, DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'RelationshipsChild','CHD, CHL, DPC, STC');
  

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

     
  ---========================================================================
 --  Insert into Spouse for Critial illness 
 --   --======================================================================
    INSERT INTO [dbo].[U_dsi_BDM_EMETLIFONE]
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
           ,[BdmSessionID]
            )
            SELECT Distinct rectype = 'DEP'
                ,EdhCoid
                ,EdhEEID
                ,eeddeprecid
                ,eedDepRecID
                ,''
                ,'Data Inserted for Record'
                ,conRelationship
                ,conDateOfBirth
                ,EdhDedCode
                ,edhBenOption
                ,eedBenStatus
                ,EdhBenStartDate
                --,EdhBenStopDate
                ,eedBenStopDate
                ,EdhBenStatusDate
                ,EdhEffDate
                ,edhChangeReason
                ,edhChangeReason
                ,EdhStartDate
                ,EdhStopDate
                ,CASE WHEN conRelationShip = 'SPS' THEN 'Y' ELSE 'N' END
                ,'Y'
                ,ROW_NUMBER() OVER (PARTITION by EdhEEID, EdhCOID, edhChangeReason, EdhDedCode ORDER BY EdhEffDate desc)
            FROM dbo.emphded WITH (NOLOCK)
                JOIN empded 
                    ON eedeeid = edheeid 
                    AND eedCoID = EdhCoID
                    AND EdhDedCode = eedDedCode
                    AND eeddeprecid is not null
            JOIN dbo.contacts WITH (NOLOCK)
                    ON ConEEID = edheeid 
                    and ConRelationship = 'SPS'
                    and ConIsDependent = 'Y'
                    and ConIsActive = 'Y'
            WHERE  eedDedCode IN ('MSCR1', 'MSCR2', 'MSCR3' )    
            and (ISNULL(eedBenStopDate, '')  = ''  or eedBenStopDate BETWEEN @StartDate AND @EndDate)


--========================================================================
 --  Insert into Spouse for Critial illness 
 --   --======================================================================
    INSERT INTO [dbo].[U_dsi_BDM_DepDeductions]
        (    DbnFormatCode
        ,    DbnCoID
        ,    DbnEEID
        ,    DbnDepRecID
        ,    DbnRelationship
        ,    DbnDateOfBirth
        ,    DbnBenOption
        ,    DbnBenStartDate
        ,    DbnBenStatus
        ,    DbnBenStatusDate
        ,    DbnBenStopDate
        ,    DbnSystemID
        ,    DbnDedCode
        ,   DedDedCode
        ,   DedDedType
        )    
            Select
             'EMETLIFONE'
            ,bdmcoid
            ,eedeeid
            ,EedDepRecID
            ,'SPS'
            ,ConDateOfBirth
            ,EedBenoption
            ,eedbenstartdate
            ,EedBenStatus
            ,eedBenStatusDate
            ,eedBenStopDate
            ,EedDepRecID
            ,eedDedCode
            ,eedDedCode
            ,'DEP'
                FROM empded  WITH (NOLOCK)    
                JOIN dbo.U_dsi_BDM_EMETLIFONE WITH (NOLOCK)
                        ON eeddedcode = BdmDedCode
                        AND BdmEEID = eedeeid
                        AND BdmCoID = eedcoid 
                        and bdmdeprecid is not null
                JOIN dbo.contacts WITH (NOLOCK)
                        ON ConEEID = eedeeid 
                        and ConRelationship = 'SPS'
                        and ConIsDependent = 'Y'
                        and ConIsActive = 'Y'   
               where eedDedCode IN ('MSCR1', 'MSCR2', 'MSCR3' )
    
    ----Update amounts
    --Update dbo.u_dsi_bdm_BenCalculationAmounts
    --Set BcaDepRecID = EedDepRecID
    --, BcaeebenAmt = BcaeebenAmt
    --FROM dbo.u_dsi_bdm_BenCalculationAmounts
 --   JOIN empded  WITH (NOLOCK)
 --   on eedeeid = bcaeeid 
    --AND eedcoid = bcacoid
 --   AND eeddedcode = bcadedcode
 --   AND BcaDepRecID IS NULL 
    --and BcaFormatCode = 'EMETLIFONE'
 --   JOIN dbo.U_dsi_BDM_EMETLIFONE WITH (NOLOCK)
 --   ON eeddedcode = BdmDedCode
 --   AND BdmEEID = eedeeid
 --   AND BdmCoID = eedcoid 
    --and bdmdeprecid is not null
 --  where eedDedCode IN ('MSCR1', 'MSCR2', 'MSCR3' )

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMETLIFONE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMETLIFONE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFONE_drvTbl;
       SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = xeeid
        ,drvSubSort = BdmDepRecID
        -- standard fields above and additional driver fields below
        ,drvTransactiionCode =  CASE WHEN BdmRecType = 'EMP' THEN 'E'
                                     WHEN BdmRecType = 'DEP' THEN 'D'
                                 END
        ,drvCustomerNumber = '9254400'
        ,drvEmpSSN =  eepSSN
                          
        ,drvMemberSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN
                          WHEN BdmRecType = 'DEP' THEN Conssn
                        END
        ,drvPersonelID = EecEmpno
        ,drvLastName = UPPER(dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')
                                   WHEN BdmRecType = 'DEP' THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ConNameLast, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')
                              END))
        ,drvFirstName = UPPER(dbo.dsi_fnRemoveChars('.,/-',
                               CASE WHEN BdmRecType = 'EMP' THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepNameFirst, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')
                                    WHEN BdmRecType = 'DEP' THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ConNameFirst, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')
                               END))
        ,drvMiddleInitial = UPPER(dbo.dsi_fnRemoveChars('.,/-',
                                       CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                       END))
        ,drvDateofBirth = CASE WHEN BdmRecType = 'EMP' THEN replace(convert(char(10),EepDateOfBirth, 101), '/', '')
                               WHEN BdmRecType = 'DEP' THEN replace(convert(char(10),ConDateofBirth, 101), '/', '')
                            END
        ,drvMaritalStatus = CASE WHEN BdmRecType = 'EMP'  AND EepMaritalStatus IN ('S' ,'M' ) THEN eepMaritalStatus Else  'U' END

        ,drvGender =  CASE WHEN BdmRecType = 'EMP' THEN EepGender
                           WHEN BdmRecType = 'DEP' THEN ConGender
                          END
        ,drvRealationship = CASE WHEN BdmRecType = 'EMP' THEN '00'
                                 WHEN BdmRecType = 'DEP' AND BdmRelationship IN ('DP', 'SPS') THEN '01'
                                 WHEN BdmRecType = 'DEP' AND BdmRelationship IN ('CHL', 'DCH', 'DPC',  'STC') THEN '02'
                                END
        ,drvDateofHire = CASE WHEN BdmRecType = 'EMP' THEN replace(convert(char(10),EecDateOfLastHire, 101), '/', '') END
        ,drvForeignAddressInd = ''
        ,drvAddressLine1 = CASE WHEN BdmRecType = 'EMP' THEN UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine1, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')) END
        ,drvAddressLine2 = CASE WHEN BdmRecType = 'EMP' THEN UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressLine2, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')) END
        ,drvAddressCity = CASE WHEN BdmRecType = 'EMP' THEN UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressCity, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')) END
        ,drvAddressState = CASE WHEN BdmRecType = 'EMP' THEN UPPER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EepAddressState, 'á', 'a'), 'é','e'), 'í', 'i'), 'ó', 'o'), 'ú','u'), 'n','n'),'ö','o')) END
        ,drvAddressZipCode = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnRemoveChars('.,/-',EepAddressZipCode) END
        ,drvCountryCode = ''
        ,drvWorkState = ''
        ,drvPhoneNumber = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnRemoveChars('.,/-',EepPhoneHomeNumber) END
        ,drvEmailAddress = CASE WHEN BdmRecType = 'EMP' THEN EepAddressEMail END
        ,drvWorkStatusCode =CASE WHEN BdmRectYpe = 'EMP' THEN
                                    CASE WHEN Eecemplstatus = 'T' and Eectermreason = '203' THEN 'D'
                                         WHEN Eecemplstatus = 'T' and Eectermreason = '202' THEN 'R'
                                         WHEN Eecemplstatus = 'T' and Eectermreason NOT IN ( '202' , '203')  THEN 'T'
                                         WHEN Eecemplstatus = 'L'  THEN 'L'
                                        ELSE 'A'
                                    END
                                END

        ,drvWorkStatusCodeEffDate = CASE WHEN BdmRectYpe = 'EMP' THEN 
                                            CASE WHEN EecEmplStatus ='A' then replace(convert(char(10),EecDateOfLastHire, 101), '/', '')
                                                 WHEN EecEmplStatus = 'T' then replace(convert(char(10),EecDateOfTermination, 101), '/', '')  
                                                END    
                                            END

        ,drvDepartment = CASE WHEN BdmRectYpe = 'EMP' THEN '0001' END
        ,drvGroupID = ''--CASE WHEN BdmRectYpe = 'EMP' THEN
                        --CASE WHEN BdmDedCode = 'MTLIF'  then '0254581'
                        --     WHEN BdmDedCode =  'MFS' then '0254582'
                        --     WHEN BdmDedCode IN ('MCCR', 'MCRI1', 'MCRI2', 'MECRI', 'MSCR1', 'MSCR2', 'MSCR3')  then '0254583'
                        --    END
                        --END
    
        ,drvLocationID = CASE WHEN BdmRectYpe = 'EMP' THEN '0001' END
        ,drvScheduleID = ''
        ,drvPayFrequency = CASE WHEN BdmRectYpe = 'EMP' THEN 
                                CASE WHEN EecPayPeriod = 'W' THEN '52'
                                     WHEN EecPayPeriod = 'B' THEN '26'
                                     WHEN EecPayPeriod = 'S' THEN '24'
                                     WHEN EecPayPeriod = 'M' THEN '12'
                                END
                            END
        ,drvEmpSmokerStatus = CASE WHEN BdmRectYpe = 'EMP' AND  EepIsSmoker = 'Y' then 'S'
                                   WHEN BdmRectYpe = 'EMP' AND  EepIsSmoker = 'N' then 'N'
                                END

        ,drvSpSmorkerStatus = CASE WHEN BdmRectYpe = 'DEP' AND BdmRelationship in ('DP', 'SPS') and  ConIsSmoker = 'Y' then 'S'
                                   WHEN BdmRectYpe = 'DEP' AND BdmRelationship in ('DP', 'SPS') and  ConIsSmoker ='N' then 'N'
                                END
        ,drvAccidentIns = CASE WHEN MTLIF_DedCode IS NOT NULL  then 'AH' END
        ,drvAccCovEffDate = CASE WHEN  MTLIF_DedCode IS NOT NULL THEN replace(convert(char(10),(dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MTLIF_BenStartDate)) , 101), '/', '') END
        ,drvAccCovEndDate = CASE WHEN  MTLIF_DedCode IS NOT NULL THEN replace(convert(char(10),MTLIF_BenStopDate, 101), '/', '') END
        ,drvAccGroupNum = CASE WHEN  MTLIF_DedCode IS NOT NULL THEN '0254581' END
        ,drvAccSubcode = CASE WHEN  MTLIF_DedCode IS NOT NULL THEN '0001' END
        ,drvAccBranch = CASE WHEN  MTLIF_DedCode IS NOT NULL THEN '0001' END
        ,drvAccCovStatus = CASE WHEN  MTLIF_DedCode IS NOT NULL AND MTLIF_BenStatus = 'A' THEN 'A' END
        ,drvAccMemberCovCode = CASE WHEN  MTLIF_DedCode IS NOT NULL  AND MTLIF_BenOption = 'EE' THEN '1'
                                    WHEN  MTLIF_DedCode IS NOT NULL  AND MTLIF_BenOption = 'EEC' THEN '2'
                                    WHEN  MTLIF_DedCode IS NOT NULL  AND MTLIF_BenOption IN ('EES', 'EEDP') THEN '3'
                                    WHEN  MTLIF_DedCode IS NOT NULL AND MTLIF_BenOption IN ('EEF', 'EEDPF') THEN '4'
                                END
        ,drvAccEnrollStatus = CASE WHEN  MTLIF_DedCode IS NOT NULL  AND MTLIF_BenStatus = 'A' THEN 'P' END
        ,drvAccVolCancelInd = CASE WHEN  BdmRectYpe = 'EMP' AND MTLIF_DedCode IS NOT NULL AND MTLIF_BenStatus <> 'A' THEN 'CE' END
        ,drvHospitalIndemnity = CASE WHEN MFS_DedCode IS NOT NULL THEN 'HH' END
        ,drvHospCovEffDate = CASE WHEN MFS_DedCode IS NOT NULL  THEN replace(convert(char(10),(dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MFS_BenStartDate)) , 101), '/', '') END
        ,drvHospCovEndDate = CASE WHEN MFS_DedCode IS NOT NULL  THEN replace(convert(char(10),MFS_BenStopDate, 101), '/', '') END
        ,drvHospgroupNum = CASE WHEN MFS_DedCode IS NOT NULL  THEN '0254582' END
        ,drvHospSubcode = CASE WHEN MFS_DedCode IS NOT NULL  THEN '0001' END
        ,drvHospBranch = CASE WHEN MFS_DedCode IS NOT NULL  THEN '0001' END
        ,drvHospCoverageStatus = CASE WHEN  MFS_DedCode IS NOT NULL  AND MFS_BenStatus = 'A' THEN 'A' END
        ,drvHospCemEveD = CASE WHEN MFS_DedCode IS NOT NULL  AND MFS_BenOption = 'EE' THEN '1'
                                    WHEN  MFS_DedCode IS NOT NULL   AND MFS_BenOption = 'EEC' THEN '2'
                                    WHEN  MFS_DedCode IS NOT NULL  AND MFS_BenOption IN ('EES', 'EEDP') THEN '3'
                                    WHEN  MFS_DedCode IS NOT NULL   AND MFS_BenOption IN ('EEF', 'EEDPF') THEN '4'
                                END
        ,drvHospEnrollmentstatus = CASE WHEN  MFS_DedCode IS NOT NULL  AND MFS_BenStatus = 'A' THEN 'P' END
        ,drvHospVolCancelInd =  CASE WHEN  BdmRectYpe = 'EMP' AND MFS_DedCode IS NOT NULL  AND MFS_BenStatus <> 'A' THEN 'CE' END
        ,drvCrillEmpAttainedIge = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL THEN 'GE' END
        ,drvCrillCovEffDateEmp =  CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL  THEN replace(convert(char(10),(dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MCR_BenStartDate)) , 101), '/', '') END
        ,drvCrillCovEndDateEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL THEN replace(convert(char(10),MCR_BenStopDate, 101), '/', '')END
        ,drvCrillgroupNumEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL  THEN '0254583' END
        ,drvCrillSubcodeEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL  THEN '0001' END
        ,drvCrillBranchEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL  THEN '0001' END
        ,drvCrillCoverageStatusEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL  AND MCR_BenStatus = 'A' THEN 'A' END
        ,drvCrillMembCovCodeEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL THEN '1' END
        ,drvCrillEnrollmentstatusEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL   THEN 'P' END
        ,drvCrillBenefitamountEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL  THEN dbo.dsi_fnpadzero(CAST(MCR_BenEEAmt as varchar),8,0) END
        ,drvCrillVolCancelIndEmp = CASE WHEN  BdmRectYpe = 'EMP' AND MCR_DedCode IS NOT NULL  THEN 'CE' END        
        ,drvCrillDepAttainedIge = CASE WHEN BdmRectYpe = 'DEP' AND  (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null )  THEN  'GD' END
        ,drvCrillCovEffDateDep = CASE WHEN BdmRectYpe = 'DEP' AND MCCR_DedCode IS NOT NULL THEN  replace(convert(char(10),(dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MCCR_BenStartDate)) , 101), '/', '') 
                                    WHEN BdmRectYpe = 'DEP' AND MCCRC_DedCode IS NOT NULL THEN  replace(convert(char(10),(dbo.dsi_fnGetMinMaxDates('MAX', @MinCovDate, MCCRC_BenStartDate)) , 101), '/', '') END
        ,drvCrillCovEndDateDep = CASE WHEN BdmRectYpe = 'DEP' AND MCCR_DedCode IS NOT NULL THEN  replace(convert(char(10),MCCR_BenStopDate, 101), '/', '') 
                                       WHEN BdmRectYpe = 'DEP' AND MCCRC_DedCode IS NOT NULL THEN  replace(convert(char(10),MCCRC_BenStopDate, 101), '/', '') END
        ,drvCrillgroupNumDep = CASE WHEN BdmRectYpe = 'DEP' AND (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null ) THEN '0254583' END
        ,drvCrillSubcodeDep = CASE WHEN BdmRectYpe = 'DEP' AND (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null ) THEN '0001' END
        ,drvCrillBranchDep = CASE WHEN BdmRectYpe = 'DEP' AND (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null ) THEN '0001' END        
        ,drvCrillCoverageStatusDep = CASE WHEN BdmRectYpe = 'DEP' and (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null )    THEN 'A' END --AND MCCR_BenOption = 'A'
        ,drvCrillMembCovCodeDep = CASE WHEN BdmRectYpe = 'DEP' and (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null )   AND ((SELECT COUNT(Distinct bdmdeprecid) FROM dbo.U_dsi_BDM_EMETLIFONE Con WITH (NOLOCK) WHERE  Con.bdmEEID= xEEID  and bdmRelationship IN ('SPS','DP')) = 0 AND ((SELECT COUNT(Distinct bdmdeprecid) FROM dbo.U_dsi_BDM_EMETLIFONE CON WITH (NOLOCK) WHERE Con.bdmEEID = xEEID and BdmRelationship IN ('CHL','CRT','DIS','GRC','STC')) >= 1 ) )  THEN '2'
                                    WHEN BdmRectYpe = 'DEP' and (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null )    AND ((SELECT COUNT(Distinct bdmdeprecid) FROM dbo.U_dsi_BDM_EMETLIFONE Con WITH (NOLOCK) WHERE  Con.bdmEEID= xEEID and bdmRelationship IN ('SPS','DP')) = 1  and ((SELECT COUNT(Distinct bdmdeprecid) FROM dbo.U_dsi_BDM_EMETLIFONE Con WITH (NOLOCK) WHERE Con.bdmEEID=  xEEID and bdmRelationship IN ('CHL','CRT','DIS','GRC','STC')) = 0 ) ) THEN '3'
                                    WHEN BdmRectYpe = 'DEP' and (MCCR_DedCode Is not null  or MCCRC_DedCode Is not null )    AND ((SELECT COUNT(Distinct bdmdeprecid) FROM dbo.U_dsi_BDM_EMETLIFONE Con WITH (NOLOCK) WHERE  Con.bdmEEID= xEEID and bdmRelationship IN ('SPS','DP')) = 1  and ((SELECT COUNT(Distinct bdmdeprecid) FROM dbo.U_dsi_BDM_EMETLIFONE Con WITH (NOLOCK) WHERE Con.bdmEEID=  xEEID and bdmRelationship IN ('CHL','CRT','DIS','GRC','STC')) >= 1 ) )  THEN '4'
                                END
        --WHEN MCCR_DedCode IS NOT NULL  AND MCCR_BenOption = 'EEC' THEN '2'
        --                            WHEN MCCR_DedCode IS NOT NULL  AND  MCCR_BenOption IN ('EES', 'EEDP') THEN '3'
        --                            WHEN MCCR_DedCode IS NOT NULL  AND MCCR_BenOption IN ('EEF', 'EEDPF') THEN '4'
                                --END
        ,drvCrillEnrollmentstatusDep = CASE WHEN BdmRectYpe = 'DEP' and ((MCCR_DedCode Is not null AND  ISNULL(MCCR_BenStopDate, '')  = '') or (MCCRC_DedCode Is not null AND  ISNULL(MCCRC_BenStopDate, '')  = ''))  THEN 'P' END --MCCR_BenStatus= 'A' 
        ,drvCrillBenefitamountDep =  CASE WHEn CASE WHEN  BdmRectYpe = 'DEP' AND bdmdeprecid  IN (SELECT Distinct bdmdeprecid FROM dbo.U_dsi_BDM_EMETLIFONE Con WITH (NOLOCK) WHERE  Con.bdmEEID= xEEID and bdmRelationship IN ('SPS','DP','CHL','CRT','DIS','GRC','STC')) And (MCCR_DedCode Is not null AND  ISNULL(MCCR_BenStopDate, '')  = '') THEN  MCCR_BenEEAmt END is not null THEN
                                            CASE WHEN  BdmRectYpe = 'DEP' AND bdmdeprecid  IN (SELECT Distinct bdmdeprecid FROM dbo.U_dsi_BDM_EMETLIFONE Con WITH (NOLOCK) WHERE  Con.bdmEEID= xEEID and bdmRelationship IN ('SPS','DP','CHL','CRT','DIS','GRC','STC')) And (MCCR_DedCode Is not null AND  ISNULL(MCCR_BenStopDate, '')  = '') THEN dbo.dsi_fnpadzero(CAST(MCCR_BenEEAmt as varchar),8,0) END
                                                                 -- AND MCCR_BenStatus <> 'A'
                                    ELSE CaSE WHEN BdmRectYpe = 'DEP' AND ( MCCR_DedCode Is not null AND  ISNULL(MCCR_BenStopDate, '')  <= '') and bdmdeprecid IN  (SELECT Distinct bdmdeprecid FROM dbo.U_dsi_BDM_EMETLIFONE CON WITH (NOLOCK) WHERE Con.bdmEEID = xEEID and BdmRelationship IN ('SPS','DP')) THEN 
                                                                    ( SELECT dbo.dsi_fnpadzero(CAST(MAX(CASE WHEN BcaDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BcaeebenAmt END)as varchar),8,0)       
                                                                            FROM dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
                                                                            JOIN dbo.U_dsi_BDM_EMETLIFONE WITH (NOLOCK)                                                                                                                                                     ON Bcaeeid = Bdmeeid                                                                                 --AND bcacoid = Bdmcoid                                                                                 AND bcadedcode = bdmdedcode                                                                                 AND bcaformatcode = 'EMETLIFONE'
                                                                                where bdmeeid = xeeid
                                                                                and BdmBenStatus NOT In ('W', 'C')
                                                                             GROUP BY BdmEEID) 
                                                                            WHEN BdmRectYpe = 'DEP' AND ( MCCRC_DedCode Is not null AND  ISNULL(MCCR_BenStopDate, '')  <= '') and bdmdeprecid NOT IN  (SELECT bdmdeprecid FROM dbo.U_dsi_BDM_EMETLIFONE CON WITH (NOLOCK) WHERE Con.bdmEEID = xEEID and BdmRelationship IN ('SPS','DP'))THEN 
                                                                    ( SELECT dbo.dsi_fnpadzero(CAST(MAX(CASE WHEN BcaDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BcaeebenAmt / 2 END)as varchar),8,0)       
                                                                            FROM dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
                                                                            JOIN dbo.U_dsi_BDM_EMETLIFONE WITH (NOLOCK)                                                                                                                                                     ON Bcaeeid = Bdmeeid                                                                                 --AND bcacoid = Bdmcoid                                                                                 AND bcadedcode = bdmdedcode                                                                                 AND bcaformatcode = 'EMETLIFONE'
                                                                                where bdmeeid = xeeid                                                                                
                                                                             GROUP BY BdmEEID)
                                                                            END 
                                                                        END
        ,drvCrillVolCancelIndDep = CASE WHEN  BdmRectYpe = 'DEP' and (MCCR_DedCode Is not null AND  ISNULL(MCCRC_BenStopDate, '')  <> '' or MCCRC_DedCode Is not null AND  ISNULL(MCCR_BenStopDate, '')  <> '') THEN 'CE' END --AND MCCR_BenStatus <> 'A' 
        ,drvEmpCancer = ''
        ,drvPaidFMLACovCode = ''
        ,drvPaidMEDLACovCode = ''
  INTO dbo.U_EMETLIFONE_drvTbl
    FROM dbo.U_EMETLIFONE_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN ( SELECT BdmEEID, BdmCOID, BdmDepRecID
                ,MAX(BdmRecType) AS BdmRecType
                ,MAX(BdmRelationship) AS BdmRelationship
                ,MAX(CASE WHEN BdmDedCode = 'MFS' THEN BdmDedCode END) MFS_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BdmDedCode END) MCR_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MSCR1', 'MSCR2', 'MSCR3') THEN BdmDedCode END) MCCR_DedCode
                ,MAX(CASE WHEN BdmDedCode IN ('MCCR') THEN BdmDedCode END) MCCRC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'MTLIF' THEN BdmDedCode END) MTLIF_DedCode

                ,MAX(CASE WHEN BdmDedCode IN ('MFS') THEN BdmBenStatus END) MFS_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('MFS') THEN BdmBenStopDate END) MFS_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MFS') THEN BdmBenStartDate END) MFS_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MFS') THEN BdmBenOption END) MFS_BenOption

                ,MAX(CASE WHEN BdmDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BdmBenStatus END) MCR_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BdmBenStopDate END) MCR_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BdmBenStartDate END) MCR_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BdmBenOption END) MCR_BenOption
                ,MAX(CASE WHEN BdmDedCode IN ('MCRI1', 'MCRI2', 'MECRI') THEN BcaeebenAmt END) MCR_BenEEAmt

                ,MAX(CASE WHEN BdmDedCode IN ('MSCR1', 'MSCR2', 'MSCR3' ) THEN dbnBenStatus END) MCCR_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('MSCR1', 'MSCR2', 'MSCR3'  ) THEN dbnBenStopDate END) MCCR_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MSCR1', 'MSCR2', 'MSCR3'  ) THEN dbnBenStartDate END) MCCR_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MSCR1', 'MSCR2', 'MSCR3'  ) THEN bdmBenOption END) MCCR_BenOption
                ,MAX(CASE WHEN BdmDedCode IN ('MSCR1', 'MSCR2', 'MSCR3'  ) THEN BcaeebenAmt END) MCCR_BenEEAmt
                
                ,MAX(CASE WHEN BdmDedCode IN ('MCCR')  THEN dbnBenStopDate END) MCCRC_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MCCR'  ) THEN dbnBenStartDate END) MCCRC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MCCR'  ) THEN BcaeebenAmt END) MCCRC_BenEEAmt

                ,MAX(CASE WHEN BdmDedCode IN ('MTLIF') THEN BdmBenStatus END) MTLIF_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('MTLIF') THEN BdmBenStopDate END) MTLIF_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('MTLIF') THEN BdmBenStartDate END) MTLIF_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('MTLIF') THEN BdmBenOption END) MTLIF_BenOption

                FROM dbo.U_dsi_BDM_EMETLIFONE WITH (NOLOCK)
                LEFT JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)                     ON Bcaeeid = Bdmeeid                     AND bcacoid = Bdmcoid                     AND bcadedcode = bdmdedcode                     AND bcaformatcode = @Formatcode
                LEFT JOIN   dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
                            ON dbneeid = bdmeeid 
                            AND DbnCoID = bdmCoID
                            AND bdmDedCode = DbnDedCode       
                            AND dbnformatcode = @Formatcode
                        Where BdmBenStatus NOT In ('W', 'C')
                 GROUP BY BdmEEID, BdmCOID, BdmDepRecID) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
     LEFT JOIN dbo.U_EMETLIFONE_Audit WITH (NOLOCK)
        ON AudEEID = XEEID 
        and AudCOID = XCOID
    WHERE EecEEType <> 'TES' and (eecemplstatus <> 'T' or (eecemplstatus = 'T'  and eecTermReason <> 'TRO' and audDatetime Between @StartDate and @EndDate))
    ;
    
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMETLIFONE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFONE_Header;
    SELECT DISTINCT
         drvEnitityName = 'METROPOLITAN FAMILY SERVICES'
        ,drvDateFileCreated =  replace(convert(char(10),GetDate(), 101), '/', '')
        ,drvChangesOnlyInd = 'N'
    INTO dbo.U_EMETLIFONE_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EMETLIFONE_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EMETLIFONE_Trailer;
    SELECT DISTINCT
         drvTotalRecordCount = FORMAT((SELECT COUNT (*) FROM dbo.U_EMETLIFONE_drvTbl), '00000000')
    INTO dbo.U_EMETLIFONE_Trailer
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
ALTER VIEW dbo.dsi_vwEMETLIFONE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMETLIFONE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EMETLIFONE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202401161'
       ,expStartPerControl     = '202401161'
       ,expLastEndPerControl   = '202401239'
       ,expEndPerControl       = '202401239'
WHERE expFormatCode = 'EMETLIFONE' and expexportcode = 'TEST_XOE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMETLIFONE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMETLIFONE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EMETLIFONE' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EMETLIFONE'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EMETLIFONE'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMETLIFONE', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EMETLIFONE', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EMETLIFONE', 'UseFileName', 'V', 'Y'


-- End ripout