SET NOCOUNT ON;
IF OBJECT_ID('U_EVOYACMP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVOYACMP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVOYACMP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVOYACMP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVOYACMP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVOYACMP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYACMP];
GO
IF OBJECT_ID('U_EVOYACMP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_PDedHist];
GO
IF OBJECT_ID('U_EVOYACMP_File') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_File];
GO
IF OBJECT_ID('U_EVOYACMP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_EEList];
GO
IF OBJECT_ID('U_EVOYACMP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_drvTbl];
GO
IF OBJECT_ID('U_EVOYACMP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_DedList];
GO
IF OBJECT_ID('U_EVOYACMP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_AuditFields];
GO
IF OBJECT_ID('U_EVOYACMP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EVOYACMP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EVOYACMP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVOYACMP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVOYACMP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVOYACMP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVOYACMP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVOYACMP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EVOYACMP','Voya Comp Eligibility','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EVOYACMP00Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EVOYACMP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Benefit Plan ID"','1','(''DA''=''T,'')','EVOYACMP00Z0','21','H','01','1',NULL,'Group Benefit Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Claim Account Number"','2','(''DA''=''T,'')','EVOYACMP00Z0','20','H','01','2',NULL,'Claim Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','3','(''DA''=''T,'')','EVOYACMP00Z0','11','H','01','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','4','(''DA''=''T,'')','EVOYACMP00Z0','12','H','01','4',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Insured SSN"','5','(''DA''=''T,'')','EVOYACMP00Z0','11','H','01','5',NULL,'Insured SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','6','(''DA''=''T,'')','EVOYACMP00Z0','9','H','01','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','7','(''DA''=''T,'')','EVOYACMP00Z0','10','H','01','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name or Middle Initial"','8','(''DA''=''T,'')','EVOYACMP00Z0','29','H','01','8',NULL,'Middle Name or Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Name Suffix"','9','(''DA''=''T,'')','EVOYACMP00Z0','11','H','01','9',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line #1"','10','(''DA''=''T,'')','EVOYACMP00Z0','15','H','01','10',NULL,'Address Line #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line #2"','11','(''DA''=''T,'')','EVOYACMP00Z0','15','H','01','11',NULL,'Address Line #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','12','(''DA''=''T,'')','EVOYACMP00Z0','4','H','01','12',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','13','(''DA''=''T,'')','EVOYACMP00Z0','5','H','01','13',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','14','(''DA''=''T,'')','EVOYACMP00Z0','8','H','01','14',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','15','(''DA''=''T,'')','EVOYACMP00Z0','13','H','01','15',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','16','(''DA''=''T,'')','EVOYACMP00Z0','6','H','01','16',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone"','17','(''DA''=''T,'')','EVOYACMP00Z0','5','H','01','17',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','18','(''DA''=''T,'')','EVOYACMP00Z0','17','H','01','18',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','19','(''DA''=''T,'')','EVOYACMP00Z0','12','H','01','19',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Termination Date"','20','(''DA''=''T,'')','EVOYACMP00Z0','27','H','01','20',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','21','(''DA''=''T,'')','EVOYACMP00Z0','11','H','01','21',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Takeover"','22','(''DA''=''T,'')','EVOYACMP00Z0','8','H','01','22',NULL,'Takeover',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employees Job Title"','23','(''DA''=''T,'')','EVOYACMP00Z0','20','H','01','23',NULL,'Employees Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Location"','24','(''DA''=''T,'')','EVOYACMP00Z0','13','H','01','24',NULL,'Work Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Change SSN"','25','(''DA''=''T,'')','EVOYACMP00Z0','10','H','01','25',NULL,'Change SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Type"','26','(''DA''=''T,'')','EVOYACMP00Z0','9','H','01','26',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Class"','27','(''DA''=''T,'')','EVOYACMP00Z0','13','H','01','27',NULL,'Benefit Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Voya Coverage Effective Date"','28','(''DA''=''T,'')','EVOYACMP00Z0','28','H','01','28',NULL,'Voya Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Paid Amount"','29','(''DA''=''T,'')','EVOYACMP00Z0','20','H','01','29',NULL,'Employer Paid Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Paid Amount"','30','(''DA''=''T,'')','EVOYACMP00Z0','20','H','01','30',NULL,'Employee Paid Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Term Date"','31','(''DA''=''T,'')','EVOYACMP00Z0','17','H','01','31',NULL,'Benefit Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Coverage Effective Date"','32','(''DA''=''T,'')','EVOYACMP00Z0','32','H','01','32',NULL,'Original Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Tier"','33','(''DA''=''T,'')','EVOYACMP00Z0','13','H','01','33',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supplemental Information"','34','(''DA''=''T,'')','EVOYACMP00Z0','24','H','01','34',NULL,'Supplemental Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tobacco Status"','35','(''DA''=''T,'')','EVOYACMP00Z0','14','H','01','35',NULL,'Tobacco Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization 1"','36','(''DA''=''T,'')','EVOYACMP00Z0','14','H','01','36',NULL,'Organization 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Country"','37','(''DA''=''T'')','EVOYACMP00Z0','15','H','01','37',NULL,'Address Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00681059"','1','(''DA''=''T,'')','EVOYACMP00Z0','8','D','10','1',NULL,'Group Benefit Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','2','(''DA''=''T,'')','EVOYACMP00Z0','4','D','10','2',NULL,'Claim Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','3','(''UA''=''T,'')','EVOYACMP00Z0','15','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','4','(''UA''=''T,'')','EVOYACMP00Z0','2','D','10','4',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','EVOYACMP00Z0','9','D','10','5',NULL,'Insured SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EVOYACMP00Z0','30','D','10','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','EVOYACMP00Z0','20','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','8','(''UA''=''T,'')','EVOYACMP00Z0','10','D','10','8',NULL,'Middle Name or Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','9','(''UA''=''T,'')','EVOYACMP00Z0','10','D','10','9',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','10','(''UA''=''T,'')','EVOYACMP00Z0','30','D','10','10',NULL,'Address Line #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','11','(''UA''=''T,'')','EVOYACMP00Z0','30','D','10','11',NULL,'Address Line #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','12','(''UA''=''T,'')','EVOYACMP00Z0','30','D','10','12',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','13','(''UA''=''T,'')','EVOYACMP00Z0','2','D','10','13',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','14','(''UA''=''T,'')','EVOYACMP00Z0','9','D','10','14',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','15','(''UDMDY''=''T,'')','EVOYACMP00Z0','8','D','10','15',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','16','(''UA''=''T,'')','EVOYACMP00Z0','1','D','10','16',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','17','(''UA''=''T,'')','EVOYACMP00Z0','13','D','10','17',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','18','(''UA''=''T,'')','EVOYACMP00Z0','30','D','10','18',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','19','(''UDMDY''=''T,'')','EVOYACMP00Z0','8','D','10','19',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','20','(''UDMDY''=''T,'')','EVOYACMP00Z0','8','D','10','20',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','21','(''UDMDY''=''T,'')','EVOYACMP00Z0','8','D','10','21',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','22','(''DA''=''T,'')','EVOYACMP00Z0','1','D','10','22',NULL,'Takeover',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''T,'')','EVOYACMP00Z0','30','D','10','23',NULL,'Employees Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''SS''=''T,'')','EVOYACMP00Z0','10','D','10','24',NULL,'Work Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNHasChanged"','25','(''UA''=''T,'')','EVOYACMP00Z0','1','D','10','25',NULL,'Change SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanType"','26','(''UA''=''T,'')','EVOYACMP00Z0','4','D','10','26',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''SS''=''T,'')','EVOYACMP00Z0','30','D','10','27',NULL,'Benefit Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''SS''=''T,'')','EVOYACMP00Z0','8','D','10','28',NULL,'Voya Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''SS''=''T,'')','EVOYACMP00Z0','8','D','10','29',NULL,'Employer Paid Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageAmt"','30','(''UNT2''=''T,'')','EVOYACMP00Z0','8','D','10','30',NULL,'Employee Paid Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenTermDate"','31','(''UDMDY''=''T,'')','EVOYACMP00Z0','8','D','10','31',NULL,'Benefit Term Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''SS''=''T,'')','EVOYACMP00Z0','8','D','10','32',NULL,'Original Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','33','(''UA''=''T,'')','EVOYACMP00Z0','3','D','10','33',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeductionFrequency"','34','(''UA''=''T,'')','EVOYACMP00Z0','50','D','10','34',NULL,'Supplemental Information',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSmoker"','35','(''UA''=''T,'')','EVOYACMP00Z0','3','D','10','35',NULL,'Tobacco Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsDisabled"','36','(''UA''=''T,'')','EVOYACMP00Z0','50','D','10','36',NULL,'Organization 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"United States"','37','(''DA''=''T'')','EVOYACMP00Z0','20','D','10','37',NULL,'Address Country',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EVOYACMP_20210721.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107209','EMPEXPORT','OEACTIVE',NULL,'EVOYACMP',NULL,NULL,NULL,'202107209','Jul 20 2021  2:50PM','Jul 20 2021  2:50PM','202107201',NULL,'','','202107201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202107209','EMPEXPORT','OEPASSIVE',NULL,'EVOYACMP',NULL,NULL,NULL,'202107209','Jul 20 2021  2:50PM','Jul 20 2021  2:50PM','202107201',NULL,'','','202107201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya Comp Eligibility','202107209','EMPEXPORT','ONDEM_XOE',NULL,'EVOYACMP',NULL,NULL,NULL,'202107209','Jul 20 2021  2:50PM','Jul 20 2021  2:50PM','202107201',NULL,'','','202107201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Voya Comp Eligibility-Sched','202107209','EMPEXPORT','SCH_EVOYAC',NULL,'EVOYACMP',NULL,NULL,NULL,'202107209','Jul 20 2021  2:50PM','Jul 20 2021  2:50PM','202107201',NULL,'','','202107201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Voya Comp Eligibility-Test','202107209','EMPEXPORT','TEST_XOE',NULL,'EVOYACMP',NULL,NULL,NULL,'202107209','Jul 20 2021  2:50PM','Jul 20 2021  2:50PM','202107201',NULL,'','','202107201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACMP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACMP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACMP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACMP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACMP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EVOYACMP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EVOYACMP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EVOYACMP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYACMP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYACMP','D10','dbo.U_EVOYACMP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EVOYACMP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EVOYACMP] (
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
IF OBJECT_ID('U_EVOYACMP_Audit') IS NULL
CREATE TABLE [dbo].[U_EVOYACMP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EVOYACMP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EVOYACMP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EVOYACMP_DedList') IS NULL
CREATE TABLE [dbo].[U_EVOYACMP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EVOYACMP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVOYACMP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(9) NULL,
    [drvEmpNo] char(9) NULL,
    [drvRelationship] varchar(2) NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvDateOfHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvSSNHasChanged] varchar(1) NOT NULL,
    [drvPlanType] varchar(2) NULL,
    [drvCoverageAmt] money NULL,
    [drvBenTermDate] datetime NULL,
    [drvCoverageTier] varchar(3) NULL,
    [drvDeductionFrequency] varchar(2) NOT NULL,
    [drvIsSmoker] varchar(1) NULL,
    [drvIsDisabled] char(1) NULL
);
IF OBJECT_ID('U_EVOYACMP_EEList') IS NULL
CREATE TABLE [dbo].[U_EVOYACMP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVOYACMP_File') IS NULL
CREATE TABLE [dbo].[U_EVOYACMP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EVOYACMP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EVOYACMP_PDedHist] (
    [PdhAchChildSupRun] char(1) NULL,
    [PdhAllowPartialDed] char(1) NULL,
    [PdhArrearsAmt] money NULL,
    [PdhBatchID] char(15) NULL,
    [PdhBenAmt] money NULL,
    [PdhBenOption] char(6) NULL,
    [PdhBenProvider] char(10) NULL,
    [PdhChangeByUserEE] char(1) NULL,
    [PdhChangeByUserER] char(1) NULL,
    [PdhChangedByUser] char(1) NULL,
    [PdhChildSupportType] char(1) NULL,
    [PdhCoID] char(5) NOT NULL,
    [PdhCurArrearsAmt] money NULL,
    [PdhCustomAmt1] decimal NULL,
    [PdhCustomAmt2] decimal NULL,
    [PdhCustomDate] datetime NULL,
    [PdhDedCalcBasisAmt] money NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhDedForBonusOnly] char(1) NULL,
    [PdhDedPlanType] char(3) NULL,
    [PdhDedType] char(4) NOT NULL,
    [PdhDefCompCap] money NULL,
    [PdhDefCompRegCap] money NULL,
    [PdhDepDateOfBirth] datetime NULL,
    [PdhDepGender] char(1) NULL,
    [PdhDepIsSmoker] char(1) NULL,
    [PdhDepRecID] char(12) NULL,
    [PdhEECalcRateOrPct] decimal NULL,
    [PdhEECalcRule] char(2) NULL,
    [PdhEECurAmt] money NULL,
    [PdhEEDedLstPaid] datetime NULL,
    [pdhEEFeePct] decimal NULL,
    [pdhEEFeePerMonth] money NULL,
    [pdhEEFeePerWithholding] money NULL,
    [PdhEEGoalAmt] money NULL,
    [PdhEEGoalRule] char(1) NULL,
    [PdhEEGTDAmt] money NULL,
    [PdhEEID] char(12) NOT NULL,
    [PdhEENativeExemptAmt] money NULL,
    [PdhEEOrigAmt] money NULL,
    [pdhEESetupAmount] money NULL,
    [pdhEESetupIncrements] int NULL,
    [pdhEESetupIncrsUsed] int NULL,
    [pdhEESetupPct] decimal NULL,
    [PdhEmpNo] char(9) NULL,
    [PdhERAnnCapCalcRule] char(2) NULL,
    [PdhERCalcRateOrPct] decimal NULL,
    [PdhERCalcRule] char(2) NULL,
    [PdhERCurAmt] money NULL,
    [PdhERFundDiffFromEE] char(1) NULL,
    [PdhERPerCapCalcRule] char(2) NULL,
    [PdhExclFromWC] char(1) NULL,
    [PdhFLSAProtectMinWage] char(1) NULL,
    [PdhGenNumber] char(12) NOT NULL,
    [PdhGLExpAcct] char(15) NULL,
    [PdhGLPayAcct] char(15) NULL,
    [PdhImputedEarn] char(5) NULL,
    [PdhImputedEarnER] char(5) NULL,
    [PdhIncInImpInc] char(1) NULL,
    [PdhIncInImpIncER] char(1) NULL,
    [pdhInclInDefCompWageLimit] char(1) NULL,
    [PdhInclInRST] char(1) NULL,
    [PdhInsRateGender] char(1) NULL,
    [PdhInterestAmt] money NULL,
    [PdhIs401k] char(1) NULL,
    [PdhIs403b] char(1) NULL,
    [PdhIs408k] char(1) NULL,
    [PdhIs408p] char(1) NULL,
    [PdhIs457] char(1) NULL,
    [PdhIs457b] char(1) NULL,
    [PdhIs457F] char(1) NULL,
    [PdhIs501C] char(1) NULL,
    [PdhIsD125] char(1) NULL,
    [PdhIsDedOffSet] char(1) NULL,
    [PdhIsDefComp] char(1) NULL,
    [PdhIsDeferredForCAInsurance] char(1) NULL,
    [PdhIsDepCare] char(1) NULL,
    [PdhIsHousing] char(1) NULL,
    [PdhIsNQP] char(1) NULL,
    [PdhIsPER] char(1) NULL,
    [PdhIsProrated] char(1) NULL,
    [PdhIsSec125] char(1) NULL,
    [PdhIsVoided] char(1) NULL,
    [PdhIsVoidingRecord] char(1) NULL,
    [PdhLMWJurisdictionCode] varchar(8) NULL,
    [PdhLMWRate] money NULL,
    [PdhPayDate] datetime NULL,
    [PdhPayeeID] char(10) NULL,
    [PdhPayGroup] char(6) NOT NULL,
    [PdhPEOCost] decimal NULL,
    [PdhPerControl] char(9) NOT NULL,
    [PdhPriority] int NULL,
    [PdhProCostCode] char(10) NULL,
    [PdhProratePct] decimal NULL,
    [PdhProrationReason] char(1) NULL,
    [PdhRecID] int NULL,
    [PdhRecordCreationSource] char(1) NULL,
    [PdhRSTProv] char(8) NULL,
    [PdhSystemID] char(12) NULL,
    [PdhTaxCalcGroupID] char(5) NULL,
    [PdhTaxCategory] char(6) NOT NULL,
    [PdhTcdReferenceID] int NULL,
    [PdhTimeclockCode] char(12) NULL,
    [PdhUncollected2Arrears] char(1) NULL,
    [PdhUseChildSuppAllocation] char(1) NULL,
    [PdhVendor] char(10) NULL,
    [PdhWgaAddlArrearageAmt] money NULL,
    [PdhWgaAllocateAsArrears] char(1) NULL,
    [PdhWgaAmtExempt] money NULL,
    [PdhWgaAmtExemptFromLevy] money NULL,
    [PdhWgaAmtExemtFromGarn] money NULL,
    [PdhWgaAmtSubjectToCS] money NULL,
    [PdhWgaAmtSubjectToGarn] money NULL,
    [PdhWgaDedTaxCategory] char(6) NULL,
    [PdhWgaDisposableIncome] money NULL,
    [PdhWgaMinWageFactor] money NULL,
    [PdhWgaWageCode] char(5) NULL,
    [PdhYTDDefCompCombineAmt] money NULL,
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYACMP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: SAFE Federal Credit Union

Created By: Keary McCutchen
Business Analyst: Richard Vars
Create Date: 07/20/2021
Service Request Number: SR-2016-00012345

Purpose: Voya Comp Eligibility

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVOYACMP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVOYACMP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVOYACMP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVOYACMP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVOYACMP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYACMP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYACMP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYACMP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYACMP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYACMP', 'SCH_EVOYAC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVOYACMP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EVOYACMP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EVOYACMP';

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
    DELETE FROM dbo.U_EVOYACMP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVOYACMP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EVOYACMP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYACMP_AuditFields;
    CREATE TABLE dbo.U_EVOYACMP_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EVOYACMP_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EVOYACMP_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EVOYACMP_AuditFields VALUES ('EmpComp','EecDateOfTermination');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EVOYACMP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYACMP_Audit;
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
    INTO dbo.U_EVOYACMP_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EVOYACMP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EVOYACMP_Audit ON dbo.U_EVOYACMP_Audit (audEEID,audCOID);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'CIICH,CIIEE,CIISP,PACCI';

    IF OBJECT_ID('U_EVOYACMP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYACMP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVOYACMP_DedList
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
    --NonRequired parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'BuildConsolidatedTable', 'Standard') 
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
    -- DETAIL RECORD - U_EVOYACMP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVOYACMP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYACMP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EecEmpNo
        -- standard fields above and additional driver fields below
        ,drvEmpNo = EecEmpNo
        ,drvRelationship = CASE BdmRelationship  
                                WHEN 'Emp' THEN 'EE'
                                WHEN 'SPS' THEN 'SP'
                                WHEN 'CHL' THEN 'CH'
                            END
        ,drvSSN = CASE WHEN BdmRecType = 'EMP' THEN EepSSN ELSE ConSSN END
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END 
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType = 'EMP' THEN EepNameMiddle ELSE ConNameMiddle END
        ,drvNameSuffix = CASE WHEN BdmRecType = 'EMP' THEN NULLIF(EepNameSuffix,'Z') ELSE NULLIF(ConNameSuffix,'Z') END  
        ,drvAddressLine1 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine1 ELSE ConAddressLine1 END  
        ,drvAddressLine2 = CASE WHEN BdmRecType = 'EMP' THEN EepAddressLine2 ELSE ConAddressLine2 END  
        ,drvAddressCity = CASE WHEN BdmRecType = 'EMP' THEN EepAddressCity ELSE ConAddressCity END  
        ,drvAddressState = CASE WHEN BdmRecType = 'EMP' THEN EepAddressState ELSE ConAddressState END  
        ,drvAddressZip = CASE WHEN BdmRecType = 'EMP' THEN EepAddressZipCode ELSE ConAddressZipCode END  
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END  
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END  
        ,drvHomePhoneNumber = CASE WHEN BdmRecType = 'EMP' THEN EepPhoneHomeNumber ELSE ConPhoneHomeNumber END  
        ,drvEmplStatus = CASE WHEN EecEmplStatus = 'T' THEN 'T' ELSE 'A' END
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvSSNHasChanged = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN EXISTS(SELECT 1 FROM dbo.U_EVOYACMP_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCOID AND audFieldName = 'EepSSN') THEN 'Y' ELSE 'N' END
                                 ELSE CASE WHEN EXISTS(SELECT 1 FROM dbo.U_EVOYACMP_Audit WITH (NOLOCK) WHERE audEEID = xEEID AND audCOID = xCOID AND audFieldName = 'ConSSN') THEN 'Y' ELSE 'N' END
                             END
        ,drvPlanType = CASE WHEN BdmDedCode IN ('CIICH','CIIEE','CIISP') THEN 'CI'
                            WHEN BdmDedCode = 'PACCI' THEN 'AC'
                        END
        ,drvCoverageAmt = BdmEEAmt/*CASE WHEN  BdmDedCode IN ('CIICH','CIIEE','CIISP') THEN
                                CASE BdmBenOption 
                                    WHEN '5K'  THEN 5000.00
                                    WHEN '10K' THEN 10000.00 
                                    WHEN '2K5' THEN 2500.00
                                    WHEN '1K'  THEN 1000.00
                                    WHEN '15K' THEN 15000.00
                                    WHEN '20K' THEN 20000.00
                                END
                            END*/
        ,drvBenTermDate = DATEADD(d, -1, DATEADD(m, DATEDIFF(m, 0, BdmStopDate) + 1, 0))
        ,drvCoverageTier = CASE BdmBenOption
                                WHEN 'EE' THEN 'EMP'
                                WHEN 'EEC' THEN 'ECH'
                                WHEN 'EEF' THEN 'FAM'
                                WHEN 'EES' THEN 'ESP'
                            END
        ,drvDeductionFrequency = '26'
        ,drvIsSmoker = CASE WHEN BdmRecType = 'EMP' THEN EepIsSmoker ELSE ConIsSmoker END
        ,drvIsDisabled = CASE WHEN BdmRecType = 'EMP' THEN EepIsDisabled ELSE ConIsDisabled END
    INTO dbo.U_EVOYACMP_drvTbl
    FROM dbo.U_EVOYACMP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
       AND EecCoID = xCoID
       AND (EecEmplStatus <> 'T' or exists (Select 1 from dbo.U_EVOYACMP_Audit where xEEID = AudEEID and AudFieldName = 'EecDateOfTermination'))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.u_dsi_bdm_EVOYACMP WITH (NOLOCK)
        ON BdmEEID = xEEID 
       AND BdmCoID = xCoID
    LEFT
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConSystemID = BdmDepRecID
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
ALTER VIEW dbo.dsi_vwEVOYACMP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVOYACMP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EVOYACMP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107131'
       ,expStartPerControl     = '202107131'
       ,expLastEndPerControl   = '202107209'
       ,expEndPerControl       = '202107209'
WHERE expFormatCode = 'EVOYACMP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVOYACMP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVOYACMP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort