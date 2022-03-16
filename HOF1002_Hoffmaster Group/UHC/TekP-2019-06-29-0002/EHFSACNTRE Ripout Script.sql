SET NOCOUNT ON;
IF OBJECT_ID('U_EHFSACNTRE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHFSACNTRE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHFSACNTRE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHFSACNTRE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHFSACNTRE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHFSACNTRE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFSACNTRE];
GO
IF OBJECT_ID('U_EHFSACNTRE_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_Trailer];
GO
IF OBJECT_ID('U_EHFSACNTRE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_PEarHist];
GO
IF OBJECT_ID('U_EHFSACNTRE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_PDedHist];
GO
IF OBJECT_ID('U_EHFSACNTRE_Header') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_Header];
GO
IF OBJECT_ID('U_EHFSACNTRE_File') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_File];
GO
IF OBJECT_ID('U_EHFSACNTRE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_EEList];
GO
IF OBJECT_ID('U_EHFSACNTRE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_drvTbl];
GO
IF OBJECT_ID('U_EHFSACNTRE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EHFSACNTRE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHFSACNTRE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHFSACNTRE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHFSACNTRE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHFSACNTRE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHFSACNTRE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHFSACNTRE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EHFSACNTRE','UHC FSA Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','500','S','N','EHFSACNTREZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0000000000000000000"','1','(''DA''=''F'')','EHFSACNTREZ0','19','H','01','1',NULL,'Header Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"6"','2','(''DA''=''F'')','EHFSACNTREZ0','1','H','01','20',NULL,'Header Master Layout',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSA"','3','(''DA''=''F'')','EHFSACNTREZ0','3','H','01','21',NULL,'System Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"5426"','4','(''DA''=''F'')','EHFSACNTREZ0','4','H','01','24',NULL,'System Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HOFFMAST"','5','(''DA''=''F'')','EHFSACNTREZ0','8','H','01','28',NULL,'Client Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"001"','6','(''DA''=''F'')','EHFSACNTREZ0','3','H','01','36',NULL,'Version Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate"','7','(''UD112''=''F'')','EHFSACNTREZ0','8','H','01','39',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0921778111"','8','(''DA''=''F'')','EHFSACNTREZ0','9','H','01','47',NULL,'Customer Specific ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hoffmaster Group, Inc"','9','(''DA''=''F'')','EHFSACNTREZ0','30','H','01','56',NULL,'Customer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCycle"','10','(''UA''=''F'')','EHFSACNTREZ0','3','H','01','86',NULL,'Cycle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0921778"','11','(''DA''=''F'')','EHFSACNTREZ0','7','H','01','89',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PROD"','12','(''DA''=''F'')','EHFSACNTREZ0','4','H','01','96',NULL,'Type of Feed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','13','(''DA''=''F'')','EHFSACNTREZ0','1','H','01','100',NULL,'Multi-Coverage Data Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EHFSACNTREZ0','400','H','01','101',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EHFSACNTREZ0','9','D','10','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EHFSACNTREZ0','9','D','10','11',NULL,'Employer ID/Employer Alt ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''F'')','EHFSACNTREZ0','30','D','10','20',NULL,'Member Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''F'')','EHFSACNTREZ0','14','D','10','50',NULL,'Member First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','64',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''F'')','EHFSACNTREZ0','1','D','10','65',NULL,'Member Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EHFSACNTREZ0','4','D','10','66',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EHFSACNTREZ0','4','D','10','70',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine"','10','(''UA''=''F'')','EHFSACNTREZ0','30','D','10','74',NULL,'Permanent Street Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','11','(''UA''=''F'')','EHFSACNTREZ0','30','D','10','104',NULL,'Permanent Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','12','(''UA''=''F'')','EHFSACNTREZ0','15','D','10','134',NULL,'Permanent City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','13','(''UA''=''F'')','EHFSACNTREZ0','2','D','10','149',NULL,'Permanent State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EHFSACNTREZ0','15','D','10','151',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','15','(''UA''=''F'')','EHFSACNTREZ0','9','D','10','166',NULL,'Permanent Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','175',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','17','(''UD112''=''F'')','EHFSACNTREZ0','8','D','10','176',NULL,'Member Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0921778"','18','(''DA''=''F'')','EHFSACNTREZ0','7','D','10','184',NULL,'Policy Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode"','19','(''UA''=''F'')','EHFSACNTREZ0','4','D','10','191',NULL,'Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEffectiveDate"','20','(''UD112''=''F'')','EHFSACNTREZ0','8','D','10','195',NULL,'Plan Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EHFSACNTREZ0','6','D','10','203',NULL,'Reporting Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EHFSACNTREZ0','2','D','10','209',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EHFSACNTREZ0','6','D','10','211',NULL,'Reporting Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EHFSACNTREZ0','2','D','10','217',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentDate"','25','(''UD112''=''F'')','EHFSACNTREZ0','8','D','10','219',NULL,'Enrollment Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''F'')','EHFSACNTREZ0','11','D','10','227',NULL,'Numeric Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionType1"','27','(''UA''=''F'')','EHFSACNTREZ0','3','D','10','238',NULL,'Contribution Type 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionSourceCode1"','28','(''UA''=''F'')','EHFSACNTREZ0','1','D','10','241',NULL,'Contribution Source Code 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionSign1"','29','(''UA''=''F'')','EHFSACNTREZ0','1','D','10','242',NULL,'Contribution Sign 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount1"','30','(''UA''=''F'')','EHFSACNTREZ0','7','D','10','243',NULL,'Contribution Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionType2"','31','(''UA''=''F'')','EHFSACNTREZ0','3','D','10','250',NULL,'Contribution Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionSourceCode2"','32','(''UA''=''F'')','EHFSACNTREZ0','1','D','10','253',NULL,'Contribution Source Code 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionSign2"','33','(''UA''=''F'')','EHFSACNTREZ0','1','D','10','254',NULL,'Contribution Sign 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmount2"','34','(''UA''=''F'')','EHFSACNTREZ0','7','D','10','255',NULL,'Contribution Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EHFSACNTREZ0','3','D','10','262',NULL,'Contribution Type 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','265',NULL,'Contribution Source Code 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','266',NULL,'Contribution Sign 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EHFSACNTREZ0','7','D','10','267',NULL,'Contribution Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EHFSACNTREZ0','3','D','10','274',NULL,'Contribution Type 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','277',NULL,'Contribution Source Code 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','278',NULL,'Contribution Sign 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EHFSACNTREZ0','7','D','10','279',NULL,'Contribution Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','286',NULL,'Automatic Submission Indicator/Coordinate Payment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EHFSACNTREZ0','7','D','10','287',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSATerminationDate"','45','(''UD112''=''F'')','EHFSACNTREZ0','8','D','10','294',NULL,'Healthcare or Limited Purpose FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','302',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAElectionAmount"','47','(''UA''=''F'')','EHFSACNTREZ0','7','D','10','303',NULL,'Healthcare or Limited Purpose FSA Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAEffectiveDate"','48','(''UD112''=''F'')','EHFSACNTREZ0','8','D','10','310',NULL,'Healthcare or Limited Purpose FSA Election Effecti',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EHFSACNTREZ0','2','D','10','318',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','320',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EHFSACNTREZ0','9','D','10','321',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EHFSACNTREZ0','17','D','10','330',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EHFSACNTREZ0','2','D','10','347',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EHFSACNTREZ0','121','D','10','349',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EHFSACNTREZ0','1','D','10','470',NULL,'Prefund Sign',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EHFSACNTREZ0','7','D','10','471',NULL,'Prefund Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFSATerminationDate"','57','(''UD112''=''F'')','EHFSACNTREZ0','8','D','10','478',NULL,'Dependent Care FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFSAElectionDate"','58','(''UD112''=''F'')','EHFSACNTREZ0','8','D','10','486',NULL,'Dependent Care FSA Election Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFSAElectionAmount"','59','(''UA''=''F'')','EHFSACNTREZ0','7','D','10','494',NULL,'Dependent Care FSA Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"99999999999999999999"','1','(''DA''=''F'')','EHFSACNTREZ0','20','T','90','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''F'')','EHFSACNTREZ0','6','T','90','21',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalFsaContributionSign"','3','(''UA''=''F'')','EHFSACNTREZ0','1','T','90','27',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalFsaContributionAmount"','4','(''UA''=''F'')','EHFSACNTREZ0','10','T','90','28',NULL,'Total Healthcare and Limited Purpose FSA Contribut',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalFsaDepContribSign"','5','(''UA''=''F'')','EHFSACNTREZ0','1','T','90','38',NULL,'Total Dependent Care FSA Contribution Amount Sign',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalFsaDepContribAmount"','6','(''UA''=''F'')','EHFSACNTREZ0','10','T','90','39',NULL,'Total Dependent Care FSA Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalFSAElectionAmount"','7','(''UA''=''F'')','EHFSACNTREZ0','10','T','90','49',NULL,'Total Healthcare and Limited Purpose FSA Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalDepCareFSAAmount"','8','(''UA''=''F'')','EHFSACNTREZ0','10','T','90','59',NULL,'Total Dependent Care FSA Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EHFSACNTREZ0','432','T','90','69',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHFSACNTRE_20200724.txt',NULL,'','','',NULL,NULL,NULL,'UHC FSA Contribution Export','202007109','EMPEXPORT','ONDEMAND','Jul 20 2020  2:14PM','EHFSACNTRE',NULL,NULL,NULL,'202007109','Jul 19 2020 11:14PM','Jul 19 2020 11:14PM','202007101','208','','','202007101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHFSACNTRE_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202007109','EMPEXPORT','SCHEDULED','Jul 20 2020  2:15PM','EHFSACNTRE',NULL,NULL,NULL,'202007109','Jul 19 2020 11:14PM','Jul 19 2020 11:14PM','202007101','208','','','202007101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHFSACNTRE_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202007109','EMPEXPORT','OEACTIVE','Jul 20 2020  2:13PM','EHFSACNTRE',NULL,NULL,NULL,'202007109','Jul 19 2020 11:14PM','Jul 19 2020 11:14PM','202007101','208','','','202007101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHFSACNTRE_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202007109','EMPEXPORT','OEPASSIVE','Jul 20 2020  2:14PM','EHFSACNTRE',NULL,NULL,NULL,'202007109','Jul 19 2020 11:14PM','Jul 19 2020 11:14PM','202007101','208','','','202007101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHFSACNTRE_20200724.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202007109','EMPEXPORT','TEST','Jul 23 2020  4:03PM','EHFSACNTRE',NULL,NULL,NULL,'202007109','Jul 10 2020 12:00AM','Dec 30 1899 12:00AM','202007101','145','eecPayGroup','AARDBW,CLINHR,GMSPHR,NONEX,OSHKBW,SALARY,SUMNR','202007101',dbo.fn_GetTimedKey(),NULL,'us3cPeHOF1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EHFSACNTRE_20200724.txt' END WHERE expFormatCode = 'EHFSACNTRE';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFSACNTRE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFSACNTRE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFSACNTRE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFSACNTRE','NextFileSequence','V','42');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFSACNTRE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHFSACNTRE','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EHFSACNTRE' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHFSACNTRE' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EHFSACNTRE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHFSACNTRE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFSACNTRE','H01','dbo.U_EHFSACNTRE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFSACNTRE','D10','dbo.U_EHFSACNTRE_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHFSACNTRE','T90','dbo.U_EHFSACNTRE_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EHFSACNTRE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHFSACNTRE] (
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
IF OBJECT_ID('U_EHFSACNTRE_DedList') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHFSACNTRE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvPlanCode] varchar(4) NULL,
    [drvPlanEffectiveDate] date NULL,
    [drvEnrollmentDate] datetime NULL,
    [drvContributionType1] varchar(3) NULL,
    [drvContributionSourceCode1] varchar(1) NULL,
    [drvContributionSign1] varchar(1) NULL,
    [drvContributionAmount1] nvarchar(4000) NULL,
    [drvContributionType2] varchar(3) NULL,
    [drvContributionSourceCode2] varchar(1) NULL,
    [drvContributionSign2] varchar(1) NULL,
    [drvContributionAmount2] nvarchar(4000) NULL,
    [drvFSATerminationDate] datetime NULL,
    [drvFSAElectionAmount] nvarchar(4000) NULL,
    [drvFSAEffectiveDate] datetime NULL,
    [drvDepFSATerminationDate] datetime NULL,
    [drvDepFSAElectionDate] datetime NULL,
    [drvDepFSAElectionAmount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EHFSACNTRE_EEList') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHFSACNTRE_File') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EHFSACNTRE_Header') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_Header] (
    [drvDate] datetime NULL,
    [drvCycle] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EHFSACNTRE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1Amt] numeric NULL,
    [PdhSource2Amt] numeric NULL
);
IF OBJECT_ID('U_EHFSACNTRE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_PEarHist] (
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
IF OBJECT_ID('U_EHFSACNTRE_Trailer') IS NULL
CREATE TABLE [dbo].[U_EHFSACNTRE_Trailer] (
    [drvRecordCount] nvarchar(4000) NULL,
    [drvTotalFsaContributionSign] varchar(1) NOT NULL,
    [drvTotalFsaContributionAmount] nvarchar(4000) NULL,
    [drvTotalFsaDepContribSign] varchar(1) NOT NULL,
    [drvTotalFsaDepContribAmount] nvarchar(4000) NULL,
    [drvTotalFSAElectionAmount] nvarchar(4000) NULL,
    [drvTotalDepCareFSAAmount] nvarchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHFSACNTRE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hoffmaster Group

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 07/19/2020
Service Request Number: TekP-2019-06-29-0002

Purpose: UHC FSA Contribution Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHFSACNTRE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHFSACNTRE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHFSACNTRE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHFSACNTRE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHFSACNTRE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHFSACNTRE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHFSACNTRE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHFSACNTRE', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHFSACNTRE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHFSACNTRE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHFSACNTRE';

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
    DELETE FROM dbo.U_EHFSACNTRE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHFSACNTRE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EHFSAELIGE_EEList
        WHERE xEEID IN (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC,FSALD';

    IF OBJECT_ID('U_EHFSACNTRE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHFSACNTRE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHFSACNTRE_DedList
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
    IF OBJECT_ID('U_EHFSACNTRE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHFSACNTRE_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1Amt     = SUM(CASE WHEN PdhDedCode IN ('FSA','FSALD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2Amt     = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        /*,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_EHFSACNTRE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHFSACNTRE_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EHFSACNTRE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHFSACNTRE_PEarHist;
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
    INTO dbo.U_EHFSACNTRE_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHFSACNTRE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHFSACNTRE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHFSACNTRE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvPlanCode =    CASE WHEN FSA_DedCode IS NOT NULL AND FSADC_DedCode IS NULL AND FSALD_DedCode IS NULL THEN '0001'
                            WHEN FSA_DedCode IS NULL AND FSADC_DedCode IS NOT NULL AND FSALD_DedCode IS NULL THEN '0001'
                            WHEN FSA_DedCode IS NOT NULL AND FSADC_DedCode IS NOT NULL AND FSALD_DedCode IS NULL THEN '0001'
                            WHEN FSA_DedCode IS NULL AND FSADC_DedCode IS NULL AND FSALD_DedCode IS NOT NULL THEN '5001'
                            WHEN FSA_DedCode IS NULL AND FSADC_DedCode IS NOT NULL AND FSALD_DedCode IS NOT NULL THEN '5001'
                        END
        ,drvPlanEffectiveDate = CAST('01/01/' + CAST(YEAR(GETDATE()) AS VARCHAR) AS DATE)
        ,drvEnrollmentDate =    CASE WHEN FSA_DedCode IS NOT NULL THEN FSA_BenStartDate
                                    WHEN FSADC_DedCode IS NOT NULL THEN FSADC_BenStartDate
                                    WHEN FSALD_DedCode IS NOT NULL THEN FSALD_BenStartDate
                                END
        ,drvContributionType1 = CASE WHEN FSA_DedCode IS NOT NULL OR FSALD_DedCode IS NOT NULL THEN 'MED' END
        ,drvContributionSourceCode1 = CASE WHEN FSA_DedCode IS NOT NULL OR FSALD_DedCode IS NOT NULL THEN 'E' END
        ,drvContributionSign1 =    CASE WHEN FSA_DedCode IS NOT NULL OR FSALD_DedCode IS NOT NULL THEN
                                    CASE WHEN PdhSource1Amt > 0 THEN '+'
                                        WHEN PdhSource1Amt < 0 THEN '-'
                                    END
                                END
        ,drvContributionAmount1 =    CASE WHEN FSA_DedCode IS NOT NULL OR FSALD_DedCode IS NOT NULL THEN
                                        CASE WHEN PdhSource1Amt > 0 THEN FORMAT(PdhSource1Amt*100, '0000000') END
                                    END
        ,drvContributionType2 = CASE WHEN FSADC_DedCode IS NOT NULL THEN 'DEP' END
        ,drvContributionSourceCode2 = CASE WHEN FSADC_DedCode IS NOT NULL THEN 'E' END
        ,drvContributionSign2 = CASE WHEN FSADC_DedCode IS NOT NULL THEN
                                    CASE WHEN PdhSource2Amt > 0 THEN '+'
                                        WHEN PdhSource2Amt < 0 THEN '-'
                                    END
                                END
        ,drvContributionAmount2 =    CASE WHEN FSADC_DedCode IS NOT NULL THEN
                                        CASE WHEN PdhSource2Amt > 0 THEN FORMAT(PdhSource2Amt*100, '0000000') END
                                    END
        ,drvFSATerminationDate = CASE WHEN FSA_DedCode IS NOT NULL OR FSALD_DedCode IS NOT NULL THEN EecDateOfTermination END
        ,drvFSAElectionAmount =    FORMAT(
                                        CASE WHEN FSA_DedCode IS NOT NULL THEN FSA_BenEEGoalAmt*100
                                            WHEN FSALD_DedCode IS NOT NULL THEN FSALD_BenEEGoalAmt*100
                                        END
                                    , '0000000')
        ,drvFSAEffectiveDate =    CASE WHEN FSA_DedCode IS NOT NULL THEN FSA_BenStartDate
                                    WHEN FSALD_DedCode IS NOT NULL THEN FSALD_BenStartDate
                                END
        ,drvDepFSATerminationDate = CASE WHEN FSADC_DedCode IS NOT NULL THEN EecDateOfTermination END
        ,drvDepFSAElectionDate = CASE WHEN FSADC_DedCode IS NOT NULL THEN FSADC_BenStartDate END
        ,drvDepFSAElectionAmount = CASE WHEN FSADC_DedCode IS NOT NULL THEN FORMAT(FSADC_BenEEGoalAmt*100, '0000000') END
    INTO dbo.U_EHFSACNTRE_drvTbl
    FROM dbo.U_EHFSACNTRE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmEEID, BdmCOID
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmDedCode END) AS FSA_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmDedCode END) AS FSADC_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSALD' THEN BdmDedCode END) AS FSALD_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmBenStartDate END) AS FSA_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmBenStartDate END) AS FSADC_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSALD' THEN BdmBenStartDate END) AS FSALD_BenStartDate
                ,MAX(CASE WHEN BdmDedCode = 'FSA' THEN BdmEEGoalAmt END) AS FSA_BenEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSADC' THEN BdmEEGoalAmt END) AS FSADC_BenEEGoalAmt
                ,MAX(CASE WHEN BdmDedCode = 'FSALD' THEN BdmEEGoalAmt END) AS FSALD_BenEEGoalAmt
            FROM dbo.U_dsi_BDM_EHFSACNTRE WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID
        ) AS Bdm
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN dbo.U_EHFSACNTRE_PDedHist
        ON PdhEEID = xEEID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
    ;

    DECLARE @ThisFileSequence    INT
        ,@WeekNumber            INT
        ,@PayFrequency            VARCHAR(1)
        ,@PayDate                DATETIME
        ,@PayGroup                VARCHAR(6)
        ;

    SELECT @ThisFileSequence = CAST(CfgValue AS INT) 
    FROM dbo.U_dsi_Configuration
    WHERE FormatCode = 'EHFSACNTRE'
    AND CfgName = 'NextFileSequence'


    SELECT TOP 1 @PayFrequency = PgrPayFrequency, @PayGroup = PgrPayGroup
    FROM dbo.PayGroup WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecPayGroup = PgrPayGroup
    JOIN dbo.U_EHFSACNTRE_drvTbl WITH (NOLOCK)
        ON drvEEID = EecEEID
    ;


    
    DECLARE @CycleNo INT;

    SELECT @CycleNo = COUNT(*), @PayDate = MAX(PgpPayDate) 
    FROM dbo.PgPayPer WITH (NOLOCK)
    WHERE PgpPayGroup = @PayGroup 
        AND PgpPayDate BETWEEN '1/1/2020' AND @EndDate
        AND RIGHT(PgpPeriodControl, 1) = '1'




    /*SELECT @WeekNumber = DATEPART(WEEK, GETDATE());

    SET @WeekNumber =    CASE WHEN @PayFrequency = 'B' THEN
                            CASE WHEN @WeekNumber % 2 > 0 THEN (@WeekNumber + 1)/2 ELSE @WeekNumber/2
                            END
                            ELSE @WeekNumber
                        END*/

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EHFSACNTRE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EHFSACNTRE_Header;
    SELECT DISTINCT
         drvDate = @PayDate -- CAST('01/01/' + CAST(YEAR(GETDATE()) AS VARCHAR) AS DATE)
        ,drvCycle = @PayFrequency + FORMAT(@CycleNo, '00') --FORMAT(@WeekNumber, '00') -- 'E01'
    INTO dbo.U_EHFSACNTRE_Header
    ;
    
    UPDATE dbo.U_dsi_Configuration
    SET CfgValue = CAST(@ThisFileSequence+1 AS VARCHAR)
    WHERE FormatCode = 'EHFSACNTRE'
    AND CfgName = 'NextFileSequence'
    ;


    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------

    DECLARE @TotalEmpEECurAmt INT
        ,@TotalDepEECurAmt INT
        ,@DepFSAElectionAmount INT
        ;

    select @TotalEmpEECurAmt = SUM(CAST(drvContributionAmount1 AS INT)), @TotalDepEECurAmt = SUM(CAST(drvContributionAmount2 AS INT)), @DepFSAElectionAmount = SUM(CAST(drvDepFSAElectionAmount AS INT)) from dbo.U_EHFSACNTRE_drvTbl;

    IF OBJECT_ID('U_EHFSACNTRE_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EHFSACNTRE_Trailer;
    SELECT DISTINCT
         drvRecordCount = FORMAT((SELECT COUNT(*) FROM dbo.U_EHFSACNTRE_drvTbl), '000000')
        ,drvTotalFsaContributionSign = CASE WHEN @TotalEmpEECurAmt >= 0 THEN '+' ELSE '-' END
        ,drvTotalFsaContributionAmount = FORMAT(@TotalEmpEECurAmt, '0000000000')
        ,drvTotalFsaDepContribSign = CASE WHEN @TotalDepEECurAmt >= 0 THEN '+' ELSE '-' END
        ,drvTotalFsaDepContribAmount = FORMAT(@TotalDepEECurAmt, '0000000000')
        ,drvTotalFSAElectionAmount = (SELECT FORMAT(SUM(CAST(drvFSAElectionAmount AS INT)), '0000000000') FROM dbo.U_EHFSACNTRE_drvTbl)
        ,drvTotalDepCareFSAAmount = FORMAT(@DepFSAElectionAmount, '0000000000')
    INTO dbo.U_EHFSACNTRE_Trailer
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
ALTER VIEW dbo.dsi_vwEHFSACNTRE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHFSACNTRE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHFSACNTRE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202007101'
       ,expStartPerControl     = '202007101'
       ,expLastEndPerControl   = '202007109'
       ,expEndPerControl       = '202007109'
WHERE expFormatCode = 'EHFSACNTRE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHFSACNTRE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHFSACNTRE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort