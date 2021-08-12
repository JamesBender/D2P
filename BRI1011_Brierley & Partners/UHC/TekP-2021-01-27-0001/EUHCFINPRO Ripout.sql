SET NOCOUNT ON;
IF OBJECT_ID('U_EUHCFINPRO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUHCFINPRO_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUHCFINPRO' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUHCFINPRO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUHCFINPRO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUHCFINPRO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFINPRO];
GO
IF OBJECT_ID('U_EUHCFINPRO_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_Trailer];
GO
IF OBJECT_ID('U_EUHCFINPRO_Header') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_Header];
GO
IF OBJECT_ID('U_EUHCFINPRO_File') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_File];
GO
IF OBJECT_ID('U_EUHCFINPRO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_EEList];
GO
IF OBJECT_ID('U_EUHCFINPRO_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_drvTbl];
GO
IF OBJECT_ID('U_EUHCFINPRO_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_DedList];
GO
IF OBJECT_ID('U_EUHCFINPRO_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_AuditFields];
GO
IF OBJECT_ID('U_EUHCFINPRO_Audit') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUHCFINPRO';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUHCFINPRO';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUHCFINPRO';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUHCFINPRO';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUHCFINPRO';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EUHCFINPRO','United Health Care Financial Protection','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','495','S','N','EUHCFINPROZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUHCFINPRO' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''SS''=''F'')','EUHCFINPROZ0','48','H','01','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HEADER RECORD"','2','(''DA''=''F'')','EUHCFINPROZ0','13','H','01','49',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EUHCFINPROZ0','1','H','01','62',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TBD"','4','(''DA''=''F'')','EUHCFINPROZ0','8','H','01','63',NULL,'Client Job Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EUHCFINPROZ0','1','H','01','71',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateCreated"','6','(''UD112''=''F'')','EUHCFINPROZ0','8','H','01','72',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EUHCFINPROZ0','355','H','01','80',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''F'')','EUHCFINPROZ0','9','D','10','1',NULL,'Subscriber ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberIndicator"','2','(''UA''=''F'')','EUHCFINPROZ0','2','D','10','10',NULL,'Member Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','3','(''UA''=''F'')','EUHCFINPROZ0','35','D','10','12',NULL,'Member Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''F'')','EUHCFINPROZ0','15','D','10','47',NULL,'Member First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','5','(''UA''=''F'')','EUHCFINPROZ0','2','D','10','62',NULL,'Member Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''F'')','EUHCFINPROZ0','1','D','10','64',NULL,'Member Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','7','(''UA''=''F'')','EUHCFINPROZ0','40','D','10','65',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','8','(''UA''=''F'')','EUHCFINPROZ0','40','D','10','105',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','9','(''UA''=''F'')','EUHCFINPROZ0','19','D','10','145',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','10','(''UA''=''F'')','EUHCFINPROZ0','2','D','10','164',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','11','(''UA''=''F'')','EUHCFINPROZ0','5','D','10','166',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipSuffix"','12','(''UA''=''F'')','EUHCFINPROZ0','4','D','10','171',NULL,'Zip Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','13','(''UA''=''F'')','EUHCFINPROZ0','12','D','10','175',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','14','(''UA''=''F'')','EUHCFINPROZ0','12','D','10','187',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''F'')','EUHCFINPROZ0','1','D','10','199',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','16','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','200',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0909812"','17','(''DA''=''F'')','EUHCFINPROZ0','30','D','10','208',NULL,'Group Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2001"','18','(''DA''=''F'')','EUHCFINPROZ0','30','D','10','238',NULL,'Subgrp Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenStartDate"','19','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','268',NULL,'Emp Sub-Grp Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode"','20','(''UA''=''F'')','EUHCFINPROZ0','10','D','10','276',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenStartDate"','21','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','286',NULL,'Plan Code Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTierCode"','22','(''UA''=''F'')','EUHCFINPROZ0','2','D','10','294',NULL,'Tier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberOrigEffDate"','23','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','296',NULL,'Member Original Eff Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','24','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','304',NULL,'Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAlternateID"','25','(''UA''=''F'')','EUHCFINPROZ0','9','D','10','312',NULL,'ALT-ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStudentStatus"','26','(''UA''=''F'')','EUHCFINPROZ0','1','D','10','321',NULL,'Student Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHandicapped"','27','(''UA''=''F'')','EUHCFINPROZ0','1','D','10','322',NULL,'Handicapped',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageWritten"','28','(''UA''=''F'')','EUHCFINPROZ0','3','D','10','323',NULL,'Written Preference Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageWrittenEffDate"','29','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','326',NULL,'Written Preference Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageSpoken"','30','(''UA''=''F'')','EUHCFINPROZ0','3','D','10','334',NULL,'Spoken Preference Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageSpokenEffDate"','31','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','337',NULL,'Spoken Preference Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndicatorCALAP"','32','(''UA''=''F'')','EUHCFINPROZ0','1','D','10','345',NULL,'CALAP Eligibility Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','33','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','346',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubscriberClassID"','34','(''UA''=''F'')','EUHCFINPROZ0','4','D','10','354',NULL,'Subscriber Class Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubClassEffDate"','35','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','358',NULL,'Subscriber Class Effective date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryType"','36','(''UA''=''F'')','EUHCFINPROZ0','1','D','10','366',NULL,'Salary Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','37','(''UA''=''F'')','EUHCFINPROZ0','10','D','10','367',NULL,'Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffDate"','38','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','377',NULL,'Salary Effective date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageAmount"','39','(''UA''=''F'')','EUHCFINPROZ0','10','D','10','385',NULL,'Plan Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageAmountEffDate"','40','(''UD112''=''F'')','EUHCFINPROZ0','8','D','10','395',NULL,'Plan Coverage Amount Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''SS''=''F'')','EUHCFINPROZ0','8','D','10','403',NULL,'Student Status Effective date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''SS''=''F'')','EUHCFINPROZ0','8','D','10','411',NULL,'Student Status Term date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''F'')','EUHCFINPROZ0','8','D','10','419',NULL,'Handicap Effective date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''SS''=''F'')','EUHCFINPROZ0','8','D','10','427',NULL,'Handicap Term date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvALTMemberIndicator"','45','(''UA''=''F'')','EUHCFINPROZ0','11','D','10','435',NULL,'ALT Member Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''F'')','EUHCFINPROZ0','49','D','10','446',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''SS''=''F'')','EUHCFINPROZ0','48','T','90','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TRAILER RECORD"','2','(''DA''=''F'')','EUHCFINPROZ0','14','T','90','49',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EUHCFINPROZ0','1','T','90','63',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientJobNumber"','4','(''UA''=''F'')','EUHCFINPROZ0','8','T','90','64',NULL,'Client Job Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EUHCFINPROZ0','1','T','90','72',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','6','(''UNT0''=''F'')','EUHCFINPROZ0','9','T','90','73',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','EUHCFINPROZ0','353','T','90','82',NULL,'Filler',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUHCFINPRO_20210806.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202105039','EMPEXPORT','OEACTIVE',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202105039','May  3 2021  1:27PM','May  3 2021  1:27PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202105039','EMPEXPORT','OEPASSIVE',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202105039','May  3 2021  1:27PM','May  3 2021  1:27PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC Financial Protection','202105039','EMPEXPORT','ONDEM_XOE',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202105039','May  3 2021  1:27PM','May  3 2021  1:27PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC Financial Protection-Sched','202105039','EMPEXPORT','SCH_EUHCFI',NULL,'EUHCFINPRO',NULL,NULL,NULL,'202105039','May  3 2021  1:27PM','May  3 2021  1:27PM','202105031',NULL,'','','202105031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'UHC Financial Protection-Test','202106221','EMPEXPORT','TEST_XOE','Aug  2 2021  2:25PM','EUHCFINPRO',NULL,NULL,NULL,'202106221','Jun 22 2021 12:00AM','Dec 30 1899 12:00AM','202106221','718','','','202106221',dbo.fn_GetTimedKey(),NULL,'us3rVaBRI1011',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFINPRO','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUHCFINPRO' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUHCFINPRO' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUHCFINPRO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCFINPRO_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFINPRO','H01','dbo.U_EUHCFINPRO_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFINPRO','D10','dbo.U_EUHCFINPRO_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFINPRO','T90','dbo.U_EUHCFINPRO_Trailer',NULL);
IF OBJECT_ID('U_EUHCFINPRO_Audit') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audDateTime] datetime NULL
);
IF OBJECT_ID('U_EUHCFINPRO_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EUHCFINPRO_DedList') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUHCFINPRO_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvDedGroupCode] varchar(5) NULL,
    [drvSort] char(12) NULL,
    [drvSubSort] varchar(2) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvMemberIndicator] varchar(2) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvRelationship] varchar(2) NOT NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvAddressZipSuffix] varchar(1) NOT NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvBenStartDate] datetime NULL,
    [drvPlanCode] varchar(8) NULL,
    [drvTierCode] varchar(1) NULL,
    [drvMemberOrigEffDate] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvAlternateID] varchar(1) NOT NULL,
    [drvStudentStatus] varchar(1) NOT NULL,
    [drvHandicapped] char(1) NULL,
    [drvLanguageWritten] char(2) NOT NULL,
    [drvLanguageWrittenEffDate] datetime NULL,
    [drvLanguageSpoken] char(2) NOT NULL,
    [drvLanguageSpokenEffDate] datetime NULL,
    [drvIndicatorCALAP] varchar(1) NOT NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvSubscriberClassID] varchar(4) NULL,
    [drvSubClassEffDate] datetime NULL,
    [drvSalaryType] varchar(1) NULL,
    [drvAnnSalary] varchar(10) NULL,
    [drvSalaryEffDate] datetime NULL,
    [drvCoverageAmount] money NULL,
    [drvCoverageAmountEffDate] datetime NULL,
    [drvALTMemberIndicator] varchar(11) NOT NULL
);
IF OBJECT_ID('U_EUHCFINPRO_EEList') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUHCFINPRO_File') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(495) NULL
);
IF OBJECT_ID('U_EUHCFINPRO_Header') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_Header] (
    [drvDateCreated] date NULL
);
IF OBJECT_ID('U_EUHCFINPRO_Trailer') IS NULL
CREATE TABLE [dbo].[U_EUHCFINPRO_Trailer] (
    [drvClientJobNumber] varchar(1) NOT NULL,
    [drvRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFINPRO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Brierley & Partners

Created By: Keary McCutchen
Business Analyst: Richard Vars
Create Date: 05/03/2021
Service Request Number: SR-2020-00300150

Purpose: United Health Care Financial Protection

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCFINPRO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCFINPRO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCFINPRO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUHCFINPRO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUHCFINPRO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFINPRO', 'SCH_EUHCFI';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUHCFINPRO';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUHCFINPRO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUHCFINPRO';

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
    DELETE FROM dbo.U_EUHCFINPRO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUHCFINPRO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Cleans EE List of Employees Where EecEmpType = TES
    DELETE EEList
    FROM dbo.U_EUHCFINPRO_EEList EEList
    INNER 
     JOIN dbo.EmpComp WITH (NOLOCK)
      ON EecEEID = xEEID
     AND EecCoID = xCoID
     AND EecEEType = 'TES';

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EUHCFINPRO_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_AuditFields;
    CREATE TABLE dbo.U_EUHCFINPRO_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('Contacts','ConIsStudent');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('EmpComp','EecLanguageCode');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EUHCFINPRO_AuditFields VALUES ('EmpPers','EepIsDisabled');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EUHCFINPRO_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_Audit;
    SELECT 
         audEEID  = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        --,audAction
        ,audDateTime = MAX(audDateTime)
        --,audOldValue
        --,audNewValue
        --,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EUHCFINPRO_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EUHCFINPRO_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
        AND audAction <> 'Delete'
    WHERE audDateTime <= @EndDate
    GROUP BY audKey1Value
            ,audKey2Value
            ,audKey3Value
            ,audTableName
            ,audFieldName
    ;
    -- Create Index

    CREATE CLUSTERED INDEX CDX_U_EUHCFINPRO_Audit ON dbo.U_EUHCFINPRO_Audit (audEEID,audCOID);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GTLEX,ADDCX,CIE20,CIS10,CIS5,ACC,HSPL,HSPH,STDER,LTDEX,GTLEE,ADDCE,LIFEE,LIFES,LIFEC,CIE20,CIS5,ACCL,LTD';

    IF OBJECT_ID('U_EUHCFINPRO_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUHCFINPRO_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUHCFINPRO_drvTbl
    -- Employee Data
    ---------------------------------
    IF OBJECT_ID('U_EUHCFINPRO_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvDedGroupCode = RTRIM(LTRIM(EecDedGroupCode))
        ,drvSort = xEEID
        ,drvSubSort = '00'
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvMemberIndicator = '  '
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvRelationship = 'EE'
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipCode
        ,drvAddressZipSuffix = ''
        ,drvHomePhone = ''
        ,drvWorkPhone = ''
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, '8/1/2021')
        ,drvPlanCode = CASE
                            WHEN RTRIM(LTRIM(EedDedCode)) = 'GTLEX' THEN 'LE000886'
                            WHEN RTRIM(LTRIM(EedDedCode)) = 'ADDCX' THEN 'LE000887'
                            WHEN RTRIM(LTRIM(EedDedCode)) = 'LIFEE' THEN 'LE000019'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'LIFES'THEN 'LE000123'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000006'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000007'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 7500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000008'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 10000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000009'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'CIE20' THEN 'LE000137'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'CIS10' THEN 'LE000138'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000079'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000251'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL)  AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002232'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002233'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002234'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002235'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002236'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002237'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002238'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002239'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001924'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001925'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001926'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001927'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001928'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001929'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001930'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001931'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) = 'STDER' THEN 'LE000379'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) = 'EXEC' AND RTRIM(LTRIM(EedDedCode)) IN ('LTD','LTDEX') THEN 'LE000770'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'GTLEE' THEN 'LE001502'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'ADDCE' THEN 'LE001503'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'LIFEE' THEN 'LE000019'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'LIFES'THEN 'LE000123'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000006'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000007'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 7500 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000008'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 10000 AND RTRIM(LTRIM(EedDedCode)) = 'LIFEC' THEN 'LE000009'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'CIE20' THEN 'LE000137'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'CIS10' THEN 'LE000138'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 2500 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000079'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND EedBenAmt = 5000 AND RTRIM(LTRIM(EedDedCode)) = 'CIS5' THEN 'LE000251'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002232'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002233'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002234'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACCL' THEN 'LE002235'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002236'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002237'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002238'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'ACC' THEN 'LE002239'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001924'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001925'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001926'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPL' THEN 'LE001927'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND (RTRIM(LTRIM(EedBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(EedBenOption)) IS NULL) AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001928'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EES' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001929'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEC' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001930'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedBenOption)) = 'EEF' AND RTRIM(LTRIM(EedDedCode)) = 'HSPH' THEN 'LE001931'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) = 'STDER' THEN 'LE000379'
                            WHEN RTRIM(LTRIM(EecDedGroupCode)) IN ('FT','PT') AND RTRIM(LTRIM(EedDedCode)) IN ('LTD','LTDEX') THEN 'LE000016'
                        END
        ,drvTierCode = CASE
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EEF' THEN 'A'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EES' THEN 'B'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EE' THEN 'C'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('GTLEX','ADDCX','LIFEE','CIE20','STDER','LTDEX','LTD','GTLEE','ADDCE') THEN 'C'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND EedBenOption = 'EEC' THEN 'D'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('LIFES','CIS10') THEN 'F'
                            WHEN RTRIM(LTRIM(EedDedCode)) IN ('LIFEC','CIS5') THEN 'G'
                        END
        ,drvMemberOrigEffDate = dbo.dsi_fnGetMinMaxDates('MAX', EecDateOfLastHire, '8/1/2021') 
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvAlternateID = ''
        ,drvStudentStatus = ''
        ,drvHandicapped = EepIsDisabled
        ,drvLanguageWritten =  EecLanguageCode
        ,drvLanguageWrittenEffDate = (SELECT TOP 1 audDateTime FROM dbo.U_EUHCFINPRO_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCoID AND audFieldName = 'EecLanguageCode')
        ,drvLanguageSpoken = EecLanguageCode
        ,drvLanguageSpokenEffDate = (SELECT TOP 1 audDateTime FROM dbo.U_EUHCFINPRO_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCoID AND audFieldName = 'EecLanguageCode')
        ,drvIndicatorCALAP = ''
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvSubscriberClassID = CASE WHEN EecDedGroupCode = 'EXEC' THEN '2001'
                                     WHEN EecDedGroupCode IN ('FT','PT') THEN '2002'
                                 END
        ,drvSubClassEffDate = dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, '8/1/2021') 
        ,drvSalaryType = CASE WHEN EedDedCode IN ('STDER','LTDEX','LTD') THEN 'A' END 
        ,drvAnnSalary = CONVERT(VARCHAR(10), CASE WHEN EedDedCode IN ('STDER','LTDEX','LTD') THEN EecAnnSalary END)
        ,drvSalaryEffDate = CASE WHEN EedDedCode IN ('STDER','LTDEX','LTD') THEN  dbo.dsi_fnGetMinMaxDates('MAX', (SELECT TOP 1 audDateTime FROM dbo.U_EUHCFINPRO_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCoID AND audFieldName = 'EecAnnSalary') , '8/1/2021') END 
        ,drvCoverageAmount = CASE WHEN EedDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') THEN EedBenAmt END
        ,drvCoverageAmountEffDate = CASE WHEN EedDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE', 'HSPH', 'STDER', 'LIFEC', 'LTDEX', 'HSPL', 'ACCL', 'ACC') THEN dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, '8/1/2021') END
        ,drvALTMemberIndicator = '00000      '
    INTO dbo.U_EUHCFINPRO_drvTbl
    FROM dbo.U_EUHCFINPRO_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
        AND EedBenStatus = 'A'
    ;
      ---------------------------------
    -- DETAIL RECORD - U_EUHCFINPRO_drvTbl
    -- Dependents Data
    ---------------------------------
    INSERT INTO dbo.U_EUHCFINPRO_drvTbl
    SELECT DISTINCT
         drvEEID
        ,drvCoID
        ,drvDepRecID = CONVERT(varchar(12),DbnDepRecID) --DELETE IF NOT USING DEPENDENT DATA
        ,drvDedGroupCode
        ,drvSort = drvEEID
        ,drvSubSort = '01'
        -- standard fields above and additional driver fields below
        ,drvSSN 
        ,drvMemberIndicator = '  '/*CASE 
                                    WHEN ConRelationship IN ('DP','SP') THEN '01'
                                    WHEN ConRelationship IN ('CHL','DPC','STC','CH') THEN '99'
                              END*/
        ,drvNameLast = ConNameLast
        ,drvNameFirst = ConNameFirst
        ,drvRelationship = CASE 
                                    WHEN ConRelationship IN ('DP','SP') THEN 'SP'
                                    WHEN ConRelationship IN ('CHL','DPC','STC','CH') THEN 'CH'
                              END
        ,drvNameMiddle = LEFT(ConNameMiddle,1)
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvAddressCity = ConAddressCity
        ,drvAddressState = ConAddressState
        ,drvAddressZip = ConAddressZipCode
        ,drvAddressZipSuffix = ''
        ,drvHomePhone = ''
        ,drvWorkPhone = ''
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvBenStartDate = dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, '8/1/2021')
        ,drvPlanCode = CASE
                            WHEN RTRIM(LTRIM(DbnDedCode)) = 'GTLEX' THEN 'LE000886'
                            WHEN RTRIM(LTRIM(DbnDedCode)) = 'ADDCX' THEN 'LE000887'
                            WHEN RTRIM(LTRIM(DbnDedCode)) = 'LIFEE' THEN 'LE000019'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'LIFES'THEN 'LE000123'
                            WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000006'
                            WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000007'
                            WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 7500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000008'
                            WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 10000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000009'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'CIE20' THEN 'LE000137'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'CIS10' THEN 'LE000138'
                            WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000079'
                            WHEN drvDedGroupCode = 'EXEC' AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000251'
                            WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL)  AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002232'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002233'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002234'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002235'
                            WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002236'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002237'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002238'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002239'
                            WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001924'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001925'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001926'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001927'
                            WHEN drvDedGroupCode = 'EXEC' AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001928'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001929'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001930'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001931'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'STDER' THEN 'LE000379'
                            WHEN drvDedGroupCode = 'EXEC' AND RTRIM(LTRIM(DbnDedCode)) = 'LTDEX' THEN 'LE000770'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'GTLEE' THEN 'LE001502'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'ADDCE' THEN 'LE001503'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEE' THEN 'LE000019'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LIFES'THEN 'LE000123'
                            WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000006'
                            WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000007'
                            WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 7500 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000008'
                            WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 10000 AND RTRIM(LTRIM(DbnDedCode)) = 'LIFEC' THEN 'LE000009'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'CIE20' THEN 'LE000137'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'CIS10' THEN 'LE000138'
                            WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 2500 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000079'
                            WHEN drvDedGroupCode IN ('FT','PT') AND DedEEBenAmt = 5000 AND RTRIM(LTRIM(DbnDedCode)) = 'CIS5' THEN 'LE000251'
                            WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002232'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002233'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002234'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACCL' THEN 'LE002235'
                            WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002236'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002237'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002238'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'ACC' THEN 'LE002239'
                            WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001924'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001925'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001926'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPL' THEN 'LE001927'
                            WHEN drvDedGroupCode IN ('FT','PT') AND (RTRIM(LTRIM(DbnBenOption)) IN ('EE','Z') OR RTRIM(LTRIM(DbnBenOption)) IS NULL) AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001928'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EES' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001929'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEC' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001930'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnBenOption)) = 'EEF' AND RTRIM(LTRIM(DbnDedCode)) = 'HSPH' THEN 'LE001931'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'STDER' THEN 'LE000379'
                            WHEN drvDedGroupCode IN ('FT','PT') AND RTRIM(LTRIM(DbnDedCode)) = 'LTDEX' THEN 'LE000016'
                        END
        ,drvTierCode = CASE
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EEF' THEN 'A'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EES' THEN 'B'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EE' THEN 'C'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('GTLEX','ADDCX','LIFEE','CIE20','STDER','LTDEX','LTD','GTLEE','ADDCE') THEN 'C'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('ACCL','ACC','HSPL','HSPH') AND DbnBenOption = 'EEC' THEN 'D'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('LIFES','CIS10') THEN 'F'
                            WHEN RTRIM(LTRIM(DbnDedCode)) IN ('LIFEC','CIS5') THEN 'G'
                        END
        ,drvMemberOrigEffDate 
        ,drvDateOfTermination 
        ,drvAlternateID 
        ,drvStudentStatus
        ,drvHandicapped = ConIsDisabled
        ,drvLanguageWritten 
        ,drvLanguageWrittenEffDate
        ,drvLanguageSpoken 
        ,drvLanguageSpokenEffDate
        ,drvIndicatorCALAP 
        ,drvDateOfOriginalHire
        ,drvSubscriberClassID 
        ,drvSubClassEffDate = dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, '8/1/2021')
        ,drvSalaryType 
        ,drvAnnSalary 
        ,drvSalaryEffDate
        ,drvCoverageAmount = CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE') THEN DedEEBenAmt END
        ,drvCoverageAmountEffDate = CASE WHEN DbnDedCode IN ('GTLEX','ADDCX','LIFEE','LIFES','CIE20','CIS10','GTLEE','ADDCE','HSPH','STDER','LIFEC','LTDEX','HSPL','ACCL','ACC') THEN dbo.dsi_fnGetMinMaxDates('MAX', DbnBenStartDate, '8/1/2021') END
        ,drvALTMemberIndicator = RTRIM(LTRIM(ConSSN))+'00'
    FROM dbo.U_EUHCFINPRO_drvTbl
    JOIN dbo.Contacts WITH (NOLOCK)
        On ConEEID = drvEEID
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = drvEEID 
        AND DbnCoID = drvCoID
        AND DbnDepRecID = ConSystemID
        AND DbnFormatCode = 'EUHCFINPRO'--@FormatCode 
        AND DbnValidForExport = 'Y'
        AND DbnBenStatus = 'A'
    ;
    
    ---------------------------------
    -- DETAIL RECORD - U_EUHCFINPRO_MemberID_drvTbl
    -- This calculates the Child's Member ID and Updates the Driver Tables
    ---------------------------------
    UPDATE dbo.U_EUHCFINPRO_drvTbl
            SET drvMemberIndicator = '  '--RIGHT('00' + CAST(tmpMemberIndicator AS VARCHAR(2)),2)
               ,drvSubSort = RIGHT('00' + CAST(tmpMemberIndicator AS VARCHAR(2)),2)
    FROM dbo.U_EUHCFINPRO_drvTbl
    INNER JOIN (SELECT tmpEEID = drvEEID
                      ,tmpDepRecID = drvDepRecID
                      ,tmpMemberIndicator = ROW_NUMBER() OVER (PARTITION BY DRVEEID ORDER BY drvDepRecID)  + 1
                  FROM dbo.U_EUHCFINPRO_drvTbl 
                  WHERE drvRelationship = 'CH' 
               GROUP BY drvEEID, drvDepRecID) TMP
            ON drvEEID = tmpEEID
           AND drvDepRecID = tmpDepRecID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUHCFINPRO_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_Header;
    SELECT DISTINCT
         drvDateCreated = CAST(getdate() AS DATE)
    INTO dbo.U_EUHCFINPRO_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EUHCFINPRO_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFINPRO_Trailer;
    SELECT DISTINCT
         drvClientJobNumber = ''
        ,drvRecordCount = (SELECT COUNT(*) FROM dbo.U_EUHCFINPRO_drvTbl WITH (NOLOCK))
    INTO dbo.U_EUHCFINPRO_Trailer
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
ALTER VIEW dbo.dsi_vwEUHCFINPRO_Export AS
    SELECT TOP 20000000 *, Data FROM dbo.U_EUHCFINPRO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefh
SELECT * FROM dbo.AscDefh where adhformatcode = 'EUHCFINPRO'

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUHCFINPRO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104261'
       ,expStartPerControl     = '202104261'
       ,expLastEndPerControl   = '202105039'
       ,expEndPerControl       = '202105039'
WHERE expFormatCode = 'EUHCFINPRO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUHCFINPRO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUHCFINPRO_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort