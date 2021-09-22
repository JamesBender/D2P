SET NOCOUNT ON;
IF OBJECT_ID('U_EAFLACCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EAFLACCEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EAFLACCEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEAFLACCEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAFLACCEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAFLACCEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAFLACCEXP];
GO
IF OBJECT_ID('U_EAFLACCEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_PEarHist];
GO
IF OBJECT_ID('U_EAFLACCEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_PDedHist];
GO
IF OBJECT_ID('U_EAFLACCEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_File];
GO
IF OBJECT_ID('U_EAFLACCEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_EEList];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblProd') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblProd];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblMeta') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblMeta];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblEmp') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblEmp];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblDep') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblDep];
GO
IF OBJECT_ID('U_EAFLACCEXP_drvTblBen') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_drvTblBen];
GO
IF OBJECT_ID('U_EAFLACCEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_DedList];
GO
IF OBJECT_ID('U_EAFLACCEXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_BdmConsolidated];
GO
IF OBJECT_ID('U_EAFLACCEXP_Bdm_PIVOT') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_Bdm_PIVOT];
GO
IF OBJECT_ID('U_EAFLACCEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_AuditFields];
GO
IF OBJECT_ID('U_EAFLACCEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EAFLACCEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAFLACCEXP];
GO
IF OBJECT_ID('dboU_EAFLACCEXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[dboU_EAFLACCEXP_BdmConsolidated];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EAFLACCEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EAFLACCEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EAFLACCEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EAFLACCEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EAFLACCEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAFLACCEXP','Aflac ACC/HOSP/CRIT Illness Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EAFLACCEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EAFLACCEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRecDisc"','1','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRecType"','2','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpUnComp"','3','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','3',NULL,'Underwriting Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','4','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','4',NULL,'Employee ID/SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','5','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','5',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','6','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','6',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleName"','7','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','7',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine1"','8','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine2"','9','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine3"','10','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','10',NULL,'Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCity"','11','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpState"','12','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpZipCode"','13','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','13',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpGender"','14','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','14',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateofBirth"','15','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','10','15',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLocationName"','16','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','16',NULL,'Location Name or Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTerminationDate"','17','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','10','17',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateofHire"','18','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','10','18',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBenefitEligibleDate"','19','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','10','19',NULL,'Benefit Eligible Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHomePhoneNumber"','20','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','20',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAnnSalary"','21','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','21',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHoursWorkedPerWeek"','22','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','22',NULL,'Hours Worked per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSalaryMode"','23','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','23',NULL,'Salary Mode (Pay Frequency)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBillingFreq"','24','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','24',NULL,'EE''s Billing Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmployer"','25','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','25',NULL,'Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpOccupation"','26','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','26',NULL,'Employee''s Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHeight"','27','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','27',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWeight"','28','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','28',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpResponse"','29','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','29',NULL,'Response to EE Actively at Work Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmailAddress"','30','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','10','30',NULL,'Employee''s Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpGroupNumber"','31','(''UA''=''T'')','EAFLACCEXPZ0','50','D','10','31',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPRecDisc"','1','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRecType"','2','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepSSN"','3','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','3',NULL,'Employee SSN/ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast"','4','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','4',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPNameFirst"','5','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','5',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle"','6','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','6',NULL,'Dependent Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth"','7','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','20','7',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender"','8','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','8',NULL,'Dependent Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDependentId"','9','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','9',NULL,'Dependent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepWeight"','10','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','10',NULL,'Dependent Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepHeight"','11','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','11',NULL,'Dependent Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepResponse"','12','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','12',NULL,'Response to SP Are you now disabled or unable to w',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmailAddress"','13','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','20','13',NULL,'Dependent''s Email address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGroupNumber"','14','(''UA''=''T'')','EAFLACCEXPZ0','50','D','20','14',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecDisc"','1','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecInd"','2','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','2',NULL,'Record Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecType"','3','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','3',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpSSN"','4','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','4',NULL,'Employee SSN/ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenAmt"','5','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','5',NULL,'Benefit Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenPrm"','6','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','6',NULL,'Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCovOption"','7','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','7',NULL,'Coverage Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCovTier"','8','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','8',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdApplicationDate"','9','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','30','9',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEffectiveDate"','10','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','30','10',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdTerminationDate"','11','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','30','11',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdTeminatingCovOption"','12','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','12',NULL,'Verify Terminating Coverage Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAddCov"','13','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','13',NULL,'Change - Adding Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenefitChange"','14','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','14',NULL,'Change - Benefit Changes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdDemoChanges"','15','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','15',NULL,'Change - Demographic Changes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpStatsChange"','16','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','16',NULL,'Change - Employee Status Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmplStatChangeReason"','17','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','17',NULL,'Change - Employee Status Change Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpStatusChangeDate"','18','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','30','18',NULL,'Change - Employee Status Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRollOver"','19','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','19',NULL,'Rollover',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRollOverBenAmt"','20','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','20',NULL,'Rollover Benefit Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecordSet"','21','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','21',NULL,'Record Set',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdSection125"','22','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','22',NULL,'Section 125',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdFTPT"','23','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','23',NULL,'FT or PT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHourlySalary"','24','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','24',NULL,'Hourly or Salaried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdClassCode"','25','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','25',NULL,'Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdFirstDeductionDate"','26','(''UD112''=''T,'')','EAFLACCEXPZ0','50','D','30','26',NULL,'First Deduction Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdStateofEnrollment"','27','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','27',NULL,'SOE - State of Enrollment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAgentName"','28','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','28',NULL,'Enrolling Agent Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAgentNumber"','29','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','29',NULL,'Enrolling Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpSignatureMethod"','30','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','30',NULL,'Employee Signature Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEnrollmentTypeMethod"','31','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','31',NULL,'Enrollment Type/Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider1"','32','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','32',NULL,'Rider 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider2"','33','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','33',NULL,'Rider 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider3"','34','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','34',NULL,'Rider 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider4"','35','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','35',NULL,'Rider 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider5"','36','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','36',NULL,'Rider 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdResponse"','37','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','37',NULL,'Response to Replacement Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCarriersName"','38','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','38',NULL,'Prior Carrier''s Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCertNumber"','39','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','39',NULL,'Prior Carrier''s Certificate Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ1"','40','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','40',NULL,'HQ 1 - TOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ2"','41','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','41',NULL,'HQ 2 - AIDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ3"','42','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','42',NULL,'HQ 3 - CANCER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ4"','43','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','43',NULL,'HQ 4 - MED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ5"','44','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','44',NULL,'HQ 5 - 5 DAYS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ6"','45','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','45',NULL,'HQ 6 - RX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ7"','46','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','46',NULL,'HQ 7 - ALCOHOL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ8"','47','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','47',NULL,'HQ 8 - HOS TREAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ9"','48','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','48',NULL,'HQ 9 - MAJ HLTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ10"','49','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','49',NULL,'HQ 10 - MEDICAID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdElimPeriod"','50','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','50',NULL,'Elimination Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenPeriod"','51','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','51',NULL,'Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdOptionalBenefitInd"','52','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','52',NULL,'Product Optional Benefit Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdDependentId"','53','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','53',NULL,'Dependent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRiderIndc"','54','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','54',NULL,'RIDER Premium Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdPremiumMode"','55','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','55',NULL,'PREMIUM MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdUnion"','56','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','56',NULL,'UNION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRollOverCov"','57','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','57',NULL,'Roll Over Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ11"','58','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','58',NULL,'HQ 11 - Major Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12"','59','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','59',NULL,'HQ 12 - Other Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12C"','60','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','60',NULL,'HQ 12 - Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12CP"','61','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','61',NULL,'HQ 12 - PolicyType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12B"','62','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','62',NULL,'HQ 12 - Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ13"','63','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','63',NULL,'HQ 13 - Medical Condition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ14"','64','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','64',NULL,'HQ 14 - Vehicle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ15"','65','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','65',NULL,'HQ 15 - Mental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ16"','66','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','66',NULL,'HQ 16 - Joint',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdMinAnnPayQuestion"','67','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','67',NULL,'Minimum Annual Pay question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdWorkCompQuestion"','68','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','68',NULL,'Workers Compensation Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdPriorEffectiveDate"','69','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','69',NULL,'Prior Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ17"','70','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','70',NULL,'HQ 17 -Comp Health Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ18"','71','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','71',NULL,'HQ 18 -Existing CI Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ19"','72','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','72',NULL,'HQ 19 - Number of CI Policies',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ20"','73','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','73',NULL,'HQ 20 - Medicaid Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAflacARO"','74','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','74',NULL,'Aflac Individual ARO Replacement Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdIndPolicyReplace"','75','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','75',NULL,'Individual Policy being replaced',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdTDIQuestion"','76','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','76',NULL,'TDI States Coverage Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdGroupNumber"','77','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','77',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ21"','78','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','78',NULL,'HQ 21 - Disorder Nerv System',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ22"','79','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','79',NULL,'HQ 22 - Unconsciousness',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ23"','80','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','80',NULL,'HQ 23 - Prog Disease',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ24"','81','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','30','81',NULL,'HQ 24 - Results Not Received',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ26"','82','(''UA''=''T'')','EAFLACCEXPZ0','50','D','30','82',NULL,'HQ 25 - Blood Pressure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRecordDisc"','1','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenProdInd"','2','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','2',NULL,'Product Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRecType"','3','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','3',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEmpSSN"','4','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','4',NULL,'Employee ID/SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenFullName"','5','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','5',NULL,'Beneficiary Full Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSSN"','6','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','6',NULL,'Beneficiary''s SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPercentage"','7','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','7',NULL,'Beneficiary''s Percentage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRelationship"','8','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','40','8',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenGroupNumber"','9','(''UA''=''T'')','EAFLACCEXPZ0','50','D','40','9',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaRecDisc"','1','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','50','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaGroupNumber"','2','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','50','2',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaVendorId"','3','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','50','3',NULL,'Vendor ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaFileType"','4','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','50','4',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaFileStatus"','5','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','50','5',NULL,'File Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaEnrollmentType"','6','(''UA''=''T,'')','EAFLACCEXPZ0','50','D','50','6',NULL,'Enrollment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaFileLayoutVersion"','7','(''UA''=''T'')','EAFLACCEXPZ0','50','D','50','7',NULL,'File Layout Version',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EAFLACCEXP_20210910.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','E2F7R',NULL,NULL,NULL,'Active Open Enrollment Export','202110019','EMPEXPORT','OEACTIVE','Sep  3 2021  8:50AM','EAFLACCEXP',NULL,NULL,NULL,'202110019','Oct  1 2021 12:00AM','Dec 30 1899 12:00AM','202108241','42','','','202108241',dbo.fn_GetTimedKey(),NULL,'us3lKiCOM1062',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',0N6CG',NULL,NULL,NULL,'Passive Open Enrollment Export','202001019','EMPEXPORT','OEPASSIVE',NULL,'EAFLACCEXP',NULL,NULL,NULL,'202001019','Dec 12 2019  3:35PM','Dec 12 2019  3:35PM','201912311',NULL,'','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Aflac Enrollment ONDEMAND','201912129','EMPEXPORT','ONDEMAND','Jun 26 2020 12:00AM','EAFLACCEXP',NULL,NULL,NULL,'201912129','Dec 12 2019 12:00AM','Dec 30 1899 12:00AM','201912121',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',0N6CG',NULL,NULL,NULL,'AFLAC Weekly Production Feed','201912129','EMPEXPORT','SCH_AFLXP',NULL,'EAFLACCEXP',NULL,NULL,NULL,'201912129','Dec 12 2019  3:35PM','Dec 12 2019  3:35PM','201912121',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202109039','EMPEXPORT','TEST','Sep  3 2021  8:48AM','EAFLACCEXP',NULL,NULL,NULL,'202109039','Sep  3 2021 12:00AM','Dec 30 1899 12:00AM','202108201','1','','','202108201',dbo.fn_GetTimedKey(),NULL,'us3lKiCOM1062',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLACCEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EAFLACCEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EAFLACCEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EAFLACCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAFLACCEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D10','dbo.U_EAFLACCEXP_drvTblEmp',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D20','dbo.U_EAFLACCEXP_drvTblDep',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D30','dbo.U_EAFLACCEXP_drvTblProd',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D40','dbo.U_EAFLACCEXP_drvTblBen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLACCEXP','D50','dbo.U_EAFLACCEXP_drvTblMeta',NULL);
IF OBJECT_ID('dboU_EAFLACCEXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[dboU_EAFLACCEXP_BdmConsolidated] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmrelationship] char(3) NULL,
    [bdmdedcode] char(5) NULL,
    [bdmbenoption] char(6) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmBenStartDate] datetime NULL,
    [bdmBenStopDate] datetime NULL,
    [bdmbenstatatus] varchar(10) NULL
);
IF OBJECT_ID('U_dsi_BDM_EAFLACCEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAFLACCEXP] (
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
IF OBJECT_ID('U_EAFLACCEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EAFLACCEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EAFLACCEXP_Bdm_PIVOT') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_Bdm_PIVOT] (
    [PvtEEID] char(12) NOT NULL,
    [PvtCOID] char(5) NULL,
    [Has_CD10K] varchar(1) NULL,
    [Has_CD5K] varchar(1) NULL,
    [Has_CI10K] varchar(1) NULL,
    [Has_CI20K] varchar(1) NULL,
    [Has_CIS10] varchar(1) NULL,
    [Has_CIS15] varchar(1) NULL,
    [Has_CIS5K] varchar(1) NULL,
    [Has_CD15K] varchar(1) NULL,
    [Has_CI30K] varchar(1) NULL
);
IF OBJECT_ID('U_EAFLACCEXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_BdmConsolidated] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmrelationship] char(3) NULL,
    [bdmdedcode] char(5) NULL,
    [bdmdeprecid] char(12) NULL,
    [bdmbenoption] char(6) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmBenStartDate] datetime NULL,
    [bdmBenStopDate] datetime NULL,
    [bdmbenstatus] char(1) NULL
);
IF OBJECT_ID('U_EAFLACCEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EAFLACCEXP_drvTblBen') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblBen] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvBenRecordDisc] varchar(4) NOT NULL,
    [drvBenProdInd] varchar(4) NULL,
    [drvBenRecType] varchar(1) NOT NULL,
    [drvBenEmpSSN] char(11) NULL,
    [drvBenFullName] varchar(201) NULL,
    [drvBenSSN] varchar(11) NULL,
    [drvBenPercentage] varchar(3) NULL,
    [drvBenRelationship] varchar(2) NOT NULL,
    [drvBenGroupNumber] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EAFLACCEXP_drvTblDep') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblDep] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvDEPRecDisc] varchar(4) NOT NULL,
    [drvDepRecType] varchar(1) NOT NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepSSN] char(11) NULL,
    [drvDepNameLast] varchar(100) NULL,
    [drvDEPNameFirst] varchar(100) NULL,
    [drvDepNameMiddle] varchar(1) NULL,
    [drvDepDateofBirth] datetime NULL,
    [drvDepGender] char(1) NULL,
    [drvDepDependentId] char(11) NULL,
    [drvDepWeight] varchar(1) NOT NULL,
    [drvDepHeight] varchar(1) NOT NULL,
    [drvDepResponse] varchar(1) NOT NULL,
    [drvDepEmailAddress] varchar(1) NOT NULL,
    [drvDepGroupNumber] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EAFLACCEXP_drvTblEmp') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblEmp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpRecDisc] varchar(3) NOT NULL,
    [drvEmpRecType] varchar(1) NOT NULL,
    [drvEmpUnComp] varchar(3) NOT NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmpSSN] char(11) NULL,
    [drvEmpLastName] varchar(131) NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMiddleName] varchar(1) NULL,
    [drvEmpAddressLine1] varchar(255) NULL,
    [drvEmpAddressLine2] varchar(255) NULL,
    [drvEmpAddressLine3] varchar(1) NOT NULL,
    [drvEmpCity] varchar(255) NULL,
    [drvEmpState] varchar(255) NULL,
    [drvEmpZipCode] varchar(50) NULL,
    [drvEmpGender] char(1) NULL,
    [drvEmpDateofBirth] datetime NULL,
    [drvEmpLocationName] varchar(1) NOT NULL,
    [drvEmpTerminationDate] datetime NULL,
    [drvEmpDateofHire] datetime NULL,
    [drvEmpBenefitEligibleDate] varchar(1) NOT NULL,
    [drvEmpHomePhoneNumber] varchar(1) NOT NULL,
    [drvEmpAnnSalary] varchar(1) NOT NULL,
    [drvEmpHoursWorkedPerWeek] varchar(2) NOT NULL,
    [drvEmpSalaryMode] varchar(1) NOT NULL,
    [drvEmpBillingFreq] varchar(1) NOT NULL,
    [drvEmpEmployer] varchar(16) NOT NULL,
    [drvEmpOccupation] varchar(1) NOT NULL,
    [drvEmpHeight] varchar(1) NOT NULL,
    [drvEmpWeight] varchar(1) NOT NULL,
    [drvEmpResponse] varchar(1) NOT NULL,
    [drvEmpEmailAddress] varchar(1) NOT NULL,
    [drvEmpGroupNumber] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EAFLACCEXP_drvTblMeta') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblMeta] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvInitialSort] varchar(14) NOT NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvMetaRecDisc] varchar(4) NOT NULL,
    [drvMetaGroupNumber] varchar(5) NOT NULL,
    [drvMetaVendorId] varchar(6) NOT NULL,
    [drvMetaFileType] varchar(1) NOT NULL,
    [drvMetaFileStatus] varchar(1) NOT NULL,
    [drvMetaEnrollmentType] varchar(2) NOT NULL,
    [drvMetaFileLayoutVersion] varchar(6) NOT NULL
);
IF OBJECT_ID('U_EAFLACCEXP_drvTblProd') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_drvTblProd] (
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(1) NOT NULL,
    [drvProdRecDisc] varchar(4) NULL,
    [drvProdRecInd] varchar(4) NULL,
    [drvProdRecType] varchar(1) NOT NULL,
    [drvProdEmpSSN] char(11) NULL,
    [drvProdBenAmt] varchar(24) NULL,
    [drvProdBenAmtRaw] money NULL,
    [drvProdBenPrm] varchar(24) NULL,
    [drvProdBenPrmRaw] money NULL,
    [drvProdCovOption] varchar(1) NULL,
    [drvProdCovTier] varchar(1) NULL,
    [drvProdApplicationDate] datetime NULL,
    [drvProdEffectiveDate] datetime NULL,
    [drvProdTerminationDate] datetime NULL,
    [drvProdTeminatingCovOption] varchar(1) NULL,
    [drvProdAddCov] varchar(1) NOT NULL,
    [drvProdBenefitChange] varchar(1) NOT NULL,
    [drvProdDemoChanges] varchar(1) NOT NULL,
    [drvProdEmpStatsChange] varchar(1) NOT NULL,
    [drvProdEmplStatChangeReason] varchar(1) NOT NULL,
    [drvProdEmpStatusChangeDate] varchar(1) NOT NULL,
    [drvProdRollOver] varchar(1) NOT NULL,
    [drvProdRollOverBenAmt] varchar(1) NOT NULL,
    [drvProdRecordSet] varchar(1) NOT NULL,
    [drvProdSection125] varchar(1) NOT NULL,
    [drvProdFTPT] varchar(2) NULL,
    [drvProdHourlySalary] char(1) NULL,
    [drvProdClassCode] varchar(1) NOT NULL,
    [drvProdFirstDeductionDate] varchar(1) NOT NULL,
    [drvProdStateofEnrollment] varchar(255) NULL,
    [drvProdAgentName] varchar(19) NOT NULL,
    [drvProdAgentNumber] varchar(4) NOT NULL,
    [drvProdEmpSignatureMethod] varchar(1) NOT NULL,
    [drvProdEnrollmentTypeMethod] varchar(1) NOT NULL,
    [drvProdRider1] varchar(1) NOT NULL,
    [drvProdRider2] varchar(1) NOT NULL,
    [drvProdRider3] varchar(1) NOT NULL,
    [drvProdRider4] varchar(1) NOT NULL,
    [drvProdRider5] varchar(1) NOT NULL,
    [drvProdResponse] varchar(1) NOT NULL,
    [drvProdCarriersName] varchar(1) NOT NULL,
    [drvProdCertNumber] varchar(1) NOT NULL,
    [drvProdHQ1] varchar(1) NOT NULL,
    [drvProdHQ2] varchar(1) NOT NULL,
    [drvProdHQ3] varchar(1) NOT NULL,
    [drvProdHQ4] varchar(1) NOT NULL,
    [drvProdHQ5] varchar(1) NOT NULL,
    [drvProdHQ6] varchar(1) NOT NULL,
    [drvProdHQ7] varchar(1) NOT NULL,
    [drvProdHQ8] varchar(1) NOT NULL,
    [drvProdHQ9] varchar(1) NOT NULL,
    [drvProdHQ10] varchar(1) NOT NULL,
    [drvProdElimPeriod] varchar(1) NOT NULL,
    [drvProdBenPeriod] varchar(1) NOT NULL,
    [drvProdOptionalBenefitInd] varchar(1) NOT NULL,
    [drvProdDependentId] char(11) NULL,
    [drvProdRiderIndc] varchar(1) NOT NULL,
    [drvProdPremiumMode] varchar(2) NOT NULL,
    [drvProdUnion] varchar(1) NOT NULL,
    [drvProdRollOverCov] varchar(1) NOT NULL,
    [drvProdHQ11] varchar(1) NOT NULL,
    [drvProdHQ12] varchar(1) NOT NULL,
    [drvProdHQ12C] varchar(1) NOT NULL,
    [drvProdHQ12CP] varchar(1) NOT NULL,
    [drvProdHQ12B] varchar(1) NOT NULL,
    [drvProdHQ13] varchar(1) NOT NULL,
    [drvProdHQ14] varchar(1) NOT NULL,
    [drvProdHQ15] varchar(1) NOT NULL,
    [drvProdHQ16] varchar(1) NOT NULL,
    [drvProdMinAnnPayQuestion] varchar(1) NOT NULL,
    [drvProdWorkCompQuestion] varchar(1) NOT NULL,
    [drvProdPriorEffectiveDate] varchar(1) NOT NULL,
    [drvProdHQ17] varchar(1) NOT NULL,
    [drvProdHQ18] varchar(1) NOT NULL,
    [drvProdHQ19] varchar(1) NOT NULL,
    [drvProdHQ20] varchar(1) NOT NULL,
    [drvProdAflacARO] varchar(1) NOT NULL,
    [drvProdIndPolicyReplace] varchar(1) NOT NULL,
    [drvProdTDIQuestion] varchar(1) NOT NULL,
    [drvProdGroupNumber] varchar(5) NOT NULL,
    [drvProdHQ21] varchar(1) NOT NULL,
    [drvProdHQ22] varchar(1) NOT NULL,
    [drvProdHQ23] varchar(1) NOT NULL,
    [drvProdHQ24] varchar(1) NOT NULL,
    [drvProdHQ26] varchar(1) NOT NULL,
    [drvEEDateOfBirth] datetime NULL,
    [drvSpDateOfBirth] datetime NULL,
    [drvEEGender] char(1) NULL,
    [drvDedcode] char(5) NULL
);
IF OBJECT_ID('U_EAFLACCEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EAFLACCEXP_File') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EAFLACCEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhLOWAC] money NULL,
    [PdhHIGHA] money NULL,
    [PdhCI10K] money NULL,
    [PdhCI20K] money NULL,
    [PdhCI30K] money NULL,
    [PdhCIS5K] money NULL,
    [PdhCIS10] money NULL,
    [PdhCIS15] money NULL,
    [PdhCD5K] money NULL,
    [PdhCD10K] money NULL,
    [PdhCD15K] money NULL,
    [PdhHOSPT] money NULL
);
IF OBJECT_ID('U_EAFLACCEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EAFLACCEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAFLACCEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: AllHealth Network

Created By: Keary McCutchen
Business Analyst: Lea King
Create Date: 08/24/2021
Service Request Number: TekP-2021-07-09-0001

Purpose: Aflac ACC/HOSP/CRIT Illness Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAFLACCEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAFLACCEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAFLACCEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAFLACCEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAFLACCEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLACCEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAFLACCEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAFLACCEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAFLACCEXP';

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
    DELETE FROM dbo.U_EAFLACCEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAFLACCEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LOWAC,HIGHA,CI10K,CI20K,CI30K,CIS5K,CIS10,CIS15,CD5K,CD10K,CD15K,HOSPT';

    IF OBJECT_ID('U_EAFLACCEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAFLACCEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EAFLACCEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_AuditFields;
    CREATE TABLE dbo.U_EAFLACCEXP_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EAFLACCEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EAFLACCEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EAFLACCEXP_Audit
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EAFLACCEXP_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    ;

    CREATE CLUSTERED INDEX CDX_U_EAFLACCEXP_Audit ON dbo.U_EAFLACCEXP_Audit (audEEID,audCOID);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EmployeeElectedRateorPct',@DedList);
        -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP')
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
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EAFLACCEXP
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EAFLACCEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with        BPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EAFLACCEXP
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EAFLACCEXP
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (DedEedBenAmt)
    --======================================================
     UPDATE dbo.U_dsi_bdm_EAFLACCEXP
        SET BdmUSGField1 = CONVERT(VARCHAR(20),DedEEBenAmt)
    FROM dbo.U_dsi_bdm_EAFLACCEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --======================================================
    --UPDATE Premiums based on Option Rate Table
    --======================================================
     UPDATE dbo.u_dsi_bdm_BenCalculationAmounts
        SET BcaEEAmt = CorEERate
    FROM dbo.u_dsi_bdm_BenCalculationAmounts
    JOIN dbo.OptRate WITH (NOLOCK)
        ON BcaFormatCode = @FormatCode
       AND BcaDedCode = CorDedCode
       AND BcaBenOption = CorBenOption
       AND ISNULL(BcaEEAmt,0.00) = 0.00
    ;    
    

    --==========================================
    -- Build Working Tables
    --==========================================
    -----------------------------
    -- Working Table - Pivot Critical Illness Coverage
    -----------------------------
     IF OBJECT_ID('U_EAFLACCEXP_Bdm_PIVOT','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_Bdm_PIVOT;
    SELECT
           PvtEEID = BdmEEID
          ,PvtCOID = BdmCOID
          --,PVtDepRecID = BdmDepRecId
          ,Has_CD10K = MAX(CASE WHEN BdmDedCode = 'CD10K' THEN 'Y' END)
          ,Has_CD5K =  MAX(CASE WHEN BdmDedCode = 'CD5K' THEN 'Y' END)
          ,Has_CI10K =  MAX(CASE WHEN BdmDedCode = 'CI10K' THEN 'Y' END)
          ,Has_CI20K =  MAX(CASE WHEN BdmDedCode = 'CI20K' THEN 'Y' END)
          ,Has_CIS10 =  MAX(CASE WHEN BdmDedCode = 'CIS10' THEN 'Y' END)
          ,Has_CIS15 =  MAX(CASE WHEN BdmDedCode = 'CIS15' THEN 'Y' END)
          ,Has_CIS5K =  MAX(CASE WHEN BdmDedCode = 'CIS5K' THEN 'Y' END)
          ,Has_CD15K =  MAX(CASE WHEN BdmDedCode = 'CD15K' THEN 'Y' END)
          ,Has_CI30K =  MAX(CASE WHEN BdmDedCode = 'CI30K' THEN 'Y' END)
      INTO dbo.U_EAFLACCEXP_Bdm_PIVOT
      FROM dbo.U_EAFLACCEXP_BdmConsolidated
     WHERE BdmDedCode IN ('CD10K','CD5K','CI10K','CI20K','CI30K','CIS10','CIS15','CIS5K','CD15K')
     GROUP 
        BY BdmEEID, BdmCOID
    ;
    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EAFLACCEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhLOWAC        = MAX (CASE WHEN PdhDedCode IN ('LOWAC') THEN PdhEECurAmt END)
        ,PdhHIGHA        = MAX (CASE WHEN PdhDedCode IN ('HIGHA') THEN PdhEECurAmt END)
        ,PdhCI10K        = MAX (CASE WHEN PdhDedCode IN ('CI10K') THEN PdhEECurAmt END)
        ,PdhCI20K        = MAX (CASE WHEN PdhDedCode IN ('CI20K') THEN PdhEECurAmt END)
        ,PdhCI30K        = MAX (CASE WHEN PdhDedCode IN ('CI30K') THEN PdhEECurAmt END)
        ,PdhCIS5K        = MAX (CASE WHEN PdhDedCode IN ('CIS5K') THEN PdhEECurAmt END)
        ,PdhCIS10        = MAX( CASE WHEN PdhDedCode IN ('CIS10') THEN PdhEECurAmt END)
        ,PdhCIS15        = MAX(CASE WHEN PdhDedCode IN ('CIS15') THEN PdhEECurAmt END)
        ,PdhCD5K        = MAX(CASE WHEN PdhDedCode IN ('CD5K') THEN PdhEECurAmt END)
        ,PdhCD10K        = MAX(CASE WHEN PdhDedCode IN ('CD10K') THEN PdhEECurAmt END)
        ,PdhCD15K        = MAX(CASE WHEN PdhDedCode IN ('CD15K') THEN PdhEECurAmt END)
        ,PdhHOSPT        =MAX(CASE WHEN PdhDedCode IN ('HOSPT') THEN PdhEECurAmt END)
    INTO dbo.U_EAFLACCEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAFLACCEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EAFLACCEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_PEarHist;
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
    INTO dbo.U_EAFLACCEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    IF OBJECT_ID('U_EAFLACCEXP_BdmConsolidated','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_BdmConsolidated;
    select bdmeeid,
          bdmcoid,
          bdmrectype,
          bdmrelationship,
          bdmdedcode,
          bdmdeprecid,
          bdmbenoption,max(BdmUSGField1) as BdmUSGField1,
          max(bdmBenStartDate) as bdmBenStartDate, 
          max(bdmBenStopDate) as bdmBenStopDate,
          max(bdmbenstatus) as bdmbenstatus
          INTO dbo.U_EAFLACCEXP_BdmConsolidated
          from dbo.U_dsi_BDM_EAFLACCEXP 
        group by bdmeeid,bdmcoid,bdmrectype,bdmrelationship,bdmdedcode,bdmdeprecid,bdmbenoption
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblEmp
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblEmp','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblEmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpRecDisc = 'EMP'
        ,drvEmpRecType = 'A'
        ,drvEmpUnComp = 'CAI'
        ,drvInitialSort = eepSSN
        ,drvSubSort = '2'
        ,drvEmpSSN = eepSSN
        ,drvEmpLastName = EepNameLast + ' ' + ISNULL(EepNameSuffix,'')
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpMiddleName = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvEmpAddressLine1 = EepAddressLine1
        ,drvEmpAddressLine2 = EepAddressLine2
        ,drvEmpAddressLine3 = ''
        ,drvEmpCity = EepAddressCity
        ,drvEmpState = EepAddressState
        ,drvEmpZipCode = EepAddressZipCode
        ,drvEmpGender = EepGender
        ,drvEmpDateofBirth = EepDateOfBirth
        ,drvEmpLocationName = ''
        ,drvEmpTerminationDate = CASE WHEN eecEmplStatus = 'T' THEN eecdateoftermination END
        ,drvEmpDateofHire = EecDateOfLastHire    
        ,drvEmpBenefitEligibleDate = '' --CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire then EecDateOfLastHire Else EecDateOfOriginalHire END
        ,drvEmpHomePhoneNumber = ''--EepPhoneHomeNumber
        ,drvEmpAnnSalary = ''
        ,drvEmpHoursWorkedPerWeek = '20'
        ,drvEmpSalaryMode = 'S'
        ,drvEmpBillingFreq = ''
        ,drvEmpEmployer = 'Community Health'
        ,drvEmpOccupation =  '' --REPLACE(REPLACE((SELECT Top 1JbcDesc FROM JobCode where JbcJobCode = EecJobCode), CHAR(13), ''), CHAR(10), '')
        ,drvEmpHeight = ''
        ,drvEmpWeight = ''
        ,drvEmpResponse = 'Y'
        ,drvEmpEmailAddress = ''
        ,drvEmpGroupNumber = '27751'
    INTO dbo.U_EAFLACCEXP_drvTblEmp
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        AND (EecEmplStatus <> 'T' 
             OR EXISTS (SELECT 1 FROM dbo.U_EAFLACCEXP_Audit WHERE xEEID = AudEEID AND AudFieldName = 'EecDateOfTermination')) 
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (select bdmeeid,bdmcoid,max(bdmbenstartdate ) as bdmbenstartdate from dbo.U_dsi_BDM_EAFLACCEXP WITH (NOLOCK) --Where bdmRecType = 'EMP'
group by bdmeeid,bdmcoid ) as bdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblDep
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblDep','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblDep;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID
        -- standard fields above and additional driver fields below
        ,drvDEPRecDisc = CASE WHEN ConRelationship IN ('SPS','DP') THEN 'SPSE'
                              ELSE 'DPDT'
                         END
        ,drvDepRecType = 'A'
        ,drvInitialSort = eepSSN
        ,drvSubSort = '3'
        ,drvDepSSN = eepSSN
        ,drvDepNameLast = ConNameLast
        ,drvDEPNameFirst = ConNameFirst
        ,drvDepNameMiddle = LEFT(ISNULL(ConNameMiddle,''),1)
        ,drvDepDateofBirth = ConDateOfBirth
        ,drvDepGender = ConGender
        ,drvDepDependentId = ConSSN
        ,drvDepWeight = ''
        ,drvDepHeight = ''
        ,drvDepResponse = CASE WHEN ConRelationship IN ('SPS','DP') THEN 'N'
                              ELSE ''
                         END
        ,drvDepEmailAddress = ''
        ,drvDepGroupNumber = '27751'
    INTO dbo.U_EAFLACCEXP_drvTblDep
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAFLACCEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    Where bdmRecType = 'DEP'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblProd
    ---------------------------------
   
    IF OBJECT_ID('U_EAFLACCEXP_drvTblProd','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblProd;
    SELECT DISTINCT
        drvInitialSort = eepSSN
        ,drvSubSort = '4'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ''
        -- standard fields above and additional driver fields below


        ,drvProdRecDisc = CASE WHEN BdmDedCode IN ('LOWAC','HIGHA') THEN 'ACCD'
                             WHEN BdmDedCode IN ('HOSPT') THEN 'HIPL'
                              WHEN BdmDedCode IN ('CI10K','CI20K','CI30K','CIS5K','CIS10','CIS15','CD5K','CD10K','CD15K') THEN 'CRIT'
                                     

                END 
        ,drvProdRecInd = CASE WHEN bdmRecType = 'EMP' THEN 'EMPL'
                              WHEN bdmRecType = 'DEP' THEN
                                CASE WHEN bdmrelationship IN ('SPS','DP') THEN 'SPSE'
                                    ELSE 'DPDT'
                                END
                         END
        ,drvProdRecType = 'A'
        ,drvProdEmpSSN = eepSSN
        ,drvProdBenAmt = dbo.dsi_fnPadZero(CAST(Isnull(BdmUSGField1,0) as money) ,7,0)   /*CASE WHEN BdmDedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A' )  THEN  dbo.dsi_fnPadZero(CAST(Isnull(BdmUSGField1,0) as money) ,7,0)  
                               WHEN BdmDedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S' )  THEN dbo.dsi_fnPadZero(CAST(Isnull((Select top 1 BdmUSGField1 from dbo.U_EAFLACCEXP_BdmConsolidated A where A.bdmdedcode = bdmdedcode and A.bdmeeid = xeeid and bdmrectype = 'EMP' ),0) as money)  ,7,0)
                              END*/
        ,drvProdBenAmtRaw = CAST(Isnull(BdmUSGField1,0) as money)  /*CASE WHEN BdmDedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A' ) THEN  CAST(Isnull(BdmUSGField1,0) as money) 
                               WHEN BdmDedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S' )  THEN CAST(Isnull((Select top 1 BdmUSGField1 from dbo.U_EAFLACCEXP_BdmConsolidated A where A.bdmdedcode = bdmdedcode and A.bdmeeid = xeeid and bdmrectype = 'EMP' ),0) as money)
                              END*/
        ,drvProdBenPrm =  dbo.dsi_fnPadZero( CASE WHEN ISNULL(bcaeeamt,0.00) = 0.00 THEN 
                                  CASE BdmDedCode 
                                       WHEN 'LOWAC' THEN PdhLOWAC
                                       WHEN 'HIGHA' THEN PdhHIGHA
                                       WHEN 'CI10K' THEN PdhCI10K
                                       WHEN 'CI20K' THEN PdhCI20K
                                       WHEN 'CI30K' THEN PdhCI30K
                                       WHEN 'CIS5K' THEN PdhCIS5K
                                       WHEN 'CIS10' THEN PdhCIS10
                                       WHEN 'CIS15' THEN PdhCIS15
                                       WHEN 'CD5K' THEN PdhCD5K
                                       WHEN 'CD10K' THEN PdhCD10K
                                       WHEN 'CD15K' THEN PdhCD15K
                                       WHEN 'HOSPT' THEN PdhHOSPT
                                 END
                            ELSE bcaeeamt 
                            END *100 , 7,0)
        
                    /*CASE WHEN BdmDedCode IN ('AFLCA') THEN  dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100 , 7,0)
                             WHEN BdmDedCode IN ('AFLCH') THEN dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100, 7,0)
                          END*/ 
                                      
        ,drvProdBenPrmRaw =  CASE WHEN ISNULL(bcaeeamt,0.00) = 0.00 THEN 
                                  CASE BdmDedCode 
                                       WHEN 'LOWAC' THEN PdhLOWAC
                                       WHEN 'HIGHA' THEN PdhHIGHA
                                       WHEN 'CI10K' THEN PdhCI10K
                                       WHEN 'CI20K' THEN PdhCI20K
                                       WHEN 'CI30K' THEN PdhCI30K
                                       WHEN 'CIS5K' THEN PdhCIS5K
                                       WHEN 'CIS10' THEN PdhCIS10
                                       WHEN 'CIS15' THEN PdhCIS15
                                       WHEN 'CD5K' THEN PdhCD5K
                                       WHEN 'CD10K' THEN PdhCD10K
                                       WHEN 'CD15K' THEN PdhCD15K
                                       WHEN 'HOSPT' THEN PdhHOSPT
                                 END
                            ELSE bcaeeamt 
                            END /*CASE WHEN BdmDedCode IN ('AFLCA') THEN   (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) 
                             WHEN BdmDedCode IN ('AFLCH') THEN  (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption)
                          END */

                            /*
                           If EedBenOption = EE or EEPLUS send 1
If EedBenOption = EES or EEDP send 2
If EedBenOption = EEC or EEDPC send 3 
If EedBenOption = EEF, EEDPF or FMPLUS send 4                    
                            */
        ,drvProdCovOption = CASE WHEN bdmBenOption IN ('EE') THEN '1'
                                WHEN bdmBenOption IN ('EES','EEDP') THEN '2'
                                WHEN bdmBenOption IN ('EEC') THEN '3'
                                WHEN bdmBenOption IN ('EEF', 'EEDPF') THEN '4'
                                WHEN COALESCE(Has_CI10K,Has_CI20K,Has_CI30K) = 'Y' AND (COALESCE(Has_CIS5K,Has_CIS10,Has_CIS15,Has_CD5K,Has_CD10K) IS NULL OR Has_CD15K = 'Y') THEN '1'                                 WHEN COALESCE(Has_CI10K, Has_CI20K, Has_CI30K, Has_CIS5K, Has_CIS10, Has_CIS15) = 'Y' AND (COALESCE(Has_CD5K, Has_CD10K) IS NULL OR Has_CD15K = 'Y') THEN '2'                                 WHEN (COALESCE(Has_CI10K, Has_CI20K, Has_CI30K, Has_CD5K, Has_CD10K) = 'Y' OR Has_CD15K = 'Y') AND (COALESCE(Has_CI30K, Has_CIS5K, Has_CIS10) IS NULL OR Has_CIS15 = 'Y') THEN '3'                                 WHEN COALESCE(Has_CI10K,Has_CI20K,Has_CI30K,Has_CIS5K,Has_CIS10,Has_CIS15,Has_CD5K,Has_CD10K, Has_CD15K) = 'Y' THEN '4'
                    END

        ,drvProdCovTier = CASE WHEN BdmDedCode = 'LOWAC' THEN '2'
                               WHEN BdmDedCode = 'HIGHA' THEN '1'
                           END
        ,drvProdApplicationDate = DateAdd(Day,-1,bdmBenStartDate)
        ,drvProdEffectiveDate = bdmBenStartDate
        ,drvProdTerminationDate = CASE WHEN eecemplstatus = 'T' THEN bdmBenStopDate END
        /*
            if eecemplstatus = A send dbnbenstatus = C or T and ConRelationship
                in (SPS, DP, CHL, DPC, STC) send 4
                if eecemplstatus = A send dbnbenstatus = C or T and ConRelationship
                in (SPS, DP) and not (CHL, DPC, STC) send 2

            if eecemplstatus = A send dbnbenstatus = C or T and ConRelationship
                in (CHL, DPC, STC) and not (SPS, DP) send 3 : TODO
        */
        ,drvProdTeminatingCovOption = CASE WHEN eecEmplStatus = 'A' and BdmBenStatus in ('C','T') and bdmrectype = 'DEP' and bdmrelationship = 'SPS' THEN '2'
                                           WHEN eecEmplStatus = 'A' and BdmBenStatus in ('C','T') and bdmrectype = 'DEP' and bdmrelationship = 'CHD' THEN '3'
                                           WHEN eecEmplStatus = 'A' and BdmBenStatus in ('C','T') and bdmrectype = 'DEP' THEN '4'
                                      END
        ,drvProdAddCov = ''
        ,drvProdBenefitChange = ''
        ,drvProdDemoChanges = ''
        ,drvProdEmpStatsChange = ''
        ,drvProdEmplStatChangeReason = ''
        ,drvProdEmpStatusChangeDate = ''
        ,drvProdRollOver = ''
        ,drvProdRollOverBenAmt = ''
        ,drvProdRecordSet = ''
        ,drvProdSection125 = 'N'
        ,drvProdFTPT = CASE WHEN EecFullTimeOrPartTime = 'F' THEN 'FT'
                            WHEN EecFullTimeOrPartTime = 'P' THEN 'PT'
                        END
        ,drvProdHourlySalary = EecSalaryOrHourly
        ,drvProdClassCode = ''
        ,drvProdFirstDeductionDate = ''
        ,drvProdStateofEnrollment = EepAddressState
        ,drvProdAgentName = 'Internet Enrollment'
        ,drvProdAgentNumber = '1000'
        ,drvProdEmpSignatureMethod = '1'
        ,drvProdEnrollmentTypeMethod = '3'
        ,drvProdRider1 = ''
        ,drvProdRider2 = ''
        ,drvProdRider3 = ''
        ,drvProdRider4 = ''
        ,drvProdRider5 = ''
        ,drvProdResponse = ''
        ,drvProdCarriersName = ''
        ,drvProdCertNumber = ''
        ,drvProdHQ1 = '' /*CASE WHEN BdmRecType = 'EMP' THEN EepIsSmoker  
                           WHEN BdmRecType = 'DEP' THEN  (
                                CASE WHEN bdmrelationship = 'SPS' THEN
                                    (Select top 1 conIsSmoker from contacts where conrelationship = 'SPS' and coneeid =  bdmeeid)
                                ELSE 
                                 (Select top 1 conIsSmoker from contacts where conrelationship <> 'SPS' and coneeid =  bdmeeid)
                            END 
                           )
                      END*/
        ,drvProdHQ2 = ''
        ,drvProdHQ3 = ''
        ,drvProdHQ4 = ''
        ,drvProdHQ5 = ''
        ,drvProdHQ6 = ''
        ,drvProdHQ7 = ''
        ,drvProdHQ8 = ''
        ,drvProdHQ9 = ''
        ,drvProdHQ10 = ''
        ,drvProdElimPeriod = ''
        ,drvProdBenPeriod = ''
        ,drvProdOptionalBenefitInd = ''
        ,drvProdDependentId = ConSSN
        ,drvProdRiderIndc = CASE WHEN BdmDedCode  IN ('LOWAC','HIGHA','HOSP') THEN 'N'
                                 ELSE 'Y'
                            END
        ,drvProdPremiumMode ='24'
        ,drvProdUnion = ''
        ,drvProdRollOverCov = ''
        ,drvProdHQ11 = ''
        ,drvProdHQ12 = ''
        ,drvProdHQ12C = ''
        ,drvProdHQ12CP = ''
        ,drvProdHQ12B = ''
        ,drvProdHQ13 = ''
        ,drvProdHQ14 = ''
        ,drvProdHQ15 = ''
        ,drvProdHQ16 = ''
        ,drvProdMinAnnPayQuestion = ''
        ,drvProdWorkCompQuestion = ''
        ,drvProdPriorEffectiveDate = ''
        ,drvProdHQ17 = ''
        ,drvProdHQ18 = ''
        ,drvProdHQ19 = ''
        ,drvProdHQ20 = ''
        /*if edhdedcode = AFACC, AHAL2,
AHAL3, AHALL, AHBA2, AHBA3,
AHBAS, AHEB2, AHEB3, AHEBR,
AHOS1, AHOS2, AHOS3, AHSU2,
AHSU3, AHSUR or XXXX and edhbenstatus = T
and eeddedcode = XXX send Y else send N
        */
        ,drvProdAflacARO = 'N'
        ,drvProdIndPolicyReplace = ''
        ,drvProdTDIQuestion = ''
        ,drvProdGroupNumber = '27751'
        ,drvProdHQ21 = ''
        ,drvProdHQ22 = ''
        ,drvProdHQ23 = ''
        ,drvProdHQ24 = ''
        ,drvProdHQ26 = ''
        ,drvEEDateOfBirth = eepdateofbirth
        ,drvSpDateOfBirth =  case when bdmrelationship in ('SPS') THEN 
                                (Select top 1 condateofbirth from contacts where conrelationship = 'SPS' and coneeid =  bdmeeid)
                             end 
        ,drvEEGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender  
                           WHEN BdmRecType = 'DEP' THEN (
                            CASE WHEN bdmrelationship = 'SPS' THEN
                                    (Select top 1 congender from contacts where conrelationship = 'SPS' and coneeid =  bdmeeid)
                                ELSE 
                                 (Select top 1 congender from contacts where conrelationship <> 'SPS' and coneeid =  bdmeeid)
                            END 
                           )
                      END
        ,drvDedcode = BdmDedCode
    INTO dbo.U_EAFLACCEXP_drvTblProd
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EAFLACCEXP_BdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
   LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
       AND ConSystemID = BdmDepRecID
    JOIN dbo.u_dsi_bdm_BenCalculationAmounts ON bdmeeid = bcaeeid AND bdmcoid = bcacoid
       AND bdmdedcode = bcadedcode 
    LEFT JOIN dbo.U_EAFLACCEXP_Bdm_PIVOT WITH (NOLOCK)
        ON PvtEEID = BdmEEID
       AND PvtCOID = BdmCOID
    LEFT JOIN dbo.U_EAFLACCEXP_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
;
    Delete from dbo.U_EAFLACCEXP_drvTblProd where  drvProdRecDisc is null
    --Delete from dbo.U_EAFLACCEXP_drvTblProd where drvdedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S', 'AF15S' )  and drvProdRecInd = 'EMPL'




    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblBen
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblBen','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblBen;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = '5'
                -- standard fields above and additional driver fields below
        ,drvBenRecordDisc = 'BENE'
        ,drvBenProdInd = CASE WHEN BfpDedCode IN ('LOWAC','HIGHA') THEN 'ACCD' 
                              WHEN BfpDedCode IN ('CI10K','CI20K','CI30K','CIS5K','CIS10','CIS15','CD5K','CD10K','CD15K') THEN 'CRIT'
                              --When BfpDedCode IN ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A',  'AF5S', 'AF7S', 'AF10S', 'AF12S', 'AF15S' ) THEN 'CRIT'
                         END
        ,drvBenRecType = 'A'
        ,drvBenEmpSSN = eepSSN
        ,drvBenFullName = ConNameFirst + ' ' + ConNameLast
        ,drvBenSSN = CASE WHEN ISNULL(ConSSN,'') = '' THEN '0000000000' ELSE CONSSN END
        ,drvBenPercentage = CAST(CONVERT(DECIMAL(3,0),BfpPctToAlloc) as varchar(3))
        ,drvBenRelationship = CASE WHEN ConRelationship in ('BRO') THEN '18'
                                   WHEN ConRelationship in ('SIS') THEN '18'
                                   WHEN ConRelationship in ('DAD') THEN '03'
                                   WHEN ConRelationship in ('EST') THEN '41'
                                   WHEN ConRelationship in ('MOM') THEN '04'
                                   WHEN ConRelationship in ('NIC') THEN '26'
                                   WHEN ConRelationship in ('SIS') THEN '19'
                                   WHEN ConRelationship in ('STF') THEN '14'
                                   WHEN ConRelationship in ('CHL') and ConGender = 'M' THEN '05'
                                   WHEN ConRelationship in ('CHL') and ConGender = 'F' THEN '06'
                                   WHEN ConRelationship in ('GRC') and ConGender = 'M' THEN '07'
                                   WHEN ConRelationship in ('GRC') and ConGender = 'F' THEN '08'
                                   WHEN ConRelationship in ('SPS') and ConGender = 'M' THEN '01'
                                   WHEN ConRelationship in ('SPS') and ConGender = 'F' THEN '02'
                                   WHEN ConRelationship in ('DP') and ConGender = 'M' THEN '21'
                                   WHEN ConRelationship in ('DP') and ConGender = 'F' THEN '20'
                                   WHEN ConRelationship in ('STM')  THEN '15'
                                   WHEN ConRelationship in ('STF')  THEN '14'
                                   WHEN ConRelationship in ('STC') and ConGender = 'M' THEN '11'
                                   WHEN ConRelationship in ('STC') and ConGender = 'F' THEN '12'
                                   WHEN ConRelationship in ('FIA') and ConGender = 'M' THEN '22'
                                   WHEN ConRelationship in ('FIA') and ConGender = 'F' THEN '23'
                                   WHEN ConRelationship in ('PAR')  THEN '10'
                                   WHEN ConRelationship in ('EST')  THEN '41'
                                   WHEN ConRelationship in ('DPC') and ConGender = 'M' THEN '13'
                                   WHEN ConRelationship in ('DPC') and ConGender = 'F' THEN '12'
                                   ELSE '27'
                              END
        ,drvBenGroupNumber = '27751'
    INTO dbo.U_EAFLACCEXP_drvTblBen
    FROM dbo.U_EAFLACCEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.BnfBPlan WITH (NOLOCK)
        ON BfpEEID = xEEID 
     JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
        AND ConSystemID = BfpConRecID
    JOIN dbo.U_EAFLACCEXP_drvTblEmp WITH (NOLOCK)
        ON drvEEID = eepEEID
    WHERE ConIsBeneficiary = 'Y' and bfpdedcode in ('LOWAC','HIGHA','CI10K','CI20K','CI30K','CIS5K','CIS10','CIS15','CD5K','CD10K','CD15K')
    ;

    
    /*Update D set drvProdBenPrm = dbo.dsi_fnPadZero( (CASE WHEN drvProdRecInd = 'EMPL' THEN A.EmpPremAmount ELSE A.SpsPremAmt END) *100,7,0)
FROM U_EAFLACCEXP_drvTblProd D 
JOIN (
select drveeid,
    DateDiff(year,drvSpDateOfBirth,drvProdEffectiveDate) as SpsAge,
    DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) as EmpAge,
    drvProdHQ1,
    EmpPremAmount = ISNULL((CASE WHEN drvProdBenAmtRaw IS NOT NULL THEN (
            CASE WHEN drvProdHQ1 = 'Y' and drvEEGender  = 'M' THEN ( Select Top 1 RatEERateSMMale from InsRate   where RatDedCode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN drvProdHQ1 = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN drvProdHQ1 = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge  and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN drvProdHQ1 = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
            END
    ) 
    END * (drvProdBenAmtRaw / 1000)),0)  ,

     SpsPremAmt = ISNULL((CASE WHEN drvProdBenAmtRaw IS NOT NULL THEN (
            CASE WHEN drvProdHQ1 = 'Y' and drvEEGender  = 'M' THEN ( Select Top 1 RatEERateSMMale from InsRate   where RatDedCode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN drvProdHQ1 = 'Y' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateSMFemale from InsRate   where RatDedCode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN drvProdHQ1 = 'N' and drvEEGender  = 'M' THEN  ( Select Top 1 RatEERateNSMale from InsRate   where RatDedCode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge  and RatPayFreq = 'B' order by RatEffDate desc  )
                 WHEN drvProdHQ1 = 'N' and drvEEGender  = 'F' THEN  ( Select Top 1 RatEERateNSFemale from InsRate   where RatDedCode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S') and  DateDiff(year,drvEEDateOfBirth,drvProdEffectiveDate) BETWEEN RatMinAge and RatMaxAge and RatPayFreq = 'B' order by RatEffDate desc  )
            END
    ) 
    END * (drvProdBenAmtRaw / 1000)),0)   

 from U_EAFLACCEXP_drvTblProd where drvProdRecDisc not IN ('ACCD','HIPL') ) A

  ON A.drveeid = D.drveeid
 and D.drvProdRecDisc not IN('ACCD','HIPL')
 and drvProdBenPrm is  null;
    */
    ---------------------------------
    -- DETAIL RECORD - U_EAFLACCEXP_drvTblMeta
    ---------------------------------
    IF OBJECT_ID('U_EAFLACCEXP_drvTblMeta','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLACCEXP_drvTblMeta;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvInitialSort = '99999999999999'
        ,drvSubSort = '6'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvMetaRecDisc = 'META'
        ,drvMetaGroupNumber = '27751'
        ,drvMetaVendorId = '100055'
        ,drvMetaFileType = 'F'
        ,drvMetaFileStatus = CASE WHEN @ExportCode LIKE 'TEST%' THEN 'T' ELSE 'P' END
        ,drvMetaEnrollmentType = CASE WHEN @ExportCode LIKE 'OE%' THEN 'AE' ELSE 'NH' END
        ,drvMetaFileLayoutVersion = 'CSV2.6'
    INTO dbo.U_EAFLACCEXP_drvTblMeta
 
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
ALTER VIEW dbo.dsi_vwEAFLACCEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAFLACCEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAFLACCEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912051'
       ,expStartPerControl     = '201912051'
       ,expLastEndPerControl   = '201912129'
       ,expEndPerControl       = '201912129'
WHERE expFormatCode = 'EAFLACCEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAFLACCEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAFLACCEXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;