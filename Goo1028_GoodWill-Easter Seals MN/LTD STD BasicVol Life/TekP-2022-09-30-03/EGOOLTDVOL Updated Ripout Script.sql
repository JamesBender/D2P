/**********************************************************************************

EGOOLTDVOL: Hartford LTD, STD, Life, AD&D, Crit, Acc, Hosp

FormatCode:     EGOOLTDVOL
Project:        Hartford LTD, STD, Life, AD&D, Crit, Acc, Hosp
Client ID:      GOO1028
Date/time:      2023-04-19 09:59:22.707
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP2DB03
Database:       ULTIPRO_WPGESM
Web Filename:   GOO1028_X25JZ_EEHISTORY_EGOOLTDVOL_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EGOOLTDVOL_SavePath') IS NOT NULL DROP TABLE dbo.U_EGOOLTDVOL_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EGOOLTDVOL'


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
WHERE FormatCode = 'EGOOLTDVOL'
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
WHERE ExpFormatCode = 'EGOOLTDVOL'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EGOOLTDVOL')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EGOOLTDVOL'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EGOOLTDVOL'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EGOOLTDVOL'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EGOOLTDVOL'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EGOOLTDVOL'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EGOOLTDVOL'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EGOOLTDVOL'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EGOOLTDVOL'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EGOOLTDVOL'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEGOOLTDVOL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEGOOLTDVOL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EGOOLTDVOL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGOOLTDVOL];
GO
IF OBJECT_ID('U_EGOOLTDVOL_HDR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_HDR_drvTbl];
GO
IF OBJECT_ID('U_EGOOLTDVOL_FTR_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_FTR_drvTbl];
GO
IF OBJECT_ID('U_EGOOLTDVOL_File') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_File];
GO
IF OBJECT_ID('U_EGOOLTDVOL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_EEList];
GO
IF OBJECT_ID('U_EGOOLTDVOL_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_drvTbl];
GO
IF OBJECT_ID('U_EGOOLTDVOL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_DedList];
GO
IF OBJECT_ID('U_EGOOLTDVOL_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_AuditFields];
GO
IF OBJECT_ID('U_EGOOLTDVOL_Audit') IS NOT NULL DROP TABLE [dbo].[U_EGOOLTDVOL_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EGOOLTDVOL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EGOOLTDVOL];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EGOOLTDVOL','Hartford LTD, STD, Life, AD&D, Crit, Acc, Hosp','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','12000','S','N','EGOOLTDVOLZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGOOLTDVOLZ0','5','H','01','1',NULL,'Section code',NULL,NULL,'"~HDR~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGOOLTDVOLZ0','3','H','01','6',NULL,'Customer Count',NULL,NULL,'"drvCustomerCount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGOOLTDVOLZ0','30','H','01','9',NULL,'File Name',NULL,NULL,'"drvFileName"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGOOLTDVOLZ0','20','H','01','39',NULL,'Date File Created',NULL,NULL,'"drvDateCreated"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGOOLTDVOLZ0','20','H','01','59',NULL,'Customer Name',NULL,NULL,'"GoodWillESM"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGOOLTDVOLZ0','6','H','01','79',NULL,'File Version Number',NULL,NULL,'"drvVersionNo"','(''UA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGOOLTDVOLZ0','5','D','10','1',NULL,'Section code',NULL,NULL,'"~PII~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGOOLTDVOLZ0','10','D','10','6',NULL,'Customer Number',NULL,NULL,'"drvCustomerNumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EGOOLTDVOLZ0','1','D','10','16',NULL,'Transaction Code',NULL,NULL,'"drvTransactionCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EGOOLTDVOLZ0','9','D','10','17',NULL,'Employee SSN',NULL,NULL,'"drvSSN"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EGOOLTDVOLZ0','15','D','10','26',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID "','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EGOOLTDVOLZ0','9','D','10','41',NULL,'Member SSN/Member ID',NULL,NULL,'"drvMemberID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EGOOLTDVOLZ0','2','D','10','50',NULL,'Relationship Code',NULL,NULL,'"drvRelationshipCode"','(''UDMDY''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EGOOLTDVOLZ0','30','D','10','52',NULL,'Last Name',NULL,NULL,'"drvNameLast"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EGOOLTDVOLZ0','30','D','10','82',NULL,'First Name',NULL,NULL,'"drvNameFirst"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EGOOLTDVOLZ0','1','D','10','112',NULL,'Middle Initial',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EGOOLTDVOLZ0','10','D','10','113',NULL,'Name Prefix',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EGOOLTDVOLZ0','10','D','10','123',NULL,'Name Suffix',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EGOOLTDVOLZ0','8','D','10','133',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EGOOLTDVOLZ0','1','D','10','141',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EGOOLTDVOLZ0','1','D','10','142',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EGOOLTDVOLZ0','1','D','10','143',NULL,'Smoker Status',NULL,NULL,'"drvSmokerStatus"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EGOOLTDVOLZ0','5','D','10','144',NULL,'Section Code',NULL,NULL,'"~BNK~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EGOOLTDVOLZ0','20','D','10','149',NULL,'Bank ABA Routing Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EGOOLTDVOLZ0','40','D','10','169',NULL,'Bank Account Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EGOOLTDVOLZ0','1','D','10','209',NULL,'Bank Account Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EGOOLTDVOLZ0','5','D','10','210',NULL,'Section Code',NULL,NULL,'"~ECI~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EGOOLTDVOLZ0','40','D','10','215',NULL,'Member Mailing Address 1',NULL,NULL,'"EepAddressLine1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EGOOLTDVOLZ0','40','D','10','255',NULL,'Member Mailing Address 2',NULL,NULL,'"EepAddressLine2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EGOOLTDVOLZ0','30','D','10','295',NULL,'Member Mailing Address City',NULL,NULL,'"EepAddressCity"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EGOOLTDVOLZ0','2','D','10','325',NULL,'Member Mailing Address State',NULL,NULL,'"EepAddressState"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','EGOOLTDVOLZ0','10','D','10','327',NULL,'Member Mailing Address Zip Code',NULL,NULL,'"EepAddressZipCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','EGOOLTDVOLZ0','3','D','10','337',NULL,'Member Mailing Address Country Code',NULL,NULL,'"840"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','EGOOLTDVOLZ0','2','D','10','340',NULL,'Member Mailing Address Province Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','EGOOLTDVOLZ0','30','D','10','342',NULL,'Member Mailing Address Province Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','EGOOLTDVOLZ0','10','D','10','372',NULL,'Employee Home Phone',NULL,NULL,'"eepphonehomenumber"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','EGOOLTDVOLZ0','10','D','10','382',NULL,'Employee Cell Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','EGOOLTDVOLZ0','50','D','10','392',NULL,'Employee Personal E-mail Address',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('33','EGOOLTDVOLZ0','50','D','10','442',NULL,'Employee Work E-mail Address',NULL,NULL,'"eepAddressEMail"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('34','EGOOLTDVOLZ0','2','D','10','492',NULL,'Employee Work State Code',NULL,NULL,'"drvWorkStateCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('35','EGOOLTDVOLZ0','40','D','10','494',NULL,'Employee Work Address 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('36','EGOOLTDVOLZ0','40','D','10','534',NULL,'Employee Work Address 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('37','EGOOLTDVOLZ0','30','D','10','574',NULL,'Employee Work Address City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('38','EGOOLTDVOLZ0','2','D','10','604',NULL,'Employee Work Address State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('39','EGOOLTDVOLZ0','10','D','10','606',NULL,'Employee Work Address Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('40','EGOOLTDVOLZ0','3','D','10','616',NULL,'Employee Work Address Country Code',NULL,NULL,'"840"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('41','EGOOLTDVOLZ0','10','D','10','619',NULL,'Employee Work Phone',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('42','EGOOLTDVOLZ0','5','D','10','629',NULL,'Section Code',NULL,NULL,'"~ERC~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('43','EGOOLTDVOLZ0','30','D','10','634',NULL,'Supervisor Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('44','EGOOLTDVOLZ0','30','D','10','664',NULL,'Supervisor First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('45','EGOOLTDVOLZ0','20','D','10','694',NULL,'Supervisor ID',NULL,NULL,'"drvSupervisorID"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('46','EGOOLTDVOLZ0','10','D','10','714',NULL,'Supervisor Work Phone Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('47','EGOOLTDVOLZ0','50','D','10','724',NULL,'Supervisor Email Address',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('48','EGOOLTDVOLZ0','30','D','10','774',NULL,'HR Manager Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('49','EGOOLTDVOLZ0','30','D','10','804',NULL,'HR Manager First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('50','EGOOLTDVOLZ0','20','D','10','834',NULL,'HR Manager ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('51','EGOOLTDVOLZ0','10','D','10','854',NULL,'HR Manager Work Phone Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('52','EGOOLTDVOLZ0','50','D','10','864',NULL,'HR Manager Email Address',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('53','EGOOLTDVOLZ0','30','D','10','914',NULL,'ER Contact Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('54','EGOOLTDVOLZ0','30','D','10','944',NULL,'ER Contact First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('55','EGOOLTDVOLZ0','20','D','10','974',NULL,'ER ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('56','EGOOLTDVOLZ0','50','D','10','994',NULL,'ER Contact Email Address',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('57','EGOOLTDVOLZ0','5','D','10','1044',NULL,'Section Code',NULL,NULL,'"~EMI~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('58','EGOOLTDVOLZ0','1','D','10','1049',NULL,'Employee Status Code',NULL,NULL,'"drvEmplStatusCode"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('59','EGOOLTDVOLZ0','8','D','10','1050',NULL,'Employee Status Effective Date',NULL,NULL,'"drvStatusEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('60','EGOOLTDVOLZ0','8','D','10','1058',NULL,'Employee Service Date',NULL,NULL,'"drvEmplServiceDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('61','EGOOLTDVOLZ0','8','D','10','1066',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('62','EGOOLTDVOLZ0','8','D','10','1074',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('63','EGOOLTDVOLZ0','10','D','10','1082',NULL,'Employee Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('64','EGOOLTDVOLZ0','35','D','10','1092',NULL,'Employee Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('65','EGOOLTDVOLZ0','8','D','10','1127',NULL,'Last Day Worked',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('66','EGOOLTDVOLZ0','2','D','10','1135',NULL,'Employment Type',NULL,NULL,'"drvEmploymentType"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('67','EGOOLTDVOLZ0','1','D','10','1137',NULL,'Exempt/Non-Exempt',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('68','EGOOLTDVOLZ0','4','D','10','1138',NULL,'Scheduled Hours Per Week',NULL,NULL,'"drvScheduledHoursPerWeek"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('69','EGOOLTDVOLZ0','9','D','10','1142',NULL,'Benefit Salary Amount',NULL,NULL,'"drvAnnSalary"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('70','EGOOLTDVOLZ0','1','D','10','1151',NULL,'Salary Basis',NULL,NULL,'"A"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('71','EGOOLTDVOLZ0','12','D','10','1152',NULL,'Additional Salary Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('72','EGOOLTDVOLZ0','2','D','10','1164',NULL,'Additional Salary/Wage Basis',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('73','EGOOLTDVOLZ0','8','D','10','1166',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffectiveDate"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('74','EGOOLTDVOLZ0','9','D','10','1174',NULL,'Commission Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('75','EGOOLTDVOLZ0','9','D','10','1183',NULL,'Bonus',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('76','EGOOLTDVOLZ0','1','D','10','1192',NULL,'Payroll Basis',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('77','EGOOLTDVOLZ0','4','D','10','1193',NULL,'Pay Grade Level',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('78','EGOOLTDVOLZ0','2','D','10','1197',NULL,'Pay Period Frequency',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('79','EGOOLTDVOLZ0','8','D','10','1199',NULL,'Pay Period Begin Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('80','EGOOLTDVOLZ0','8','D','10','1207',NULL,'Pay Period End Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('81','EGOOLTDVOLZ0','25','D','10','1215',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('82','EGOOLTDVOLZ0','1','D','10','1240',NULL,'Job Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('83','EGOOLTDVOLZ0','10','D','10','1241',NULL,'Payroll Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('84','EGOOLTDVOLZ0','10','D','10','1251',NULL,'Company Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('85','EGOOLTDVOLZ0','10','D','10','1261',NULL,'Department Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('86','EGOOLTDVOLZ0','10','D','10','1271',NULL,'Division Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('87','EGOOLTDVOLZ0','10','D','10','1281',NULL,'Location Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('88','EGOOLTDVOLZ0','10','D','10','1291',NULL,'Region Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('89','EGOOLTDVOLZ0','10','D','10','1301',NULL,'Account Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('90','EGOOLTDVOLZ0','1','D','10','1311',NULL,'Union Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('91','EGOOLTDVOLZ0','10','D','10','1312',NULL,'Union Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('92','EGOOLTDVOLZ0','30','D','10','1322',NULL,'Medical Carrier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('93','EGOOLTDVOLZ0','30','D','10','1352',NULL,'Mental Health Carrier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('94','EGOOLTDVOLZ0','5','D','10','1382',NULL,'Section Code',NULL,NULL,'"~CSF~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('95','EGOOLTDVOLZ0','30','D','10','1387',NULL,'Client-Specific Field #1 Name Last 8 Week Earnings',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('96','EGOOLTDVOLZ0','30','D','10','1417',NULL,'Client-Specific Field #1 Value Last 8 Week Earning',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('97','EGOOLTDVOLZ0','30','D','10','1447',NULL,'Client-Specific Field #2 Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('98','EGOOLTDVOLZ0','30','D','10','1477',NULL,'Client-Specific Field #2 Value',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('99','EGOOLTDVOLZ0','30','D','10','1507',NULL,'Client-Specific Field #3 Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('100','EGOOLTDVOLZ0','30','D','10','1537',NULL,'Client-Specific Field #3 Value',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('101','EGOOLTDVOLZ0','30','D','10','1567',NULL,'Client-Specific Field#4 Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('102','EGOOLTDVOLZ0','30','D','10','1597',NULL,'Client-Specific Field #4 Value',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('103','EGOOLTDVOLZ0','30','D','10','1627',NULL,'Client-Specific Field #5 Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('104','EGOOLTDVOLZ0','30','D','10','1657',NULL,'Client-Specific Field #5 Value',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('105','EGOOLTDVOLZ0','30','D','10','1687',NULL,'Client-Specific Field #6 Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('106','EGOOLTDVOLZ0','30','D','10','1717',NULL,'Client-Specific Field #6 Value',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('107','EGOOLTDVOLZ0','30','D','10','1747',NULL,'Client-Specific Field #7 Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('108','EGOOLTDVOLZ0','30','D','10','1777',NULL,'Client-Specific Field #7 Value',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('109','EGOOLTDVOLZ0','30','D','10','1807',NULL,'Client-Specific Field #8 Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('110','EGOOLTDVOLZ0','30','D','10','1837',NULL,'Client-Specific Field #8 Value',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('111','EGOOLTDVOLZ0','5','D','10','1867',NULL,'Section Code',NULL,NULL,'"~NST~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('112','EGOOLTDVOLZ0','8','D','10','1872',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate1"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('113','EGOOLTDVOLZ0','8','D','10','1880',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate1"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('114','EGOOLTDVOLZ0','9','D','10','1888',NULL,'STD Covered Salary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('115','EGOOLTDVOLZ0','5','D','10','1897',NULL,'STD Coverage Plan Option',NULL,NULL,'"drvSTDCoveragePlanOption1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('116','EGOOLTDVOLZ0','5','D','10','1902',NULL,'STD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('117','EGOOLTDVOLZ0','7','D','10','1907',NULL,'Plan Summary',NULL,NULL,'"drvPlanSummary1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('118','EGOOLTDVOLZ0','5','D','10','1914',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('119','EGOOLTDVOLZ0','3','D','10','1919',NULL,'Employee Class Code',NULL,NULL,'"drvEmplClassCode1"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('120','EGOOLTDVOLZ0','5','D','10','1922',NULL,'Section Code',NULL,NULL,'"~NSB~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('121','EGOOLTDVOLZ0','8','D','10','1927',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('122','EGOOLTDVOLZ0','8','D','10','1935',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('123','EGOOLTDVOLZ0','9','D','10','1943',NULL,'STD Covered Salary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('124','EGOOLTDVOLZ0','5','D','10','1952',NULL,'STD Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('125','EGOOLTDVOLZ0','5','D','10','1957',NULL,'STD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('126','EGOOLTDVOLZ0','7','D','10','1962',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('127','EGOOLTDVOLZ0','5','D','10','1969',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('128','EGOOLTDVOLZ0','3','D','10','1974',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('129','EGOOLTDVOLZ0','5','D','10','1977',NULL,'Section Code',NULL,NULL,'"~STA~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('130','EGOOLTDVOLZ0','8','D','10','1982',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('131','EGOOLTDVOLZ0','8','D','10','1990',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('132','EGOOLTDVOLZ0','5','D','10','1998',NULL,'Statutory Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('133','EGOOLTDVOLZ0','5','D','10','2003',NULL,'Statutory Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('134','EGOOLTDVOLZ0','7','D','10','2008',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('135','EGOOLTDVOLZ0','5','D','10','2015',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('136','EGOOLTDVOLZ0','3','D','10','2020',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('137','EGOOLTDVOLZ0','5','D','10','2023',NULL,'Section Code',NULL,NULL,'"~PFL~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('138','EGOOLTDVOLZ0','2','D','10','2028',NULL,'State PFL Enrolled',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('139','EGOOLTDVOLZ0','8','D','10','2030',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('140','EGOOLTDVOLZ0','8','D','10','2038',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('141','EGOOLTDVOLZ0','7','D','10','2046',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('142','EGOOLTDVOLZ0','5','D','10','2053',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('143','EGOOLTDVOLZ0','3','D','10','2058',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('144','EGOOLTDVOLZ0','5','D','10','2061',NULL,'Section Code',NULL,NULL,'"~FLX~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('145','EGOOLTDVOLZ0','8','D','10','2066',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('146','EGOOLTDVOLZ0','8','D','10','2074',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('147','EGOOLTDVOLZ0','3','D','10','2082',NULL,'DisabilityFLEX Benefit Commencement Period - Day I',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('148','EGOOLTDVOLZ0','3','D','10','2085',NULL,'DisabilityFLEX Benefit Commencement Period - Day S',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('149','EGOOLTDVOLZ0','3','D','10','2088',NULL,'DisabilityFLEX Benefit Duration',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('150','EGOOLTDVOLZ0','6','D','10','2091',NULL,'DisabilityFLEX Benefit Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('151','EGOOLTDVOLZ0','7','D','10','2097',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('152','EGOOLTDVOLZ0','5','D','10','2104',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('153','EGOOLTDVOLZ0','3','D','10','2109',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('154','EGOOLTDVOLZ0','5','D','10','2112',NULL,'Section Code',NULL,NULL,'"~LTD~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('155','EGOOLTDVOLZ0','8','D','10','2117',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate2"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('156','EGOOLTDVOLZ0','8','D','10','2125',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate2"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('157','EGOOLTDVOLZ0','10','D','10','2133',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('158','EGOOLTDVOLZ0','35','D','10','2143',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('159','EGOOLTDVOLZ0','9','D','10','2178',NULL,'LTD Covered Salary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('160','EGOOLTDVOLZ0','5','D','10','2187',NULL,'LTD Coverage Plan Option',NULL,NULL,'"drv60"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('161','EGOOLTDVOLZ0','5','D','10','2192',NULL,'LTD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('162','EGOOLTDVOLZ0','7','D','10','2197',NULL,'Plan Summary',NULL,NULL,'"drvPlanSummary2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('163','EGOOLTDVOLZ0','5','D','10','2204',NULL,'Employee Group ID',NULL,NULL,'"drvEmployeeGroupID2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('164','EGOOLTDVOLZ0','3','D','10','2209',NULL,'Employee Class Code',NULL,NULL,'"drvEmployeeClassCode2"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('165','EGOOLTDVOLZ0','5','D','10','2212',NULL,'Section Code',NULL,NULL,'"~LDB~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('166','EGOOLTDVOLZ0','8','D','10','2217',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('167','EGOOLTDVOLZ0','8','D','10','2225',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('168','EGOOLTDVOLZ0','10','D','10','2233',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('169','EGOOLTDVOLZ0','35','D','10','2243',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('170','EGOOLTDVOLZ0','9','D','10','2278',NULL,'LTD Covered Salary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('171','EGOOLTDVOLZ0','5','D','10','2287',NULL,'LTD Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('172','EGOOLTDVOLZ0','5','D','10','2292',NULL,'LTD Requested Coverage Plan Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('173','EGOOLTDVOLZ0','7','D','10','2297',NULL,'Plan Summary',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('174','EGOOLTDVOLZ0','5','D','10','2304',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('175','EGOOLTDVOLZ0','3','D','10','2309',NULL,'Employee Class Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('176','EGOOLTDVOLZ0','5','D','10','2312',NULL,'Section Code',NULL,NULL,'"~RPL~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('177','EGOOLTDVOLZ0','20','D','10','2317',NULL,'Reporting Level 1',NULL,NULL,'"GoodWillESM"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('178','EGOOLTDVOLZ0','20','D','10','2337',NULL,'Reporting Level 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('179','EGOOLTDVOLZ0','20','D','10','2357',NULL,'Reporting Level 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('180','EGOOLTDVOLZ0','20','D','10','2377',NULL,'Reporting Level 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('181','EGOOLTDVOLZ0','20','D','10','2397',NULL,'Reporting Level 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('182','EGOOLTDVOLZ0','20','D','10','2417',NULL,'Reporting Level 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('183','EGOOLTDVOLZ0','20','D','10','2437',NULL,'Reporting Level 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('184','EGOOLTDVOLZ0','20','D','10','2457',NULL,'Reporting Level 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('185','EGOOLTDVOLZ0','20','D','10','2477',NULL,'Reporting Level 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('186','EGOOLTDVOLZ0','20','D','10','2497',NULL,'Reporting Level 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('187','EGOOLTDVOLZ0','20','D','10','2517',NULL,'Reporting Level 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('188','EGOOLTDVOLZ0','20','D','10','2537',NULL,'Reporting Level 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('189','EGOOLTDVOLZ0','5','D','10','2557',NULL,'Section Code',NULL,NULL,'"~BLF~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('190','EGOOLTDVOLZ0','8','D','10','2562',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate3"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('191','EGOOLTDVOLZ0','8','D','10','2570',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate3"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('192','EGOOLTDVOLZ0','10','D','10','2578',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('193','EGOOLTDVOLZ0','35','D','10','2588',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('194','EGOOLTDVOLZ0','3','D','10','2623',NULL,'Basic Life Multiple of Salary Face Amount',NULL,NULL,'"drvBasicLifeMulSalFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('195','EGOOLTDVOLZ0','11','D','10','2626',NULL,'Basic Life Face Amount',NULL,NULL,'"drvBasicLifeFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('196','EGOOLTDVOLZ0','3','D','10','2637',NULL,'Basic Life Multiple of Salary Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('197','EGOOLTDVOLZ0','11','D','10','2640',NULL,'Basic Life Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('198','EGOOLTDVOLZ0','5','D','10','2651',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID3','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('199','EGOOLTDVOLZ0','3','D','10','2656',NULL,'Employee Class Code',NULL,NULL,'"drvEmplClassCode3"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('200','EGOOLTDVOLZ0','5','D','10','2659',NULL,'Section Code',NULL,NULL,'"~BAD~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('201','EGOOLTDVOLZ0','8','D','10','2664',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate4"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('202','EGOOLTDVOLZ0','8','D','10','2672',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate4"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('203','EGOOLTDVOLZ0','10','D','10','2680',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('204','EGOOLTDVOLZ0','35','D','10','2690',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('205','EGOOLTDVOLZ0','11','D','10','2725',NULL,'Basic AD&D Face Amount',NULL,NULL,'"drvBasicADDFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('206','EGOOLTDVOLZ0','11','D','10','2736',NULL,'Basic AD&D Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('207','EGOOLTDVOLZ0','5','D','10','2747',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('208','EGOOLTDVOLZ0','3','D','10','2752',NULL,'Employee Class Code',NULL,NULL,'"drvEmplClassCode4"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('209','EGOOLTDVOLZ0','5','D','10','2755',NULL,'Section Code',NULL,NULL,'"~LIF~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('210','EGOOLTDVOLZ0','8','D','10','2760',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate5"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('211','EGOOLTDVOLZ0','8','D','10','2768',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate5"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('212','EGOOLTDVOLZ0','10','D','10','2776',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('213','EGOOLTDVOLZ0','35','D','10','2786',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('214','EGOOLTDVOLZ0','3','D','10','2821',NULL,'Supplemental Life Multiple of Salary Face Amount',NULL,NULL,'"drvSupLifeMultiSalFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('215','EGOOLTDVOLZ0','11','D','10','2824',NULL,'Supplemental Life Face Amount',NULL,NULL,'"drvSupLifeFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('216','EGOOLTDVOLZ0','3','D','10','2835',NULL,'Supplemental Life  Multiple of Salary Requested Am',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('217','EGOOLTDVOLZ0','11','D','10','2838',NULL,'Supplemental Life Requested Amount',NULL,NULL,'"drvSupLifeReqAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('218','EGOOLTDVOLZ0','5','D','10','2849',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID5"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('219','EGOOLTDVOLZ0','3','D','10','2854',NULL,'Employee Class Code',NULL,NULL,'"drvEmplClassCode5"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('220','EGOOLTDVOLZ0','5','D','10','2857',NULL,'Section Code',NULL,NULL,'"~ADD~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('221','EGOOLTDVOLZ0','8','D','10','2862',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate6"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('222','EGOOLTDVOLZ0','8','D','10','2870',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate6"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('223','EGOOLTDVOLZ0','10','D','10','2878',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('224','EGOOLTDVOLZ0','35','D','10','2888',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('225','EGOOLTDVOLZ0','3','D','10','2923',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('226','EGOOLTDVOLZ0','11','D','10','2926',NULL,'Supplemental AD&D Face Amount',NULL,NULL,'"drvSupADDFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('227','EGOOLTDVOLZ0','3','D','10','2937',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('228','EGOOLTDVOLZ0','11','D','10','2940',NULL,'Supplemental AD&D Requested Amount',NULL,NULL,'"drvSupADDReqAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('229','EGOOLTDVOLZ0','5','D','10','2951',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID6"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('230','EGOOLTDVOLZ0','3','D','10','2956',NULL,'Employee Class Code',NULL,NULL,'"drvEmplClassCode6"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('231','EGOOLTDVOLZ0','5','D','10','2959',NULL,'Section Code',NULL,NULL,'"~BSD~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('232','EGOOLTDVOLZ0','8','D','10','2964',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('233','EGOOLTDVOLZ0','8','D','10','2972',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('234','EGOOLTDVOLZ0','10','D','10','2980',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('235','EGOOLTDVOLZ0','35','D','10','2990',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('236','EGOOLTDVOLZ0','3','D','10','3025',NULL,'AD&D Multiple of Salary Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('237','EGOOLTDVOLZ0','11','D','10','3028',NULL,'AD&D Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('238','EGOOLTDVOLZ0','3','D','10','3039',NULL,'AD&D Multiple of Salary Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('239','EGOOLTDVOLZ0','11','D','10','3042',NULL,'AD&D Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('240','EGOOLTDVOLZ0','1','D','10','3053',NULL,'Coverage Tier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('241','EGOOLTDVOLZ0','5','D','10','3054',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('242','EGOOLTDVOLZ0','3','D','10','3059',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('243','EGOOLTDVOLZ0','5','D','10','3062',NULL,'Section Code',NULL,NULL,'"~SSA~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('244','EGOOLTDVOLZ0','8','D','10','3067',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('245','EGOOLTDVOLZ0','8','D','10','3075',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('246','EGOOLTDVOLZ0','10','D','10','3083',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('247','EGOOLTDVOLZ0','35','D','10','3093',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('248','EGOOLTDVOLZ0','3','D','10','3128',NULL,'Supplemental AD&D Multiple of Salary Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('249','EGOOLTDVOLZ0','11','D','10','3131',NULL,'Supplemental AD&D Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('250','EGOOLTDVOLZ0','3','D','10','3142',NULL,'Supplemental AD&D Multiple of Salary Requested Amo',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('251','EGOOLTDVOLZ0','11','D','10','3145',NULL,'Supplemental AD&D Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('252','EGOOLTDVOLZ0','1','D','10','3156',NULL,'Coverage Tier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('253','EGOOLTDVOLZ0','5','D','10','3157',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('254','EGOOLTDVOLZ0','3','D','10','3162',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('255','EGOOLTDVOLZ0','5','D','10','3165',NULL,'Section Code',NULL,NULL,'"~BSL~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('256','EGOOLTDVOLZ0','8','D','10','3170',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('257','EGOOLTDVOLZ0','8','D','10','3178',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('258','EGOOLTDVOLZ0','10','D','10','3186',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('259','EGOOLTDVOLZ0','35','D','10','3196',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('260','EGOOLTDVOLZ0','11','D','10','3231',NULL,'Spouse Basic Life Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('261','EGOOLTDVOLZ0','11','D','10','3242',NULL,'Spouse Basic Life Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('262','EGOOLTDVOLZ0','5','D','10','3253',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('263','EGOOLTDVOLZ0','3','D','10','3258',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('264','EGOOLTDVOLZ0','5','D','10','3261',NULL,'Section Code',NULL,NULL,'"~SPL~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('265','EGOOLTDVOLZ0','8','D','10','3266',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate7"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('266','EGOOLTDVOLZ0','8','D','10','3274',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate7"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('267','EGOOLTDVOLZ0','10','D','10','3282',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('268','EGOOLTDVOLZ0','35','D','10','3292',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('269','EGOOLTDVOLZ0','11','D','10','3327',NULL,'Spouse Supplemental Life Face Amount',NULL,NULL,'"drvSpouseSupLifeFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('270','EGOOLTDVOLZ0','11','D','10','3338',NULL,'Spouse Supplemental Life Requested Amount',NULL,NULL,'"drvSpouseSupLifeReqAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('271','EGOOLTDVOLZ0','5','D','10','3349',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID7"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('272','EGOOLTDVOLZ0','3','D','10','3354',NULL,'Employee Class',NULL,NULL,'"drvEmplClass7"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('273','EGOOLTDVOLZ0','5','D','10','3357',NULL,'Section Code',NULL,NULL,'"~BDL~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('274','EGOOLTDVOLZ0','8','D','10','3362',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('275','EGOOLTDVOLZ0','8','D','10','3370',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('276','EGOOLTDVOLZ0','10','D','10','3378',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('277','EGOOLTDVOLZ0','35','D','10','3388',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('278','EGOOLTDVOLZ0','11','D','10','3423',NULL,'Dependent/Child Basic Life Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('279','EGOOLTDVOLZ0','11','D','10','3434',NULL,'Dependent/Child Basic Life Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('280','EGOOLTDVOLZ0','5','D','10','3445',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('281','EGOOLTDVOLZ0','3','D','10','3450',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('282','EGOOLTDVOLZ0','5','D','10','3453',NULL,'Section Code',NULL,NULL,'"~DPL~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('283','EGOOLTDVOLZ0','8','D','10','3458',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate8"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('284','EGOOLTDVOLZ0','8','D','10','3466',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate8"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('285','EGOOLTDVOLZ0','10','D','10','3474',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('286','EGOOLTDVOLZ0','35','D','10','3484',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('287','EGOOLTDVOLZ0','11','D','10','3519',NULL,'Dependent/Child Basic Life Face Amount',NULL,NULL,'"drvDepChildBasicLifeFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('288','EGOOLTDVOLZ0','11','D','10','3530',NULL,'Dependent/Child Basic Life Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('289','EGOOLTDVOLZ0','5','D','10','3541',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID8"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('290','EGOOLTDVOLZ0','3','D','10','3546',NULL,'Employee Class',NULL,NULL,'"drvEmplClass8"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('291','EGOOLTDVOLZ0','5','D','10','3549',NULL,'Section Code',NULL,NULL,'"~BSA~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('292','EGOOLTDVOLZ0','8','D','10','3554',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('293','EGOOLTDVOLZ0','8','D','10','3562',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('294','EGOOLTDVOLZ0','10','D','10','3570',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('295','EGOOLTDVOLZ0','35','D','10','3580',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('296','EGOOLTDVOLZ0','11','D','10','3615',NULL,'Dependent/Child Supplemental Life Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('297','EGOOLTDVOLZ0','11','D','10','3626',NULL,'Dependent/Child Supplemental Life Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('298','EGOOLTDVOLZ0','5','D','10','3637',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('299','EGOOLTDVOLZ0','3','D','10','3642',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('300','EGOOLTDVOLZ0','5','D','10','3645',NULL,'Section Code',NULL,NULL,'"~SAD~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('301','EGOOLTDVOLZ0','8','D','10','3650',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate9"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('302','EGOOLTDVOLZ0','8','D','10','3658',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate9"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('303','EGOOLTDVOLZ0','10','D','10','3666',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('304','EGOOLTDVOLZ0','35','D','10','3676',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('305','EGOOLTDVOLZ0','11','D','10','3711',NULL,'Spouse Basic AD&D Face Amount',NULL,NULL,'"drvSpouseSupADDFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('306','EGOOLTDVOLZ0','11','D','10','3722',NULL,'Spouse Basic AD&D Requested Amount',NULL,NULL,'"drvSpouseSupADDReqAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('307','EGOOLTDVOLZ0','5','D','10','3733',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID9"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('308','EGOOLTDVOLZ0','3','D','10','3738',NULL,'Employee Class',NULL,NULL,'"drvEmplClass9"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('309','EGOOLTDVOLZ0','5','D','10','3741',NULL,'Section Code',NULL,NULL,'"~BDA~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('310','EGOOLTDVOLZ0','8','D','10','3746',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('311','EGOOLTDVOLZ0','8','D','10','3754',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('312','EGOOLTDVOLZ0','10','D','10','3762',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('313','EGOOLTDVOLZ0','35','D','10','3772',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('314','EGOOLTDVOLZ0','11','D','10','3807',NULL,'Spouse Supplemental AD&D Face Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('315','EGOOLTDVOLZ0','11','D','10','3818',NULL,'Spouse Supplemental AD&D Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('316','EGOOLTDVOLZ0','5','D','10','3829',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('317','EGOOLTDVOLZ0','3','D','10','3834',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('318','EGOOLTDVOLZ0','5','D','10','3837',NULL,'Section Code',NULL,NULL,'"~DCA~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('319','EGOOLTDVOLZ0','8','D','10','3842',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate10"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('320','EGOOLTDVOLZ0','8','D','10','3850',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate10"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('321','EGOOLTDVOLZ0','10','D','10','3858',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('322','EGOOLTDVOLZ0','35','D','10','3868',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('323','EGOOLTDVOLZ0','11','D','10','3903',NULL,'Dependent/Child Basic AD&D Face Amount',NULL,NULL,'"drvDepChildBasicADDFaceAmt"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('324','EGOOLTDVOLZ0','11','D','10','3914',NULL,'Dependent/Child Basic AD&D Requested Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('325','EGOOLTDVOLZ0','5','D','10','3925',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID10"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('326','EGOOLTDVOLZ0','3','D','10','3930',NULL,'Employee Class',NULL,NULL,'"drvEmplClass10"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('327','EGOOLTDVOLZ0','5','D','10','3933',NULL,'Section Code',NULL,NULL,'"~VCI~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('328','EGOOLTDVOLZ0','8','D','10','3938',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate11"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('329','EGOOLTDVOLZ0','8','D','10','3946',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate11"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('330','EGOOLTDVOLZ0','10','D','10','3954',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('331','EGOOLTDVOLZ0','35','D','10','3964',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('332','EGOOLTDVOLZ0','11','D','10','3999',NULL,'CI Benefit Amount',NULL,NULL,'"drvCIBenefitAmount"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('333','EGOOLTDVOLZ0','1','D','10','4010',NULL,'Coverage Tier',NULL,NULL,'"drvCoverageTier11"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('334','EGOOLTDVOLZ0','3','D','10','4011',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber11"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('335','EGOOLTDVOLZ0','5','D','10','4014',NULL,'Employee Group ID',NULL,NULL,'"drvEmpGroupID11"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('336','EGOOLTDVOLZ0','3','D','10','4019',NULL,'Employee Class',NULL,NULL,'"drvEmpClass11"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('337','EGOOLTDVOLZ0','5','D','10','4022',NULL,'Section Code',NULL,NULL,'"~CIB~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('338','EGOOLTDVOLZ0','8','D','10','4027',NULL,'Coverage Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('339','EGOOLTDVOLZ0','8','D','10','4035',NULL,'Coverage Termination Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('340','EGOOLTDVOLZ0','10','D','10','4043',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('341','EGOOLTDVOLZ0','35','D','10','4053',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('342','EGOOLTDVOLZ0','11','D','10','4088',NULL,'CI Buy-up Benefit Amount',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('343','EGOOLTDVOLZ0','1','D','10','4099',NULL,'Buy-Up Coverage Tier',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('344','EGOOLTDVOLZ0','3','D','10','4100',NULL,'Plan Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('345','EGOOLTDVOLZ0','5','D','10','4103',NULL,'Employee Group ID',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('346','EGOOLTDVOLZ0','3','D','10','4108',NULL,'Employee Class',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('347','EGOOLTDVOLZ0','5','D','10','4111',NULL,'Section Code',NULL,NULL,'"~VAC~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('348','EGOOLTDVOLZ0','8','D','10','4116',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffectiveDate12"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('349','EGOOLTDVOLZ0','8','D','10','4124',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate12"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('350','EGOOLTDVOLZ0','10','D','10','4132',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('351','EGOOLTDVOLZ0','35','D','10','4142',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('352','EGOOLTDVOLZ0','1','D','10','4177',NULL,'Coverage Tier',NULL,NULL,'"drvCoverageTier12"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('353','EGOOLTDVOLZ0','50','D','10','4178',NULL,'Plan Option',NULL,NULL,'"drvPlanOption12"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('354','EGOOLTDVOLZ0','3','D','10','4228',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber12"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('355','EGOOLTDVOLZ0','5','D','10','4231',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID12"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('356','EGOOLTDVOLZ0','3','D','10','4236',NULL,'Employee Class',NULL,NULL,'"drvEmplClass12"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('357','EGOOLTDVOLZ0','5','D','10','4239',NULL,'Section Code',NULL,NULL,'"~HIP~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('358','EGOOLTDVOLZ0','8','D','10','4244',NULL,'Coverage Effective Date',NULL,NULL,'"drvCovEffDate13"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('359','EGOOLTDVOLZ0','8','D','10','4252',NULL,'Coverage Termination Date',NULL,NULL,'"drvCovTermDate13"','(''UD112''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('360','EGOOLTDVOLZ0','10','D','10','4260',NULL,'Coverage Termination Reason Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('361','EGOOLTDVOLZ0','35','D','10','4270',NULL,'Coverage Termination Description',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('362','EGOOLTDVOLZ0','1','D','10','4305',NULL,'Coverage Tier',NULL,NULL,'"drvCoverageTier13"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('363','EGOOLTDVOLZ0','50','D','10','4306',NULL,'Plan Option',NULL,NULL,'"drvPlanOption13"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('364','EGOOLTDVOLZ0','3','D','10','4356',NULL,'Plan Number',NULL,NULL,'"drvPlanNumber13"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('365','EGOOLTDVOLZ0','5','D','10','4359',NULL,'Employee Group ID',NULL,NULL,'"drvEmplGroupID13"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('366','EGOOLTDVOLZ0','3','D','10','4364',NULL,'Employee Class',NULL,NULL,'"drvEmplClass13"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('367','EGOOLTDVOLZ0','5','D','10','4367',NULL,'Section Code',NULL,NULL,'"~LMS~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('368','EGOOLTDVOLZ0','1','D','10','4372',NULL,'Leave Management Services Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('369','EGOOLTDVOLZ0','1','D','10','4373',NULL,'Employee Covered by FML 50/75 Rule',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('370','EGOOLTDVOLZ0','1','D','10','4374',NULL,'Key Employee Indicator',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('371','EGOOLTDVOLZ0','1','D','10','4375',NULL,'Forced Eligibility',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('372','EGOOLTDVOLZ0','5','D','10','4376',NULL,'Leave Management Option',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('373','EGOOLTDVOLZ0','6','D','10','4381',NULL,'Last 12 Months Hours',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('374','EGOOLTDVOLZ0','6','D','10','4387',NULL,'Last 12 Months Paid Hours',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('375','EGOOLTDVOLZ0','7','D','10','4393',NULL,'Actual Hours Worked',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('376','EGOOLTDVOLZ0','4','D','10','4400',NULL,'Usage Time',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('377','EGOOLTDVOLZ0','4','D','10','4404',NULL,'Regulation Period Basis',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('378','EGOOLTDVOLZ0','8','D','10','4408',NULL,'Cumulative Hours End Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('379','EGOOLTDVOLZ0','2','D','10','4416',NULL,'Cumulative Hours Number of Weeks',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('380','EGOOLTDVOLZ0','4','D','10','4418',NULL,'Sick Leave Hours Remaining',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('381','EGOOLTDVOLZ0','4','D','10','4422',NULL,'Vacation Hours Remaining',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('382','EGOOLTDVOLZ0','3','D','10','4426',NULL,'Work Schedule Type',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('383','EGOOLTDVOLZ0','8','D','10','4429',NULL,'Work Schedule From Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('384','EGOOLTDVOLZ0','4','D','10','4437',NULL,'Work schedule -  Hours Monday',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('385','EGOOLTDVOLZ0','4','D','10','4441',NULL,'Work Schedule - Hours Tuesday',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('386','EGOOLTDVOLZ0','4','D','10','4445',NULL,'Work Schedule -  Hours Wednesday',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('387','EGOOLTDVOLZ0','4','D','10','4449',NULL,'Work Schedule -  Hours Thursday',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('388','EGOOLTDVOLZ0','4','D','10','4453',NULL,'Work Schedule - Hours Friday',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('389','EGOOLTDVOLZ0','4','D','10','4457',NULL,'Work Schedule -  Hours Saturday',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('390','EGOOLTDVOLZ0','4','D','10','4461',NULL,'Work Schedule -  Hours Sunday',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('391','EGOOLTDVOLZ0','4','D','10','4465',NULL,'Number of Days in Repeating Work Schedule',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('392','EGOOLTDVOLZ0','4','D','10','4469',NULL,'Repeating Schedule - Day 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('393','EGOOLTDVOLZ0','4','D','10','4473',NULL,'Repeating Schedule - Day 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('394','EGOOLTDVOLZ0','4','D','10','4477',NULL,'Repeating Schedule - Day 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('395','EGOOLTDVOLZ0','4','D','10','4481',NULL,'Repeating Schedule - Day 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('396','EGOOLTDVOLZ0','4','D','10','4485',NULL,'Repeating Schedule - Day 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('397','EGOOLTDVOLZ0','4','D','10','4489',NULL,'Repeating Schedule - Day 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('398','EGOOLTDVOLZ0','4','D','10','4493',NULL,'Repeating Schedule - Day 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('399','EGOOLTDVOLZ0','4','D','10','4497',NULL,'Repeating Schedule - Day 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('400','EGOOLTDVOLZ0','4','D','10','4501',NULL,'Repeating Schedule - Day 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('401','EGOOLTDVOLZ0','4','D','10','4505',NULL,'Repeating Schedule - Day 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('402','EGOOLTDVOLZ0','4','D','10','4509',NULL,'Repeating Schedule - Day 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('403','EGOOLTDVOLZ0','4','D','10','4513',NULL,'Repeating Schedule - Day 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('404','EGOOLTDVOLZ0','4','D','10','4517',NULL,'Repeating Schedule - Day 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('405','EGOOLTDVOLZ0','4','D','10','4521',NULL,'Repeating Schedule - Day 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('406','EGOOLTDVOLZ0','4','D','10','4525',NULL,'Repeating Schedule - Day 15',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('407','EGOOLTDVOLZ0','4','D','10','4529',NULL,'Repeating Schedule - Day 16',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('408','EGOOLTDVOLZ0','4','D','10','4533',NULL,'Repeating Schedule - Day 17',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('409','EGOOLTDVOLZ0','4','D','10','4537',NULL,'Repeating Schedule - Day 18',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('410','EGOOLTDVOLZ0','4','D','10','4541',NULL,'Repeating Schedule - Day 19',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('411','EGOOLTDVOLZ0','4','D','10','4545',NULL,'Repeating Schedule - Day 20',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('412','EGOOLTDVOLZ0','4','D','10','4549',NULL,'Repeating Schedule - Day 21',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('413','EGOOLTDVOLZ0','4','D','10','4553',NULL,'Repeating Schedule - Day 22',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('414','EGOOLTDVOLZ0','4','D','10','4557',NULL,'Repeating Schedule - Day 23',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('415','EGOOLTDVOLZ0','4','D','10','4561',NULL,'Repeating Schedule - Day 24',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('416','EGOOLTDVOLZ0','4','D','10','4565',NULL,'Repeating Schedule - Day 25',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('417','EGOOLTDVOLZ0','4','D','10','4569',NULL,'Repeating Schedule - Day 26',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('418','EGOOLTDVOLZ0','4','D','10','4573',NULL,'Repeating Schedule - Day 27',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('419','EGOOLTDVOLZ0','4','D','10','4577',NULL,'Repeating Schedule - Day 28',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('420','EGOOLTDVOLZ0','4','D','10','4581',NULL,'Repeating Schedule - Day 29',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('421','EGOOLTDVOLZ0','4','D','10','4585',NULL,'Repeating Schedule - Day 30',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('422','EGOOLTDVOLZ0','4','D','10','4589',NULL,'Repeating Schedule - Day 31',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('423','EGOOLTDVOLZ0','4','D','10','4593',NULL,'Repeating Schedule - Day 32',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('424','EGOOLTDVOLZ0','4','D','10','4597',NULL,'Repeating Schedule - Day 33',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('425','EGOOLTDVOLZ0','4','D','10','4601',NULL,'Repeating Schedule - Day 34',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('426','EGOOLTDVOLZ0','4','D','10','4605',NULL,'Repeating Schedule - Day 35',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('427','EGOOLTDVOLZ0','4','D','10','4609',NULL,'Repeating Schedule - Day 36',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('428','EGOOLTDVOLZ0','4','D','10','4613',NULL,'Repeating Schedule - Day 37',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('429','EGOOLTDVOLZ0','4','D','10','4617',NULL,'Repeating Schedule - Day 38',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('430','EGOOLTDVOLZ0','4','D','10','4621',NULL,'Repeating Schedule - Day 39',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('431','EGOOLTDVOLZ0','4','D','10','4625',NULL,'Repeating Schedule - Day 40',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('432','EGOOLTDVOLZ0','4','D','10','4629',NULL,'Repeating Schedule - Day 41',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('433','EGOOLTDVOLZ0','4','D','10','4633',NULL,'Repeating Schedule - Day 42',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('434','EGOOLTDVOLZ0','4','D','10','4637',NULL,'Repeating Schedule - Day 43',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('435','EGOOLTDVOLZ0','4','D','10','4641',NULL,'Repeating Schedule - Day 44',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('436','EGOOLTDVOLZ0','4','D','10','4645',NULL,'Repeating Schedule - Day 45',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('437','EGOOLTDVOLZ0','4','D','10','4649',NULL,'Repeating Schedule - Day 46',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('438','EGOOLTDVOLZ0','4','D','10','4653',NULL,'Repeating Schedule - Day 47',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('439','EGOOLTDVOLZ0','4','D','10','4657',NULL,'Repeating Schedule - Day 48',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('440','EGOOLTDVOLZ0','4','D','10','4661',NULL,'Repeating Schedule - Day 49',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('441','EGOOLTDVOLZ0','4','D','10','4665',NULL,'Repeating Schedule - Day 50',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('442','EGOOLTDVOLZ0','4','D','10','4669',NULL,'Repeating Schedule - Day 51',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('443','EGOOLTDVOLZ0','4','D','10','4673',NULL,'Repeating Schedule - Day 52',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('444','EGOOLTDVOLZ0','4','D','10','4677',NULL,'Repeating Schedule - Day 53',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('445','EGOOLTDVOLZ0','4','D','10','4681',NULL,'Repeating Schedule - Day 54',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('446','EGOOLTDVOLZ0','4','D','10','4685',NULL,'Repeating Schedule - Day 55',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('447','EGOOLTDVOLZ0','4','D','10','4689',NULL,'Repeating Schedule - Day 56',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('448','EGOOLTDVOLZ0','4','D','10','4693',NULL,'Repeating Schedule - Day 57',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('449','EGOOLTDVOLZ0','4','D','10','4697',NULL,'Repeating Schedule - Day 58',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('450','EGOOLTDVOLZ0','4','D','10','4701',NULL,'Repeating Schedule - Day 59',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('451','EGOOLTDVOLZ0','4','D','10','4705',NULL,'Repeating Schedule - Day 60',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('452','EGOOLTDVOLZ0','2','D','10','4709',NULL,'Flight Crew',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('453','EGOOLTDVOLZ0','1','D','10','4711',NULL,'FMLA Radius',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('454','EGOOLTDVOLZ0','5','D','10','4712',NULL,'Section Code',NULL,NULL,'"~ROL~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('455','EGOOLTDVOLZ0','50','D','10','4717',NULL,'Reporting Level 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('456','EGOOLTDVOLZ0','50','D','10','4767',NULL,'Reporting Level 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('457','EGOOLTDVOLZ0','50','D','10','4817',NULL,'Reporting Level 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('458','EGOOLTDVOLZ0','50','D','10','4867',NULL,'Reporting Level 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('459','EGOOLTDVOLZ0','50','D','10','4917',NULL,'Reporting Level 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('460','EGOOLTDVOLZ0','50','D','10','4967',NULL,'Reporting Level 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('461','EGOOLTDVOLZ0','50','D','10','5017',NULL,'Reporting Level 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('462','EGOOLTDVOLZ0','50','D','10','5067',NULL,'Reporting Level 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('463','EGOOLTDVOLZ0','50','D','10','5117',NULL,'Reporting Level 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('464','EGOOLTDVOLZ0','50','D','10','5167',NULL,'Reporting Level 10',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('465','EGOOLTDVOLZ0','50','D','10','5217',NULL,'Reporting Level 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('466','EGOOLTDVOLZ0','50','D','10','5267',NULL,'Reporting Level 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('467','EGOOLTDVOLZ0','5','D','10','5317',NULL,'Section Code',NULL,NULL,'"~BEN~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('468','EGOOLTDVOLZ0','30','D','10','5322',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('469','EGOOLTDVOLZ0','30','D','10','5352',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('470','EGOOLTDVOLZ0','9','D','10','5382',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('471','EGOOLTDVOLZ0','60','D','10','5391',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('472','EGOOLTDVOLZ0','9','D','10','5451',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('473','EGOOLTDVOLZ0','8','D','10','5460',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('474','EGOOLTDVOLZ0','40','D','10','5468',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('475','EGOOLTDVOLZ0','40','D','10','5508',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('476','EGOOLTDVOLZ0','30','D','10','5548',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('477','EGOOLTDVOLZ0','2','D','10','5578',NULL,'Beneficiary State',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('478','EGOOLTDVOLZ0','10','D','10','5580',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('479','EGOOLTDVOLZ0','2','D','10','5590',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('480','EGOOLTDVOLZ0','3','D','10','5592',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('481','EGOOLTDVOLZ0','3','D','10','5595',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('482','EGOOLTDVOLZ0','1','D','10','5598',NULL,'Beneficiary Type Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('483','EGOOLTDVOLZ0','8','D','10','5599',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('484','EGOOLTDVOLZ0','30','D','10','5607',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('485','EGOOLTDVOLZ0','30','D','10','5637',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('486','EGOOLTDVOLZ0','9','D','10','5667',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('487','EGOOLTDVOLZ0','60','D','10','5676',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('488','EGOOLTDVOLZ0','9','D','10','5736',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('489','EGOOLTDVOLZ0','8','D','10','5745',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('490','EGOOLTDVOLZ0','40','D','10','5753',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('491','EGOOLTDVOLZ0','40','D','10','5793',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('492','EGOOLTDVOLZ0','30','D','10','5833',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('493','EGOOLTDVOLZ0','2','D','10','5863',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('494','EGOOLTDVOLZ0','10','D','10','5865',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('495','EGOOLTDVOLZ0','2','D','10','5875',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('496','EGOOLTDVOLZ0','3','D','10','5877',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('497','EGOOLTDVOLZ0','3','D','10','5880',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('498','EGOOLTDVOLZ0','1','D','10','5883',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('499','EGOOLTDVOLZ0','8','D','10','5884',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('500','EGOOLTDVOLZ0','30','D','10','5892',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('501','EGOOLTDVOLZ0','30','D','10','5922',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('502','EGOOLTDVOLZ0','9','D','10','5952',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('503','EGOOLTDVOLZ0','60','D','10','5961',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('504','EGOOLTDVOLZ0','9','D','10','6021',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('505','EGOOLTDVOLZ0','8','D','10','6030',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('506','EGOOLTDVOLZ0','40','D','10','6038',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('507','EGOOLTDVOLZ0','40','D','10','6078',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('508','EGOOLTDVOLZ0','30','D','10','6118',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('509','EGOOLTDVOLZ0','2','D','10','6148',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('510','EGOOLTDVOLZ0','10','D','10','6150',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('511','EGOOLTDVOLZ0','2','D','10','6160',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('512','EGOOLTDVOLZ0','3','D','10','6162',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('513','EGOOLTDVOLZ0','3','D','10','6165',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('514','EGOOLTDVOLZ0','1','D','10','6168',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('515','EGOOLTDVOLZ0','8','D','10','6169',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('516','EGOOLTDVOLZ0','30','D','10','6177',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('517','EGOOLTDVOLZ0','30','D','10','6207',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('518','EGOOLTDVOLZ0','9','D','10','6237',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('519','EGOOLTDVOLZ0','60','D','10','6246',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('520','EGOOLTDVOLZ0','9','D','10','6306',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('521','EGOOLTDVOLZ0','8','D','10','6315',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('522','EGOOLTDVOLZ0','40','D','10','6323',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('523','EGOOLTDVOLZ0','40','D','10','6363',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('524','EGOOLTDVOLZ0','30','D','10','6403',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('525','EGOOLTDVOLZ0','2','D','10','6433',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('526','EGOOLTDVOLZ0','10','D','10','6435',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('527','EGOOLTDVOLZ0','2','D','10','6445',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('528','EGOOLTDVOLZ0','3','D','10','6447',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('529','EGOOLTDVOLZ0','3','D','10','6450',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('530','EGOOLTDVOLZ0','1','D','10','6453',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('531','EGOOLTDVOLZ0','8','D','10','6454',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('532','EGOOLTDVOLZ0','30','D','10','6462',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('533','EGOOLTDVOLZ0','30','D','10','6492',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('534','EGOOLTDVOLZ0','9','D','10','6522',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('535','EGOOLTDVOLZ0','60','D','10','6531',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('536','EGOOLTDVOLZ0','9','D','10','6591',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('537','EGOOLTDVOLZ0','8','D','10','6600',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('538','EGOOLTDVOLZ0','40','D','10','6608',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('539','EGOOLTDVOLZ0','40','D','10','6648',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('540','EGOOLTDVOLZ0','30','D','10','6688',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('541','EGOOLTDVOLZ0','2','D','10','6718',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('542','EGOOLTDVOLZ0','10','D','10','6720',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('543','EGOOLTDVOLZ0','2','D','10','6730',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('544','EGOOLTDVOLZ0','3','D','10','6732',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('545','EGOOLTDVOLZ0','3','D','10','6735',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('546','EGOOLTDVOLZ0','1','D','10','6738',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('547','EGOOLTDVOLZ0','8','D','10','6739',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('548','EGOOLTDVOLZ0','30','D','10','6747',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('549','EGOOLTDVOLZ0','30','D','10','6777',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('550','EGOOLTDVOLZ0','9','D','10','6807',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('551','EGOOLTDVOLZ0','60','D','10','6816',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('552','EGOOLTDVOLZ0','9','D','10','6876',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('553','EGOOLTDVOLZ0','8','D','10','6885',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('554','EGOOLTDVOLZ0','40','D','10','6893',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('555','EGOOLTDVOLZ0','40','D','10','6933',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('556','EGOOLTDVOLZ0','30','D','10','6973',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('557','EGOOLTDVOLZ0','2','D','10','7003',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('558','EGOOLTDVOLZ0','10','D','10','7005',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('559','EGOOLTDVOLZ0','2','D','10','7015',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('560','EGOOLTDVOLZ0','3','D','10','7017',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('561','EGOOLTDVOLZ0','3','D','10','7020',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('562','EGOOLTDVOLZ0','1','D','10','7023',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('563','EGOOLTDVOLZ0','8','D','10','7024',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('564','EGOOLTDVOLZ0','30','D','10','7032',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('565','EGOOLTDVOLZ0','30','D','10','7062',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('566','EGOOLTDVOLZ0','9','D','10','7092',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('567','EGOOLTDVOLZ0','60','D','10','7101',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('568','EGOOLTDVOLZ0','9','D','10','7161',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('569','EGOOLTDVOLZ0','8','D','10','7170',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('570','EGOOLTDVOLZ0','40','D','10','7178',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('571','EGOOLTDVOLZ0','40','D','10','7218',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('572','EGOOLTDVOLZ0','30','D','10','7258',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('573','EGOOLTDVOLZ0','2','D','10','7288',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('574','EGOOLTDVOLZ0','10','D','10','7290',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('575','EGOOLTDVOLZ0','2','D','10','7300',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('576','EGOOLTDVOLZ0','3','D','10','7302',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('577','EGOOLTDVOLZ0','3','D','10','7305',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('578','EGOOLTDVOLZ0','1','D','10','7308',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('579','EGOOLTDVOLZ0','8','D','10','7309',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('580','EGOOLTDVOLZ0','30','D','10','7317',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('581','EGOOLTDVOLZ0','30','D','10','7347',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('582','EGOOLTDVOLZ0','9','D','10','7377',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('583','EGOOLTDVOLZ0','60','D','10','7386',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('584','EGOOLTDVOLZ0','9','D','10','7446',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('585','EGOOLTDVOLZ0','8','D','10','7455',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('586','EGOOLTDVOLZ0','40','D','10','7463',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('587','EGOOLTDVOLZ0','40','D','10','7503',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('588','EGOOLTDVOLZ0','30','D','10','7543',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('589','EGOOLTDVOLZ0','2','D','10','7573',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('590','EGOOLTDVOLZ0','10','D','10','7575',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('591','EGOOLTDVOLZ0','2','D','10','7585',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('592','EGOOLTDVOLZ0','3','D','10','7587',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('593','EGOOLTDVOLZ0','3','D','10','7590',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('594','EGOOLTDVOLZ0','1','D','10','7593',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('595','EGOOLTDVOLZ0','8','D','10','7594',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('596','EGOOLTDVOLZ0','30','D','10','7602',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('597','EGOOLTDVOLZ0','30','D','10','7632',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('598','EGOOLTDVOLZ0','9','D','10','7662',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('599','EGOOLTDVOLZ0','60','D','10','7671',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('600','EGOOLTDVOLZ0','9','D','10','7731',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('601','EGOOLTDVOLZ0','8','D','10','7740',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('602','EGOOLTDVOLZ0','40','D','10','7748',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('603','EGOOLTDVOLZ0','40','D','10','7788',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('604','EGOOLTDVOLZ0','30','D','10','7828',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('605','EGOOLTDVOLZ0','2','D','10','7858',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('606','EGOOLTDVOLZ0','10','D','10','7860',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('607','EGOOLTDVOLZ0','2','D','10','7870',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('608','EGOOLTDVOLZ0','3','D','10','7872',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('609','EGOOLTDVOLZ0','3','D','10','7875',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('610','EGOOLTDVOLZ0','1','D','10','7878',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('611','EGOOLTDVOLZ0','8','D','10','7879',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('612','EGOOLTDVOLZ0','30','D','10','7887',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('613','EGOOLTDVOLZ0','30','D','10','7917',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('614','EGOOLTDVOLZ0','9','D','10','7947',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('615','EGOOLTDVOLZ0','60','D','10','7956',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('616','EGOOLTDVOLZ0','9','D','10','8016',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('617','EGOOLTDVOLZ0','8','D','10','8025',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('618','EGOOLTDVOLZ0','40','D','10','8033',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('619','EGOOLTDVOLZ0','40','D','10','8073',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('620','EGOOLTDVOLZ0','30','D','10','8113',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('621','EGOOLTDVOLZ0','2','D','10','8143',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('622','EGOOLTDVOLZ0','10','D','10','8145',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('623','EGOOLTDVOLZ0','2','D','10','8155',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('624','EGOOLTDVOLZ0','3','D','10','8157',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('625','EGOOLTDVOLZ0','3','D','10','8160',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('626','EGOOLTDVOLZ0','1','D','10','8163',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('627','EGOOLTDVOLZ0','8','D','10','8164',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('628','EGOOLTDVOLZ0','30','D','10','8172',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('629','EGOOLTDVOLZ0','30','D','10','8202',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('630','EGOOLTDVOLZ0','9','D','10','8232',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('631','EGOOLTDVOLZ0','60','D','10','8241',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('632','EGOOLTDVOLZ0','9','D','10','8301',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('633','EGOOLTDVOLZ0','8','D','10','8310',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('634','EGOOLTDVOLZ0','40','D','10','8318',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('635','EGOOLTDVOLZ0','40','D','10','8358',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('636','EGOOLTDVOLZ0','30','D','10','8398',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('637','EGOOLTDVOLZ0','2','D','10','8428',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('638','EGOOLTDVOLZ0','10','D','10','8430',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('639','EGOOLTDVOLZ0','2','D','10','8440',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('640','EGOOLTDVOLZ0','3','D','10','8442',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('641','EGOOLTDVOLZ0','3','D','10','8445',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('642','EGOOLTDVOLZ0','1','D','10','8448',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('643','EGOOLTDVOLZ0','8','D','10','8449',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('644','EGOOLTDVOLZ0','30','D','10','8457',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('645','EGOOLTDVOLZ0','30','D','10','8487',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('646','EGOOLTDVOLZ0','9','D','10','8517',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('647','EGOOLTDVOLZ0','60','D','10','8526',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('648','EGOOLTDVOLZ0','9','D','10','8586',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('649','EGOOLTDVOLZ0','8','D','10','8595',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('650','EGOOLTDVOLZ0','40','D','10','8603',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('651','EGOOLTDVOLZ0','40','D','10','8643',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('652','EGOOLTDVOLZ0','30','D','10','8683',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('653','EGOOLTDVOLZ0','2','D','10','8713',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('654','EGOOLTDVOLZ0','10','D','10','8715',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('655','EGOOLTDVOLZ0','2','D','10','8725',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('656','EGOOLTDVOLZ0','3','D','10','8727',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('657','EGOOLTDVOLZ0','3','D','10','8730',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('658','EGOOLTDVOLZ0','1','D','10','8733',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('659','EGOOLTDVOLZ0','8','D','10','8734',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('660','EGOOLTDVOLZ0','30','D','10','8742',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('661','EGOOLTDVOLZ0','30','D','10','8772',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('662','EGOOLTDVOLZ0','9','D','10','8802',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('663','EGOOLTDVOLZ0','60','D','10','8811',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('664','EGOOLTDVOLZ0','9','D','10','8871',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('665','EGOOLTDVOLZ0','8','D','10','8880',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('666','EGOOLTDVOLZ0','40','D','10','8888',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('667','EGOOLTDVOLZ0','40','D','10','8928',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('668','EGOOLTDVOLZ0','30','D','10','8968',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('669','EGOOLTDVOLZ0','2','D','10','8998',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('670','EGOOLTDVOLZ0','10','D','10','9000',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('671','EGOOLTDVOLZ0','2','D','10','9010',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('672','EGOOLTDVOLZ0','3','D','10','9012',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('673','EGOOLTDVOLZ0','3','D','10','9015',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('674','EGOOLTDVOLZ0','1','D','10','9018',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('675','EGOOLTDVOLZ0','8','D','10','9019',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('676','EGOOLTDVOLZ0','30','D','10','9027',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('677','EGOOLTDVOLZ0','30','D','10','9057',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('678','EGOOLTDVOLZ0','9','D','10','9087',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('679','EGOOLTDVOLZ0','60','D','10','9096',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('680','EGOOLTDVOLZ0','9','D','10','9156',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('681','EGOOLTDVOLZ0','8','D','10','9165',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('682','EGOOLTDVOLZ0','40','D','10','9173',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('683','EGOOLTDVOLZ0','40','D','10','9213',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('684','EGOOLTDVOLZ0','30','D','10','9253',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('685','EGOOLTDVOLZ0','2','D','10','9283',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('686','EGOOLTDVOLZ0','10','D','10','9285',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('687','EGOOLTDVOLZ0','2','D','10','9295',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('688','EGOOLTDVOLZ0','3','D','10','9297',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('689','EGOOLTDVOLZ0','3','D','10','9300',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('690','EGOOLTDVOLZ0','1','D','10','9303',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('691','EGOOLTDVOLZ0','8','D','10','9304',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('692','EGOOLTDVOLZ0','30','D','10','9312',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('693','EGOOLTDVOLZ0','30','D','10','9342',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('694','EGOOLTDVOLZ0','9','D','10','9372',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('695','EGOOLTDVOLZ0','60','D','10','9381',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('696','EGOOLTDVOLZ0','9','D','10','9441',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('697','EGOOLTDVOLZ0','8','D','10','9450',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('698','EGOOLTDVOLZ0','40','D','10','9458',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('699','EGOOLTDVOLZ0','40','D','10','9498',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('700','EGOOLTDVOLZ0','30','D','10','9538',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('701','EGOOLTDVOLZ0','2','D','10','9568',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('702','EGOOLTDVOLZ0','10','D','10','9570',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('703','EGOOLTDVOLZ0','2','D','10','9580',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('704','EGOOLTDVOLZ0','3','D','10','9582',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('705','EGOOLTDVOLZ0','3','D','10','9585',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('706','EGOOLTDVOLZ0','1','D','10','9588',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('707','EGOOLTDVOLZ0','8','D','10','9589',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('708','EGOOLTDVOLZ0','30','D','10','9597',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('709','EGOOLTDVOLZ0','30','D','10','9627',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('710','EGOOLTDVOLZ0','9','D','10','9657',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('711','EGOOLTDVOLZ0','60','D','10','9666',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('712','EGOOLTDVOLZ0','9','D','10','9726',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('713','EGOOLTDVOLZ0','8','D','10','9735',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('714','EGOOLTDVOLZ0','40','D','10','9743',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('715','EGOOLTDVOLZ0','40','D','10','9783',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('716','EGOOLTDVOLZ0','30','D','10','9823',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('717','EGOOLTDVOLZ0','2','D','10','9853',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('718','EGOOLTDVOLZ0','10','D','10','9855',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('719','EGOOLTDVOLZ0','2','D','10','9865',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('720','EGOOLTDVOLZ0','3','D','10','9867',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('721','EGOOLTDVOLZ0','3','D','10','9870',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('722','EGOOLTDVOLZ0','1','D','10','9873',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('723','EGOOLTDVOLZ0','8','D','10','9874',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('724','EGOOLTDVOLZ0','30','D','10','9882',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('725','EGOOLTDVOLZ0','30','D','10','9912',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('726','EGOOLTDVOLZ0','9','D','10','9942',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('727','EGOOLTDVOLZ0','60','D','10','9951',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('728','EGOOLTDVOLZ0','9','D','10','10011',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('729','EGOOLTDVOLZ0','8','D','10','10020',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('730','EGOOLTDVOLZ0','40','D','10','10028',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('731','EGOOLTDVOLZ0','40','D','10','10068',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('732','EGOOLTDVOLZ0','30','D','10','10108',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('733','EGOOLTDVOLZ0','2','D','10','10138',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('734','EGOOLTDVOLZ0','10','D','10','10140',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('735','EGOOLTDVOLZ0','2','D','10','10150',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('736','EGOOLTDVOLZ0','3','D','10','10152',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('737','EGOOLTDVOLZ0','3','D','10','10155',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('738','EGOOLTDVOLZ0','1','D','10','10158',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('739','EGOOLTDVOLZ0','8','D','10','10159',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('740','EGOOLTDVOLZ0','30','D','10','10167',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('741','EGOOLTDVOLZ0','30','D','10','10197',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('742','EGOOLTDVOLZ0','9','D','10','10227',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('743','EGOOLTDVOLZ0','60','D','10','10236',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('744','EGOOLTDVOLZ0','9','D','10','10296',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('745','EGOOLTDVOLZ0','8','D','10','10305',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('746','EGOOLTDVOLZ0','40','D','10','10313',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('747','EGOOLTDVOLZ0','40','D','10','10353',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('748','EGOOLTDVOLZ0','30','D','10','10393',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('749','EGOOLTDVOLZ0','2','D','10','10423',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('750','EGOOLTDVOLZ0','10','D','10','10425',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('751','EGOOLTDVOLZ0','2','D','10','10435',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('752','EGOOLTDVOLZ0','3','D','10','10437',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('753','EGOOLTDVOLZ0','3','D','10','10440',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('754','EGOOLTDVOLZ0','1','D','10','10443',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('755','EGOOLTDVOLZ0','8','D','10','10444',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('756','EGOOLTDVOLZ0','30','D','10','10452',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('757','EGOOLTDVOLZ0','30','D','10','10482',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('758','EGOOLTDVOLZ0','9','D','10','10512',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('759','EGOOLTDVOLZ0','60','D','10','10521',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('760','EGOOLTDVOLZ0','9','D','10','10581',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('761','EGOOLTDVOLZ0','8','D','10','10590',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('762','EGOOLTDVOLZ0','40','D','10','10598',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('763','EGOOLTDVOLZ0','40','D','10','10638',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('764','EGOOLTDVOLZ0','30','D','10','10678',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('765','EGOOLTDVOLZ0','2','D','10','10708',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('766','EGOOLTDVOLZ0','10','D','10','10710',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('767','EGOOLTDVOLZ0','2','D','10','10720',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('768','EGOOLTDVOLZ0','3','D','10','10722',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('769','EGOOLTDVOLZ0','3','D','10','10725',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('770','EGOOLTDVOLZ0','1','D','10','10728',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('771','EGOOLTDVOLZ0','8','D','10','10729',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('772','EGOOLTDVOLZ0','30','D','10','10737',NULL,'Beneficiary Last Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('773','EGOOLTDVOLZ0','30','D','10','10767',NULL,'Beneficiary First Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('774','EGOOLTDVOLZ0','9','D','10','10797',NULL,'Beneficiary SSN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('775','EGOOLTDVOLZ0','60','D','10','10806',NULL,'Trust/Charity Name',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('776','EGOOLTDVOLZ0','9','D','10','10866',NULL,'Tax Identification Number',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('777','EGOOLTDVOLZ0','8','D','10','10875',NULL,'Beneficiary Date of Birth',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('778','EGOOLTDVOLZ0','40','D','10','10883',NULL,'Beneficiary Address Line 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('779','EGOOLTDVOLZ0','40','D','10','10923',NULL,'Beneficiary Address Line 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('780','EGOOLTDVOLZ0','30','D','10','10963',NULL,'Beneficiary City',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('781','EGOOLTDVOLZ0','2','D','10','10993',NULL,'Beneficiary State',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('782','EGOOLTDVOLZ0','10','D','10','10995',NULL,'Beneficiary Zip Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('783','EGOOLTDVOLZ0','2','D','10','11005',NULL,'Beneficiary Relationship',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('784','EGOOLTDVOLZ0','3','D','10','11007',NULL,'Beneficiary Plan Type Code',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('785','EGOOLTDVOLZ0','3','D','10','11010',NULL,'Beneficiary Percent Allocation',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('786','EGOOLTDVOLZ0','1','D','10','11013',NULL,'Beneficiary Primary or Contingent',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('787','EGOOLTDVOLZ0','8','D','10','11014',NULL,'Beneficiary Effective Date',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('788','EGOOLTDVOLZ0','5','D','10','11022',NULL,'Section Code',NULL,NULL,'"~DED~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('789','EGOOLTDVOLZ0','10','D','10','11027',NULL,'Benefit Deduct Type 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('790','EGOOLTDVOLZ0','6','D','10','11037',NULL,'Benefit Deduct Amt 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('791','EGOOLTDVOLZ0','8','D','10','11043',NULL,'Benefit Deduct Eff Date 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('792','EGOOLTDVOLZ0','8','D','10','11051',NULL,'Benefit Deduct End Date1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('793','EGOOLTDVOLZ0','1','D','10','11059',NULL,'Benefit Deduct Pre/Post 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('794','EGOOLTDVOLZ0','1','D','10','11060',NULL,'Benefit Deduct Basis 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('795','EGOOLTDVOLZ0','2','D','10','11061',NULL,'Benefit Deduct Order 1',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('796','EGOOLTDVOLZ0','10','D','10','11063',NULL,'Benefit Deduct Type 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('797','EGOOLTDVOLZ0','6','D','10','11073',NULL,'Benefit Deduct Amt 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('798','EGOOLTDVOLZ0','8','D','10','11079',NULL,'Benefit Deduct Eff Date 2',NULL,NULL,'""','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('799','EGOOLTDVOLZ0','8','D','10','11087',NULL,'Benefit Deduct End Date 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('800','EGOOLTDVOLZ0','1','D','10','11095',NULL,'Benefit Deduct Pre/Post 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('801','EGOOLTDVOLZ0','1','D','10','11096',NULL,'Benefit Deduct Basis 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('802','EGOOLTDVOLZ0','2','D','10','11097',NULL,'Benefit Deduct Order 2',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('803','EGOOLTDVOLZ0','10','D','10','11099',NULL,'Benefit Deduct Type 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('804','EGOOLTDVOLZ0','6','D','10','11109',NULL,'Benefit Deduct Amt 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('805','EGOOLTDVOLZ0','8','D','10','11115',NULL,'Benefit Deduct Eff Date 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('806','EGOOLTDVOLZ0','8','D','10','11123',NULL,'Benefit Deduct End Date3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('807','EGOOLTDVOLZ0','1','D','10','11131',NULL,'Benefit Deduct Pre/Post 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('808','EGOOLTDVOLZ0','1','D','10','11132',NULL,'Benefit Deduct Basis 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('809','EGOOLTDVOLZ0','2','D','10','11133',NULL,'Benefit Deduct Order 3',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('810','EGOOLTDVOLZ0','10','D','10','11135',NULL,'Benefit Deduct Type 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('811','EGOOLTDVOLZ0','6','D','10','11145',NULL,'Benefit Deduct Amt 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('812','EGOOLTDVOLZ0','8','D','10','11151',NULL,'Benefit Deduct Eff Date 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('813','EGOOLTDVOLZ0','8','D','10','11159',NULL,'Benefit Deduct End Date 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('814','EGOOLTDVOLZ0','1','D','10','11167',NULL,'Benefit Deduct Pre/Post 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('815','EGOOLTDVOLZ0','1','D','10','11168',NULL,'Benefit Deduct Basis 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('816','EGOOLTDVOLZ0','2','D','10','11169',NULL,'Benefit Deduct Order 4',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('817','EGOOLTDVOLZ0','10','D','10','11171',NULL,'Benefit Deduct Type 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('818','EGOOLTDVOLZ0','6','D','10','11181',NULL,'Benefit Deduct Amt 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('819','EGOOLTDVOLZ0','8','D','10','11187',NULL,'Benefit Deduct Eff Date 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('820','EGOOLTDVOLZ0','8','D','10','11195',NULL,'Benefit Deduct End Date 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('821','EGOOLTDVOLZ0','1','D','10','11203',NULL,'Benefit Deduct Pre/Post 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('822','EGOOLTDVOLZ0','1','D','10','11204',NULL,'Benefit Deduct Basis 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('823','EGOOLTDVOLZ0','2','D','10','11205',NULL,'Benefit Deduct Order 5',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('824','EGOOLTDVOLZ0','10','D','10','11207',NULL,'Benefit Deduct Type 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('825','EGOOLTDVOLZ0','6','D','10','11217',NULL,'Benefit Deduct Amt 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('826','EGOOLTDVOLZ0','8','D','10','11223',NULL,'Benefit Deduct Eff Date 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('827','EGOOLTDVOLZ0','8','D','10','11231',NULL,'Benefit Deduct End Date 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('828','EGOOLTDVOLZ0','1','D','10','11239',NULL,'Benefit Deduct Pre/Post 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('829','EGOOLTDVOLZ0','1','D','10','11240',NULL,'Benefit Deduct Basis 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('830','EGOOLTDVOLZ0','2','D','10','11241',NULL,'Benefit Deduct Order 6',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('831','EGOOLTDVOLZ0','10','D','10','11243',NULL,'Benefit Deduct Type 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('832','EGOOLTDVOLZ0','6','D','10','11253',NULL,'Benefit Deduct Amt 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('833','EGOOLTDVOLZ0','8','D','10','11259',NULL,'Benefit Deduct Eff Date 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('834','EGOOLTDVOLZ0','8','D','10','11267',NULL,'Benefit Deduct End Date 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('835','EGOOLTDVOLZ0','1','D','10','11275',NULL,'Benefit Deduct Pre/Post 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('836','EGOOLTDVOLZ0','1','D','10','11276',NULL,'Benefit Deduct Basis 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('837','EGOOLTDVOLZ0','2','D','10','11277',NULL,'Benefit Deduct Order 7',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('838','EGOOLTDVOLZ0','10','D','10','11279',NULL,'Benefit Deduct Type 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('839','EGOOLTDVOLZ0','6','D','10','11289',NULL,'Benefit Deduct Amt 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('840','EGOOLTDVOLZ0','8','D','10','11295',NULL,'Benefit Deduct Eff Date 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('841','EGOOLTDVOLZ0','8','D','10','11303',NULL,'Benefit Deduct End Date 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('842','EGOOLTDVOLZ0','1','D','10','11311',NULL,'Benefit Deduct Pre/Post 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('843','EGOOLTDVOLZ0','1','D','10','11312',NULL,'Benefit Deduct Basis 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('844','EGOOLTDVOLZ0','2','D','10','11313',NULL,'Benefit Deduct Order 8',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('845','EGOOLTDVOLZ0','10','D','10','11315',NULL,'Benefit Deduct Type 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('846','EGOOLTDVOLZ0','6','D','10','11325',NULL,'Benefit Deduct Amt 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('847','EGOOLTDVOLZ0','8','D','10','11331',NULL,'Benefit Deduct Eff Date 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('848','EGOOLTDVOLZ0','8','D','10','11339',NULL,'Benefit Deduct End Date 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('849','EGOOLTDVOLZ0','1','D','10','11347',NULL,'Benefit Deduct Pre/Post 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('850','EGOOLTDVOLZ0','1','D','10','11348',NULL,'Benefit Deduct Basis 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('851','EGOOLTDVOLZ0','2','D','10','11349',NULL,'Benefit Deduct Order 9',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('852','EGOOLTDVOLZ0','10','D','10','11351',NULL,'Benefit Deduct Type 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('853','EGOOLTDVOLZ0','6','D','10','11361',NULL,'Benefit Deduct Amt 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('854','EGOOLTDVOLZ0','8','D','10','11367',NULL,'Benefit Deduct Eff Date 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('855','EGOOLTDVOLZ0','8','D','10','11375',NULL,'Benefit Deduct End Date 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('856','EGOOLTDVOLZ0','1','D','10','11383',NULL,'Benefit Deduct Pre/Post 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('857','EGOOLTDVOLZ0','1','D','10','11384',NULL,'Benefit Deduct Basis 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('858','EGOOLTDVOLZ0','2','D','10','11385',NULL,'Benefit Deduct Order 10',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('859','EGOOLTDVOLZ0','10','D','10','11387',NULL,'Benefit Deduct Type 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('860','EGOOLTDVOLZ0','6','D','10','11397',NULL,'Benefit Deduct Amt 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('861','EGOOLTDVOLZ0','8','D','10','11403',NULL,'Benefit Deduct Eff Date 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('862','EGOOLTDVOLZ0','8','D','10','11411',NULL,'Benefit Deduct End Date 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('863','EGOOLTDVOLZ0','1','D','10','11419',NULL,'Benefit Deduct Pre/Post 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('864','EGOOLTDVOLZ0','1','D','10','11420',NULL,'Benefit Deduct Basis 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('865','EGOOLTDVOLZ0','2','D','10','11421',NULL,'Benefit Deduct Order 11',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('866','EGOOLTDVOLZ0','10','D','10','11423',NULL,'Benefit Deduct Type 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('867','EGOOLTDVOLZ0','6','D','10','11433',NULL,'Benefit Deduct Amt 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('868','EGOOLTDVOLZ0','8','D','10','11439',NULL,'Benefit Deduct Eff Date 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('869','EGOOLTDVOLZ0','8','D','10','11447',NULL,'Benefit Deduct End Date 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('870','EGOOLTDVOLZ0','1','D','10','11455',NULL,'Benefit Deduct Pre/Post 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('871','EGOOLTDVOLZ0','1','D','10','11456',NULL,'Benefit Deduct Basis 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('872','EGOOLTDVOLZ0','2','D','10','11457',NULL,'Benefit Deduct Order 12',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('873','EGOOLTDVOLZ0','10','D','10','11459',NULL,'Benefit Deduct Type 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('874','EGOOLTDVOLZ0','6','D','10','11469',NULL,'Benefit Deduct Amt 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('875','EGOOLTDVOLZ0','8','D','10','11475',NULL,'Benefit Deduct Eff Date 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('876','EGOOLTDVOLZ0','8','D','10','11483',NULL,'Benefit Deduct End Date 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('877','EGOOLTDVOLZ0','1','D','10','11491',NULL,'Benefit Deduct Pre/Post 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('878','EGOOLTDVOLZ0','1','D','10','11492',NULL,'Benefit Deduct Basis 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('879','EGOOLTDVOLZ0','2','D','10','11493',NULL,'Benefit Deduct Order 13',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('880','EGOOLTDVOLZ0','10','D','10','11495',NULL,'Benefit Deduct Type 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('881','EGOOLTDVOLZ0','6','D','10','11505',NULL,'Benefit Deduct Amt 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('882','EGOOLTDVOLZ0','8','D','10','11511',NULL,'Benefit Deduct Eff Date 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('883','EGOOLTDVOLZ0','8','D','10','11519',NULL,'Benefit Deduct End Date 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('884','EGOOLTDVOLZ0','1','D','10','11527',NULL,'Benefit Deduct Pre/Post 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('885','EGOOLTDVOLZ0','1','D','10','11528',NULL,'Benefit Deduct Basis 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('886','EGOOLTDVOLZ0','2','D','10','11529',NULL,'Benefit Deduct Order 14',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('887','EGOOLTDVOLZ0','10','D','10','11531',NULL,'Benefit Deduct Type 15',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('888','EGOOLTDVOLZ0','6','D','10','11541',NULL,'Benefit Deduct Amt 15',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('889','EGOOLTDVOLZ0','8','D','10','11547',NULL,'Benefit Deduct Eff Date 15',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('890','EGOOLTDVOLZ0','8','D','10','11555',NULL,'Benefit Deduct End Date 15',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('891','EGOOLTDVOLZ0','1','D','10','11563',NULL,'Benefit Deduct Pre/Post 15',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('892','EGOOLTDVOLZ0','1','D','10','11564',NULL,'Benefit Deduct Basis 15',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('893','EGOOLTDVOLZ0','2','D','10','11565',NULL,'Benefit Deduct Order 15',NULL,NULL,'""','(''SS''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EGOOLTDVOLZ0','5','T','90','1',NULL,'Section Code',NULL,NULL,'"~FTR~"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EGOOLTDVOLZ0','7','T','90','6',NULL,'Record Count',NULL,NULL,'"drvRecordCount"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EGOOLTDVOL_20230419.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202212129','EMPEXPORT','OEACTIVE',NULL,'EGOOLTDVOL',NULL,NULL,NULL,'202212129','Dec 13 2022  1:27PM','Dec 13 2022  1:27PM','202112051',NULL,'','','202112051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202212129','EMPEXPORT','OEPASSIVE',NULL,'EGOOLTDVOL',NULL,NULL,NULL,'202212129','Dec 13 2022  1:27PM','Dec 13 2022  1:27PM','202112051',NULL,'','','202112051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Hartford On Demand','202212129','EMPEXPORT','ONDEM_XOE',NULL,'EGOOLTDVOL',NULL,NULL,NULL,'202212129','Dec 13 2022  1:27PM','Dec 13 2022  1:27PM','202112051',NULL,'','','202112051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'Null','N',',LQS0S',NULL,NULL,NULL,'Hartford Weekly Wed 6A ET','202212129','EMPEXPORT','SCH_EGOOLT',NULL,'EGOOLTDVOL',NULL,NULL,NULL,'202304129','Dec 13 2022  1:27PM','Dec 13 2022  1:27PM','202304051',NULL,'','','202112051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Hartford-Test','202304179','EMPEXPORT','TEST_XOE',NULL,'EGOOLTDVOL',NULL,NULL,NULL,'202304179','Dec 13 2022  1:27PM','Dec 13 2022  1:27PM','202304031',NULL,'','','202304031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGOOLTDVOL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGOOLTDVOL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGOOLTDVOL','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGOOLTDVOL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGOOLTDVOL','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EGOOLTDVOL','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGOOLTDVOL','H01','dbo.U_EGOOLTDVOL_HDR_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGOOLTDVOL','D10','dbo.U_EGOOLTDVOL_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EGOOLTDVOL','T90','dbo.U_EGOOLTDVOL_FTR_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_EGOOLTDVOL
-----------

IF OBJECT_ID('U_dsi_BDM_EGOOLTDVOL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EGOOLTDVOL] (
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
-- Create table U_EGOOLTDVOL_Audit
-----------

IF OBJECT_ID('U_EGOOLTDVOL_Audit') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_Audit] (
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
-- Create table U_EGOOLTDVOL_AuditFields
-----------

IF OBJECT_ID('U_EGOOLTDVOL_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EGOOLTDVOL_DedList
-----------

IF OBJECT_ID('U_EGOOLTDVOL_DedList') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_EGOOLTDVOL_drvTbl
-----------

IF OBJECT_ID('U_EGOOLTDVOL_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(10) NULL,
    [drvCustomerNumber] varchar(7) NOT NULL,
    [drvTransactionCode] varchar(1) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvRelationshipCode] varchar(2) NULL,
    [drvMemberID] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvDateofBirth] datetime NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvSmokerStatus] varchar(1) NULL,
    [EepAddressLine1] varchar(255) NULL,
    [EepAddressLine2] varchar(255) NULL,
    [EepAddressCity] varchar(255) NULL,
    [EepAddressState] varchar(255) NULL,
    [EepAddressZipCode] varchar(50) NULL,
    [eepphonehomenumber] varchar(50) NULL,
    [eepAddressEMail] varchar(50) NULL,
    [drvWorkStateCode] varchar(255) NULL,
    [drvSupervisorID] varchar(256) NULL,
    [drvEmplStatusCode] varchar(1) NOT NULL,
    [drvStatusEffectiveDate] datetime NULL,
    [drvEmplServiceDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvEmploymentType] varchar(1) NOT NULL,
    [drvScheduledHoursPerWeek] nvarchar(4000) NULL,
    [drvAnnSalary] nvarchar(4000) NULL,
    [drvSalaryEffectiveDate] datetime NULL,
    [drvJobTitle] varchar(25) NULL,
    [drvCovEffectiveDate1] datetime NULL,
    [drvCovTermDate1] datetime NULL,
    [drvSTDCoveragePlanOption1] varchar(2) NULL,
    [drvPlanSummary1] varchar(3) NULL,
    [drvEmplGroupID1] varchar(1) NULL,
    [drvEmplClassCode1] varchar(1) NULL,
    [drvCovEffectiveDate2] datetime NULL,
    [drvCovTermDate2] datetime NULL,
    [drv60] varchar(2) NULL,
    [drvPlanSummary2] varchar(3) NULL,
    [drvEmployeeGroupID2] varchar(1) NULL,
    [drvEmployeeClassCode2] varchar(1) NULL,
    [drvCovEffectiveDate3] datetime NULL,
    [drvCovTermDate3] datetime NULL,
    [drvBasicLifeMulSalFaceAmt] varchar(3) NULL,
    [drvBasicLifeFaceAmt] nvarchar(4000) NULL,
    [drvEmplGroupID3] varchar(1) NULL,
    [drvEmplClassCode3] varchar(1) NULL,
    [drvCovEffectiveDate4] datetime NULL,
    [drvCovTermDate4] datetime NULL,
    [drvBasicADDFaceAmt] nvarchar(4000) NULL,
    [drvEmplGroupID4] varchar(1) NULL,
    [drvEmplClassCode4] varchar(1) NULL,
    [drvCovEffectiveDate5] datetime NULL,
    [drvCovTermDate5] datetime NULL,
    [drvSupLifeMultiSalFaceAmt] varchar(1) NOT NULL,
    [drvSupLifeFaceAmt] nvarchar(4000) NULL,
    [drvSupLifeReqAmt] nvarchar(4000) NULL,
    [drvEmplGroupID5] varchar(1) NULL,
    [drvEmplClassCode5] varchar(1) NULL,
    [drvCovEffectiveDate6] datetime NULL,
    [drvCovTermDate6] datetime NULL,
    [drvSupADDFaceAmt] nvarchar(4000) NULL,
    [drvSupADDReqAmt] varchar(1) NOT NULL,
    [drvEmplGroupID6] varchar(1) NULL,
    [drvEmplClassCode6] varchar(1) NULL,
    [drvCovEffectiveDate7] datetime NULL,
    [drvCovTermDate7] datetime NULL,
    [drvSpouseSupLifeFaceAmt] nvarchar(4000) NULL,
    [drvSpouseSupLifeReqAmt] nvarchar(4000) NULL,
    [drvEmplGroupID7] varchar(1) NULL,
    [drvEmplClass7] varchar(1) NULL,
    [drvCovEffectiveDate8] datetime NULL,
    [drvCovTermDate8] datetime NULL,
    [drvDepChildBasicLifeFaceAmt] nvarchar(4000) NULL,
    [drvEmplGroupID8] varchar(1) NULL,
    [drvEmplClass8] varchar(1) NULL,
    [drvCovEffectiveDate9] datetime NULL,
    [drvCovTermDate9] datetime NULL,
    [drvSpouseSupADDFaceAmt] nvarchar(4000) NULL,
    [drvSpouseSupADDReqAmt] varchar(1) NOT NULL,
    [drvEmplGroupID9] varchar(1) NULL,
    [drvEmplClass9] varchar(1) NULL,
    [drvCovEffectiveDate10] datetime NULL,
    [drvCovTermDate10] datetime NULL,
    [drvDepChildBasicADDFaceAmt] nvarchar(4000) NULL,
    [drvEmplGroupID10] varchar(1) NULL,
    [drvEmplClass10] varchar(1) NULL,
    [drvCovEffectiveDate11] datetime NULL,
    [drvCovTermDate11] datetime NULL,
    [drvCIBenefitAmount] varchar(5) NULL,
    [drvCoverageTier11] varchar(1) NULL,
    [drvPlanNumber11] varchar(1) NULL,
    [drvEmpGroupID11] varchar(1) NULL,
    [drvEmpClass11] varchar(1) NULL,
    [drvCovEffectiveDate12] datetime NULL,
    [drvCovTermDate12] datetime NULL,
    [drvCoverageTier12] varchar(1) NULL,
    [drvPlanOption12] varchar(9) NULL,
    [drvPlanNumber12] varchar(1) NULL,
    [drvEmplGroupID12] varchar(1) NULL,
    [drvEmplClass12] varchar(1) NULL,
    [drvCovEffDate13] datetime NULL,
    [drvCovTermDate13] datetime NULL,
    [drvCoverageTier13] varchar(1) NULL,
    [drvPlanOption13] varchar(9) NULL,
    [drvPlanNumber13] varchar(1) NULL,
    [drvEmplGroupID13] varchar(1) NULL,
    [drvEmplClass13] varchar(1) NULL
);

-----------
-- Create table U_EGOOLTDVOL_EEList
-----------

IF OBJECT_ID('U_EGOOLTDVOL_EEList') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EGOOLTDVOL_File
-----------

IF OBJECT_ID('U_EGOOLTDVOL_File') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);

-----------
-- Create table U_EGOOLTDVOL_FTR_drvTbl
-----------

IF OBJECT_ID('U_EGOOLTDVOL_FTR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_FTR_drvTbl] (
    [drvRecordCount] int NULL
);

-----------
-- Create table U_EGOOLTDVOL_HDR_drvTbl
-----------

IF OBJECT_ID('U_EGOOLTDVOL_HDR_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EGOOLTDVOL_HDR_drvTbl] (
    [drvCustomerCount] varchar(1) NOT NULL,
    [drvFileName] varchar(36) NOT NULL,
    [drvDateCreated] datetime NOT NULL,
    [drvVersionNo] varchar(5) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EGOOLTDVOL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Goodwill-Easter Seals MN

Created By: Marie Thomerson
Business Analyst: Katherine Ricca
Create Date: 12/13/2022
Service Request Number: TekP-2022-09-30-03

Purpose: Hartford LTD, STD, Life, AD&D, Crit, Acc, Hosp

Revision History
----------------
Update By           Date           Request Num        Desc
Marie Waters        04/19/2023       TekP-2022-09-30-03  Changed how Supplemental Life Face Amount is populated
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EGOOLTDVOL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EGOOLTDVOL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EGOOLTDVOL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EGOOLTDVOL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EGOOLTDVOL' ORDER BY RunID DESC;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202304031'
       ,expStartPerControl     = '202304031'
       ,expLastEndPerControl   = '202304179'
       ,expEndPerControl       = '202304179'
WHERE expFormatCode = 'EGOOLTDVOL' and expexportcode = 'TEST_XOE';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGOOLTDVOL', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGOOLTDVOL', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGOOLTDVOL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGOOLTDVOL', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EGOOLTDVOL', 'SCH_EGOOLT';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EGOOLTDVOL';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EGOOLTDVOL', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EGOOLTDVOL';

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
    DELETE FROM dbo.U_EGOOLTDVOL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EGOOLTDVOL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EGOOLTDVOL_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EGOOLTDVOL_AuditFields;
    CREATE TABLE dbo.U_EGOOLTDVOL_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EGOOLTDVOL_AuditFields VALUES ('Empcomp','eecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EGOOLTDVOL_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EGOOLTDVOL_Audit;
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
    INTO dbo.U_EGOOLTDVOL_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EGOOLTDVOL_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EGOOLTDVOL_Audit ON dbo.U_EGOOLTDVOL_Audit (audEEID,audKey2);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STDHD,LTDHD,LTDHC,LIFCH,LIFDH,LIFBH,LIEBH,LIFCH,LIFDH,ELIFH,CLIFH,CIC1H,CIC2H,CIS1H,CIS2H,CIE1H,CIE2H,SLIFH,ACCHH,ACCLH,HIHHD,HILHD';
    IF OBJECT_ID('U_EGOOLTDVOL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EGOOLTDVOL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EGOOLTDVOL_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);--'STDHD,LTDHD,LTDHC,LIFCH,LIFDH,LIFBH,LIEBH,LIFCH,LIFDH,ELIFH,CLIFH,CIC1H,CIC2H,CIS1H,CIS2H,CIE1H,CIE2H,SLIFH,ACCHH,ACCLH,HIHHD,HILHD'
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DependentBenefitAgeGradedRate','ELIFH,CLIFH,SLIFH');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EmployeeElectedRateorPct','LIFBH,LIFCH, LIFDH');

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

    --==============================
    -- Update EedEOIDesiredAmt
    --============================== 

        UPDATE dbo.U_dsi_bdm_EGOOLTDVOL
        SET BdmUSGField1 = EedEOIDesiredAmt
           FROM dbo.U_dsi_bdm_EGOOLTDVOL
           JOIN dbo.EmpDed WITH (NOLOCK)
               ON EedEEID = BdmEEID
               AND EedCOID  = BdmCOID
            AND EedDedCode in ('CIS1H','CIE1H','CIE2H','CIC2H','CIC1H','CIS2H','LIFBH','LIFCH','LIFDH','LTDHC','LTDHD','STDHD','SLIFH','ACCHH','ACCLH','HILHD','HIHHD','ELIFH','CLIFH')
            AND EedDedCode = BdmDedCode
            AND eedneedeoi = 'Y' ;

    --================================
    -- Update BdmEEAmt with BcaEEAmt
    --================================

    UPDATE dbo.U_dsi_BDM_EGOOLTDVOL
    SET BdmEEAmt = BcaEEAmt
    from dbo.u_dsi_bdm_BenCalculationAmounts
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
    on eedeeid = bcaeeid AND eedcoid = bcacoid
    AND eedFormatCode = bcaFormatCode AND eeddedcode = bcadedcode
    AND BcaDepRecID IS NULL
    AND eedFormatCode = 'EGOOLTDVOL' AND eedvalidforexport = 'Y'
    JOIN dbo.U_dsi_BDM_EGOOLTDVOL WITH (NOLOCK)
    ON eeddedcode = BdmDedCode
    AND BdmEEID = eedeeid
    AND BdmCoID = eedcoid 
    AND BdmDedCode in ('ACCHH','ACCLH','HILHD','HIHHD');

    --================================
    -- Update BdmEEAmt with EedBenAmt
    --================================

    UPDATE dbo.U_dsi_BDM_EGOOLTDVOL
    SET BdmEEAmt = EedBenAmt
    from dbo.u_dsi_bdm_BenCalculationAmounts
    JOIN dbo.U_dsi_bdm_EmpDeductions
    on eedeeid = bcaeeid AND eedcoid = bcacoid
    AND eedFormatCode = bcaFormatCode AND eeddedcode = bcadedcode
    AND BcaDepRecID IS NULL
    AND eedFormatCode = 'EGOOLTDVOL' AND eedvalidforexport = 'Y'
    JOIN dbo.U_dsi_BDM_EGOOLTDVOL
    ON eeddedcode = BdmDedCode
    AND BdmEEID = eedeeid
    AND BdmCoID = eedcoid 
    AND BdmDedCode in  ('ELIFH','CLIFH','SLIFH')  --Supp Life
    ANd EedBenAmt <> 0;

    --===================================
    -- Update BdmEEAmt with bcaBenAmtCalc
    --===================================

    UPDATE dbo.U_dsi_BDM_EGOOLTDVOL
    SET BdmEEAmt = bcaBenAmtCalc
    from dbo.u_dsi_bdm_BenCalculationAmounts
    JOIN dbo.U_dsi_bdm_EmpDeductions
    on eedeeid = bcaeeid AND eedcoid = bcacoid
    AND eedFormatCode = bcaFormatCode AND eeddedcode = bcadedcode
    AND BcaDepRecID IS NULL
    AND eedFormatCode = 'EGOOLTDVOL' AND eedvalidforexport = 'Y'
    JOIN dbo.U_dsi_BDM_EGOOLTDVOL
    ON eeddedcode = BdmDedCode
    AND BdmEEID = eedeeid
    AND BdmCoID = eedcoid 
    AND BdmDedCode in  ('ELIFH','CLIFH','LIFBH', 'LIFCH','LIFDH')
    ANd EedBenAmt = 0;

    UPDATE dbo.U_dsi_BDM_EGOOLTDVOL
    SET BdmEEAmt = bcaBenAmtCalc
    from dbo.u_dsi_bdm_BenCalculationAmounts
    JOIN dbo.U_dsi_bdm_EmpDeductions
    on eedeeid = bcaeeid AND eedcoid = bcacoid
    AND eedFormatCode = bcaFormatCode AND eeddedcode = bcadedcode
    AND BcaDepRecID IS NULL
    AND eedFormatCode = 'EGOOLTDVOL' AND eedvalidforexport = 'Y'
    JOIN dbo.U_dsi_BDM_EGOOLTDVOL
    ON eeddedcode = BdmDedCode
    AND BdmEEID = eedeeid
    AND BdmCoID = eedcoid 
    AND BdmDedCode in  ('CIS1H','CIE1H','CIE2H','CIC2H','CIC1H','CIS2H','LIFBH','LIFCH','LIFDH','LTDHC','LTDHD','STDHD','SLIFH');

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EGOOLTDVOL_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EGOOLTDVOL_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGOOLTDVOL_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo + CASE WHEN BdmRecType = 'EMP' THEN 'A' 
                                    WHEN ConRelationship = 'SP' THEN 'B'ELSE 'C' END
        -- standard fields above and additional driver fields below
        ,drvCustomerNumber = '1732343'
        ,drvTransactionCode = CASE  WHEN BdmRecType = 'EMP' THEN 'E'
                                    WHEN BdmRecType = 'DEP' THEN 'D'
                                    END
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvRelationshipCode = CASE WHEN conrelationship in ('CHL', 'STC', 'DPC', 'DIS') THEN 'CH'
                                    WHEN conrelationship in ('SPS','DP') THEN 'SP' 
                                    END
        ,drvMemberID = CASE  WHEN BdmRecType = 'EMP' THEN EepSSN else conSSN END 
        ,drvNameLast = CASE  WHEN BdmRecType = 'EMP' THEN EepNameLast Else ConNameLast END
        ,drvNameFirst = CASE  WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvDateofBirth = CASE    WHEN BdmRecType = 'EMP' THEN EepDateOfBirth else condateofbirth END 
        ,drvMaritalStatus = CASE    WHEN eepMaritalStatus = 'Z' THEN 'U'
                                    WHEN EepMaritalStatus is null then 'U'
                                    WHEN eepMaritalStatus = 'S' THEN 'I'
                                    ELSE eepMaritalStatus END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN eepGender in ('M','F') THEN eepGender ELSE 'U' END
                        ELSE CASE WHEN conGender in ('M','F') THEN conGender ELSE 'U' END END
        ,drvSmokerStatus = eepIsSmoker
        --- ~ECI~
        ,EepAddressLine1 = EepAddressLine1
        ,EepAddressLine2 = EepAddressLine2
        ,EepAddressCity = EepAddressCity
        ,EepAddressState = EepAddressState
        ,EepAddressZipCode = EepAddressZipCode
        ,eepphonehomenumber = EepPhoneHomeNumber
        ,eepAddressEMail = EepAddressEMail
        ,drvWorkStateCode = LocAddressState 
        --- ~ERC~
        ,drvSupervisorID = [dbo].[dsi_fnlib_GetSupervisorField_v2] ('',EecEEID,'EmpNo')
        --- ~EMI~
        ,drvEmplStatusCode = CASE   WHEN EecEmplStatus = 'T' THEN 'T'
                                    WHEN EecEmplStatus = 'L' THEN 'L' 
                                    else 'A'
                                    END
        ,drvStatusEffectiveDate = CASE  WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                        WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                        else EecDateOfLastHire
                                        END
        ,drvEmplServiceDate = EecDateOfLastHire
        ,drvRehireDate = EecDateOfLastHire
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvEmploymentType = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'P' else 'F' END
        ,drvScheduledHoursPerWeek = Case 
                                        When EecPayPeriod  ='W' then FORMAT(EecScheduledWorkHrs *100,'####')
                                        When EecPayPeriod = 'B' then FORMAT((EecScheduledWorkHrs / 2) *100,'####')
                                        When EecPayPeriod = 'S' then FORMAT(((EecScheduledWorkHrs * 24) / 52)*100,'####')
                                        When EecPayPeriod  ='M' then FORMAT(((EecScheduledWorkHrs * 12) / 52)*100,'####')
                                        END

        ,drvAnnSalary = FORMAT(EecAnnSalary*100, '#########')
        ,drvSalaryEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate(EecEEID, EecCOID, EecDateOfLastHire) 
        ,drvJobTitle = JbcDesc
        --- ~NST~
        ,drvCovEffectiveDate1 = CASE WHEN dedcode_STDHD  = 'STDHD' and LocAddressState <> 'CA' THEN BdmBenStartDate_STDHD END
        ,drvCovTermDate1 = CASE WHEN dedcode_STDHD  = 'STDHD' and LocAddressState  <> 'CA' THEN BdmBenStopDate_STDHD END
        ,drvSTDCoveragePlanOption1 = CASE WHEN dedcode_STDHD  = 'STDHD' and LocAddressState  <> 'CA' THEN '60' END
        ,drvPlanSummary1 = CASE WHEN dedcode_STDHD  = 'STDHD' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1A1'
                                 WHEN dedcode_STDHD  = 'STDHD' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '1A3'
                                WHEN dedcode_STDHD  = 'STDHD' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') THEN '1A2'
                            END
                            --CASE WHEN DedCode_STDHD  = 'STDHD' and LocAddressState  <> 'CA' THEN '1A2' END
        ,drvEmplGroupID1 = CASE WHEN dedcode_STDHD  = 'STDHD' and LocAddressState  <> 'CA' THEN '1' END
        ,drvEmplClassCode1 = CASE WHEN dedcode_STDHD  = 'STDHD' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                                 WHEN dedcode_STDHD  = 'STDHD' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                                WHEN dedcode_STDHD  = 'STDHD' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') THEN '2'
                            END
        --- ~LTD~
        ,drvCovEffectiveDate2 = CASE WHEN dedcode_LTDHD = 'LTDHD' THEN BdmBenStartDate_LTDHD END
        ,drvCovTermDate2 = CASE WHEN dedcode_LTDHD = 'LTDHD' THEN BdmBenStopDate_LTDHD END
        ,drv60 = CASE WHEN dedcode_LTDHD = 'LTDHD' THEN '60' END
        ,drvPlanSummary2 = CASE WHEN dedcode_LTDHD = 'LTDHD' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1B1'
                             WHEN dedcode_LTDHD = 'LTDHD' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '1B3'
                             WHEN dedcode_LTDHD  = 'LTDHD' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') THEN '1B2'
                           END

        ,drvEmployeeGroupID2 = CASE WHEN dedcode_LTDHD = 'LTDHD' THEN '1' END
        ,drvEmployeeClassCode2 = CASE WHEN dedcode_LTDHD = 'LTDHD' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                                     WHEN dedcode_LTDHD = 'LTDHD' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                                    WHEN dedcode_LTDHD  = 'LTDHD' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                                  END
        --- ~BLF~
        ,drvCovEffectiveDate3 = CASE WHEN dedcode_L in ('Y') THEN Bdmbenstartdate_L END
        ,drvCovTermDate3 = CASE WHEN dedcode_L in ('Y') THEN Bdmbenstopdate_L END
        ,drvBasicLifeMulSalFaceAmt = CASE WHEN dedcode_LIFCH = 'LIFCH' THEN '250'  --FORMAT(BdmEEAmt_LIFCH, '#.##')
                                          WHEN dedcode_L in ('Y') THEN '100' 
                                    END                            ---- Added MT
        ,drvBasicLifeFaceAmt = CASE WHEN dedcode_LIFBH = 'LIFBH' THEN FORMAT(BdmEEAmt_LIFBH, '###########')
                                    WHEN dedcode_LIFCH  = 'LIFCH' then FORMAT(BdmEEAmt_LIFCH, '###########')
                                    --WHEN dedcode_LIFBH = 'LIFBH' THEN FORMAT((BdmEEAmt_LIFBH*EecAnnSalary)*100, '###########')
                                    --WHEN dedcode_LIFCH  = 'LIFCH' then FORMAT((BdmEEAmt_LIFCH*EecAnnSalary)*100, '###########')
                                    WHEN dedcode_LIFDH  = 'LIFDH' then FORMAT(BdmEEAmt_LIFDH, '###########') --'125000'
                                 END
        ,drvEmplGroupID3 = CASE WHEN dedcode_L in ('Y') THEN '1' END
        ,drvEmplClassCode3 = CASE WHEN dedcode_L in ('Y') and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                                     WHEN dedcode_L in ('Y') and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                                    WHEN dedcode_L in ('Y') and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                                  END
        
        --- ~BAD~
        ,drvCovEffectiveDate4 = CASE WHEN dedcode_L in ('Y') THEN Bdmbenstartdate_L END
        ,drvCovTermDate4 = CASE WHEN dedcode_L in ('Y') THEN Bdmbenstopdate_L END
        ,drvBasicADDFaceAmt = CASE WHEN dedcode_LIFBH = 'LIFBH' THEN FORMAT(BdmEEAmt_LIFBH, '###########') --BdmEEAmt_LIFBH
                                    WHEN dedcode_LIFCH = 'LIFCH' then FORMAT(BdmEEAmt_LIFCH, '###########') --BdmEEAmt_LIFCH
                                    WHEN dedcode_LIFDH = 'LIFDH' then FORMAT(BdmEEAmt_LIFDH, '###########') --'125000'
                                    END
        ,drvEmplGroupID4 = CASE WHEN dedcode_L in ('Y') THEN '1' END
        ,drvEmplClassCode4 = CASE WHEN dedcode_L in ('Y') and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                                     WHEN dedcode_L in ('Y') and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                                    WHEN dedcode_L in ('Y') and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                                  END
        
        --- ~LIF~
        ,drvCovEffectiveDate5 = CASE WHEN dedcode_ELIFH = 'ELIFH' THEN Bdmbenstartdate_ELIFH END
        ,drvCovTermDate5 = CASE WHEN dedcode_ELIFH = 'ELIFH' THEN Bdmbenstopdate_ELIFH END
        ,drvSupLifeMultiSalFaceAmt = '' --'500'
        ,drvSupLifeFaceAmt = CASE WHEN dedcode_ELIFH = 'ELIFH' and BdmEEAmt_ELIFH is not null  THEN FORMAT(BdmEEAmt_ELIFH,'###########') END
        ,drvSupLifeReqAmt = CASE WHEN dedcode_ELIFH = 'ELIFH' and eoidesiredamt <> 0.00 THEN FORMAT(eoidesiredamt, '###########') END  --FORMAT(eoidesiredamt*100, '#####') END
        ,drvEmplGroupID5 = CASE WHEN dedcode_ELIFH = 'ELIFH'  THEN '1' END
        ,drvEmplClassCode5 = CASE WHEN dedcode_ELIFH = 'ELIFH' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                                 WHEN dedcode_ELIFH = 'ELIFH' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                                WHEN dedcode_ELIFH  = 'ELIFH' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                            END           
        --- ~ADD~
        ,drvCovEffectiveDate6 = CASE WHEN dedcode_ELIFH = 'ELIFH' THEN Bdmbenstartdate_ELIFH END
        ,drvCovTermDate6 = CASE WHEN dedcode_ELIFH = 'ELIFH' THEN Bdmbenstopdate_ELIFH END
        ,drvSupADDFaceAmt = CASE WHEN dedcode_ELIFH = 'ELIFH' and BdmEEAmt_ELIFH is not null  THEN FORMAT(BdmEEAmt_ELIFH,'###########') END
        ,drvSupADDReqAmt = '' 
        ,drvEmplGroupID6 = CASE WHEN dedcode_ELIFH = 'ELIFH' THEN '1' END
        ,drvEmplClassCode6 = CASE WHEN dedcode_ELIFH = 'ELIFH' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                                 WHEN dedcode_ELIFH = 'ELIFH' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                                WHEN dedcode_ELIFH  = 'ELIFH' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                            END
        --- ~SPL~
        ,drvCovEffectiveDate7 = CASE WHEN dedcode_SLIFH = 'SLIFH' THEN Bdmbenstartdate_SLIFH END
        ,drvCovTermDate7 = CASE WHEN dedcode_SLIFH = 'SLIFH'THEN Bdmbenstopdate_SLIFH END
        ,drvSpouseSupLifeFaceAmt = CASE WHEN dedcode_SLIFH = 'SLIFH' THEN FORMAT(BdmEEAmt_SLIFH,'###########') END
        ,drvSpouseSupLifeReqAmt = CASE WHEN dedcode_SLIFH = 'SLIFH' AND eoidesiredamt <> 0.00 THEN FORMAT(eoidesiredamt, '##########') END  --FORMAT(eoidesiredamt*100, '#####') END
        ,drvEmplGroupID7 = CASE WHEN dedcode_SLIFH = 'SLIFH' THEN '1' END
        ,drvEmplClass7 = CASE WHEN dedcode_SLIFH = 'SLIFH' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                             WHEN dedcode_SLIFH = 'SLIFH' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                              WHEN dedcode_SLIFH  = 'SLIFH' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                            END
        --- ~DPL~
        ,drvCovEffectiveDate8 = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN BdmBenStartDate_CLIFH END
        ,drvCovTermDate8 = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN BdmBenStopDate_CLIFH END
        ,drvDepChildBasicLifeFaceAmt = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN FORMAT(BdmEEAmt_CLIFH,'###########') END
        ,drvEmplGroupID8 = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN '1' END
        ,drvEmplClass8 = CASE WHEN dedcode_CLIFH = 'CLIFH' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                             WHEN dedcode_CLIFH = 'CLIFH' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                                WHEN dedcode_CLIFH  = 'CLIFH' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                            END
        --~SAD~--
        ,drvCovEffectiveDate9 = CASE WHEN dedcode_SLIFH = 'SLIFH' THEN Bdmbenstartdate_SLIFH END
        ,drvCovTermDate9 = CASE WHEN dedcode_SLIFH = 'SLIFH'THEN Bdmbenstopdate_SLIFH END
        ,drvSpouseSupADDFaceAmt = CASE WHEN dedcode_SLIFH = 'SLIFH' THEN FORMAT(BdmEEAmt_SLIFH,'###########') END
        ,drvSpouseSupADDReqAmt = '' --if eeddedcode = SLIFH send EedEOIDesiredAmt
                                        --if EedEOIDesiredAmt = 0 or blank and EedNeedEOI = Y send EdhEEBenAmt
                                        --else send eedbenamt
        ,drvEmplGroupID9 = CASE WHEN dedcode_SLIFH = 'SLIFH' THEN '1' END
        ,drvEmplClass9 = CASE WHEN dedcode_SLIFH = 'SLIFH' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                             WHEN dedcode_SLIFH = 'SLIFH' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                              WHEN dedcode_SLIFH  = 'SLIFH' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                            END
        
          --~DCA~--
        ,drvCovEffectiveDate10 = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN BdmBenStartDate_CLIFH END
        ,drvCovTermDate10 = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN BdmBenStopDate_CLIFH END
        ,drvDepChildBasicADDFaceAmt = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN FORMAT(BdmEEAmt_CLIFH,'###########') END
        ,drvEmplGroupID10 = CASE WHEN dedcode_CLIFH = 'CLIFH' THEN '1' END
        ,drvEmplClass10 = CASE WHEN dedcode_CLIFH = 'CLIFH' and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
                             WHEN dedcode_CLIFH = 'CLIFH' and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
                              WHEN dedcode_CLIFH  = 'CLIFH' and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
                            END
          
          --- ~VCI~
        ,drvCovEffectiveDate11 = CASE WHEN dedcode_C in ('Y') THEN Bdmbenstartdate_C END
        ,drvCovTermDate11 = CASE WHEN dedcode_C  in ('Y') THEN Bdmbenstopdate_C END
        ,drvCIBenefitAmount = CASE       WHEN dedcode_CIE1H = 'CIE1H' THEN '10000'             
                                        WHEN dedcode_CIE2H = 'CIE2H' THEN '20000'
                                          WHEN dedcode_CIC1H = 'CIC1H' THEN '10000'
                                          WHEN dedcode_CIC2H = 'CIC2H' THEN '20000'
                                          WHEN dedcode_CIS1H = 'CIS1H' THEN '10000'
                                          WHEN dedcode_CIS2H = 'CIS2H' THEN '20000'
                                        END
        --CASE  WHEN dedcode_C2 in ('Y') and bdmrectype = 'EMP' THEN '20000'
  --                                  WHEN dedcode_C1 in  ('Y') and bdmrectype = 'DEP'  THEN '10000'
  --                                END
        ,drvCoverageTier11 = CASE    
                                    WHEN dedcode_CIE1H = 'CIE1H' THEN '1'
                                    WHEN dedcode_CIE2H = 'CIE2H' THEN '1'
                                    WHEN dedcode_CIC1H = 'CIC1H' THEN '2'
                                    WHEN dedcode_CIC2H = 'CIC2H' THEN '2'
                                    WHEN dedcode_CIS1H = 'CIS1H' THEN '3'
                                    WHEN dedcode_CIS2H = 'CIS2H' THEN '3'
                                    END
        --WHEN dedcode_C in ('Y') and Bdmbenoption_C = 'EE' THEN '1'
  --                                  WHEN dedcode_C in ('Y') and Bdmbenoption_C in ('EEC1', 'EEC', 'EEF', 'EEFD', 'EEDPF') THEN '2'
  --                                  WHEN dedcode_C in ('Y') and Bdmbenoption_C in ('EES', 'EEDP') THEN '3' 
  --                             END
        ,drvPlanNumber11 = CASE WHEN dedcode_C in ('Y') THEN '1' END
        ,drvEmpGroupID11 = CASE WHEN dedcode_C in ('Y') THEN '1' END
        ,drvEmpClass11 = CASE WHEN dedcode_c in ('Y') THEN '1' END
        --CASE WHEN dedcode_C in ('Y') and EecDedGroupCode in ('DIR', 'DIRNE') THEN '1'
  --                           WHEN dedcode_C in ('Y') and EecDedGroupCode in ('CEO', 'CLEVE', 'CLVNE') THEN '3'
  --                              WHEN dedcode_C in ('Y') and EecDedGroupCode not in ('DIR', 'DIRNE','CEO', 'CLEVE', 'CLVNE') then '2'
  --                          END
                   
        --~VCA~--
        ,drvCovEffectiveDate12 = CASE WHEN dedcode_ACCHH in ('ACCHH') THEN BdmBenStartDate_ACCHH
                                      WHEN dedcode_ACCLH in ('ACCLH') THEN BdmBenStartDate_ACCLH
                                    END
        ,drvCovTermDate12 = CASE WHEN dedcode_ACCHH in ('ACCHH') THEN BdmBenStopDate_ACCHH
                                WHEN dedcode_ACCLH in ('ACCLH') THEN BdmBenStopDate_ACCLH
                                END
        ,drvCoverageTier12 = CASE   WHEN dedcode_ACCHH in ('ACCHH') and Bdmbenoption_ACCHH  = 'EE' THEN '1'
                                    WHEN dedcode_ACCHH in ('ACCHH') and Bdmbenoption_ACCHH in ('EEF') THEN '2'
                                    WHEN dedcode_ACCHH in ('ACCHH') and Bdmbenoption_ACCHH in ('EES') THEN '3'
                                    WHEN dedcode_ACCHH in ('ACCHH') and Bdmbenoption_ACCHH in ('EEC') THEN '4'
                                    WHEN dedcode_ACCLH in ('ACCLH') and Bdmbenoption_ACCLH = 'EE' THEN '1'
                                    WHEN dedcode_ACCLH in ('ACCLH') and Bdmbenoption_ACCLH in ('EEF') THEN '2'
                                    WHEN dedcode_ACCLH in ('ACCLH') and Bdmbenoption_ACCLH in ('EES') THEN '3'
                                    WHEN dedcode_ACCLH in ('ACCLH') and Bdmbenoption_ACCLH in ('EEC') THEN '4'
                                    END
        ,drvPlanOption12 = CASE  WHEN dedcode_ACCHH in ('ACCHH') then 'High Plan'
                                 WHEN dedcode_ACCLH in ('ACCLH') then 'Low Plan'
                                END
        ,drvPlanNumber12 = CASE WHEN dedcode_ACCHH in ('ACCHH') THEN '1' 
                                WHEN dedcode_ACCLH in ('ACCLH') THEN '1' 
                                END
        ,drvEmplGroupID12 = CASE    WHEN dedcode_ACCHH in ('ACCHH') THEN '1' 
                                WHEN dedcode_ACCLH in ('ACCLH') THEN '1' 
                                END
        ,drvEmplClass12 = CASE    WHEN dedcode_ACCHH in ('ACCHH') THEN '1' 
                                WHEN dedcode_ACCLH in ('ACCLH') THEN '1' 
                                END

        --~HIP~--
        ,drvCovEffDate13 = CASE     WHEN dedcode_HIHHD in ('HIHHD') THEN Bdmbenstartdate_HIHHD
                                    WHEN dedcode_HILHD = 'HILHD' then Bdmbenstartdate_HILHD 
                                    END
        ,drvCovTermDate13 = CASE        WHEN dedcode_HIHHD in ('HIHHD') THEN Bdmbenstopdate_HIHHD
                                    WHEN dedcode_HILHD = 'HILHD' then Bdmbenstopdate_HILHD 
                                    END
        ,drvCoverageTier13 = CASE    WHEN dedcode_HIHHD in ('HIHHD') and Bdmbenoption_HIHHD = 'EE' THEN '1'
                                    WHEN dedcode_HIHHD in ('HIHHD') and Bdmbenoption_HIHHD in ('EEF') THEN '2'
                                    WHEN dedcode_HIHHD in ('HIHHD') and Bdmbenoption_HIHHD in ('EES') THEN '3'
                                    WHEN dedcode_HIHHD in ('HIHHD') and Bdmbenoption_HIHHD in ('EEC') THEN '4'

                                    WHEN dedcode_HILHD in ('HILHD') and Bdmbenoption_HILHD = 'EE' THEN '1'
                                    WHEN dedcode_HILHD in ('HILHD') and Bdmbenoption_HILHD in ('EEF') THEN '2'
                                    WHEN dedcode_HILHD in ('HILHD') and Bdmbenoption_HILHD in ('EES') THEN '3'
                                    WHEN dedcode_HILHD in ('HILHD') and Bdmbenoption_HILHD in ('EEC') THEN '4'
                                    END
        ,drvPlanOption13 = CASE    WHEN dedcode_HIHHD = 'HIHHD' then 'High Plan'
                                WHEN dedcode_HILHD = 'HILHD' then 'Low Plan'
                                END
        ,drvPlanNumber13 = CASE    WHEN dedcode_HIHHD in ('HIHHD') THEN '1' 
                                WHEN dedcode_HILHD in ('HILHD') THEN '1' 
                                END
        ,drvEmplGroupID13 = CASE    WHEN dedcode_HIHHD in ('HIHHD') THEN '1' 
                                WHEN dedcode_HILHD in ('HILHD') THEN '1' 
                                END
        ,drvEmplClass13 = CASE    WHEN dedcode_HIHHD in ('HIHHD') THEN '1' 
                                WHEN dedcode_HILHD in ('HILHD') THEN '1' 
                                END
    INTO dbo.U_EGOOLTDVOL_drvTbl
    FROM dbo.U_EGOOLTDVOL_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
                   And (eecemplstatus <> 'T' OR (eecemplstatus = 'T' and eectermreason <> 'TRO'
          and EXISTS (Select 1 from dbo.U_EGOOLTDVOL_Audit where audEEID = xEEID and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (
            SELECT BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
                ,MAX(CAST(BdmUSGField1 as money)) as eoidesiredamt
                ,MAX(CASE WHEN BdmDedCode in ('ACCHH') THEN BdmDedCode END) AS dedcode_ACCHH
                ,MAX(CASE WHEN BdmDedCode in ('ACCHH') THEN BdmBenStartDate END) AS BdmBenStartDate_ACCHH
                ,MAX(CASE WHEN BdmDedCode in ('ACCHH') THEN BdmBenStopDate END) AS BdmBenStopDate_ACCHH
                ,MAX(CASE WHEN BdmDedCode in ('ACCHH') THEN BdmEEAmt END) AS BdmEEAmt_ACCHH
                ,MAX(CASE WHEN BdmDedCode in ('ACCHH') THEN BdmBenOption END) AS BdmBenOption_ACCHH
                ,MAX(CASE WHEN BdmDedCode in ('ACCLH') THEN BdmDedCode END) AS dedcode_ACCLH
                ,MAX(CASE WHEN BdmDedCode in ('ACCLH') THEN BdmBenStartDate END) AS BdmBenStartDate_ACCLH
                ,MAX(CASE WHEN BdmDedCode in ('ACCLH') THEN BdmBenStopDate END) AS BdmBenStopDate_ACCLH
                ,MAX(CASE WHEN BdmDedCode in ('ACCLH') THEN BdmEEAmt END) AS BdmEEAmt_ACCLH
                ,MAX(CASE WHEN BdmDedCode in ('ACCLH') THEN BdmBenOption END) AS BdmBenOption_ACCLH
                ,MAX(CASE WHEN BdmDedCode in ('CLIFH') THEN BdmDedCode END) AS dedcode_CLIFH
                ,MAX(CASE WHEN BdmDedCode in ('CLIFH') THEN BdmBenStartDate END) AS BdmBenStartDate_CLIFH
                ,MAX(CASE WHEN BdmDedCode in ('CLIFH') THEN BdmBenStopDate END) AS BdmBenStopDate_CLIFH
                ,MAX(CASE WHEN BdmDedCode in ('CLIFH') THEN BdmEEAmt END) AS BdmEEAmt_CLIFH
                ,MAX(CASE WHEN BdmDedCode in ('CIC1H') THEN BdmDedCode END) AS dedcode_CIC1H
                --,MAX(CASE WHEN BdmDedCode in ('CIC1H') THEN BdmBenStartDate END) AS BdmBenStartDate_CIC1H
                --,MAX(CASE WHEN BdmDedCode in ('CIC1H') THEN BdmBenStopDate END) AS BdmBenStopDate_CIC1H
                --,MAX(CASE WHEN BdmDedCode in ('CIC1H') THEN BdmEEAmt END) AS BdmEEAmt_CIC1H
                ,MAX(CASE WHEN BdmDedCode in ('CIC2H') THEN BdmDedCode END) AS dedcode_CIC2H
                --,MAX(CASE WHEN BdmDedCode in ('CIC2H') THEN BdmBenStartDate END) AS BdmBenStartDate_CIC2H
                --,MAX(CASE WHEN BdmDedCode in ('CIC2H') THEN BdmBenStopDate END) AS BdmBenStopDate_CIC2H
                --,MAX(CASE WHEN BdmDedCode in ('CIC2H') THEN BdmEEAmt END) AS BdmEEAmt_CIC2H
                ,MAX(CASE WHEN BdmDedCode in ('CIS1H') THEN BdmDedCode END) AS dedcode_CIS1H
                --,MAX(CASE WHEN BdmDedCode in ('CIS1H') THEN BdmBenStartDate END) AS BdmBenStartDate_CIS1H
                --,MAX(CASE WHEN BdmDedCode in ('CIS1H') THEN BdmBenStopDate END) AS BdmBenStopDate_CIS1H
                --,MAX(CASE WHEN BdmDedCode in ('CIS1H') THEN BdmEEAmt END) AS BdmEEAmt_CIS1H
                ,MAX(CASE WHEN BdmDedCode in ('CIS2H') THEN BdmDedCode END) AS dedcode_CIS2H
                --,MAX(CASE WHEN BdmDedCode in ('CIS2H') THEN BdmBenStartDate END) AS BdmBenStartDate_CIS2H
                --,MAX(CASE WHEN BdmDedCode in ('CIS2H') THEN BdmBenStopDate END) AS BdmBenStopDate_CIS2H
                --,MAX(CASE WHEN BdmDedCode in ('CIS2H') THEN BdmEEAmt END) AS BdmEEAmt_CIS2H
                ,MAX(CASE WHEN BdmDedCode in ('CIE1H') THEN BdmDedCode END) AS dedcode_CIE1H
                --,MAX(CASE WHEN BdmDedCode in ('CIE1H') THEN BdmBenStartDate END) AS BdmBenStartDate_CIE1H
                --,MAX(CASE WHEN BdmDedCode in ('CIE1H') THEN BdmBenStopDate END) AS BdmBenStopDate_CIE1H
                --,MAX(CASE WHEN BdmDedCode in ('CIE1H') THEN BdmEEAmt END) AS BdmEEAmt_CIE1H
                ,MAX(CASE WHEN BdmDedCode in ('CIE2H') THEN BdmDedCode END) AS dedcode_CIE2H
                --,MAX(CASE WHEN BdmDedCode in ('CIE2H') THEN BdmBenStartDate END) AS BdmBenStartDate_CIE2H
                --,MAX(CASE WHEN BdmDedCode in ('CIE2H') THEN BdmBenStopDate END) AS BdmBenStopDate_CIE2H
                --,MAX(CASE WHEN BdmDedCode in ('CIE2H') THEN BdmEEAmt END) AS BdmEEAmt_CIE2H
                ,MAX(CASE WHEN BdmDedCode in ('CIC1H', 'CIC2H', 'CIS1H', 'CIS2H', 'CIE1H', 'CIE2H') THEN 'Y' END) AS dedcode_C
                ,MAX(CASE WHEN BdmDedCode in ('CIC1H', 'CIC2H', 'CIS1H', 'CIS2H', 'CIE1H', 'CIE2H') THEN BdmBenStartDate END) AS BdmBenStartDate_C
                ,MAX(CASE WHEN BdmDedCode in ('CIC1H', 'CIC2H', 'CIS1H', 'CIS2H', 'CIE1H', 'CIE2H') THEN BdmBenStopDate END) AS BdmBenStopDate_C
                ,MAX(CASE WHEN BdmDedCode in ('CIC1H', 'CIC2H', 'CIS1H', 'CIS2H', 'CIE1H', 'CIE2H') THEN BdmEEAmt END) AS BdmEEAmt_C
                ,MAX(CASE WHEN BdmDedCode in ('CIC1H', 'CIC2H', 'CIS1H', 'CIS2H', 'CIE1H', 'CIE2H') THEN BdmBenOption END) AS BdmBenOption_C
                ,MAX(CASE WHEN BdmDedCode in ('CIC1H', 'CIS1H', 'CIE1H') THEN 'Y' END) AS dedcode_C1
                ,MAX(CASE WHEN BdmDedCode in ('CIC2H', 'CIS2H', 'CIE2H') THEN 'Y' END) AS dedcode_C2
                --,MAX(CASE WHEN BdmDedCode in ('CIC2H', 'CIS2H', 'CIE2H') THEN BdmBenStartDate END) AS BdmBenStartDate_C2
                --,MAX(CASE WHEN BdmDedCode in ('CIC2H', 'CIS2H', 'CIE2H') THEN BdmBenStopDate END) AS BdmBenStopDate_C2
                --,MAX(CASE WHEN BdmDedCode in ('CIC2H', 'CIS2H', 'CIE2H') THEN BdmEEAmt END) AS BdmEEAmt_C2
                ,MAX(CASE WHEN BdmDedCode in ('ELIFH') THEN BdmDedCode END) AS dedcode_ELIFH
                ,MAX(CASE WHEN BdmDedCode in ('ELIFH') THEN BdmBenStartDate END) AS BdmBenStartDate_ELIFH
                ,MAX(CASE WHEN BdmDedCode in ('ELIFH') THEN BdmBenStopDate END) AS BdmBenStopDate_ELIFH
                ,MAX(CASE WHEN BdmDedCode in ('ELIFH') THEN BdmEEAmt END) AS BdmEEAmt_ELIFH
                ,MAX(CASE WHEN BdmDedCode in ('HIHHD') THEN BdmDedCode END) AS dedcode_HIHHD
                ,MAX(CASE WHEN BdmDedCode in ('HIHHD') THEN BdmBenStartDate END) AS BdmBenStartDate_HIHHD
                ,MAX(CASE WHEN BdmDedCode in ('HIHHD') THEN BdmBenStopDate END) AS BdmBenStopDate_HIHHD
                --,MAX(CASE WHEN BdmDedCode in ('HIHHD') THEN BdmEEAmt END) AS BdmEEAmt_HIHHD
                ,MAX(CASE WHEN BdmDedCode in ('HIHHD') THEN BdmBenOption END) AS BdmBenOption_HIHHD
                ,MAX(CASE WHEN BdmDedCode in ('HILHD') THEN BdmDedCode END) AS dedcode_HILHD 
                ,MAX(CASE WHEN BdmDedCode in ('HILHD') THEN BdmBenStartDate END) AS BdmBenStartDate_HILHD
                ,MAX(CASE WHEN BdmDedCode in ('HILHD') THEN BdmBenStopDate END) AS BdmBenStopDate_HILHD
                --,MAX(CASE WHEN BdmDedCode in ('HILHD') THEN BdmEEAmt END) AS BdmEEAmt_HILHD
                ,MAX(CASE WHEN BdmDedCode in ('HILHD') THEN BdmBenOption END) AS BdmBenOption_HILHD
                ,MAX(CASE WHEN BdmDedCode in ('LIFBH', 'LIFCH', 'LIFDH') THEN 'Y' END) AS dedcode_L
                ,MAX(CASE WHEN BdmDedCode in ('LIFBH', 'LIFCH', 'LIFDH') THEN BdmBenStartDate END) AS BdmBenStartDate_L
                ,MAX(CASE WHEN BdmDedCode in ('LIFBH', 'LIFCH', 'LIFDH') THEN BdmBenStopDate END) AS BdmBenStopDate_L
                ,MAX(CASE WHEN BdmDedCode in ('LIFBH', 'LIFCH', 'LIFDH') THEN BdmEECalcRateOrPct END) AS BdmEEAmt_L
                ,MAX(CASE WHEN BdmDedCode in ('LIFBH') THEN BdmDedCode END) AS dedcode_LIFBH 
                --,MAX(CASE WHEN BdmDedCode in ('LIFBH') THEN BdmBenStartDate END) AS BdmBenStartDate_LIFBH  
                --,MAX(CASE WHEN BdmDedCode in ('LIFBH') THEN BdmBenStopDate END) AS BdmBenStopDate_LIFBH  
                ,MAX(CASE WHEN BdmDedCode in ('LIFBH') THEN BdmEEAmt END) AS BdmEEAmt_LIFBH  
                ,MAX(CASE WHEN BdmDedCode in ('LIFCH') THEN BdmDedCode END) AS dedcode_LIFCH 
                --,MAX(CASE WHEN BdmDedCode in ('LIFCH') THEN BdmBenStartDate END) AS BdmBenStartDate_LIFCH  
                --,MAX(CASE WHEN BdmDedCode in ('LIFCH') THEN BdmBenStopDate END) AS BdmBenStopDate_LIFCH  
                ,MAX(CASE WHEN BdmDedCode in ('LIFCH') THEN BdmEEAmt END) AS BdmEEAmt_LIFCH  
                ,MAX(CASE WHEN BdmDedCode in ('LIFDH') THEN BdmDedCode END) AS dedcode_LIFDH
                --,MAX(CASE WHEN BdmDedCode in ('LIFDH') THEN BdmBenStartDate END) AS BdmBenStartDate_LIFDH  
                --,MAX(CASE WHEN BdmDedCode in ('LIFDH') THEN BdmBenStopDate END) AS BdmBenStopDate_LIFDH 
                ,MAX(CASE WHEN BdmDedCode in ('LIFDH') THEN BdmEEAmt END) AS BdmEEAmt_LIFDH 
                ,MAX(CASE WHEN BdmDedCode in ('LTDHD','LTDHC') THEN BdmDedCode END) AS dedcode_LTDHD
                ,MAX(CASE WHEN BdmDedCode in ('LTDHD','LTDHC') THEN BdmBenStartDate END) AS BdmBenStartDate_LTDHD
                ,MAX(CASE WHEN BdmDedCode in ('LTDHD','LTDHC') THEN BdmBenStopDate END) AS BdmBenStopDate_LTDHD
                --,MAX(CASE WHEN BdmDedCode in ('LTDHD') THEN BdmEEAmt END) AS BdmEEAmt_LTDHD
                --,MAX(CASE WHEN BdmDedCode in ('LIFEE') THEN BdmDedCode END) AS dedcode_LIFEE 
                --,MAX(CASE WHEN BdmDedCode in ('LIFEE') THEN BdmBenStartDate END) AS BdmBenStartDate_LIFEE 
                --,MAX(CASE WHEN BdmDedCode in ('LIFEE') THEN BdmBenStopDate END) AS BdmBenStopDate_LIFEE 
                --,MAX(CASE WHEN BdmDedCode in ('LIFEE') THEN BdmEEAmt END) AS BdmEEAmt_LIFEE 
                --,MAX(CASE WHEN BdmDedCode in ('LTD') THEN BdmDedCode END) AS dedcode_LTD
                --,MAX(CASE WHEN BdmDedCode in ('LTD') THEN BdmBenStartDate END) AS BdmBenStartDate_LTD
                --,MAX(CASE WHEN BdmDedCode in ('LTD') THEN BdmBenStopDate END) AS BdmBenStopDate_LTD
                --,MAX(CASE WHEN BdmDedCode in ('LTD') THEN BdmEEAmt END) AS BdmEEAmt_LTD
                ,MAX(CASE WHEN BdmDedCode in ('SLIFH') THEN BdmDedCode END) AS dedcode_SLIFH
                ,MAX(CASE WHEN BdmDedCode in ('SLIFH') THEN BdmBenStartDate END) AS BdmBenStartDate_SLIFH
                ,MAX(CASE WHEN BdmDedCode in ('SLIFH') THEN BdmBenStopDate END) AS BdmBenStopDate_SLIFH
                ,MAX(CAST(BdmUSGField1 as money)) AS BdmEEAmt_SLIFH
               -- ,MAX(CASE WHEN BdmDedCode in ('SLIFH') THEN BdmEEAmt END) AS BdmEEAmt_SLIFH
                ,MAX(CASE WHEN BdmDedCode in ('STDHD') THEN BdmDedCode END) AS dedcode_STDHD
                ,MAX(CASE WHEN BdmDedCode in ('STDHD') THEN BdmBenStartDate END) AS BdmBenStartDate_STDHD
                ,MAX(CASE WHEN BdmDedCode in ('STDHD') THEN BdmBenStopDate END) AS BdmBenStopDate_STDHD
                --,MAX(CASE WHEN BdmDedCode in ('STDHD') THEN BdmEEAmt END) AS BdmEEAmt_STDHD
            FROM dbo.U_dsi_BDM_EGOOLTDVOL WITH (NOLOCK)
            GROUP BY BdmRecType, BdmEEID, BdmCOID, BdmDepRecId, BdmRunId, BdmBenStatus
        ) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    --LEFT JOIN dbo.BenProgTI L1 WITH (NOLOCK)
    --    ON L1.CbpDedCode = dedCode_LTD
    --LEFT JOIN dbo.BenProgTI L2 WITH (NOLOCK) 
    --    ON L2.CbpDedCode = dedCode_LTDHD
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID   
    LEFT JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EGOOLTDVOL_HDR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGOOLTDVOL_HDR_drvTbl;
    SELECT DISTINCT
         drvCustomerCount = '1'
        ,drvFileName = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_GOODWILLESM_UKGPRO_YYYYMMDD.dat' ELSE 'GOODWILLESM_UKGPRO_YYYYMMDD.dat' END 
        ,drvDateCreated = GetDate()
        ,drvVersionNo = '02.00'
    INTO dbo.U_EGOOLTDVOL_HDR_drvTbl
    ;

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EGOOLTDVOL_FTR_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EGOOLTDVOL_FTR_drvTbl;
    SELECT DISTINCT
         drvRecordCount = count(drvEEID)
    INTO dbo.U_EGOOLTDVOL_FTR_drvTbl
    FROM dbo.U_EGOOLTDVOL_drvTbl WITH (NOLOCK)
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEGOOLTDVOL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EGOOLTDVOL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EGOOLTDVOL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202212061'
       ,expStartPerControl     = '202212061'
       ,expLastEndPerControl   = '202212139'
       ,expEndPerControl       = '202212139'
WHERE expFormatCode = 'EGOOLTDVOL';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEGOOLTDVOL_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EGOOLTDVOL_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EGOOLTDVOL' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EGOOLTDVOL'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EGOOLTDVOL'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGOOLTDVOL', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EGOOLTDVOL', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EGOOLTDVOL', 'UseFileName', 'V', 'Y'


-- End ripout