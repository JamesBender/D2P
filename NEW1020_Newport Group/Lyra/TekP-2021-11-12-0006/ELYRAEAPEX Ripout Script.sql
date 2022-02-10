/**********************************************************************************

ELYRAEAPEX: Lyra EAP Export

FormatCode:     ELYRAEAPEX
Project:        Lyra EAP Export
Client ID:      NEW1020
Date/time:      2022-02-08 08:59:36.960
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW2WUP1DB02
Database:       ULTIPRO_WPNEWG
Web Filename:   NEW1020_CC960_EEHISTORY_ELYRAEAPEX_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELYRAEAPEX_SavePath') IS NOT NULL DROP TABLE dbo.U_ELYRAEAPEX_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELYRAEAPEX'


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
WHERE FormatCode = 'ELYRAEAPEX'
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
WHERE ExpFormatCode = 'ELYRAEAPEX'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELYRAEAPEX')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELYRAEAPEX'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELYRAEAPEX'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELYRAEAPEX'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELYRAEAPEX'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELYRAEAPEX'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELYRAEAPEX'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELYRAEAPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELYRAEAPEX'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELYRAEAPEX'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELYRAEAPEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELYRAEAPEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELYRAEAPEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELYRAEAPEX];
GO
IF OBJECT_ID('U_ELYRAEAPEX_File') IS NOT NULL DROP TABLE [dbo].[U_ELYRAEAPEX_File];
GO
IF OBJECT_ID('U_ELYRAEAPEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELYRAEAPEX_EEList];
GO
IF OBJECT_ID('U_ELYRAEAPEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELYRAEAPEX_drvTbl];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELYRAEAPEX','Lyra EAP Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','3000','S','N','ELYRAEAPEXZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELYRAEAPEXZ0','50','H','01','1',NULL,'mbr_id',NULL,NULL,'"mbr_id"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELYRAEAPEXZ0','50','H','01','2',NULL,'employee_id',NULL,NULL,'"employee_id"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELYRAEAPEXZ0','50','H','01','3',NULL,'mbr_first_name',NULL,NULL,'"mbr_first_name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELYRAEAPEXZ0','50','H','01','4',NULL,'mbr_middle_name',NULL,NULL,'"mbr_middle_name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELYRAEAPEXZ0','50','H','01','5',NULL,'mbr_last_name',NULL,NULL,'"mbr_last_name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELYRAEAPEXZ0','50','H','01','6',NULL,'mbr_current_status',NULL,NULL,'"mbr_current_status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELYRAEAPEXZ0','50','H','01','7',NULL,'mbr_gender',NULL,NULL,'"mbr_gender"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELYRAEAPEXZ0','50','H','01','8',NULL,'mbr_dob',NULL,NULL,'"mbr_dob"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELYRAEAPEXZ0','50','H','01','9',NULL,'mbr_street_1',NULL,NULL,'"mbr_street_1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELYRAEAPEXZ0','50','H','01','10',NULL,'mbr_street_2',NULL,NULL,'"mbr_street_2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELYRAEAPEXZ0','50','H','01','11',NULL,'mbr_city',NULL,NULL,'"mbr_city"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELYRAEAPEXZ0','50','H','01','12',NULL,'mbr_state',NULL,NULL,'"mbr_state"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELYRAEAPEXZ0','50','H','01','13',NULL,'mbr_country',NULL,NULL,'"mbr_country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELYRAEAPEXZ0','50','H','01','14',NULL,'mbr_zip',NULL,NULL,'"mbr_zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELYRAEAPEXZ0','50','H','01','15',NULL,'mbr_phone',NULL,NULL,'"mbr_phone"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELYRAEAPEXZ0','50','H','01','16',NULL,'mbr_email_address',NULL,NULL,'"mbr_email_address"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELYRAEAPEXZ0','50','H','01','17',NULL,'mbr_marital_status',NULL,NULL,'"mbr_marital_status"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELYRAEAPEXZ0','50','H','01','18',NULL,'mbr_race',NULL,NULL,'"mbr_race"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELYRAEAPEXZ0','50','H','01','19',NULL,'mbr_ethnic_group',NULL,NULL,'"mbr_ethnic_group"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELYRAEAPEXZ0','50','H','01','20',NULL,'mbr_edu_lvl',NULL,NULL,'"mbr_edu_lvl"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELYRAEAPEXZ0','50','H','01','21',NULL,'mbr_relationship_desc',NULL,NULL,'"mbr_relationship_desc"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELYRAEAPEXZ0','50','H','01','22',NULL,'mbr_relationship_class',NULL,NULL,'"mbr_relationship_class"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELYRAEAPEXZ0','50','H','01','23',NULL,'ins_plan_type_desc',NULL,NULL,'"ins_plan_type_desc"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELYRAEAPEXZ0','50','H','01','24',NULL,'ins_carrier_name',NULL,NULL,'"ins_carrier_name"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELYRAEAPEXZ0','50','H','01','25',NULL,'ins_coverage_type_desc',NULL,NULL,'"ins_coverage_type_desc"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELYRAEAPEXZ0','50','H','01','26',NULL,'ins_med_eff_date',NULL,NULL,'"ins_med_eff_date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELYRAEAPEXZ0','50','H','01','27',NULL,'ins_med_term_date',NULL,NULL,'"ins_med_term_date"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELYRAEAPEXZ0','50','H','01','28',NULL,'ins_cobra_desc',NULL,NULL,'"ins_cobra_desc"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELYRAEAPEXZ0','50','H','01','29',NULL,'mbr_preferred_address_street_1',NULL,NULL,'"mbr_preferred_address_street_1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELYRAEAPEXZ0','50','H','01','30',NULL,'mbr_preferred_address_street_2',NULL,NULL,'"mbr_preferred_address_street_2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELYRAEAPEXZ0','50','H','01','31',NULL,'mbr_preferred_address_city',NULL,NULL,'"mbr_preferred_address_city"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELYRAEAPEXZ0','50','H','01','32',NULL,'mbr_preferred_address_state',NULL,NULL,'"mbr_preferred_address_state"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ELYRAEAPEXZ0','50','H','01','33',NULL,'mbr_preferred_address_country',NULL,NULL,'"mbr_preferred_address_country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ELYRAEAPEXZ0','50','H','01','34',NULL,'mbr_preferred_address_zip',NULL,NULL,'"mbr_preferred_address_zip"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ELYRAEAPEXZ0','50','H','01','35',NULL,'employee_title',NULL,NULL,'"employee_title"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ELYRAEAPEXZ0','50','H','01','36',NULL,'employee_group',NULL,NULL,'"employee_group"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ELYRAEAPEXZ0','50','H','01','37',NULL,'office_street_1',NULL,NULL,'"office_street_1"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ELYRAEAPEXZ0','50','H','01','38',NULL,'office_street_2',NULL,NULL,'"office_street_2"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ELYRAEAPEXZ0','50','H','01','39',NULL,'office_city',NULL,NULL,'"office_city"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ELYRAEAPEXZ0','50','H','01','40',NULL,'office_state',NULL,NULL,'"office_state"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ELYRAEAPEXZ0','50','H','01','41',NULL,'office_country',NULL,NULL,'"office_country"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ELYRAEAPEXZ0','50','H','01','42',NULL,'office_zip',NULL,NULL,'"office_zip"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELYRAEAPEXZ0','50','D','10','1',NULL,'mbr_id',NULL,NULL,'"drvMbrId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELYRAEAPEXZ0','50','D','10','2',NULL,'employee_id',NULL,NULL,'"drvEmployeeId"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELYRAEAPEXZ0','50','D','10','3',NULL,'mbr_first_name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELYRAEAPEXZ0','50','D','10','4',NULL,'mbr_middle_name',NULL,NULL,'"drvNameMiddle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELYRAEAPEXZ0','50','D','10','5',NULL,'mbr_last_name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELYRAEAPEXZ0','50','D','10','6',NULL,'mbr_current_status',NULL,NULL,'"drvCurrentStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELYRAEAPEXZ0','50','D','10','7',NULL,'mbr_gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELYRAEAPEXZ0','50','D','10','8',NULL,'mbr_dob',NULL,NULL,'"drvDateOfBirth"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELYRAEAPEXZ0','50','D','10','9',NULL,'mbr_street_1',NULL,NULL,'"drvAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELYRAEAPEXZ0','50','D','10','10',NULL,'mbr_street_2',NULL,NULL,'"drvAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELYRAEAPEXZ0','50','D','10','11',NULL,'mbr_city',NULL,NULL,'"drvAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELYRAEAPEXZ0','50','D','10','12',NULL,'mbr_state',NULL,NULL,'"drvAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELYRAEAPEXZ0','50','D','10','13',NULL,'mbr_country',NULL,NULL,'"drvAddressCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELYRAEAPEXZ0','50','D','10','14',NULL,'mbr_zip',NULL,NULL,'"drvAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELYRAEAPEXZ0','50','D','10','15',NULL,'mbr_phone',NULL,NULL,'"drvPhone"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELYRAEAPEXZ0','50','D','10','16',NULL,'mbr_email_address',NULL,NULL,'"drvEmailAddress"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELYRAEAPEXZ0','50','D','10','17',NULL,'mbr_marital_status',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELYRAEAPEXZ0','50','D','10','18',NULL,'mbr_race',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELYRAEAPEXZ0','50','D','10','19',NULL,'mbr_ethnic_group',NULL,NULL,'"drvEthnicGroup"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELYRAEAPEXZ0','50','D','10','20',NULL,'mbr_edu_lvl',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELYRAEAPEXZ0','50','D','10','21',NULL,'mbr_relationship_desc',NULL,NULL,'"drvRelationshipDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELYRAEAPEXZ0','50','D','10','22',NULL,'mbr_relationship_class',NULL,NULL,'"drvRelationshipClass"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELYRAEAPEXZ0','50','D','10','23',NULL,'ins_plan_type_desc',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELYRAEAPEXZ0','50','D','10','24',NULL,'ins_carrier_name',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELYRAEAPEXZ0','50','D','10','25',NULL,'ins_coverage_type_desc',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELYRAEAPEXZ0','50','D','10','26',NULL,'ins_med_eff_date',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELYRAEAPEXZ0','50','D','10','27',NULL,'ins_med_term_date',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELYRAEAPEXZ0','50','D','10','28',NULL,'ins_cobra_desc',NULL,NULL,'"drvCobraDesc"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELYRAEAPEXZ0','50','D','10','29',NULL,'mbr_preferred_address_street_1',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELYRAEAPEXZ0','50','D','10','30',NULL,'mbr_preferred_address_street_2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELYRAEAPEXZ0','50','D','10','31',NULL,'mbr_preferred_address_city',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELYRAEAPEXZ0','50','D','10','32',NULL,'mbr_preferred_address_state',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','ELYRAEAPEXZ0','50','D','10','33',NULL,'mbr_preferred_address_country',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','ELYRAEAPEXZ0','50','D','10','34',NULL,'mbr_preferred_address_zip',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','ELYRAEAPEXZ0','50','D','10','35',NULL,'employee_title',NULL,NULL,'"drvEmployeeTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','ELYRAEAPEXZ0','50','D','10','36',NULL,'employee_group',NULL,NULL,'"drvEmployeeGroup"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','ELYRAEAPEXZ0','50','D','10','37',NULL,'office_street_1',NULL,NULL,'"drvOfficeStreet1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','ELYRAEAPEXZ0','50','D','10','38',NULL,'office_street_2',NULL,NULL,'"drvOfficeStreet2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','ELYRAEAPEXZ0','50','D','10','39',NULL,'office_city',NULL,NULL,'"drvOfficeCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','ELYRAEAPEXZ0','50','D','10','40',NULL,'office_state',NULL,NULL,'"drvOfficeState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','ELYRAEAPEXZ0','50','D','10','41',NULL,'office_country',NULL,NULL,'"drvOfficeCountry"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','ELYRAEAPEXZ0','50','D','10','42',NULL,'office_zip',NULL,NULL,'"drvOfficeZipCode"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELYRAEAPEX_20220208.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Lyra EAP Export','202201279','EMPEXPORT','ONDEM_XOE','Jan 28 2022 12:27PM','ELYRAEAPEX',NULL,NULL,NULL,'202201279','Jan 27 2022  9:04AM','Jan 27 2022  9:04AM','202201271','4071','','','202201271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Lyra EAP Export-Sched','202201279','EMPEXPORT','SCH_ELYRAE','Jan 28 2022 12:26PM','ELYRAEAPEX',NULL,NULL,NULL,'202201279','Jan 27 2022  9:04AM','Jan 27 2022  9:04AM','202201271','4071','','','202201271',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','U5P4Y,CXNNJ',NULL,NULL,NULL,'Lyra EAP Export-Test','202202021','EMPEXPORT','TEST_XOE','Feb  2 2022  5:27PM','ELYRAEAPEX',NULL,NULL,NULL,'202202021','Feb  2 2022 12:00AM','Dec 30 1899 12:00AM','202201261','3295','','','202201261',dbo.fn_GetTimedKey(),NULL,'us3cPeNEW1020',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELYRAEAPEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELYRAEAPEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELYRAEAPEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELYRAEAPEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELYRAEAPEX','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELYRAEAPEX','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELYRAEAPEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELYRAEAPEX','D10','dbo.U_ELYRAEAPEX_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_ELYRAEAPEX_drvTbl
-----------

IF OBJECT_ID('U_ELYRAEAPEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELYRAEAPEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(15) NULL,
    [drvMbrId] varchar(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvCurrentStatus] varchar(10) NULL,
    [drvGender] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressCountry] varchar(3) NOT NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEthnicGroup] varchar(45) NULL,
    [drvRelationshipDesc] varchar(35) NULL,
    [drvRelationshipClass] varchar(10) NOT NULL,
    [drvCobraDesc] varchar(5) NOT NULL,
    [drvEmployeeTitle] varchar(150) NULL,
    [drvEmployeeGroup] varchar(25) NULL,
    [drvOfficeStreet1] varchar(255) NULL,
    [drvOfficeStreet2] varchar(255) NULL,
    [drvOfficeCity] varchar(255) NULL,
    [drvOfficeState] varchar(255) NULL,
    [drvOfficeCountry] char(3) NULL,
    [drvOfficeZipCode] varchar(50) NULL
);

-----------
-- Create table U_ELYRAEAPEX_EEList
-----------

IF OBJECT_ID('U_ELYRAEAPEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ELYRAEAPEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELYRAEAPEX_File
-----------

IF OBJECT_ID('U_ELYRAEAPEX_File') IS NULL
CREATE TABLE [dbo].[U_ELYRAEAPEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELYRAEAPEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Newport

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 01/27/2022
Service Request Number: TekP-2021-11-12-0006

Purpose: Lyra EAP Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELYRAEAPEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELYRAEAPEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELYRAEAPEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELYRAEAPEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELYRAEAPEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELYRAEAPEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELYRAEAPEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELYRAEAPEX', 'SCH_ELYRAE';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELYRAEAPEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELYRAEAPEX';

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
    DELETE FROM dbo.U_ELYRAEAPEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELYRAEAPEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELYRAEAPEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELYRAEAPEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELYRAEAPEX_drvTbl        
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + ' 01'                    
        -- standard fields above and additional driver fields below
        ,drvMbrId = RTRIM(EecEmpNo) + '01'                
        ,drvEmployeeId = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvNameLast = EepNameLast
        ,drvCurrentStatus =    CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'L' THEN 'Leave'
                            WHEN 'T' THEN 'Terminated'
                            END
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressCountry = 'USA'
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPhone = EepPhoneHomeNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvEthnicGroup = Ethnic.CodDesc
        ,drvRelationshipDesc = 'Subscriber' + SPACE(25)
        ,drvRelationshipClass = 'Subscriber' --+ SPACE(25)
        ,drvCobraDesc = CASE WHEN ISNULL(EepUDField05, '') <> '' THEN 'TRUE' ELSE 'FALSE' END
        ,drvEmployeeTitle = JbcLongDesc
        ,drvEmployeeGroup = OrgDesc
        ,drvOfficeStreet1 = LocAddressLine1
        ,drvOfficeStreet2 = LocAddressLine2
        ,drvOfficeCity = LocAddressCity
        ,drvOfficeState = LocAddressState
        ,drvOfficeCountry = LocAddressCountry
        ,drvOfficeZipCode = LocAddressZipCode
    INTO dbo.U_ELYRAEAPEX_drvTbl
    FROM dbo.U_ELYRAEAPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Codes Ethnic WITH (NOLOCK)
        ON EepEthnicId = Ethnic.CodCode
        AND Ethnic.CodTable = 'ETHNICCODE'
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Orglevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
        AND OrgLvl = 1
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    WHERE EecEmplStatus <> 'T'
            OR (EecEmplStatus = 'T' AND (
                                            (ISNULL(EepUdField05, '') = '' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate) 
                                            OR
                                            (ISNULL(EepUdField05, '') <> '' AND ISNULL(EepUdField06, '') <> '' AND CAST(EepUdField06 AS DATE) BETWEEN @StartDate AND @EndDate)
                                        )
                )
    ;



    INSERT INTO dbo.U_ELYRAEAPEX_drvTbl
    SELECT DISTINCT drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = RTRIM(xEEID) + ' ' + FORMAT(RN, '00') /*    CASE WHEN ConRelationship IN ('DOM', 'DP', 'SPS') THEN ' 02'                
                                WHEN ConRelationship IN ('CHL','DAU','DPC','SON','STC') THEN ' 03'
                                END                    */    
        -- standard fields above and additional driver fields below
        ,drvMbrId = RTRIM(EecEmpNo) +    FORMAT(RN, '00') /*CASE WHEN ConRelationship IN ('DOM', 'DP', 'SPS') THEN FORMAT(RN, '00') -- '02'                
                                WHEN ConRelationship IN ('CHL','DAU','DPC','SON','STC') THEN FORMAT(RN, '00') --'03'
                                END                */
        ,drvEmployeeId = EecEmpNo
        ,drvNameFirst = LTRIM(ConNameFirst)
        ,drvNameMiddle = ConNameMiddle
        ,drvNameLast = ConNameLast
        ,drvCurrentStatus =    CASE EecEmplStatus
                            WHEN 'A' THEN 'Active'
                            WHEN 'L' THEN 'Leave'
                            WHEN 'T' THEN 'Terminated'
                            END
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender ELSE 'U' END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvAddressLine1 = ''
        ,drvAddressLine2 = ''
        ,drvAddressCity = ''
        ,drvAddressState = ''
        ,drvAddressCountry = ''
        ,drvAddressZipCode = ''
        ,drvPhone = ConPhoneHomeNumber
        ,drvEmailAddress = ''
        ,drvEthnicGroup = Ethnic.CodDesc
        ,drvRelationshipDesc =    CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                WHEN ConRelationship IN ('DOM', 'DP') THEN 'Domestic Partner'
                                WHEN ConRelationship = 'CHL' THEN 'Child'
                                WHEN ConRelationship = 'DAU' THEN 'Daughter'
                                WHEN ConRelationship = 'DPC' THEN 'Domestic Partner Child'
                                WHEN ConRelationship = 'SON' THEN 'Son'
                                WHEN ConRelationship = 'STC' THEN 'Step Child'
                                END
        ,drvRelationshipClass =    CASE WHEN ConRelationship IN ('DOM','DP','SPS') THEN 'Spouse'
                                WHEN ConRelationship IN ('CHL','DAU','DPC','SON','STC') THEN 'Dependent'
                                END
        ,drvCobraDesc = CASE WHEN ISNULL(EepUDField05, '') <> '' THEN 'TRUE' ELSE 'FALSE' END
        ,drvEmployeeTitle = JbcLongDesc
        ,drvEmployeeGroup = OrgDesc
        ,drvOfficeStreet1 = ''
        ,drvOfficeStreet2 = ''
        ,drvOfficeCity = ''
        ,drvOfficeState = ''
        ,drvOfficeCountry = ''
        ,drvOfficeZipCode = ''
    FROM dbo.U_ELYRAEAPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Codes Ethnic WITH (NOLOCK)
        ON EepEthnicId = Ethnic.CodCode
        AND Ethnic.CodTable = 'ETHNICCODE'
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.Orglevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
        AND OrgLvl = 1
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN( -- dbo.Contacts WITH (NOLOCK)
            SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConPhoneHomeNumber, ConIsDependent, ConIsActive, RN 
            FROM (
                    SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConPhoneHomeNumber, ConIsDependent, ConIsActive, 2 AS RN 
                    FROM dbo.Contacts WITH (NOLOCK) 
                    WHERE ConRelationship IN ('SPS','SP','DOM') AND ConIsDependent = 'Y'
        
                    UNION 
        
                    SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConPhoneHomeNumber, ConIsDependent, ConIsActive, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER By ConDateOfBirth DESC)+2 AS RN 
                    FROM ( 
                            SELECT DISTINCT ConEEID, ConRelationship, ConNameFirst, ConNameLast, ConNameMiddle, ConDateOfBirth, ConGender, ConAddressLine1, ConAddressLine2, ConAddressCity, ConAddressState, ConAddressZipCode, ConPhoneHomeNumber, ConIsDependent, ConIsActive 
                            FROM dbo.Contacts WITH (NOLOCK) 
                            WHERE ConIsActive = 'Y' 
                            AND ConRelationship IN ('CHL','DAU','DPC','SON','STC') AND ConIsDependent = 'Y') AS CHLD
                ) AS Con) as Contacts
        ON xEEID = ConEEID
    WHERE ConRelationship IN ('DOM','DP','SPS','CHL','DAU','DPC','SON','STC')
    AND (EecEmplStatus <> 'T'
            OR (EecEmplStatus = 'T' AND (
                                            (ISNULL(EepUdField05, '') = '' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate) 
                                            OR
                                            (ISNULL(EepUdField05, '') <> '' AND ISNULL(EepUdField06, '') <> '' AND CAST(EepUdField06 AS DATE) BETWEEN @StartDate AND @EndDate)
                                        )
                ))
    AND ConIsDependent = 'Y'
    AND ConIsActive = 'Y'

    
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
ALTER VIEW dbo.dsi_vwELYRAEAPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELYRAEAPEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELYRAEAPEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201201'
       ,expStartPerControl     = '202201201'
       ,expLastEndPerControl   = '202201279'
       ,expEndPerControl       = '202201279'
WHERE expFormatCode = 'ELYRAEAPEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELYRAEAPEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELYRAEAPEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELYRAEAPEX' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELYRAEAPEX'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELYRAEAPEX'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELYRAEAPEX', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELYRAEAPEX', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELYRAEAPEX', 'UseFileName', 'V', 'Y'


-- End ripout