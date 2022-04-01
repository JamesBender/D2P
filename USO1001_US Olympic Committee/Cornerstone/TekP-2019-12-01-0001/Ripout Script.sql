SET NOCOUNT ON;
IF OBJECT_ID('U_ECRNUSODE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECRNUSODE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECRNUSODE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECRNUSODE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECRNUSODE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECRNUSODE_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNUSODE_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECRNUSODE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNUSODE];
GO
IF OBJECT_ID('U_ECRNUSODE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_PEarHist];
GO
IF OBJECT_ID('U_ECRNUSODE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_PDedHist];
GO
IF OBJECT_ID('U_ECRNUSODE_File') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_File];
GO
IF OBJECT_ID('U_ECRNUSODE_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_EEList];
GO
IF OBJECT_ID('U_ECRNUSODE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_drvTbl];
GO
IF OBJECT_ID('U_ECRNUSODE_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_DedList];
GO
IF OBJECT_ID('U_ECRNUSODE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_AuditFields];
GO
IF OBJECT_ID('U_ECRNUSODE_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECRNUSODE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECRNUSODE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECRNUSODE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECRNUSODE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECRNUSODE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECRNUSODE','CornerStone Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECRNUSODE0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECRNUSODE' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User ID"','1','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','1',NULL,'User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Username"','2','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','2',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Active"','3','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','3',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Absent"','4','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','4',NULL,'Absent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Allow Reconciliation"','5','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','5',NULL,'Allow Reconciliation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Prefix"','6','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','6',NULL,'Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','7','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','8','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','8',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','9','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','9',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Suffix"','10','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','10',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','11','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','11',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','12','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','12',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','13','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','13',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mobile Phone"','14','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','14',NULL,'Mobile Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Fax"','15','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','15',NULL,'Fax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country Code"','16','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','16',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Line 1"','17','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','17',NULL,'Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Line 2"','18','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','18',NULL,'Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Mail Stop"','19','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','19',NULL,'Mail Stop',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','20','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','20',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State/Province"','21','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division ID"','22','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location ID"','23','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Position ID"','24','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cost Center ID','25','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Grade ID','26','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','27','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','22',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Hire Date"','28','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','23',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','29','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','24',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Required Approvals"','30','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','25',NULL,'Required Approvals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Approver ID"','31','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','26',NULL,'Approver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager ID"','32','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','27',NULL,'Manager ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Executive Team Leader"','33','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','27',NULL,'Executive Team Leader',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','34','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','28',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Ethnicity"','35','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','29',NULL,'Ethnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Language"','36','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','30',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Time Zone"','37','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','31',NULL,'Time Zone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Compensation Currency"','38','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','32',NULL,'Compensation Currency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Preferred Name"','39','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','33',NULL,'Preferred Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"People and Culture"','40','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','34',NULL,'People & Culture User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Actual Wages Earned"','41','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','34',NULL,'Actual Wages Earned',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Compensation Level for Bonus"','42','(''DA''=''Q,'')','ECRNUSODE0Z0','50','H','01','34',NULL,'Compensation Level for Bonus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Type"','43','(''DA''=''Q'')','ECRNUSODE0Z0','50','H','01','34',NULL,'Employee Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserID"','1','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','1',NULL,'User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsername"','2','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','2',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActive"','3','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','3',NULL,'Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAbsent"','4','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','4',NULL,'Absent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAllowReconciliation"','5','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','5',NULL,'Allow Reconciliation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrefix"','6','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','6',NULL,'Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','7','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','8','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','8',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','9','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','9',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuffix"','10','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','10',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','11','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','11',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','12','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','12',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','13','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','13',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMobilePhone"','14','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','14',NULL,'Mobile Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFax"','15','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','15',NULL,'Fax',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','16','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','16',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLine1"','17','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','17',NULL,'Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLine2"','18','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','18',NULL,'Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailStop"','19','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','19',NULL,'Mail Stop',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','20','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','20',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateProvince"','21','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionId"','22','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationId"','23','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPositionId"','24','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCostCenterId"','25','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGradeId"','26','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','21',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','27','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','22',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastHireDate"','28','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','23',NULL,'Last Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigHirDate"','29','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','24',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequiredApproval"','30','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','25',NULL,'Required Approvals',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApproverId"','31','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','26',NULL,'Approver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerId"','32','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','27',NULL,'Manager ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExecutiveTeamLeader"','33','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','27',NULL,'Executive Team Leader',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','34','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','28',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEthnicity"','35','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','29',NULL,'Ethnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguage"','36','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','30',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTimeZone"','37','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','31',NULL,'Time Zone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompensationCurrency"','38','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','32',NULL,'Compensation Currency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreferredName"','39','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','33',NULL,'Preferred Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeopleCultureUserID"','40','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','34',NULL,'People & Culture User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualWagesEarned"','41','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','34',NULL,'People & Culture User ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompensationLevelforBonus"','42','(''UA''=''Q,'')','ECRNUSODE0Z0','50','D','10','34',NULL,'CompensationLevelforBonus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','43','(''UA''=''Q'')','ECRNUSODE0Z0','50','D','10','34',NULL,'EmployeeType',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECRNUSODE_20201229.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202006179','EMPEXPORT','OEACTIVE',NULL,'ECRNUSODE',NULL,NULL,NULL,'202006179','Jun 17 2020  5:37PM','Jun 17 2020  5:37PM','202006171',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202006179','EMPEXPORT','OEPASSIVE',NULL,'ECRNUSODE',NULL,NULL,NULL,'202006179','Jun 17 2020  5:37PM','Jun 17 2020  5:37PM','202006171',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CornerStone Demo Export','202006179','EMPEXPORT','ONDEMAND',NULL,'ECRNUSODE',NULL,NULL,NULL,'202006179','Jun 17 2020  5:37PM','Jun 17 2020  5:37PM','202006171',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',V5C45',NULL,NULL,NULL,'Cornerstone User - Daily 11pm','202006179','EMPEXPORT','SCH_CRND',NULL,'ECRNUSODE',NULL,NULL,NULL,'202012109','Jun 17 2020  5:37PM','Jun 17 2020  5:37PM','202012091',NULL,'','','202006171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','V5C45',NULL,NULL,NULL,'Test Purposes Only','202009231','EMPEXPORT','TEST','Sep 23 2020  5:11PM','ECRNUSODE',NULL,NULL,NULL,'202009231','Sep 23 2020 12:00AM','Dec 30 1899 12:00AM','202009011','384','','','202009011',dbo.fn_GetTimedKey(),NULL,'us3mLaUSO1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNUSODE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNUSODE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNUSODE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNUSODE','OEPath','V','');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNUSODE','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNUSODE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECRNUSODE','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECRNUSODE' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECRNUSODE' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECRNUSODE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECRNUSODE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNUSODE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECRNUSODE','D10','dbo.U_ECRNUSODE_drvTbl',NULL);
IF OBJECT_ID('U_ECRNUSODE_Audit') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_ECRNUSODE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECRNUSODE_DedList') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECRNUSODE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvUserID] char(9) NULL,
    [drvUsername] varchar(50) NULL,
    [drvActive] varchar(5) NOT NULL,
    [drvAbsent] varchar(5) NOT NULL,
    [drvAllowReconciliation] varchar(4) NOT NULL,
    [drvPrefix] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NULL,
    [drvLastName] varchar(100) NULL,
    [drvSuffix] varchar(30) NULL,
    [drvEmail] varchar(50) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvMobilePhone] varchar(50) NULL,
    [drvFax] varchar(1) NOT NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvLine1] varchar(255) NULL,
    [drvLine2] varchar(255) NULL,
    [drvMailStop] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvStateProvince] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvDivisionId] varchar(10) NULL,
    [drvLocationId] char(6) NULL,
    [drvPositionId] char(8) NULL,
    [drvCostCenterId] varchar(10) NULL,
    [drvGradeId] char(6) NULL,
    [drvLastHireDate] nvarchar(4000) NULL,
    [drvOrigHirDate] nvarchar(4000) NULL,
    [drvRequiredApproval] varchar(1) NOT NULL,
    [drvApproverId] varchar(1) NOT NULL,
    [drvManagerId] varchar(256) NULL,
    [drvExecutiveTeamLeader] nvarchar(4000) NULL,
    [drvGender] varchar(9) NOT NULL,
    [drvEthnicity] varchar(1) NULL,
    [drvLanguage] varchar(5) NOT NULL,
    [drvTimeZone] varchar(1) NOT NULL,
    [drvCompensationCurrency] varchar(3) NOT NULL,
    [drvPreferredName] varchar(100) NULL,
    [drvPeopleCultureUserID] varchar(7) NOT NULL,
    [drvActualWagesEarned] varchar(12) NULL,
    [drvCompensationLevelforBonus] char(10) NULL,
    [drvEmployeeType] varchar(45) NULL
);
IF OBJECT_ID('U_ECRNUSODE_EEList') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECRNUSODE_File') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECRNUSODE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_PDedHist] (
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
IF OBJECT_ID('U_ECRNUSODE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECRNUSODE_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNUSODE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 06/17/2020
Service Request Number: SR-2016-00012345

Purpose: CornerStone Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECRNUSODE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECRNUSODE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECRNUSODE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECRNUSODE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECRNUSODE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECRNUSODE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECRNUSODE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECRNUSODE';

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
    DELETE FROM dbo.U_ECRNUSODE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECRNUSODE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECRNUSODE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_AuditFields;
    CREATE TABLE dbo.U_ECRNUSODE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
        INSERT INTO dbo.U_ECRNUSODE_AuditFields VALUES ('EmpComp','EecEmplStatus');    

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECRNUSODE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_Audit;
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
    INTO dbo.U_ECRNUSODE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECRNUSODE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECRNUSODE_Audit ON dbo.U_ECRNUSODE_Audit (audEEID,audKey2);

    

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECRNUSODE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_PDedHist;
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
    INTO dbo.U_ECRNUSODE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECRNUSODE_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECRNUSODE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_PEarHist;
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
    INTO dbo.U_ECRNUSODE_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    AND PehEarnCode in ('ADMLV','ADPLV','BEREV','CRGVL','DT','FFCRA','HOL','JURY','NYPFL','OT','PARLV','PFML','PTO','REG','RETHR','RETOT','RETRO','SICK','SPRNG','STD1','STD60','STDPR','STDSK','STDVA','VAC','VOL','WKCMP','WNTR','FFCRA','HFWA','FFCHF','CRGVL','CRGHF','CRGFH','PFML','PPVQ')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECRNUSODE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECRNUSODE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvUserID = eecempno
        ,drvUsername = SUBSTRING(susUsername,PATINDEX('%[^0]%',susUsername),LEN(susUsername))  
        ,drvActive = CASE WHEN eecemplstatus = 'T' THEN 'FALSE' else  'TRUE' END
        ,drvAbsent = CASE WHEN eecemplstatus = 'L' THEN 'TRUE' else  'FALSE' END
        ,drvAllowReconciliation = 'TRUE'
        ,drvPrefix = ''
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvLastName = EepNameLast
        ,drvSuffix = CASE WHEN ISNULL(eepnamesuffix,'') in ('Z','') THEN '' ELSE  eepnamesuffix END
        ,drvEmail = EepAddressEMail
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvMobilePhone = (Select top 1 efoPhoneNumber from  dbo.EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)
        ,drvFax = ''
        ,drvCountryCode = 'US'
        ,drvLine1 = EepAddressLine1
        ,drvLine2 = EepAddressLine2
        ,drvMailStop = ''
        ,drvCity = EepAddressCity
        ,drvStateProvince = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvDivisionId = eecorglvl3
        ,drvLocationId = eeclocation
        ,drvPositionId = EecJobCode
        ,drvCostCenterId = eecorglvl4
        ,drvGradeId = (Select top 1 EjhSalaryGrade from dbo.vw_int_EmpHJob  where ejheeid =  xeeid and ejhcoid  =  xcoid order by ejhdatetimecreated desc)
        ,drvLastHireDate = FORMAT(EecDateOfLastHire, 'yyyy-MM-dd') 
        ,drvOrigHirDate = FORMAT(eecdateoforiginalhire, 'yyyy-MM-dd')  
        ,drvRequiredApproval = CASE WHEN dbo.dsi_fnlib_GetSupervisorField_v2('', EM.EecEEID, 'Count')  = '' THEN '0'
                                    WHEN dbo.dsi_fnlib_GetSupervisorField_v2('', EM.EecEEID, 'Count') = 1 THEN '1'
                                    WHEN dbo.dsi_fnlib_GetSupervisorField_v2('', EM.EecEEID, 'Count') = 2 THEN '2'
                                    ELSE '3'    
                                END
        ,drvApproverId = ''
        ,drvManagerId = SUBSTRING(dbo.dsi_fnlib_GetSupervisorField('', EM.EecEEID, 'EmpNo') ,PATINDEX('%[^0]%',dbo.dsi_fnlib_GetSupervisorField('', EM.EecEEID, 'EmpNo') ),LEN(dbo.dsi_fnlib_GetSupervisorField('', EM.EecEEID, 'EmpNo') ))     
         ,drvExecutiveTeamLeader = SUBSTRING(Employment_ELTMember,PATINDEX('%[^0]%',Employment_ELTMember),LEN(Employment_ELTMember))   
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'Male' 
                           WHEN EepGender = 'F' THEN 'Female' 
                           ELSE 'Not Known'
                     END
                        
        ,drvEthnicity = CASE WHEN ISNULL(eepEthnicID,'') in ('Z') THEN '' ELSE eepEthnicID END
        ,drvLanguage = 'en-US'
        ,drvTimeZone = ''
        ,drvCompensationCurrency = 'USD'
        ,drvPreferredName = EepNamePreferred
        ,drvPeopleCultureUserID = 'PCAdmin'
        ,drvActualWagesEarned = CAST(PehCurAmtYTD as varchar(12))
        ,drvCompensationLevelforBonus = EECUDFIELD01
        ,drvEmployeeType = (Select top 1 CodDesc from dbo.Codes WITH (NOLOCK) where CodTable = 'EMPTYPE' and CodCode  = eeceetype)
    INTO dbo.U_ECRNUSODE_drvTbl
    FROM dbo.U_ECRNUSODE_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EM WITH (NOLOCK)
        ON EM.EecEEID = xEEID 
        AND EM.EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ECRNUSODE_Audit where  audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ECRNUSODE_PEarHist WITH (NOLOCK)
        ON PehEEID = xeeid
    JOIN dbo.vw_rbsUserFinder on suceeid = xeeid
    LEFT JOIN (select * from dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL)) as A
    ON A.EecEEID = xEEID
    and A.EecCoID  = xCOID
    AND Employment_ELTMember is not null

    Update dbo.U_ECRNUSODE_drvTbl  set drvuserid  = SUBSTRING(drvuserid,PATINDEX('%[^0]%',drvuserid),LEN(drvuserid))
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
ALTER VIEW dbo.dsi_vwECRNUSODE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECRNUSODE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECRNUSODE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006101'
       ,expStartPerControl     = '202006101'
       ,expLastEndPerControl   = '202006179'
       ,expEndPerControl       = '202006179'
WHERE expFormatCode = 'ECRNUSODE';

**********************************************************************************/
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECRNUSODE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 06/17/2020
Service Request Number: SR-2016-00012345

Purpose: CornerStone Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECRNUSODE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECRNUSODE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECRNUSODE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECRNUSODE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECRNUSODE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECRNUSODE', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECRNUSODE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECRNUSODE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECRNUSODE';

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
    DELETE FROM dbo.U_ECRNUSODE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECRNUSODE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ECRNUSODE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_AuditFields;
    CREATE TABLE dbo.U_ECRNUSODE_AuditFields (aTableName varchar(30),aFieldName varchar(30));
        INSERT INTO dbo.U_ECRNUSODE_AuditFields VALUES ('EmpComp','EecEmplStatus');    

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECRNUSODE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_Audit;
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
    INTO dbo.U_ECRNUSODE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_ECRNUSODE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ECRNUSODE_Audit ON dbo.U_ECRNUSODE_Audit (audEEID,audKey2);

    

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ECRNUSODE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_PDedHist;
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
    INTO dbo.U_ECRNUSODE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECRNUSODE_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECRNUSODE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_PEarHist;
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
    INTO dbo.U_ECRNUSODE_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    AND PehEarnCode in ('ADMLV','ADPLV','BEREV','CRGVL','DT','FFCRA','HOL','JURY','NYPFL','OT','PARLV','PFML','PTO','REG','RETHR','RETOT','RETRO','SICK','SPRNG','STD1','STD60','STDPR','STDSK','STDVA','VAC','VOL','WKCMP','WNTR')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECRNUSODE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECRNUSODE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECRNUSODE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvUserID = eecempno
        ,drvUsername = SUBSTRING(susUsername,PATINDEX('%[^0]%',susUsername),LEN(susUsername))  
        ,drvActive = CASE WHEN eecemplstatus = 'T' THEN 'FALSE' else  'TRUE' END
        ,drvAbsent = CASE WHEN eecemplstatus = 'L' THEN 'TRUE' else  'FALSE' END
        ,drvAllowReconciliation = 'TRUE'
        ,drvPrefix = ''
        ,drvFirstName = EepNameFirst
        ,drvMiddleName = EepNameMiddle
        ,drvLastName = EepNameLast
        ,drvSuffix = CASE WHEN ISNULL(eepnamesuffix,'') in ('Z','') THEN '' ELSE  eepnamesuffix END
        ,drvEmail = EepAddressEMail
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvMobilePhone = (Select top 1 efoPhoneNumber from  dbo.EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)
        ,drvFax = ''
        ,drvCountryCode = 'US'
        ,drvLine1 = EepAddressLine1
        ,drvLine2 = EepAddressLine2
        ,drvMailStop = ''
        ,drvCity = EepAddressCity
        ,drvStateProvince = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvDivisionId = eecorglvl3
        ,drvLocationId = eeclocation
        ,drvPositionId = EecJobCode
        ,drvCostCenterId = eecorglvl4
        ,drvGradeId = (Select top 1 EjhSalaryGrade from dbo.emphjob  where ejheeid =  xeeid and ejhcoid  =  xcoid order by ejhdatetimecreated desc)
        ,drvLastHireDate = FORMAT(EecDateOfLastHire, 'yyyy-MM-dd') 
        ,drvOrigHirDate = FORMAT(eecdateoforiginalhire, 'yyyy-MM-dd')  
        ,drvRequiredApproval = CASE WHEN dbo.dsi_fnlib_GetSupervisorField_v2('', EM.EecEEID, 'Count')  = '' THEN '0'
                                    WHEN dbo.dsi_fnlib_GetSupervisorField_v2('', EM.EecEEID, 'Count') = 1 THEN '1'
                                    WHEN dbo.dsi_fnlib_GetSupervisorField_v2('', EM.EecEEID, 'Count') = 2 THEN '2'
                                    ELSE '3'    
                                END
        ,drvApproverId = ''
        ,drvManagerId = SUBSTRING(dbo.dsi_fnlib_GetSupervisorField('', EM.EecEEID, 'EmpNo') ,PATINDEX('%[^0]%',dbo.dsi_fnlib_GetSupervisorField('', EM.EecEEID, 'EmpNo') ),LEN(dbo.dsi_fnlib_GetSupervisorField('', EM.EecEEID, 'EmpNo') ))     
         ,drvExecutiveTeamLeader = SUBSTRING(Employment_ELTMember,PATINDEX('%[^0]%',Employment_ELTMember),LEN(Employment_ELTMember))   
        ,drvGender = CASE WHEN EepGender = 'M' THEN 'Male' 
                           WHEN EepGender = 'F' THEN 'Female' 
                           ELSE 'Not Known'
                     END
                        
        ,drvEthnicity = CASE WHEN ISNULL(eepEthnicID,'') in ('Z') THEN '' ELSE eepEthnicID END
        ,drvLanguage = 'en-US'
        ,drvTimeZone = ''
        ,drvCompensationCurrency = 'USD'
        ,drvPreferredName = EepNamePreferred
        ,drvPeopleCultureUserID = 'PCAdmin'
        ,drvActualWagesEarned = CAST(PehCurAmtYTD as varchar(12))
        ,drvCompensationLevelforBonus = EECUDFIELD01
        ,drvEmployeeType = (Select top 1 CodDesc from dbo.Codes WITH (NOLOCK) where CodTable = 'EMPTYPE' and CodCode  = eeceetype)
    INTO dbo.U_ECRNUSODE_drvTbl
    FROM dbo.U_ECRNUSODE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp EM WITH (NOLOCK)
        ON EM.EecEEID = xEEID 
        AND EM.EecCoID = xCoID
         and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ECRNUSODE_Audit where  audEEID = xEEID AND audKey2 = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_ECRNUSODE_PEarHist WITH (NOLOCK)
        ON PehEEID = xeeid
    JOIN dbo.vw_rbsUserFinder on suceeid = xeeid
    LEFT JOIN (select * from dbo.fn_MP_CustomFields_EmpComp_Export (NULL,NULL,NULL,NULL)) as A
    ON A.EecEEID = xEEID
    and A.EecCoID  = xCOID
    AND Employment_ELTMember is not null

    Update dbo.U_ECRNUSODE_drvTbl  set drvuserid  = SUBSTRING(drvuserid,PATINDEX('%[^0]%',drvuserid),LEN(drvuserid))
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
ALTER VIEW dbo.dsi_vwECRNUSODE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECRNUSODE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECRNUSODE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202006101'
       ,expStartPerControl     = '202006101'
       ,expLastEndPerControl   = '202006179'
       ,expEndPerControl       = '202006179'
WHERE expFormatCode = 'ECRNUSODE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECRNUSODE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECRNUSODE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort