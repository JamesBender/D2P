/**********************************************************************************


>>>>>> NOTE: this ripout is cloned from EDDPMASLHA


EDDPMASLH2: Decision Design PM

FormatCode:     EDDPMASLH2
Project:        Decision Design PM
Client ID:      AME1077
Date/time:      2023-11-27 11:16:22.777
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW3WUP3DB03
Database:       ULTIPRO_WPASLHA
Web Filename:   AME1077_F3A0E_EEHISTORY_EDDPMASLH2_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EDDPMASLH2_SavePath') IS NOT NULL DROP TABLE dbo.U_EDDPMASLH2_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EDDPMASLH2'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EDDPMASLH2')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EDDPMASLH2'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EDDPMASLH2'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EDDPMASLH2'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EDDPMASLH2'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EDDPMASLH2'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EDDPMASLH2'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EDDPMASLH2'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EDDPMASLH2'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EDDPMASLH2'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEDDPMASLH2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDDPMASLH2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDDPMASLH2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDDPMASLH2];
GO
IF OBJECT_ID('U_EDDPMASLH2_File') IS NOT NULL DROP TABLE [dbo].[U_EDDPMASLH2_File];
GO
IF OBJECT_ID('U_EDDPMASLH2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDDPMASLH2_EEList];
GO
IF OBJECT_ID('U_dsi_EDDPMASLH2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EDDPMASLH2_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','EDDPMASLH2','Decision Design PM','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','210456','S','N','F32VBA000040','N','Dec 19 2015 12:03PM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','F32VBA000040','10','H','01','1',NULL,NULL,NULL,NULL,'"EmployeeID"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','F32VBA000040','8','H','01','11',NULL,NULL,NULL,NULL,'"LastName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','F32VBA000040','9','H','01','19',NULL,NULL,NULL,NULL,'"FirstName"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','F32VBA000040','2','H','01','28',NULL,NULL,NULL,NULL,'"MI"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','F32VBA000040','5','H','01','30',NULL,NULL,NULL,NULL,'"eMail"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','F32VBA000040','4','H','01','35',NULL,NULL,NULL,NULL,'"Team"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','F32VBA000040','7','H','01','39',NULL,NULL,NULL,NULL,'"Cluster"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','F32VBA000040','5','H','01','46',NULL,NULL,NULL,NULL,'"Group"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','F32VBA000040','3','H','01','51',NULL,NULL,NULL,NULL,'"EEO"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','F32VBA000040','9','H','01','54',NULL,NULL,NULL,NULL,'"Job Title"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','F32VBA000040','8','H','01','63',NULL,NULL,NULL,NULL,'"HireDate"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','F32VBA000040','13','H','01','71',NULL,NULL,NULL,NULL,'"Position Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','F32VBA000040','4','H','01','84',NULL,NULL,NULL,NULL,'"FLSA"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','F32VBA000040','13','H','01','88',NULL,NULL,NULL,NULL,'"Date of Birth"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','F32VBA000040','6','H','01','101',NULL,NULL,NULL,NULL,'"Gender"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','F32VBA000040','11','H','01','107',NULL,NULL,NULL,NULL,'"Ethnic Code"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','F32VBA000040','5','H','01','118',NULL,NULL,NULL,NULL,'"Coach"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','F32VBA000040','21','H','01','123',NULL,NULL,NULL,NULL,'"Executive Team Member"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','F32VBA000040','11','H','01','144',NULL,NULL,NULL,NULL,'"Active User"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','F32VBA000040','16','H','01','155',NULL,NULL,NULL,NULL,'"Job Description0"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','F32VBA000040','16','H','01','171',NULL,NULL,NULL,NULL,'"Job Description1"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','F32VBA000040','16','H','01','187',NULL,NULL,NULL,NULL,'"Job Description2"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','F32VBA000040','16','H','01','203',NULL,NULL,NULL,NULL,'"Job Description3"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','F32VBA000040','16','H','01','219',NULL,NULL,NULL,NULL,'"Job Description4"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','F32VBA000040','16','H','01','235',NULL,NULL,NULL,NULL,'"Job Description5"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','F32VBA000040','16','H','01','251',NULL,NULL,NULL,NULL,'"Job Description6"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','F32VBA000040','16','H','01','267',NULL,NULL,NULL,NULL,'"Job Description7"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','F32VBA000040','16','H','01','283',NULL,NULL,NULL,NULL,'"Job Description8"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','F32VBA000040','16','H','01','299',NULL,NULL,NULL,NULL,'"Job Description9"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','F32VBA000040','17','H','01','315',NULL,NULL,NULL,NULL,'"Job Description10"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','F32VBA000040','17','H','01','332',NULL,NULL,NULL,NULL,'"Job Description11"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','F32VBA000040','17','H','01','349',NULL,NULL,NULL,NULL,'"Job Description12"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','F32VBA000040','17','H','01','366',NULL,NULL,NULL,NULL,'"Job Description13"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','F32VBA000040','17','H','01','383',NULL,NULL,NULL,NULL,'"Job Description14"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','F32VBA000040','17','H','01','400',NULL,NULL,NULL,NULL,'"Job Description15"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','F32VBA000040','17','H','01','417',NULL,NULL,NULL,NULL,'"Job Description16"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','F32VBA000040','17','H','01','434',NULL,NULL,NULL,NULL,'"Job Description17"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','F32VBA000040','17','H','01','451',NULL,NULL,NULL,NULL,'"Job Description18"','(''DA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','F32VBA000040','17','H','01','468',NULL,NULL,NULL,NULL,'"Job Description19"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','F32VBA000040','16','D','02','1',NULL,'EmployeeID',NULL,NULL,'"drvEmployeeID"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','F32VBA000040','50','D','02','17',NULL,'LastName',NULL,NULL,'"drvLastName"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','F32VBA000040','50','D','02','67',NULL,'FirstName',NULL,NULL,'"drvFirstName"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','F32VBA000040','1','D','02','117',NULL,'MI',NULL,NULL,'"drvMI"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','F32VBA000040','50','D','02','118',NULL,'eMail',NULL,NULL,'"drveMail"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','F32VBA000040','16','D','02','168',NULL,'Team',NULL,NULL,'"drvTeam"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','F32VBA000040','46','D','02','184',NULL,'Cluster',NULL,NULL,'"drvCluster"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','F32VBA000040','16','D','02','230',NULL,'Group',NULL,NULL,'"drvGroup"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','F32VBA000040','16','D','02','246',NULL,'EEO',NULL,NULL,'"drvEEO"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','F32VBA000040','50','D','02','262',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','F32VBA000040','20','D','02','312',NULL,'HireDate',NULL,NULL,'"drvHireDate"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','F32VBA000040','16','D','02','332',NULL,'Position Code',NULL,NULL,'"drvPositionCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','F32VBA000040','16','D','02','348',NULL,'FLSA',NULL,NULL,'"drvFLSA"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','F32VBA000040','20','D','02','364',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD101''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','F32VBA000040','1','D','02','384',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','F32VBA000040','16','D','02','385',NULL,'Ethnic Code',NULL,NULL,'"drvEthnicCode"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','F32VBA000040','20','D','02','401',NULL,'Coach',NULL,NULL,'"drvCoach"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','F32VBA000040','20','D','02','421',NULL,'Executive Team Member',NULL,NULL,'"drvExecutiveTeamMember"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','F32VBA000040','16','D','02','441',NULL,'Active User',NULL,NULL,'"drvActiveUser"','(''UA''=''T,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','F32VBA000040','9999','D','02','457',NULL,NULL,NULL,NULL,'"drvJobLongDesc0"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','F32VBA000040','9999','D','02','20457',NULL,NULL,NULL,NULL,'"drvJobLongDesc1"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','F32VBA000040','9999','D','02','30457',NULL,NULL,NULL,NULL,'"drvJobLongDesc2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','F32VBA000040','9999','D','02','40457',NULL,NULL,NULL,NULL,'"drvJobLongDesc3"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','F32VBA000040','9999','D','02','50457',NULL,NULL,NULL,NULL,'"drvJobLongDesc4"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','F32VBA000040','9999','D','02','60457',NULL,NULL,NULL,NULL,'"drvJobLongDesc5"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','F32VBA000040','9999','D','02','70457',NULL,NULL,NULL,NULL,'"drvJobLongDesc6"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','F32VBA000040','9999','D','02','80457',NULL,NULL,NULL,NULL,'"drvJobLongDesc7"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','F32VBA000040','9999','D','02','90457',NULL,NULL,NULL,NULL,'"drvJobLongDesc8"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','F32VBA000040','9999','D','02','100457',NULL,NULL,NULL,NULL,'"drvJobLongDesc9"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','F32VBA000040','9999','D','02','110457',NULL,NULL,NULL,NULL,'"drvJobLongDesc10"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','F32VBA000040','9999','D','02','120457',NULL,NULL,NULL,NULL,'"drvJobLongDesc11"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','F32VBA000040','9999','D','02','130457',NULL,NULL,NULL,NULL,'"drvJobLongDesc12"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','F32VBA000040','9999','D','02','140457',NULL,NULL,NULL,NULL,'"drvJobLongDesc13"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','F32VBA000040','9999','D','02','150457',NULL,NULL,NULL,NULL,'"drvJobLongDesc14"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','F32VBA000040','9999','D','02','160457',NULL,NULL,NULL,NULL,'"drvJobLongDesc15"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','F32VBA000040','9999','D','02','170457',NULL,NULL,NULL,NULL,'"drvJobLongDesc16"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','F32VBA000040','9999','D','02','180457',NULL,NULL,NULL,NULL,'"drvJobLongDesc17"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','F32VBA000040','9999','D','02','190457',NULL,NULL,NULL,NULL,'"drvJobLongDesc18"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','F32VBA000040','9999','D','02','200457',NULL,NULL,NULL,NULL,'"drvJobLongDesc19"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EDDPMASLH2_20231127.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',NULL,NULL,NULL,NULL,'Decision Design - Daily - REG','201908219','EMPEXPORT','DDREG','Aug 22 2019 12:00AM','EDDPMASLH2',NULL,NULL,NULL,'202311279','Aug 21 2019 12:00AM','Dec 30 1899 12:00AM','202311261',NULL,NULL,NULL,'201908201',dbo.fn_GetTimedKey(),NULL,'ULTI_WPASLHA',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DRG','201908219','EMPEXPORT','DREG',NULL,'EDDPMASLH2',NULL,NULL,NULL,'201908219',NULL,NULL,'201908201',NULL,NULL,NULL,'201908201',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'OEACTIVE - Decision Design PM','201512199','EMPEXPORT','OEACTIVE',NULL,'EDDPMASLH2',NULL,NULL,NULL,'201512199',NULL,NULL,'201509201',NULL,NULL,NULL,'201509201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'OEPASSIVE - Decision Design PM','201512199','EMPEXPORT','OEPASSIVE',NULL,'EDDPMASLH2',NULL,NULL,NULL,'201512199',NULL,NULL,'201509201',NULL,NULL,NULL,'201509201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'TEST - Decision Design PM','202310051','EMPEXPORT','TEST','Oct  5 2023  6:22PM','EDDPMASLH2',NULL,NULL,NULL,'202310051','Oct  5 2023 12:00AM','Dec 30 1899 12:00AM','202309151','479',NULL,NULL,'202309151',dbo.fn_GetTimedKey(),NULL,'us3kEpAME1077A',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'unlock EDDPMASLH2','201512199','EMPEXPORT','ZAP',NULL,'EDDPMASLH2',NULL,NULL,NULL,'201512199',NULL,NULL,'201509201',NULL,NULL,NULL,'201509201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','ExportDescription','C','Decision Design PM - ASLHA');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','InitialSort','C','drvLastName');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','MaxFileLength','C','446');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','SubSort','C','drvFirstName');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','SystemID','V','D4E6D76B0467');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDDPMASLH2','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDDPMASLH2','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDDPMASLH2','D02','dbo.U_dsi_EDDPMASLH2_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_EDDPMASLH2_drvTbl
-----------

IF OBJECT_ID('U_dsi_EDDPMASLH2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EDDPMASLH2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvSortKey] varchar(1) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMI] varchar(1) NOT NULL,
    [drveMail] varchar(50) NULL,
    [drvTeam] varchar(10) NULL,
    [drvCluster] varchar(25) NULL,
    [drvGroup] varchar(10) NULL,
    [drvEEO] char(3) NOT NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvPositionCode] char(8) NULL,
    [drvFLSA] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvEthnicCode] varchar(3) NOT NULL,
    [drvCoach] varchar(1) NOT NULL,
    [drvExecutiveTeamMember] varchar(1) NOT NULL,
    [drvActiveUser] varchar(1) NOT NULL,
    [drvJobLongDesc] varchar(max) NULL,
    [drvJobLongDesc0] varchar(max) NULL,
    [drvJobLongDesc1] varchar(max) NULL,
    [drvJobLongDesc2] varchar(max) NULL,
    [drvJobLongDesc3] varchar(max) NULL,
    [drvJobLongDesc4] varchar(max) NULL,
    [drvJobLongDesc5] varchar(max) NULL,
    [drvJobLongDesc6] varchar(max) NULL,
    [drvJobLongDesc7] varchar(max) NULL,
    [drvJobLongDesc8] varchar(max) NULL,
    [drvJobLongDesc9] varchar(max) NULL,
    [drvJobLongDesc10] varchar(max) NULL,
    [drvJobLongDesc11] varchar(max) NULL,
    [drvJobLongDesc12] varchar(max) NULL,
    [drvJobLongDesc13] varchar(max) NULL,
    [drvJobLongDesc14] varchar(max) NULL,
    [drvJobLongDesc15] varchar(max) NULL,
    [drvJobLongDesc16] varchar(max) NULL,
    [drvJobLongDesc17] varchar(max) NULL,
    [drvJobLongDesc18] varchar(max) NULL,
    [drvJobLongDesc19] varchar(max) NULL
);

-----------
-- Create table U_EDDPMASLH2_EEList
-----------

IF OBJECT_ID('U_EDDPMASLH2_EEList') IS NULL
CREATE TABLE [dbo].[U_EDDPMASLH2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EDDPMASLH2_File
-----------

IF OBJECT_ID('U_EDDPMASLH2_File') IS NULL
CREATE TABLE [dbo].[U_EDDPMASLH2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EDDPMASLH2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EDDPMASLH2',getdate(),'P','V1.VK'
*/

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDDPMASLH2]
 @systemid varchar(12) = ''
AS
Begin

/*************************************************************************************************
DRIVER TABLE SP FOR:  Decision Design - Performance Management File
BUILT FOR: American Speech-Language-Hearing Association
ORIGINAL BUILD (V-1.0): 12/19/2015 - chas   - SF 06065208
Updated 2/27/2019 - Sean Hawkins - SR-2019-00226045  - Added JbcNotes for testing
Updated 8/22/2019 - Sean Hawkins - more updates per request, added 19 fields with 9999K each field for job notes - switchbox can't go to 10k or above for field length



SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDDPMASLH2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDDPMASLH2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDDPMASLH2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDDPMASLH2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDDPMASLH2' ORDER BY RunID DESC;

update U_dsi_Configuration set cfgvalue = NULL where formatcode = 'EDDPMASLH2' and cfgname = 'ExportPath'


dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','EDDPMASLH2'
dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','OEACTIVE'
dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','OEPASSIVE'
dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','TEST'

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDDPMASLH2',  @IsWeb = 'Y';
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

 /***************************
 COLLECT DATE PARAMETERS
 ****************************/
 DECLARE 
  @StartDate DATETIME,
  @EndDate DATETIME,
  @StartPerControl Char(9),
  @EndPerControl Char(9),
  @FormatCode Char(10),
  @ExportCode Char(10),
  @ExportFile char(200)
  
 -- Declare @Systemid char(12) 
 -- set @Systemid = '6DWPQL0000K0'

 SELECT 
  @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
  @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
  @StartPerControl = startpercontrol,
  @EndPerControl  = endpercontrol,
  @FormatCode = rtrim(formatcode),
  @ExportCode = Exportcode,
  @Exportfile = ExportFile

 FROM dbo.U_Dsi_Parameters 
 WHERE SystemID = @SystemID

  
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 14 -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment (OBSOLETE)
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown (OBSOLETE)
set @oetype = 'F'  -- P or F indicates if this export is for a passive or full(active) oe (OBSOLETE)

-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
   delete dbo.u_EDDPMASLH2_EELIST
   from dbo.u_EDDPMASLH2_EELIST
   join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
   where t.eecemplstatus = 'T'
   and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
    and a.eecemplstatus <> 'T')

end

--BDM
-- replace EMARAACPOE with the OE session if applicable

/*NO BDM necessary for this export:

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','MED, MED2, MEDCT, MED2CT')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedTypes', 'ZZZ')

-- select deddedtype, deddedcode, dedlongdesc from dedcode order by 2

IF @ExportCode not in ('OEACTIVE','OEPASSIVE') BEGIN
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate) --@EndDate - @daysstopped)
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode in ('OEACTIVE','OEPASSIVE') BEGIN
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
 INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate') --'ActiveOnly') --'stoptdate') --'AuditDate')   --'stopdate')

IF @ExportCode = 'OEACTIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active') --'Active')
END

IF @ExportCode = 'OEPASSIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive') --'Active')
END

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode
*/

-- Step20 Clean up eelist if needed to only include employees with deductions
   --delete dbo.u_EDDPMASLH2_eelist
   --from dbo.u_EDDPMASLH2_eelist a
   --where not exists(select 1 from U_dsi_bdm_EmpDeductions
   --    where a.xeeid = eedeeid
   --    and a.xcoid = eedcoid
   --    and eedformatcode = @formatcode
   --    and eedvalidforexport = 'Y')

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
   delete dbo.u_EDDPMASLH2_EELIST
   from dbo.u_EDDPMASLH2_EELIST
   join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
   where t.eecemplstatus = 'T'
   and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
    and a.eecemplstatus <> 'T')

   delete dbo.u_EDDPMASLH2_eelist
   from dbo.u_EDDPMASLH2_eelist a
   join emppers with (nolock) on xeeid = eepeeid
   where eephomecoid <> xcoid
   and exists(select 1 from dbo.u_EDDPMASLH2_eelist b where a.xeeid = b.xeeid
   having count(*) > 1)
end

--Clean up Terms from Deductions and EEList
  --delete U_dsi_bdm_EmpDeductions
  -- from U_dsi_bdm_EmpDeductions left join vw_int_EmpComp on eedeeid = eeceeid
  --where eedFormatCode = @FormatCode
  -- and eedValidForExport = 'Y'
  -- and eecDateofTermination is not null and eecemplstatus <> 'A'
  -- and @daysstopped + eecDateofTermination < getdate()

  --delete dbo.u_EDDPMASLH2_eelist
  -- from dbo.u_EDDPMASLH2_eelist left join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
  --where eecDateofTermination is not null
  -- and @daysstopped + eecDateofTermination < getdate() and eecemplstatus <> 'A'

-- Populate Source for Employees

if object_id('U_dsi_EDDPMASLH2_drvTbl') is not null
  drop table dbo.U_dsi_EDDPMASLH2_drvTbl
  --select * from U_dsi_EDDPMASLH2_drvTbl

-- EE Detail

  select 
 drvEEID = xEEID, 
 drvcoid = xcoid,
 drvdepid = cast(null as varchar),
 drvrectype = 'E',
 drvSortKey = '1',
-- standard fields above and additional driver fields below
 drvEmployeeID = EecEmpNo, 
 drvLastName = EepNameLast, 
 drvFirstName = EepNameFirst, 
 drvMI = isnull(left(EepNameMiddle,1),''), 
 drveMail = eepAddressEMail, 
 drvTeam = EecOrgLvl4, 
 drvCluster = org2.OrgDesc, 
 drvGroup = EecOrgLvl1, 
 drvEEO = JbcEEOCategory, 
 drvJobTitle = JbcDesc, 
 drvHireDate = EecDateOfLastHire, 
 drvPositionCode = EecJobCode, 
 drvFLSA = case when JbcFLSAType = 'E' then 'X' else JbcFLSAType end, 
 drvDateofBirth = EepDateOfBirth, 
 drvGender = EepGender, 
 drvEthnicCode = case eepEthnicID
                    when '1' then 'W'
                    when '2' then 'B'
                    when '3' then 'H'
                    when '5' then 'I'
                    when '6' then 'ANH'
                    when '7' then 'P'
                    when '8' then 'TR'
                    else '' end, 
 --drvCoach = (select eepSSN from EmpPers where eepEEID = EecSupervisorID), 
 drvCoach = case when exists (select 1 from vw_int_EmpComp where EecSupervisorID = eepeeid) then 'T' else 'F' end, 

 drvExecutiveTeamMember = case 
                            when EecJobCode in ('111101','131300','161704','133106','161702','161703','144603') then 'T'
                            else 'F' end, 

 drvActiveUser = case when EecEmplStatus in ('A','L') then 'T' else 'F' end,
drvJobLongDesc = NULLIF(REPLACE(cast(jbcnotes as varchar(max)),'"',''''),''), --REPLACE(dbo.dsi_FNLib_StripHTML (jbcnotes) ,'&nbsp','')--CAST(JbcNotes as varchar(max))--new 2/27/2019 - SPH - SR-2019-00226045
/*NEW FIELDS 8/21/19 - need job notes in 10k chunks of data, out to 200000 positions*/
drvJobLongDesc0=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),1,9999),
drvJobLongDesc1=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),10000,9999),
drvJobLongDesc2=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),20000,9999),
drvJobLongDesc3=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),30000,9999),
drvJobLongDesc4=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),40000,9999),
drvJobLongDesc5=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),50000,9999),
drvJobLongDesc6=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),60000,9999),
drvJobLongDesc7=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),70000,9999),
drvJobLongDesc8=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),80000,9999),
drvJobLongDesc9=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),90000,9999),
drvJobLongDesc10=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),100000,9999),
drvJobLongDesc11=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),110000,9999),
drvJobLongDesc12=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),120000,9999),
drvJobLongDesc13=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),130000,9999),
drvJobLongDesc14=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),140000,9999),
drvJobLongDesc15=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),150000,9999),
drvJobLongDesc16=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),160000,9999),
drvJobLongDesc17=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),170000,9999),
drvJobLongDesc18=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),180000,9999),
drvJobLongDesc19=substring(NULLIF(REPLACE(RTRIM(LTRIM(cast(jbcnotes as varchar(max)))),'"',''''),''),190000,9999)

  into dbo.U_dsi_EDDPMASLH2_drvTbl
  from dbo.u_EDDPMASLH2_eelist with (nolock)
  join empPers with (nolock) on xEEID = eepEEID  
  join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID  
  join JobCode on EecJobCode = JbcJobCode
  join vw_int_OrgLevel org2 with (nolock) on eecOrglvl2 = OrgCode and orglvl = '2'  
  --select max(LEN(drvJobLongDesc)) from U_dsi_EDDPMASLH2_drvTbl

-- Dependents

/*
-- Header
if object_id('U_dsi_EDDPMASLH2_hdrTbl') is not null
  drop table dbo.U_dsi_EDDPMASLH2_hdrTbl

  select 
 --hdrFiller = '',
 hdrRecordType = '0',
 hdrCustomerID = '',  -- ?? VA
 hdrCreateDate = GETDATE(),
 hdrCreateTime = replace(RIGHT(CONVERT(varchar, getdate(), 120), 8),':',''),
 hdrSubscriberCount = (select COUNT(*) from dbo.U_dsi_EDDPMASLH2_drvTbl),
 hdrRecordCount = (select COUNT(*) from dbo.U_dsi_EDDPMASLH2_drvTbl) + 1,
 hdrFileTypeCode = 'FULL',
 hdrEligibilityDate = dateadd(day, 1, dbo.fn_EndOfMonth(GETDATE()))  -- ,
 --hdrFiller = ''
into dbo.U_dsi_EDDPMASLH2_hdrTbl
*/
-- Trailer

-- Set FileName  
if (dbo.dsi_fnVariable('EDDPMASLH2','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
 set ExportFile =  'ASLHA_DD_' + convert(varchar,getdate(),112) + '.txt'
 where FormatCode = 'EDDPMASLH2'

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwEDDPMASLH2_Export as
       select top 2000000 data as data from dbo.U_EDDPMASLH2_File with (nolock)
         order by 
   initialsort, subsort, substring(Recordset,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'EDDPMASLH2'

select * from dbo.dsi_vwEDDPMASLH2_Export
*/

-- select distinct prgpercontrol from vw_int_PayReg order by 1 desc

/*
--Used for testing
dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','EDDPMASLH2'
dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','OEACTIVE'
dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','OEPASSIVE'
dbo.dsi_sp_TestSwitchbox_v2 'EDDPMASLH2','TEST'
*/
END
GO
CREATE View [dbo].[dsi_vwEDDPMASLH2_Export] as
       select top 200000000 RTRIM(Data) Data from dbo.U_EDDPMASLH2_File with (nolock)
       order by substring(RecordSet,2,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EDDPMASLH2' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDDPMASLH2', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EDDPMASLH2', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EDDPMASLH2', 'UseFileName', 'V', 'Y'


-- End ripout