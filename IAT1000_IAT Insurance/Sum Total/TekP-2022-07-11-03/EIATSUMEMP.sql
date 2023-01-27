/**********************************************************************************

EIATSUMEMP: Sum Total Employee

FormatCode:     EIATSUMEMP
Project:        Sum Total Employee
Client ID:      IAT1000
Date/time:      2022-09-19 09:13:14.623
Ripout version: 7.4
Export Type:    Web
Status:         Testing
Environment:    EWP
Server:         EW4WUP4DB03
Database:       ULTIPRO_WPIATIG
Web Filename:   IAT1000_2BDI5_EEHISTORY_EIATSUMEMP_ExportCode_YYYYMMDD_HHMMSS.txt
ExportPath:    
TestPath:      

**********************************************************************************/

SET NOCOUNT ON;

-----------
-- Drop the SavePath table if it exists
-----------

IF OBJECT_ID('U_EIATSUMEMP_SavePath') IS NOT NULL DROP TABLE dbo.U_EIATSUMEMP_SavePath


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

DELETE FROM dbo.U_dsi_RipoutParms WHERE rpoFormatCode = 'EIATSUMEMP'


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
WHERE FormatCode = 'EIATSUMEMP'
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
WHERE ExpFormatCode = 'EIATSUMEMP'


-----------
-- Delete configuration data
-----------

DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'EIATSUMEMP')
DELETE FROM [dbo].[AscExp]                 WHERE ExpFormatCode = 'EIATSUMEMP'
DELETE FROM [dbo].[AscImp]                 WHERE ImpFormatCode = 'EIATSUMEMP'
DELETE FROM [dbo].[AscDefH]                WHERE AdhFormatCode = 'EIATSUMEMP'
DELETE FROM [dbo].[U_dsi_Configuration]    WHERE FormatCode    = 'EIATSUMEMP'
DELETE FROM [dbo].[U_dsi_SQLClauses]       WHERE FormatCode    = 'EIATSUMEMP'
DELETE FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode    = 'EIATSUMEMP'

IF OBJECT_ID('dbo.U_dsi_Translations')    IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations]    WHERE FormatCode = 'EIATSUMEMP'
IF OBJECT_ID('dbo.U_dsi_Translations_v2') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v2] WHERE FormatCode = 'EIATSUMEMP'
IF OBJECT_ID('dbo.U_dsi_Translations_v3') IS NOT NULL DELETE FROM [dbo].[U_dsi_Translations_v3] WHERE FormatCode = 'EIATSUMEMP'


-----------
-- Drop export-specific objects
-----------

IF OBJECT_ID('dsi_vwEIATSUMEMP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIATSUMEMP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIATSUMEMP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATSUMEMP];
GO
IF OBJECT_ID('U_EIATSUMEMP_File') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEMP_File];
GO
IF OBJECT_ID('U_EIATSUMEMP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEMP_EEList];
GO
IF OBJECT_ID('U_EIATSUMEMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEMP_drvTbl];
GO
IF OBJECT_ID('U_EIATSUMEMP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEMP_AuditFields];
GO
IF OBJECT_ID('U_EIATSUMEMP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIATSUMEMP_Audit];
GO

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIATSUMEMP','Sum Total Employee','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N','EIATSUMEMPZ0','N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATSUMEMPZ0','50','H','01','1',NULL,'EMP_NO',NULL,NULL,'"EMP_NO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATSUMEMPZ0','50','H','01','2',NULL,'LAST_NAME',NULL,NULL,'"LAST_NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATSUMEMPZ0','50','H','01','3',NULL,'FIRST_NAME',NULL,NULL,'"FIRST_NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATSUMEMPZ0','50','H','01','4',NULL,'FULL_NAME',NULL,NULL,'"FULL_NAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIATSUMEMPZ0','50','H','01','5',NULL,'EMAIL',NULL,NULL,'"EMAIL"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIATSUMEMPZ0','50','H','01','6',NULL,'MANAGER_NO',NULL,NULL,'"MANAGER_NO"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIATSUMEMPZ0','50','H','01','7',NULL,'LOGIN_USERNAME',NULL,NULL,'"LOGIN_USERNAME"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIATSUMEMPZ0','50','H','01','8',NULL,'LOGIN_ENABLED_FLAG',NULL,NULL,'"LOGIN_ENABLED_FLAG"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIATSUMEMPZ0','50','H','01','9',NULL,'START_DATE',NULL,NULL,'"START_DATE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIATSUMEMPZ0','50','H','01','10',NULL,'END_DATE',NULL,NULL,'"END_DATE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIATSUMEMPZ0','50','H','01','11',NULL,'ACTIVE_FLAG',NULL,NULL,'"ACTIVE_FLAG"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIATSUMEMPZ0','50','H','01','12',NULL,'WORK_STATE_TEXT',NULL,NULL,'"WORK_STATE_TEXT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIATSUMEMPZ0','50','H','01','13',NULL,'LOCALE_TEXT',NULL,NULL,'"LOCALE_TEXT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIATSUMEMPZ0','50','H','01','14',NULL,'TIMEZONE_TEXT',NULL,NULL,'"TIMEZONE_TEXT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIATSUMEMPZ0','50','H','01','15',NULL,'USER_CODE_TEXT',NULL,NULL,'"USER_CODE_TEXT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIATSUMEMPZ0','50','H','01','16',NULL,'USER_STATUS_TEXT',NULL,NULL,'"USER_STATUS_TEXT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIATSUMEMPZ0','50','H','01','17',NULL,'PRIMARY_DOMAIN',NULL,NULL,'"PRIMARY_DOMAIN"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIATSUMEMPZ0','50','H','01','18',NULL,'SECURITY_ROLE',NULL,NULL,'"SECURITY_ROLE"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIATSUMEMPZ0','50','H','01','19',NULL,'MOBILE_ENABLED',NULL,NULL,'"MOBILE_ENABLED"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIATSUMEMPZ0','50','H','01','20',NULL,'EMAIL_FORMAT',NULL,NULL,'"EMAIL_FORMAT"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIATSUMEMPZ0','50','H','01','21',NULL,'OFFICE_LOCATION',NULL,NULL,'"OFFICE_LOCATION"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIATSUMEMPZ0','50','H','01','22',NULL,'JOB_FAMILY',NULL,NULL,'"JOB_FAMILY"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIATSUMEMPZ0','50','H','01','23',NULL,'GRADES',NULL,NULL,'"GRADES"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIATSUMEMPZ0','50','H','01','24',NULL,'EXEMPTION_STATUS',NULL,NULL,'"EXEMPTION_STATUS"','(''DA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIATSUMEMPZ0','50','H','01','25',NULL,'MANAGEMENT_LEVEL',NULL,NULL,'"MANAGEMENT_LEVEL"','(''DA''=''T'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('1','EIATSUMEMPZ0','50','D','10','1',NULL,'EMP_NO',NULL,NULL,'"drvEMP_NO"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('2','EIATSUMEMPZ0','50','D','10','2',NULL,'LAST_NAME',NULL,NULL,'"drvLAST_NAME"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('3','EIATSUMEMPZ0','50','D','10','3',NULL,'FIRST_NAME',NULL,NULL,'"drvFIRST_NAME"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('4','EIATSUMEMPZ0','50','D','10','4',NULL,'FULL_NAME',NULL,NULL,'"drvFULL_NAME"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('5','EIATSUMEMPZ0','50','D','10','5',NULL,'EMAIL',NULL,NULL,'"drvEMAIL"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('6','EIATSUMEMPZ0','50','D','10','6',NULL,'MANAGER_NO',NULL,NULL,'"drvMANAGER_NO"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('7','EIATSUMEMPZ0','50','D','10','7',NULL,'LOGIN_USERNAME',NULL,NULL,'"drvLOGIN_USERNAME"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('8','EIATSUMEMPZ0','50','D','10','8',NULL,'LOGIN_ENABLED_FLAG',NULL,NULL,'"drvLOGIN_ENABLED_FLAG"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('9','EIATSUMEMPZ0','50','D','10','9',NULL,'START_DATE',NULL,NULL,'"drvSTART_DATE"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('10','EIATSUMEMPZ0','50','D','10','10',NULL,'END_DATE',NULL,NULL,'"drvEND_DATE"','(''UD101''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('11','EIATSUMEMPZ0','50','D','10','11',NULL,'ACTIVE_FLAG',NULL,NULL,'"drvACTIVE_FLAG"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('12','EIATSUMEMPZ0','50','D','10','12',NULL,'WORK_STATE_TEXT',NULL,NULL,'"drvWORK_STATE_TEXT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('13','EIATSUMEMPZ0','50','D','10','13',NULL,'LOCALE_TEXT',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('14','EIATSUMEMPZ0','50','D','10','14',NULL,'TIMEZONE_TEXT',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('15','EIATSUMEMPZ0','50','D','10','15',NULL,'USER_CODE_TEXT',NULL,NULL,'"drvUSER_CODE_TEXT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('16','EIATSUMEMPZ0','50','D','10','16',NULL,'USER_STATUS_TEXT',NULL,NULL,'"drvUSER_STATUS_TEXT"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('17','EIATSUMEMPZ0','50','D','10','17',NULL,'PRIMARY_DOMAIN',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('18','EIATSUMEMPZ0','50','D','10','18',NULL,'SECURITY_ROLE',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('19','EIATSUMEMPZ0','50','D','10','19',NULL,'MOBILE_ENABLED',NULL,NULL,'"drvMOBILE_ENABLED"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('20','EIATSUMEMPZ0','50','D','10','20',NULL,'EMAIL_FORMAT',NULL,NULL,'""','(''SS''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('21','EIATSUMEMPZ0','50','D','10','21',NULL,'OFFICE_LOCATION',NULL,NULL,'"drvOFFICE_LOCATION"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('22','EIATSUMEMPZ0','50','D','10','22',NULL,'JOB_FAMILY',NULL,NULL,'"drvJOB_FAMILY"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('23','EIATSUMEMPZ0','50','D','10','23',NULL,'GRADES',NULL,NULL,'"drvGRADES"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('24','EIATSUMEMPZ0','50','D','10','24',NULL,'EXEMPTION_STATUS',NULL,NULL,'"drvEXEMPTION_STATUS"','(''UA''=''T|'')');
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) VALUES ('25','EIATSUMEMPZ0','50','D','10','25',NULL,'MANAGEMENT_LEVEL',NULL,NULL,'"drvMANAGEMENT_LEVEL"','(''UA''=''T'')');

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
/*08*/ DECLARE @FileName varchar(1000) = 'EIATSUMEMP_20220919.txt';
/*09*/ DECLARE @FilePath varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202209159','EMPEXPORT','OEACTIVE',NULL,'EIATSUMEMP',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202209159','EMPEXPORT','OEPASSIVE',NULL,'EIATSUMEMP',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sum Total Employee','202209159','EMPEXPORT','ONDEM_XOE',NULL,'EIATSUMEMP',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sum Total Employee-Sched','202209159','EMPEXPORT','SCH_EIATSU',NULL,'EIATSUMEMP',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FilePath) + LTRIM(RTRIM(@FileName)),NULL,'','',NULL,NULL,NULL,NULL,'Sum Total Employee-Test','202209159','EMPEXPORT','TEST_XOE',NULL,'EIATSUMEMP',NULL,NULL,NULL,'202209159','Sep 15 2022  6:05AM','Sep 15 2022  6:05AM','202209151',NULL,'','','202209151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEMP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEMP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEMP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEMP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEMP','TestPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIATSUMEMP','UseFileName','V','Y');

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATSUMEMP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIATSUMEMP','D10','dbo.U_EIATSUMEMP_drvTbl',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EIATSUMEMP_Audit
-----------

IF OBJECT_ID('U_EIATSUMEMP_Audit') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEMP_Audit] (
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
-- Create table U_EIATSUMEMP_AuditFields
-----------

IF OBJECT_ID('U_EIATSUMEMP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEMP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EIATSUMEMP_drvTbl
-----------

IF OBJECT_ID('U_EIATSUMEMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEMP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvEMP_NO] char(9) NULL,
    [drvLAST_NAME] varchar(100) NULL,
    [drvFIRST_NAME] varchar(100) NULL,
    [drvFULL_NAME] varchar(1) NOT NULL,
    [drvEMAIL] varchar(50) NULL,
    [drvMANAGER_NO] varchar(256) NULL,
    [drvLOGIN_USERNAME] varchar(50) NULL,
    [drvLOGIN_ENABLED_FLAG] varchar(1) NOT NULL,
    [drvSTART_DATE] datetime NULL,
    [drvEND_DATE] datetime NULL,
    [drvACTIVE_FLAG] varchar(1) NOT NULL,
    [drvWORK_STATE_TEXT] varchar(2) NULL,
    [drvUSER_CODE_TEXT] varchar(9) NULL,
    [drvUSER_STATUS_TEXT] varchar(10) NULL,
    [drvMOBILE_ENABLED] varchar(1) NOT NULL,
    [drvOFFICE_LOCATION] char(6) NULL,
    [drvJOB_FAMILY] varchar(150) NULL,
    [drvGRADES] varchar(128) NULL,
    [drvEXEMPTION_STATUS] varchar(10) NULL,
    [drvMANAGEMENT_LEVEL] varchar(12) NOT NULL
);

-----------
-- Create table U_EIATSUMEMP_EEList
-----------

IF OBJECT_ID('U_EIATSUMEMP_EEList') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEMP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EIATSUMEMP_File
-----------

IF OBJECT_ID('U_EIATSUMEMP_File') IS NULL
CREATE TABLE [dbo].[U_EIATSUMEMP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIATSUMEMP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: IAT Insurance Inc

Created By: Marie Thomerson
Business Analyst: Kim Ephraim
Create Date: 09/15/2022
Service Request Number: TekP-2022-07-11-03

Purpose: Sum Total Employee

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2022     SR-2022-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIATSUMEMP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIATSUMEMP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIATSUMEMP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIATSUMEMP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIATSUMEMP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEMP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEMP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEMP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEMP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIATSUMEMP', 'SCH_EIATSU';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = 'EIATSUMEMP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EIATSUMEMP';

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
    DELETE FROM dbo.U_EIATSUMEMP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIATSUMEMP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIATSUMEMP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIATSUMEMP_AuditFields;
    CREATE TABLE dbo.U_EIATSUMEMP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EIATSUMEMP_AuditFields VALUES ('Empcomp','eecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIATSUMEMP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIATSUMEMP_Audit;
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
    INTO dbo.U_EIATSUMEMP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIATSUMEMP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIATSUMEMP_Audit ON dbo.U_EIATSUMEMP_Audit (audEEID,audKey2);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EIATSUMEMP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EIATSUMEMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIATSUMEMP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEMP_NO =EecEmpNo
        ,drvLAST_NAME = EepNameLast
        ,drvFIRST_NAME = EepNameFirst
        ,drvFULL_NAME = ''
        ,drvEMAIL = EepAddressEMail
        ,drvMANAGER_NO = dbo.dsi_fnlib_GetSupervisorField_v2('', EecEEID, 'EmpNo') 
        ,drvLOGIN_USERNAME = EepAddressEMail
        ,drvLOGIN_ENABLED_FLAG = CASE WHEN EecEmplStatus in ( 'A' ,'L') THEN '1' Else '0' END
        ,drvSTART_DATE = eecDateOfLastHire
        ,drvEND_DATE = EecDateOfTermination
        ,drvACTIVE_FLAG = CASE WHEN EecEmplStatus in ( 'A' ,'L') THEN '1' Else '0' END
        ,drvWORK_STATE_TEXT = LEFT(EecStateSUI,2)
        ,drvUSER_CODE_TEXT = CASE    WHEN EecFullTimeOrPartTime = 'F' THEN 'Full-Time' 
                                    WHEN EecFullTimeOrPartTime = 'P' THEN 'Part-Time'
                                    END
        ,drvUSER_STATUS_TEXT = CASE WHEN EecEmplStatus = 'A' THEN 'Active'
                                    WHEN EecEmplStatus =  'L' THEN 'Sick Leave' 
                                    WHEN EecEmplStatus =  'T' THEN 'Inactive' 
                                    END
        ,drvMOBILE_ENABLED = '1'
        ,drvOFFICE_LOCATION = EecLocation
        ,drvJOB_FAMILY = JbcLongDesc
        ,drvGRADES = JHT.NewValue  --MAX(EjhSalaryGrade)
        ,drvEXEMPTION_STATUS = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Exempt'
                                    WHEN EecSalaryOrHourly = 'H' THEN 'Non-exempt'
                                    END
        ,drvMANAGEMENT_LEVEL = CASE
                                    WHEN EecEmpNo IN ('58219','58591','58120','58556','58732','58717','58424','56888','58220','58264','56689','58566','58271','58259','58454','59109','58282','59338') AND EecUDField05 IN ('Y','N') THEN 'MC Member'
                                    WHEN EecEmpNo <> '58219' AND EecUDField05 = 'Y' THEN 'Managers'
                                    WHEN EecEmpNo <> '58219' AND EecUDField05 = 'N' THEN 'Non-Managers'
                                    ELSE 'NULL'
                                    END
    INTO dbo.U_EIATSUMEMP_drvTbl
    FROM dbo.U_EIATSUMEMP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND EecOrgLvl2 not in ('DRG', 'IATF', 'IATKF', 'IATNY', 'IATRWF', 'IATS')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        AND eepnamelast <>'TEST'
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.dsi_fnlib_JobHistoryTable_v2 ('EjhSalaryGrade') JHT
        ON JHT.EEID = EecEEID
        AND JHT.CoID = EecCoID
    ;

------Exclude ORGCODE: DRG, IATF, IATKF, IATNY, IATRWF, IATS; eepnamelast = 'TEST',


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
ALTER VIEW dbo.dsi_vwEIATSUMEMP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIATSUMEMP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out iascDefF
SELECT * FROM dbo.iascDefF
WHERE AdfHeaderSystemID LIKE 'EIATSUMEMP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202209081'
       ,expStartPerControl     = '202209081'
       ,expLastEndPerControl   = '202209159'
       ,expEndPerControl       = '202209159'
WHERE expFormatCode = 'EIATSUMEMP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIATSUMEMP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIATSUMEMP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort

GO


-----------
-- This is a web export; insert a record into the CustomTemplates table to make it visible
-----------

INSERT INTO dbo.CustomTemplates (Engine, EngineCode)
SELECT Engine = AdhEngine, EngineCode = AdhFormatCode
  FROM dbo.AscDefH WITH (NOLOCK)
 WHERE AdhFormatCode = 'EIATSUMEMP' AND AdhEngine = 'EMPEXPORT'
   AND NOT EXISTS (SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine);


-----------
-- Restore target paths from U_dsi_RipoutParms
-----------

UPDATE dbo.U_dsi_Configuration
   SET CfgValue = rpoParmValue02
  FROM dbo.U_dsi_Configuration
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = FormatCode AND rpoParmValue01 = CfgName
 WHERE rpoFormatCode = 'EIATSUMEMP'
   AND rpoParmType = 'Path'


-----------
-- Restore expSystemIDs from U_dsi_RipoutParms
-----------

UPDATE dbo.AscExp
   SET expSystemID = rpoParmValue02
  FROM dbo.AscExp
  JOIN dbo.U_dsi_RipoutParms WITH (NOLOCK) ON rpoFormatCode = expFormatCode AND rpoParmValue01 = expExportCode
 WHERE rpoFormatCode = 'EIATSUMEMP'
   AND rpoParmType = 'expSystemID'


-----------
-- This is a web export; set paths to NULL
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATSUMEMP', 'ExportPath', 'V', NULL
EXEC dbo.dsi_sp_UpdateConfig 'EIATSUMEMP', 'TestPath', 'V', NULL


-----------
-- This is a web export; set UseFileName = Y
-----------

EXEC dbo.dsi_sp_UpdateConfig 'EIATSUMEMP', 'UseFileName', 'V', 'Y'


-- End ripout