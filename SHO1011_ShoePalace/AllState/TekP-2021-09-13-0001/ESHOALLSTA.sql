/**********************************************************************************

ESHOALLSTA: Allstate AC and Hosp

FormatCode:     ESHOALLSTA
Project:        Allstate AC and Hosp
Client ID:      SHO1011
Date/time:      2022-05-11 06:54:22.667
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP4DB03
Database:       ULTIPRO_WPSOPL
Web Filename:   SHO1011_XGTM5_EEHISTORY_ESHOALLSTA_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ESHOALLSTA_SavePath') IS NOT NULL DROP TABLE dbo.U_ESHOALLSTA_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ESHOALLSTA'


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
WHERE FormatCode = 'ESHOALLSTA'
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
WHERE ExpFormatCode = 'ESHOALLSTA'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ESHOALLSTA')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ESHOALLSTA'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ESHOALLSTA'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ESHOALLSTA'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ESHOALLSTA'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ESHOALLSTA'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ESHOALLSTA'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ESHOALLSTA'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ESHOALLSTA'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ESHOALLSTA'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwESHOALLSTA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESHOALLSTA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESHOALLSTA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESHOALLSTA];
GO
IF OBJECT_ID('U_ESHOALLSTA_Q_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_Q_drvTbl];
GO
IF OBJECT_ID('U_ESHOALLSTA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_PEarHist];
GO
IF OBJECT_ID('U_ESHOALLSTA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_PDedHist];
GO
IF OBJECT_ID('U_ESHOALLSTA_File') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_File];
GO
IF OBJECT_ID('U_ESHOALLSTA_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_EEList];
GO
IF OBJECT_ID('U_ESHOALLSTA_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_DedList];
GO
IF OBJECT_ID('U_ESHOALLSTA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_AuditFields];
GO
IF OBJECT_ID('U_ESHOALLSTA_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_Audit];
GO
IF OBJECT_ID('U_ESHOALLSTA_55_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_55_drvTbl];
GO
IF OBJECT_ID('U_ESHOALLSTA_40_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_40_drvTbl];
GO
IF OBJECT_ID('U_ESHOALLSTA_38_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_38_drvTbl];
GO
IF OBJECT_ID('U_ESHOALLSTA_01_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESHOALLSTA_01_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_ESHOALLSTA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESHOALLSTA];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESHOALLSTA','Allstate AC and Hosp','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1000','S','N','ESHOALLSTAZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESHOALLSTAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL,'"01"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESHOALLSTAZ0','9','D','10','2',NULL,'Application ID (Employee SSN)',NULL,NULL,'"drvApplicationID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESHOALLSTAZ0','15','D','10','3',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESHOALLSTAZ0','1','D','10','4',NULL,'Is Proposed Insured',NULL,NULL,'"drvIsProposedInsured"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESHOALLSTAZ0','1','D','10','5',NULL,'Is Employee',NULL,NULL,'"drvIsEmployee"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESHOALLSTAZ0','1','D','10','6',NULL,'Is Policy Owner',NULL,NULL,'"drvIsPolicyOwner"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESHOALLSTAZ0','1','D','10','7',NULL,'Is Dependent',NULL,NULL,'"dvIsDependent"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESHOALLSTAZ0','1','D','10','8',NULL,'Is Beneficiary',NULL,NULL,'"N"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESHOALLSTAZ0','1','D','10','9',NULL,'Beneficiary Type',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESHOALLSTAZ0','5','D','10','10',NULL,'Beneficiary Percentage',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESHOALLSTAZ0','2','D','10','11',NULL,'Relationship To Primary Insured',NULL,NULL,'"drvRelToPrimaryInsured"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESHOALLSTAZ0','2','D','10','12',NULL,'Relationship To Employee',NULL,NULL,'"drvRelToEmployee"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESHOALLSTAZ0','35','D','10','13',NULL,'Last Name or Name of Trust Estate',NULL,NULL,'"drvLNofTrustEstate"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESHOALLSTAZ0','35','D','10','14',NULL,'First Name',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESHOALLSTAZ0','1','D','10','15',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESHOALLSTAZ0','9','D','10','16',NULL,'Person SSN',NULL,NULL,'"drvPersonSSN"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESHOALLSTAZ0','1','D','10','17',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESHOALLSTAZ0','8','D','10','18',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESHOALLSTAZ0','15','D','10','19',NULL,'Home Phone Number',NULL,NULL,'"drvHomePhoneNum"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESHOALLSTAZ0','1','D','10','20',NULL,'Marital Status',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESHOALLSTAZ0','3','D','10','21',NULL,'Height',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESHOALLSTAZ0','3','D','10','22',NULL,'Weight',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESHOALLSTAZ0','71','D','10','23',NULL,'Full Street Address',NULL,NULL,'"drvFullStreetAddress"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESHOALLSTAZ0','20','D','10','24',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESHOALLSTAZ0','2','D','10','25',NULL,'State',NULL,NULL,'"drvState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESHOALLSTAZ0','9','D','10','26',NULL,'Zip',NULL,NULL,'"drvZip"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESHOALLSTAZ0','35','D','10','27',NULL,'Employer or Association or Union',NULL,NULL,'"drvEmployerAssocUnion"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESHOALLSTAZ0','8','D','10','28',NULL,'Date of Hire',NULL,NULL,'"drvDateofHire"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESHOALLSTAZ0','8','D','10','29',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESHOALLSTAZ0','25','D','10','30',NULL,'Plant or Division',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESHOALLSTAZ0','1','D','10','31',NULL,'Active at Work',NULL,NULL,'"Y"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESHOALLSTAZ0','75','D','10','32',NULL,'Reason for not active at work',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESHOALLSTAZ0','10','D','10','33',NULL,'Employee or Member ID',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESHOALLSTAZ0','8','D','10','34',NULL,'Annual Salary',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESHOALLSTAZ0','35','D','10','35',NULL,'Occupation',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESHOALLSTAZ0','35','D','10','36',NULL,'Job Title',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESHOALLSTAZ0','45','D','10','37',NULL,'Employee Email',NULL,NULL,'"drvEmployeeEmail "','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESHOALLSTAZ0','100','D','10','38',NULL,'Remarks',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESHOALLSTAZ0','15','D','10','39',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESHOALLSTAZ0','15','D','10','40',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESHOALLSTAZ0','15','D','10','41',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESHOALLSTAZ0','15','D','10','42',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESHOALLSTAZ0','15','D','10','43',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESHOALLSTAZ0','15','D','10','44',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESHOALLSTAZ0','15','D','10','45',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESHOALLSTAZ0','15','D','10','46',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESHOALLSTAZ0','15','D','10','47',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESHOALLSTAZ0','15','D','10','48',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESHOALLSTAZ0','36','D','10','49',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESHOALLSTAZ0','1','D','10','50',NULL,'IsSecondaryContact',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESHOALLSTAZ0','2','D','20','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESHOALLSTAZ0','9','D','20','2',NULL,'Application ID (Employee SSN)',NULL,NULL,'"drvApplicationID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESHOALLSTAZ0','1','D','20','3',NULL,'Coverage Tier',NULL,NULL,'"drvCoverageTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESHOALLSTAZ0','1','D','20','4',NULL,'Section 125 (pre or post tax)',NULL,NULL,'"drvSection125"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESHOALLSTAZ0','6','D','20','5',NULL,'Rate',NULL,NULL,'"drvRate"','(''UNT0''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESHOALLSTAZ0','3','D','20','6',NULL,'Base Plan Units',NULL,NULL,'"drvBasePlanUnits"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESHOALLSTAZ0','10','D','20','7',NULL,'Rider1',NULL,NULL,'"drvRider1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESHOALLSTAZ0','10','D','20','8',NULL,'Rider1 UnitsAmt',NULL,NULL,'"drvRider1UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESHOALLSTAZ0','10','D','20','9',NULL,'Rider2',NULL,NULL,'"drvRider2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESHOALLSTAZ0','10','D','20','10',NULL,'Rider2 UnitsAmt',NULL,NULL,'"drvRider2UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESHOALLSTAZ0','10','D','20','11',NULL,'Rider3',NULL,NULL,'"drvRider3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESHOALLSTAZ0','10','D','20','12',NULL,'Rider3 UnitsAmt',NULL,NULL,'"drvRider3UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESHOALLSTAZ0','10','D','20','13',NULL,'Rider4',NULL,NULL,'"drvRider4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESHOALLSTAZ0','10','D','20','14',NULL,'Rider4 UnitsAmt',NULL,NULL,'"drvRider4UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESHOALLSTAZ0','10','D','20','15',NULL,'Rider5',NULL,NULL,'"drvRider5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESHOALLSTAZ0','10','D','20','16',NULL,'Rider5 UnitsAmt',NULL,NULL,'"drvRider5UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESHOALLSTAZ0','10','D','20','17',NULL,'Rider6',NULL,NULL,'"drvRider6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESHOALLSTAZ0','10','D','20','18',NULL,'Rider6 UnitsAmt',NULL,NULL,'"drvRider6UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESHOALLSTAZ0','10','D','20','19',NULL,'Rider7',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESHOALLSTAZ0','10','D','20','20',NULL,'Rider7 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESHOALLSTAZ0','10','D','20','21',NULL,'Rider8',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESHOALLSTAZ0','10','D','20','22',NULL,'Rider8 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESHOALLSTAZ0','10','D','20','23',NULL,'Rider9',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESHOALLSTAZ0','10','D','20','24',NULL,'Rider9 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESHOALLSTAZ0','10','D','20','25',NULL,'Rider10',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESHOALLSTAZ0','10','D','20','26',NULL,'Rider10 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESHOALLSTAZ0','10','D','20','27',NULL,'Rider11',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESHOALLSTAZ0','10','D','20','28',NULL,'Rider11 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESHOALLSTAZ0','10','D','20','29',NULL,'Rider12',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESHOALLSTAZ0','10','D','20','30',NULL,'Rider12 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESHOALLSTAZ0','2','D','20','31',NULL,'Rate Mode',NULL,NULL,'"12"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESHOALLSTAZ0','8','D','20','32',NULL,'Date of First Deduction',NULL,NULL,'"drvDateofFirstDeduction"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESHOALLSTAZ0','8','D','20','33',NULL,'Requested Coverage Effective Date',NULL,NULL,'"drvReqCovEffectiveDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESHOALLSTAZ0','10','D','20','34',NULL,'Case Number',NULL,NULL,'"drvCaseNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESHOALLSTAZ0','1','D','20','35',NULL,'Status Code',NULL,NULL,'"drvStatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESHOALLSTAZ0','8','D','20','36',NULL,'Requested Coverage End Date',NULL,NULL,'"drvReqCovEndDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESHOALLSTAZ0','100','D','20','37',NULL,'Signed City and State',NULL,NULL,'"drvSignedCityandState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESHOALLSTAZ0','8','D','20','38',NULL,'Date signed by Employee',NULL,NULL,'"drvDateSignedbyEmp"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESHOALLSTAZ0','35','D','20','39',NULL,'Producers name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESHOALLSTAZ0','10','D','20','40',NULL,'Servicing Agent Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESHOALLSTAZ0','5','D','20','41',NULL,'Servicing Agent Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESHOALLSTAZ0','10','D','20','42',NULL,'Writing Agent Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESHOALLSTAZ0','5','D','20','43',NULL,'Writing Agent Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESHOALLSTAZ0','10','D','20','44',NULL,'Other Agent1 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESHOALLSTAZ0','5','D','20','45',NULL,'Other Agent1 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESHOALLSTAZ0','10','D','20','46',NULL,'Other Agent2 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESHOALLSTAZ0','5','D','20','47',NULL,'Other Agent2 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESHOALLSTAZ0','10','D','20','48',NULL,'Other Agent3 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESHOALLSTAZ0','5','D','20','49',NULL,'Other Agent3 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESHOALLSTAZ0','10','D','20','50',NULL,'Other Agent4 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESHOALLSTAZ0','5','D','20','51',NULL,'Other Agent4 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESHOALLSTAZ0','10','D','20','52',NULL,'Other Agent5 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESHOALLSTAZ0','5','D','20','53',NULL,'Other Agent5 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESHOALLSTAZ0','3','D','20','54',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','ESHOALLSTAZ0','1','D','20','55',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','ESHOALLSTAZ0','25','D','20','56',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','ESHOALLSTAZ0','6','D','20','57',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','ESHOALLSTAZ0','4','D','20','58',NULL,'Filler',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESHOALLSTAZ0','2','D','30','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESHOALLSTAZ0','9','D','30','2',NULL,'Application ID (Employee SSN)',NULL,NULL,'"drvApplicationID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESHOALLSTAZ0','1','D','30','3',NULL,'Coverage Tier',NULL,NULL,'"drvCoverageTier"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESHOALLSTAZ0','1','D','30','4',NULL,'Section 125 (pre or post tax)',NULL,NULL,'"drvSection125"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESHOALLSTAZ0','8','D','30','5',NULL,'Basic Benefit Amount',NULL,NULL,'"drvBasicBenefitAmount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESHOALLSTAZ0','6','D','30','6',NULL,'Total Mode Premium',NULL,NULL,'"drvTotalModePremium"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESHOALLSTAZ0','10','D','30','7',NULL,'Rider1',NULL,NULL,'"drvRider1"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESHOALLSTAZ0','10','D','30','8',NULL,'Rider1 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESHOALLSTAZ0','10','D','30','9',NULL,'Rider2',NULL,NULL,'"drvRider2"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESHOALLSTAZ0','10','D','30','10',NULL,'Rider2 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESHOALLSTAZ0','10','D','30','11',NULL,'Rider3',NULL,NULL,'"drvRider3"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESHOALLSTAZ0','10','D','30','12',NULL,'Rider3 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESHOALLSTAZ0','10','D','30','13',NULL,'Rider4',NULL,NULL,'"drvRider4"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESHOALLSTAZ0','10','D','30','14',NULL,'Rider4 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESHOALLSTAZ0','10','D','30','15',NULL,'Rider5',NULL,NULL,'"drvRider5"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESHOALLSTAZ0','10','D','30','16',NULL,'Rider5 UnitsAmt',NULL,NULL,'"drvRider5UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESHOALLSTAZ0','10','D','30','17',NULL,'Rider6',NULL,NULL,'"drvRider6"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESHOALLSTAZ0','10','D','30','18',NULL,'Rider6 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESHOALLSTAZ0','10','D','30','19',NULL,'Rider7',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ESHOALLSTAZ0','10','D','30','20',NULL,'Rider7 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ESHOALLSTAZ0','10','D','30','21',NULL,'Rider8',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ESHOALLSTAZ0','10','D','30','22',NULL,'Rider8 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ESHOALLSTAZ0','10','D','30','23',NULL,'Rider9',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ESHOALLSTAZ0','10','D','30','24',NULL,'Rider9 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ESHOALLSTAZ0','10','D','30','25',NULL,'Rider10',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ESHOALLSTAZ0','10','D','30','26',NULL,'Rider10 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ESHOALLSTAZ0','10','D','30','27',NULL,'Rider11',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ESHOALLSTAZ0','10','D','30','28',NULL,'Rider11 UnitsAmt',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ESHOALLSTAZ0','10','D','30','29',NULL,'Rider12',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ESHOALLSTAZ0','10','D','30','30',NULL,'Rider12 UnitsAmt',NULL,NULL,'"drvRider12UnitsAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ESHOALLSTAZ0','2','D','30','31',NULL,'Rate Mode',NULL,NULL,'"drvRateMode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ESHOALLSTAZ0','8','D','30','32',NULL,'Date of First Deduction',NULL,NULL,'"drvDateofFirstDeduction"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ESHOALLSTAZ0','8','D','30','33',NULL,'Requested Coverage Effective Date',NULL,NULL,'"drvReqCovEffDate"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ESHOALLSTAZ0','10','D','30','34',NULL,'Case Number',NULL,NULL,'"drvCaseNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ESHOALLSTAZ0','10','D','30','35',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ESHOALLSTAZ0','1','D','30','36',NULL,'Status Code',NULL,NULL,'"drvStatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ESHOALLSTAZ0','100','D','30','37',NULL,'Signed City and State',NULL,NULL,'"drvSignedCityandState"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ESHOALLSTAZ0','8','D','30','38',NULL,'Date signed by Employee',NULL,NULL,'"drvDatesignedbyEmployee"','(''UD112''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ESHOALLSTAZ0','35','D','30','39',NULL,'Producers name',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ESHOALLSTAZ0','10','D','30','40',NULL,'Servicing Agent Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ESHOALLSTAZ0','5','D','30','41',NULL,'Servicing Agent Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ESHOALLSTAZ0','10','D','30','42',NULL,'Writing Agent Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','ESHOALLSTAZ0','5','D','30','43',NULL,'Writing Agent Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','ESHOALLSTAZ0','10','D','30','44',NULL,'Other Agent1 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','ESHOALLSTAZ0','5','D','30','45',NULL,'Other Agent1 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','ESHOALLSTAZ0','10','D','30','46',NULL,'Other Agent2 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','ESHOALLSTAZ0','5','D','30','47',NULL,'Other Agent2 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','ESHOALLSTAZ0','10','D','30','48',NULL,'Other Agent3 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','ESHOALLSTAZ0','5','D','30','49',NULL,'Other Agent3 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','ESHOALLSTAZ0','10','D','30','50',NULL,'Other Agent4 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','ESHOALLSTAZ0','5','D','30','51',NULL,'Other Agent4 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','ESHOALLSTAZ0','10','D','30','52',NULL,'Other Agent5 Number',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','ESHOALLSTAZ0','5','D','30','53',NULL,'Other Agent5 Split',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','ESHOALLSTAZ0','8','D','30','54',NULL,'Requested Coverage End Date',NULL,NULL,'"drvReqCovEndDate"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESHOALLSTAZ0','2','D','40','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESHOALLSTAZ0','9','D','40','2',NULL,'Application ID (Employee SSN)',NULL,NULL,'"drvApplicationID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESHOALLSTAZ0','5','D','40','3',NULL,'Question Number',NULL,NULL,'"drvQuestionNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESHOALLSTAZ0','1','D','40','4',NULL,'Response',NULL,NULL,'"drvResponse"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESHOALLSTAZ0','70','D','40','5',NULL,'Person Name',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ESHOALLSTAZ0','2','D','50','1',NULL,'Record Type',NULL,NULL,'"drvRecordType"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ESHOALLSTAZ0','9','D','50','2',NULL,'Application ID (Employee SSN)',NULL,NULL,'"drvApplicationID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ESHOALLSTAZ0','1','D','50','3',NULL,'Coverage Level',NULL,NULL,'"drvCoverageLevel"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ESHOALLSTAZ0','1','D','50','4',NULL,'Section 125 (pre or post tax)',NULL,NULL,'"drvSection125"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ESHOALLSTAZ0','35','D','50','5',NULL,'Product Type/Name',NULL,NULL,'"drvProductTypeName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ESHOALLSTAZ0','35','D','50','6',NULL,'Plan Designation',NULL,NULL,'"drvPlanDesignation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ESHOALLSTAZ0','8','D','50','7',NULL,'Date of First Deduction',NULL,NULL,'"drvDateofFirstDed"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ESHOALLSTAZ0','8','D','50','8',NULL,'Requested Coverage Effective Date',NULL,NULL,'"drvReqCovEffDate"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ESHOALLSTAZ0','10','D','50','9',NULL,'Group Number',NULL,NULL,'"drvGroupNumber"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ESHOALLSTAZ0','5','D','50','10',NULL,'Account (Billing)',NULL,NULL,'"drvAccount"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ESHOALLSTAZ0','1','D','50','11',NULL,'Status Code',NULL,NULL,'"drvStatusCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ESHOALLSTAZ0','10','D','50','12',NULL,'Location (Billing)',NULL,NULL,'"drvLocation"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ESHOALLSTAZ0','8','D','50','13',NULL,'Location Effective Date',NULL,NULL,'"drvLocationEffDate"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ESHOALLSTAZ0','1','D','50','14',NULL,'Employer Paid 100%',NULL,NULL,'"drvEmployerPaid100"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ESHOALLSTAZ0','9','D','50','15',NULL,'Benefit/Face Amount',NULL,NULL,'"drvBenefitFaceAmt"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ESHOALLSTAZ0','8','D','50','16',NULL,'Requested Coverage End Date',NULL,NULL,'"drvReqCovEndDate"','(''UD112''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ESHOALLSTAZ0','2','D','50','17',NULL,'Filler',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ESHOALLSTAZ0','6','D','50','18',NULL,'Total Mode Premium',NULL,NULL,'""','(''SS''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ESHOALLSTAZ0','2','D','50','19',NULL,'Premium Billing Mode',NULL,NULL,'""','(''SS''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ESHOALLSTA_20220511.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Allstate AC and Hosp','202204209','EMPEXPORT','ONDEM_XOE',NULL,'ESHOALLSTA',NULL,NULL,NULL,'202204209','Apr 20 2022  3:41PM','Apr 20 2022  3:41PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Allstate AC and Hosp-Sched','202204209','EMPEXPORT','SCH_ESHOAL',NULL,'ESHOALLSTA',NULL,NULL,NULL,'202204209','Apr 20 2022  3:41PM','Apr 20 2022  3:41PM','202201011',NULL,'','','202201011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Allstate AC and Hosp-Test','202205029','EMPEXPORT','TEST_XOE','May  2 2022  1:05PM','ESHOALLSTA',NULL,NULL,NULL,'202205029','May  2 2022 12:00AM','Dec 30 1899 12:00AM','202204181','1992','','','202204181',dbo.fn_GetTimedKey(),NULL,'us3lKiSHO1011',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESHOALLSTA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESHOALLSTA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESHOALLSTA','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESHOALLSTA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESHOALLSTA','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESHOALLSTA','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESHOALLSTA','D10','dbo.U_ESHOALLSTA_01_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESHOALLSTA','D20','dbo.U_ESHOALLSTA_38_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESHOALLSTA','D30','dbo.U_ESHOALLSTA_40_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESHOALLSTA','D40','dbo.U_ESHOALLSTA_Q_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESHOALLSTA','D50','dbo.U_ESHOALLSTA_55_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ESHOALLSTA
-----------

IF OBJECT_ID('U_dsi_BDM_ESHOALLSTA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESHOALLSTA] (
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
-- Create table U_ESHOALLSTA_01_drvTbl
-----------

IF OBJECT_ID('U_ESHOALLSTA_01_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_01_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvApplicationID] char(11) NULL,
    [drvIsProposedInsured] varchar(1) NOT NULL,
    [drvIsEmployee] varchar(1) NOT NULL,
    [drvIsPolicyOwner] varchar(1) NOT NULL,
    [dvIsDependent] varchar(1) NOT NULL,
    [drvRelToPrimaryInsured] varchar(2) NULL,
    [drvRelToEmployee] varchar(2) NULL,
    [drvLNofTrustEstate] varchar(33) NULL,
    [drvFirstName] varchar(33) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvPersonSSN] varchar(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvHomePhoneNum] varchar(1) NOT NULL,
    [drvFullStreetAddress] varchar(511) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvEmployerAssocUnion] varchar(11) NOT NULL,
    [drvDateofHire] datetime NULL,
    [drvEmployeeEmail] varchar(50) NULL
);

-----------
-- Create table U_ESHOALLSTA_38_drvTbl
-----------

IF OBJECT_ID('U_ESHOALLSTA_38_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_38_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvRecordType] varchar(2) NULL,
    [drvApplicationID] char(11) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvSection125] varchar(1) NULL,
    [drvRate] money NULL,
    [drvBasePlanUnits] varchar(3) NULL,
    [drvRider1] varchar(6) NULL,
    [drvRider1UnitsAmt] varchar(3) NULL,
    [drvRider2] varchar(6) NULL,
    [drvRider2UnitsAmt] varchar(3) NULL,
    [drvRider3] varchar(6) NULL,
    [drvRider3UnitsAmt] varchar(3) NULL,
    [drvRider4] varchar(5) NULL,
    [drvRider4UnitsAmt] varchar(3) NULL,
    [drvRider5] varchar(5) NULL,
    [drvRider5UnitsAmt] varchar(3) NULL,
    [drvRider6] varchar(6) NULL,
    [drvRider6UnitsAmt] varchar(3) NULL,
    [drvDateofFirstDeduction] datetime NULL,
    [drvReqCovEffectiveDate] datetime NULL,
    [drvCaseNumber] varchar(5) NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvReqCovEndDate] datetime NULL,
    [drvSignedCityandState] varchar(14) NULL,
    [drvDateSignedbyEmp] datetime NULL
);

-----------
-- Create table U_ESHOALLSTA_40_drvTbl
-----------

IF OBJECT_ID('U_ESHOALLSTA_40_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_40_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvRecordType] varchar(2) NULL,
    [drvApplicationID] char(11) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvSection125] varchar(1) NULL,
    [drvBasicBenefitAmount] varchar(5) NULL,
    [drvTotalModePremium] money NULL,
    [drvRider1] varchar(6) NULL,
    [drvRider2] varchar(5) NULL,
    [drvRider3] varchar(6) NULL,
    [drvRider4] varchar(8) NULL,
    [drvRider5] varchar(8) NULL,
    [drvRider5UnitsAmt] varchar(3) NULL,
    [drvRider6] varchar(8) NULL,
    [drvRider12UnitsAmt] varchar(1) NOT NULL,
    [drvRateMode] varchar(2) NULL,
    [drvDateofFirstDeduction] datetime NULL,
    [drvReqCovEffDate] datetime NULL,
    [drvCaseNumber] varchar(5) NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvSignedCityandState] varchar(14) NULL,
    [drvDatesignedbyEmployee] datetime NULL,
    [drvReqCovEndDate] datetime NULL
);

-----------
-- Create table U_ESHOALLSTA_55_drvTbl
-----------

IF OBJECT_ID('U_ESHOALLSTA_55_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_55_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvRecordType] varchar(2) NULL,
    [drvApplicationID] char(11) NULL,
    [drvCoverageLevel] varchar(1) NULL,
    [drvSection125] varchar(1) NULL,
    [drvProductTypeName] varchar(4) NULL,
    [drvPlanDesignation] varchar(3) NULL,
    [drvDateofFirstDed] datetime NULL,
    [drvReqCovEffDate] datetime NULL,
    [drvGroupNumber] varchar(5) NULL,
    [drvAccount] varchar(1) NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvLocation] varchar(1) NULL,
    [drvLocationEffDate] datetime NULL,
    [drvEmployerPaid100] varchar(1) NULL,
    [drvBenefitFaceAmt] varchar(1) NULL,
    [drvReqCovEndDate] datetime NULL
);

-----------
-- Create table U_ESHOALLSTA_Audit
-----------

IF OBJECT_ID('U_ESHOALLSTA_Audit') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_Audit] (
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
-- Create table U_ESHOALLSTA_AuditFields
-----------

IF OBJECT_ID('U_ESHOALLSTA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ESHOALLSTA_DedList
-----------

IF OBJECT_ID('U_ESHOALLSTA_DedList') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ESHOALLSTA_EEList
-----------

IF OBJECT_ID('U_ESHOALLSTA_EEList') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ESHOALLSTA_File
-----------

IF OBJECT_ID('U_ESHOALLSTA_File') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);

-----------
-- Create table U_ESHOALLSTA_PDedHist
-----------

IF OBJECT_ID('U_ESHOALLSTA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_PDedHist] (
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
-- Create table U_ESHOALLSTA_PEarHist
-----------

IF OBJECT_ID('U_ESHOALLSTA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_PEarHist] (
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

-----------
-- Create table U_ESHOALLSTA_Q_drvTbl
-----------

IF OBJECT_ID('U_ESHOALLSTA_Q_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESHOALLSTA_Q_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drvRecordType] varchar(2) NULL,
    [drvApplicationID] char(11) NULL,
    [drvQuestionNumber] varchar(3) NULL,
    [drvResponse] varchar(1) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESHOALLSTA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Shoe Palace

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 04/20/2022
Service Request Number: TekP-2021-09-13-0001

Purpose: Allstate AC and Hosp

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESHOALLSTA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESHOALLSTA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESHOALLSTA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESHOALLSTA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESHOALLSTA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESHOALLSTA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESHOALLSTA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESHOALLSTA', 'SCH_ESHOAL';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESHOALLSTA';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ESHOALLSTA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESHOALLSTA';

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
    DELETE FROM dbo.U_ESHOALLSTA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESHOALLSTA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESHOALLSTA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_AuditFields;
    CREATE TABLE dbo.U_ESHOALLSTA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ESHOALLSTA_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_ESHOALLSTA_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_ESHOALLSTA_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESHOALLSTA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_Audit;
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
    INTO dbo.U_ESHOALLSTA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ESHOALLSTA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESHOALLSTA_Audit ON dbo.U_ESHOALLSTA_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACC, ACCI, CIE10, CIE1S, CIE20, CIE2S, CIF10, CIF1S, CIF20, CIF2S, HOSP';

    IF OBJECT_ID('U_ESHOALLSTA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESHOALLSTA_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','ACC, ACCI, CIE10, CIE1S, CIE20, CIE2S, CIF10, CIF1S, CIF20, CIF2S, HOSP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS, DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','DIS, CHL, DPC, STC');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESHOALLSTA_01_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESHOALLSTA_01_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_01_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepssn
        -- standard fields above and additional driver fields below
        ,drvApplicationID = eepssn
        ,drvIsProposedInsured =       CASE	WHEN BdmRelationship = 'Emp' THEN 'Y' else  'N' END
        ,drvIsEmployee =			  CASE	WHEN BdmRelationship = 'Emp' THEN 'Y' else  'N' END
        ,drvIsPolicyOwner =           CASE	WHEN BdmRelationship = 'Emp' THEN 'Y' else  'N' END
        ,dvIsDependent =              CASE	WHEN BdmRelationship = 'Emp' THEN 'N' else  'Y' END
        ,drvRelToPrimaryInsured =     CASE  WHEN ConRelationship = 'DAD' THEN '02'
											WHEN ConRelationship = 'MOM' THEN '01'
											WHEN ConRelationship = 'PRT' THEN '34'
											WHEN ConRelationship = 'OTH' THEN '13'
											WHEN ConRelationship = 'BRO' THEN '03'
											WHEN ConRelationship = 'SIS' THEN '04'
											WHEN ConRelationship = 'SBL' THEN '16'
											WHEN ConRelationship = 'SPS' THEN '12'
											WHEN ConRelationship = 'GRC' THEN '20' 
											WHEN ConRelationship = 'DP' THEN '35'
											WHEN ConRelationship = 'CHL' THEN '17'
											WHEN ConRelationship = 'FIA' THEN '24'
											WHEN ConRelationship = 'COU' THEN '25'
											WHEN ConRelationship is null THEN '14'
											END
        ,drvRelToEmployee =       CASE		WHEN ConRelationship = 'DAD' THEN '02'
											WHEN ConRelationship = 'MOM' THEN '01'
											WHEN ConRelationship = 'PRT' THEN '34'
											WHEN ConRelationship = 'OTH' THEN '13'
											WHEN ConRelationship = 'BRO' THEN '03'
											WHEN ConRelationship = 'SIS' THEN '04'
											WHEN ConRelationship = 'SBL' THEN '16'
											WHEN ConRelationship = 'SPS' THEN '12'
											WHEN ConRelationship = 'GRC' THEN '20' 
											WHEN ConRelationship = 'DP' THEN '35'
											WHEN ConRelationship = 'CHL' THEN '17'
											WHEN ConRelationship = 'FIA' THEN '24'
											WHEN ConRelationship = 'COU' THEN '25'
											WHEN ConRelationship is null THEN '14'
											END
        ,drvLNofTrustEstate = Substring(CASE WHEN BdmRelationship = 'Emp' THEN eepnamelast else connamelast END,1,33)
        ,drvFirstName = Substring(CASE WHEN BdmRelationship = 'Emp' THEN EepNameFirst else connamefirst END,1,33)
        ,drvMiddleInitial = CASE WHEN BdmRelationship = 'Emp' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END
        ,drvPersonSSN = CASE WHEN BdmRelationship = 'Emp' then eepSSN else CASE WHEN ConSSN is null then '000000000' ELSE ConSSN END END
        ,drvGender = CASE WHEN BdmRelationship = 'Emp' THEN EepGender else ConGender END
        ,drvDateofBirth = CASE WHEN BdmRelationship = 'Emp' THEN eepdateofbirth else  condateofbirth END
        ,drvHomePhoneNum = ''
        ,drvFullStreetAddress = eepaddressLine1 + '' + eepaddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvEmployerAssocUnion = CASE WHEN BdmRelationship = 'Emp' THEN 'Shoe Palace' else '' END
        ,drvDateofHire = eecdateoflasthire
        ,drvEmployeeEmail = EepAddressEMail
    INTO dbo.U_ESHOALLSTA_01_drvTbl
    FROM dbo.U_ESHOALLSTA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID= xCoID
    JOIN dbo.U_dsi_BDM_ESHOALLSTA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESHOALLSTA_38_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESHOALLSTA_38_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_38_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvRecordType =    CASE	WHEN BdmDedCode in ('ACC', 'ACCI') THEN '38' END
        ,drvApplicationID = CASE	WHEN BdmDedCode in ('ACC', 'ACCI') THEN eepssn END 
        ,drvCoverageTier =    CASE  WHEN BdmDedCode in ('ACC', 'ACCI')  and BdmBenOption = 'EE' THEN '1'
                                    WHEN BdmDedCode in ('ACC', 'ACCI')  and BdmBenOption = 'EECS' THEN '3'
                                    WHEN BdmDedCode in ('ACC', 'ACCI')  and BdmBenOption = 'EEF' THEN '4'
                                    WHEN BdmDedCode in ('ACC', 'ACCI')  and BdmBenOption = 'EES' THEN '2'
                                    END
        ,drvSection125 =    CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'N' END
        ,drvRate =            CASE  WHEN BdmDedCode in ('ACC', 'ACCI') THEN (CorEERate*2)*100 END
        ,drvBasePlanUnits = CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN '300' END
        ,drvRider1 =        CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'GP6AUC' END
        ,drvRider1UnitsAmt = CASE   WHEN BdmDedCode in ('ACC', 'ACCI') THEN '200' END
        ,drvRider2 =        CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'GP6ERS' END
        ,drvRider2UnitsAmt = CASE   WHEN BdmDedCode in ('ACC', 'ACCI') THEN '150' END
        ,drvRider3 =        CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'GP6OPT' END
        ,drvRider3UnitsAmt = CASE   WHEN BdmDedCode in ('ACC', 'ACCI') THEN '100' END
        ,drvRider4 =        CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'GP6DF' END
        ,drvRider4UnitsAmt = CASE   WHEN BdmDedCode in ('ACC', 'ACCI') THEN '200' END
        ,drvRider5 =        CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'GP6BE' END
        ,drvRider5UnitsAmt = CASE   WHEN BdmDedCode in ('ACC', 'ACCI') THEN '150' END
        ,drvRider6 =        CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'GP6ADD' END
        ,drvRider6UnitsAmt = CASE   WHEN BdmDedCode in ('ACC', 'ACCI') THEN '150' END
        ,drvDateofFirstDeduction = CASE WHEN BdmDedCode in ('ACC', 'ACCI') THEN BdmBenStartDate END
        ,drvReqCovEffectiveDate = CASE WHEN BdmDedCode in ('ACC', 'ACCI') THEN CASE WHEN BdmBenStartDate < 2022-01-01 THEN 2022-01-01 ELSE BdmBenStartDate END END
        ,drvCaseNumber =    CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN '49365' END
        ,drvStatusCode = CASE        WHEN eecemplstatus = 'T' THEN 'T'
                                    WHEN eecemplstatus = 'A' and Bdmdedcode in ('ACC', 'ACCI') and Bdmbenstatus <> 'A' THEN 'X' 
                                    END
        ,drvReqCovEndDate = CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN BdmBenStopDate END
        ,drvSignedCityandState = CASE WHEN BdmDedCode in ('ACC', 'ACCI') THEN 'MORGAN HILL CA' END
        ,drvDateSignedbyEmp = CASE    WHEN BdmDedCode in ('ACC', 'ACCI') THEN DATEADD(dd,-1,GetDate()) END
    INTO dbo.U_ESHOALLSTA_38_drvTbl
    FROM dbo.U_ESHOALLSTA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID= xCoID
    JOIN dbo.U_dsi_BDM_ESHOALLSTA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
		AND BdmDedCode in ('ACC', 'ACCI')
    LEFT JOIN OptRate  WITH (NOLOCK)
        ON CorDedCode = BdmDedCode
        AND CorBenOption = BdmBenOption
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESHOALLSTA_40_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESHOALLSTA_40_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_40_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvRecordType =        CASE    WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN '40'
                                        WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN '40'
                                        END
        ,drvApplicationID =     CASE    WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN eepssn
                                        WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN eepssn
                                        END
        ,drvCoverageTier =        CASE  WHEN Bdmdedcode in ('CIE10', 'CIE1S') THEN '1'
                                        WHEN Bdmdedcode in ('CIF10', 'CIF1S') THEN '4'
                                        WHEN Bdmdedcode in ('CIE20', 'CIE2S') THEN '1'
                                        WHEN Bdmdedcode in ('CIF20', 'CIF2S') THEN '4'
                                        END
        ,drvSection125 =        CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'N'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'N'
                                        END
        ,drvBasicBenefitAmount =CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN '10000'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN '20000'
                                        END
        ,drvTotalModePremium = CASE     WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN (RatEERateNSFemale*10000)*2 
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN (RatEERateNSFemale*10000)*2 
                                        END
        ,drvRider1 =            CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'CIHCR2'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'CIHCR2'
                                        END
        ,drvRider2 =            CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'CICR1'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'CICR1'
                                        END
        ,drvRider3 =            CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'CIHCR1'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'CIHCR1'
                                        END
        ,drvRider4 =            CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'GCIP4SR2'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'GCIP4SR2'
                                        END
        ,drvRider5 =            CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'GCIP4FWR'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'GCIP4FWR'
                                        END
        ,drvRider5UnitsAmt =    CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN '400'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN '400'
                                        END
        ,drvRider6 =            CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'GCIP4SCR'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'GCIP4SCR'
                                        END
        ,drvRider12UnitsAmt = ''
        ,drvRateMode =          CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN '12'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN '12'
                                        END
        ,drvDateofFirstDeduction = CASE WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN BdmBenStartDate
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN BdmBenStartDate
                                        END
        ,drvReqCovEffDate =     CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN CASE WHEN BdmBenStartDate < 2022-01-01 THEN 2022-01-01 ELSE BdmBenStartDate END
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN CASE WHEN BdmBenStartDate < 2022-01-01 THEN 2022-01-01 ELSE BdmBenStartDate END
                                        END
        ,drvCaseNumber =        CASE    WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN '49365'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN '49365'
                                        END
        ,drvStatusCode =        CASE    WHEN eecemplstatus = 'T' THEN 'T'
                                        WHEN eecemplstatus = 'A' and Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') and Bdmbenstatus <> 'A' THEN 'X'
                                        WHEN eecemplstatus = 'A' and Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') and Bdmbenstatus <> 'A' THEN 'X'
                                        END
        ,drvSignedCityandState = CASE   WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN 'MORGAN HILL CA'
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN 'MORGAN HILL CA'
                                        END
        ,drvDatesignedbyEmployee = CASE WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN DATEADD(dd,-1,GetDate()) 
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN DATEADD(dd,-1,GetDate())
                                        END
        ,drvReqCovEndDate =        CASE WHEN Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10') THEN BdmBenStopDate
                                        WHEN Bdmdedcode in ('CIE2S', 'CIE20', 'CIF2S','CIF20') THEN BdmBenStopDate 
                                        END
    INTO dbo.U_ESHOALLSTA_40_drvTbl
    FROM dbo.U_ESHOALLSTA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESHOALLSTA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
		AND Bdmdedcode in ('CIE1S', 'CIE10', 'CIF1S','CIF10','CIE2S', 'CIE20', 'CIF2S','CIF20') 
    LEFT JOIN (select EepEEID, BdmdedCode as dedcode, EepDateofBirth, BdmBenStartDate as StartDate, DATEDIFF(year, EepDateOfBirth, BdmBenStartDate) as Age From dbo.EmpPers WITH (NOLOCK) JOIN dbo.U_dsi_BDM_ESHOALLSTA WITH (NOLOCK) on BdmEEID = EepEEID) AGETB 
        ON AGETB.EepEEID = BdmEEID
        AND AGETB.DedCode = BdmDedCode
    LEFT JOIN dbo.InsRate WITH (NOLOCK)
        ON AGETB.Age > RatMinAge 
        AND AGETB.Age <= RatMaxAge 
        and RatDedCode = AGETB.DedCode
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESHOALLSTA_Q_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESHOALLSTA_Q_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_Q_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvRecordType =    CASE    WHEN BdmRelationship = 'Emp' THEN '15'
                                    WHEN BdmRelationship in ('SPS', 'DPC') THEN '29'
                                    END
        ,drvApplicationID = EepSSN
        ,drvQuestionNumber = CASE   WHEN BdmRelationship = 'Emp' THEN '214'
                                    WHEN conrelationship in ('SPS', 'DPC') THEN '215'
                                    END
        ,drvResponse =       CASE   WHEN BdmRelationship = 'Emp' THEN EepIsSmoker 
                                    WHEN BdmRelationship in ('SPS', 'DPC') THEN ConIsSmoker
                                    END
    INTO dbo.U_ESHOALLSTA_Q_drvTbl
    FROM dbo.U_ESHOALLSTA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESHOALLSTA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
		AND BdmRelationship in ('SPS', 'DPC','Emp')
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_ESHOALLSTA_55_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESHOALLSTA_55_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESHOALLSTA_55_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvRecordType =      CASE  WHEN Bdmdedcode = 'HOSP' THEN '55' END
        ,drvApplicationID =   CASE  WHEN Bdmdedcode = 'HOSP' THEN eepssn END
        ,drvCoverageLevel =   CASE  WHEN Bdmdedcode = 'HOSP' AND BdmBenOption = 'EE' THEN '1'
									WHEN Bdmdedcode = 'HOSP' AND BdmBenOption = 'EES' THEN '2'
                                    WHEN Bdmdedcode = 'HOSP' AND BdmBenOption = 'EECS' THEN '3'
                                    WHEN Bdmdedcode = 'HOSP' AND BdmBenOption = 'EEF' THEN '4'
                                    END
        ,drvSection125 =      CASE  WHEN Bdmdedcode = 'HOSP' THEN 'N' END
        ,drvProductTypeName = CASE  WHEN Bdmdedcode = 'HOSP' THEN 'GIM2' END
        ,drvPlanDesignation = CASE  WHEN Bdmdedcode = 'HOSP' THEN 'HSA' END
        ,drvDateofFirstDed =  CASE  WHEN Bdmdedcode = 'HOSP' THEN BdmBenStartDate END
        ,drvReqCovEffDate =   CASE  WHEN Bdmdedcode = 'HOSP' THEN CASE WHEN BdmBenStartDate < 2022-01-01 THEN 2022-01-01 ELSE BdmBenStartDate END
                                    END
        ,drvGroupNumber =     CASE  WHEN Bdmdedcode = 'HOSP' THEN '96818' END
        ,drvAccount =         CASE  WHEN Bdmdedcode = 'HOSP' THEN '1' END
        ,drvStatusCode =      CASE  WHEN eecemplstatus = 'T' THEN 'T'
                                    WHEN eecemplstatus = 'A' and Bdmdedcode = 'HOSP' and Bdmbenstatus <> 'A' THEN 'X'
                                    END
        ,drvLocation =        CASE  WHEN Bdmdedcode = 'HOSP' THEN '1' END
        ,drvLocationEffDate = CASE  WHEN Bdmdedcode = 'HOSP' THEN CASE WHEN BdmBenStartDate < 2022-01-01 THEN 2022-01-01 ELSE BdmBenStartDate END
                                    END
        ,drvEmployerPaid100 = CASE  WHEN Bdmdedcode = 'HOSP' THEN 'N' END
        ,drvBenefitFaceAmt =  CASE  WHEN Bdmdedcode = 'HOSP' THEN '0' END
        ,drvReqCovEndDate =   CASE  WHEN Bdmdedcode = 'HOSP' THEN BdmBenStopDate END
    INTO dbo.U_ESHOALLSTA_55_drvTbl
    FROM dbo.U_ESHOALLSTA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
            ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESHOALLSTA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
		AND Bdmdedcode = 'HOSP' 
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'test_tekpartnersukg_shoepalace_multiplan_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                                  ELSE 'tekpartnersukg_shoepalace_multiplan_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.csv'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESHOALLSTA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESHOALLSTA_File WITH (NOLOCK)
    ORDER BY InitialSort, RIGHT(RecordSet,2);

--Check out iascDefF 
SELECT * FROM dbo.iascDefF WITH (NOLOCK)
WHERE AdfHeaderSystemID LIKE 'ESHOALLSTA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202204131'
       ,expStartPerControl     = '202204131'
       ,expLastEndPerControl   = '202204209'
       ,expEndPerControl       = '202204209'
WHERE expFormatCode = 'ESHOALLSTA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESHOALLSTA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESHOALLSTA_File WITH (NOLOCK)
    ORDER BY InitialSort, RIGHT(RecordSet,2)

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ESHOALLSTA' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ESHOALLSTA'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ESHOALLSTA'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESHOALLSTA', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ESHOALLSTA', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ESHOALLSTA', 'UseFileName', 'V', 'Y'


-- End ripout