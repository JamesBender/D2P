/**********************************************************************************

EINGGREDEM: Ingaged Export File

FormatCode:     EINGGREDEM
Project:        Ingaged Export File
Client ID:      GRE1021
Date/time:      2022-08-02 12:23:25.917
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP3DB03
Database:       ULTIPRO_WPGREPL
Web Filename:   GRE1021_96C5A_EEHISTORY_EINGGREDEM_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EINGGREDEM_SavePath') IS NOT NULL DROP TABLE dbo.U_EINGGREDEM_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EINGGREDEM'


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
WHERE FormatCode = 'EINGGREDEM'
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
WHERE ExpFormatCode = 'EINGGREDEM'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EINGGREDEM')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EINGGREDEM'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EINGGREDEM'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EINGGREDEM'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EINGGREDEM'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EINGGREDEM'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EINGGREDEM'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EINGGREDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EINGGREDEM'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EINGGREDEM'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEINGGREDEM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEINGGREDEM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EINGGREDEM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINGGREDEM];
GO
IF OBJECT_ID('U_EINGGREDEM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EINGGREDEM_PEarHist];
GO
IF OBJECT_ID('U_EINGGREDEM_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EINGGREDEM_PDedHist];
GO
IF OBJECT_ID('U_EINGGREDEM_File') IS NOT NULL DROP TABLE [dbo].[U_EINGGREDEM_File];
GO
IF OBJECT_ID('U_EINGGREDEM_EEList') IS NOT NULL DROP TABLE [dbo].[U_EINGGREDEM_EEList];
GO
IF OBJECT_ID('U_EINGGREDEM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EINGGREDEM_drvTbl];
GO
IF OBJECT_ID('U_EINGGREDEM_DedList') IS NOT NULL DROP TABLE [dbo].[U_EINGGREDEM_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EINGGREDEM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EINGGREDEM];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EINGGREDEM','Ingaged Export File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','EINGGREDEMZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINGGREDEMZ0','50','H','01','1',NULL,'EMPLOYEE_ID',NULL,NULL,'"EMPLOYEE_ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINGGREDEMZ0','50','H','01','2',NULL,'FIRST_NAME',NULL,NULL,'"FIRST_NAME"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINGGREDEMZ0','50','H','01','3',NULL,'MIDDLE_NAME',NULL,NULL,'"MIDDLE_NAME"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINGGREDEMZ0','50','H','01','4',NULL,'LAST_NAME',NULL,NULL,'"LAST_NAME"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINGGREDEMZ0','50','H','01','5',NULL,'TITLE',NULL,NULL,'"TITLE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINGGREDEMZ0','50','H','01','6',NULL,'BIRTH_DATE',NULL,NULL,'"BIRTH_DATE"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINGGREDEMZ0','50','H','01','7',NULL,'EMAIL_ADDRESS',NULL,NULL,'"EMAIL_ADDRESS"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINGGREDEMZ0','50','H','01','8',NULL,'HOME_PHONE_NUMBER',NULL,NULL,'"HOME_PHONE_NUMBER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINGGREDEMZ0','50','H','01','9',NULL,'MOBILE_PHONE_NUMBER',NULL,NULL,'"MOBILE_PHONE_NUMBER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINGGREDEMZ0','50','H','01','10',NULL,'WORK_PHONE_NUMBER',NULL,NULL,'"WORK_PHONE_NUMBER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINGGREDEMZ0','50','H','01','11',NULL,'FILLER',NULL,NULL,'"FILLER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINGGREDEMZ0','50','H','01','12',NULL,'SSO_ID',NULL,NULL,'"SSO_ID"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EINGGREDEMZ0','50','H','01','13',NULL,'FILLER',NULL,NULL,'"FILLER"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EINGGREDEMZ0','50','H','01','14',NULL,'Medical_Plan',NULL,NULL,'"Medical_Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EINGGREDEMZ0','50','H','01','15',NULL,'Dental_Plan',NULL,NULL,'"Dental_Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EINGGREDEMZ0','50','H','01','16',NULL,'Vision_Plan',NULL,NULL,'"Vision_Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EINGGREDEMZ0','50','H','01','17',NULL,'Health_FSA',NULL,NULL,'"Health_FSA"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EINGGREDEMZ0','50','H','01','18',NULL,'Dep_Care_FSA',NULL,NULL,'"Dep_Care_FSA"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EINGGREDEMZ0','50','H','01','19',NULL,'Limited_Purpose_FSA',NULL,NULL,'"Limited_Purpose_FSA"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EINGGREDEMZ0','50','H','01','20',NULL,'HSA',NULL,NULL,'"HSA"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EINGGREDEMZ0','50','H','01','21',NULL,'HRA',NULL,NULL,'"HRA"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EINGGREDEMZ0','50','H','01','22',NULL,'LTD',NULL,NULL,'"LTD"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EINGGREDEMZ0','50','H','01','23',NULL,'STD',NULL,NULL,'"STD"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EINGGREDEMZ0','50','H','01','24',NULL,'Basic_Life',NULL,NULL,'"Basic_Life"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EINGGREDEMZ0','50','H','01','25',NULL,'Voluntary_EE_Life',NULL,NULL,'"Voluntary_EE_Life"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EINGGREDEMZ0','50','H','01','26',NULL,'Voluntary_SP_Life',NULL,NULL,'"Voluntary_SP_Life"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EINGGREDEMZ0','50','H','01','27',NULL,'Voluntary_CH_Life',NULL,NULL,'"Voluntary_CH_Life"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EINGGREDEMZ0','50','H','01','28',NULL,'Whole_Life',NULL,NULL,'"Whole_Life"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EINGGREDEMZ0','50','H','01','29',NULL,'Hospital_Indemnity',NULL,NULL,'"Hospital_Indemnity"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EINGGREDEMZ0','50','H','01','30',NULL,'Crit_Illness',NULL,NULL,'"Crit_Illness"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EINGGREDEMZ0','50','H','01','31',NULL,'Accident_Plan',NULL,NULL,'"Accident_Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EINGGREDEMZ0','50','H','01','32',NULL,'Cancer_Plan',NULL,NULL,'"Cancer_Plan"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EINGGREDEMZ0','50','H','01','33',NULL,'Legal',NULL,NULL,'"Legal"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EINGGREDEMZ0','50','H','01','34',NULL,'ID_Theft',NULL,NULL,'"ID_Theft"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EINGGREDEMZ0','50','H','01','35',NULL,'Pet_Insurance',NULL,NULL,'"Pet_Insurance"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EINGGREDEMZ0','50','H','01','36',NULL,'Beneficiary_Companion',NULL,NULL,'"Beneficiary_Companion"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EINGGREDEMZ0','50','H','01','37',NULL,'401k',NULL,NULL,'"401k"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EINGGREDEMZ0','50','H','01','38',NULL,'401k_Roth',NULL,NULL,'"401k_Roth"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EINGGREDEMZ0','50','H','01','39',NULL,'403b',NULL,NULL,'"403b"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EINGGREDEMZ0','50','H','01','40',NULL,'Office_Location',NULL,NULL,'"Office_Location"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EINGGREDEMZ0','50','H','01','41',NULL,'Pay Code',NULL,NULL,'"Pay_Code"','(''DA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EINGGREDEMZ0','50','H','01','42',NULL,'PTO',NULL,NULL,'"PTO"','(''DA''=''Q'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EINGGREDEMZ0','50','D','10','1',NULL,'EMPLOYEE_ID',NULL,NULL,'"drvEMPLOYEEID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EINGGREDEMZ0','50','D','10','2',NULL,'FIRST_NAME',NULL,NULL,'"drvFIRSTNAME"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EINGGREDEMZ0','50','D','10','3',NULL,'MIDDLE_NAME',NULL,NULL,'"drvMIDDLENAME"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EINGGREDEMZ0','50','D','10','4',NULL,'LAST_NAME',NULL,NULL,'"drvLASTNAME"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EINGGREDEMZ0','50','D','10','5',NULL,'TITLE',NULL,NULL,'"drvTITLE"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EINGGREDEMZ0','50','D','10','6',NULL,'BIRTH_DATE',NULL,NULL,'"drvBIRTHDATE"','(''UD101''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EINGGREDEMZ0','50','D','10','7',NULL,'EMAIL_ADDRESS',NULL,NULL,'"drvEMAILADDRESS"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EINGGREDEMZ0','50','D','10','8',NULL,'HOME_PHONE_NUMBER',NULL,NULL,'"drvHOMEPHONENUMBER"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EINGGREDEMZ0','50','D','10','9',NULL,'MOBILE_PHONE_NUMBER',NULL,NULL,'"drvMOBILEPHONENUMBER"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EINGGREDEMZ0','50','D','10','10',NULL,'WORK_PHONE_NUMBER',NULL,NULL,'"drvWORKPHONENUMBER"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EINGGREDEMZ0','50','D','10','11',NULL,'FILLER',NULL,NULL,'"drvFILLER"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EINGGREDEMZ0','50','D','10','12',NULL,'SSO_ID',NULL,NULL,'"drvSSOID"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EINGGREDEMZ0','50','D','10','13',NULL,'FILLER',NULL,NULL,'"drvFILLER2"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EINGGREDEMZ0','50','D','10','14',NULL,'Medical_Plan',NULL,NULL,'"drvMedicalPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EINGGREDEMZ0','50','D','10','15',NULL,'Dental_Plan',NULL,NULL,'"drvDentalPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EINGGREDEMZ0','50','D','10','16',NULL,'Vision_Plan',NULL,NULL,'"drvVisionPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EINGGREDEMZ0','50','D','10','17',NULL,'Health_FSA',NULL,NULL,'"drvHealthFSA"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EINGGREDEMZ0','50','D','10','18',NULL,'Dep_Care_FSA',NULL,NULL,'"drvDepCareFSA"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EINGGREDEMZ0','50','D','10','19',NULL,'Limited_Purpose_FSA',NULL,NULL,'"drvLimitedPurposeFSA"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EINGGREDEMZ0','50','D','10','20',NULL,'HSA',NULL,NULL,'"drvHSA"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EINGGREDEMZ0','50','D','10','21',NULL,'HRA',NULL,NULL,'"drvHRA"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EINGGREDEMZ0','50','D','10','22',NULL,'LTD',NULL,NULL,'"drvLTD"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EINGGREDEMZ0','50','D','10','23',NULL,'STD',NULL,NULL,'"drvSTD"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EINGGREDEMZ0','50','D','10','24',NULL,'Basic_Life',NULL,NULL,'"drvBasicLife"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EINGGREDEMZ0','50','D','10','25',NULL,'Voluntary_EE_Life',NULL,NULL,'"drvVoluntaryEELife"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EINGGREDEMZ0','50','D','10','26',NULL,'Voluntary_SP_Life',NULL,NULL,'"drvVoluntarySPLife"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EINGGREDEMZ0','50','D','10','27',NULL,'Voluntary_CH_Life',NULL,NULL,'"drvVoluntaryCHLife"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EINGGREDEMZ0','50','D','10','28',NULL,'Whole_Life',NULL,NULL,'"drvWholeLife"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EINGGREDEMZ0','50','D','10','29',NULL,'Hospital_Indemnity',NULL,NULL,'"drvHospitalIndemnity"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EINGGREDEMZ0','50','D','10','30',NULL,'Crit_Illness',NULL,NULL,'"drvCritIllness"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EINGGREDEMZ0','50','D','10','31',NULL,'Accident_Plan',NULL,NULL,'"drvAccidentPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EINGGREDEMZ0','50','D','10','32',NULL,'Cancer_Plan',NULL,NULL,'"drvCancerPlan"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EINGGREDEMZ0','50','D','10','33',NULL,'Legal',NULL,NULL,'"drvLegal"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EINGGREDEMZ0','50','D','10','34',NULL,'ID_Theft',NULL,NULL,'"drvIDTheft"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EINGGREDEMZ0','50','D','10','35',NULL,'Pet_Insurance',NULL,NULL,'"drvPetInsurance"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EINGGREDEMZ0','50','D','10','36',NULL,'Beneficiary_Companion',NULL,NULL,'"drvBeneficiaryCompanion"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EINGGREDEMZ0','50','D','10','37',NULL,'401k',NULL,NULL,'"drv401k"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EINGGREDEMZ0','50','D','10','38',NULL,'401k_Roth',NULL,NULL,'"drv401kRoth"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EINGGREDEMZ0','50','D','10','39',NULL,'403b',NULL,NULL,'"drv403b"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EINGGREDEMZ0','50','D','10','40',NULL,'Office_Location',NULL,NULL,'"drvOfficeLocation"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EINGGREDEMZ0','50','D','10','41',NULL,'Pay Code',NULL,NULL,'"drvPayCode"','(''UA''=''Q,'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EINGGREDEMZ0','50','D','10','42',NULL,'PTO',NULL,NULL,'"drvPTO"','(''UA''=''Q'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EINGGREDEM_20220802.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202201049','EMPEXPORT','OEACTIVE',NULL,'EINGGREDEM',NULL,NULL,NULL,'202201049','Jan  4 2022  5:33PM','Jan  4 2022  5:33PM','202201041',NULL,'','','202201041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202201049','EMPEXPORT','OEPASSIVE',NULL,'EINGGREDEM',NULL,NULL,NULL,'202201049','Jan  4 2022  5:33PM','Jan  4 2022  5:33PM','202201041',NULL,'','','202201041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ingaged Export File','202201049','EMPEXPORT','ONDEM_XOE',NULL,'EINGGREDEM',NULL,NULL,NULL,'202201049','Jan  4 2022  5:33PM','Jan  4 2022  5:33PM','202201041',NULL,'','','202201041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',OEZDW,OEZ87,RIWDE',NULL,NULL,NULL,'Ingaged Export File-Sched','202201049','EMPEXPORT','SCH_EINGGR',NULL,'EINGGREDEM',NULL,NULL,NULL,'202207279','Jan  4 2022  5:33PM','Jan  4 2022  5:33PM','202207201',NULL,'','','202201041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Ingaged Export File-Test','202208029','EMPEXPORT','TEST_XOE','Aug  2 2022  6:53AM','EINGGREDEM',NULL,NULL,NULL,'202208029','Aug  2 2022 12:00AM','Dec 30 1899 12:00AM','202207261','883','','','202207261',dbo.fn_GetTimedKey(),NULL,'us3jReGRE1021',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','IsUTF','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINGGREDEM','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINGGREDEM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINGGREDEM','D10','dbo.U_EINGGREDEM_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EINGGREDEM
-----------

IF OBJECT_ID('U_dsi_BDM_EINGGREDEM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EINGGREDEM] (
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
-- Create table U_EINGGREDEM_DedList
-----------

IF OBJECT_ID('U_EINGGREDEM_DedList') IS NULL
CREATE TABLE [dbo].[U_EINGGREDEM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EINGGREDEM_drvTbl
-----------

IF OBJECT_ID('U_EINGGREDEM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EINGGREDEM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvEMPLOYEEID] char(9) NULL,
    [drvFIRSTNAME] varchar(100) NULL,
    [drvMIDDLENAME] varchar(1) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvTITLE] varchar(25) NOT NULL,
    [drvBIRTHDATE] datetime NULL,
    [drvEMAILADDRESS] varchar(50) NULL,
    [drvHOMEPHONENUMBER] varchar(1) NOT NULL,
    [drvMOBILEPHONENUMBER] varchar(50) NULL,
    [drvWORKPHONENUMBER] varchar(50) NULL,
    [drvFILLER] varchar(1) NOT NULL,
    [drvSSOID] varchar(1) NOT NULL,
    [drvFILLER2] varchar(1) NOT NULL,
    [drvMedicalPlan] varchar(8) NULL,
    [drvDentalPlan] varchar(1) NULL,
    [drvVisionPlan] varchar(10) NULL,
    [drvHealthFSA] varchar(1) NULL,
    [drvDepCareFSA] varchar(1) NULL,
    [drvLimitedPurposeFSA] varchar(1) NULL,
    [drvHSA] varchar(1) NULL,
    [drvHRA] varchar(1) NOT NULL,
    [drvLTD] varchar(1) NULL,
    [drvSTD] varchar(1) NULL,
    [drvBasicLife] varchar(1) NULL,
    [drvVoluntaryEELife] varchar(1) NULL,
    [drvVoluntarySPLife] varchar(1) NULL,
    [drvVoluntaryCHLife] varchar(1) NULL,
    [drvWholeLife] varchar(1) NOT NULL,
    [drvHospitalIndemnity] varchar(1) NULL,
    [drvCritIllness] varchar(1) NULL,
    [drvAccidentPlan] varchar(1) NULL,
    [drvCancerPlan] varchar(1) NOT NULL,
    [drvLegal] varchar(1) NOT NULL,
    [drvIDTheft] varchar(1) NOT NULL,
    [drvPetInsurance] varchar(1) NOT NULL,
    [drvBeneficiaryCompanion] varchar(1) NOT NULL,
    [drv401k] varchar(1) NULL,
    [drv401kRoth] varchar(1) NULL,
    [drv403b] varchar(1) NOT NULL,
    [drvOfficeLocation] varchar(255) NULL,
    [drvPayCode] varchar(6) NOT NULL,
    [drvPTO] varchar(30) NULL
);

-----------
-- Create table U_EINGGREDEM_EEList
-----------

IF OBJECT_ID('U_EINGGREDEM_EEList') IS NULL
CREATE TABLE [dbo].[U_EINGGREDEM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EINGGREDEM_File
-----------

IF OBJECT_ID('U_EINGGREDEM_File') IS NULL
CREATE TABLE [dbo].[U_EINGGREDEM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);

-----------
-- Create table U_EINGGREDEM_PDedHist
-----------

IF OBJECT_ID('U_EINGGREDEM_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EINGGREDEM_PDedHist] (
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
-- Create table U_EINGGREDEM_PEarHist
-----------

IF OBJECT_ID('U_EINGGREDEM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EINGGREDEM_PEarHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINGGREDEM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Green Plains

Created By: Marco Lagrosa
Business Analyst: Julie Reardon 
Create Date: 01/04/2022
Service Request Number: TekP-2021-10-04-0006

Purpose: Ingaged Export File

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EINGGREDEM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EINGGREDEM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EINGGREDEM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EINGGREDEM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EINGGREDEM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINGGREDEM', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINGGREDEM', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINGGREDEM', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINGGREDEM', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINGGREDEM', 'SCH_EINGGR';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EINGGREDEM';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EINGGREDEM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EINGGREDEM';

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
    DELETE FROM dbo.U_EINGGREDEM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EINGGREDEM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EINGGREDEM_EEList WHERE xEEID = '93FVWH0010Z0'

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HDP35,MD1,MD4,DN1,DN2,FSA,FSADC,FSALI,HSAEE, HSAFAM, HSAIC, HSAFC,LTD1, LTD2,STD1, STD2,CLIFE, SLIFE, LIFE1, LIFE2, LIFE3, LIFE4,VOLE,VOLC,HOSP1, HOSP2,CIEC1, CIEC2, CIEE1, CIEE2, CIES1, CIES2, CIFM1, CREF2,ACC1, ACC2,401F, 401P, 401CU, 401CP,401RF, 401RP, 4KRCP, 4KRCU,VOLS';

    IF OBJECT_ID('U_EINGGREDEM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EINGGREDEM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EINGGREDEM_DedList
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
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EINGGREDEM_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EINGGREDEM_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EINGGREDEM_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EINGGREDEM_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EINGGREDEM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EINGGREDEM_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EINGGREDEM_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EINGGREDEM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EINGGREDEM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EINGGREDEM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvEMPLOYEEID = EecEmpNo
        ,drvFIRSTNAME = EepNameFirst
        ,drvMIDDLENAME = LEFT(EepNameMiddle,1)
        ,drvLASTNAME = EepNameLast
        ,drvTITLE = JbcDesc 
        ,drvBIRTHDATE = EepDateOfBirth
        ,drvEMAILADDRESS = EepAddressEMail
        ,drvHOMEPHONENUMBER = ''
        ,drvMOBILEPHONENUMBER = CASE WHEN EfoPhoneType = 'CEL' THEN EfoPhoneNumber END
        ,drvWORKPHONENUMBER = EecPhoneBusinessNumber
        ,drvFILLER = ''
        ,drvSSOID = ''
        ,drvFILLER2 = ''
        ,drvMedicalPlan = Medical_Plan
        ,drvDentalPlan = Dental_Plan
        ,drvVisionPlan = Vision_Plan
        ,drvHealthFSA = Health_FSA
        ,drvDepCareFSA = Dep_Care_FSA
        ,drvLimitedPurposeFSA = Limited_Purpose_FSA
        ,drvHSA = HSA
        ,drvHRA = ''
        ,drvLTD = LTD
        ,drvSTD = STD
        ,drvBasicLife = Basic_Life
        ,drvVoluntaryEELife = Voluntary_EE_Life
        ,drvVoluntarySPLife = Voluntary_SS_Life
        ,drvVoluntaryCHLife = Voluntary_CH_Life
        ,drvWholeLife = ''
        ,drvHospitalIndemnity = Hospital_Indemnity
        ,drvCritIllness = Crit_Illness
        ,drvAccidentPlan = Accident_Plan
        ,drvCancerPlan = ''
        ,drvLegal = ''
        ,drvIDTheft = ''
        ,drvPetInsurance = ''
        ,drvBeneficiaryCompanion = ''
        ,drv401k = P401K
        ,drv401kRoth = P401KRoth
        ,drv403b = ''
        ,drvOfficeLocation = Loc.LocAddressCity
        ,drvPayCode = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Salary' ELSE 'Hourly' END
        ,drvPTO = CAST( CONVERT(DECIMAL(10,2),CASE WHEN EacAccrCode = 'PTO' THEN EacAccrAllowedCurBal - EacAccrTakenCurBal END) as varchar)
    INTO dbo.U_EINGGREDEM_drvTbl
    FROM dbo.U_EINGGREDEM_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and eecemplstatus = 'A'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
    JOIN dbo.Location Loc
    on Loc.LocCode = eecLocation
    LEFT JOIN dbo.EmpAccr WITH (NOLOCK)
        on EacEEID =  xeeid
        AND EacCOID = xCOID
        AND EacAccrCode = 'PTO'
    JOIN (
                SELECT BdmEEID, BdmCOID
                ,Medical_Plan = MAX(CASE WHEN BdmDedCode IN ('HDP35') THEN 'HDHP' 
                                         WHEN BdmDedCode IN ('MD1') THEN 'PPO500'
                                         WHEN BdmDedCode IN ('MD4') THEN 'PPO 2000'
                                END)
                ,Dental_Plan = MAX(CASE WHEN BdmDedCode IN ('DN1', 'DN2') THEN 'Y' END)
                ,Vision_Plan = MAX(CASE WHEN BdmDedCode IN ('DN1') THEN 'VSP'
                                        WHEN BdmDedCode IN ('DN2') THEN 'Viewpointe' 
                                 END)
                ,Health_FSA = MAX(CASE WHEN BdmDedCode IN ('FSA') THEN 'Y' END)
                ,Dep_Care_FSA = MAX(CASE WHEN BdmDedCode IN ('FSADC') THEN 'Y' END)
                ,Limited_Purpose_FSA = MAX(CASE WHEN BdmDedCode IN ('FSALI') THEN 'Y' END)
                ,HSA = MAX(CASE WHEN BdmDedCode IN ('HSAEE', 'HSAFAM', 'HSAIC', 'HSAFC') THEN 'Y' END)
                ,LTD = MAX(CASE WHEN BdmDedCode IN ('LTD1', 'LTD2') THEN 'Y' END)
                ,STD = MAX(CASE WHEN BdmDedCode IN ('STD1', 'STD2') THEN 'Y' END)
                ,Basic_Life = MAX(CASE WHEN BdmDedCode IN ('CLIFE', 'SLIFE', 'LIFE1', 'LIFE2', 'LIFE3', 'LIFE4') THEN 'Y' END)
                ,Voluntary_EE_Life = MAX(CASE WHEN BdmDedCode IN ('VOLE') THEN 'Y' END)
                ,Voluntary_SS_Life = MAX(CASE WHEN BdmDedCode IN ('VOLS') THEN 'Y' END)
                ,Voluntary_CH_Life = MAX(CASE WHEN BdmDedCode IN ('VOLC') THEN 'Y' END)
                ,Hospital_Indemnity  = MAX(CASE WHEN BdmDedCode IN ('HOSP1', 'HOSP2') THEN 'Y' END)
                ,Crit_Illness = MAX(CASE WHEN BdmDedCode IN ('CIEC1', 'CIEC2', 'CIEE1', 'CIEE2', 'CIES1', 'CIES2', 'CIFM1', 'CREF2') THEN 'Y' END)
                ,Accident_Plan = MAX(CASE WHEN BdmDedCode IN ('ACC1', 'ACC2') THEN 'Y' END)
                ,P401K = MAX(CASE WHEN BdmDedCode IN ('401F', '401P', '401CU', '401CP') THEN 'Y' END)  
                ,P401KRoth = MAX(CASE WHEN BdmDedCode IN ('401RF', '401RP', '4KRCP', '4KRCU') THEN 'Y' END) 

                FROM dbo.U_dsi_BDM_EINGGREDEM WITH (NOLOCK)
                GROUP BY BdmEEID, BdmCOID) as ConsolidatedBDM
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
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
ALTER VIEW dbo.dsi_vwEINGGREDEM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EINGGREDEM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EINGGREDEM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202112281'
       ,expStartPerControl     = '202112281'
       ,expLastEndPerControl   = '202201049'
       ,expEndPerControl       = '202201049'
WHERE expFormatCode = 'EINGGREDEM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEINGGREDEM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EINGGREDEM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EINGGREDEM' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EINGGREDEM'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EINGGREDEM'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EINGGREDEM', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EINGGREDEM', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EINGGREDEM', 'UseFileName', 'V', 'Y'


-- End ripout