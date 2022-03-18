/**********************************************************************************

Project details

Date/time:     2021-05-20 14:55:26.443
Client ID:     APO1003
FormatCode:    EEPRNAPO
Project:       Empyrean Export
Export Type:   Back Office
Status:        Production
Environment:   EZ33
Server:        EZ3D023DB01
Database:      ULTIPRO_APGRP
ExportPath:    \\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\
TestPath:      \\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\

Git Filename and Command
-------------------
C:\GDIToolsGIT\EEPRNAPO_Deploy.sql
./AddToGit.sh -s SR-2018-00202319 -a APO1003 -f EEPRNAPO

**********************************************************************************/

SET NOCOUNT ON;
IF OBJECT_ID('U_EEPRNAPO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EEPRNAPO_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EEPRNAPO' AND CfgName LIKE '%Path';

-----------
-- Drop current objects and delete configuration data
-----------

IF OBJECT_ID('dsi_vwEEPRNAPO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEEPRNAPO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEPRNAPO_051821') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEPRNAPO_051821];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EEPRNAPO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEPRNAPO];
GO
IF OBJECT_ID('U_EEPRNAPO_SECJOB') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_SECJOB];
GO
IF OBJECT_ID('U_EEPRNAPO_LastSent') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_LastSent];
GO
IF OBJECT_ID('U_EEPRNAPO_HeaderH01') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_HeaderH01];
GO
IF OBJECT_ID('U_EEPRNAPO_File') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_File];
GO
IF OBJECT_ID('U_EEPRNAPO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_EEList];
GO
IF OBJECT_ID('U_EEPRNAPO_drvTblD10') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_drvTblD10];
GO
IF OBJECT_ID('U_EEPRNAPO_audPivotTable') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_audPivotTable];
GO
IF OBJECT_ID('U_EEPRNAPO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_AuditFields];
GO
IF OBJECT_ID('U_EEPRNAPO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EEPRNAPO';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EEPRNAPO';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EEPRNAPO';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EEPRNAPO';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EEPRNAPO';

-----------
-- AscDefH inserts
-----------

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EEPRNAPO','Empyrean Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EEPRNAPO00Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');

-----------
-- AscDefF inserts
-----------

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','1','(''DA''=''TT'')','EEPRNAPO00Z0','50','H','01','1',NULL,'LINE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFILEPRODUCTIONDATE"','2','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','H','01','3',NULL,'FILE PRODUCTION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"02"','1','(''DA''=''TT'')','EEPRNAPO00Z0','50','D','10','1',NULL,'LINE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"UOPX"','2','(''DA''=''TT'')','EEPRNAPO00Z0','50','D','10','3',NULL,'EMPLOYER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEESSN"','3','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','13',NULL,'EMPLOYEE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEEID"','4','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','22',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLASTNAME"','5','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','32',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFIRSTNAME"','6','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','62',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','92',NULL,'MIDDLE NAME  INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','122',NULL,'SUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBIRTHDATE"','9','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','132',NULL,'BIRTHDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGENDER"','10','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','140',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESS1"','11','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','141',NULL,'ADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESS2"','12','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','181',NULL,'ADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','221',NULL,'ADDRESS3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITY"','14','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','261',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTATE"','15','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','311',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPOSTAL"','16','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','313',NULL,'POSTAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOUNTRY"','17','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','323',NULL,'COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDRESSEFFDATE"','18','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','373',NULL,'ADDRESS EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHOMEPHONE"','19','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','381',NULL,'HOME PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWORKPHONE"','20','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','391',NULL,'WORK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobilePhone"','21','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','401',NULL,'MOBILE PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWORKEMAILADDRESS"','22','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','411',NULL,'WORK EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','611',NULL,'PERSONAL EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvORIGINALHIREDATE"','24','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','811',NULL,'ORIGINAL HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLATESTHIREDATE"','25','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','819',NULL,'LATEST HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYMENTSTATUS"','26','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','827',NULL,'EMPLOYMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYMENTSTATUSEFFDATE"','27','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','828',NULL,'EMPLOYMENT STATUS EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEATHDATEATTR"','28','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','836',NULL,'DEATH DATE ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTERMINATIONDATEATTR"','29','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','844',NULL,'TERMINATION DATE ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURRENTANNUALSALARYATTR"','30','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','852',NULL,'CURRENT ANNUAL SALARY ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCURRENTSALARYATTREFFDATE"','31','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','882',NULL,'CURRENT SALARY ATTR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAYFREQUENCYATTR"','32','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','890',NULL,'PAY FREQUENCY ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPAYFREQUENCYATTREFFDATE"','33','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','894',NULL,'PAY FREQUENCY ATTR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEREINATTR"','34','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','902',NULL,'EMPLOYER EIN ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEINATTREFFDATE"','35','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','911',NULL,'EIN ATTR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFTPTATTR"','36','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','919',NULL,'FTPT ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFTPTATTREFFDATE"','37','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','920',NULL,'FTPT ATTR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','928',NULL,'ACTION CODE ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','958',NULL,'ACTION CODE ATTR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonCodeAttr"','40','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','966',NULL,'REASON CODE ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonEffDate"','41','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','996',NULL,'REASON ATTR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','1004',NULL,'RETIREMENT DATE ATTR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFTPTINDICATOR"','43','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1012',NULL,'FTPT INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFTPTINDICATOREFFDATE"','44','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1013',NULL,'FTPT INDICATOR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEECLASS"','45','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1021',NULL,'EMPLOYEE CLASS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEECLASSEFFDATE"','46','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1051',NULL,'EMPLOYEE CLASS EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREGTEMP"','47','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1059',NULL,'REGTEMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREGTEMPEFFDATE"','48','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1060',NULL,'REGTEMP EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJOBCODE"','49','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1068',NULL,'JOB CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJOBCODEEFFDATE"','50','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1078',NULL,'JOB CODE EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJOBTITLE"','51','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1086',NULL,'JOB TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJOBTITLEEFFDATE"','52','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1116',NULL,'JOB TITLE EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWORKLOCATION"','53','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1124',NULL,'WORK LOCATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWORKLOCATIONEFFDATE"','54','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1134',NULL,'WORK LOCATION EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTANDARDHOURS"','55','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1142',NULL,'STANDARD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTANDARDHOURSEFFDATE"','56','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1147',NULL,'STANDARD HOURS EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOMPANYCODE"','57','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1155',NULL,'COMPANY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOMPANYCODEEFFDATE"','58','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1185',NULL,'COMPANY CODE EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSALARYGRADE"','59','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1193',NULL,'SALARY GRADE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSALARYGRADEEFFDATE"','60','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1203',NULL,'SALARY GRADE EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLEAVEREASON"','61','(''UA''=''TT'')','EEPRNAPO00Z0','50','D','10','1211',NULL,'LEAVE REASON',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLEAVEREASONEFFDATE"','62','(''UDMDY''=''TT'')','EEPRNAPO00Z0','50','D','10','1217',NULL,'LEAVE REASON EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','1225',NULL,'ACQUISITION INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','1231',NULL,'ACQUISITION INDICATOR EFF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','1239',NULL,'CREDITED SERVICE VALUE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''SS''=''TT'')','EEPRNAPO00Z0','50','D','10','1245',NULL,'CREDITED SERVICE EFF DATE',NULL,NULL);

-----------
-- AscExp inserts
-----------

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Export','201810229','EMPEXPORT','ONDEMAND','Oct 22 2018  2:16PM','EEPRNAPO',NULL,NULL,NULL,'201810229','Oct 22 2018 12:00AM','Dec 30 1899 12:00AM','201810151','17344','','','201810151',dbo.fn_GetTimedKey(),NULL,'usgsmartinez',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Export','202105129','EMPEXPORT','SCHEDULED','May 12 2021 10:00PM','EEPRNAPO',NULL,NULL,NULL,'202105129','Aug 19 2018  5:45PM','Aug 19 2018  5:45PM','202105051',NULL,'','','202105051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Empyrean Export','202105189','EMPEXPORT','TEST','Sep  5 2019  7:40PM','EEPRNAPO',NULL,NULL,NULL,'202105181','Sep  5 2019 12:00AM','Dec 30 1899 12:00AM','202105041','12980','','','202105049',dbo.fn_GetTimedKey(),NULL,'PAMBROSE',NULL);

-----------
-- AscImp inserts
-----------


-----------
-- U_dsi_Configuration inserts
-----------

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','ExportPath','V','\\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','TestPath','V','\\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EEPRNAPO','UseFileName','V','N');

-----------
-- Restore target paths
-----------

UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EEPRNAPO_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_EEPRNAPO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EEPRNAPO_SavePath];
GO

-----------
-- U_dsi_RecordSetDetails inserts
-----------


-----------
-- U_dsi_SQLClauses inserts
-----------

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEPRNAPO','H01','dbo.U_EEPRNAPO_HeaderH01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EEPRNAPO','D10','dbo.U_EEPRNAPO_drvTblD10',NULL);

-----------
-- U_dsi_Translations inserts
-----------


-----------
-- U_dsi_Translations_v2 inserts
-----------


-----------
-- Create table U_EEPRNAPO_Audit
-----------

IF OBJECT_ID('U_EEPRNAPO_Audit') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audAddressChgDate] datetime NULL,
    [audLOAEffDate] datetime NULL,
    [audReturnFromLeave] varchar(1) NOT NULL,
    [audLtoAEffDate] datetime NULL,
    [audPayPeriodUpdate] varchar(1) NOT NULL,
    [audPayPeriodUpdateDate] datetime NULL,
    [audCOIDChgDate] datetime NULL,
    [audFTPTChg] varchar(1) NOT NULL,
    [audFTPTChgDate] datetime NULL,
    [audUDField11ChgDate] datetime NULL,
    [audJobCodeChg] varchar(1) NOT NULL,
    [audJobCodeChgDate] datetime NULL,
    [audNewJobCode] varchar(2000) NULL,
    [audOldJobCode] varchar(2000) NULL,
    [audSalGradeChgDate] datetime NULL,
    [audLOARsnChgDate] datetime NULL,
    [audPrimaryJobChg] varchar(1) NOT NULL,
    [audPrimaryJobChgDate] datetime NULL,
    [audClassChange] varchar(1) NOT NULL,
    [audJobEffDate] datetime NULL
);

-----------
-- Create table U_EEPRNAPO_AuditFields
-----------

IF OBJECT_ID('U_EEPRNAPO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);

-----------
-- Create table U_EEPRNAPO_audPivotTable
-----------

IF OBJECT_ID('U_EEPRNAPO_audPivotTable') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_audPivotTable] (
    [audPivEEID] varchar(255) NOT NULL,
    [audPivReturnFromLeave] varchar(1) NULL,
    [audPivAddressChgDate] date NULL,
    [audPivLOARsnChgDate] date NULL,
    [audPivSalGradeChgDate] date NULL,
    [audPivJobCodeChgDate] date NULL,
    [audPivJobCodeChg] varchar(1) NULL,
    [audPivNewJobCode] varchar(2000) NULL,
    [audPivOldJobCode] varchar(2000) NULL,
    [audPivUDField11ChgDate] date NULL,
    [audPivFTPTChgDate] date NULL,
    [audPivCOIDChgDate] date NULL,
    [audPivPayPeriodEffDate] date NULL,
    [audPivLOAReturnDate] date NULL,
    [audPivFTPTChg] varchar(1) NULL,
    [audPivPrimaryJobChg] varchar(1) NULL,
    [audPivPrimaryJobChgDate] date NULL
);

-----------
-- Create table U_EEPRNAPO_drvTblD10
-----------

IF OBJECT_ID('U_EEPRNAPO_drvTblD10') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_drvTblD10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubSort2] varchar(1) NOT NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvEMPLOYEESSN] char(11) NULL,
    [drvEMPLOYEEID] char(9) NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvFIRSTNAME] varchar(100) NULL,
    [drvBIRTHDATE] datetime NULL,
    [drvGENDER] char(1) NULL,
    [drvADDRESS1] varchar(255) NULL,
    [drvADDRESS2] varchar(255) NULL,
    [drvCITY] varchar(255) NULL,
    [drvSTATE] varchar(255) NULL,
    [drvPOSTAL] varchar(5) NULL,
    [drvCOUNTRY] varchar(2) NULL,
    [drvADDRESSEFFDATE] datetime NULL,
    [drvHOMEPHONE] varchar(50) NULL,
    [drvWORKPHONE] varchar(50) NULL,
    [drvMobilePhone] nvarchar(4000) NULL,
    [drvWORKEMAILADDRESS] varchar(50) NULL,
    [drvORIGINALHIREDATE] datetime NULL,
    [drvLATESTHIREDATE] datetime NULL,
    [drvEMPLOYMENTSTATUS] varchar(1) NULL,
    [drvEMPLOYMENTSTATUSEFFDATE] datetime NULL,
    [drvDEATHDATEATTR] datetime NULL,
    [drvTERMINATIONDATEATTR] datetime NULL,
    [drvCURRENTANNUALSALARYATTR] varchar(30) NULL,
    [drvCURRENTSALARYATTREFFDATE] datetime NULL,
    [drvPAYFREQUENCYATTR] char(1) NULL,
    [drvPAYFREQUENCYATTREFFDATE] datetime NULL,
    [drvEMPLOYEREINATTR] char(9) NULL,
    [drvEINATTREFFDATE] datetime NULL,
    [drvFTPTATTR] char(1) NULL,
    [drvFTPTATTREFFDATE] datetime NULL,
    [drvReasonCodeAttr] nvarchar(4000) NULL,
    [drvReasonEffDate] datetime NULL,
    [drvFTPTINDICATOR] char(1) NULL,
    [drvFTPTINDICATOREFFDATE] datetime NULL,
    [drvEMPLOYEECLASS] varchar(3) NOT NULL,
    [drvEMPLOYEECLASSEFFDATE] datetime NOT NULL,
    [drvREGTEMP] varchar(1) NOT NULL,
    [drvREGTEMPEFFDATE] datetime NULL,
    [drvJOBCODE] char(8) NULL,
    [drvJOBCODEEFFDATE] datetime NULL,
    [drvJOBTITLE] varchar(150) NULL,
    [drvJOBTITLEEFFDATE] datetime NULL,
    [drvWORKLOCATION] char(6) NULL,
    [drvWORKLOCATIONEFFDATE] datetime NOT NULL,
    [drvSTANDARDHOURS] varchar(30) NULL,
    [drvSTANDARDHOURSEFFDATE] datetime NOT NULL,
    [drvCOMPANYCODE] char(5) NULL,
    [drvCOMPANYCODEEFFDATE] datetime NOT NULL,
    [drvSALARYGRADE] char(3) NULL,
    [drvSALARYGRADEEFFDATE] datetime NULL,
    [drvLEAVEREASON] char(6) NULL,
    [drvLEAVEREASONEFFDATE] datetime NULL,
    [lstADDRESSEFFDATE] datetime NULL,
    [audPivAddressChgDate] date NULL,
    [lstFTPTATTREFFDATE] datetime NULL,
    [audPivFTPTChg] varchar(1) NULL,
    [MaxJobEffDate] datetime NULL
);

-----------
-- Create table U_EEPRNAPO_EEList
-----------

IF OBJECT_ID('U_EEPRNAPO_EEList') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);

-----------
-- Create table U_EEPRNAPO_File
-----------

IF OBJECT_ID('U_EEPRNAPO_File') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);

-----------
-- Create table U_EEPRNAPO_HeaderH01
-----------

IF OBJECT_ID('U_EEPRNAPO_HeaderH01') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_HeaderH01] (
    [drvFILEPRODUCTIONDATE] datetime NOT NULL
);

-----------
-- Create table U_EEPRNAPO_LastSent
-----------

IF OBJECT_ID('U_EEPRNAPO_LastSent') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_LastSent] (
    [lstEEID] char(12) NULL,
    [lstCOID] char(5) NULL,
    [lstADDRESSEFFDATE] datetime NULL,
    [lstORIGINALHIREDATE] datetime NULL,
    [lstLATESTHIREDATE] datetime NULL,
    [lstEMPLOYMENTSTATUSEFFDATE] datetime NULL,
    [lstDEATHDATEATTR] datetime NULL,
    [lstTERMINATIONDATEATTR] datetime NULL,
    [lstCURRENTSALARYATTREFFDATE] datetime NULL,
    [lstPAYFREQUENCYATTREFFDATE] datetime NULL,
    [lstEINATTREFFDATE] datetime NULL,
    [lstFTPTATTREFFDATE] datetime NULL,
    [lstFTPTINDICATOREFFDATE] datetime NULL,
    [lstEMPLOYEECLASSEFFDATE] datetime NULL,
    [lstREGTEMPEFFDATE] datetime NULL,
    [lstJOBCODEEFFDATE] datetime NULL,
    [lstJOBTITLEEFFDATE] datetime NULL,
    [lstWORKLOCATIONEFFDATE] datetime NULL,
    [lstSTANDARDHOURSEFFDATE] datetime NULL,
    [lstCOMPANYCODEEFFDATE] datetime NULL,
    [lstSALARYGRADEEFFDATE] datetime NULL,
    [lstLEAVEREASONEFFDATE] datetime NULL
);

-----------
-- Create table U_EEPRNAPO_SECJOB
-----------

IF OBJECT_ID('U_EEPRNAPO_SECJOB') IS NULL
CREATE TABLE [dbo].[U_EEPRNAPO_SECJOB] (
    [EecEEID] char(12) NULL,
    [EecCoID] char(5) NULL,
    [Employment_UPSecondaryJobActionReason] nvarchar(4000) NULL,
    [Employment_UPSecondaryJobDepartment] nvarchar(4000) NULL,
    [Employment_UPSecondaryJobHireDate] datetime NULL,
    [Employment_UPSecondaryJobLastDayWorked] datetime NULL,
    [Employment_UPSecondaryJobLocation] nvarchar(4000) NULL,
    [Employment_UPSecondaryJobSupervisorID] nvarchar(4000) NULL,
    [Employment_UPSecondaryJobTerminationDate] datetime NULL,
    [Employment_UPSecondaryLastStartDate] datetime NULL,
    [Employment_UPSecondaryJobBenefitsServiceDate] datetime NULL,
    [Employment_UPSecondaryJobCompanySeniorityDate] datetime NULL,
    [Employment_UPSecondaryJobSeniorityCalcDate] datetime NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEPRNAPO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Univeristy of Phoenix

Created By: Nicci Blady
Business Analyst: Bridget Amsden
Create Date: 08/19/2018
Service Request Number: SR-2018-00202319

Purpose: Emyperian Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
SBEEVER             05/29/2019     SR-00236839        V2.15
SBEEVER             08/28/2019     SR-00236839        V2.17
RDULANEY            11/06/2020       SR-00282940          V3.18 -- Update to gender logic
AP                    05/18/2021                         Update secondary jobs data

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEPRNAPO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEPRNAPO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEPRNAPO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEPRNAPO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEPRNAPO' ORDER BY RunID DESC;

--SELECT AdhFileFormat, * FROM dbo.AscDefH WHERE AdhFormatCode = 'EEPRNAPO'
    
Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

--Update Drive Mappings in U_DSI_Configuration
---------------------------------------------------
SELECT * FROM U_DSI_Configuration WHERE cfgname like '%path%' order by 4
--Prod
update U_DSI_Configuration SET cfgvalue = '\\US.SAAS\n2\APO1003\APO1003\Exports\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'TestPath'
update U_DSI_Configuration SET cfgvalue = '\\us.saas\NZ\APO1003\APO1003\Exports_TEST\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'ExportPath'

--Test
update U_DSI_Configuration SET cfgvalue = '\\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'TestPath'
update U_DSI_Configuration SET cfgvalue = '\\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'ExportPath'

--Update Testing flag in U_DSI_Configuration for Production
---------------------------------------------------
update U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'Testing'

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v6 @FormatCode = 'EEPRNAPO', @AllObjects = 'Y', @IsWeb = 'N'
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
    SELECT @FormatCode = 'EEPRNAPO';

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
    DELETE FROM dbo.U_EEPRNAPO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEPRNAPO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEPRNAPO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_AuditFields;
    CREATE TABLE dbo.U_EEPRNAPO_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecCOID');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecUDField11');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecJobCode');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecLeaveReason');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecIsFaculty');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpHJob','EjhSalaryGrade');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpMJobs','EejIsPrimaryJob');
    --INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('JobCode','JbcUDField1');

    --sp_help empcomp

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEPRNAPO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_Audit;
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
        ,audAddressChgDate = CASE WHEN audFieldName LIKE 'EepAddress%' AND audAction = 'UPDATE' THEN audDateTime END
        ,audLOAEffDate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' AND audOldValue = 'A' AND audNewValue = 'L' THEN audDateTime END
        ,audReturnFromLeave = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' AND audOldValue = 'L' AND audNewValue = 'A' THEN 'Y' ELSE 'N' END
        ,audLtoAEffDate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' AND audOldValue = 'L' AND audNewValue = 'A' THEN audDateTime END
        ,audPayPeriodUpdate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audPayPeriodUpdateDate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' THEN audDateTime END
        ,audCOIDChgDate = CASE WHEN audFieldName IN('EecCOID') AND audAction = 'UPDATE' THEN audDateTime END
        ,audFTPTChg = CASE WHEN audFieldName IN('EecFullTimeOrPartTime') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audFTPTChgDate = CASE WHEN audFieldName IN('EecFullTimeOrPartTime') AND audAction = 'UPDATE' THEN audDateTime END
        ,audUDField11ChgDate = CASE WHEN audFieldName IN('EecUDField11') AND audAction = 'UPDATE' THEN audDateTime END
        ,audJobCodeChg = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audJobCodeChgDate = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN audDateTime END
        ,audNewJobCode = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN audNewValue END
        ,audOldJobCode = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN audOldValue END
        ,audSalGradeChgDate = CASE WHEN audFieldName IN('EjhSalaryGrade') AND audAction = 'UPDATE' THEN audDateTime END
        ,audLOARsnChgDate = CASE WHEN audFieldName IN('EecLeaveReason') AND audAction = 'UPDATE' THEN audDateTime END
        --,audJobUDField1Chg = CASE WHEN audFieldName IN('JbcUDField1') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audPrimaryJobChg = CASE WHEN audFieldName IN('EejIsPrimaryJob') AND audNewValue = 'Y' THEN 'Y' ELSE 'N' END
        ,audPrimaryJobChgDate = CASE WHEN audFieldName IN('EejIsPrimaryJob') AND audNewValue = 'Y' THEN audDateTime END
        --,audIsFacultyChg = CASE WHEN audFieldName IN('EecIsFaculty') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        --,audIsFacultyChgDate = CASE WHEN audFieldName IN('EecIsFaculty') AND audAction = 'UPDATE' THEN audDateTime END
        ,audClassChange = CASE WHEN audFieldName = 'EecJobCode' and audOldValue IN ('999999','AA088') and audNewValue NOT IN ('999999','AA088') then 'Y'
                               WHEN audFieldName = 'EecJobCode' and audOldValue NOT IN ('999999','AA088') and audNewValue IN ('999999','AA088') then 'Y'
                               ELSE 'N'
                               END
        ,audJobEffDate = EjhJobEffDate
    INTO dbo.U_EEPRNAPO_Audit        -- select * from dbo.U_EEPRNAPO_Audit where audeeid = '9RS27T0000K0' audftptchg = 'Y'        sp_geteeid '0988522'
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEPRNAPO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON left(audsystemid ,5) = left(EjhSystemID,5)
        and audKey1Value = ejheeid
        and audKey2Value = ejhcoid
        --and nullif(audKey3Value,'') is not null
    WHERE cast(audDateTime as date) >= cast(@StartDate as date)
    and cast(auddatetime as date) <= cast(@EndDate as date)
    --WHERE audDateTime BETWEEN '09-15-2018' and '09-28-2018'--@StartDate AND @EndDate
    AND audAction <> 'DELETE'
    ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEPRNAPO_Audit ON dbo.U_EEPRNAPO_Audit (audEEID,audKey2);

    --================
    -- Only keep latest audit change per data element
    --================
    DELETE FROM dbo.U_EEPRNAPO_Audit where audRowNo > 1


    --sp_help vw_AuditData
    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EEPRNAPO_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EEPRNAPO_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Working Table (Static) 
    --==========================================
    -- Create static table to store dates **Empyrean Cannot Accept Dates Older Than Last Sent**
    -- DROP TABLE dbo.U_EEPRNAPO_LastSent
    IF OBJECT_ID('U_EEPRNAPO_LastSent','U') IS NULL
    BEGIN    
    CREATE TABLE dbo.U_EEPRNAPO_LastSent (
         lstEEID                        CHAR(12)
        ,lstCOID                        CHAR(5)
        ,lstADDRESSEFFDATE              DATETIME
        ,lstORIGINALHIREDATE            DATETIME
        ,lstLATESTHIREDATE              DATETIME
        ,lstEMPLOYMENTSTATUSEFFDATE     DATETIME
        ,lstDEATHDATEATTR               DATETIME
        ,lstTERMINATIONDATEATTR         DATETIME
        ,lstCURRENTSALARYATTREFFDATE    DATETIME
        ,lstPAYFREQUENCYATTREFFDATE     DATETIME
        ,lstEINATTREFFDATE              DATETIME
        ,lstFTPTATTREFFDATE             DATETIME
        ,lstFTPTINDICATOREFFDATE        DATETIME
        ,lstEMPLOYEECLASSEFFDATE        DATETIME
        ,lstREGTEMPEFFDATE              DATETIME
        ,lstJOBCODEEFFDATE              DATETIME
        ,lstJOBTITLEEFFDATE             DATETIME
        ,lstWORKLOCATIONEFFDATE         DATETIME
        ,lstSTANDARDHOURSEFFDATE        DATETIME
        ,lstCOMPANYCODEEFFDATE          DATETIME
        ,lstSALARYGRADEEFFDATE          DATETIME
        ,lstLEAVEREASONEFFDATE          DATETIME
    )
    ;

    END
    --sp_help U_EEPRNAPO_LastSent
    --DELETE FROM dbo.U_EEPRNAPO_LastSent
    --select * from dbo.U_EEPRNAPO_LastSent

    --Create Audit Pivot Table
    IF OBJECT_ID('U_EEPRNAPO_audPivotTable','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_audPivotTable;

    SELECT DISTINCT
         audPivEEID = audEEID
        ,audPivReturnFromLeave = MAX(audReturnFromLeave)
        ,audPivAddressChgDate = CONVERT(DATE,MAX(audAddressChgDate),112)
        ,audPivLOARsnChgDate = CONVERT(DATE,MAX(audLOARsnChgDate),112)
        ,audPivSalGradeChgDate = CONVERT(DATE,MAX(audSalGradeChgDate),112)
        ,audPivJobCodeChgDate = CONVERT(DATE,MAX(audJobCodeChgDate),112)
        ,audPivJobCodeChg = MAX(audJobCodeChg)
        ,audPivNewJobCode = MAX(audNewJobCode)
        ,audPivOldJobCode = MAX(audOldJobCode)
        ,audPivUDField11ChgDate = CONVERT(DATE,MAX(audUDField11ChgDate),112)
        ,audPivFTPTChgDate = CONVERT(DATE,MAX(audFTPTChgDate),112)
        ,audPivCOIDChgDate = CONVERT(DATE,MAX(audCOIDChgDate),112)
        ,audPivPayPeriodEffDate = CONVERT(DATE,MAX(audPayPeriodUpdateDate),112)
        ,audPivLOAReturnDate = CONVERT(DATE,MAX(audLtoAEffDate),112)
        ,audPivFTPTChg = MAX(audFTPTChg)
        ,audPivPrimaryJobChg = MAX(audPrimaryJobChg)
        ,audPivPrimaryJobChgDate = CONVERT(DATE,MAX(audPrimaryJobChgDate),112)
        --,audPivClassChg = MAX(audClassChange)
        --,audPivJobEffDate = CONVERT(DATE,MAX(audJobEffDate),112)
    INTO dbo.U_EEPRNAPO_audPivotTable
        FROM dbo.U_EEPRNAPO_Audit WITH (NOLOCK)
        WHERE COALESCE(audLtoAEffDate,audAddressChgDate,audAddressChgDate,audSalGradeChgDate,audJobCodeChgDate,audUDField11ChgDate,audFTPTChgDate,audCOIDChgDate,audPrimaryJobChgDate) IS NOT NULL
        --AND audRowNo = '1'
        GROUP BY audEEID
        ;

        --sp_help U_EEPRNAPO_audPivotTable
        --select * from dbo.U_EEPRNAPO_audPivotTable

     ---- Build iCIMSID field table ---------------------------------------

     IF OBJECT_ID('U_EEPRNAPO_SECJOB','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_SECJOB;
    SELECT * 
    INTO dbo.U_EEPRNAPO_SECJOB
    FROM [dbo].[fn_MP_CustomFields_EmpComp_Export] (NULL,NULL,NULL,NULL)
    
    -----------------------------------------------------------------------

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEPRNAPO_drvTblD10
    ---------------------------------
    IF OBJECT_ID('U_EEPRNAPO_drvTblD10','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_drvTblD10;
    
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvEMPLOYEESSN = EepSSN
        ,drvEMPLOYEEID = EecEmpNo
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAME = EepNameFirst
        ,drvBIRTHDATE = EepDateOfBirth
        ,drvGENDER = CASE WHEN EepGender IN ('F','M') THEN EepGender ELSE GenderMapping END
        ,drvADDRESS1 = EepAddressLine1
        ,drvADDRESS2 = EepAddressLine2
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvPOSTAL = LEFT(EepAddressZipCode,5)
        ,drvCOUNTRY = LEFT(EepAddressCountry,2)
        ,drvADDRESSEFFDATE = COALESCE(audPivAddressChgDate,GETDATE())    -- JBJ based on calls with Bridget and client on 10/4/18
        ,drvHOMEPHONE = EepPhoneHomeNumber
        ,drvWORKPHONE = EecPhoneBusinessNumber
        ,drvMobilePhone = Employee_PersonalCell
        ,drvWORKEMAILADDRESS = EepAddressEMail
        ,drvORIGINALHIREDATE = EecDateOfOriginalHire
        ,drvLATESTHIREDATE = EecDateOfLastHire
        ,drvEMPLOYMENTSTATUS = case when EecEmplStatus = 'T' and EecTermReason = '203' then 'D'
                                    else EecEmplStatus
                                    END
       --drvEMPLOYMENTSTATUSEFFDATE 27
        ,drvEMPLOYMENTSTATUSEFFDATE =  CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                                     WHEN EecEmplStatus IN('T','R') THEN EecEmplStatusStartDate --EecDateOfTermination
                                                     WHEN audPivReturnFromLeave = 'Y' THEN COALESCE(EecEmplStatusStartDate,MaxJobEffDate)  --audPivLOAReturnDate)
                                                     WHEN EecDateOfLastHire < EecEmplStatusStartDate THEN EecEmplStatusStartDate
                                                     ELSE EecDateOfLastHire
                                                     END
        
        --CASE WHEN lstEMPLOYMENTSTATUSEFFDATE IS NULL OR lstEMPLOYMENTSTATUSEFFDATE < COALESCE(EecEmplStatusStartDate,EecDateOfTermination,EecStatusExpectedEndDate,audPivLOAReturnDate,EecDateOfLastHire) THEN
  --                                              CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
  --                                                   WHEN EecEmplStatus IN('T','R') THEN EecEmplStatusStartDate --EecDateOfTermination
  --                                                   WHEN audPivReturnFromLeave = 'Y' THEN COALESCE(EecEmplStatusStartDate,MaxJobEffDate)  --audPivLOAReturnDate)
  --                                                   WHEN EecDateOfLastHire < EecEmplStatusStartDate THEN EecEmplStatusStartDate
  --                                                   ELSE EecDateOfLastHire
  --                                                   END
  --                                         WHEN lstEMPLOYMENTSTATUSEFFDATE > GETDATE() THEN lstEMPLOYMENTSTATUSEFFDATE
        --                                   ELSE GETDATE()
        --                                   ---ISNULL(lstEMPLOYMENTSTATUSEFFDATE,GETDATE())
  --                                         END
        ,drvDEATHDATEATTR = CASE WHEN EepDateDeceased IS NOT NULL THEN EepDateDeceased END
        ,drvTERMINATIONDATEATTR = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END --AND (lstTERMINATIONDATEATTR IS NULL OR lstTERMINATIONDATEATTR < EecDateLastWorked) THEN EecDateOfTermination ELSE lstTERMINATIONDATEATTR END
        ,drvCURRENTANNUALSALARYATTR = CONVERT(VARCHAR(30),TRY_CONVERT(DECIMAL(12,0),EecAnnSalary*100))
        ,drvCURRENTSALARYATTREFFDATE = CASE WHEN (lstCURRENTSALARYATTREFFDATE IS NULL OR lstCURRENTSALARYATTREFFDATE < COALESCE(MaxPayRateDate,EecDateOfLastHire)) THEN COALESCE(MaxPayRateDate,EecDateOfLastHire) ELSE lstCURRENTSALARYATTREFFDATE END
        ,drvPAYFREQUENCYATTR = EecPayPeriod
        ,drvPAYFREQUENCYATTREFFDATE = CASE WHEN lstPAYFREQUENCYATTREFFDATE IS NULL OR lstPAYFREQUENCYATTREFFDATE < COALESCE(audPivPayPeriodEffDate,MaxJobEffDate) THEN COALESCE(audPivPayPeriodEffDate,MaxJobEffDate) ELSE lstPAYFREQUENCYATTREFFDATE END
        ,drvEMPLOYEREINATTR = CmpFedTaxID
        ,drvEINATTREFFDATE = CASE WHEN lstEINATTREFFDATE IS NULL OR lstEINATTREFFDATE < COALESCE(audPivCOIDChgDate,EecDateOfLastHire) THEN COALESCE(audPivCOIDChgDate,EecDateOfLastHire) 
                WHEN lstEINATTREFFDATE > GETDATE() THEN  lstEINATTREFFDATE
                ELSE GETDATE() END
        
        ,drvFTPTATTR = EecFullTimeOrPartTime
--ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ drvFTPTATTREFFDATE Field 37
        ,drvFTPTATTREFFDATE = CASE WHEN FTPTEffDate > lstFTPTINDICATOREFFDATE THEN FTPTEffDate
                                   WHEN lstFTPTATTREFFDATE > GETDATE() THEN lstFTPTATTREFFDATE 
                                   ELSE GETDATE() 
                                   END
        ,drvReasonCodeAttr = CASE WHEN EecEmplStatus = 'A' THEN r.Employment_UPSecondaryJobActionReason
                                    WHEN EecEmplStatus = 'T' THEN EecTermReason 
                                    END
        ,drvReasonEffDate = CASE WHEN EecEmplStatus = 'A' THEN r.Employment_UPSecondaryJobTerminationDate 
                                    WHEN EecEmplStatus = 'T' THEN EecDateOfTermination 
                                END
        --COALESCE(FTPTEffDate,GETDATE())  -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
                                --CASE WHEN audPivFTPTChg = 'Y' THEN MaxJobEffDate ELSE getdate() end    -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        ,drvFTPTINDICATOR = EecFullTimeOrPartTime ---43

--ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ drvFTPTINDICATOREFFDATE field 44
        ,drvFTPTINDICATOREFFDATE = CASE WHEN FTPTEffDate > lstFTPTINDICATOREFFDATE THEN FTPTEffDate      
                                        WHEN lstFTPTINDICATOREFFDATE > GETDATE() THEN lstFTPTINDICATOREFFDATE
                                        ELSE GETDATE() 
                                        END
        --COALESCE(FTPTEffDate,GETDATE())  -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
                                --CASE WHEN audPivFTPTChg = 'Y' THEN MaxJobEffDate ELSE getdate() end    -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
       --drvEMPLOYEECLASS  field 45
        ,drvEMPLOYEECLASS = CASE WHEN EecJobCode IN('999999','AA088') THEN 'FAC' ELSE 'STF' END
--ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        -- drvEMPLOYEECLASSEFFDATE field 46
        ,drvEMPLOYEECLASSEFFDATE = isnull(MaxClassEffDate,GETDATE()) ---added coalesce
        
        --CASE WHEN ClassEffDate IS NOT NULL THEN ClassEffDate
  --                                      WHEN lstFTPTINDICATOREFFDATE > GETDATE() THEN lstFTPTINDICATOREFFDATE 
        --                                ELSE GETDATE() END            
        
        --CASE WHEN /*lstEMPLOYEECLASSEFFDATE*/ ClassEffDate IS NOT NULL THEN ClassEffDate
  --                                          --IIF(ClassEffDate > lstEMPLOYEECLASSEFFDATE, ClassEffDate, lstEMPLOYEECLASSEFFDATE)   --Updated 10/16/18 Per email request from Annie Varghese - NB
  --                                      ELSE lstFTPTINDICATOREFFDATE--ClassEffDate  --xyzx replaced EecDateOfLastHire    -- Updated 10/18/18 Per email from Annie Varghese & Phillip Ambrose - NB
  --                                      END
                                        
            --CASE WHEN /*lstEMPLOYEECLASSEFFDATE*/ ClassEffDate IS NOT NULL THEN ClassEffDate
   --                                         --IIF(ClassEffDate > lstEMPLOYEECLASSEFFDATE, ClassEffDate, lstEMPLOYEECLASSEFFDATE)   --Updated 10/16/18 Per email request from Annie Varghese - NB
   --                                     ELSE ISNULL(lstEMPLOYEECLASSEFFDATE,EecDateOfLastHire)    -- Updated 10/18/18 Per email from Annie Varghese & Phillip Ambrose - NB
   --                                     END 
                                        
                                                                                    
        --COALESCE(ClassEffDate,GETDATE())  -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        ,drvREGTEMP = CASE WHEN EecUDField11 = 'T' THEN 'T' ELSE 'R' END
        ,drvREGTEMPEFFDATE = COALESCE(audPivUDField11ChgDate,GETDATE())    --JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        ,drvJOBCODE = EecJobCode
        ,drvJOBCODEEFFDATE = CASE WHEN lstJOBCODEEFFDATE IS NULL OR lstJOBCODEEFFDATE < ISNULL(audPivJobCodeChgDate,MaxJobEffDate) THEN ISNULL(audPivJobCodeChgDate,MaxJobEffDate) ELSE lstJOBCODEEFFDATE END
        ,drvJOBTITLE = CASE WHEN (EecJobTitle <> '' AND EecJobTitle IS NOT NULL) THEN EecJobTitle ELSE JbcLongDesc END 
        ,drvJOBTITLEEFFDATE = CASE WHEN lstJOBTITLEEFFDATE IS NULL OR lstJOBTITLEEFFDATE < ISNULL(audPivJobCodeChgDate,MaxJobEffDate) THEN ISNULL(audPivJobCodeChgDate,MaxJobEffDate) ELSE lstJOBTITLEEFFDATE END
        ,drvWORKLOCATION = EecLocation
        ,drvWORKLOCATIONEFFDATE = GETDATE()
        ,drvSTANDARDHOURS = CAST(CONVERT(DECIMAL(10,0),(EecScheduledAnnualHrs/52) *100) AS VARCHAR)
        ,drvSTANDARDHOURSEFFDATE = GETDATE()
        ,drvCOMPANYCODE = CmpCompanyCode
        ,drvCOMPANYCODEEFFDATE = GETDATE()
        ,drvSALARYGRADE = JbcSalaryGrade
        ,drvSALARYGRADEEFFDATE = CASE WHEN lstSALARYGRADEEFFDATE IS NULL OR lstSALARYGRADEEFFDATE < COALESCE(audPivSalGradeChgDate,EecDateOfLastHire) THEN COALESCE(audPivSalGradeChgDate,EecDateOfLastHire) ELSE lstSALARYGRADEEFFDATE END
        ,drvLEAVEREASON = CASE WHEN EecEmplStatus = 'L' THEN EecLeaveReason END
        ,drvLEAVEREASONEFFDATE = CASE WHEN EecEmplStatus = 'L' AND isnull(MaxJobEffDate,'01/01/1901') >EecEmplStatusStartDate THEN MaxJobEffDate
                                      WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                      END
        --AND (lstLEAVEREASONEFFDATE IS NULL OR lstLEAVEREASONEFFDATE < COALESCE(audPivLOARsnChgDate,EecEmplStatusStartDate)) THEN COALESCE(audPivLOARsnChgDate,EecEmplStatusStartDate) ELSE lstLEAVEREASONEFFDATE END
        ,lstADDRESSEFFDATE
        ,audPivAddressChgDate
        ,lstFTPTATTREFFDATE
        ,audPivFTPTChg
        ,MaxJobEffDate
    INTO dbo.U_EEPRNAPO_drvTblD10        --        --Select * from U_EEPRNAPO_drvTblD10 where drveeid = '9RS7P90000K0'        sp_geteeid '1001302'
    FROM dbo.U_EEPRNAPO_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_EEPRNAPO_LastSent WITH (NOLOCK)
        ON lstEEID = xEEID
    LEFT JOIN dbo.U_EEPRNAPO_audPivotTable WITH (NOLOCK)
        ON audPivEEID = xEEID
    LEFT JOIN (Select audeeid as eeid10, max(audJobEffDate) as FTPTEffDate from dbo.U_EEPRNAPO_Audit where audFTPTChg = 'Y' group by audEEID) as TmpTbl10 on xEEID = eeid10
    LEFT JOIN (Select audeeid as eeid11, max(audJobEffDate) as ClassEffDate from dbo.U_EEPRNAPO_Audit where audClassChange = 'Y' group by audEEID) as TmpTbl11 on xEEID = eeid11
    LEFT JOIN (SELECT ejhcoid AS coid3, ejheeid AS eeid3, MAX(ejhjobeffdate) AS MaxPayRateDate 
               FROM emphjob(NOLOCK) 
               --WHERE ejhisratechange = 'Y' 
               GROUP BY ejhcoid, ejheeid) AS ttl3 
        ON eeccoid = coid3
        AND eeceeid = eeid3
    LEFT JOIN (SELECT EjhCOID AS COID4, EjhEEID AS EEID4, EjhJobCode, MAX(EjhJobEffDate) AS MaxJobEffDate 
               FROM EmphJob(NOLOCK)
               GROUP BY EjhCOID, EjhEEID, EjhJobCode) AS ttl4 
        ON EecCOID = COID4
        AND EecEEID = EEID4
        AND EecJobCode = EjhJobCode
    LEFT JOIN (SELECT EejCOID AS COID9, EejEEID AS EEID9, EejJobCode, MAX(EejDateInJob) AS MaxClassEffDate 
               FROM EmpMJobs WITH (NOLOCK)
               WHERE EejIsPrimaryJob = 'Y'
               GROUP BY EejCOID, EejEEID, EejJobCode) AS ttl9 
        ON EecCOID = COID9
        AND EecEEID = EEID9
        AND EecJobCode = EejJobCode
    --LEFT JOIN dbo.EmpMJobs em WITH(NOLOCK)
    --    ON em.eejeeid = xeeid
    --    and em.eejcoid = xcoid
    ----    and em.eejjobcode = eecjobcode
    LEFT JOIN [dbo].[fn_MP_CustomFields_EmpPers_Export](null, null, null, null)
        ON EEID = xEEID
    JOIN ULTIPRO_SYSTEM.dbo.CountryISOCode WITH (NOLOCK)
        ON EepAddressCountry = cicCountryCode
    LEFT JOIN dbo.EmployeeGender WITH (NOLOCK)
        ON GenderCode = EepGender
    --LEFT JOIN dbo.U_EEPRNAPO_SECJOB sj ON sj.EecEEID = xEEID AND sj.EecCOID = xCOID
    LEFT JOIN (SELECT ec.EecEEID, ec.EecCOID, sj.Employment_UPSecondaryJobActionReason, sj.Employment_UPSecondaryJobTerminationDate
                FROM dbo.EmpComp ec WITH(NOLOCK) JOIN dbo.EmpMJobs WITH(NOLOCK)
                ON ec.EecEEID = EejEEID AND ec.EecCOID = EejCOID JOIN dbo.U_EEPRNAPO_SECJOB sj 
                ON sj.EecEEID = ec.EecEEID AND sj.EecCOID = ec.EecCOID
                WHERE ec.EecEmplStatus = 'A'
                AND EejIsPrimaryJob = 'N'
                AND EejJobCode NOT IN ('999999', 'AA088') 
                AND sj.Employment_UPSecondaryJobTerminationDate <> '') r ON r.EecEEID = xEEID AND r.EecCOID = xCOID
    WHERE (EecEmplStatus <> 'T' OR EecDateOfTermination >= DATEADD(MM,-12,GETDATE()))
    ;
     
    -- Populate/Update static table to store dates **Empyrean Cannot Accept Dates Older Than Last Sent**
    -- DROP TABLE dbo.U_EEPRNAPO_LastSent
    IF EXISTS (SELECT DISTINCT drvEEID, drvCOID 
               FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
               JOIN dbo.U_EEPRNAPO_LastSent WITH (NOLOCK) 
                    ON drvEEID = lstEEID AND drvCOID = lstCOID)
    BEGIN
    UPDATE dbo.U_EEPRNAPO_LastSent
    SET  
         lstADDRESSEFFDATE = drvADDRESSEFFDATE
        ,lstORIGINALHIREDATE = drvORIGINALHIREDATE
        ,lstLATESTHIREDATE = drvLATESTHIREDATE
        ,lstEMPLOYMENTSTATUSEFFDATE = drvEMPLOYMENTSTATUSEFFDATE
        ,lstDEATHDATEATTR = drvDEATHDATEATTR
        ,lstTERMINATIONDATEATTR = drvTERMINATIONDATEATTR
        ,lstCURRENTSALARYATTREFFDATE = drvCURRENTSALARYATTREFFDATE
        ,lstPAYFREQUENCYATTREFFDATE = drvPAYFREQUENCYATTREFFDATE
        ,lstEINATTREFFDATE = drvEINATTREFFDATE
        ,lstFTPTATTREFFDATE = drvFTPTATTREFFDATE
        ,lstFTPTINDICATOREFFDATE = drvFTPTINDICATOREFFDATE
        ,lstEMPLOYEECLASSEFFDATE = drvEMPLOYEECLASSEFFDATE
        ,lstREGTEMPEFFDATE = drvREGTEMPEFFDATE
        ,lstJOBCODEEFFDATE = drvJOBCODEEFFDATE
        ,lstJOBTITLEEFFDATE = drvJOBTITLEEFFDATE
        ,lstWORKLOCATIONEFFDATE = drvWORKLOCATIONEFFDATE
        ,lstSTANDARDHOURSEFFDATE = drvSTANDARDHOURSEFFDATE
        ,lstCOMPANYCODEEFFDATE = drvCOMPANYCODEEFFDATE
        ,lstSALARYGRADEEFFDATE = drvSALARYGRADEEFFDATE
        ,lstLEAVEREASONEFFDATE = drvLEAVEREASONEFFDATE
        FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
        WHERE lstEEID = drvEEID AND drvCOID = lstCOID;
    END

    IF NOT EXISTS (SELECT DISTINCT drvEEID, drvCOID 
               FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
               JOIN dbo.U_EEPRNAPO_LastSent WITH (NOLOCK) 
                    ON drvEEID = lstEEID AND drvCOID = lstCOID)
    BEGIN
    INSERT INTO dbo.U_EEPRNAPO_LastSent
    SELECT DISTINCT 
         lstEEID = drvEEID
        ,lstCOID = drvCOID
        ,lstADDRESSEFFDATE = drvADDRESSEFFDATE
        ,lstORIGINALHIREDATE = drvORIGINALHIREDATE
        ,lstLATESTHIREDATE = drvLATESTHIREDATE
        ,lstEMPLOYMENTSTATUSEFFDATE = drvEMPLOYMENTSTATUSEFFDATE
        ,lstDEATHDATEATTR = drvDEATHDATEATTR
        ,lstTERMINATIONDATEATTR = drvTERMINATIONDATEATTR
        ,lstCURRENTSALARYATTREFFDATE = drvCURRENTSALARYATTREFFDATE
        ,lstPAYFREQUENCYATTREFFDATE = drvPAYFREQUENCYATTREFFDATE
        ,lstEINATTREFFDATE = drvEINATTREFFDATE
        ,lstFTPTATTREFFDATE = drvFTPTATTREFFDATE
        ,lstFTPTINDICATOREFFDATE = drvFTPTINDICATOREFFDATE
        ,lstEMPLOYEECLASSEFFDATE = drvEMPLOYEECLASSEFFDATE
        ,lstREGTEMPEFFDATE = drvREGTEMPEFFDATE
        ,lstJOBCODEEFFDATE = drvJOBCODEEFFDATE
        ,lstJOBTITLEEFFDATE = drvJOBTITLEEFFDATE
        ,lstWORKLOCATIONEFFDATE = drvWORKLOCATIONEFFDATE
        ,lstSTANDARDHOURSEFFDATE = drvSTANDARDHOURSEFFDATE
        ,lstCOMPANYCODEEFFDATE = drvCOMPANYCODEEFFDATE
        ,lstSALARYGRADEEFFDATE = drvSALARYGRADEEFFDATE
        ,lstLEAVEREASONEFFDATE = drvLEAVEREASONEFFDATE
    FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
    END 
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EEPRNAPO_HeaderH01','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_HeaderH01;
    
    SELECT DISTINCT
         drvFILEPRODUCTIONDATE = GETDATE()
    INTO dbo.U_EEPRNAPO_HeaderH01
    ;


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_UOPX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_UOPX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'UOPX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'TEST';

--Alter the View
ALTER VIEW dbo.dsi_vwEEPRNAPO_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EEPRNAPO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEPRNAPO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

BEGIN TRANSACTION
UPDATE dbo.AscDefF
SET AdfForCond = REPLACE(CAST(AdfForCond AS VARCHAR(MAX)),'T','TT')
WHERE AdfHeaderSystemID LIKE 'EEPRNAPO%'
AND AdfSetNumber ='10'
AND AdfFieldNumber BETWEEN '24' AND '34'
ROLLBACK
COMMIT

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201810101'
       ,expStartPerControl     = '201810101'
       ,expLastEndPerControl   = '201810189'
       ,expEndPerControl       = '201810189'
WHERE expFormatCode = 'EEPRNAPO'
and expexportcode = 'TEST';

--Data validation quereis
SELECT * FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK) WHERE drvJobTitle = ''


    --------JOB NAME: Emyperian Demographic Export (EEPRNAPO) - Weekly, Wednesday, 10:00PM ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - Emyperian Demographic Export (EEPRNAPO) - Weekly, Wednesday, 10:00PM ET'
    SELECT @dbname = RTRIM(DB_NAME())

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    END

    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
            @enabled=0,
            @notify_level_eventlog=0, 
            @notify_level_email=0, 
            @notify_level_netsend=0, 
            @notify_level_page=0, 
            @delete_level=0, 
            @description=N'No description available.', 
            @category_name=N'[Uncategorized (Local)]', 
            @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (EEPRNAPO)', 
            @step_id=1, 
            @cmdexec_success_code=0, 
            @on_success_action=3, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'DECLARE @StartPerControl char(9), 
        @EndPerControl char(9), 
        @RunDate datetime; 

    SELECT @StartPerControl = CONVERT(char(8),GETDATE()-7,112) + ''1''; 
    SELECT @EndPerControl = CONVERT(char(8),GETDATE()-1,112) + ''9''; 
    SELECT @RunDate = GETDATE(); 

UPDATE dbo.AscExp
SET    expStartPerControl = @StartPerControl,
    expLastStartPerControl = @StartPerControl,
    expEndPerControl = @EndPerControl,
    expLastEndPerControl = @EndPerControl,
    expExported = @RunDate
WHERE expFormatCode = ''EEPRNAPO''
  AND expExportCode = ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (EEPRNAPO)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''EEPRNAPO'', ''SCHEDULED'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly, Wednesday, 10:00PM ET',
            @enabled=1, 
            @freq_type=8, 
            @freq_interval=8,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20180819,
            @active_end_date=99991231,
            @active_start_time=220000,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_id = @jobId, @set_owner_to_self = 0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------

    TESTING

    SELECT CmpCompanyCode, EecCoID, EecEEID, EecEmpNo, eepnamelast, eepnamefirst, EecEmplStatus, EecEmplStatusStartDate, EecDateOfOriginalHire, EecDateOfLastHire, EecDateOfTermination, EecTermReason, EecAnnSalary, EecDateLastWorked, EecPayGroup, EecDedGroupCode, EecEarnGroupCode, EecEEType, EecFullTimeOrPartTime, EecJobCode, EecLocation, eepaddressline1
FROM dbo.EmpComp WITH (NOLOCK)
JOIN dbo.Company WITH (NOLOCK) ON CmpCoID = EecCoID
JOIN dbo.EmpPers WITH (NOLOCK) ON eeceeid = eepeeid
--join dbo.EmpDed WITH (NOLOCK) on eeccoid = eedcoid and eeceeid = eedeeid
 WHERE EecEEID = 'BNKRO20010K0'


    Select * from U_EEPRNAPO_drvTblD10 where drvemployeeid = '43452'
    select * from dbo.U_EEPRNAPO_Audit where audeeid = 'BNKRO20010K0'
**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EEPRNAPO_051821]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Univeristy of Phoenix

Created By: Nicci Blady
Business Analyst: Bridget Amsden
Create Date: 08/19/2018
Service Request Number: SR-2018-00202319

Purpose: Emyperian Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
SBEEVER             05/29/2019     SR-00236839        V2.15
SBEEVER             08/28/2019     SR-00236839        V2.17
RDULANEY            11/06/2020       SR-00282940          V3.18 -- Update to gender logic

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EEPRNAPO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EEPRNAPO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EEPRNAPO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EEPRNAPO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EEPRNAPO' ORDER BY RunID DESC;

--SELECT AdhFileFormat, * FROM dbo.AscDefH WHERE AdhFormatCode = 'EEPRNAPO'
    
Job Ownership Scripts
---------------------
-- Set job owner to ssis_user for Production jobs
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 0;

-- Set job owner to self, to make changes in SQL Job Scheduler. Remember to re-run the above script to change ownership to ssis_user when complete
EXEC msdb..usg_set_job_owner @job_name = '', @set_owner_to_self = 1;

--Update Drive Mappings in U_DSI_Configuration
---------------------------------------------------
SELECT * FROM U_DSI_Configuration WHERE cfgname like '%path%' order by 4
--Prod
update U_DSI_Configuration SET cfgvalue = '\\US.SAAS\n2\APO1003\APO1003\Exports\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'TestPath'
update U_DSI_Configuration SET cfgvalue = '\\us.saas\NZ\APO1003\APO1003\Exports_TEST\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'ExportPath'

--Test
update U_DSI_Configuration SET cfgvalue = '\\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'TestPath'
update U_DSI_Configuration SET cfgvalue = '\\US.SAAS\ez\APO1003\APO1003\Exports\Empyrean\' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'ExportPath'

--Update Testing flag in U_DSI_Configuration for Production
---------------------------------------------------
update U_DSI_Configuration SET cfgvalue = 'N' WHERE formatcode = 'EEPRNAPO' AND cfgname = 'Testing'

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut_v6 @FormatCode = 'EEPRNAPO', @AllObjects = 'Y', @IsWeb = 'N'
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
    SELECT @FormatCode = 'EEPRNAPO';

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
    DELETE FROM dbo.U_EEPRNAPO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EEPRNAPO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EEPRNAPO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_AuditFields;
    CREATE TABLE dbo.U_EEPRNAPO_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecPayPeriod');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecCOID');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecUDField11');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecJobCode');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecLeaveReason');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpComp','EecIsFaculty');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpHJob','EjhSalaryGrade');
    INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('EmpMJobs','EejIsPrimaryJob');
    --INSERT INTO dbo.U_EEPRNAPO_AuditFields VALUES ('JobCode','JbcUDField1');

    --sp_help empcomp

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EEPRNAPO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_Audit;
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
        ,audAddressChgDate = CASE WHEN audFieldName LIKE 'EepAddress%' AND audAction = 'UPDATE' THEN audDateTime END
        ,audLOAEffDate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' AND audOldValue = 'A' AND audNewValue = 'L' THEN audDateTime END
        ,audReturnFromLeave = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' AND audOldValue = 'L' AND audNewValue = 'A' THEN 'Y' ELSE 'N' END
        ,audLtoAEffDate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' AND audOldValue = 'L' AND audNewValue = 'A' THEN audDateTime END
        ,audPayPeriodUpdate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audPayPeriodUpdateDate = CASE WHEN audFieldName IN('EecEmplStatus') AND audAction = 'UPDATE' THEN audDateTime END
        ,audCOIDChgDate = CASE WHEN audFieldName IN('EecCOID') AND audAction = 'UPDATE' THEN audDateTime END
        ,audFTPTChg = CASE WHEN audFieldName IN('EecFullTimeOrPartTime') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audFTPTChgDate = CASE WHEN audFieldName IN('EecFullTimeOrPartTime') AND audAction = 'UPDATE' THEN audDateTime END
        ,audUDField11ChgDate = CASE WHEN audFieldName IN('EecUDField11') AND audAction = 'UPDATE' THEN audDateTime END
        ,audJobCodeChg = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audJobCodeChgDate = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN audDateTime END
        ,audNewJobCode = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN audNewValue END
        ,audOldJobCode = CASE WHEN audFieldName IN('EecJobCode') AND audAction = 'UPDATE' THEN audOldValue END
        ,audSalGradeChgDate = CASE WHEN audFieldName IN('EjhSalaryGrade') AND audAction = 'UPDATE' THEN audDateTime END
        ,audLOARsnChgDate = CASE WHEN audFieldName IN('EecLeaveReason') AND audAction = 'UPDATE' THEN audDateTime END
        --,audJobUDField1Chg = CASE WHEN audFieldName IN('JbcUDField1') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        ,audPrimaryJobChg = CASE WHEN audFieldName IN('EejIsPrimaryJob') AND audNewValue = 'Y' THEN 'Y' ELSE 'N' END
        ,audPrimaryJobChgDate = CASE WHEN audFieldName IN('EejIsPrimaryJob') AND audNewValue = 'Y' THEN audDateTime END
        --,audIsFacultyChg = CASE WHEN audFieldName IN('EecIsFaculty') AND audAction = 'UPDATE' THEN 'Y' ELSE 'N' END
        --,audIsFacultyChgDate = CASE WHEN audFieldName IN('EecIsFaculty') AND audAction = 'UPDATE' THEN audDateTime END
        ,audClassChange = CASE WHEN audFieldName = 'EecJobCode' and audOldValue IN ('999999','AA088') and audNewValue NOT IN ('999999','AA088') then 'Y'
                               WHEN audFieldName = 'EecJobCode' and audOldValue NOT IN ('999999','AA088') and audNewValue IN ('999999','AA088') then 'Y'
                               ELSE 'N'
                               END
        ,audJobEffDate = EjhJobEffDate
    INTO dbo.U_EEPRNAPO_Audit        -- select * from dbo.U_EEPRNAPO_Audit where audeeid = '9RS27T0000K0' audftptchg = 'Y'        sp_geteeid '0988522'
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EEPRNAPO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    LEFT JOIN dbo.EmpHJob WITH (NOLOCK)
        ON left(audsystemid ,5) = left(EjhSystemID,5)
        and audKey1Value = ejheeid
        and audKey2Value = ejhcoid
        --and nullif(audKey3Value,'') is not null
    WHERE cast(audDateTime as date) >= cast(@StartDate as date)
    and cast(auddatetime as date) <= cast(@EndDate as date)
    --WHERE audDateTime BETWEEN '09-15-2018' and '09-28-2018'--@StartDate AND @EndDate
    AND audAction <> 'DELETE'
    ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EEPRNAPO_Audit ON dbo.U_EEPRNAPO_Audit (audEEID,audKey2);

    --================
    -- Only keep latest audit change per data element
    --================
    DELETE FROM dbo.U_EEPRNAPO_Audit where audRowNo > 1


    --sp_help vw_AuditData
    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EEPRNAPO_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EEPRNAPO_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Working Table (Static) 
    --==========================================
    -- Create static table to store dates **Empyrean Cannot Accept Dates Older Than Last Sent**
    -- DROP TABLE dbo.U_EEPRNAPO_LastSent
    IF OBJECT_ID('U_EEPRNAPO_LastSent','U') IS NULL
    BEGIN    
    CREATE TABLE dbo.U_EEPRNAPO_LastSent (
         lstEEID                        CHAR(12)
        ,lstCOID                        CHAR(5)
        ,lstADDRESSEFFDATE              DATETIME
        ,lstORIGINALHIREDATE            DATETIME
        ,lstLATESTHIREDATE              DATETIME
        ,lstEMPLOYMENTSTATUSEFFDATE     DATETIME
        ,lstDEATHDATEATTR               DATETIME
        ,lstTERMINATIONDATEATTR         DATETIME
        ,lstCURRENTSALARYATTREFFDATE    DATETIME
        ,lstPAYFREQUENCYATTREFFDATE     DATETIME
        ,lstEINATTREFFDATE              DATETIME
        ,lstFTPTATTREFFDATE             DATETIME
        ,lstFTPTINDICATOREFFDATE        DATETIME
        ,lstEMPLOYEECLASSEFFDATE        DATETIME
        ,lstREGTEMPEFFDATE              DATETIME
        ,lstJOBCODEEFFDATE              DATETIME
        ,lstJOBTITLEEFFDATE             DATETIME
        ,lstWORKLOCATIONEFFDATE         DATETIME
        ,lstSTANDARDHOURSEFFDATE        DATETIME
        ,lstCOMPANYCODEEFFDATE          DATETIME
        ,lstSALARYGRADEEFFDATE          DATETIME
        ,lstLEAVEREASONEFFDATE          DATETIME
    )
    ;

    END
    --sp_help U_EEPRNAPO_LastSent
    --DELETE FROM dbo.U_EEPRNAPO_LastSent
    --select * from dbo.U_EEPRNAPO_LastSent

    --Create Audit Pivot Table
    IF OBJECT_ID('U_EEPRNAPO_audPivotTable','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_audPivotTable;

    SELECT DISTINCT
         audPivEEID = audEEID
        ,audPivReturnFromLeave = MAX(audReturnFromLeave)
        ,audPivAddressChgDate = CONVERT(DATE,MAX(audAddressChgDate),112)
        ,audPivLOARsnChgDate = CONVERT(DATE,MAX(audLOARsnChgDate),112)
        ,audPivSalGradeChgDate = CONVERT(DATE,MAX(audSalGradeChgDate),112)
        ,audPivJobCodeChgDate = CONVERT(DATE,MAX(audJobCodeChgDate),112)
        ,audPivJobCodeChg = MAX(audJobCodeChg)
        ,audPivNewJobCode = MAX(audNewJobCode)
        ,audPivOldJobCode = MAX(audOldJobCode)
        ,audPivUDField11ChgDate = CONVERT(DATE,MAX(audUDField11ChgDate),112)
        ,audPivFTPTChgDate = CONVERT(DATE,MAX(audFTPTChgDate),112)
        ,audPivCOIDChgDate = CONVERT(DATE,MAX(audCOIDChgDate),112)
        ,audPivPayPeriodEffDate = CONVERT(DATE,MAX(audPayPeriodUpdateDate),112)
        ,audPivLOAReturnDate = CONVERT(DATE,MAX(audLtoAEffDate),112)
        ,audPivFTPTChg = MAX(audFTPTChg)
        ,audPivPrimaryJobChg = MAX(audPrimaryJobChg)
        ,audPivPrimaryJobChgDate = CONVERT(DATE,MAX(audPrimaryJobChgDate),112)
        --,audPivClassChg = MAX(audClassChange)
        --,audPivJobEffDate = CONVERT(DATE,MAX(audJobEffDate),112)
    INTO dbo.U_EEPRNAPO_audPivotTable
        FROM dbo.U_EEPRNAPO_Audit WITH (NOLOCK)
        WHERE COALESCE(audLtoAEffDate,audAddressChgDate,audAddressChgDate,audSalGradeChgDate,audJobCodeChgDate,audUDField11ChgDate,audFTPTChgDate,audCOIDChgDate,audPrimaryJobChgDate) IS NOT NULL
        --AND audRowNo = '1'
        GROUP BY audEEID
        ;

        --sp_help U_EEPRNAPO_audPivotTable
        --select * from dbo.U_EEPRNAPO_audPivotTable

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EEPRNAPO_drvTblD10
    ---------------------------------
    IF OBJECT_ID('U_EEPRNAPO_drvTblD10','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_drvTblD10;
    
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = ''
        ,drvSubSort2 = ''
        ,drvSubSort3 = ''
        -- standard fields above and additional driver fields below
        ,drvEMPLOYEESSN = EepSSN
        ,drvEMPLOYEEID = EecEmpNo
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAME = EepNameFirst
        ,drvBIRTHDATE = EepDateOfBirth
        ,drvGENDER = CASE WHEN EepGender IN ('F','M') THEN EepGender ELSE GenderMapping END
        ,drvADDRESS1 = EepAddressLine1
        ,drvADDRESS2 = EepAddressLine2
        ,drvCITY = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvPOSTAL = LEFT(EepAddressZipCode,5)
        ,drvCOUNTRY = LEFT(EepAddressCountry,2)
        ,drvADDRESSEFFDATE = COALESCE(audPivAddressChgDate,GETDATE())    -- JBJ based on calls with Bridget and client on 10/4/18
        ,drvHOMEPHONE = EepPhoneHomeNumber
        ,drvWORKPHONE = EecPhoneBusinessNumber
        ,drvMobilePhone = Employee_PersonalCell
        ,drvWORKEMAILADDRESS = EepAddressEMail
        ,drvORIGINALHIREDATE = EecDateOfOriginalHire
        ,drvLATESTHIREDATE = EecDateOfLastHire
        ,drvEMPLOYMENTSTATUS = case when EecEmplStatus = 'T' and EecTermReason = '203' then 'D'
                                    else EecEmplStatus
                                    END
       --drvEMPLOYMENTSTATUSEFFDATE 27
        ,drvEMPLOYMENTSTATUSEFFDATE =  CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                                     WHEN EecEmplStatus IN('T','R') THEN EecEmplStatusStartDate --EecDateOfTermination
                                                     WHEN audPivReturnFromLeave = 'Y' THEN COALESCE(EecEmplStatusStartDate,MaxJobEffDate)  --audPivLOAReturnDate)
                                                     WHEN EecDateOfLastHire < EecEmplStatusStartDate THEN EecEmplStatusStartDate
                                                     ELSE EecDateOfLastHire
                                                     END
        
        --CASE WHEN lstEMPLOYMENTSTATUSEFFDATE IS NULL OR lstEMPLOYMENTSTATUSEFFDATE < COALESCE(EecEmplStatusStartDate,EecDateOfTermination,EecStatusExpectedEndDate,audPivLOAReturnDate,EecDateOfLastHire) THEN
  --                                              CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
  --                                                   WHEN EecEmplStatus IN('T','R') THEN EecEmplStatusStartDate --EecDateOfTermination
  --                                                   WHEN audPivReturnFromLeave = 'Y' THEN COALESCE(EecEmplStatusStartDate,MaxJobEffDate)  --audPivLOAReturnDate)
  --                                                   WHEN EecDateOfLastHire < EecEmplStatusStartDate THEN EecEmplStatusStartDate
  --                                                   ELSE EecDateOfLastHire
  --                                                   END
  --                                         WHEN lstEMPLOYMENTSTATUSEFFDATE > GETDATE() THEN lstEMPLOYMENTSTATUSEFFDATE
        --                                   ELSE GETDATE()
        --                                   ---ISNULL(lstEMPLOYMENTSTATUSEFFDATE,GETDATE())
  --                                         END
        ,drvDEATHDATEATTR = CASE WHEN EepDateDeceased IS NOT NULL THEN EepDateDeceased END
        ,drvTERMINATIONDATEATTR = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END --AND (lstTERMINATIONDATEATTR IS NULL OR lstTERMINATIONDATEATTR < EecDateLastWorked) THEN EecDateOfTermination ELSE lstTERMINATIONDATEATTR END
        ,drvCURRENTANNUALSALARYATTR = CONVERT(VARCHAR(30),TRY_CONVERT(DECIMAL(12,0),EecAnnSalary*100))
        ,drvCURRENTSALARYATTREFFDATE = CASE WHEN (lstCURRENTSALARYATTREFFDATE IS NULL OR lstCURRENTSALARYATTREFFDATE < COALESCE(MaxPayRateDate,EecDateOfLastHire)) THEN COALESCE(MaxPayRateDate,EecDateOfLastHire) ELSE lstCURRENTSALARYATTREFFDATE END
        ,drvPAYFREQUENCYATTR = EecPayPeriod
        ,drvPAYFREQUENCYATTREFFDATE = CASE WHEN lstPAYFREQUENCYATTREFFDATE IS NULL OR lstPAYFREQUENCYATTREFFDATE < COALESCE(audPivPayPeriodEffDate,MaxJobEffDate) THEN COALESCE(audPivPayPeriodEffDate,MaxJobEffDate) ELSE lstPAYFREQUENCYATTREFFDATE END
        ,drvEMPLOYEREINATTR = CmpFedTaxID
        ,drvEINATTREFFDATE = CASE WHEN lstEINATTREFFDATE IS NULL OR lstEINATTREFFDATE < COALESCE(audPivCOIDChgDate,EecDateOfLastHire) THEN COALESCE(audPivCOIDChgDate,EecDateOfLastHire) 
                WHEN lstEINATTREFFDATE > GETDATE() THEN  lstEINATTREFFDATE
                ELSE GETDATE() END
        
        ,drvFTPTATTR = EecFullTimeOrPartTime
--ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ drvFTPTATTREFFDATE Field 37
        ,drvFTPTATTREFFDATE = CASE WHEN FTPTEffDate > lstFTPTINDICATOREFFDATE THEN FTPTEffDate
                                   WHEN lstFTPTATTREFFDATE > GETDATE() THEN lstFTPTATTREFFDATE 
                                   ELSE GETDATE() 
                                   END
        --COALESCE(FTPTEffDate,GETDATE())  -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
                                --CASE WHEN audPivFTPTChg = 'Y' THEN MaxJobEffDate ELSE getdate() end    -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        ,drvFTPTINDICATOR = EecFullTimeOrPartTime ---43

--ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ drvFTPTINDICATOREFFDATE field 44
        ,drvFTPTINDICATOREFFDATE = CASE WHEN FTPTEffDate > lstFTPTINDICATOREFFDATE THEN FTPTEffDate      
                                        WHEN lstFTPTINDICATOREFFDATE > GETDATE() THEN lstFTPTINDICATOREFFDATE
                                        ELSE GETDATE() 
                                        END
        --COALESCE(FTPTEffDate,GETDATE())  -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
                                --CASE WHEN audPivFTPTChg = 'Y' THEN MaxJobEffDate ELSE getdate() end    -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
       --drvEMPLOYEECLASS  field 45
        ,drvEMPLOYEECLASS = CASE WHEN EecJobCode IN('999999','AA088') THEN 'FAC' ELSE 'STF' END
--ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        -- drvEMPLOYEECLASSEFFDATE field 46
        ,drvEMPLOYEECLASSEFFDATE = isnull(MaxClassEffDate,GETDATE()) ---added coalesce
        
        --CASE WHEN ClassEffDate IS NOT NULL THEN ClassEffDate
  --                                      WHEN lstFTPTINDICATOREFFDATE > GETDATE() THEN lstFTPTINDICATOREFFDATE 
        --                                ELSE GETDATE() END            
        
        --CASE WHEN /*lstEMPLOYEECLASSEFFDATE*/ ClassEffDate IS NOT NULL THEN ClassEffDate
  --                                          --IIF(ClassEffDate > lstEMPLOYEECLASSEFFDATE, ClassEffDate, lstEMPLOYEECLASSEFFDATE)   --Updated 10/16/18 Per email request from Annie Varghese - NB
  --                                      ELSE lstFTPTINDICATOREFFDATE--ClassEffDate  --xyzx replaced EecDateOfLastHire    -- Updated 10/18/18 Per email from Annie Varghese & Phillip Ambrose - NB
  --                                      END
                                        
            --CASE WHEN /*lstEMPLOYEECLASSEFFDATE*/ ClassEffDate IS NOT NULL THEN ClassEffDate
   --                                         --IIF(ClassEffDate > lstEMPLOYEECLASSEFFDATE, ClassEffDate, lstEMPLOYEECLASSEFFDATE)   --Updated 10/16/18 Per email request from Annie Varghese - NB
   --                                     ELSE ISNULL(lstEMPLOYEECLASSEFFDATE,EecDateOfLastHire)    -- Updated 10/18/18 Per email from Annie Varghese & Phillip Ambrose - NB
   --                                     END 
                                        
                                                                                    
        --COALESCE(ClassEffDate,GETDATE())  -- JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        ,drvREGTEMP = CASE WHEN EecUDField11 = 'T' THEN 'T' ELSE 'R' END
        ,drvREGTEMPEFFDATE = COALESCE(audPivUDField11ChgDate,GETDATE())    --JBJ 10/4/18  ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ
        ,drvJOBCODE = EecJobCode
        ,drvJOBCODEEFFDATE = CASE WHEN lstJOBCODEEFFDATE IS NULL OR lstJOBCODEEFFDATE < ISNULL(audPivJobCodeChgDate,MaxJobEffDate) THEN ISNULL(audPivJobCodeChgDate,MaxJobEffDate) ELSE lstJOBCODEEFFDATE END
        ,drvJOBTITLE = CASE WHEN (EecJobTitle <> '' AND EecJobTitle IS NOT NULL) THEN EecJobTitle ELSE JbcLongDesc END 
        ,drvJOBTITLEEFFDATE = CASE WHEN lstJOBTITLEEFFDATE IS NULL OR lstJOBTITLEEFFDATE < ISNULL(audPivJobCodeChgDate,MaxJobEffDate) THEN ISNULL(audPivJobCodeChgDate,MaxJobEffDate) ELSE lstJOBTITLEEFFDATE END
        ,drvWORKLOCATION = EecLocation
        ,drvWORKLOCATIONEFFDATE = GETDATE()
        ,drvSTANDARDHOURS = CAST(CONVERT(DECIMAL(10,0),(EecScheduledAnnualHrs/52) *100) AS VARCHAR)
        ,drvSTANDARDHOURSEFFDATE = GETDATE()
        ,drvCOMPANYCODE = CmpCompanyCode
        ,drvCOMPANYCODEEFFDATE = GETDATE()
        ,drvSALARYGRADE = JbcSalaryGrade
        ,drvSALARYGRADEEFFDATE = CASE WHEN lstSALARYGRADEEFFDATE IS NULL OR lstSALARYGRADEEFFDATE < COALESCE(audPivSalGradeChgDate,EecDateOfLastHire) THEN COALESCE(audPivSalGradeChgDate,EecDateOfLastHire) ELSE lstSALARYGRADEEFFDATE END
        ,drvLEAVEREASON = CASE WHEN EecEmplStatus = 'L' THEN EecLeaveReason END
        ,drvLEAVEREASONEFFDATE = CASE WHEN EecEmplStatus = 'L' AND isnull(MaxJobEffDate,'01/01/1901') >EecEmplStatusStartDate THEN MaxJobEffDate
                                      WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                      END
        --AND (lstLEAVEREASONEFFDATE IS NULL OR lstLEAVEREASONEFFDATE < COALESCE(audPivLOARsnChgDate,EecEmplStatusStartDate)) THEN COALESCE(audPivLOARsnChgDate,EecEmplStatusStartDate) ELSE lstLEAVEREASONEFFDATE END
        ,lstADDRESSEFFDATE
        ,audPivAddressChgDate
        ,lstFTPTATTREFFDATE
        ,audPivFTPTChg
        ,MaxJobEffDate
    INTO dbo.U_EEPRNAPO_drvTblD10        --        --Select * from U_EEPRNAPO_drvTblD10 where drveeid = '9RS7P90000K0'        sp_geteeid '1001302'
    FROM dbo.U_EEPRNAPO_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_EEPRNAPO_LastSent WITH (NOLOCK)
        ON lstEEID = xEEID
    LEFT JOIN dbo.U_EEPRNAPO_audPivotTable WITH (NOLOCK)
        ON audPivEEID = xEEID
    LEFT JOIN (Select audeeid as eeid10, max(audJobEffDate) as FTPTEffDate from dbo.U_EEPRNAPO_Audit where audFTPTChg = 'Y' group by audEEID) as TmpTbl10 on xEEID = eeid10
    LEFT JOIN (Select audeeid as eeid11, max(audJobEffDate) as ClassEffDate from dbo.U_EEPRNAPO_Audit where audClassChange = 'Y' group by audEEID) as TmpTbl11 on xEEID = eeid11
    LEFT JOIN (SELECT ejhcoid AS coid3, ejheeid AS eeid3, MAX(ejhjobeffdate) AS MaxPayRateDate 
               FROM emphjob(NOLOCK) 
               --WHERE ejhisratechange = 'Y' 
               GROUP BY ejhcoid, ejheeid) AS ttl3 
        ON eeccoid = coid3
        AND eeceeid = eeid3
    LEFT JOIN (SELECT EjhCOID AS COID4, EjhEEID AS EEID4, EjhJobCode, MAX(EjhJobEffDate) AS MaxJobEffDate 
               FROM EmphJob(NOLOCK)
               GROUP BY EjhCOID, EjhEEID, EjhJobCode) AS ttl4 
        ON EecCOID = COID4
        AND EecEEID = EEID4
        AND EecJobCode = EjhJobCode
    LEFT JOIN (SELECT EejCOID AS COID9, EejEEID AS EEID9, EejJobCode, MAX(EejDateInJob) AS MaxClassEffDate 
               FROM EmpMJobs WITH (NOLOCK)
               WHERE EejIsPrimaryJob = 'Y'
               GROUP BY EejCOID, EejEEID, EejJobCode) AS ttl9 
        ON EecCOID = COID9
        AND EecEEID = EEID9
        AND EecJobCode = EejJobCode
    LEFT JOIN [dbo].[fn_MP_CustomFields_EmpPers_Export](null, null, null, null)
        ON EEID = xEEID
    JOIN ULTIPRO_SYSTEM.dbo.CountryISOCode WITH (NOLOCK)
        ON EepAddressCountry = cicCountryCode
    LEFT JOIN dbo.EmployeeGender WITH (NOLOCK)
        ON GenderCode = EepGender
    WHERE (EecEmplStatus <> 'T' OR EecDateOfTermination >= DATEADD(MM,-12,GETDATE()))
    ;
     
    -- Populate/Update static table to store dates **Empyrean Cannot Accept Dates Older Than Last Sent**
    -- DROP TABLE dbo.U_EEPRNAPO_LastSent
    IF EXISTS (SELECT DISTINCT drvEEID, drvCOID 
               FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
               JOIN dbo.U_EEPRNAPO_LastSent WITH (NOLOCK) 
                    ON drvEEID = lstEEID AND drvCOID = lstCOID)
    BEGIN
    UPDATE dbo.U_EEPRNAPO_LastSent
    SET  
         lstADDRESSEFFDATE = drvADDRESSEFFDATE
        ,lstORIGINALHIREDATE = drvORIGINALHIREDATE
        ,lstLATESTHIREDATE = drvLATESTHIREDATE
        ,lstEMPLOYMENTSTATUSEFFDATE = drvEMPLOYMENTSTATUSEFFDATE
        ,lstDEATHDATEATTR = drvDEATHDATEATTR
        ,lstTERMINATIONDATEATTR = drvTERMINATIONDATEATTR
        ,lstCURRENTSALARYATTREFFDATE = drvCURRENTSALARYATTREFFDATE
        ,lstPAYFREQUENCYATTREFFDATE = drvPAYFREQUENCYATTREFFDATE
        ,lstEINATTREFFDATE = drvEINATTREFFDATE
        ,lstFTPTATTREFFDATE = drvFTPTATTREFFDATE
        ,lstFTPTINDICATOREFFDATE = drvFTPTINDICATOREFFDATE
        ,lstEMPLOYEECLASSEFFDATE = drvEMPLOYEECLASSEFFDATE
        ,lstREGTEMPEFFDATE = drvREGTEMPEFFDATE
        ,lstJOBCODEEFFDATE = drvJOBCODEEFFDATE
        ,lstJOBTITLEEFFDATE = drvJOBTITLEEFFDATE
        ,lstWORKLOCATIONEFFDATE = drvWORKLOCATIONEFFDATE
        ,lstSTANDARDHOURSEFFDATE = drvSTANDARDHOURSEFFDATE
        ,lstCOMPANYCODEEFFDATE = drvCOMPANYCODEEFFDATE
        ,lstSALARYGRADEEFFDATE = drvSALARYGRADEEFFDATE
        ,lstLEAVEREASONEFFDATE = drvLEAVEREASONEFFDATE
        FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
        WHERE lstEEID = drvEEID AND drvCOID = lstCOID;
    END

    IF NOT EXISTS (SELECT DISTINCT drvEEID, drvCOID 
               FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
               JOIN dbo.U_EEPRNAPO_LastSent WITH (NOLOCK) 
                    ON drvEEID = lstEEID AND drvCOID = lstCOID)
    BEGIN
    INSERT INTO dbo.U_EEPRNAPO_LastSent
    SELECT DISTINCT 
         lstEEID = drvEEID
        ,lstCOID = drvCOID
        ,lstADDRESSEFFDATE = drvADDRESSEFFDATE
        ,lstORIGINALHIREDATE = drvORIGINALHIREDATE
        ,lstLATESTHIREDATE = drvLATESTHIREDATE
        ,lstEMPLOYMENTSTATUSEFFDATE = drvEMPLOYMENTSTATUSEFFDATE
        ,lstDEATHDATEATTR = drvDEATHDATEATTR
        ,lstTERMINATIONDATEATTR = drvTERMINATIONDATEATTR
        ,lstCURRENTSALARYATTREFFDATE = drvCURRENTSALARYATTREFFDATE
        ,lstPAYFREQUENCYATTREFFDATE = drvPAYFREQUENCYATTREFFDATE
        ,lstEINATTREFFDATE = drvEINATTREFFDATE
        ,lstFTPTATTREFFDATE = drvFTPTATTREFFDATE
        ,lstFTPTINDICATOREFFDATE = drvFTPTINDICATOREFFDATE
        ,lstEMPLOYEECLASSEFFDATE = drvEMPLOYEECLASSEFFDATE
        ,lstREGTEMPEFFDATE = drvREGTEMPEFFDATE
        ,lstJOBCODEEFFDATE = drvJOBCODEEFFDATE
        ,lstJOBTITLEEFFDATE = drvJOBTITLEEFFDATE
        ,lstWORKLOCATIONEFFDATE = drvWORKLOCATIONEFFDATE
        ,lstSTANDARDHOURSEFFDATE = drvSTANDARDHOURSEFFDATE
        ,lstCOMPANYCODEEFFDATE = drvCOMPANYCODEEFFDATE
        ,lstSALARYGRADEEFFDATE = drvSALARYGRADEEFFDATE
        ,lstLEAVEREASONEFFDATE = drvLEAVEREASONEFFDATE
    FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK)
    END 
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EEPRNAPO_HeaderH01','U') IS NOT NULL
        DROP TABLE dbo.U_EEPRNAPO_HeaderH01;
    
    SELECT DISTINCT
         drvFILEPRODUCTIONDATE = GETDATE()
    INTO dbo.U_EEPRNAPO_HeaderH01
    ;


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_UOPX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_UOPX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'UOPX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

EXEC dbo.dsi_sp_TestSwitchbox_v2 'EEPRNAPO', 'TEST';

--Alter the View
ALTER VIEW dbo.dsi_vwEEPRNAPO_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_EEPRNAPO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EEPRNAPO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

BEGIN TRANSACTION
UPDATE dbo.AscDefF
SET AdfForCond = REPLACE(CAST(AdfForCond AS VARCHAR(MAX)),'T','TT')
WHERE AdfHeaderSystemID LIKE 'EEPRNAPO%'
AND AdfSetNumber ='10'
AND AdfFieldNumber BETWEEN '24' AND '34'
ROLLBACK
COMMIT

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202105041'
       ,expStartPerControl     = '202105049'
       ,expLastEndPerControl   = '202105181'
       ,expEndPerControl       = '202105189'
WHERE expFormatCode = 'EEPRNAPO'
and expexportcode = 'TEST';

--Data validation quereis
SELECT * FROM dbo.U_EEPRNAPO_drvTblD10 WITH (NOLOCK) WHERE drvJobTitle = ''


    --------JOB NAME: Emyperian Demographic Export (EEPRNAPO) - Weekly, Wednesday, 10:00PM ET--------
    --Copy and paste this in environment to create job script

    BEGIN TRANSACTION
    DECLARE @ReturnCode INT, @JobName varchar(100), @dbName varchar(50)
    SELECT @ReturnCode = 0
    SELECT @JobName = RTRIM(REPLACE(DB_NAME(),'ULTIPRO_','')) + ' - Emyperian Demographic Export (EEPRNAPO) - Weekly, Wednesday, 10:00PM ET'
    SELECT @dbname = RTRIM(DB_NAME())

    -- Job Params
    IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
    BEGIN
    EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    END

    DECLARE @jobId BINARY(16)
    EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=@JobName, 
            @enabled=0,
            @notify_level_eventlog=0, 
            @notify_level_email=0, 
            @notify_level_netsend=0, 
            @notify_level_page=0, 
            @delete_level=0, 
            @description=N'No description available.', 
            @category_name=N'[Uncategorized (Local)]', 
            @job_id = @jobId OUTPUT
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step [Run]
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Update AscExp'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update AscExp Start/End Date (EEPRNAPO)', 
            @step_id=1, 
            @cmdexec_success_code=0, 
            @on_success_action=3, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'DECLARE @StartPerControl char(9), 
        @EndPerControl char(9), 
        @RunDate datetime; 

    SELECT @StartPerControl = CONVERT(char(8),GETDATE()-7,112) + ''1''; 
    SELECT @EndPerControl = CONVERT(char(8),GETDATE()-1,112) + ''9''; 
    SELECT @RunDate = GETDATE(); 

UPDATE dbo.AscExp
SET    expStartPerControl = @StartPerControl,
    expLastStartPerControl = @StartPerControl,
    expEndPerControl = @EndPerControl,
    expLastEndPerControl = @EndPerControl,
    expExported = @RunDate
WHERE expFormatCode = ''EEPRNAPO''
  AND expExportCode = ''SCHEDULED'';',
            @database_name=@dbName,
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

    -- Step 'Run SP'
    EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Export File (EEPRNAPO)', 
            @step_id=2, 
            @cmdexec_success_code=0, 
            @on_success_action=1, 
            @on_success_step_id=0, 
            @on_fail_action=2, 
            @on_fail_step_id=0, 
            @retry_attempts=0, 
            @retry_interval=0, 
            @os_run_priority=0, @subsystem=N'TSQL', 
            @command=N'EXEC dbo.dsi_sp_TestSwitchbox_v2 ''EEPRNAPO'', ''SCHEDULED'';', 
            @database_name=@dbName, 
            @flags=0
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
    EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly, Wednesday, 10:00PM ET',
            @enabled=1, 
            @freq_type=8, 
            @freq_interval=8,  
            @freq_subday_type=1, 
            @freq_subday_interval=0, 
            @freq_relative_interval=0,
            @freq_recurrence_factor=1,
            @active_start_date=20180819,
            @active_end_date=99991231,
            @active_start_time=220000,
            @active_end_time=235959;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)';
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    EXEC msdb..usg_set_job_owner @job_id = @jobId, @set_owner_to_self = 0;
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
    COMMIT TRANSACTION
    GOTO EndSave;
    QuitWithRollback:
        IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
    EndSave:

    GO
    --------END JOB SCRIPT--------

    TESTING

    SELECT CmpCompanyCode, EecCoID, EecEEID, EecEmpNo, eepnamelast, eepnamefirst, EecEmplStatus, EecEmplStatusStartDate, EecDateOfOriginalHire, EecDateOfLastHire, EecDateOfTermination, EecTermReason, EecAnnSalary, EecDateLastWorked, EecPayGroup, EecDedGroupCode, EecEarnGroupCode, EecEEType, EecFullTimeOrPartTime, EecJobCode, EecLocation, eepaddressline1
FROM dbo.EmpComp WITH (NOLOCK)
JOIN dbo.Company WITH (NOLOCK) ON CmpCoID = EecCoID
JOIN dbo.EmpPers WITH (NOLOCK) ON eeceeid = eepeeid
--join dbo.EmpDed WITH (NOLOCK) on eeccoid = eedcoid and eeceeid = eedeeid
 WHERE EecEEID = 'BNKRO20010K0'


    Select * from U_EEPRNAPO_drvTblD10 where drvemployeeid = '43452'
    select * from dbo.U_EEPRNAPO_Audit where audeeid = 'BNKRO20010K0'
**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEEPRNAPO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EEPRNAPO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2, SubSort3