/**********************************************************************************

ELSMETEXPO: MetLife Termed Employees/Conversion/Portability

FormatCode:     ELSMETEXPO
Project:        MetLife Termed Employees/Conversion/Portability
Client ID:      LEN1002
Date/time:      2023-04-14 16:44:57.227
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    NWP
Server:         NW1WUP2DB03
Database:       ULTIPRO_WPLSINC
Web Filename:   LEN1002_AB8K5_EEHISTORY_ELSMETEXPO_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_ELSMETEXPO_SavePath') IS NOT NULL DROP TABLE dbo.U_ELSMETEXPO_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'ELSMETEXPO'


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
WHERE FormatCode = 'ELSMETEXPO'
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
WHERE ExpFormatCode = 'ELSMETEXPO'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ELSMETEXPO')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'ELSMETEXPO'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'ELSMETEXPO'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'ELSMETEXPO'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'ELSMETEXPO'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'ELSMETEXPO'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'ELSMETEXPO'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'ELSMETEXPO'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'ELSMETEXPO'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'ELSMETEXPO'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwELSMETEXPO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELSMETEXPO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELSMETEXPO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELSMETEXPO];
GO
IF OBJECT_ID('U_ELSMETEXPO_File') IS NOT NULL DROP TABLE [dbo].[U_ELSMETEXPO_File];
GO
IF OBJECT_ID('U_ELSMETEXPO_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELSMETEXPO_EEList];
GO
IF OBJECT_ID('U_ELSMETEXPO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ELSMETEXPO_drvTbl];
GO
IF OBJECT_ID('U_ELSMETEXPO_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELSMETEXPO_DedList];
GO
IF OBJECT_ID('U_ELSMETEXPO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELSMETEXPO_AuditFields];
GO
IF OBJECT_ID('U_ELSMETEXPO_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELSMETEXPO_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ELSMETEXPO') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ELSMETEXPO];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELSMETEXPO','MetLife Termed Employees/Conversion/Portability','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','ELSMETEXPOZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELSMETEXPOZ0','50','H','01','1',NULL,'LAST',NULL,NULL,'"LAST"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELSMETEXPOZ0','50','H','01','2',NULL,'FIRST',NULL,NULL,'"FIRST"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELSMETEXPOZ0','50','H','01','3',NULL,'ADDRESS',NULL,NULL,'"ADDRESS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELSMETEXPOZ0','50','H','01','4',NULL,'CITY',NULL,NULL,'"CITY"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELSMETEXPOZ0','50','H','01','5',NULL,'ST',NULL,NULL,'"ST"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELSMETEXPOZ0','50','H','01','6',NULL,'ZIP',NULL,NULL,'"ZIP"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELSMETEXPOZ0','50','H','01','7',NULL,'PHONE',NULL,NULL,'"PHONE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELSMETEXPOZ0','50','H','01','8',NULL,'COUNTRY CODE',NULL,NULL,'"COUNTRY CODE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELSMETEXPOZ0','50','H','01','9',NULL,'BASIC',NULL,NULL,'"BASIC"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELSMETEXPOZ0','50','H','01','10',NULL,'BASIC PORT Y/N',NULL,NULL,'"BASIC PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELSMETEXPOZ0','50','H','01','11',NULL,'OPTIONAL',NULL,NULL,'"OPTIONAL"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELSMETEXPOZ0','50','H','01','12',NULL,'OPTIONAL PORT Y/N',NULL,NULL,'"OPTIONAL PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELSMETEXPOZ0','50','H','01','13',NULL,'SPOUSE',NULL,NULL,'"SPOUSE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELSMETEXPOZ0','50','H','01','14',NULL,'SPOUSE PORT Y/N',NULL,NULL,'"SPOUSE PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELSMETEXPOZ0','50','H','01','15',NULL,'CHILD',NULL,NULL,'"CHILD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELSMETEXPOZ0','50','H','01','16',NULL,'CHILD PORT Y/N',NULL,NULL,'"CHILD PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELSMETEXPOZ0','50','H','01','17',NULL,'PADD',NULL,NULL,'"PADD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELSMETEXPOZ0','50','H','01','18',NULL,'PADD PORT Y/N',NULL,NULL,'"PADD PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELSMETEXPOZ0','50','H','01','19',NULL,'OADD',NULL,NULL,'"OADD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELSMETEXPOZ0','50','H','01','20',NULL,'OADD PORT Y/N',NULL,NULL,'"OADD PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELSMETEXPOZ0','50','H','01','21',NULL,'SO_ADD',NULL,NULL,'"SO_ADD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELSMETEXPOZ0','50','H','01','22',NULL,'SO_ADD PORT Y/N',NULL,NULL,'"SO_ADD PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELSMETEXPOZ0','50','H','01','23',NULL,'CO_ADD',NULL,NULL,'"CO_ADD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELSMETEXPOZ0','50','H','01','24',NULL,'CO_ADD PORT Y/N',NULL,NULL,'"CO_ADD PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELSMETEXPOZ0','50','H','01','25',NULL,'VADD',NULL,NULL,'"VADD"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELSMETEXPOZ0','50','H','01','26',NULL,'VADD PORT Y/N',NULL,NULL,'"VADD PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELSMETEXPOZ0','50','H','01','27',NULL,'VADDFAM',NULL,NULL,'"VADDFAM"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELSMETEXPOZ0','50','H','01','28',NULL,'VADDFAM PORT Y/N',NULL,NULL,'"VADDFAM PORT Y/N"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELSMETEXPOZ0','50','H','01','29',NULL,'DOB',NULL,NULL,'"DOB"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELSMETEXPOZ0','50','H','01','30',NULL,'BENEFIT END DATE',NULL,NULL,'"BENEFIT END DATE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELSMETEXPOZ0','50','H','01','31',NULL,'STATUS',NULL,NULL,'"STATUS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELSMETEXPOZ0','50','H','01','32',NULL,'Comments',NULL,NULL,'"Comments"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','ELSMETEXPOZ0','30','D','10','1',NULL,'LAST',NULL,NULL,'"drvLAST"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','ELSMETEXPOZ0','30','D','10','2',NULL,'FIRST',NULL,NULL,'"drvFIRST"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','ELSMETEXPOZ0','50','D','10','3',NULL,'ADDRESS',NULL,NULL,'"drvADDRESS"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','ELSMETEXPOZ0','21','D','10','4',NULL,'CITY',NULL,NULL,'"drvCITY"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','ELSMETEXPOZ0','2','D','10','5',NULL,'ST',NULL,NULL,'"drvST"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','ELSMETEXPOZ0','5','D','10','6',NULL,'ZIP',NULL,NULL,'"drvZIP"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','ELSMETEXPOZ0','10','D','10','7',NULL,'PHONE',NULL,NULL,'"drvPHONE"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','ELSMETEXPOZ0','2','D','10','8',NULL,'COUNTRY CODE',NULL,NULL,'"drvCOUNTRYCODE"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','ELSMETEXPOZ0','10','D','10','9',NULL,'BASIC',NULL,NULL,'"drvBASIC"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','ELSMETEXPOZ0','1','D','10','10',NULL,'BASIC PORT Y/N',NULL,NULL,'"drvBASICPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','ELSMETEXPOZ0','10','D','10','11',NULL,'OPTIONAL',NULL,NULL,'"drvOPTIONAL"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','ELSMETEXPOZ0','1','D','10','12',NULL,'OPTIONAL PORT Y/N',NULL,NULL,'"drvOPTIONALPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','ELSMETEXPOZ0','10','D','10','13',NULL,'SPOUSE',NULL,NULL,'"drvSPOUSE"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','ELSMETEXPOZ0','1','D','10','14',NULL,'SPOUSE PORT Y/N',NULL,NULL,'"drvSPOUSEPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','ELSMETEXPOZ0','10','D','10','15',NULL,'CHILD',NULL,NULL,'"drvCHILD"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','ELSMETEXPOZ0','1','D','10','16',NULL,'CHILD PORT Y/N',NULL,NULL,'"drvCHILDPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','ELSMETEXPOZ0','7','D','10','17',NULL,'PADD',NULL,NULL,'"drvPADD"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','ELSMETEXPOZ0','1','D','10','18',NULL,'PADD PORT Y/N',NULL,NULL,'"drvPADDPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','ELSMETEXPOZ0','7','D','10','19',NULL,'OADD',NULL,NULL,'"drvOADD"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','ELSMETEXPOZ0','1','D','10','20',NULL,'OADD PORT Y/N',NULL,NULL,'"drvOADDPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','ELSMETEXPOZ0','7','D','10','21',NULL,'SO_ADD',NULL,NULL,'"drvSO_ADD"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','ELSMETEXPOZ0','1','D','10','22',NULL,'SO_ADD PORT Y/N',NULL,NULL,'"drvSO_ADDPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','ELSMETEXPOZ0','7','D','10','23',NULL,'CO_ADD',NULL,NULL,'"drvCO_ADD"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','ELSMETEXPOZ0','1','D','10','24',NULL,'CO_ADD PORT Y/N',NULL,NULL,'"drvCO_ADDPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','ELSMETEXPOZ0','7','D','10','25',NULL,'VADD',NULL,NULL,'"drvVADD"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('26','ELSMETEXPOZ0','1','D','10','26',NULL,'VADD PORT Y/N',NULL,NULL,'"drvVADDPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('27','ELSMETEXPOZ0','7','D','10','27',NULL,'VADDFAM',NULL,NULL,'"drvVADDFAM"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('28','ELSMETEXPOZ0','1','D','10','28',NULL,'VADDFAM PORT Y/N',NULL,NULL,'"drvVADDFAMPORT"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('29','ELSMETEXPOZ0','10','D','10','29',NULL,'DOB',NULL,NULL,'"drvDOB"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('30','ELSMETEXPOZ0','10','D','10','30',NULL,'BENEFIT END DATE',NULL,NULL,'"drvBENEFITENDDATE"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('31','ELSMETEXPOZ0','3','D','10','31',NULL,'STATUS',NULL,NULL,'"drvSTATUS"','(''UA''=''F|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('32','ELSMETEXPOZ0','20','D','10','32',NULL,'Comments',NULL,NULL,'"drvComments"','(''UA''=''F'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'ELSMETEXPO_20230414.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife Termed Employees/Conve','202301199','EMPEXPORT','ONDEM_XOE',NULL,'ELSMETEXPO',NULL,NULL,NULL,'202301199','Jan 19 2023  1:22PM','Jan 19 2023  1:22PM','202301191',NULL,'','','202301191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MetLife Termed Employees-Sched','202301199','EMPEXPORT','SCH_ELSMET',NULL,'ELSMETEXPO',NULL,NULL,NULL,'202301199','Jan 19 2023  1:22PM','Jan 19 2023  1:22PM','202301191',NULL,'','','202301191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'MetLife Termed Employees-Test','202301199','EMPEXPORT','TEST_XOE',NULL,'ELSMETEXPO',NULL,NULL,NULL,'202301199','Jan 19 2023  1:22PM','Jan 19 2023  1:22PM','202301191',NULL,'','','202301191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELSMETEXPO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELSMETEXPO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELSMETEXPO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELSMETEXPO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELSMETEXPO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELSMETEXPO','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELSMETEXPO','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELSMETEXPO','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELSMETEXPO','D10','dbo.U_ELSMETEXPO_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_dsi_BDM_ELSMETEXPO
-----------

IF OBJECT_ID('U_dsi_BDM_ELSMETEXPO') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ELSMETEXPO] (
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
-- Create table U_ELSMETEXPO_Audit
-----------

IF OBJECT_ID('U_ELSMETEXPO_Audit') IS NULL
CREATE TABLE [dbo].[U_ELSMETEXPO_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] nvarchar(2000) NULL,
    [audNewValue] nvarchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audTerm] varchar(1) NOT NULL
);

-----------
-- Create table U_ELSMETEXPO_AuditFields
-----------

IF OBJECT_ID('U_ELSMETEXPO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELSMETEXPO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_ELSMETEXPO_DedList
-----------

IF OBJECT_ID('U_ELSMETEXPO_DedList') IS NULL
CREATE TABLE [dbo].[U_ELSMETEXPO_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);

-----------
-- Create table U_ELSMETEXPO_drvTbl
-----------

IF OBJECT_ID('U_ELSMETEXPO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ELSMETEXPO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvLAST] varchar(100) NULL,
    [drvFIRST] varchar(100) NULL,
    [drvADDRESS] varchar(511) NULL,
    [drvCITY] varchar(255) NULL,
    [drvST] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvPHONE] varchar(50) NULL,
    [drvCOUNTRYCODE] varchar(2) NULL,
    [drvBASIC] nvarchar(4000) NULL,
    [drvBASICPORT] varchar(1) NOT NULL,
    [drvOPTIONAL] nvarchar(4000) NULL,
    [drvOPTIONALPORT] varchar(1) NOT NULL,
    [drvSPOUSE] nvarchar(4000) NULL,
    [drvSPOUSEPORT] varchar(1) NOT NULL,
    [drvCHILD] nvarchar(4000) NULL,
    [drvCHILDPORT] varchar(1) NOT NULL,
    [drvPADD] nvarchar(4000) NULL,
    [drvPADDPORT] varchar(1) NULL,
    [drvOADD] nvarchar(4000) NULL,
    [drvOADDPORT] varchar(1) NULL,
    [drvSO_ADD] nvarchar(4000) NULL,
    [drvSO_ADDPORT] varchar(1) NULL,
    [drvCO_ADD] nvarchar(4000) NULL,
    [drvCO_ADDPORT] varchar(1) NULL,
    [drvVADD] varchar(1) NOT NULL,
    [drvVADDPORT] varchar(1) NOT NULL,
    [drvVADDFAM] varchar(1) NOT NULL,
    [drvVADDFAMPORT] varchar(1) NOT NULL,
    [drvDOB] varchar(10) NULL,
    [drvBENEFITENDDATE] varchar(10) NULL,
    [drvSTATUS] char(1) NULL,
    [drvComments] varchar(50) NULL
);

-----------
-- Create table U_ELSMETEXPO_EEList
-----------

IF OBJECT_ID('U_ELSMETEXPO_EEList') IS NULL
CREATE TABLE [dbo].[U_ELSMETEXPO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_ELSMETEXPO_File
-----------

IF OBJECT_ID('U_ELSMETEXPO_File') IS NULL
CREATE TABLE [dbo].[U_ELSMETEXPO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELSMETEXPO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Lending Solutions, Inc

Created By: Marie Waters
Business Analyst: Katherine Ricca
Create Date: 01/19/2023
Service Request Number: TekP-2022-10-04-02

Purpose: MetLife Termed Employees/Conversion/Portability

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2023     SR-2023-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELSMETEXPO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELSMETEXPO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELSMETEXPO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELSMETEXPO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELSMETEXPO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELSMETEXPO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELSMETEXPO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELSMETEXPO', 'SCH_ELSMET';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ELSMETEXPO';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'ELSMETEXPO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELSMETEXPO';

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
    DELETE FROM dbo.U_ELSMETEXPO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELSMETEXPO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ELSMETEXPO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELSMETEXPO_AuditFields;
    CREATE TABLE dbo.U_ELSMETEXPO_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELSMETEXPO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELSMETEXPO_Audit;
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
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ELSMETEXPO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ELSMETEXPO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN dateadd(day,-30, @StartDate) AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ELSMETEXPO_Audit ON dbo.U_ELSMETEXPO_Audit (audEEID,audCOID);

    ----================
    ---- Changes Only
    ----================
    --DELETE FROM dbo.U_ELSMETEXPO_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELSMETEXPO_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTL,GLIFX,GLIFM,GLIFE,GLIFC,GLIFS,LIFEC,LIFEE,LIFES';

    IF OBJECT_ID('U_ELSMETEXPO_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELSMETEXPO_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELSMETEXPO_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
   -- EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELSMETEXPO_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ELSMETEXPO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ELSMETEXPO_drvTbl;
      SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvLAST = EepNameLast
        ,drvFIRST = EepNameFirst
        ,drvADDRESS = eepaddressline1 + ' ' + eepaddressline2
        ,drvCITY = EepAddressCity
        ,drvST = eepaddressstate
        ,drvZIP = eepaddresszipcode
        ,drvPHONE = Eepphonehomenumber
        ,drvCOUNTRYCODE = LEFT(EepAddressCountry, 2)
        ,drvBASIC = CASE WHEN EecEmplStatus = 'T' and GIFE_DedCode IS NOT NULL and GLIFE_EEAmt <> 0.00 THEN FORMAT(GLIFE_EEAmt, '0.00')  END
        ,drvBASICPORT = CASE WHEN EecEmplStatus = 'T' and GIFE_DedCode IS NOT NULL THEN 'Y' ELSE 'N' END
        ,drvOPTIONAL = CASE WHEN EecEmplStatus = 'T' and LIFEE_DedCode IS  NOT NULL and LIFEE_BdmEEAmt <> 0.00 THEN FORMAT(LIFEE_BdmEEAmt,' 0.00') END
        ,drvOPTIONALPORT = CASE WHEN EecEmplStatus = 'T' and LIFEE_DedCode IS  NOT NULL and ISNULL(LIFEE_BdmEEAmt, '0.00') <> '0.00' THEN 'Y' ELSE 'N' END
        ,drvSPOUSE = CASE WHEN EecEmplStatus = 'T' and LIFES_DedCode IS  NOT NULL and LIFES_BdmEEAmt <> 0.00  THEN Format(LIFES_BdmEEAmt, '0.00') END
        ,drvSPOUSEPORT = CASE WHEN EecEmplStatus = 'T' and LIFES_DedCode IS  NOT NULL  and ISNULL(LIFES_BdmEEAmt, '0.00') <> 0.00 THEN 'Y' ELSE 'N' END
        ,drvCHILD = CASE WHEN EecEmplStatus = 'T' and LIFEC_DedCode IS  NOT NULL  and LIFEC_BdmEEAmt <> 0.00 THEN Format(LIFEC_BdmEEAmt, '0.00') END
        ,drvCHILDPORT = CASE WHEN EecEmplStatus = 'T' and LIFEC_DedCode IS  NOT NULL and LIFEC_BdmEEAmt <> 0.00  THEN 'Y' ELSE 'N' END
        ,drvPADD = CASE WHEN EecEmplStatus = 'T' and   GIFE_DedCode IS NOT NULL and GLIFE_EEAmt <> 0.00 THEN FORMAT(GLIFE_EEAmt, '0.00')  END
        ,drvPADDPORT = CASE WHEN EecEmplStatus = 'T' and   GIFE_DedCode IS NOT NULL THEN  'Y'  END
        ,drvOADD = CASE WHEN EecEmplStatus = 'T' and LIFEE_DedCode IS  NOT NULL and LIFEE_BdmEEAmt <> 0.00 THEN FORMAT(LIFEE_BdmEEAmt,' 0.00') END
        ,drvOADDPORT = CASE WHEN EecEmplStatus = 'T' and LIFEE_DedCode IS  NOT NULL and ISNULL(LIFEE_BdmEEAmt, '0.00') <> '0.00' THEN 'Y'  END
        ,drvSO_ADD = CASE WHEN EecEmplStatus = 'T' and LIFES_DedCode IS  NOT NULL and LIFES_BdmEEAmt <> 0.00  THEN Format(LIFES_BdmEEAmt, '0.00') END
        ,drvSO_ADDPORT = CASE WHEN EecEmplStatus = 'T' and LIFES_DedCode IS  NOT NULL  and ISNULL(LIFES_BdmEEAmt, '0.00') <> 0.00 THEN 'Y' END
        ,drvCO_ADD = CASE WHEN EecEmplStatus = 'T' and LIFEC_DedCode IS  NOT NULL  and LIFEC_BdmEEAmt <> 0.00 THEN Format(LIFEC_BdmEEAmt, '0.00') END
        ,drvCO_ADDPORT = CASE WHEN EecEmplStatus = 'T' and LIFEC_DedCode IS  NOT NULL and LIFEC_BdmEEAmt <> 0.00  THEN 'Y' END
        ,drvVADD = ''
        ,drvVADDPORT = ''
        ,drvVADDFAM = ''
        ,drvVADDFAMPORT = ''
        ,drvDOB = CONVERT(VARCHAR(10),EepDateofBirth,101)
        ,drvBENEFITENDDATE =  EedBenStopDate 
        ,drvSTATUS = EecEmplStatus 
        ,drvComments = EepAddressEmailAlternate
    INTO dbo.U_ELSMETEXPO_drvTbl
    FROM dbo.U_ELSMETEXPO_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN (SELECT BdmEEID, BdmCOID
                    ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN EedDedCode END) AS LIFEE_DedCode 
                    ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN EedDedCode END) AS LIFES_DedCode 
                    ,MAX(CASE WHEN EedDedCode = 'LIFEC' THEN EedDedCode END) AS LIFEC_DedCode 
                    ,MAX(CASE WHEN EedDedCode in ('GTL', 'GLIFX', 'GLIFM', 'GLIFE', 'GLIFC', 'GLIFS') THEN EedDedCode END) AS GIFE_DedCode
                    ,MAX(CASE WHEN EedDedCode in ('GTL', 'GLIFX', 'GLIFM', 'GLIFE', 'GLIFC', 'GLIFS', 'LIFEC', 'LIFEE', 'LIFES') THEN EedDedCode END )  EedDedCode
                    ,MAX(CASE WHEN EedDedCode in ('GTL', 'GLIFX', 'GLIFM', 'GLIFE', 'GLIFC', 'GLIFS') THEN cast(EedBenAmt as money) END)  AS GLIFE_EEAmt
                    ,MAX(CASE WHEN EedDedCode in ('GTL', 'GLIFX', 'GLIFM', 'GLIFE', 'GLIFC', 'GLIFS', 'LIFEC', 'LIFEE', 'LIFES') THEN CONVERT(VARCHAR(10),EedBenStopDate,101) END) AS EedBenStopDate
                      ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN cast(LTrim(RTrim(EedBenAmt)) as money)  END) AS LIFEE_BdmEEAmt
                    ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN cast(LTrim(RTrim(EedBenAmt)) as money)  END) AS LIFES_BdmEEAmt
                    ,MAX(CASE WHEN EedDedCode = 'LIFEC' THEN cast(EedBenAmt as money) END) AS LIFEC_BdmEEAmt
                    FROM dbo.U_dsi_BDM_ELSMETEXPO WITH (NOLOCK)
                    JOIN dbo.empded WITH (NOLOCK)
                    ON bdmeeid = EedEEID
                    AND bdmcoid = EedCOID
                    AND EedDedCode = EedDedcode 
                    and EedBenStopDate between @Startdate and @EndDate
                    Where BdmBenstatus NOT IN ('W', 'C')
                 GROUP BY BdmEEID, BdmCOID) BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_ELSMETEXPO_Audit WITH (NOLOCK)
        ON audEEID = xEEID
        AND audCOID = xCOID
    WHERE  EecEmplStatus IN ( 'T', 'R')
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
ALTER VIEW dbo.dsi_vwELSMETEXPO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELSMETEXPO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'ELSMETEXPO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202301011'
       ,expStartPerControl     = '202301011'
       ,expLastEndPerControl   = '202301199'
       ,expEndPerControl       = '202301199'
WHERE expFormatCode = 'ELSMETEXPO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELSMETEXPO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELSMETEXPO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'ELSMETEXPO' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'ELSMETEXPO'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'ELSMETEXPO'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELSMETEXPO', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'ELSMETEXPO', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'ELSMETEXPO', 'UseFileName', 'V', 'Y'


-- End ripout