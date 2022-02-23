SET NOCOUNT ON;
IF OBJECT_ID('U_ESTANTAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESTANTAEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESTANTAEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESTANTAEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTANTAEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTANTAEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANTAEXP];
GO
IF OBJECT_ID('U_ESTANTAEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_Trailer];
GO
IF OBJECT_ID('U_ESTANTAEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_PEarHist];
GO
IF OBJECT_ID('U_ESTANTAEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_PDedHist];
GO
IF OBJECT_ID('U_ESTANTAEXP_header') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_header];
GO
IF OBJECT_ID('U_ESTANTAEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_File];
GO
IF OBJECT_ID('U_ESTANTAEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_EEList];
GO
IF OBJECT_ID('U_ESTANTAEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_drvTbl];
GO
IF OBJECT_ID('U_ESTANTAEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_DedList];
GO
IF OBJECT_ID('U_ESTANTAEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_AuditFields];
GO
IF OBJECT_ID('U_ESTANTAEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ESTANTAEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESTANTAEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESTANTAEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESTANTAEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESTANTAEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESTANTAEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESTANTAEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTANTAEXP','Standard File Export(EXP)','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','25000','S','N','ESTANTAEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESTANTAEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupIdDetail"','1','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','1',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','3',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','4','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','5',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','7',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','9',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofDeath"','11','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','11',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','13','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','13',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','14','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','14',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','15','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','15',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','16',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','17','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','18','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','18',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','19','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','19',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','20','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','21','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','21',NULL,'Non-Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','22','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','23',NULL,'Current Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOriginalHire"','23','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','24',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','25',NULL,'Adjusted Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','25','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','29',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','26','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','32',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','27','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','33',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','28','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','33',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduleWorkHours"','29','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','34',NULL,'Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkFrequencey"','30','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','35',NULL,'Scheduled Work Hours Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPayType"','31','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','36',NULL,'Employee Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTimePartTime"','32','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','37',NULL,'Full / Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','33','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','38',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmaillAddress"','34','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','39',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptStatus"','35','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','40',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionFlag"','36','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','41',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','42',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""drvAffiliateName','38','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','43',NULL,'Employer Affiliate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','39','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','44',NULL,'Employer Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationDesc"','40','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','45',NULL,'Employer Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeptCode"','41','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','46',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeptName"','42','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','47',NULL,'Department Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','48',NULL,'Occupation Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','51',NULL,'User Specific 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','52',NULL,'User Specific 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','53',NULL,'User Specific 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','54',NULL,'User Specific 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','55',NULL,'User Specific 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEearningCat1"','49','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','73',NULL,'Earnings Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEearningType1"','50','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','73',NULL,'Earnings Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmount1"','51','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','74',NULL,'Earnings Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmtExp1"','52','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','75',NULL,'Earnings Amount Expression',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningEffDate1"','53','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','76',NULL,'Earnings Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFreq1"','54','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','93',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayStartDate1"','55','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','94',NULL,'Pay Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayEndDate1"','56','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','95',NULL,'Pay End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriosHrs1"','57','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','96',NULL,'Pay Period Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEearningCat2"','58','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','73',NULL,'Earnings Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEearningType2"','59','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','73',NULL,'Earnings Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmount2"','60','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','74',NULL,'Earnings Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmtExp2"','61','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','75',NULL,'Earnings Amount Expression',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningEffDate2"','62','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','76',NULL,'Earnings Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFreq2"','63','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','93',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayStartDate2"','64','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','94',NULL,'Pay Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayEndDate2"','65','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','95',NULL,'Pay End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriosHrs2"','66','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','96',NULL,'Pay Period Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEearningCat3"','67','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','73',NULL,'Earnings Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEearningType3"','68','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','73',NULL,'Earnings Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmount3"','69','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','74',NULL,'Earnings Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningAmtExp3"','70','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','75',NULL,'Earnings Amount Expression',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningEffDate3"','71','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','76',NULL,'Earnings Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFreq3"','72','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','93',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayStartDate3"','73','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','94',NULL,'Pay Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayEndDate3"','74','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','95',NULL,'Pay End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriosHrs3"','75','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','96',NULL,'Pay Period Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked12Months"','76','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','113',NULL,'Hours Worked in the Last 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayDate"','77','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','114',NULL,'Hours Worked in the Last 12 Months thru Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorId"','78','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','115',NULL,'Supervisor/Manager Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','116',NULL,'AMS User Defined Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','117',NULL,'AMS Reporting Group 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','118',NULL,'AMS Reporting Group 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','119',NULL,'AMS Reporting Group 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','120',NULL,'AMS Reporting Group 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','121',NULL,'AMS Reporting Group 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','122',NULL,'AMS Reporting Group 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','123',NULL,'AMS Reporting Group 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','124',NULL,'AMS Reporting Group 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','125',NULL,'AMS Reporting Group 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','126',NULL,'HR Contact Recipient',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hrpay@tacenergy.com"','90','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','127',NULL,'HR Contact Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','128',NULL,'HR Contact Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','129',NULL,'Reporting Category 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','130',NULL,'Reporting Category 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','131',NULL,'Reporting Category 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','132',NULL,'Reporting Category 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','133',NULL,'Reporting Category 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilityCoverage1"','97','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','147',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisPlanId1"','98','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','148',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisProductId1"','99','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','149',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisPlanCode1"','100','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','151',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisWaitingPeriod1"','101','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','155',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisBenPercent1"','102','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','156',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisSelectedAmt1"','103','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','157',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisAMClass1"','104','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisClassName1"','105','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','172',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisEffectiveDate1"','106','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','178',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisTerminationDate1"','107','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','179',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','147',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','148',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','149',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','151',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','155',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','156',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','157',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','172',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','178',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','179',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDCoverage1"','119','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','147',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtdPlanId1"','120','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','148',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDProductId1"','121','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','149',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDPlanCode1"','122','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','151',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDWaitingPeriod1"','123','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','155',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDBenPercent1"','124','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','156',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDSelectedAmt1"','125','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','157',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDAMClass1"','126','(''UA''=''T|'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffectiveDate1"','127','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','178',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDTerminationDate1"','128','(''UD112''=''T|'')','ESTANTAEXPZ0','50','D','10','179',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','147',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','148',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','149',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','151',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','155',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','156',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','157',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','178',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','179',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','147',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','148',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','149',NULL,'Product ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','151',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','155',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','156',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','157',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','178',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','179',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','147',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','148',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','151',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','155',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','156',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','157',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''DA''=''T|'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''DA''=''T'')','ESTANTAEXPZ0','50','D','10','171',NULL,'AM Class Name',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESTANTAEXP_20210121.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','201911219','EMPEXPORT','OEACTIVE','Jan  9 2020  6:56PM','ESTANTAEXP',NULL,NULL,NULL,'201911219','Nov 21 2019  5:10PM','Nov 21 2019  5:10PM','201911211','6','','','201911211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201911219','EMPEXPORT','OEPASSIVE',NULL,'ESTANTAEXP',NULL,NULL,NULL,'201911219','Nov 21 2019  5:10PM','Nov 21 2019  5:10PM','201911211',NULL,'','','201911211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Standard File Export','201911219','EMPEXPORT','ONDEMAND',NULL,'ESTANTAEXP',NULL,NULL,NULL,'201911219','Nov 21 2019  5:10PM','Nov 21 2019  5:10PM','201911211',NULL,'','','201911211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'',NULL,NULL,NULL,'Sunday 5:00 pm','201911219','EMPEXPORT','SCH_STAEX',NULL,'ESTANTAEXP',NULL,NULL,NULL,'202005179','Nov 21 2019  5:10PM','Nov 21 2019  5:10PM','202005101',NULL,'','','201911211',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202101219','EMPEXPORT','TEST','Jan 21 2021  2:04PM','ESTANTAEXP',NULL,NULL,NULL,'202101219','Jan 21 2021 12:00AM','Dec 30 1899 12:00AM','202101071','894','','','202101071',dbo.fn_GetTimedKey(),NULL,'us3lKiTRU1009',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANTAEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANTAEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANTAEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANTAEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANTAEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESTANTAEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESTANTAEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESTANTAEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTANTAEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTANTAEXP','D10','dbo.U_ESTANTAEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESTANTAEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESTANTAEXP] (
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
IF OBJECT_ID('U_ESTANTAEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_Audit] (
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
IF OBJECT_ID('U_ESTANTAEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ESTANTAEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESTANTAEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvGroupIdDetail] varchar(8) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateofDeath] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvDateOriginalHire] datetime NULL,
    [drvEligibilityStartDate] varchar(1) NOT NULL,
    [drvLossBenDate] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvWorkState] varchar(255) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvEmploymentStatus] varchar(45) NULL,
    [drvScheduleWorkHours] varchar(12) NULL,
    [drvWorkFrequencey] varchar(45) NULL,
    [drvEmpPayType] varchar(6) NOT NULL,
    [drvFullTimePartTime] varchar(9) NOT NULL,
    [drvEmploymentType] varchar(9) NOT NULL,
    [drvWorkEmaillAddress] varchar(50) NULL,
    [drvExemptStatus] varchar(10) NOT NULL,
    [drvUnionFlag] varchar(1) NOT NULL,
    [drvAffiliateName] varchar(40) NULL,
    [drvLocationCode] char(6) NULL,
    [drvLocationDesc] varchar(25) NULL,
    [drvDeptCode] char(10) NULL,
    [drvDeptName] varchar(25) NULL,
    [drvEearningCat1] varchar(6) NOT NULL,
    [drvEearningType1] varchar(2) NOT NULL,
    [drvEarningAmount1] varchar(30) NULL,
    [drvEarningAmtExp1] varchar(6) NOT NULL,
    [drvEarningEffDate1] datetime NULL,
    [drvPayFreq1] varchar(1) NOT NULL,
    [drvPayStartDate1] datetime NULL,
    [drvPayEndDate1] datetime NULL,
    [drvPayPeriosHrs1] varchar(1) NOT NULL,
    [drvEearningCat2] varchar(1) NOT NULL,
    [drvEearningType2] varchar(1) NOT NULL,
    [drvEarningAmount2] varchar(1) NOT NULL,
    [drvEarningAmtExp2] varchar(1) NOT NULL,
    [drvEarningEffDate2] varchar(1) NOT NULL,
    [drvPayFreq2] varchar(1) NOT NULL,
    [drvPayStartDate2] varchar(1) NOT NULL,
    [drvPayEndDate2] varchar(1) NOT NULL,
    [drvPayPeriosHrs2] varchar(1) NOT NULL,
    [drvEearningCat3] varchar(1) NOT NULL,
    [drvEearningType3] varchar(1) NOT NULL,
    [drvEarningAmount3] varchar(1) NOT NULL,
    [drvEarningAmtExp3] varchar(1) NOT NULL,
    [drvEarningEffDate3] varchar(1) NOT NULL,
    [drvPayFreq3] varchar(1) NOT NULL,
    [drvPayStartDate3] varchar(1) NOT NULL,
    [drvPayEndDate3] varchar(1) NOT NULL,
    [drvPayPeriosHrs3] varchar(1) NOT NULL,
    [drvHoursWorked12Months] varchar(12) NULL,
    [drvPayDate] datetime NULL,
    [drvSupervisorId] varchar(256) NULL,
    [drvDisabilityCoverage1] varchar(6) NULL,
    [drvDisPlanId1] varchar(1) NULL,
    [drvDisProductId1] varchar(2) NULL,
    [drvDisPlanCode1] varchar(1) NOT NULL,
    [drvDisWaitingPeriod1] varchar(1) NOT NULL,
    [drvDisBenPercent1] varchar(1) NOT NULL,
    [drvDisSelectedAmt1] varchar(1) NOT NULL,
    [drvDisAMClass1] varchar(1) NOT NULL,
    [drvDisClassName1] varchar(1) NOT NULL,
    [drvDisEffectiveDate1] datetime NULL,
    [drvDisTerminationDate1] datetime NULL,
    [drvDisabilityCoverage2] varchar(1) NOT NULL,
    [drvDisPlanId2] varchar(1) NOT NULL,
    [drvDisProductId2] varchar(1) NOT NULL,
    [drvDisPlanCode2] varchar(1) NOT NULL,
    [drvDisWaitingPeriod2] varchar(1) NOT NULL,
    [drvDisBenPercent2] varchar(1) NOT NULL,
    [drvDisSelectedAmt2] varchar(1) NOT NULL,
    [drvDisAMClass2] varchar(1) NOT NULL,
    [drvDisClassName2] varchar(1) NOT NULL,
    [drvDisEffectiveDate2] varchar(1) NOT NULL,
    [drvDisTerminationDate2] varchar(1) NOT NULL,
    [drvLTDCoverage1] varchar(6) NULL,
    [drvLtdPlanId1] varchar(1) NULL,
    [drvLTDProductId1] varchar(2) NULL,
    [drvLTDPlanCode1] varchar(1) NOT NULL,
    [drvLTDWaitingPeriod1] varchar(1) NOT NULL,
    [drvLTDBenPercent1] varchar(1) NOT NULL,
    [drvLTDSelectedAmt1] varchar(1) NOT NULL,
    [drvLTDAMClass1] varchar(1) NOT NULL,
    [drvLTDEffectiveDate1] datetime NULL,
    [drvLTDTerminationDate1] datetime NULL,
    [drvLTDCoverage2] varchar(1) NOT NULL,
    [drvLtdPlanId2] varchar(1) NOT NULL,
    [drvLTDProductId2] varchar(1) NOT NULL,
    [drvLTDPlanCode2] varchar(1) NOT NULL,
    [drvLTDWaitingPeriod2] varchar(1) NOT NULL,
    [drvLTDBenPercent2] varchar(1) NOT NULL,
    [drvLTDSelectedAmt2] varchar(1) NOT NULL,
    [drvLTDAMClass2] varchar(1) NOT NULL,
    [drvLTDEffectiveDate2] varchar(1) NOT NULL,
    [drvLTDTerminationDate2] varchar(1) NOT NULL,
    [drvLOTHCoverage2] varchar(1) NOT NULL,
    [drvOTHPlanId2] varchar(1) NOT NULL,
    [drvOTHProductId2] varchar(1) NOT NULL,
    [drvOTHPlanCode2] varchar(1) NOT NULL,
    [drvOTHWaitingPeriod2] varchar(1) NOT NULL,
    [drvOTHBenPercent2] varchar(1) NOT NULL,
    [drvOTHSelectedAmt2] varchar(1) NOT NULL,
    [drvOTHAMClass2] varchar(1) NOT NULL,
    [drvOTHAMClassName2] varchar(1) NOT NULL,
    [drvOTHEffectiveDate2] varchar(1) NOT NULL,
    [drvOTHTerminationDate2] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESTANTAEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESTANTAEXP_File') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ESTANTAEXP_header') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_header] (
    [drvHeader] varchar(3) NOT NULL,
    [drvFileDate] datetime NOT NULL,
    [drvCompanyId] varchar(2) NOT NULL,
    [drvCustomerName] varchar(18) NOT NULL,
    [drvGroupId] varchar(8) NOT NULL
);
IF OBJECT_ID('U_ESTANTAEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_PDedHist] (
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
IF OBJECT_ID('U_ESTANTAEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_PEarHist] (
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
IF OBJECT_ID('U_ESTANTAEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_ESTANTAEXP_Trailer] (
    [drvRecordCount] varchar(12) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANTAEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Truman Arnold Companies

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 11/21/2019
Service Request Number: SR-2020-00293184

Purpose: Standard File Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTANTAEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTANTAEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTANTAEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTANTAEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTANTAEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANTAEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANTAEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANTAEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANTAEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTANTAEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESTANTAEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@Last52WeekPerControl as VARCHAR(10);

    -- Set FormatCode
    SELECT @FormatCode = 'ESTANTAEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESTANTAEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTANTAEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    IF OBJECT_ID('U_ESTANTAEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANTAEXP_AuditFields;
    CREATE TABLE dbo.U_ESTANTAEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESTANTAEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    INSERT INTO dbo.U_ESTANTAEXP_AuditFields VALUES ('empcomp','EecDedGroupCode');    

    
    -- Create audit table
    IF OBJECT_ID('U_ESTANTAEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANTAEXP_Audit;
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
    INTO dbo.U_ESTANTAEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ESTANTAEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ESTANTAEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate - 30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESTANTAEXP_Audit ON dbo.U_ESTANTAEXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DISA,DISB';

    IF OBJECT_ID('U_ESTANTAEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANTAEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTANTAEXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStartDates', 'Y')

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,CHD, DPC,STC');

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

    FROM dbo.U_dsi_BDM_ESTANTAEXP D

    JOIN dbo.U_dsi_BDM_ESTANTAEXP E

        ON E.BdmEEID = D.BdmEEID

        AND E.BdmCOID = D.BdmCOID

        AND E.BdmDedCode = D.BdmDedCode

    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';



    --=====================================================

    -- Update BdmUSGField2 with EmpDedTVID for Employees

    --=====================================================

    UPDATE dbo.U_dsi_BDM_ESTANTAEXP

        SET BdmUSGField2 = EedEmpDedTVID

    FROM dbo.U_dsi_BDM_ESTANTAEXP

    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)

        ON EedEEID = BdmEEID

        AND EedCOID = BdmCOID

        AND EedDedCode = BdmDedCode

    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';



    --=======================================================

    -- Update BdmUSGField2 with DepBPlanTVID for Dependents

    --=======================================================

    UPDATE dbo.U_dsi_BDM_ESTANTAEXP

        SET BdmUSGField2 = DbnDepBPlanTVID

    FROM dbo.U_dsi_BDM_ESTANTAEXP

    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)

        ON DbnEEID = BdmEEID

        AND DbnCOID = BdmCOID

        AND DbnDedCode = BdmDedCode

    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';



    --======================================================

    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)

    --======================================================

    UPDATE dbo.U_dsi_BDM_ESTANTAEXP

        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)

    FROM dbo.U_dsi_BDM_ESTANTAEXP

    JOIN dbo.EmpDedFull WITH (NOLOCK)

        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESTANTAEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANTAEXP_PDedHist;
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
    INTO dbo.U_ESTANTAEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESTANTAEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESTANTAEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANTAEXP_PEarHist;
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
    INTO dbo.U_ESTANTAEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTANTAEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTANTAEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANTAEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvGroupIdDetail = '10152480'
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateofDeath = CASE WHEN eecemplstatus = 'T' and  eectermreason  = '203' THEN eecdateoftermination
                               WHEN EepDateDeceased  is not null then EepDateDeceased 
                         END 
        ,drvGender = CASE WHEN EepGender in ('','Z') THEN 'U' ELSE eepGender END
        ,drvMaritalStatus = ''
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvPhoneNumber = CASE WHEN EepPhoneHomeNumber is not null then EepPhoneHomeNumber 
                             ELSE (Select top 1 efoPhoneNumber   from EmpMPhon where efoPhoneType  = 'CEL' and efoeeid = xeeid)
                            END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvDateOriginalHire = EecDateOfOriginalHire
        ,drvEligibilityStartDate = ''
        ,drvLossBenDate = CASE WHEN  RTRIM(EecDedGroupCode) = 'NON' and RTRIM((select top 1 EdhChangeReason from Emphded where edheeid =  xeeid and edhcoid = xCOID and  edhdedcode in (select dedcode from U_ESTANTAEXP_DedList) order by EdhEffDate desc)) in ('202', '203' , 'CHGRP')  THEN  (select top 1 EdhEffDate from Emphded where edheeid =  xeeid and edhcoid = xCOID and  edhdedcode in (select dedcode from U_ESTANTAEXP_DedList) order by EdhEffDate desc)  END
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvWorkState = (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation))
        ,drvJobTitle = JbcDesc
        ,drvEmploymentStatus = CASE WHEN eecemplstatus = 'L' THEN 'Leave of Absence'
                                    ELSE (Select top 1 CodDesc from Codes WITH (NOLOCK) where codTable  = 'EMPLOYEESTATUS' and CodCode = eecemplstatus)
                                END 
        ,drvScheduleWorkHours = CAST(CONVERT(DECIMAL(10,2),EecScheduledWorkHrs) as varchar(12))
        ,drvWorkFrequencey =  CASE WHEN eecpayperiod = 'B' THEN  'Bi-Weekly' ELSE (Select top 1 CodDesc from Codes WITH (NOLOCK) where codTable  = 'PAYFREQ' and CodCode = eecpayperiod) END
        ,drvEmpPayType = CASE WHEN EecSalaryOrHourly ='H' THEN 'Hourly' ELSE 'Salary' END
        ,drvFullTimePartTime = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvEmploymentType = CASE WHEN EecEEType ='TMP' THEN 'Temporary' 
                                  WHEN EecEEType ='SUM' THEN 'Seasonal' 
                                  ELSE 'Regular'
                             
                             END
        ,drvWorkEmaillAddress = EepAddressEMail
        ,drvExemptStatus =  CASE WHEN (Select top 1 EjhFLSACategory from EmpHJob where ejheeid = xeeid and ejhcoid = xcoid order by ejhjobeffdate desc) = 'E' THEN 'Exempt' ELSE 'Non-Exempt' END
        ,drvUnionFlag = '' --CASE WHEN EecUnionNational is not null or EecUnionLocal is not null THEN 'Y' ELSE  'N' END
        ,drvAffiliateName = (Select top 1 cmpcompanyname from dbo.company where cmpcoid = xcoid)
        ,drvLocationCode = EEcLocation
        ,drvLocationDesc = (Select Top 1 LocDesc from Location where LocCode in (EEcLocation))
        ,drvDeptCode = eecorglvl1
        ,drvDeptName = (Select top 1 OrgDesc from dbo.OrgLevel where OrgCode = EecOrgLvl1 and OrgLvl = 1 )
        ,drvEearningCat1 = 'Actual'
        ,drvEearningType1 =  'W2'
        ,drvEarningAmount1 = CAST ( (Select top 1 YesUSMEDEETaxableWages from YREESum where YesEEID =  xeeid and YesCoid = xcoid) as varchar)
        ,drvEarningAmtExp1 = 'Annual'
        ,drvEarningEffDate1 =  CAST( '12/31/' + CAST (Year(@StartDate) - 1 as varchar(4)) as DateTime)
        ,drvPayFreq1 = ''
        ,drvPayStartDate1 = CAST( '01/01/' + CAST (Year(@StartDate) - 1 as varchar(4)) as DateTime)
        ,drvPayEndDate1 = CAST( '12/31/' + CAST (Year(@StartDate) - 1 as varchar(4)) as DateTime)
        ,drvPayPeriosHrs1 =  ''

        ,drvEearningCat2 = ''
        ,drvEearningType2 = '' 
        ,drvEarningAmount2 = ''
        ,drvEarningAmtExp2 = ''
        ,drvEarningEffDate2 = ''
        ,drvPayFreq2 = ''
        ,drvPayStartDate2 = '' 
        ,drvPayEndDate2 = ''
        ,drvPayPeriosHrs2 = ''

        ,drvEearningCat3 = ''
        ,drvEearningType3 = ''
        ,drvEarningAmount3 = ''
        ,drvEarningAmtExp3 = ''
        ,drvEarningEffDate3 = ''
        ,drvPayFreq3 = ''
        ,drvPayStartDate3 = ''
        ,drvPayEndDate3 = ''
        ,drvPayPeriosHrs3 = ''

     
        ,drvHoursWorked12Months = CAST(CONVERT(DECIMAL(10,2),PehCurHrsYTD) as varchar(12))
        ,drvPayDate = PrgPayDate
        ,drvSupervisorId = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'EmpNo')  

        ,drvDisabilityCoverage1 = CASE WHEN LTDER is not null then '759706' END
        ,drvDisPlanId1 = CASE WHEN LTDER is not null then 'A' END
        ,drvDisProductId1 = CASE WHEN LTDER is not null then 'ST' END
        ,drvDisPlanCode1 = ''
        ,drvDisWaitingPeriod1 = ''
        ,drvDisBenPercent1 = ''
        ,drvDisSelectedAmt1 = ''
        ,drvDisAMClass1 = ''
        ,drvDisClassName1 = ''
        ,drvDisEffectiveDate1 = CASE WHEN LTDER is not null then LTDER_BenefitDate END
        ,drvDisTerminationDate1 = CASE WHEN LTDER is not null then LTDER_BenefitStopDate END
        ,drvDisabilityCoverage2 = ''
        ,drvDisPlanId2 = ''
        ,drvDisProductId2 = ''
        ,drvDisPlanCode2 = ''
        ,drvDisWaitingPeriod2 = ''
        ,drvDisBenPercent2 = ''
        ,drvDisSelectedAmt2 = ''
        ,drvDisAMClass2 = ''
        ,drvDisClassName2 = ''
        ,drvDisEffectiveDate2 = ''
        ,drvDisTerminationDate2 = ''
        ,drvLTDCoverage1  = CASE WHEN LTDER is not null then '759703' END
        ,drvLtdPlanId1 = CASE WHEN LTDER is not null then 'B' END
        ,drvLTDProductId1 = CASE WHEN LTDER is not null then 'LT' END
        ,drvLTDPlanCode1 = ''
        ,drvLTDWaitingPeriod1 = ''
        ,drvLTDBenPercent1 = ''
        ,drvLTDSelectedAmt1 = ''
        ,drvLTDAMClass1 = ''
        ,drvLTDEffectiveDate1 = CASE WHEN LTDER is not null then LTDER_BenefitDate END
        ,drvLTDTerminationDate1 = CASE WHEN LTDER is not null then LTDER_BenefitStopDate END
        ,drvLTDCoverage2 = ''
        ,drvLtdPlanId2 = ''
        ,drvLTDProductId2 = ''
        ,drvLTDPlanCode2 = ''
        ,drvLTDWaitingPeriod2 = ''
        ,drvLTDBenPercent2 = ''
        ,drvLTDSelectedAmt2 = ''
        ,drvLTDAMClass2 = ''
        ,drvLTDEffectiveDate2 = ''
        ,drvLTDTerminationDate2 = ''
        ,drvLOTHCoverage2 = ''
        ,drvOTHPlanId2 = ''
        ,drvOTHProductId2 = ''
        ,drvOTHPlanCode2 = ''
        ,drvOTHWaitingPeriod2 = ''
        ,drvOTHBenPercent2 = ''
        ,drvOTHSelectedAmt2 = ''
        ,drvOTHAMClass2 = ''
        ,drvOTHAMClassName2 = ''
        ,drvOTHEffectiveDate2 = ''
        , drvOTHTerminationDate2 = ''

    INTO dbo.U_ESTANTAEXP_drvTbl
    FROM dbo.U_ESTANTAEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ESTANTAEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (Select  bdmEEID,bdmcoid
            ,LTDER = MAX((CASE WHEN BDMDedCode in ('DISA','DISB') then BDMDedCode END))
            ,LTDER_BenefitDate = MAX((CASE WHEN BDMDedCode in ('DISA','DISB')then  BdmBenStartDate END))
            ,LTDER_BenefitStopDate = MAX((CASE WHEN BDMDedCode in ('DISA','DISB')then  BdmBenStopDate END))
            ,LTDER_BenefitAmt = SUM((CASE WHEN BDMDedCode in ('DISA','DISB') then  CAST(BdmUSGField1 as MONEY) END))
            
            from U_dsi_BDM_ESTANTAEXP  group by bdmEEID,bdmcoid) AS BdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
       JOIN dbo.U_ESTANTAEXP_PEarHist WITH (NOLOCK)
        on peheeid = xeeid
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
ALTER VIEW dbo.dsi_vwESTANTAEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTANTAEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTANTAEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911141'
       ,expStartPerControl     = '201911141'
       ,expLastEndPerControl   = '201911219'
       ,expEndPerControl       = '201911219'
WHERE expFormatCode = 'ESTANTAEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTANTAEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTANTAEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort