/**********************************************************************************

EUPGLINFF: Lincoln FMLA, STD, LTD

FormatCode:     EUPGLINFF
Project:        Lincoln FMLA, STD, LTD
Client ID:      UNI1070
Date/time:      2022-03-03 14:07:15.910
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP1DB01
Database:       ULTIPRO_WPUPI
Web Filename:   UNI1070_9BEFA_EEHISTORY_EUPGLINFF_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EUPGLINFF_SavePath') IS NOT NULL DROP TABLE dbo.U_EUPGLINFF_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EUPGLINFF'


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
WHERE FormatCode = 'EUPGLINFF'
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
WHERE ExpFormatCode = 'EUPGLINFF'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EUPGLINFF')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EUPGLINFF'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EUPGLINFF'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EUPGLINFF'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EUPGLINFF'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EUPGLINFF'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EUPGLINFF'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EUPGLINFF'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EUPGLINFF'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EUPGLINFF'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEUPGLINFF_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUPGLINFF_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUPGLINFF') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUPGLINFF];
GO
IF OBJECT_ID('U_EUPGLINFF_T_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_T_drvTbl];
GO
IF OBJECT_ID('U_EUPGLINFF_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_PEarHist];
GO
IF OBJECT_ID('U_EUPGLINFF_H_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_H_drvTbl];
GO
IF OBJECT_ID('U_EUPGLINFF_File') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_File];
GO
IF OBJECT_ID('U_EUPGLINFF_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_EEList];
GO
IF OBJECT_ID('U_EUPGLINFF_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_drvTbl];
GO
IF OBJECT_ID('U_EUPGLINFF_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_DedList];
GO
IF OBJECT_ID('U_EUPGLINFF_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_AuditFields];
GO
IF OBJECT_ID('U_EUPGLINFF_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUPGLINFF_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EUPGLINFF') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUPGLINFF];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EUPGLINFF','Lincoln FMLA, STD, LTD','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2999','S','N','EUPGLINFF0Z0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUPGLINFF0Z0','9','H','01','1',NULL,'Customer ID',NULL,NULL,'"09-LF0712"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUPGLINFF0Z0','7','H','01','10',NULL,'Record Number',NULL,NULL,'"drvRecordNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUPGLINFF0Z0','10','H','01','17',NULL,'Date',NULL,NULL,'"drvDATE"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUPGLINFF0Z0','7','H','01','27',NULL,'Record Length',NULL,NULL,'"drvRecordLength"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUPGLINFF0Z0','2966','H','01','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUPGLINFF0Z0','1','D','10','1',NULL,'Record Type',NULL,NULL,'"D"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUPGLINFF0Z0','6','D','10','2',NULL,'iCAM Account ID Number',NULL,NULL,'"drviCAMAccIDNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUPGLINFF0Z0','6','D','10','8',NULL,'iCAM Account Verification Number',NULL,NULL,'"drviCAMAccVerifNo"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUPGLINFF0Z0','9','D','10','14',NULL,'Disability Customer ID',NULL,NULL,'"09-LF0712"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUPGLINFF0Z0','30','D','10','23',NULL,'Account Specific Organization 1 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EUPGLINFF0Z0','30','D','10','53',NULL,'Account Specific Organization 2 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EUPGLINFF0Z0','30','D','10','83',NULL,'Account Specific Organization 3 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EUPGLINFF0Z0','30','D','10','113',NULL,'Account Specific Organization 4 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EUPGLINFF0Z0','30','D','10','143',NULL,'Account Specific Organization 5 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EUPGLINFF0Z0','30','D','10','173',NULL,'Account Specific Organization 6 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EUPGLINFF0Z0','30','D','10','203',NULL,'Account Specific Organization 7 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EUPGLINFF0Z0','30','D','10','233',NULL,'Account Specific Organization 8 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EUPGLINFF0Z0','30','D','10','263',NULL,'Account Specific Organization 9 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EUPGLINFF0Z0','30','D','10','293',NULL,'Account Specific Organization 10 Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EUPGLINFF0Z0','30','D','10','323',NULL,'WC Insured Location Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EUPGLINFF0Z0','4','D','10','353',NULL,'Disability Subsidiary Code',NULL,NULL,'"drvDisSubCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EUPGLINFF0Z0','30','D','10','357',NULL,'Organizational Structure I',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EUPGLINFF0Z0','30','D','10','387',NULL,'Organizational Structure II',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EUPGLINFF0Z0','10','D','10','417',NULL,'Current Division Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EUPGLINFF0Z0','10','D','10','427',NULL,'Current Department Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EUPGLINFF0Z0','10','D','10','437',NULL,'Current Position Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EUPGLINFF0Z0','1','D','10','447',NULL,'Disability Contact Type Code',NULL,NULL,'"A"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EUPGLINFF0Z0','35','D','10','448',NULL,'Disability Contact First Name',NULL,NULL,'"Human"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EUPGLINFF0Z0','35','D','10','483',NULL,'Disability Contact Last Name',NULL,NULL,'"Resources"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EUPGLINFF0Z0','5','D','10','518',NULL,'Disability Contact Name Suffix',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EUPGLINFF0Z0','30','D','10','523',NULL,'Disability Contact Address Line 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EUPGLINFF0Z0','30','D','10','553',NULL,'Disability Contact Address Line 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EUPGLINFF0Z0','20','D','10','583',NULL,'Disability Contact Address City',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EUPGLINFF0Z0','2','D','10','603',NULL,'Disability Contact Address  State',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EUPGLINFF0Z0','9','D','10','605',NULL,'Disability Contact Address Postal Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EUPGLINFF0Z0','3','D','10','614',NULL,'Disability Contact Address Country Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EUPGLINFF0Z0','100','D','10','617',NULL,'Disability Contact Email Address',NULL,NULL,'"hr@upgllc.com"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EUPGLINFF0Z0','3','D','10','717',NULL,'Disability Contact Telephone Area Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EUPGLINFF0Z0','3','D','10','720',NULL,'Disability Contact Telephone Exchange Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EUPGLINFF0Z0','4','D','10','723',NULL,'Disability Contact Telephone Line Range Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EUPGLINFF0Z0','8','D','10','727',NULL,'Disability Contact Phone Extension',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EUPGLINFF0Z0','35','D','10','735',NULL,'Supervisor First Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EUPGLINFF0Z0','35','D','10','770',NULL,'Supervisor Last Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EUPGLINFF0Z0','1','D','10','805',NULL,'Supervisor Middle Initial',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EUPGLINFF0Z0','5','D','10','806',NULL,'Supervisor Name Suffix',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EUPGLINFF0Z0','3','D','10','811',NULL,'Supervisor Telephone Area Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EUPGLINFF0Z0','3','D','10','814',NULL,'Supervisor Telephone Exchange Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EUPGLINFF0Z0','4','D','10','817',NULL,'Supervisor Telephone Line Range Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EUPGLINFF0Z0','11','D','10','821',NULL,'Employee Identification',NULL,NULL,'"drvEmpID"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EUPGLINFF0Z0','2','D','10','832',NULL,'Employment State',NULL,NULL,'"drvEmpState"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EUPGLINFF0Z0','8','D','10','834',NULL,'Disability Location Code',NULL,NULL,'"drvDisLocCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EUPGLINFF0Z0','15','D','10','842',NULL,'Employee Department Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EUPGLINFF0Z0','4','D','10','857',NULL,'Occupation Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EUPGLINFF0Z0','50','D','10','861',NULL,'Occupation Description',NULL,NULL,'"drvOccDescr"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EUPGLINFF0Z0','1','D','10','911',NULL,'Physical Demands Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EUPGLINFF0Z0','35','D','10','912',NULL,'Employee First Name',NULL,NULL,'"drvFirstName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EUPGLINFF0Z0','35','D','10','947',NULL,'Employee Last Name',NULL,NULL,'"drvLastName"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EUPGLINFF0Z0','1','D','10','982',NULL,'Employee Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EUPGLINFF0Z0','5','D','10','983',NULL,'Employee Name Suffix',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EUPGLINFF0Z0','30','D','10','988',NULL,'Employee Address Line 1 Name',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EUPGLINFF0Z0','30','D','10','1018',NULL,'Employee Address Line 2 Name',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EUPGLINFF0Z0','20','D','10','1048',NULL,'Employee Address City Name',NULL,NULL,'"drvAddressCity"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EUPGLINFF0Z0','2','D','10','1068',NULL,'Employee Address State Code',NULL,NULL,'"drvStateCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EUPGLINFF0Z0','9','D','10','1070',NULL,'Employee Address Postal Code',NULL,NULL,'"drvPostalCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EUPGLINFF0Z0','3','D','10','1079',NULL,'Employee Address Country Code',NULL,NULL,'"USA"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EUPGLINFF0Z0','30','D','10','1082',NULL,'Employee Address County Name',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EUPGLINFF0Z0','3','D','10','1112',NULL,'Employee Telephone Area Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EUPGLINFF0Z0','3','D','10','1115',NULL,'Employee Telephone Exchange Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EUPGLINFF0Z0','4','D','10','1118',NULL,'Employee Telephone Line Range Number',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EUPGLINFF0Z0','11','D','10','1122',NULL,'Social Security Number',NULL,NULL,'"drvSSN"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EUPGLINFF0Z0','1','D','10','1133',NULL,'Social Security Number Type Code',NULL,NULL,'"drvSSNTypeCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EUPGLINFF0Z0','1','D','10','1134',NULL,'Employee Gender Code',NULL,NULL,'"drvGenderCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EUPGLINFF0Z0','8','D','10','1135',NULL,'Employee Birth Date',NULL,NULL,'"drvBirthDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EUPGLINFF0Z0','1','D','10','1143',NULL,'Employee Marital Status Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EUPGLINFF0Z0','1','D','10','1144',NULL,'W4 Marital Status Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EUPGLINFF0Z0','8','D','10','1145',NULL,'Spouse Birth Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EUPGLINFF0Z0','2','D','10','1153',NULL,'Employee Dependent Quantity',NULL,NULL,'"drvDependentQty"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EUPGLINFF0Z0','2','D','10','1155',NULL,'Employee Dependents Under 18 Quantity',NULL,NULL,'"drvDepUnder18Qty"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EUPGLINFF0Z0','3','D','10','1157',NULL,'Education Level',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EUPGLINFF0Z0','10','D','10','1160',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EUPGLINFF0Z0','10','D','10','1170',NULL,'Hourly Wage',NULL,NULL,'"drvHourlyWage"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EUPGLINFF0Z0','8','D','10','1180',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EUPGLINFF0Z0','2','D','10','1188',NULL,'Salary Type',NULL,NULL,'"drvSalaryType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EUPGLINFF0Z0','10','D','10','1190',NULL,'Bonus Amount',NULL,NULL,'"drvBonusAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EUPGLINFF0Z0','10','D','10','1200',NULL,'Commission Amount',NULL,NULL,'"drvCommissionAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EUPGLINFF0Z0','1','D','10','1210',NULL,'Salary Mode',NULL,NULL,'"drvSalaryMode "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EUPGLINFF0Z0','10','D','10','1211',NULL,'Year to Date Wages',NULL,NULL,'"drvYTDWages"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EUPGLINFF0Z0','2','D','10','1221',NULL,'W4 Withholding Allowance',NULL,NULL,'"drvW4WithHldgAllow"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EUPGLINFF0Z0','80','D','10','1223',NULL,'Employee Custom Data Element 1',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EUPGLINFF0Z0','80','D','10','1303',NULL,'Employee Custom Data Element 2',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EUPGLINFF0Z0','80','D','10','1383',NULL,'Employee Custom Data Element 3',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EUPGLINFF0Z0','80','D','10','1463',NULL,'Employee Custom Data Element 4',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EUPGLINFF0Z0','80','D','10','1543',NULL,'Employee Custom Data Element 5',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EUPGLINFF0Z0','80','D','10','1623',NULL,'Employee Custom Data Element 6',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EUPGLINFF0Z0','80','D','10','1703',NULL,'Employee Custom Data Element 7',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EUPGLINFF0Z0','80','D','10','1783',NULL,'Employee Custom Data Element 8',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EUPGLINFF0Z0','80','D','10','1863',NULL,'Employee Custom Data Element 9',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EUPGLINFF0Z0','80','D','10','1943',NULL,'Employee Custom Data Element 10',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EUPGLINFF0Z0','1','D','10','2023',NULL,'Employment Type',NULL,NULL,'"drvEmployType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EUPGLINFF0Z0','4','D','10','2024',NULL,'Service Months',NULL,NULL,'"drvServiceMths"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EUPGLINFF0Z0','8','D','10','2028',NULL,'Original Hire Date',NULL,NULL,'"drvOrigHireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EUPGLINFF0Z0','2','D','10','2036',NULL,'Hire State Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EUPGLINFF0Z0','1','D','10','2038',NULL,'Employment Status',NULL,NULL,'"drvEmplStatus "','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EUPGLINFF0Z0','8','D','10','2039',NULL,'Date of Termination',NULL,NULL,'"drvDateofTerm"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EUPGLINFF0Z0','6','D','10','2047',NULL,'Hours Last 12 Months',NULL,NULL,'"drvHrsLast12Mths"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EUPGLINFF0Z0','10','D','10','2053',NULL,'Hours Worked Per Week',NULL,NULL,'"drvHrsWorkedPerWk"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EUPGLINFF0Z0','9','D','10','2063',NULL,'Hours Worked Per Day',NULL,NULL,'"drvHrsWorkedPerDay"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EUPGLINFF0Z0','8','D','10','2072',NULL,'Days Worked per Week Quantity',NULL,NULL,'"drvDaysWorkedperWkQty"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EUPGLINFF0Z0','1','D','10','2080',NULL,'Workday Indicator - Monday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EUPGLINFF0Z0','1','D','10','2081',NULL,'Workday Indicator - Tuesday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EUPGLINFF0Z0','1','D','10','2082',NULL,'Workday Indicator - Wednesday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EUPGLINFF0Z0','1','D','10','2083',NULL,'Workday Indicator - Thursday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EUPGLINFF0Z0','1','D','10','2084',NULL,'Workday Indicator - Friday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EUPGLINFF0Z0','1','D','10','2085',NULL,'Workday Indicator - Saturday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EUPGLINFF0Z0','1','D','10','2086',NULL,'Workday Indicator - Sunday',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EUPGLINFF0Z0','60','D','10','2087',NULL,'Insurance Company - Medical',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EUPGLINFF0Z0','5','D','10','2147',NULL,'Product 1 – Product Code',NULL,NULL,'"drvP1ProdCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EUPGLINFF0Z0','5','D','10','2152',NULL,'Product 1 - Benefit Type',NULL,NULL,'"drvP1BenType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EUPGLINFF0Z0','1','D','10','2157',NULL,'Product 1 - Coverage Status',NULL,NULL,'"drvP1CovStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EUPGLINFF0Z0','8','D','10','2158',NULL,'Product 1 - Coverage Effective Date',NULL,NULL,'"drvP1CovEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EUPGLINFF0Z0','3','D','10','2166',NULL,'Product 1 - Employee Premium Contribution',NULL,NULL,'"drvP1EmpPremContr"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EUPGLINFF0Z0','3','D','10','2169',NULL,'Product 1 - Benefit Level',NULL,NULL,'"drvP1BenefitLvl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EUPGLINFF0Z0','5','D','10','2172',NULL,'Product 2 - Product Code',NULL,NULL,'"drvP2ProdCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EUPGLINFF0Z0','5','D','10','2177',NULL,'Product 2 - Benefit Type',NULL,NULL,'"drvP2BenType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EUPGLINFF0Z0','1','D','10','2182',NULL,'Product 2 - Coverage Status',NULL,NULL,'"drvP2CovStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EUPGLINFF0Z0','8','D','10','2183',NULL,'Product 2 - Coverage Effective Date',NULL,NULL,'"drvP2CovEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EUPGLINFF0Z0','3','D','10','2191',NULL,'Product 2 - Employee Premium Contribution',NULL,NULL,'"drvP2EmpPremContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EUPGLINFF0Z0','3','D','10','2194',NULL,'Product 2 - Benefit Level',NULL,NULL,'"drvP2BenefitLvl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EUPGLINFF0Z0','5','D','10','2197',NULL,'Product 3 - Product Code',NULL,NULL,'"drvP3ProdCode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EUPGLINFF0Z0','5','D','10','2202',NULL,'Product 3 - Benefit Type',NULL,NULL,'"drvP3BenType"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EUPGLINFF0Z0','1','D','10','2207',NULL,'Product 3 - Coverage Status',NULL,NULL,'"drvP3CovStatus"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EUPGLINFF0Z0','8','D','10','2208',NULL,'Product 3 - Coverage Effective Date',NULL,NULL,'"drvP3CovEffDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EUPGLINFF0Z0','3','D','10','2216',NULL,'Product 3 - Employee Premium Contribution',NULL,NULL,'"drvP3EmpPremContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EUPGLINFF0Z0','3','D','10','2219',NULL,'Product 3 - Benefit Level',NULL,NULL,'"000"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EUPGLINFF0Z0','5','D','10','2222',NULL,'Product 4 - Product Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EUPGLINFF0Z0','5','D','10','2227',NULL,'Product 4 - Benefit Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EUPGLINFF0Z0','1','D','10','2232',NULL,'Product 4 - Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EUPGLINFF0Z0','8','D','10','2233',NULL,'Product 4 - Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EUPGLINFF0Z0','3','D','10','2241',NULL,'Product 4 - Employee Premium Contribution',NULL,NULL,'"drvP4EmpPremContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EUPGLINFF0Z0','3','D','10','2244',NULL,'Product 4 - Benefit Level',NULL,NULL,'"drvP4BenefitLvl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EUPGLINFF0Z0','5','D','10','2247',NULL,'Product 5 - Product Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EUPGLINFF0Z0','5','D','10','2252',NULL,'Product 5 - Benefit Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EUPGLINFF0Z0','1','D','10','2257',NULL,'Product 5 - Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EUPGLINFF0Z0','8','D','10','2258',NULL,'Product 5 - Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EUPGLINFF0Z0','3','D','10','2266',NULL,'Product 5 - Employee Premium Contribution',NULL,NULL,'"drvP5EmpPremContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EUPGLINFF0Z0','3','D','10','2269',NULL,'Product 5 - Benefit Level',NULL,NULL,'"drvP5BenefitLvl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EUPGLINFF0Z0','5','D','10','2272',NULL,'Product 6 - Product Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EUPGLINFF0Z0','5','D','10','2277',NULL,'Product 6 - Benefit Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EUPGLINFF0Z0','1','D','10','2282',NULL,'Product 6 - Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EUPGLINFF0Z0','8','D','10','2283',NULL,'Product 6 - Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EUPGLINFF0Z0','3','D','10','2291',NULL,'Product 6 - Employee Premium Contribution',NULL,NULL,'"drvP6EmpPremContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EUPGLINFF0Z0','3','D','10','2294',NULL,'Product 6 - Benefit Level',NULL,NULL,'"drvP6BenefitLvl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EUPGLINFF0Z0','5','D','10','2297',NULL,'Product 7 - Product Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EUPGLINFF0Z0','5','D','10','2302',NULL,'Product 7 - Benefit Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EUPGLINFF0Z0','1','D','10','2307',NULL,'Product 7 - Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EUPGLINFF0Z0','8','D','10','2308',NULL,'Product 7 - Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EUPGLINFF0Z0','3','D','10','2316',NULL,'Product 7 - Employee Premium Contribution',NULL,NULL,'"drvP7EmpPremContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EUPGLINFF0Z0','3','D','10','2319',NULL,'Product 7 - Benefit Level',NULL,NULL,'"drvP7BenefitLvl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EUPGLINFF0Z0','5','D','10','2322',NULL,'Product 8 - Product Code',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EUPGLINFF0Z0','5','D','10','2327',NULL,'Product 8 - Benefit Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EUPGLINFF0Z0','1','D','10','2332',NULL,'Product 8 - Coverage Status',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EUPGLINFF0Z0','8','D','10','2333',NULL,'Product 8 - Coverage Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EUPGLINFF0Z0','3','D','10','2341',NULL,'Product 8 - Employee Premium Contribution',NULL,NULL,'"drvP8EmpPremContrib"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EUPGLINFF0Z0','3','D','10','2344',NULL,'Product 8 - Benefit Level',NULL,NULL,'"drvP8BenefitLvl"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EUPGLINFF0Z0','1','D','10','2347',NULL,'Entitlement Tracking Duration Type',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EUPGLINFF0Z0','4','D','10','2348',NULL,'Fixed Start Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EUPGLINFF0Z0','1','D','10','2352',NULL,'Eligibility Amount Mode',NULL,NULL,'"drvEligAmtMode"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EUPGLINFF0Z0','11','D','10','2353',NULL,'Eligibility Amount Duration',NULL,NULL,'"drvEligAmtDur"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EUPGLINFF0Z0','1','D','10','2364',NULL,'Eligibility Review Period Mode',NULL,NULL,'"M"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EUPGLINFF0Z0','3','D','10','2365',NULL,'Eligibility Review Period Duration',NULL,NULL,'"drvEligibReviewPeriodDur"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EUPGLINFF0Z0','1','D','10','2368',NULL,'Service Mode',NULL,NULL,'"M"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EUPGLINFF0Z0','12','D','10','2369',NULL,'Service Amount',NULL,NULL,'"drvServiceAmt"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EUPGLINFF0Z0','1','D','10','2381',NULL,'Non-eligible Location indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EUPGLINFF0Z0','8','D','10','2382',NULL,'Work Schedule Effective Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EUPGLINFF0Z0','9','D','10','2390',NULL,'Hours per Day – Monday',NULL,NULL,'"drvHrsPerDayMonday"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EUPGLINFF0Z0','9','D','10','2399',NULL,'Hours per Day – Tuesday',NULL,NULL,'"drvHrsPerDayTuesday"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EUPGLINFF0Z0','9','D','10','2408',NULL,'Hours per Day – Wednesday',NULL,NULL,'"drvHrsPerDayWednesday"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EUPGLINFF0Z0','9','D','10','2417',NULL,'Hours per Day – Thursday',NULL,NULL,'"drvHrsPerDayThursday"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EUPGLINFF0Z0','9','D','10','2426',NULL,'Hours per Day – Friday',NULL,NULL,'"drvHrsPerDayFriday"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EUPGLINFF0Z0','9','D','10','2435',NULL,'Hours per Day – Saturday',NULL,NULL,'"drvHrsPerDaySaturday"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EUPGLINFF0Z0','9','D','10','2444',NULL,'Hours per Day – Sunday',NULL,NULL,'"drvHrsPerDaySunday"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EUPGLINFF0Z0','8','D','10','2453',NULL,'Acquisition Date',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EUPGLINFF0Z0','8','D','10','2461',NULL,'Latest Hire Date',NULL,NULL,'"drvLatestHireDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EUPGLINFF0Z0','1','D','10','2469',NULL,'Key Employee indicator',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EUPGLINFF0Z0','1','D','10','2470',NULL,'Union Employee indicator',NULL,NULL,'"drvUnionEmpIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EUPGLINFF0Z0','1','D','10','2471',NULL,'Exempt Employee indicator',NULL,NULL,'"drvExemptEmpIndicator"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EUPGLINFF0Z0','11','D','10','2472',NULL,'Co-worker Spouse SSN',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EUPGLINFF0Z0','8','D','10','2483',NULL,'Date Created',NULL,NULL,'"drvDateCreated"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EUPGLINFF0Z0','509','D','10','2491',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EUPGLINFF0Z0','9','T','90','1',NULL,'Customer ID',NULL,NULL,'"09-LF0712"','(''DA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EUPGLINFF0Z0','7','T','90','10',NULL,'Record #',NULL,NULL,'"drvRec"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EUPGLINFF0Z0','10','T','90','17',NULL,'Date',NULL,NULL,'"drvDate"','(''UD112''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EUPGLINFF0Z0','7','T','90','27',NULL,'Number of detailed records',NULL,NULL,'"drvNoofDetailRecs"','(''UA''=''F'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EUPGLINFF0Z0','2966','T','90','34',NULL,'Filler',NULL,NULL,'""','(''SS''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EUPGLINFF_20220303.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','',NULL,NULL,NULL,'Lincoln Export','202202109','EMPEXPORT','ONDEM_XOE',NULL,'EUPGLINFF',NULL,NULL,NULL,'202202109','Jan 10 2022  1:58PM','Jan 10 2022  1:58PM','202201031',NULL,'','','202201031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Lincoln Export - Sched','202202109','EMPEXPORT','SCH_EUPGLI',NULL,'EUPGLINFF',NULL,NULL,NULL,'202202109','Jan 10 2022  1:58PM','Jan 10 2022  1:58PM','202201031',NULL,'','','202201031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','','AP87F,8GLSF,TR7I4,JTTTY,8GM6Y,4ADTX,8GLZH,9W6NS,DYKXZ,OVCWN,8GLWF,34D3M,XAVCA,8GM24,8GLND',NULL,NULL,NULL,'Lincoln Export - Test','202202289','EMPEXPORT','TEST_XOE','Feb 28 2022  8:42PM','EUPGLINFF',NULL,NULL,NULL,'202202289','Feb 28 2022 12:00AM','Dec 30 1899 12:00AM','202202141','1066','','','202202141',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1070',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUPGLINFF','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUPGLINFF','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUPGLINFF','InitialSort','C','drvEmpNoSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUPGLINFF','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUPGLINFF','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUPGLINFF','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUPGLINFF','H01','dbo.U_EUPGLINFF_H_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUPGLINFF','D10','dbo.U_EUPGLINFF_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUPGLINFF','T90','dbo.U_EUPGLINFF_T_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EUPGLINFF
-----------

IF OBJECT_ID('U_dsi_BDM_EUPGLINFF') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUPGLINFF] (
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
-- Create table U_EUPGLINFF_Audit
-----------

IF OBJECT_ID('U_EUPGLINFF_Audit') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_Audit] (
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
-- Create table U_EUPGLINFF_AuditFields
-----------

IF OBJECT_ID('U_EUPGLINFF_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EUPGLINFF_DedList
-----------

IF OBJECT_ID('U_EUPGLINFF_DedList') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EUPGLINFF_drvTbl
-----------

IF OBJECT_ID('U_EUPGLINFF_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpNoSort] char(11) NULL,
    [drviCAMAccIDNo] varchar(6) NOT NULL,
    [drviCAMAccVerifNo] varchar(6) NOT NULL,
    [drvDisSubCode] varchar(4) NULL,
    [drvEmpID] char(9) NULL,
    [drvEmpState] varchar(255) NULL,
    [drvDisLocCode] varchar(64) NULL,
    [drvOccDescr] varchar(25) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvStateCode] varchar(255) NULL,
    [drvPostalCode] varchar(9) NULL,
    [drvSSN] char(11) NULL,
    [drvSSNTypeCode] varchar(1) NOT NULL,
    [drvGenderCode] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvDependentQty] varchar(2) NOT NULL,
    [drvDepUnder18Qty] varchar(2) NOT NULL,
    [drvSalaryAmt] varchar(10) NULL,
    [drvHourlyWage] varchar(10) NULL,
    [drvSalaryEffDate] datetime NULL,
    [drvSalaryType] varchar(2) NOT NULL,
    [drvBonusAmt] varchar(10) NOT NULL,
    [drvCommissionAmt] varchar(10) NOT NULL,
    [drvSalaryMode] varchar(1) NOT NULL,
    [drvYTDWages] varchar(10) NOT NULL,
    [drvW4WithHldgAllow] varchar(2) NOT NULL,
    [drvEmployType] varchar(1) NOT NULL,
    [drvServiceMths] varchar(4) NOT NULL,
    [drvOrigHireDate] datetime NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvDateofTerm] datetime NULL,
    [drvHrsLast12Mths] varchar(6) NOT NULL,
    [drvHrsWorkedPerWk] varchar(10) NOT NULL,
    [drvHrsWorkedPerDay] varchar(9) NOT NULL,
    [drvDaysWorkedperWkQty] varchar(8) NOT NULL,
    [drvP1ProdCode] varchar(5) NOT NULL,
    [drvP1BenType] varchar(5) NOT NULL,
    [drvP1CovStatus] varchar(1) NOT NULL,
    [drvP1CovEffDate] datetime NULL,
    [drvP1EmpPremContr] varchar(3) NOT NULL,
    [drvP1BenefitLvl] varchar(3) NOT NULL,
    [drvP2ProdCode] varchar(5) NOT NULL,
    [drvP2BenType] varchar(5) NOT NULL,
    [drvP2CovStatus] varchar(1) NOT NULL,
    [drvP2CovEffDate] datetime NULL,
    [drvP2EmpPremContrib] varchar(3) NOT NULL,
    [drvP2BenefitLvl] varchar(3) NOT NULL,
    [drvP3ProdCode] varchar(5) NOT NULL,
    [drvP3BenType] varchar(5) NULL,
    [drvP3CovStatus] varchar(1) NOT NULL,
    [drvP3CovEffDate] datetime NULL,
    [drvP3EmpPremContrib] varchar(3) NULL,
    [drvP4EmpPremContrib] varchar(3) NULL,
    [drvP4BenefitLvl] varchar(3) NOT NULL,
    [drvP5EmpPremContrib] varchar(3) NOT NULL,
    [drvP5BenefitLvl] varchar(3) NOT NULL,
    [drvP6EmpPremContrib] varchar(3) NOT NULL,
    [drvP6BenefitLvl] varchar(3) NOT NULL,
    [drvP7EmpPremContrib] varchar(3) NOT NULL,
    [drvP7BenefitLvl] varchar(3) NOT NULL,
    [drvP8EmpPremContrib] varchar(3) NOT NULL,
    [drvP8BenefitLvl] varchar(3) NOT NULL,
    [drvEligAmtMode] varchar(1) NOT NULL,
    [drvEligAmtDur] varchar(10) NULL,
    [drvEligibReviewPeriodDur] varchar(3) NOT NULL,
    [drvServiceAmt] int NULL,
    [drvHrsPerDayMonday] varchar(9) NOT NULL,
    [drvHrsPerDayTuesday] varchar(9) NOT NULL,
    [drvHrsPerDayWednesday] varchar(9) NOT NULL,
    [drvHrsPerDayThursday] varchar(9) NOT NULL,
    [drvHrsPerDayFriday] varchar(9) NOT NULL,
    [drvHrsPerDaySaturday] varchar(9) NOT NULL,
    [drvHrsPerDaySunday] varchar(9) NOT NULL,
    [drvLatestHireDate] datetime NULL,
    [drvUnionEmpIndicator] varchar(1) NOT NULL,
    [drvExemptEmpIndicator] varchar(1) NOT NULL,
    [drvDateCreated] datetime NOT NULL
);

-----------
-- Create table U_EUPGLINFF_EEList
-----------

IF OBJECT_ID('U_EUPGLINFF_EEList') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EUPGLINFF_File
-----------

IF OBJECT_ID('U_EUPGLINFF_File') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2999) NULL
);

-----------
-- Create table U_EUPGLINFF_H_drvTbl
-----------

IF OBJECT_ID('U_EUPGLINFF_H_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_H_drvTbl] (
    [drvRecordNo] varchar(7) NOT NULL,
    [drvDATE] nvarchar(4000) NULL,
    [drvRecordLength] varchar(7) NOT NULL
);

-----------
-- Create table U_EUPGLINFF_PEarHist
-----------

IF OBJECT_ID('U_EUPGLINFF_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);

-----------
-- Create table U_EUPGLINFF_T_drvTbl
-----------

IF OBJECT_ID('U_EUPGLINFF_T_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUPGLINFF_T_drvTbl] (
    [drvRec] varchar(7) NOT NULL,
    [drvDate] varchar(9) NULL,
    [drvNoofDetailRecs] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUPGLINFF]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UPG Enterprises LLC

Created By: Marie Thomerson
Business Analyst: Lea King
Create Date: 01/03/2022
Service Request Number: UPG - TekP-2021-10-20-0003

Purpose: Lincoln FMLA, STD, LTD

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUPGLINFF';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUPGLINFF';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUPGLINFF';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUPGLINFF';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUPGLINFF' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUPGLINFF', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUPGLINFF', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUPGLINFF', 'SCH_EUPGLI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUPGLINFF';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EUPGLINFF', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUPGLINFF';

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
    DELETE FROM dbo.U_EUPGLINFF_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUPGLINFF_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUPGLINFF_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_AuditFields;
    CREATE TABLE dbo.U_EUPGLINFF_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EUPGLINFF_AuditFields VALUES ('EmpComp','EecDateofTermination');
    INSERT INTO dbo.U_EUPGLINFF_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EUPGLINFF_AuditFields VALUES ('EmpComp','EecTermReason');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUPGLINFF_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_Audit;
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
    INTO dbo.U_EUPGLINFF_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EUPGLINFF_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(D, -90, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EUPGLINFF_Audit ON dbo.U_EUPGLINFF_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EUPGLINFF_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EUPGLINFF_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EUPGLINFF_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUPGLINFF_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','NMSTD,LEX,CSUN,LTD');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EUPGLINFF_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_PEarHist;
    SELECT DISTINCT
         PehEEID
        --,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        --,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        --,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        --,PehCurAmtYTD           = SUM(CASE WHEN Pehearncode IN ('REG', 'OT', 'DT', 'TT') THEN PehCurAmt END)   --SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN Pehearncode in ('DT','OT','REG','TT') THEN PehCurHrs END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EUPGLINFF_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
        WHERE PehPayDate between dateadd(D, -365, @EndDate) and @EndDate
    --WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurHrs) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUPGLINFF_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUPGLINFF_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvEmpNoSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drviCAMAccIDNo = '000000'
        ,drviCAMAccVerifNo = '000000'
        ,drvDisSubCode = CASE WHEN CmpCompanyCode = '01' AND EecPayGroup IN ('UP') THEN '0001'
                                    WHEN CmpCompanyCode = '04' THEN '0004'
                                    WHEN CmpCompanyCode = 'CSC' THEN '0CSC'
                                    WHEN CmpCompanyCode = '10' THEN '0010'
                                    WHEN CmpCompanyCode = 'LEXST' THEN 'LEXS'
                                    WHEN CmpCompanyCode = 'MKPRC' THEN 'MKPR'
                                    WHEN CmpCompanyCode IN ('MKUSA','08') THEN '0008'
                                    WHEN CmpCompanyCode = '05' THEN '0005'
                                    WHEN CmpCompanyCode = '01' AND EecPayGroup NOT IN ('UP') THEN 'MTLX'
                                    WHEN CmpCompanyCode = 'NLMW' THEN 'NLMW'
                                    END
                                    --'0000'
        ,drvEmpID = EecEmpNo
        ,drvEmpState = EepAddressState
        ,drvDisLocCode = [dbo].[ACEfn_PadR](eeclocation,8,'0')
        ,drvOccDescr = JbcDesc
        ,drvFirstName = EepNameFirst
        ,drvLastName = EepNameLast
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvStateCode = EepAddressState
        ,drvPostalCode = LEFT(EepAddressZipCode,9)
        ,drvSSN = eepSSN
        ,drvSSNTypeCode = '1'
        ,drvGenderCode = eepgender
        ,drvBirthDate = EepDateOfBirth
        ,drvDependentQty = '0 '
        ,drvDepUnder18Qty = '0 '
        ,drvSalaryAmt = CASE WHEN EecSalaryOrHourly = 'S' THEN  CAST(EecAnnSalary as VARCHAR(10)) ELSE '0.0       ' END
        --RIGHT(SPACE(9) + FORMAT(EecScheduledAnnualHrs/52/5, '#0'), 9)
        --0.0 left justified; pad with spaces to complete 10 byte field size
        ,drvHourlyWage = CASE WHEN EecSalaryOrHourly = 'H' THEN LEFT(CAST(EecHourlyPayRate as decimal(6,2)),10) ELSE '0.0       ' END
                --CASE WHEN EecSalaryOrHourly = 'H' THEN LEFT(CAST(EecHourlyPayRate as VARCHAR(10)),10) ELSE '0.0       ' END
        --left justified; pad with spaces to complete 10 byte field size
        --FORMAT((SELECT COUNT(*) FROM dbo.U_EUPGLINFF_drvTbl), '0000000')
        ,drvSalaryEffDate = [dbo].[dsi_fnlib_GetAnnSalary_EffDate_WithStartDate] (EecEEID,EecCOID,'01/01/2021',EecDateOfLastHire)
        ,drvSalaryType = CASE WHEN EecSalaryOrHourly = 'S' THEN 'SL' WHEN EecSalaryOrHourly = 'H' THEN 'HR' ELSE '  ' END
        ,drvBonusAmt = '0.0       '
        ,drvCommissionAmt = '0.0       '
        ,drvSalaryMode = CASE WHEN EecSalaryOrHourly = 'S' THEN '6' WHEN EecSalaryOrHourly = 'H' THEN '1' ELSE ' ' END
        ,drvYTDWages = '0.0       '
        ,drvW4WithHldgAllow = '0 '
        ,drvEmployType = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1' ELSE '2' END
        ,drvServiceMths = '0   '
        ,drvOrigHireDate = EecDateOfLastHire
        ,drvEmplStatus = CASE WHEN EecEmplStatus = 'T' THEN 'T' ELSE 'A' END
        ,drvDateofTerm = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvHrsLast12Mths = '0.0   '
        ,drvHrsWorkedPerWk = '0.0       '
        ,drvHrsWorkedPerDay = '0.0      '
        ,drvDaysWorkedperWkQty = '0.0     '
        ,drvP1ProdCode = CASE WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN 'STD  ' 
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal = 'CSCIN142' THEN '     ' 
                                ELSE 'STD  ' 
                        END
        ,drvP1BenType = CASE WHEN EecDedGroupCode =  'LEX' THEN 'STD03'
                                WHEN EecDedGroupCode = 'CSUN' THEN 'STD04'
                                WHEN BDMSTD.Bdmdedcode = 'NMSTD' and EecUnionLocal <> 'CSCIN142' THEN 'STD02'
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal = 'CSCIN142' THEN '     ' 
                                else 'STD01' 
                        END
        ,drvP1CovStatus = CASE WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN 'A' 
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal = 'CSCIN142' THEN ' ' 
                                ELSE 'A' END
        ,drvP1CovEffDate = CASE WHEN BDMSTD.Bdmdedcode = 'NMSTD' AND BDMSTD.Bdmbenstartdate <= CAST('2022-01-01' as datetime) THEN CAST('2022-01-01' as datetime)
                                WHEN EecUnionLocal <> 'CSCIN142' THEN dbo.dsi_fnGetMinMaxDates('MAX',EecDateofLastHire,CAST('2022-01-01' as datetime)) 
                                --else dbo.dsi_fnGetMinMaxDates('MAX',EecDateofLastHire,CAST('2022-01-01' as datetime)) 
                                END 
                                /*CASE WHEN BDMSTD.Bdmdedcode = 'NMSTD' AND BDMSTD.Bdmbenstartdate < CAST('2022-01-01' as datetime) THEN CAST('2022-01-01' as datetime)
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal <> 'CSCIN142' THEN EecDateofLastHire 
                                else BDMSTD.Bdmbenstartdate END */
        --ELSE '        ' END   THEN CASE WHEN 
        ,drvP1EmpPremContr = CASE WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN '000' 
                                    WHEN EecUnionLocal IS NOT NULL and EecUnionLocal = 'CSCIN142' THEN  '0  ' 
                                    ELSE '000' 
                                    END
        ,drvP1BenefitLvl = CASE WHEN BDMSTD.Bdmdedcode = 'NMSTD' THEN '060' 
                                    WHEN EecUnionLocal IS NOT NULL and EecUnionLocal = 'CSCIN142' THEN '0  ' 
                                    ELSE '060' 
                                    END
        ,drvP2ProdCode = CASE    
        --WHEN BDMLTD.Bdmdedcode = 'LTD' THEN 'LTD  ' 
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal IN ('CSCIN142', 'LEXBIL') THEN '     ' 
                                ELSE 'LTD  '    
                                END
        ,drvP2BenType = CASE 
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal = 'CHISTL' THEN 'LTD03'  
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal = 'NATLMETALWAR' THEN 'LTD02'  
                                WHEN EecUnionLocal IN ('CSCIN142', 'LEXBIL') THEN '     '
                                ELSE 'LTD01'  
                                END
        --WHEN BDMLTD.Bdmdedcode = 'LTD' THEN 'XXXX ' 
        ,drvP2CovStatus = CASE WHEN EecUnionLocal IS NOT NULL and EecUnionLocal IN ('CSCIN142', 'LEXBIL') THEN ' ' 
                                ELSE 'A'    
                                END
        --WHEN BDMLTD.Bdmdedcode = 'LTD' THEN 'A' 
        ,drvP2CovEffDate = CASE 
                                --WHEN EecUnionLocal IN ('CSCIN142', 'LEXBIL') THEN '        '
                                WHEN EecUnionLocal IS NOT NULL AND EecUnionLocal NOT IN ('CSCIN142' , 'LEXBIL') THEN dbo.dsi_fnGetMinMaxDates('MAX',EecDateofLastHire,CAST('2022-01-01' as datetime)) 
                                --WHEN EecUnionLocal IS NOT NULL and EecUnionLocal NOT IN ('CSCIN142' , 'LEXBIL') AND EecDateofLastHire <= CAST('2022-01-01' as datetime) THEN CONVERT(varchar,CAST('2022-01-01' as datetime),112)
                                --WHEN EecUnionLocal <> 'LEXBIL' AND EecDateofLastHire > 2022-01-01 THEN EecDateofLastHire
                                --WHEN EecUnionLocal <> 'LEXBIL' AND EecDateofLastHire < 2022-01-01 THEN 2022-01-01
                                --ELSE  '        '
                            END/*CASE 
                                --WHEN EecUnionLocal IN ('CSCIN142', 'LEXBIL') THEN '        '
                                WHEN EecUnionLocal IS NOT NULL AND EecDateofLastHire > CAST('2022-01-01' as datetime) and (EecUnionLocal NOT IN  ('CSCIN142' , 'LEXBIL') ) THEN EecDateofLastHire
                                WHEN EecUnionLocal IS NOT NULL and (EecUnionLocal NOT IN  ('CSCIN142' , 'LEXBIL') ) AND EecDateofLastHire < 2022-01-01 THEN 2022-01-01
                                --WHEN EecUnionLocal IS NOT NULL and (EecUnionLocal <> 'CSCIN142' or EecUnionLocal <> 'LEXBIL') AND EecDateofLastHire < 2022-01-01 THEN 2022-01-01
                                --WHEN EecUnionLocal <> 'LEXBIL' AND EecDateofLastHire > 2022-01-01 THEN EecDateofLastHire
                                --WHEN EecUnionLocal <> 'LEXBIL' AND EecDateofLastHire < 2022-01-01 THEN 2022-01-01
                                ELSE  '        '
                            END*/
        --WHEN BDMLTD.Bdmdedcode = 'LTD' AND BDMLTD.Bdmbenstartdate < 2022-01-01 THEN 2022-01-01 else BDMLTD.Bdmbenstartdate END 
        --ELSE '        ' END 
        ,drvP2EmpPremContrib = CASE WHEN EecUnionLocal IS NOT NULL and EecUnionLocal IN ('CSCIN142', 'LEXBIL') THEN '0  '
                                    WHEN EecUnionLocal IS NOT NULL and EecUnionLocal NOT IN ('CSCIN142' , 'LEXBIL') THEN '000' 
        --WHEN BDMLTD.Bdmdedcode = 'LTD' THEN '000' 
                                    ELSE '0  ' END
        ,drvP2BenefitLvl = CASE WHEN EecUnionLocal IS NOT NULL and EecUnionLocal IN ('CSCIN142', 'LEXBIL') THEN '0  '
                                WHEN EecUnionLocal IS NOT NULL and EecUnionLocal NOT IN ('CSCIN142' , 'LEXBIL') THEN '060' 
        --WHEN BDMLTD.Bdmdedcode = 'LTD' THEN '060' 
                                    ELSE '0  ' END
        ,drvP3ProdCode = CASE WHEN EecEEType = 'REG' THEN 'LEAVE' ELSE '     ' END
        ,drvP3BenType = CASE WHEN EecEEType = 'REG' THEN 'FMLA '  END
        ,drvP3CovStatus = CASE WHEN EecEEType = 'REG' THEN 'A' ELSE ' ' END
        ,drvP3CovEffDate = CASE WHEN EecEEType = 'REG' THEN eecdateoflasthire END
        ,drvP3EmpPremContrib = CASE WHEN EecEEType = 'REG' THEN '000' END
        ,drvP4EmpPremContrib = CASE WHEN EecEEType = 'REG' THEN '000' END
        ,drvP4BenefitLvl = '0  '
        ,drvP5EmpPremContrib = '0  '
        ,drvP5BenefitLvl = '0  '
        ,drvP6EmpPremContrib = '0  '
        ,drvP6BenefitLvl = '0  '
        ,drvP7EmpPremContrib = '0  '
        ,drvP7BenefitLvl = '0  '
        ,drvP8EmpPremContrib = '0  '
        ,drvP8BenefitLvl = '0  '
        ,drvEligAmtMode = 'H'
        ,drvEligAmtDur = LEFT(CAST(PehCurHrsYTD as decimal(6,2)),10)  --LEFT(PehCurHrsYTD,11)
        --SUM(PehCurHrs) where PehEarnCode in (XXX) for per controls for last 12 months
        ,drvEligibReviewPeriodDur = '012'
        ,drvServiceAmt = DateDiff(MM, eecdateoflasthire, GETDATE())
        --# of month from eecdateoflasthire to file run date
        ,drvHrsPerDayMonday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayTuesday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayWednesday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayThursday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDayFriday = CASE WHEN EecFullTimeOrPartTime = 'F'  THEN '8.0      ' else '4.0      ' END
        ,drvHrsPerDaySaturday = '0.0      '
        ,drvHrsPerDaySunday =  '0.0      '
        ,drvLatestHireDate = EecDateOfLastHire
        ,drvUnionEmpIndicator = CASE WHEN EecUnionLocal IS NOT NULL or EecUnionNational is not NULL THEN 'Y' else 'N' END
        ,drvExemptEmpIndicator = CASE WHEN JHT.NewValue in ( 'E','Z') THEN 'Y' ELSE 'N' END
        ,drvDateCreated = GETDATE()
        --,drvRecordDelimiter = ''
    INTO dbo.U_EUPGLINFF_drvTbl
    FROM dbo.U_EUPGLINFF_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecEEType = 'REG'
                 And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          and EXISTS (Select 1 from dbo.U_EUPGLINFF_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EUPGLINFF_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMLTD WITH (NOLOCK)
        ON BDMLTD.BdmEEID = xEEID 
        AND BDMLTD.BdmCoID = xCoID
        AND BDMLTD.Bdmdedcode = 'LTD' 
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMSTD WITH (NOLOCK)
        ON BDMSTD.BdmEEID = xEEID 
        AND BDMSTD.BdmCoID = xCoID
        AND BDMSTD.Bdmdedcode = 'NMSTD'
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMCSUN WITH (NOLOCK)
        ON BDMCSUN.BdmEEID = xEEID 
        AND BDMCSUN.BdmCoID = xCoID
        AND BDMCSUN.Bdmdedcode = 'CSUN'
    LEFT JOIN dbo.U_dsi_BDM_EUPGLINFF AS BDMLEX WITH (NOLOCK)
        ON BDMLEX.BdmEEID = xEEID 
        AND BDMLEX.BdmCoID = xCoID
        AND BDMLEX.Bdmdedcode = 'CSUN'
    LEFT JOIN JOBCODE
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.dsi_fnlib_JobHistoryTable_v2 ('EjhFLSACategory') JHT
        ON JHT.EEID = EecEEID
        AND JHT.CoID = EecCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON xCOID = CmpCOID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUPGLINFF_H_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_H_drvTbl;
    SELECT DISTINCT
         drvRecordNo = '0000000'
        ,drvDATE = FORMAT(GETDATE(), 'yyyyMMdd')+'  '
        ,drvRecordLength = '3000   '
        --,drvRecDelim = ' '
    INTO dbo.U_EUPGLINFF_H_drvTbl
    FROM dbo.U_EUPGLINFF_EEList WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EUPGLINFF WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUPGLINFF_T_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUPGLINFF_T_drvTbl;
    SELECT DISTINCT
         drvRec = '9999999'
        ,drvDate = CONVERT(VARCHAR(8),GETDATE(),112)+''
        ,drvNoofDetailRecs = FORMAT((SELECT COUNT(*) FROM dbo.U_EUPGLINFF_drvTbl), '0000000')
        --,drvRecordDelimiter = ' '
    INTO dbo.U_EUPGLINFF_T_drvTbl
    FROM dbo.U_EUPGLINFF_EEList WITH (NOLOCK)
    JOIN dbo.U_dsi_BDM_EUPGLINFF WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '09LF0712.UPG.' + CONVERT(VARCHAR(8),GETDATE(),112) + '.elg.txt'
                                  ELSE '09LF0712.UPG.' + CONVERT(VARCHAR(8),GETDATE(),112) + '.elg.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUPGLINFF_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUPGLINFF_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUPGLINFF%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202201031'
       ,expStartPerControl     = '202201031'
       ,expLastEndPerControl   = '202202109'
       ,expEndPerControl       = '202202109'
WHERE expFormatCode = 'EUPGLINFF';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUPGLINFF_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUPGLINFF_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EUPGLINFF' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EUPGLINFF'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EUPGLINFF'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUPGLINFF', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EUPGLINFF', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EUPGLINFF', 'UseFileName', 'V', 'Y'


-- End ripout