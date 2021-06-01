SET NOCOUNT ON;
IF OBJECT_ID('U_ESTNLSTDEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESTNLSTDEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESTNLSTDEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESTNLSTDEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTNLSTDEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTNLSTDEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTNLSTDEX];
GO
IF OBJECT_ID('U_ESTNLSTDEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_Trailer];
GO
IF OBJECT_ID('U_ESTNLSTDEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_PEarHist];
GO
IF OBJECT_ID('U_ESTNLSTDEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_PDedHist];
GO
IF OBJECT_ID('U_ESTNLSTDEX_Header') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_Header];
GO
IF OBJECT_ID('U_ESTNLSTDEX_File') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_File];
GO
IF OBJECT_ID('U_ESTNLSTDEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_EEList];
GO
IF OBJECT_ID('U_ESTNLSTDEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_drvTbl];
GO
IF OBJECT_ID('U_ESTNLSTDEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_DedList];
GO
IF OBJECT_ID('U_ESTNLSTDEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_AuditFields];
GO
IF OBJECT_ID('U_ESTNLSTDEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESTNLSTDEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESTNLSTDEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESTNLSTDEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESTNLSTDEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESTNLSTDEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESTNLSTDEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESTNLSTDEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTNLSTDEX','Standad STD LTD ACC Crit Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','ESTNLSTDEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESTNLSTDEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDR"','1','(''DA''=''T|'')','ESTNLSTDEXZ0','50','H','01','1',NULL,'Header Identifier ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileRunDate"','2','(''UD112''=''T|'')','ESTNLSTDEXZ0','50','H','01','2',NULL,'File Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SI"','3','(''DA''=''T|'')','ESTNLSTDEXZ0','50','H','01','3',NULL,'SFG Company ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"langleyfederalcu"','4','(''DA''=''T|'')','ESTNLSTDEXZ0','50','H','01','4',NULL,'Customer Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"10019742"','5','(''DA''=''T'')','ESTNLSTDEXZ0','50','H','01','5',NULL,'Group ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"10019742"','1','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','1',NULL,'Group ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','2',NULL,'Sub Org Text ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T|'')','ESTNLSTDEXZ0','9','D','10','3',NULL,'Social Security Number ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''T|'')','ESTNLSTDEXZ0','20','D','10','4',NULL,'Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','5',NULL,'Name Prefix ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','ESTNLSTDEXZ0','40','D','10','6',NULL,'First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T|'')','ESTNLSTDEXZ0','40','D','10','7',NULL,'Middle Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T|'')','ESTNLSTDEXZ0','40','D','10','8',NULL,'Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','ESTNLSTDEXZ0','10','D','10','9',NULL,'Name Suffix ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','10',NULL,'Date of Birth ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','11',NULL,'Date of Death ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T|'')','ESTNLSTDEXZ0','1','D','10','12',NULL,'Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','13',NULL,'Marital Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','14','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','14',NULL,'Address Line 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','15','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','15',NULL,'Address Line 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','16',NULL,'Address Line 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','17',NULL,'City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T|'')','ESTNLSTDEXZ0','2','D','10','18',NULL,'State/Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T|'')','ESTNLSTDEXZ0','20','D','10','19',NULL,'Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','20','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','20',NULL,'Country ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonWorkPhone"','21','(''UA''=''T|'')','ESTNLSTDEXZ0','15','D','10','21',NULL,'Non-Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"B"','22','(''DA''=''T|'')','ESTNLSTDEXZ0','3','D','10','22',NULL,'Employee Tobacco ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentHireDate"','23','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','23',NULL,'Current Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','24',NULL,'Original Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','25',NULL,'Adjusted Hire Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','26',NULL,'Benefits Eligibility Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','27',NULL,'Benefits Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','28',NULL,'Loss of Benefits Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentTerminationDate"','29','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','29',NULL,'Employment Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','30','(''UA''=''T|'')','ESTNLSTDEXZ0','26','D','10','30',NULL,'Employment Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatusEffectDate"','31','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','31',NULL,'Employment Status Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','32','(''UA''=''T|'')','ESTNLSTDEXZ0','2','D','10','32',NULL,'Work State ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','33','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','33',NULL,'Job Title ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledWorkHours"','34','(''UA''=''T|'')','ESTNLSTDEXZ0','8','D','10','34',NULL,'Scheduled Work Hours ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Weekly"','35','(''DA''=''T|'')','ESTNLSTDEXZ0','12','D','10','35',NULL,'Scheduled Work Hours Frequency ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayType"','36','(''UA''=''T|'')','ESTNLSTDEXZ0','11','D','10','36',NULL,'Employee Pay Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullPartTime"','37','(''UA''=''T|'')','ESTNLSTDEXZ0','9','D','10','37',NULL,'Full / Part Time ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','38','(''UA''=''T|'')','ESTNLSTDEXZ0','9','D','10','38',NULL,'Employment Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','39','(''UA''=''T|'')','ESTNLSTDEXZ0','100','D','10','39',NULL,'Work Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptStatus"','40','(''UA''=''T|'')','ESTNLSTDEXZ0','10','D','10','40',NULL,'Exempt Status ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','41',NULL,'Union Flag ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','42',NULL,'Union Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAffiliate"','43','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','43',NULL,'Employer Affiliate ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerLocationCode"','44','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','44',NULL,'Employer Location Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerLocationName"','45','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','45',NULL,'Employer Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode"','46','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','46',NULL,'Department Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentName"','47','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','47',NULL,'Department Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','48',NULL,'Occupation Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','49',NULL,'Job Category ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','50',NULL,'Grandfathered Employee ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','51',NULL,'User Specific 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','52',NULL,'User Specific 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','53',NULL,'User Specific 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','54',NULL,'User Specific 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','55',NULL,'User Specific 5 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameFirst"','56','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','56',NULL,'Spouse First Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameLast"','57','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','57',NULL,'Spouse Last Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','58',NULL,'Spouse Date of Birth ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','59',NULL,'Spouse Address Line 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','60',NULL,'Spouse Address Line 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','61',NULL,'Spouse Address Line 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T|'')','ESTNLSTDEXZ0','30','D','10','62',NULL,'Spouse Address City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T|'')','ESTNLSTDEXZ0','2','D','10','63',NULL,'Spouse Address State/Province ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','64',NULL,'Spouse Address Postal Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T|'')','ESTNLSTDEXZ0','15','D','10','65',NULL,'Spouse Non-Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','66',NULL,'Spouse Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseRelToEmpl"','67','(''UA''=''T|'')','ESTNLSTDEXZ0','15','D','10','67',NULL,'Spouse Relationship to Employee ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseGender"','68','(''UA''=''T|'')','ESTNLSTDEXZ0','1','D','10','68',NULL,'Spouse Gender ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseTobacorInd"','69','(''UA''=''T|'')','ESTNLSTDEXZ0','3','D','10','69',NULL,'Spouse Tobacco Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','70',NULL,'Family Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','71',NULL,'Family Indicator Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','72',NULL,'Qualifying Event Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Base Rate"','73','(''DA''=''T|'')','ESTNLSTDEXZ0','18','D','10','73',NULL,'Earnings Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmount"','74','(''UA''=''T|'')','ESTNLSTDEXZ0','13','D','10','74',NULL,'Earnings Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmountExpression"','75','(''UA''=''T|'')','ESTNLSTDEXZ0','22','D','10','75',NULL,'Earnings Amount Expression ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsEffectiveDate"','76','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','76',NULL,'Earnings Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"|||||||||||"','77','(''DA''=''T|'')','ESTNLSTDEXZ0','18','D','10','77',NULL,'Ununsed Earnings Delim Block',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Commission"','78','(''DA''=''T|'')','ESTNLSTDEXZ0','18','D','10','78',NULL,'Earnings Type ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmount2"','79','(''UA''=''T|'')','ESTNLSTDEXZ0','13','D','10','79',NULL,'Earnings Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmountExpression2"','80','(''UA''=''T|'')','ESTNLSTDEXZ0','22','D','10','80',NULL,'Earnings Amount Expression ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPayDate2"','81','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','81',NULL,'Earnings Pay Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''T|'')','ESTNLSTDEXZ0','22','D','10','82',NULL,'Pay Frequency ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayStartDate"','83','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','83',NULL,'Pay Start Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayEndDate"','84','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','84',NULL,'Pay End Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','85',NULL,'Pay Period Hours ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"|||||||||||||||"','86','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','86',NULL,'Unused Actual Earning Delim Block',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkPast12Months"','87','(''UA''=''T|'')','ESTNLSTDEXZ0','8','D','10','87',NULL,'Hours Worked in the Last 12 Months ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorkPast12ThruDate"','88','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','88',NULL,'Hours Worked in the Last 12 Months THRU DATE ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','89',NULL,'Supervisor/Manager Employee ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','90',NULL,'AMS User Defined Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmsReportingGroup1"','91','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','91',NULL,'AMS Reporting Group 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"|||||||"','92','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','92',NULL,'AMS Reporting 2-9 Delim Block',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Team"','93','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','93',NULL,'HR Contact Recipient ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HRteam@langleyFCU.org"','94','(''DA''=''T|'')','ESTNLSTDEXZ0','100','D','10','94',NULL,'HR Contact Email Address ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"7576438743"','95','(''DA''=''T|'')','ESTNLSTDEXZ0','15','D','10','95',NULL,'HR Contact Work Phone ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"||||"','96','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','96',NULL,'Reporting Cat Delim Block',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy0"','97','(''UA''=''T|'')','ESTNLSTDEXZ0','6','D','10','97',NULL,'Policy ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingDivision"','98','(''UA''=''T|'')','ESTNLSTDEXZ0','4','D','10','98',NULL,'Billing Division ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','99','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','99',NULL,'Billing Division Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillingCategory"','100','(''UA''=''T|'')','ESTNLSTDEXZ0','4','D','10','100',NULL,'Billing Category ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','101',NULL,'Billing Category Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','102','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','102',NULL,'Customer Defined Division ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','103',NULL,'Customer Defined Billing Category ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"|||||"','104','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','104',NULL,'State Disab Delim Block',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy1"','105','(''UA''=''T|'')','ESTNLSTDEXZ0','6','D','10','105',NULL,'Policy ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId1"','106','(''UA''=''T|'')','ESTNLSTDEXZ0','2','D','10','106',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductId1"','107','(''UA''=''T|'')','ESTNLSTDEXZ0','4','D','10','107',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','108',NULL,'Schedule ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','109',NULL,'Employer Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''T|'')','ESTNLSTDEXZ0','10','D','10','110',NULL,'AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','111',NULL,'Class Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','112',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','113',NULL,'Benefit Waiting Period ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','114',NULL,'Benefit Percent ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','115',NULL,'Covered Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','116',NULL,'Prior Carrier Takeover Amount ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate1"','117','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','117',NULL,'Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate1"','118','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','118',NULL,'Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','119','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','119',NULL,'Requested Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','120','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','120',NULL,'Requested Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','121','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','121',NULL,'Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','122',NULL,'Requested Amount Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','123',NULL,'Application Date of Requested Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy2"','124','(''UA''=''T|'')','ESTNLSTDEXZ0','6','D','10','124',NULL,'Policy ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId2"','125','(''UA''=''T|'')','ESTNLSTDEXZ0','2','D','10','125',NULL,'Plan ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductId2"','126','(''UA''=''T|'')','ESTNLSTDEXZ0','4','D','10','126',NULL,'Product ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','127','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','127',NULL,'Schedule ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','128','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','128',NULL,'Employer Plan Code ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''T|'')','ESTNLSTDEXZ0','10','D','10','129',NULL,'AM Class ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','130',NULL,'Class Name ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','131',NULL,'User Specific ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','132',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','133',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','134',NULL,'Covered Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','135',NULL,'Prior Carrier Takeover Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate2"','136','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','136',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate2"','137','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','137',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','138',NULL,'Requested Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','139',NULL,'Requested Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','140',NULL,'Requested Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','141',NULL,'Requested Amount Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','142',NULL,'Application Date of Requested Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisablityThreeToSixBlock80"','143','(''UA''=''T|'')','ESTNLSTDEXZ0','80','D','10','143',NULL,'Disability three to six Delim Block',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeCoverageOneToSix108"','144','(''UA''=''T|'')','ESTNLSTDEXZ0','108','D','10','144',NULL,'Life Coverage One to Six Delim',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADDOneToSixDelimBlock108"','145','(''UA''=''T|'')','ESTNLSTDEXZ0','108','D','10','145',NULL,'AD&D one to six Delim Block',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiProductId"','146','(''UA''=''T|'')','ESTNLSTDEXZ0','4','D','10','146',NULL,'Product ID ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','147',NULL,'Application Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiEffectiveDate"','148','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','148',NULL,'Effective Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiTerminationDate"','149','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','149',NULL,'Termination Date ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAiFamilyElectionIndicator"','150','(''UA''=''T|'')','ESTNLSTDEXZ0','50','D','10','150',NULL,'Family Election Indicator ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','151',NULL,'Health Maintenance Screening Benefit ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','152',NULL,'Automobile Accident Benefit ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','153',NULL,'Question 1  ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiProductId"','154','(''UA''=''T|'')','ESTNLSTDEXZ0','4','D','10','154',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','155',NULL,'Employee Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiEmployeeAmtCancer"','156','(''UA''=''T|'')','ESTNLSTDEXZ0','13','D','10','156',NULL,'Employee Amount with Cancer Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''T|'')','ESTNLSTDEXZ0','8','D','10','157',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiEmployeeEffectiveDate"','158','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','158',NULL,'Employee Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiEmployeeTerminationDate"','159','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','159',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','160','(''DA''=''T|'')','ESTNLSTDEXZ0','13','D','10','160',NULL,'Spouse Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiSpouseAmtCancer"','161','(''UA''=''T|'')','ESTNLSTDEXZ0','13','D','10','161',NULL,'Spouse Amount with Cancer Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','162',NULL,'Spouse Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''DA''=''T|'')','ESTNLSTDEXZ0','20','D','10','163',NULL,'Spouse Percent with Cancer Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','164','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','164',NULL,'Spouse Gainfully Employed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiSpouseEffectiveDate"','165','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','165',NULL,'Spouse Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCiSpouseTerminationDate"','166','(''UD112''=''T|'')','ESTNLSTDEXZ0','8','D','10','166',NULL,'Spouse Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','167','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','167',NULL,'Health Maintenance Screening Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','168','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','168',NULL,'All questions answered favorably for employee bene',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','169','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','169',NULL,'All questions answered favorably for spouse benefi',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''DA''=''T|'')','ESTNLSTDEXZ0','1','D','10','170',NULL,'Question 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','171','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','171',NULL,'Question 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','172','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','172',NULL,'Question 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','173','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','173',NULL,'Question 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','174','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','174',NULL,'Question 5 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','175','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','175',NULL,'Question 6 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','176','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','176',NULL,'Question 7 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','177',NULL,'Question 8 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','178',NULL,'Question 9 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','179',NULL,'Question 10 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','180','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','180',NULL,'Question 11 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','181','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','181',NULL,'Question 12 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','182',NULL,'Question 13 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','183',NULL,'Question 14 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','184',NULL,'Spouse Question 1 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','185',NULL,'Spouse Question 2 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','186',NULL,'Spouse Question 3 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','187',NULL,'Spouse Question 4 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','188',NULL,'Spouse Question 5 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','189',NULL,'Spouse Question 6 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','190','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','190',NULL,'Spouse Question 7 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','191','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','191',NULL,'Spouse Question 8 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','192','(''DA''=''T|'')','ESTNLSTDEXZ0','50','D','10','192',NULL,'Spouse Question 9 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','193','(''DA''=''T'')','ESTNLSTDEXZ0','50','D','10','193',NULL,'Spouse Question 10 ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TLR"','1','(''DA''=''T|'')','ESTNLSTDEXZ0','50','T','90','1',NULL,'Trailer Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T'')','ESTNLSTDEXZ0','50','T','90','2',NULL,'RecordCount',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESTNLSTDEX_20210520.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202104169','EMPEXPORT','OEACTIVE',NULL,'ESTNLSTDEX',NULL,NULL,NULL,'202104169','Apr 16 2021  5:15PM','Apr 16 2021  5:15PM','202104161',NULL,'','','202104161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202104169','EMPEXPORT','OEPASSIVE',NULL,'ESTNLSTDEX',NULL,NULL,NULL,'202104169','Apr 16 2021  5:15PM','Apr 16 2021  5:15PM','202104161',NULL,'','','202104161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Standad STD LTD ACC Crit Ex','202104169','EMPEXPORT','ONDEM_XOE',NULL,'ESTNLSTDEX',NULL,NULL,NULL,'202104169','Apr 16 2021  5:15PM','Apr 16 2021  5:15PM','202104161',NULL,'','','202104161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Standad STD LTD ACC Crit-Sched','202104169','EMPEXPORT','SCH_ESTNLS',NULL,'ESTNLSTDEX',NULL,NULL,NULL,'202104169','Apr 16 2021  5:15PM','Apr 16 2021  5:15PM','202104161',NULL,'','','202104161',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Standad STD LTD ACC Crit-Test','202105191','EMPEXPORT','TEST_XOE','May 19 2021  2:52PM','ESTNLSTDEX',NULL,NULL,NULL,'202105191','May 19 2021 12:00AM','Dec 30 1899 12:00AM','202105191','588','','','202105191',dbo.fn_GetTimedKey(),NULL,'us3cPeLAN1016',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTNLSTDEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTNLSTDEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTNLSTDEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTNLSTDEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTNLSTDEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESTNLSTDEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESTNLSTDEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESTNLSTDEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTNLSTDEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTNLSTDEX','H01','dbo.U_ESTNLSTDEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTNLSTDEX','D10','dbo.U_ESTNLSTDEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTNLSTDEX','T90','dbo.U_ESTNLSTDEX_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ESTNLSTDEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESTNLSTDEX] (
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
IF OBJECT_ID('U_ESTNLSTDEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_Audit] (
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
IF OBJECT_ID('U_ESTNLSTDEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ESTNLSTDEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESTNLSTDEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(5) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvAddressLine1] varchar(8000) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] varchar(45) NULL,
    [drvNonWorkPhone] varchar(50) NULL,
    [drvCurrentHireDate] datetime NULL,
    [drvEmploymentTerminationDate] datetime NULL,
    [drvEmploymentStatus] varchar(16) NULL,
    [drvEmploymentStatusEffectDate] datetime NULL,
    [drvWorkState] varchar(255) NULL,
    [drvJobTitle] varchar(8000) NULL,
    [drvScheduledWorkHours] nvarchar(4000) NULL,
    [drvEmployeePayType] varchar(6) NULL,
    [drvFullPartTime] varchar(9) NULL,
    [drvEmploymentType] varchar(9) NOT NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvExemptStatus] varchar(10) NOT NULL,
    [drvEmployeeAffiliate] varchar(40) NULL,
    [drvEmployerLocationCode] char(6) NULL,
    [drvEmployerLocationName] varchar(25) NULL,
    [drvDepartmentCode] varchar(10) NULL,
    [drvDepartmentName] varchar(25) NULL,
    [drvSpouseNameFirst] varchar(100) NULL,
    [drvSpouseNameLast] varchar(100) NULL,
    [drvSpouseRelToEmpl] varchar(6) NULL,
    [drvSpouseGender] varchar(1) NULL,
    [drvSpouseTobacorInd] varchar(1) NULL,
    [drvEarningsAmount] nvarchar(4000) NULL,
    [drvEarningsAmountExpression] varchar(9) NOT NULL,
    [drvEarningsEffectiveDate] datetime NULL,
    [drvEarningsAmount2] nvarchar(4000) NULL,
    [drvEarningsAmountExpression2] varchar(9) NOT NULL,
    [drvEarningsPayDate2] datetime NULL,
    [drvPayStartDate] datetime NULL,
    [drvPayEndDate] datetime NULL,
    [drvHoursWorkPast12Months] nvarchar(4000) NULL,
    [drvHoursWorkPast12ThruDate] datetime NULL,
    [drvAmsReportingGroup1] varchar(1) NOT NULL,
    [drvPolicy0] varchar(6) NULL,
    [drvBillingDivision] varchar(4) NULL,
    [drvBillingCategory] varchar(4) NULL,
    [drvPolicy1] varchar(6) NULL,
    [drvPlanId1] varchar(1) NULL,
    [drvProductId1] varchar(2) NULL,
    [drvEffectiveDate1] datetime NULL,
    [drvTerminationDate1] datetime NULL,
    [drvPolicy2] varchar(6) NULL,
    [drvPlanId2] varchar(1) NULL,
    [drvProductId2] varchar(2) NULL,
    [drvEffectiveDate2] datetime NULL,
    [drvTerminationDate2] datetime NULL,
    [drvDisablityThreeToSixBlock80] varchar(80) NULL,
    [drvLifeCoverageOneToSix108] varchar(101) NULL,
    [drvADDOneToSixDelimBlock108] varchar(108) NULL,
    [drvAiProductId] varchar(2) NULL,
    [drvAiEffectiveDate] datetime NULL,
    [drvAiTerminationDate] datetime NULL,
    [drvAiFamilyElectionIndicator] varchar(1) NULL,
    [drvCiProductId] varchar(2) NULL,
    [drvCiEmployeeAmtCancer] nvarchar(4000) NULL,
    [drvCiEmployeeEffectiveDate] datetime NULL,
    [drvCiEmployeeTerminationDate] datetime NULL,
    [drvCiSpouseAmtCancer] money NULL,
    [drvCiSpouseEffectiveDate] datetime NULL,
    [drvCiSpouseTerminationDate] datetime NULL
);
IF OBJECT_ID('U_ESTNLSTDEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESTNLSTDEX_File') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ESTNLSTDEX_Header') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_Header] (
    [drvFileRunDate] datetime NOT NULL
);
IF OBJECT_ID('U_ESTNLSTDEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_PDedHist] (
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
IF OBJECT_ID('U_ESTNLSTDEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmtEA2] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_ESTNLSTDEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_ESTNLSTDEX_Trailer] (
    [drvRecordCount] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTNLSTDEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Langley Federal Credit Union

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 04/16/2021
Service Request Number: TekP-2020-12-02-0002

Purpose: Standad STD LTD ACC Crit Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTNLSTDEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTNLSTDEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTNLSTDEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTNLSTDEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTNLSTDEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTNLSTDEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTNLSTDEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTNLSTDEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTNLSTDEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTNLSTDEX', 'SCH_ESTNLS';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTNLSTDEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESTNLSTDEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTNLSTDEX';

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
    DELETE FROM dbo.U_ESTNLSTDEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTNLSTDEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_ESTNLSTDEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLTDE,GLTD,GSTDE,GSTD,ACC,CIC10,CIC5,CIS10,CIS5,CIE10,CIE5,CIF10,CIF5,CHSA5';

    IF OBJECT_ID('U_ESTNLSTDEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTNLSTDEX_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime', DATEADD(DAY, -30, @StartDate));
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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESTNLSTDEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_AuditFields;
    CREATE TABLE dbo.U_ESTNLSTDEX_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_ESTNLSTDEX_AuditFields VALUES ('EmpComp','EecEmplStatus');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESTNLSTDEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_Audit;
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
        --,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
    INTO dbo.U_ESTNLSTDEX_Audit
    FROM dbo.U_ESTNLSTDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_ESTNLSTDEX_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN DATEADD(DAY, -30, @StartDate) AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> ''
    AND audNewValue = 'T';

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESTNLSTDEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_PDedHist;
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
    INTO dbo.U_ESTNLSTDEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESTNLSTDEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESTNLSTDEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        ,PrgPeriodStartDate             = MAX(PrgPeriodStartDate)
        ,PrgPeriodEndDate             = MAX(PrgPeriodEndDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtEA2            = SUM(CASE WHEN PehPerControl >= @StartPerControl AND PehEarnCode IN ('COLL','COM','DEAL','FUNLI','MORT','INVES') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(CASE WHEN PehEarnCode IN ('REG','OVT') THEN PehCurHrs ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ESTNLSTDEX_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE CAST(LEFT(PehPerControl, 8) AS DATE) BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================

    DECLARE @CHSA5 MONEY -- VARCHAR(20)
        ,@CIS10 MONEY --VARCHAR(20)
        ,@CIS5 MONEY --VARCHAR(20)
        ,@CIC10 MONEY --VARCHAR(20)
        ,@CIC5 MONEY --VARCHAR(20)
        ,@CIE10 MONEY --VARCHAR(20)
        ,@CIE5 MONEY --VARCHAR(20)
        ,@CIF10 MONEY --VARCHAR(20)
        ,@CIF5 MONEY --VARCHAR(20);


        --select DedDedCode, DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5','CHSA5')


    SELECT @CHSA5 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CHSA5')
    SELECT @CIS10 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIS10')
    SELECT @CIS5 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIS5')
    SELECT @CIC10 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIC10')
    SELECT @CIC5 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIC5')
    SELECT @CIE10 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIE10')
    SELECT @CIE5 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIE5')
    SELECT @CIF10 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIF10')
    SELECT @CIF5 = DedBenAmtMax FROM DedCode WITH (NOLOCK) WHERE DedDedCode IN ('CIF5')

    ---------------------------------
    -- DETAIL RECORD - U_ESTNLSTDEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTNLSTDEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ISNULL(GL_DedCode, '')
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = EepNameMiddle
        ,drvNameLast = EepNameLast
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender ELSE 'U' END
        ,drvAddressLine1 = REPLACE(EepAddressLine1, ',', '')
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = CodDesc
        ,drvNonWorkPhone = CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber ELSE efoPhoneNumber END -- EecPhoneBusinessNumber
        ,drvCurrentHireDate = EecDateOfLastHire
        ,drvEmploymentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmploymentStatus =    CASE WHEN EecEmplStatus = 'A' THEN 'Active'
                                    WHEN EecEmplStatus = 'L' THEN 'Leave of Absence'
                                    WHEN EecEmplStatus IN ('T','O','R') THEN 'Terminated'
                                END
        ,drvEmploymentStatusEffectDate =    CASE WHEN EecEmplStatus = 'A' THEN EecDateOfLastHire
                                                WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                                WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                            END
        ,drvWorkState = LocAddressState
        ,drvJobTitle = REPLACE(JbcDesc, ',', '')
        ,drvScheduledWorkHours = FORMAT(EecScheduledWorkHrs/2, '#0.00')
        ,drvEmployeePayType =    CASE WHEN EecSalaryOrHourly = 'H' THEN 'Hourly'
                                    WHEN EecSalaryOrHourly = 'S' THEN 'Salary'
                                END
        ,drvFullPartTime =    CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Full Time'
                                WHEN EecFullTimeOrPartTime = 'P' THEN 'Part Time'
                            END
        ,drvEmploymentType = CASE WHEN EecEmplStatus = 'TMP' THEN 'Temporary' ELSE 'Regular' END
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvExemptStatus = CASE WHEN EjhFLSACategory IN ('E','Z') THEN 'Exempt' ELSE 'Non-Exempt' END
        ,drvEmployeeAffiliate = CmpCompanyName
        ,drvEmployerLocationCode = EecLocation
        ,drvEmployerLocationName = LocDesc
        ,drvDepartmentCode = EecOrgLvl2
        ,drvDepartmentName = OrgDesc
        ,drvSpouseNameFirst = ConNameFirst
        ,drvSpouseNameLast = ConNameLast
        ,drvSpouseRelToEmpl = CASE WHEN ConRelationship = 'SPS' THEN 'Spouse' END
        ,drvSpouseGender =    CASE WHEN ConGender IS NULL THEN NULL
                                WHEN ConGender IN ('M','F') THEN ConGender 
                                ELSE 'U' 
                            END
        ,drvSpouseTobacorInd = CASE WHEN ConRelationship = 'SPS' THEN 'B' END
        ,drvEarningsAmount =    FORMAT(CASE WheN EecSalaryOrHourly = 'S' THEN EecAnnSalary
                                    WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate
                                END, '#.##') -- '0000000000.00')
        ,drvEarningsAmountExpression = 'Bi-Weekly' /*    CASE WHEN EecSalaryOrHourly = 'S' THEN 'Annual'
                                            WHEN EecSalaryOrHourly = 'H' THEN 'Hourly'
                                        END*/
        ,drvEarningsEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xEEID, xCOID, '1/1/2021', EecDateOfLastHire)
        ,drvEarningsAmount2 = FORMAT(PehCurAmtEA2, '#.##') -- '0000000000.00')
        ,drvEarningsAmountExpression2 = 'Bi-Weekly' /*CASE WHEN EecSalaryOrHourly = 'S' THEN 'Annual'
                                            WHEN EecSalaryOrHourly = 'H' THEN 'Hourly'
                                        END*/
        ,drvEarningsPayDate2 = PrgPayDate
        ,drvPayStartDate = PrgPeriodStartDate
        ,drvPayEndDate = PrgPeriodEndDate
        ,drvHoursWorkPast12Months = FORMAT(PehCurHrsYTD, '#.##') --'00000.00')
        ,drvHoursWorkPast12ThruDate = PrgPayDate
        ,drvAmsReportingGroup1 = CASE WHEN EecUDField05 = 'Yes' THEN 'Y' ELSE 'N' END
        ,drvPolicy0 = CASE WHEN O_DedCode IS NOT NULL THEN '168393' END
                        --CASE WHEN GL_DedCode IS NOT NULL THEN '168393' END
        ,drvBillingDivision = CASE WHEN O_DedCode IS NOT NULL THEN '0001' END
        ,drvBillingCategory = CASE WHEN O_DedCode IS NOT NULL THEN '0100' END
        ,drvPolicy1 = CASE WHEN GS_DedCode IS NOT NULL AND (GS_StopDate  IS NULL OR GS_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN '760060' END
        ,drvPlanId1 = CASE WHEN GS_DedCode IS NOT NULL AND (GS_StopDate  IS NULL OR GS_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN 'A' END
        ,drvProductId1 = CASE WHEN GS_DedCode IS NOT NULL AND (GS_StopDate  IS NULL OR GS_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN 'ST' END
        ,drvEffectiveDate1 = CASE WHEN GS_DedCode IS NOT NULL AND (GS_StopDate  IS NULL OR GS_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN GS_StartDate END
        ,drvTerminationDate1 = CASE WHEN GS_DedCode IS NOT NULL AND (GS_StopDate  IS NULL OR GS_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN GS_StopDate  END
        ,drvPolicy2 = CASE WHEN GL_DedCode IS NOT NULL AND (GL_StopDate  IS NULL OR GL_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN '168393' END
        ,drvPlanId2 = CASE WHEN GL_DedCode IS NOT NULL AND (GL_StopDate  IS NULL OR GL_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN 'B' END
        ,drvProductId2 = CASE WHEN GL_DedCode IS NOT NULL AND (GL_StopDate  IS NULL OR GL_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN 'LT' END
        ,drvEffectiveDate2 = CASE WHEN GL_DedCode IS NOT NULL AND (GL_StopDate  IS NULL OR GL_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN GL_StartDate END
        ,drvTerminationDate2 = CASE WHEN GL_DedCode IS NOT NULL AND (GL_StopDate  IS NULL OR GL_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN GL_StopDate  END
        ,drvDisablityThreeToSixBlock80 = REPLICATE('|', 80)
        ,drvLifeCoverageOneToSix108 = REPLICATE('|', 101)
        ,drvADDOneToSixDelimBlock108 = REPLICATE('|', 108)
        ,drvAiProductId = CASE WHEN ACC_DedCode IS NOT NULL AND (ACC_StopDate  IS NULL OR ACC_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN  'AI' END
        ,drvAiEffectiveDate = CASE WHEN ACC_DedCode IS NOT NULL AND (ACC_StopDate  IS NULL OR ACC_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN  ACC_StartDate END
        ,drvAiTerminationDate = CASE WHEN ACC_DedCode IS NOT NULL AND (ACC_StopDate  IS NULL OR ACC_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN  ACC_StopDate END
        ,drvAiFamilyElectionIndicator =    CASE WHEN ACC_DedCode IS NOT NULL AND (ACC_StopDate  IS NULL OR ACC_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN  
                                            CASE WHEN ACC_BenOption IN ('EEF','EEDEP') THEN 'A'
                                                WHEN ACC_BenOption IN ('EES') THEN 'B'
                                                WHEN ACC_BenOption IN ('EE') THEN 'C'
                                                WHEN ACC_BenOption IN ('EEC','EECC','EC') THEN 'D'
                                            END
                                        END
        ,drvCiProductId = CASE WHEN CI_DedCode IS NOT NULL AND (CI_StopDate  IS NULL OR CI_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN 'CI' END
        ,drvCiEmployeeAmtCancer =    CASE WHEN CI_DedCode IS NOT NULL AND (CI_StopDate  IS NULL OR CI_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN
                                        FORMAT(CASE WHEN CHS_DedCode IS NOT NULL THEN @CHSA5 ELSE 0.00 END +
                                          CASE  WHEN CIC10_DedCode IS NOT NULL THEN @CIC10
                                            WHEN CIC5_DedCode IS NOT NULL THEN @CIC5 
                                            WHEN CIS10_DedCode IS NOT NULL THEN @CIS10
                                            WHEN CIS5_DedCode IS NOT NULL THEN @CIS5 
                                            WHEN CIE10_DedCode IS NOT NULL THEN @CIE10
                                            WHEN CIE5_DedCode IS NOT NULL THEN @CIE5
                                            WHEN CIF10_DedCode IS NOT NULL THEN @CIF10 
                                            WHEN CIF5_DedCode IS NOT NULL THEN @CIF5
                                            ELSE 0.00
                                        END, '#0.00')
                                    END
        ,drvCiEmployeeEffectiveDate =    CASE WHEN CI2_DedCode IS NOT NULL AND (CI2_StopDate  IS NULL OR CI2_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN CI2_StartDate 
                                            WHEN CHS_DedCode IS NOT NULL THEN CHSA5_StartDate
                                        END
        ,drvCiEmployeeTerminationDate =    CASE WHEN CI2_DedCode IS NOT NULL AND (CI2_StopDate  IS NULL OR CI2_StopDate  >= DATEADD(DAY, -30, @EndDate)) THEN CI2_StopDate 
                                            WHEN CHS_DedCode IS NOT NULL THEN CHSA5_StopDate
                                        END
        ,drvCiSpouseAmtCancer =    CASE WHEN CIS10_DedCode IS NOT NULL THEN @CIS10
                                    WHEN CIS5_DedCode IS NOT NULL THEN @CIS5
                                END
        ,drvCiSpouseEffectiveDate = CASE WHEN CI_SpouseDedCode IS NOT NULL AND (CI_SpouseStopDate  IS NULL OR CI_SpouseStopDate  >= DATEADD(DAY, -30, @EndDate)) THEN CI_SpouseStartDate END
        ,drvCiSpouseTerminationDate = CASE WHEN CI_SpouseDedCode IS NOT NULL AND (CI_SpouseStopDate  IS NULL OR CI_SpouseStopDate  >= DATEADD(DAY, -30, @EndDate)) THEN CI_SpouseStopDate END
    INTO dbo.U_ESTNLSTDEX_drvTbl
    FROM dbo.U_ESTNLSTDEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    --LEFT JOIN dbo.U_dsi_BDM_ESTNLSTDEX WITH (NOLOCK)
    LEFT JOIN (
                SELECT BdmEEID, BdmCOID
                    ,MAX(CASE WHEN BdmDedCode IN ('ACC','CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5','CHSA5') THEN BdmDedCode END) AS O_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('GSTDE','GSTD') THEN BdmDedCode END) AS GS_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('GSTDE','GSTD') THEN BdmBenStartDate END) AS GS_StartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('GSTDE','GSTD') THEN BdmBenStopDate  END) AS GS_StopDate    
                    ,MAX(CASE WHEN BdmDedCode IN ('GLTDE','GLTD') THEN BdmDedCode END) AS GL_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('GLTDE','GLTD') THEN BdmBenStartDate END) AS GL_StartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('GLTDE','GLTD') THEN BdmBenStopDate END) AS GL_StopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('ACC') THEN BdmDedCode END) AS ACC_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('ACC') THEN BdmBenOption END) AS ACC_BenOption
                    ,MAX(CASE WHEN BdmDedCode IN ('ACC') THEN BdmBenStartDate END) AS ACC_StartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('ACC') THEN BdmBenStopDate END) AS ACC_StopDate

                    ,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5','CHSA5') THEN BdmDedCode END) AS CI_DedCode
                    --,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5','CHSA5') THEN BdmBenOption END) AS ACC_BenOption
                    ,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5','CHSA5') AND BdmRecType = 'EMP' THEN BdmBenStartDate END) AS CI_StartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5','CHSA5') THEN BdmBenStopDate END) AS CI_StopDate


                    ,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5') THEN BdmDedCode END) AS CI2_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5') AND BdmRecType = 'EMP' THEN BdmBenStartDate END) AS CI2_StartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('CHSA5') AND BdmRecType = 'EMP' THEN BdmBenStartDate END) AS CHSA5_StartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5') THEN BdmBenStopDate END) AS CI2_StopDate
                    ,MAX(CASE WHEN BdmDedCode IN ('CHSA5') THEN BdmBenStopDate END) AS CHSA5_StopDate



                    ,MAX(CASE WHEN BdmDedCode IN ('CIS10','CIS5') THEN BdmDedCode END) AS CI_SpouseDedCode
                    --,MAX(CASE WHEN BdmDedCode IN ('CIC10','CIC5','CIS10','CIS5','CIE10','CIE5','CIF10','CIF5','CHSA5') THEN BdmBenOption END) AS ACC_BenOption
                    ,MAX(CASE WHEN BdmDedCode IN ('CIS10','CIS5') AND BdmRelationship IN ('SPS') THEN BdmBenStartDate END) AS CI_SpouseStartDate
                    ,MAX(CASE WHEN BdmDedCode IN ('CIS10','CIS5') AND BdmRelationship IN ('SPS') THEN BdmBenStopDate END) AS CI_SpouseStopDate

                    ,MAX(CASE WHEN BdmDedCode IN ('CHSA5') THEN BdmDedCode END) AS CHS_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIS10') THEN BdmDedCode END) AS CIS10_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIS5') THEN BdmDedCode END) AS CIS5_DedCode


                    ,MAX(CASE WHEN BdmDedCode IN ('CIC10') THEN BdmDedCode END) AS CIC10_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIC5') THEN BdmDedCode END) AS CIC5_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIE10') THEN BdmDedCode END) AS CIE10_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIE5') THEN BdmDedCode END) AS CIE5_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIF10') THEN BdmDedCode END) AS CIF10_DedCode
                    ,MAX(CASE WHEN BdmDedCode IN ('CIF5') THEN BdmDedCode END) AS CIF5_DedCode
                    

                FROM dbo.U_dsi_BDM_ESTNLSTDEX WITH (NOLOCK) 
                WHERE BdmBenStatus = 'A'
                GROUP BY BdmEEID, BdmCOID) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN (
            select CodCode, CodDesc from dbo.Codes WITH (NOLOCK) WHERE CodTable = 'COUNTRY') AS Country
        ON CodCode = EepAddressCountry
    LEFT JOIN dbo.EmpMPhon
        ON EfoEEID = xEEID
        AND efoPhoneType = 'CEL'
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN (            
            SELECT EjhEEID, EjhCOID, EjhFLSACategory
            FROM (
                    SELECT EjhEEID, EjhCOID, EjhFLSACategory, EjhJobEffDate, ROW_NUMBER() OVER (PARTITION BY EjhEEID, EjhCOID ORDER BY EjhJobEffDate DESC) AS RN
                    FROM dbo.EmpHJob WITH (NOLOCK)
                ) AS X
            WHERE RN = 1) AS EJH
        ON EjhEEID = xEEID
        AND EjhCoID    = xCOID
    JOIN dbo.Company WITH (NOLOCK)
        ON xCOID = CmpCoID
    JOIN dbo.OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl2
        AND OrgLvl = 2
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConRelationship = 'SPS'
        AND ConIsDependent = 'Y'
    JOIN dbo.U_ESTNLSTDEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    LEFT JOIN dbo.U_ESTNLSTDEX_Audit
        ON audEEID = xEEID
        AND audKey2 = xCOID
    /*LEFT JOIN (
                SELECT DedDedCode, DedBenAmtMax
                FROM DedCode WITH (NOLOCK)
                WHERE DedDedCode IN ('CHSA5','CIS10','CIS5')) AS CI_Amts
        ON DedDedCode = BdmDedcode*/
    WHERE EecEmplStatus <> 'T' OR audNewValue IS NOT NULL
    ;

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    DECLARE @CurrentDate VARCHAR(8)
        ,@CurrentTime VARCHAR(6);

    SELECT @CurrentDate = GETDATE();
    SELECT @CurrentTime = FORMAT(GETDATE(), 'HHmmss');

    IF OBJECT_ID('U_ESTNLSTDEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_Header;
    SELECT DISTINCT
         drvFileRunDate = GETDATE()
    INTO dbo.U_ESTNLSTDEX_Header

    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESTNLSTDEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ESTNLSTDEX_Trailer;
    SELECT DISTINCT
         drvRecordCount = (SELECT COUNT(*) FROM dbo.U_ESTNLSTDEX_drvTbl WITH (NOLOCK))
    INTO dbo.U_ESTNLSTDEX_Trailer
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
ALTER VIEW dbo.dsi_vwESTNLSTDEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTNLSTDEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTNLSTDEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202104091'
       ,expStartPerControl     = '202104091'
       ,expLastEndPerControl   = '202104169'
       ,expEndPerControl       = '202104169'
WHERE expFormatCode = 'ESTNLSTDEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTNLSTDEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTNLSTDEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort