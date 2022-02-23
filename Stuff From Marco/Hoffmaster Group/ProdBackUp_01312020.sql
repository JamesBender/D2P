SET NOCOUNT ON;
IF OBJECT_ID('U_EVIYSFHOFX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVIYSFHOFX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVIYSFHOFX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVIYSFHOFX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVIYSFHOFX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVIYSFHOFX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVIYSFHOFX];
GO
IF OBJECT_ID('U_EVIYSFHOFX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_PEarHist];
GO
IF OBJECT_ID('U_EVIYSFHOFX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_PDedHist];
GO
IF OBJECT_ID('U_EVIYSFHOFX_File') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_File];
GO
IF OBJECT_ID('U_EVIYSFHOFX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_EEList];
GO
IF OBJECT_ID('U_EVIYSFHOFX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_drvTbl];
GO
IF OBJECT_ID('U_EVIYSFHOFX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_DedList];
GO
IF OBJECT_ID('U_EVIYSFHOFX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_AuditFields];
GO
IF OBJECT_ID('U_EVIYSFHOFX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EVIYSFHOFX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EVIYSFHOFX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVIYSFHOFX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVIYSFHOFX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVIYSFHOFX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVIYSFHOFX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVIYSFHOFX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EVIYSFHOFX','Voya StD, FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EVIYSFHOFXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Benefit Plan Number"','1','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','1',NULL,'Group Benefit Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Claim Account Number"','2','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','2',NULL,'Claim Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee/ Member Social Security Number"','3','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','3',NULL,'Employee/ Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','4','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name or Initial"','7','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','7',NULL,'Middle Name or Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Name Suffix"','8','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','8',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','9','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','9',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','10','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','10',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','11','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','12','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','13','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','13',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','14','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','14',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','15','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','16','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','16',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','17','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','17',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Term Date"','18','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','18',NULL,'Employment Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Type"','19','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','19',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency"','20','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','20',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employees Job Title"','21','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','21',NULL,'Employee''s Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Location"','22','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','22',NULL,'Work Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Eligibility Date"','23','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','23',NULL,'STD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Eligibility Date"','24','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','24',NULL,'LTD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STD Eligible Flag"','25','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','25',NULL,'STD Eligible Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FMLA Consideration Flag"','26','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','26',NULL,'FMLA Consideration Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','27','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','27',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Wage"','28','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','28',NULL,'Hourly Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Weekly Hours Worked"','29','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','29',NULL,'Weekly Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Category"','30','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','30',NULL,'Employment Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee State Worked"','31','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','31',NULL,'Employee State Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone Number"','32','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','32',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','33','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','33',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Unit"','34','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','34',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt Status"','35','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','35',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Zip Code"','36','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','36',NULL,'Work Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Compsych Supplemental Information"','37','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','37',NULL,'Compsych Supplemental Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Primary Contact ID #"','38','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','38',NULL,' Primary Contact ID #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Work Email Address"','39','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','39',NULL,'Employee Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Status"','40','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','40',NULL,'Union Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','41','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','41',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Type"','42','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','42',NULL,'Group Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Number of Days per Week"','43','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','43',NULL,'Scheduled Number of Days per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Anniversary Date"','44','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','44',NULL,'Anniversary Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','45','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','45',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked in Pervious 12 Month Period"','46','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','46',NULL,'Hours Worked in Pervious 12 Month Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Compysch Account Number"','47','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','47',NULL,'Compysch Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Info"','48','(''DA''=''T,'')','EVIYSFHOFXZ0','50','H','10','48',NULL,'Supplemental Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Remarks"','49','(''DA''=''T'')','EVIYSFHOFXZ0','50','H','10','49',NULL,'Remarks',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupPlanNumber"','1','(''UA''=''T,'')','EVIYSFHOFXZ0','8','D','10','1',NULL,'Group Benefit Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClamAcctNumber"','2','(''UA''=''T,'')','EVIYSFHOFXZ0','4','D','10','2',NULL,'Claim Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','3','(''UA''=''T,'')','EVIYSFHOFXZ0','9','D','10','3',NULL,'Employee/ Member Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','4','(''UA''=''T,'')','EVIYSFHOFXZ0','15','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EVIYSFHOFXZ0','20','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EVIYSFHOFXZ0','10','D','10','7',NULL,'Middle Name or Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','8','(''UA''=''T,'')','EVIYSFHOFXZ0','10','D','10','8',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','9',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','10',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T,'')','EVIYSFHOFXZ0','2','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','13','(''UA''=''T,'')','EVIYSFHOFXZ0','9','D','10','13',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','14','(''UD112''=''T,'')','EVIYSFHOFXZ0','8','D','10','14',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T,'')','EVIYSFHOFXZ0','1','D','10','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','16','(''UA''=''T,'')','EVIYSFHOFXZ0','1','D','10','16',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','17','(''UD112''=''T,'')','EVIYSFHOFXZ0','8','D','10','17',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','18','(''UD112''=''T,'')','EVIYSFHOFXZ0','8','D','10','18',NULL,'Employment Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollType"','19','(''UA''=''T,'')','EVIYSFHOFXZ0','1','D','10','19',NULL,'Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFreq"','20','(''UA''=''T,'')','EVIYSFHOFXZ0','1','D','10','20',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpJobTitle"','21','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','21',NULL,'Employee''s Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkLocation"','22','(''UA''=''T,'')','EVIYSFHOFXZ0','10','D','10','22',NULL,'Work Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEligibilityDate"','23','(''UD112''=''T,'')','EVIYSFHOFXZ0','8','D','10','23',NULL,'STD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEligibilityDate"','24','(''UD112''=''T,'')','EVIYSFHOFXZ0','8','D','10','24',NULL,'LTD Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEligFlag"','25','(''UA''=''T,'')','EVIYSFHOFXZ0','1','D','10','25',NULL,'STD Eligible Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFMLACondiderationFlag"','26','(''UA''=''T,'')','EVIYSFHOFXZ0','1','D','10','26',NULL,'FMLA Consideration Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','27','(''UA''=''T,'')','EVIYSFHOFXZ0','11','D','10','27',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyWage"','28','(''UA''=''T,'')','EVIYSFHOFXZ0','6','D','10','28',NULL,'Hourly Wage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklHoursWorked"','29','(''UA''=''T,'')','EVIYSFHOFXZ0','4','D','10','29',NULL,'Weekly Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCategory"','30','(''UA''=''T,'')','EVIYSFHOFXZ0','1','D','10','30',NULL,'Employment Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpStateWorked"','31','(''UA''=''T,'')','EVIYSFHOFXZ0','2','D','10','31',NULL,'Employee State Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneNumber"','32','(''UA''=''T,'')','EVIYSFHOFXZ0','13','D','10','32',NULL,'Work Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','33','(''UA''=''T,'')','EVIYSFHOFXZ0','13','D','10','33',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBusinessUnit"','34','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','34',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptStatus"','35','(''UA''=''T,'')','EVIYSFHOFXZ0','15','D','10','35',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkZipCode"','36','(''UA''=''T,'')','EVIYSFHOFXZ0','10','D','10','36',NULL,'Work Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompSuppInfo"','37','(''UA''=''T,'')','EVIYSFHOFXZ0','5','D','10','37',NULL,'Compsych Supplemental Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryContactId"','38','(''UA''=''T,'')','EVIYSFHOFXZ0','13','D','10','38',NULL,' Primary Contact ID #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkEmailAddress"','39','(''UA''=''T,'')','EVIYSFHOFXZ0','100','D','10','39',NULL,'Employee Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionStatus"','40','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','40',NULL,'Union Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','41','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','41',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupType"','42','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','42',NULL,'Group Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledNumberOfDaysPW"','43','(''UA''=''T,'')','EVIYSFHOFXZ0','2','D','10','43',NULL,'Scheduled Number of Days per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnniversaryDate"','44','(''UD112''=''T,'')','EVIYSFHOFXZ0','9','D','10','44',NULL,'Anniversary Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','45','(''UD112''=''T,'')','EVIYSFHOFXZ0','8','D','10','45',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWork12Month"','46','(''UA''=''T,'')','EVIYSFHOFXZ0','7','D','10','46',NULL,'Hours Worked in Pervious 12 Month Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComAcctNumber"','47','(''UA''=''T,'')','EVIYSFHOFXZ0','7','D','10','47',NULL,'Compysch Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupplementalInfo"','48','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','48',NULL,'Supplemental Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRemarks"','49','(''UA''=''T,'')','EVIYSFHOFXZ0','30','D','10','49',NULL,'Remarks',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVIYSFHOFX_20200131.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya StD, FMLA Export','201911229','EMPEXPORT','ONDEMAND',NULL,'EVIYSFHOFX',NULL,NULL,NULL,'201911229','Nov 22 2019  3:19PM','Nov 22 2019  3:19PM','201911221',NULL,'','','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVIYSFHOFX_20200131.txt',NULL,NULL,NULL,',OFPDO',NULL,NULL,NULL,'Scheduled Session','201912099','EMPEXPORT','SCHEDULED',NULL,'EVIYSFHOFX',NULL,NULL,NULL,'202001289','Nov 22 2019  3:19PM','Nov 22 2019  3:19PM','202001211',NULL,'','','201912091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVIYSFHOFX_20200131.txt',NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201911229','EMPEXPORT','OEACTIVE',NULL,'EVIYSFHOFX',NULL,NULL,NULL,'201911229','Nov 22 2019  3:19PM','Nov 22 2019  3:19PM','201911221',NULL,'','','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVIYSFHOFX_20200131.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201911229','EMPEXPORT','OEPASSIVE',NULL,'EVIYSFHOFX',NULL,NULL,NULL,'201911229','Nov 22 2019  3:19PM','Nov 22 2019  3:19PM','201911221',NULL,'','','201911221',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVIYSFHOFX_20200131.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201912029','EMPEXPORT','TEST','Dec  4 2019 12:29PM','EVIYSFHOFX',NULL,NULL,NULL,'201912029','Dec  2 2019 12:00AM','Dec 30 1899 12:00AM','201911181','1342','','','201911181',dbo.fn_GetTimedKey(),NULL,'us3cPeHOF1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EVIYSFHOFX_20200131.txt' END WHERE expFormatCode = 'EVIYSFHOFX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVIYSFHOFX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVIYSFHOFX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVIYSFHOFX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVIYSFHOFX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EVIYSFHOFX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EVIYSFHOFX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EVIYSFHOFX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVIYSFHOFX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVIYSFHOFX','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVIYSFHOFX','D10','dbo.U_EVIYSFHOFX_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EVIYSFHOFX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EVIYSFHOFX] (
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
IF OBJECT_ID('U_EVIYSFHOFX_Audit') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_Audit] (
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
IF OBJECT_ID('U_EVIYSFHOFX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EVIYSFHOFX_DedList') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EVIYSFHOFX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvGroupPlanNumber] varchar(8) NOT NULL,
    [drvClamAcctNumber] varchar(32) NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvEmploymentStatus] varchar(1) NULL,
    [drvDateofHire] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvPayrollType] varchar(1) NULL,
    [drvPayrollFreq] char(1) NULL,
    [drvEmpJobTitle] varchar(25) NULL,
    [drvWorkLocation] varchar(255) NULL,
    [drvSTDEligibilityDate] datetime NULL,
    [drvLTDEligibilityDate] varchar(1) NOT NULL,
    [drvSTDEligFlag] varchar(1) NOT NULL,
    [drvFMLACondiderationFlag] varchar(1) NOT NULL,
    [drvAnnualSalary] varchar(12) NULL,
    [drvHourlyWage] varchar(12) NULL,
    [drvWeeklHoursWorked] varchar(12) NULL,
    [drvEmpCategory] char(1) NULL,
    [drvEmpStateWorked] varchar(255) NULL,
    [drvWorkPhoneNumber] varchar(1) NOT NULL,
    [drvHomePhoneNumber] varchar(13) NULL,
    [drvBusinessUnit] varchar(25) NULL,
    [drvExemptStatus] varchar(10) NOT NULL,
    [drvWorkZipCode] varchar(50) NULL,
    [drvCompSuppInfo] varchar(1) NOT NULL,
    [drvPrimaryContactId] varchar(25) NULL,
    [drvEmpWorkEmailAddress] varchar(50) NULL,
    [drvUnionStatus] char(12) NULL,
    [drvDivision] varchar(25) NULL,
    [drvGroupType] varchar(1) NOT NULL,
    [drvScheduledNumberOfDaysPW] varchar(1) NOT NULL,
    [drvAnniversaryDate] varchar(1) NOT NULL,
    [drvRehireDate] datetime NULL,
    [drvHoursWork12Month] varchar(12) NULL,
    [drvComAcctNumber] varchar(6) NOT NULL,
    [drvSupplementalInfo] varchar(1) NOT NULL,
    [drvRemarks] varchar(7) NULL
);
IF OBJECT_ID('U_EVIYSFHOFX_EEList') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVIYSFHOFX_File') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EVIYSFHOFX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [STD] numeric NULL,
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
IF OBJECT_ID('U_EVIYSFHOFX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EVIYSFHOFX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVIYSFHOFX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Hoffmaster Group, Inc

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 11/22/2019
Service Request Number: SR-2019-00250577

Purpose: Voya StD, FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVIYSFHOFX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVIYSFHOFX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVIYSFHOFX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVIYSFHOFX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVIYSFHOFX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVIYSFHOFX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVIYSFHOFX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVIYSFHOFX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVIYSFHOFX', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVIYSFHOFX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EVIYSFHOFX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EVIYSFHOFX';

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
    DELETE FROM dbo.U_EVIYSFHOFX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVIYSFHOFX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --Excluded paygroup
    DELETE FROM dbo.U_EVIYSFHOFX_EEList
    WHERE xEEID IN (select eeceeid from empcomp where eecpaygroup  in ('RETSMC', 'OSHRET', 'GMSPTP', 'CLINTP'));



    IF OBJECT_ID('U_EVIYSFHOFX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EVIYSFHOFX_AuditFields;
    CREATE TABLE dbo.U_EVIYSFHOFX_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EVIYSFHOFX_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EVIYSFHOFX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EVIYSFHOFX_Audit;
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
    INTO dbo.U_EVIYSFHOFX_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EVIYSFHOFX_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EVIYSFHOFX_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EVIYSFHOFX_Audit ON dbo.U_EVIYSFHOFX_Audit (audKey1Value, audKey2Value);



    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD';

    IF OBJECT_ID('U_EVIYSFHOFX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVIYSFHOFX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVIYSFHOFX_DedList
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
    IF OBJECT_ID('U_EVIYSFHOFX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVIYSFHOFX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,STD     = SUM(CASE WHEN PdhDedCode IN ('STD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EVIYSFHOFX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EVIYSFHOFX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EVIYSFHOFX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVIYSFHOFX_PEarHist;
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
    INTO dbo.U_EVIYSFHOFX_PEarHist
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
    -- DETAIL RECORD - U_EVIYSFHOFX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVIYSFHOFX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVIYSFHOFX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvInitialSort = eepSSN
        ,drvGroupPlanNumber = '00711781'
        ,drvClamAcctNumber = CASE WHEN EecOrgLvl3 = '34' THEN '1001 - ' 
                                  WHEN EecOrgLvl3 = '54' THEN '1002 - ' 
                                  WHEN EecOrgLvl3 = '52' THEN '1003 - ' 
                                  WHEN EecOrgLvl3  IN('50','51') THEN '1004 - ' 
                                  WHEN EecOrgLvl3 = '41' THEN '1005 - '
                                  WHEN EecOrgLvl3 = '39' THEN '1006 - '
                                  WHEN EecOrgLvl3 = '33' THEN '1007 - '
                                  WHEN EecOrgLvl3 = '25' THEN '1008 - '
                                  WHEN EecOrgLvl3 = '40' THEN '1009 - '
                                  WHEN EecOrgLvl3 = '45' THEN '1010 - '
                                   
                                END  
                                +  (select Top 1 OrgDesc from OrgLevel where OrgLvl = 3 and OrgCode =  EecOrgLvl3)
        ,drvEmpSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus IN ('A','L') THEN 'A'
                                WHEN EecEmplStatus = 'T' THEN 'T' END
        ,drvDateofHire = EecDateOfLastHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination ELSE NULL END
        ,drvPayrollType = CASE WHEN eecSalaryOrHourly = 'H' THEN 'H' 
                               WHEN eecSalaryOrHourly = 'S' THEN 'S'
                            END
        ,drvPayrollFreq = eecPayPeriod
        ,drvEmpJobTitle = (select top 1 JbcDesc from jobcode where JbcJobCode =  eecJobCode)
        ,drvWorkLocation = (select top 1 LocAddressState from Location where LocCode = EECLocation)
        ,drvSTDEligibilityDate = CASE WHEN bdmDedCode In ('STD')  THEN bdmBenStartDate END
        ,drvLTDEligibilityDate = ''
        ,drvSTDEligFlag = CASE WHEN bdmDedCode In ('STD') THEN 'Y' ELSE 'N' END
        ,drvFMLACondiderationFlag = 'Y'
        ,drvAnnualSalary = CAST(CONVERT(DECIMAL(10,2),eecAnnSalary) as varchar(12))
        ,drvHourlyWage = CAST(CONVERT(DECIMAL(10,2),eecHourlyPayRate)  as varchar(12))
        ,drvWeeklHoursWorked = CAST(EecScheduledWorkHrs / 2 as varchar(12))
        ,drvEmpCategory = EecFullTimeOrPartTime
        ,drvEmpStateWorked = (select top 1 LocAddressState from Location where LocCode = EECLocation)
        ,drvWorkPhoneNumber = ''
        ,drvHomePhoneNumber = CASE WHEN LEN(EepPhoneHomeNumber) = 10  THEN  '(' + LEFT(EepPhoneHomeNumber, 3) + ')' + SUBSTRING(EepPhoneHomeNumber, 4, 3) + '-' + SUBSTRING(EepPhoneHomeNumber, 7, 4) END
        ,drvBusinessUnit = (select Top 1 OrgDesc from OrgLevel where OrgLvl = 2 and OrgCode =  EecOrgLvl2)
        ,drvExemptStatus = CASE WHEN jbcFLSAType = 'E' THEN 'Exempt' ELSE 'Non-Exempt' END
        ,drvWorkZipCode = CASE WHEN EECLocation IN ('OSH','CVILLE','OCONTO','JOLIET','INDY','FWIN','SOMERS') THEN (select top 1 locAddressZipCode from Location where LocCode = EECLocation)
                            ELSE EepAddressZipCode END
        ,drvCompSuppInfo = ''
        ,drvPrimaryContactId = EECUDFIELD14
        ,drvEmpWorkEmailAddress = EepAddressEMail
        ,drvUnionStatus = EecUnionNational
        ,drvDivision = (select Top 1 OrgDesc from OrgLevel where OrgLvl = 1 and OrgCode =  EecOrgLvl1) 
        ,drvGroupType = ''
        ,drvScheduledNumberOfDaysPW = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '5' ELSE '3' END
        ,drvAnniversaryDate = ''
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfOriginalHire END 
        ,drvHoursWork12Month = CAST( PehCurHrsYTD as VARCHAR(12))
        ,drvComAcctNumber = '158332'
        ,drvSupplementalInfo = ''
        ,drvRemarks = CASE WHEN eecpaygroup IN ('SALARY','NONEX') Then 'Class 1'
                           WHEN eecpaygroup IN ('OSHKBW') Then 'Class 2'
                           WHEN eecpaygroup IN ('AARDBW', 'CLINHR', 'GMSPHR', 'SUMNR') Then 'Class 3'
                     END
    INTO dbo.U_EVIYSFHOFX_drvTbl
    FROM dbo.U_EVIYSFHOFX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EVIYSFHOFX_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_EVIYSFHOFX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EVIYSFHOFX_PEarHist WITH (NOLOCK)
        on PEHEEID = XEEID
    ;


    --Update StdEligibility to NULL and drvStdEligFlag to 'N' to all future dated Eligibility
    
    Update U_EVIYSFHOFX_drvTbl set drvStdEligibilityDate = NULL, drvSTDEligFlag = 'N' where  drvStdEligibilityDate > @EndDate
    Delete from U_EVIYSFHOFX_drvTbl where drvEmploymentStatus = 'T' and drvTerminationDate < DATEADD(MM, - 12, @EndDate)

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
ALTER VIEW dbo.dsi_vwEVIYSFHOFX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVIYSFHOFX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EVIYSFHOFX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201911151'
       ,expStartPerControl     = '201911151'
       ,expLastEndPerControl   = '201911229'
       ,expEndPerControl       = '201911229'
WHERE expFormatCode = 'EVIYSFHOFX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVIYSFHOFX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVIYSFHOFX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort