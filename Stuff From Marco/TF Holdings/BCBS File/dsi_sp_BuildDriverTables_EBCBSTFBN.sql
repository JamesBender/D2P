SET NOCOUNT ON;
IF OBJECT_ID('U_EBCBSTFBN_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBCBSTFBN_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBCBSTFBN' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBCBSTFBN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBCBSTFBN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBCBSTFBN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBCBSTFBN];
GO
IF OBJECT_ID('U_EBCBSTFBN_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_PDedHist];
GO
IF OBJECT_ID('U_EBCBSTFBN_File') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_File];
GO
IF OBJECT_ID('U_EBCBSTFBN_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_EEList];
GO
IF OBJECT_ID('U_EBCBSTFBN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_drvTbl];
GO
IF OBJECT_ID('U_EBCBSTFBN_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_DedList];
GO
IF OBJECT_ID('U_EBCBSTFBN_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_AuditFields];
GO
IF OBJECT_ID('U_EBCBSTFBN_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBCBSTFBN') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBCBSTFBN];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBCBSTFBN';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBCBSTFBN';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBCBSTFBN';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBCBSTFBN';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBCBSTFBN';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBCBSTFBN','BCBSIL/Dearborn Group Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','7000','S','N','EBCBSTFBN0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBCBSTFBN' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group"','1','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','1',NULL,'Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account"','2','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','2',NULL,'Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name"','3','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','3',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name"','4','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','4',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Middle Initial"','5','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','5',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','6','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','6',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Type of Transaction"','7','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','7',NULL,'Type of Transaction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','8','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','9','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','9',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full-Time Hire Date"','10','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','10',NULL,'Full-Time Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class"','11','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','11',NULL,'Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location "','12','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','12',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary"','13','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','13',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Mode"','14','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','14',NULL,'Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary Effective date"','15','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','15',NULL,'Salary Effective date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','16','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','16',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EE Date of Termination"','17','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','17',NULL,'EE Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Effective Date"','18','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','18',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Amount"','19','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','19',NULL,'Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Termination Date"','20','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','20',NULL,'Basic Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Effective Date"','21','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','21',NULL,'Basic AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Amount"','22','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','22',NULL,'Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D  Termination Date"','23','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','23',NULL,'Basic AD&D  Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic LTD EffectiveDate"','24','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','24',NULL,'Basic LTD EffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic LTD Amount"','25','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','25',NULL,'Basic LTD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic LTD Termination Date"','26','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','26',NULL,'Basic LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic STD Effective Date"','27','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','27',NULL,'Basic STD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic STD Amount"','28','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','28',NULL,'Basic STD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic STD Termination Date"','29','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','29',NULL,'Basic STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Employee Life Effective Date"','30','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','30',NULL,'Supplemental Employee Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Employee Life Amount"','31','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','31',NULL,'Supplemental Employee Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Employee Life Date of Termination"','32','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','32',NULL,'Supplemental Employee Life Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Employee ADD Effective Date"','33','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','33',NULL,'Supplemental Employee ADD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Employee ADD Amount"','34','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','34',NULL,'Supplemental Employee ADD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Employee ADD Date of Termination"','35','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','35',NULL,'Supplemental Employee ADD Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Child Life Effective Date"','36','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','36',NULL,'Supplemental Child Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Child Life Amount"','37','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','37',NULL,'Supplemental Child Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Child Life Date of Termination"','38','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','38',NULL,'Supplemental Child Life Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Child ADD Effective Date"','39','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','39',NULL,'Supplemental Child ADD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Child ADD Amount"','40','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','40',NULL,'Supplemental Child ADD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Child ADD Date of Termination"','41','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','41',NULL,'Supplemental Child ADD Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Spouse Life Effective Date"','42','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','42',NULL,'Supplemental Spouse Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Spouse Life Amount"','43','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','43',NULL,'Supplemental Spouse Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Spouse Life Date of Termination"','44','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','44',NULL,'Supplemental Spouse Life Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Spouse ADD Effective Date"','45','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','45',NULL,'Supplemental Spouse ADD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Spouse ADD Amount"','46','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','46',NULL,'Supplemental Spouse ADD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Spouse ADD Date of Termination"','47','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','47',NULL,'Supplemental Spouse ADD Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary Vision Effective Date"','48','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','48',NULL,'Voluntary Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary Vision Tier"','49','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','49',NULL,'Voluntary Vision Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary Vision Date of Termination"','50','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','50',NULL,'Voluntary Vision Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary Vision  COBRA Effective Date"','51','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','51',NULL,'Voluntary Vision  COBRA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary Vision COBRA Tier"','52','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','52',NULL,'Voluntary Vision COBRA Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voluntary Vision COBRA Date of Termination "','53','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','53',NULL,'Voluntary Vision COBRA Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Address"','54','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','54',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Address"','55','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','55',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Address"','56','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','56',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Address"','57','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','57',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','58','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','58',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','59','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','59',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','60','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','60',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','61','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','61',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','62','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','62',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','63','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','63',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','64','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','64',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','65','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','65',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','66','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','66',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','67','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','67',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','68','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','68',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','69','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','69',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','70','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','70',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','71','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','71',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','72','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','72',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','73','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','73',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','74','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','74',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','75','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','75',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','76','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','76',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','77','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','77',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','78','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','78',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','79','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','79',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','80','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','80',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','81','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','81',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','82','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','82',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','83','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','83',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','84','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','84',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','85','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','85',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','86','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','86',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','87','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','87',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','88','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','88',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','89','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','89',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','90','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','90',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','91','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','91',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','92','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','92',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','93','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','93',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','94','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','94',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','95','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','95',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','96','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','96',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','97','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','97',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','98','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','98',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','99','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','99',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','100','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','100',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','101','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','101',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','102','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','102',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','103','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','103',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','104','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','104',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','105','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','105',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','106','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','106',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','107','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','107',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','108','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','108',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','109','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','109',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','110','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','110',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','111','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','111',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','112','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','112',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','113','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','113',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Last Name"','114','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','114',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent First Name"','115','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','115',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent MI"','116','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','116',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Date of Birth"','117','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','117',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Relationship"','118','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','118',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','119','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','119',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Effective Date"','120','(''DA''=''Q,'')','EBCBSTFBN0Z0','50','H','01','120',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Dependent Vision Termination Date"','121','(''DA''=''Q'')','EBCBSTFBN0Z0','50','H','01','121',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroup"','1','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','1',NULL,'Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccount"','2','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','2',NULL,'Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','3','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','3',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','4','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','4',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMiddleInitial"','5','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','5',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurityNumber"','6','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','6',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTypeofTransaction"','7','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','7',NULL,'Type of Transaction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','8','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','9',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimeHireDate"','10','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','10',NULL,'Full-Time Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','11','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','11',NULL,'Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','12','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','12',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','13','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','13',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','14','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','14',NULL,'Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffDate"','15','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','15',NULL,'Salary Effective date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','16','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','16',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDateTerm"','17','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','17',NULL,'EE Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeEffDate"','18','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','18',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeAmt"','19','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','19',NULL,'Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeTerminationDate"','20','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','20',NULL,'Basic Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEffDate"','21','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','21',NULL,'Basic AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDAmt"','22','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','22',NULL,'Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDTerminationDate"','23','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','23',NULL,'Basic AD&D  Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDEffDate"','24','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','24',NULL,'Basic LTD EffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDAmt"','25','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','25',NULL,'Basic LTD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLTDTerminationDate"','26','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','26',NULL,'Basic LTD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDEffDate"','27','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','27',NULL,'Basic STD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDAmt"','28','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','28',NULL,'Basic STD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSTDTerminationDate"','29','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','29',NULL,'Basic STD Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppEmployeeLifeEffDate"','30','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','30',NULL,'Supplemental Employee Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppEmployeeLifeAmt"','31','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','31',NULL,'Supplemental Employee Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppEmployeeLifeDateTerm"','32','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','32',NULL,'Supplemental Employee Life Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppEmployeeADDEffDate"','33','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','33',NULL,'Supplemental Employee ADD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppEmployeeADDAmt"','34','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','34',NULL,'Supplemental Employee ADD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppEmployeeADDDateTerm"','35','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','35',NULL,'Supplemental Employee ADD Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppChildLifeEffDate"','36','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','36',NULL,'Supplemental Child Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppChildLifeAmt"','37','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','37',NULL,'Supplemental Child Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppChildLifeDateTerm"','38','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','38',NULL,'Supplemental Child Life Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppChildADDEffDate"','39','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','39',NULL,'Supplemental Child ADD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppChildADDAmt"','40','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','40',NULL,'Supplemental Child ADD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppChildADDDateTerm"','41','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','41',NULL,'Supplemental Child ADD Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppSpouseLifeEffDate"','42','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','42',NULL,'Supplemental Spouse Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppSpouseLifeAmt"','43','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','43',NULL,'Supplemental Spouse Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppSpouseLifeDateTerm"','44','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','44',NULL,'Supplemental Spouse Life Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppSpouseADDEffDate"','45','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','45',NULL,'Supplemental Spouse ADD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppSpouseADDAmt"','46','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','46',NULL,'Supplemental Spouse ADD Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppSpouseADDDateTerm"','47','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','47',NULL,'Supplemental Spouse ADD Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryVisionEffDate"','48','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','48',NULL,'Voluntary Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryVisionTier"','49','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','49',NULL,'Voluntary Vision Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryVisionDateTerm"','50','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','50',NULL,'Voluntary Vision Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolVisionCOBRAEffDate"','51','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','51',NULL,'Voluntary Vision  COBRA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVoluntaryVisionCOBRATier"','52','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','52',NULL,'Voluntary Vision COBRA Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVolVisionCOBRADateTerm"','53','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','53',NULL,'Voluntary Vision COBRA Date of Termination',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAddress1"','54','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','54',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAddress2"','55','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','55',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAddress3"','56','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','56',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAddress4"','57','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','57',NULL,'Employee Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName1"','58','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','58',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName1"','59','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','59',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI1"','60','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','60',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth1"','61','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','61',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship1"','62','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','62',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender1"','63','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','63',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate1"','64','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','64',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate1"','65','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','65',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName2"','66','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','66',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName2"','67','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','67',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI2"','68','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','68',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth2"','69','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','69',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship2"','70','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','70',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender2"','71','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','71',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate2"','72','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','72',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate2"','73','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','73',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName3"','74','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','74',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName3"','75','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','75',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI3"','76','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','76',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth3"','77','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','77',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship3"','78','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','78',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender3"','79','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','79',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate3"','80','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','80',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate3"','81','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','81',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName4"','82','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','82',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName4"','83','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','83',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI4"','84','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','84',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth4"','85','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','85',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship4"','86','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','86',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender4"','87','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','87',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate4"','88','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','88',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate4"','89','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','89',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName5"','90','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','90',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName5"','91','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','91',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI5"','92','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','92',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth5"','93','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','93',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship5"','94','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','94',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender5"','95','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','95',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate5"','96','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','96',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate5"','97','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','97',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName6"','98','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','98',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName6"','99','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','99',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI6"','100','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','100',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth6"','101','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','101',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship6"','102','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','102',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender6"','103','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','103',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate6"','104','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','104',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate6"','105','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','105',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName7"','106','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','106',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName7"','107','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','107',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI7"','108','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','108',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth7"','109','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','109',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship7"','110','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','110',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender7"','111','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','111',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate7"','112','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','112',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate7"','113','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','113',NULL,'Dependent Vision Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName8"','114','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','114',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName8"','115','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','115',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepMI8"','116','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','116',NULL,'Dependent MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth8"','117','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','117',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship8"','118','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','118',NULL,'Dependent Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender8"','119','(''UA''=''Q,'')','EBCBSTFBN0Z0','50','D','10','119',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionEffDate8"','120','(''UD101''=''Q,'')','EBCBSTFBN0Z0','50','D','10','120',NULL,'Dependent Vision Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepVisionTerminationDate8"','121','(''UD101''=''Q'')','EBCBSTFBN0Z0','50','D','10','121',NULL,'Dependent Vision Termination Date',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBCBSTFBN_20210401.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102249','EMPEXPORT','OEACTIVE',NULL,'EBCBSTFBN',NULL,NULL,NULL,'202102249','Feb 24 2021  3:38PM','Feb 24 2021  3:38PM','202102241',NULL,'','','202102241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102249','EMPEXPORT','OEPASSIVE',NULL,'EBCBSTFBN',NULL,NULL,NULL,'202102249','Feb 24 2021  3:38PM','Feb 24 2021  3:38PM','202102241',NULL,'','','202102241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BCBSIL/Dearborn Group Export','202102249','EMPEXPORT','ONDEMAND',NULL,'EBCBSTFBN',NULL,NULL,NULL,'202102249','Feb 24 2021  3:38PM','Feb 24 2021  3:38PM','202102241',NULL,'','','202102241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202102249','EMPEXPORT','SCH_BCBS',NULL,'EBCBSTFBN',NULL,NULL,NULL,'202102249','Feb 24 2021  3:38PM','Feb 24 2021  3:38PM','202102241',NULL,'','','202102241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','KG0G0',NULL,NULL,NULL,'Test Purposes Only','202103221','EMPEXPORT','TEST','Mar 30 2021  7:58PM','EBCBSTFBN',NULL,NULL,NULL,'202103221','Mar 22 2021 12:00AM','Dec 30 1899 12:00AM','202103081','67','','','202103081',dbo.fn_GetTimedKey(),NULL,'us3cPeTHI1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCBSTFBN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCBSTFBN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCBSTFBN','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCBSTFBN','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCBSTFBN','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCBSTFBN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBCBSTFBN','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBCBSTFBN' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBCBSTFBN' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBCBSTFBN_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBCBSTFBN_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBCBSTFBN','D10','dbo.U_EBCBSTFBN_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EBCBSTFBN') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBCBSTFBN] (
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
IF OBJECT_ID('U_EBCBSTFBN_Audit') IS NULL
CREATE TABLE [dbo].[U_EBCBSTFBN_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EBCBSTFBN_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBCBSTFBN_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EBCBSTFBN_DedList') IS NULL
CREATE TABLE [dbo].[U_EBCBSTFBN_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EBCBSTFBN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EBCBSTFBN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvGroup] varchar(8) NOT NULL,
    [drvAccount] varchar(1) NOT NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleInitial] varchar(1) NULL,
    [drvSocialSecurityNumber] char(11) NULL,
    [drvTypeofTransaction] varchar(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvFullTimeHireDate] datetime NULL,
    [drvClass] varchar(1) NOT NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvSalary] varchar(30) NULL,
    [drvSalaryMode] varchar(1) NOT NULL,
    [drvSalaryEffDate] datetime NULL,
    [drvEffDate] datetime NULL,
    [drvEEDateTerm] datetime NULL,
    [drvBasicLifeEffDate] datetime NULL,
    [drvBasicLifeAmt] varchar(256) NULL,
    [drvBasicLifeTerminationDate] datetime NULL,
    [drvBasicADDEffDate] datetime NULL,
    [drvBasicADDAmt] varchar(256) NULL,
    [drvBasicADDTerminationDate] datetime NULL,
    [drvBasicLTDEffDate] datetime NULL,
    [drvBasicLTDAmt] varchar(256) NULL,
    [drvBasicLTDTerminationDate] datetime NULL,
    [drvBasicSTDEffDate] datetime NULL,
    [drvBasicSTDAmt] varchar(256) NULL,
    [drvBasicSTDTerminationDate] datetime NULL,
    [drvSuppEmployeeLifeEffDate] datetime NULL,
    [drvSuppEmployeeLifeAmt] varchar(256) NULL,
    [drvSuppEmployeeLifeDateTerm] datetime NULL,
    [drvSuppEmployeeADDEffDate] datetime NULL,
    [drvSuppEmployeeADDAmt] varchar(256) NULL,
    [drvSuppEmployeeADDDateTerm] datetime NULL,
    [drvSuppChildLifeEffDate] datetime NULL,
    [drvSuppChildLifeAmt] varchar(256) NULL,
    [drvSuppChildLifeDateTerm] datetime NULL,
    [drvSuppChildADDEffDate] datetime NULL,
    [drvSuppChildADDAmt] varchar(256) NULL,
    [drvSuppChildADDDateTerm] datetime NULL,
    [drvSuppSpouseLifeEffDate] datetime NULL,
    [drvSuppSpouseLifeAmt] varchar(256) NULL,
    [drvSuppSpouseLifeDateTerm] datetime NULL,
    [drvSuppSpouseADDEffDate] datetime NULL,
    [drvSuppSpouseADDAmt] varchar(256) NULL,
    [drvSuppSpouseADDDateTerm] datetime NULL,
    [drvVoluntaryVisionEffDate] datetime NULL,
    [drvVoluntaryVisionTier] varchar(1) NULL,
    [drvVoluntaryVisionDateTerm] datetime NULL,
    [drvVolVisionCOBRAEffDate] varchar(1) NOT NULL,
    [drvVoluntaryVisionCOBRATier] varchar(1) NOT NULL,
    [drvVolVisionCOBRADateTerm] varchar(1) NOT NULL,
    [drvEmployeeAddress1] varchar(511) NULL,
    [drvEmployeeAddress2] varchar(255) NULL,
    [drvEmployeeAddress3] varchar(255) NULL,
    [drvEmployeeAddress4] varchar(50) NULL,
    [drvDepLastName1] varchar(100) NULL,
    [drvDepFirstName1] varchar(100) NULL,
    [drvDepMI1] varchar(1) NULL,
    [drvDepDateofBirth1] datetime NULL,
    [drvDepRelationship1] varchar(1) NULL,
    [drvGender1] char(1) NULL,
    [drvDepVisionEffDate1] datetime NULL,
    [drvDepVisionTerminationDate1] datetime NULL,
    [drvDepLastName2] varchar(100) NULL,
    [drvDepFirstName2] varchar(100) NULL,
    [drvDepMI2] varchar(1) NULL,
    [drvDepDateofBirth2] datetime NULL,
    [drvDepRelationship2] varchar(1) NULL,
    [drvGender2] char(1) NULL,
    [drvDepVisionEffDate2] datetime NULL,
    [drvDepVisionTerminationDate2] datetime NULL,
    [drvDepLastName3] varchar(100) NULL,
    [drvDepFirstName3] varchar(100) NULL,
    [drvDepMI3] varchar(1) NULL,
    [drvDepDateofBirth3] datetime NULL,
    [drvDepRelationship3] varchar(1) NULL,
    [drvGender3] char(1) NULL,
    [drvDepVisionEffDate3] datetime NULL,
    [drvDepVisionTerminationDate3] datetime NULL,
    [drvDepLastName4] varchar(100) NULL,
    [drvDepFirstName4] varchar(100) NULL,
    [drvDepMI4] varchar(1) NULL,
    [drvDepDateofBirth4] datetime NULL,
    [drvDepRelationship4] varchar(1) NULL,
    [drvGender4] char(1) NULL,
    [drvDepVisionEffDate4] datetime NULL,
    [drvDepVisionTerminationDate4] datetime NULL,
    [drvDepLastName5] varchar(100) NULL,
    [drvDepFirstName5] varchar(100) NULL,
    [drvDepMI5] varchar(1) NULL,
    [drvDepDateofBirth5] datetime NULL,
    [drvDepRelationship5] varchar(1) NULL,
    [drvGender5] char(1) NULL,
    [drvDepVisionEffDate5] datetime NULL,
    [drvDepVisionTerminationDate5] datetime NULL,
    [drvDepLastName6] varchar(100) NULL,
    [drvDepFirstName6] varchar(100) NULL,
    [drvDepMI6] varchar(1) NULL,
    [drvDepDateofBirth6] datetime NULL,
    [drvDepRelationship6] varchar(1) NULL,
    [drvGender6] char(1) NULL,
    [drvDepVisionEffDate6] datetime NULL,
    [drvDepVisionTerminationDate6] datetime NULL,
    [drvDepLastName7] varchar(100) NULL,
    [drvDepFirstName7] varchar(100) NULL,
    [drvDepMI7] varchar(1) NULL,
    [drvDepDateofBirth7] datetime NULL,
    [drvDepRelationship7] varchar(1) NULL,
    [drvGender7] char(1) NULL,
    [drvDepVisionEffDate7] datetime NULL,
    [drvDepVisionTerminationDate7] datetime NULL,
    [drvDepLastName8] varchar(100) NULL,
    [drvDepFirstName8] varchar(100) NULL,
    [drvDepMI8] varchar(1) NULL,
    [drvDepDateofBirth8] datetime NULL,
    [drvDepRelationship8] varchar(1) NULL,
    [drvGender8] char(1) NULL,
    [drvDepVisionEffDate8] datetime NULL,
    [drvDepVisionTerminationDate8] datetime NULL
);
IF OBJECT_ID('U_EBCBSTFBN_EEList') IS NULL
CREATE TABLE [dbo].[U_EBCBSTFBN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBCBSTFBN_File') IS NULL
CREATE TABLE [dbo].[U_EBCBSTFBN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EBCBSTFBN_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EBCBSTFBN_PDedHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBCBSTFBN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: TF Holdings

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 02/24/2021
Service Request Number: TekP-2020-10-28-0004

Purpose: BCBSIL/Dearborn Group Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBCBSTFBN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBCBSTFBN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBCBSTFBN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBCBSTFBN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBCBSTFBN' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBCBSTFBN', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBCBSTFBN', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBCBSTFBN', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBCBSTFBN', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBCBSTFBN', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBCBSTFBN';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBCBSTFBN', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EBCBSTFBN';

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
    DELETE FROM dbo.U_EBCBSTFBN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBCBSTFBN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LIFE,LTD1,LTD2,STD,EELF,CHLF,SPLF,V0001';

    IF OBJECT_ID('U_EBCBSTFBN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBCBSTFBN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBCBSTFBN_DedList
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


     --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EBCBSTFBN D
    JOIN dbo.U_dsi_bdm_EBCBSTFBN E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EBCBSTFBN
        SET BdmUSGField2 = EedEmpDedTVID
        ,BdmUSGField1 = case when eedbenamt <=0 THEN dedeebenamt else eedbenamt END
    FROM dbo.U_dsi_bdm_EBCBSTFBN
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EBCBSTFBN
        SET BdmUSGField2 = DbnDepBPlanTVID
        ,BdmUSGField1 = dedeebenamt
    FROM dbo.U_dsi_bdm_EBCBSTFBN
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
   /* UPDATE dbo.U_dsi_bdm_EBCBSTFBN
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EBCBSTFBN
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;
    */
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EBCBSTFBN_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EBCBSTFBN_PDedHist;
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
    INTO dbo.U_EBCBSTFBN_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EBCBSTFBN_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    
    --Audit Table
    IF OBJECT_ID('U_EBCBSTFBN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBCBSTFBN_AuditFields;
    CREATE TABLE dbo.U_EBCBSTFBN_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EBCBSTFBN_AuditFields VALUES ('EmpComp','eecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EBCBSTFBN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBCBSTFBN_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EBCBSTFBN_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EBCBSTFBN_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EBCBSTFBN_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBCBSTFBN_Audit ON dbo.U_EBCBSTFBN_Audit (audKey1Value, audKey2Value);


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EBCBSTFBN_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBCBSTFBN_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBCBSTFBN_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvGroup = 'VF026252'
        ,drvAccount = '1'
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvEmployeeMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvSocialSecurityNumber = eepSSN
        ,drvTypeofTransaction = CASE WHEN EecEmplStatus = 'T' THEN 'T'
                                     WHEN EecEmplStatus IN  ('A', 'L') THEN 'A'
                                END

        ,drvDateofBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvFullTimeHireDate = EecDateOfLastHire
        ,drvClass = '1'
        ,drvLocation = ''
        ,drvSalary = CAST(EecAnnSalary as varchar)
        ,drvSalaryMode = 'A'
        ,drvSalaryEffDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, getdate(),EecDateOfLastHire)
        ,drvEffDate = CASE WHEN LIFE_startDate is not null then LIFE_startDate END
        ,drvEEDateTerm = EecDateOfTermination
        ,drvBasicLifeEffDate = CASE WHEN LIFE is not null then LIFE_startDate END
        ,drvBasicLifeAmt = CASE WHEN LIFE is not null then LIFE_BenAmt END  
        ,drvBasicLifeTerminationDate = CASE WHEN LIFE is not null then LIFE_stopDate END
        ,drvBasicADDEffDate = CASE WHEN LIFE_startDate is not null then LIFE_startDate END
        ,drvBasicADDAmt = CASE WHEN LIFE is not null then LIFE_BenAmt END  
        ,drvBasicADDTerminationDate = CASE WHEN LIFE is not null then LIFE_stopDate END
        ,drvBasicLTDEffDate = CASE WHEN LTD is not null then LTD_startDate END
        ,drvBasicLTDAmt = CASE WHEN LTD is not null then LTD_BenAmt END
        ,drvBasicLTDTerminationDate = CASE WHEN LTD is not null then LTD_stopDate END
        ,drvBasicSTDEffDate = CASE WHEN STD is not null then STD_startdate END
        ,drvBasicSTDAmt = CASE WHEN STD is not null then STD_BenAmt END  
        ,drvBasicSTDTerminationDate = CASE WHEN STD is not null then STD_stopDate END  
        ,drvSuppEmployeeLifeEffDate = CASE WHEN EELF is not null then (Select max(edheffdate) from emphded where edheeid = xeeid  and edhdedcode = 'EELF') END  
        ,drvSuppEmployeeLifeAmt = CASE WHEN EELF is not null then (Select top 1 BdmUSGField1 from dbo.U_dsi_BDM_EBCBSTFBN B where B.bdmeeid = Consolidated.bdmeeid and B.bdmdedcode = 'EELF' and B.bdmrectype = 'EMP') END 
        ,drvSuppEmployeeLifeDateTerm = CASE WHEN EELF is not null then EELF_stopDate END
        ,drvSuppEmployeeADDEffDate = CASE WHEN EELF is not null then (Select max(edheffdate) from emphded where edheeid = xeeid and edhdedcode = 'EELF') END  
        ,drvSuppEmployeeADDAmt = CASE WHEN EELF is not null then (Select top 1 BdmUSGField1 from U_dsi_BDM_EBCBSTFBN B where B.bdmeeid = Consolidated.bdmeeid and B.bdmdedcode = 'EELF' and B.bdmrectype = 'EMP') END 
        ,drvSuppEmployeeADDDateTerm =  CASE WHEN EELF is not null then EELF_stopDate END
        ,drvSuppChildLifeEffDate =  CASE WHEN CHLF is not null then (Select max(edheffdate) from emphded where edheeid = xeeid and edhdedcode = 'CHLF') END
        ,drvSuppChildLifeAmt = CASE WHEN CHLF is not null then  (Select top 1 BdmUSGField1 from U_dsi_BDM_EBCBSTFBN B where B.bdmeeid = Consolidated.bdmeeid and B.bdmdedcode = 'CHLF' and B.bdmrectype = 'EMP') END 
        ,drvSuppChildLifeDateTerm =  CASE WHEN CHLF is not null then CHLF_stopDate END
        ,drvSuppChildADDEffDate =  CASE WHEN CHLF is not null then (Select max(edheffdate) from emphded where edheeid = xeeid and edhdedcode = 'CHLF') END
        ,drvSuppChildADDAmt = CASE WHEN CHLF is not null then (Select top 1 BdmUSGField1 from U_dsi_BDM_EBCBSTFBN B where B.bdmeeid = Consolidated.bdmeeid and B.bdmdedcode = 'CHLF' and B.bdmrectype = 'EMP') END 
        ,drvSuppChildADDDateTerm = CASE WHEN CHLF is not null then CHLF_stopDate END
        ,drvSuppSpouseLifeEffDate = CASE WHEN SPLF is  not null THEN (Select max(edheffdate) from emphded where edheeid = xeeid and edhdedcode = 'SPLF') END
        ,drvSuppSpouseLifeAmt =  CASE WHEN SPLF is  not null THEN (Select top 1 BdmUSGField1 from U_dsi_BDM_EBCBSTFBN B where B.bdmeeid = Consolidated.bdmeeid and B.bdmdedcode = 'SPLF' and B.bdmrectype = 'EMP') END
        ,drvSuppSpouseLifeDateTerm =  CASE WHEN SPLF is  not null THEN SPLF_StopDate END
        ,drvSuppSpouseADDEffDate = CASE WHEN SPLF is  not null THEN (Select max(edheffdate) from emphded where edheeid = xeeid and edhdedcode = 'SPLF') END
        ,drvSuppSpouseADDAmt = CASE WHEN SPLF is  not null THEN (Select top 1 BdmUSGField1 from U_dsi_BDM_EBCBSTFBN B where B.bdmeeid = Consolidated.bdmeeid and B.bdmdedcode = 'SPLF' and B.bdmrectype = 'EMP') END
        ,drvSuppSpouseADDDateTerm = CASE WHEN SPLF is  not null THEN SPLF_StopDate END
        ,drvVoluntaryVisionEffDate = CASE WHEN VISION is not null then VISION_StartDate END
        ,drvVoluntaryVisionTier = CASE WHEN VISION IS NOT  NULL THEN
                                        CASE WHEN VISION_benoption = '000001' THEN 'E'
                                             WHEN VISION_benoption = '000002' THEN 'S'
                                             WHEN VISION_benoption = '000003' THEN 'C'
                                             WHEN VISION_benoption = '000004' THEN 'F'
                                        END
                                  END
        ,drvVoluntaryVisionDateTerm = CASE WHEN VISION IS NOT NULL THEN Vision_Stopdate END
        ,drvVolVisionCOBRAEffDate = ''
        ,drvVoluntaryVisionCOBRATier = ''
        ,drvVolVisionCOBRADateTerm = ''
        ,drvEmployeeAddress1 = eepAddressLine1  + ' ' + ISNULL(eepAddressLine2,'')
        ,drvEmployeeAddress2 = EepAddressCity
        ,drvEmployeeAddress3 = EepAddressState
        ,drvEmployeeAddress4 = EepAddressZipCode
        ,drvDepLastName1 = DepLastName1
        ,drvDepFirstName1 = DepFirstName1
        ,drvDepMI1 =  LEFT(ISNULL(DepMiddleName1,''),1) 
        ,drvDepDateofBirth1 = DepDateOfBirth1
        ,drvDepRelationship1 = CASE WHEN DepRelationship1 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship1 in ('CHD', 'CHL', 'DPC') and DepDisabled1 = 'N' THEN 'C'
                                     WHEN DepRelationship1 in ('DP','SPS','PTR') and DepDisabled1 = 'Y' THEN 'S'
                               END 
        ,drvGender1 = DepGender1
        ,drvDepVisionEffDate1 = CASE WHEN DepLastName1 is not null then VISION_startdate END
        ,drvDepVisionTerminationDate1 = CASE WHEN DepLastName1 is not null  then DepBdmBenStopdate1 END
        ,drvDepLastName2 = DepLastName2
        ,drvDepFirstName2 = DepFirstName2
        ,drvDepMI2 =  LEFT(ISNULL(DepMiddleName2,''),1) 
        ,drvDepDateofBirth2 = DepDateOfBirth2
        ,drvDepRelationship2 =  CASE WHEN DepRelationship2 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship2 in ('CHD', 'CHL', 'DPC') and DepDisabled2 = 'N' THEN 'C'
                                     WHEN DepRelationship2 in ('DP','SPS','PTR') and DepDisabled2 = 'Y' THEN 'S'
                               END 
        ,drvGender2 = DepGender2
        ,drvDepVisionEffDate2 = CASE WHEN DepLastName2 is not null then VISION_startdate end
        ,drvDepVisionTerminationDate2 = CASE WHEN DepLastName2 is not null THEN DepBdmBenStopdate2 END
        ,drvDepLastName3 = DepLastName3
        ,drvDepFirstName3 = DepFirstName3
        ,drvDepMI3 =  LEFT(ISNULL(DepMiddleName3,''),1) 
        ,drvDepDateofBirth3 = DepDateOfBirth3
        ,drvDepRelationship3 =  CASE WHEN DepRelationship3 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship3 in ('CHD', 'CHL', 'DPC') and DepDisabled3 = 'N' THEN 'C'
                                     WHEN DepRelationship3 in ('DP','SPS','PTR') and DepDisabled3 = 'Y' THEN 'S'
                               END 
        ,drvGender3 = DepGender3
        ,drvDepVisionEffDate3 = CASE WHEN DepLastName3 is not null then VISION_startdate end
        ,drvDepVisionTerminationDate3 =  CASE WHEN DepLastName3 is not null then DepBdmBenStopdate3 end
        ,drvDepLastName4 = DepLastName4
        ,drvDepFirstName4 = DepFirstName4
        ,drvDepMI4 =  LEFT(ISNULL(DepMiddleName4,''),1) 
        ,drvDepDateofBirth4 = DepDateOfBirth4
        ,drvDepRelationship4 =  CASE WHEN DepRelationship4 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship4 in ('CHD', 'CHL', 'DPC') and DepDisabled4 = 'N' THEN 'C'
                                     WHEN DepRelationship4 in ('DP','SPS','PTR') and DepDisabled4 = 'Y' THEN 'S'
                               END 
        ,drvGender4 = DepGender4
        ,drvDepVisionEffDate4 = CASE WHEN DepLastName4 is not null then VISION_startdate end
        ,drvDepVisionTerminationDate4 =  CASE WHEN DepLastName4 is not null then DepBdmBenStopdate4 end
        ,drvDepLastName5 = DepLastName5
        ,drvDepFirstName5 = DepFirstName5
        ,drvDepMI5 =  LEFT(ISNULL(DepMiddleName5,''),1) 
        ,drvDepDateofBirth5 = DepDateOfBirth5
        ,drvDepRelationship5 =  CASE WHEN DepRelationship5 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship5 in ('CHD', 'CHL', 'DPC') and DepDisabled5 = 'N' THEN 'C'
                                     WHEN DepRelationship5 in ('DP','SPS','PTR') and DepDisabled5 = 'Y' THEN 'S'
                               END 
        ,drvGender5 = DepGender5
         ,drvDepVisionEffDate5 = CASE WHEN DepLastName5 is not null then VISION_startdate end
        ,drvDepVisionTerminationDate5 =  CASE WHEN DepLastName5 is not null then DepBdmBenStopdate5 end
        ,drvDepLastName6 = DepLastName6
        ,drvDepFirstName6 = DepFirstName6
        ,drvDepMI6 =  LEFT(ISNULL(DepMiddleName6,''),1) 
        ,drvDepDateofBirth6 = DepDateOfBirth6
        ,drvDepRelationship6 =  CASE WHEN DepRelationship6 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship6 in ('CHD', 'CHL', 'DPC') and DepDisabled6 = 'N' THEN 'C'
                                     WHEN DepRelationship6 in ('DP','SPS','PTR') and DepDisabled6 = 'Y' THEN 'S'
                               END 
        ,drvGender6 = DepGender6
        ,drvDepVisionEffDate6 = CASE WHEN DepLastName6 is not null then VISION_startdate end
        ,drvDepVisionTerminationDate6 =  CASE WHEN DepLastName6 is not null then DepBdmBenStopdate6 end
        ,drvDepLastName7 = DepLastName7
        ,drvDepFirstName7 = DepFirstName7
        ,drvDepMI7 =  LEFT(ISNULL(DepMiddleName7,''),1) 
        ,drvDepDateofBirth7 = DepDateOfBirth7
        ,drvDepRelationship7 =  CASE WHEN DepRelationship7 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship7 in ('CHD', 'CHL', 'DPC') and DepDisabled7 = 'N' THEN 'C'
                                     WHEN DepRelationship7 in ('DP','SPS','PTR') and DepDisabled7 = 'Y' THEN 'S'
                               END 
        ,drvGender7 = DepGender7
    ,drvDepVisionEffDate7 = CASE WHEN DepLastName7 is not null then VISION_startdate end
        ,drvDepVisionTerminationDate7 =  CASE WHEN DepLastName7 is not null then DepBdmBenStopdate7 end
        ,drvDepLastName8 = DepLastName8
        ,drvDepFirstName8 = DepFirstName8
        ,drvDepMI8 =  LEFT(ISNULL(DepMiddleName8,''),1) 
        ,drvDepDateofBirth8 = DepDateOfBirth8
        ,drvDepRelationship8 =  CASE WHEN DepRelationship8 in ('DP','SPS','PTR') THEN 'S'
                                     WHEN DepRelationship8 in ('CHD', 'CHL', 'DPC') and DepDisabled8 = 'N' THEN 'C'
                                     WHEN DepRelationship8 in ('DP','SPS','PTR') and DepDisabled8 = 'Y' THEN 'S'
                               END 
        ,drvGender8 = DepGender8
    ,drvDepVisionEffDate8 = CASE WHEN DepLastName8 is not null then VISION_startdate end
        ,drvDepVisionTerminationDate8 =  CASE WHEN DepLastName8 is not null then DepBdmBenStopdate8 end
    INTO dbo.U_EBCBSTFBN_drvTbl
    FROM dbo.U_EBCBSTFBN_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
          and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EBCBSTFBN_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (Select  A.bdmEEID,A.bdmcoid
            ,LIFE = MAX((CASE WHEN BDMDedCode = 'LIFE' then 'LIFE' END))
            ,LTD = MAX((CASE WHEN BDMDedCode IN ('LTD1','LTD2') then BDMDedCode END))
            ,STD = MAX((CASE WHEN BDMDedCode IN ('STD') then BDMDedCode END))

            ,EELF = MAX((CASE WHEN BDMDedCode = 'EELF' then 'EELF' END))
            ,CHLF  = MAX((CASE WHEN BDMDedCode = 'CHLF' then 'CHLF' END))
            ,SPLF   = MAX((CASE WHEN BDMDedCode = 'SPLF ' then 'SPLF ' END))
            ,VISION  = MAX((CASE WHEN BDMDedCode = 'V0001 ' then 'V0001 ' END))
            ,LIFE_startDate = MAX((CASE WHEN BDMDedCode = 'LIFE' then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('01/01/2021' as datetime) ) END))
            ,LTD_startDate = MAX((CASE WHEN BDMDedCode  IN ('LTD1','LTD2') then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('01/01/2021' as datetime) ) END))
            ,EELF_startdate = MAX((CASE WHEN BDMDedCode = 'EELF' then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('01/01/2021' as datetime) ) END))
            ,CHLF_startdate = MAX((CASE WHEN BDMDedCode = 'CHLF' then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('01/01/2021' as datetime) ) END))
            ,SPLF_startdate = MAX((CASE WHEN BDMDedCode IN ('SPLF') then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('01/01/2021' as datetime) ) END))
            ,STD_startdate = MAX((CASE WHEN BDMDedCode IN ('STD') then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('01/01/2021' as datetime) ) END))
            ,VISION_startdate = MAX((CASE WHEN BDMDedCode = 'V0001' then dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('01/01/2021' as datetime) ) END))
            ,LIFE_stopDate = MAX((CASE WHEN BDMDedCode = 'LIFE' then bdmbenstopDate END))
            ,LTD_stopDate = MAX((CASE WHEN BDMDedCode  IN ('LTD1','LTD2') then bdmbenstopDate END))
            ,EELF_stopDate = MAX((CASE WHEN BDMDedCode = 'EELF' then bdmbenstopDate END))
            ,CHLF_stopDate = MAX((CASE WHEN BDMDedCode = 'CHLF' then bdmbenstopDate END))
            ,VISION_stopDate = MAX((CASE WHEN BDMDedCode = 'V0001' then bdmbenstopDate END))
            ,SPLF_stopdate = MAX((CASE WHEN BDMDedCode IN ('SPLF') then bdmbenstopDate END))
            ,STD_stopdate = MAX((CASE WHEN BDMDedCode IN ('STD') then bdmbenstopDate END))
            ,LIFE_benoption = MAX((CASE WHEN BDMDedCode = 'LIFE' then BdmBenOption END))
            ,LTD_benoption = MAX((CASE WHEN BDMDedCode  IN ('LTD1','LTD2') then BdmBenOption END))
            ,EELF_benoption = MAX((CASE WHEN BDMDedCode = 'CHLF' then BdmBenOption END))
            ,CHLF_benoption = MAX((CASE WHEN BDMDedCode = 'SPLF' then BdmBenOption END))
            ,VISION_benoption = MAX((CASE WHEN BDMDedCode = 'V0001' then BdmBenOption END))
            ,STD_benoption = MAX((CASE WHEN BDMDedCode = 'STD' then BdmBenOption END))
            ,SPLF_benoption = MAX((CASE WHEN BDMDedCode = 'SPLF' then BdmBenOption END))
            ,LIFE_BenAmt = MAX((CASE WHEN BDMDedCode = 'LIFE' then BdmUSGField1 END))
            ,LTD_BenAmt = MAX((CASE WHEN BDMDedCode  IN ('LTD1','LTD2') then BdmUSGField1 END))
            ,EELF_BenAmt = MAX((CASE WHEN BDMDedCode = 'EELF' then BdmUSGField1 END))
            ,CHLF_BenAmt = MAX((CASE WHEN BDMDedCode = 'CHLF' then BdmUSGField1 END))
            ,SPLF_BenAmt = MAX((CASE WHEN BDMDedCode = 'SPLF' then BdmUSGField1 END))
            ,STD_BenAmt = MAX((CASE WHEN BDMDedCode = 'STD' then BdmUSGField1 END))

            from dbo.U_dsi_BDM_EBCBSTFBN A Group By bdmeeid,bdmcoid)  as Consolidated
        ON Consolidated.BdmEEID = xEEID 
        AND Consolidated.BdmCoID = xCoID
   LEFT JOIN (Select bdmeeid AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1

            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) AS DepLastName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) AS DepFirstName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConSSN END) AS DepSsn5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) AS DepDateOfBirth5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConRelationship END) AS DepRelationship5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) AS DepLastName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) AS DepFirstName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConSSN END) AS DepSsn6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) AS DepDateOfBirth6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConRelationship END) AS DepRelationship6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) AS DepLastName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) AS DepFirstName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConSSN END) AS DepSsn7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) AS DepDateOfBirth7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConRelationship END) AS DepRelationship7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) AS DepLastName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) AS DepFirstName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConSSN END) AS DepSsn8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) AS DepDateOfBirth8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConRelationship END) AS DepRelationship8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameLast END) AS DepLastName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameFirst END) AS DepFirstName9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConSSN END) AS DepSsn9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConDateOfBirth END) AS DepDateOfBirth9
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConRelationship END) AS DepRelationship9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameLast END) AS DepLastName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameFirst END) AS DepFirstName10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConSSN END) AS DepSsn10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConDateOfBirth END) AS DepDateOfBirth10
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConRelationship END) AS DepRelationship10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameLast END) AS DepLastName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameFirst END) AS DepFirstName11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConSSN END) AS DepSsn11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConDateOfBirth END) AS DepDateOfBirth11
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConRelationship END) AS DepRelationship11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameLast END) AS DepLastName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameFirst END) AS DepFirstName12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConSSN END) AS DepSsn12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConDateOfBirth END) AS DepDateOfBirth12
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConRelationship END) AS DepRelationship12
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameMiddle END) AS DepMiddleName1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameMiddle END) AS DepMiddleName2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameMiddle END) AS DepMiddleName3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameMiddle END) AS DepMiddleName4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameMiddle END) AS DepMiddleName5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameMiddle END) AS DepMiddleName6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameMiddle END) AS DepMiddleName7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameMiddle END) AS DepMiddleName8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConNameMiddle END) AS DepMiddleName9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConNameMiddle END) AS DepMiddleName10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConNameMiddle END) AS DepMiddleName11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConNameMiddle END) AS DepMiddleName12
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConGender END) AS DepGender1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConGender END) AS DepGender2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConGender END) AS DepGender3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConGender END) AS DepGender4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConGender END) AS DepGender5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConGender END) AS DepGender6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConGender END) AS DepGender7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConGender END) AS DepGender8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConGender END) AS DepGender9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConGender END) AS DepGender10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConGender END) AS DepGender11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConGender END) AS DepGender12
             ,MAX(CASE WHEN Dep_Number = 1 THEN ConIsDisabled END) AS DepDisabled1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConIsDisabled END) AS DepDisabled2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConIsDisabled END) AS DepDisabled3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConIsDisabled END) AS DepDisabled4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConIsDisabled END) AS DepDisabled5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConIsDisabled END) AS DepDisabled6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConIsDisabled END) AS DepDisabled7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConIsDisabled END) AS DepDisabled8
            ,MAX(CASE WHEN Dep_Number = 9 THEN ConIsDisabled END) AS DepDisabled9
            ,MAX(CASE WHEN Dep_Number = 10 THEN ConIsDisabled END) AS DepDisabled10
            ,MAX(CASE WHEN Dep_Number = 11 THEN ConIsDisabled END) AS DepDisabled11
            ,MAX(CASE WHEN Dep_Number = 12 THEN ConIsDisabled END) AS DepDisabled12
             ,MAX(CASE WHEN Dep_Number = 1 THEN bdmbenstopdate END) AS DepBdmBenStopdate1
            ,MAX(CASE WHEN Dep_Number = 2 THEN bdmbenstopdate END) AS DepBdmBenStopdate2
            ,MAX(CASE WHEN Dep_Number = 3 THEN bdmbenstopdate END) AS DepBdmBenStopdate3
            ,MAX(CASE WHEN Dep_Number = 4 THEN bdmbenstopdate END) AS DepBdmBenStopdate4
            ,MAX(CASE WHEN Dep_Number = 5 THEN bdmbenstopdate END) AS DepBdmBenStopdate5
            ,MAX(CASE WHEN Dep_Number = 6 THEN bdmbenstopdate END) AS DepBdmBenStopdate6
            ,MAX(CASE WHEN Dep_Number = 7 THEN bdmbenstopdate END) AS DepBdmBenStopdate7
            ,MAX(CASE WHEN Dep_Number = 8 THEN bdmbenstopdate END) AS DepBdmBenStopdate8
            ,MAX(CASE WHEN Dep_Number = 9 THEN bdmbenstopdate END) AS DepBdmBenStopdate9
            ,MAX(CASE WHEN Dep_Number = 10 THEN bdmbenstopdate END) AS DepBdmBenStopdate10
            ,MAX(CASE WHEN Dep_Number = 11 THEN bdmbenstopdate END) AS DepBdmBenStopdate11
            ,MAX(CASE WHEN Dep_Number = 12 THEN bdmbenstopdate END) AS DepBdmBenStopdate12
            ,Count(CASE WHEN ConRelationship IN ('DAU', 'SON', 'DIS', 'STC','CHL') THEN Dep_Number END) as Child_Counts

        From (
                select bdmeeid, ConNameLast, ConNameMiddle,ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ConGender, ConIsDisabled,bdmdedcode,bdmbenstopdate,ROW_NUMBER() OVER (PARTITION BY bdmeeid ORDER BY bdmeeid) AS 'Dep_Number'
                from  dbo.U_dsi_BDM_EBCBSTFBN A 
                JOIN dbo.Contacts WITH (NOLOCK) 
                ON ConEEID = bdmeeid 
                AND ConSystemID = BdmDepRecID
                where bdmrelationship IN ('DAU', 'SON', 'DIS', 'STC','CHL','CHD','SPS','DP')  and bdmdedcode in ('V0001') 
                    group by bdmeeid, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ConNameMiddle,ConGender,ConIsDisabled,bdmdedcode,bdmbenstopdate)
             AS Source Group By bdmeeid)  as C
                on C.KidEEID = Consolidated.bdmeeid

    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEBCBSTFBN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBCBSTFBN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBCBSTFBN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102171'
       ,expStartPerControl     = '202102171'
       ,expLastEndPerControl   = '202102249'
       ,expEndPerControl       = '202102249'
WHERE expFormatCode = 'EBCBSTFBN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBCBSTFBN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBCBSTFBN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2