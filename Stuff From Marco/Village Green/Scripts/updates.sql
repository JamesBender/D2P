SET NOCOUNT ON;
IF OBJECT_ID('U_EAFLENREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EAFLENREXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EAFLENREXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEAFLENREXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAFLENREXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAFLENREXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAFLENREXP];
GO
IF OBJECT_ID('U_EAFLENREXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_PEarHist];
GO
IF OBJECT_ID('U_EAFLENREXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_PDedHist];
GO
IF OBJECT_ID('U_EAFLENREXP_File') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_File];
GO
IF OBJECT_ID('U_EAFLENREXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_EEList];
GO
IF OBJECT_ID('U_EAFLENREXP_drvTblProd') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_drvTblProd];
GO
IF OBJECT_ID('U_EAFLENREXP_drvTblMeta') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_drvTblMeta];
GO
IF OBJECT_ID('U_EAFLENREXP_drvTblEmp') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_drvTblEmp];
GO
IF OBJECT_ID('U_EAFLENREXP_drvTblDep') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_drvTblDep];
GO
IF OBJECT_ID('U_EAFLENREXP_drvTblBen') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_drvTblBen];
GO
IF OBJECT_ID('U_EAFLENREXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_DedList];
GO
IF OBJECT_ID('U_EAFLENREXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_BdmConsolidated];
GO
IF OBJECT_ID('U_dsi_BDM_EAFLENREXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAFLENREXP];
GO
IF OBJECT_ID('dboU_EAFLENREXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[dboU_EAFLENREXP_BdmConsolidated];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EAFLENREXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EAFLENREXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EAFLENREXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EAFLENREXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EAFLENREXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAFLENREXP','Aflac Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','EAFLENREXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRecDisc"','1','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpRecType"','2','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpUnComp"','3','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','3',NULL,'Underwriting Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSSN"','4','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','4',NULL,'Employee ID/SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','5','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','5',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','6','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','6',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleName"','7','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','7',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine1"','8','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','8',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine2"','9','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','9',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAddressLine3"','10','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','10',NULL,'Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpCity"','11','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpState"','12','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpZipCode"','13','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','13',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpGender"','14','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','14',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateofBirth"','15','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','10','15',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLocationName"','16','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','16',NULL,'Location Name or Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTerminationDate"','17','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','10','17',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpDateofHire"','18','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','10','18',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBenefitEligibleDate"','19','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','10','19',NULL,'Benefit Eligible Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHomePhoneNumber"','20','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','20',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAnnSalary"','21','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','21',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHoursWorkedPerWeek"','22','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','22',NULL,'Hours Worked per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpSalaryMode"','23','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','23',NULL,'Salary Mode (Pay Frequency)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBillingFreq"','24','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','24',NULL,'EE''s Billing Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmployer"','25','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','25',NULL,'Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpOccupation"','26','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','26',NULL,'Employee''s Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHeight"','27','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','27',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWeight"','28','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','28',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpResponse"','29','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','29',NULL,'Response to EE Actively at Work Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpEmailAddress"','30','(''UA''=''T,'')','EAFLENREXPZ0','50','D','10','30',NULL,'Employee''s Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpGroupNumber"','31','(''UA''=''T'')','EAFLENREXPZ0','50','D','10','31',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPRecDisc"','1','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRecType"','2','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepSSN"','3','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','3',NULL,'Employee SSN/ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameLast"','4','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','4',NULL,'Dependent Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDEPNameFirst"','5','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','5',NULL,'Dependent First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepNameMiddle"','6','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','6',NULL,'Dependent Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDateofBirth"','7','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','20','7',NULL,'Dependent Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGender"','8','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','8',NULL,'Dependent Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDependentId"','9','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','9',NULL,'Dependent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepWeight"','10','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','10',NULL,'Dependent Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepHeight"','11','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','11',NULL,'Dependent Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepResponse"','12','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','12',NULL,'Response to SP Are you now disabled or unable to w',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEmailAddress"','13','(''UA''=''T,'')','EAFLENREXPZ0','50','D','20','13',NULL,'Dependent''s Email address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepGroupNumber"','14','(''UA''=''T'')','EAFLENREXPZ0','50','D','20','14',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecDisc"','1','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecInd"','2','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','2',NULL,'Record Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecType"','3','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','3',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpSSN"','4','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','4',NULL,'Employee SSN/ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenAmt"','5','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','5',NULL,'Benefit Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenPrm"','6','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','6',NULL,'Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCovOption"','7','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','7',NULL,'Coverage Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCovTier"','8','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','8',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdApplicationDate"','9','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','30','9',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEffectiveDate"','10','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','30','10',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdTerminationDate"','11','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','30','11',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdTeminatingCovOption"','12','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','12',NULL,'Verify Terminating Coverage Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAddCov"','13','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','13',NULL,'Change - Adding Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenefitChange"','14','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','14',NULL,'Change - Benefit Changes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdDemoChanges"','15','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','15',NULL,'Change - Demographic Changes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpStatsChange"','16','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','16',NULL,'Change - Employee Status Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmplStatChangeReason"','17','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','17',NULL,'Change - Employee Status Change Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpStatusChangeDate"','18','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','30','18',NULL,'Change - Employee Status Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRollOver"','19','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','19',NULL,'Rollover',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRollOverBenAmt"','20','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','20',NULL,'Rollover Benefit Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRecordSet"','21','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','21',NULL,'Record Set',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdSection125"','22','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','22',NULL,'Section 125',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdFTPT"','23','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','23',NULL,'FT or PT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHourlySalary"','24','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','24',NULL,'Hourly or Salaried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdClassCode"','25','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','25',NULL,'Class Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdFirstDeductionDate"','26','(''UD112''=''T,'')','EAFLENREXPZ0','50','D','30','26',NULL,'First Deduction Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdStateofEnrollment"','27','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','27',NULL,'SOE - State of Enrollment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAgentName"','28','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','28',NULL,'Enrolling Agent Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAgentNumber"','29','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','29',NULL,'Enrolling Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEmpSignatureMethod"','30','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','30',NULL,'Employee Signature Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdEnrollmentTypeMethod"','31','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','31',NULL,'Enrollment Type/Method',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider1"','32','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','32',NULL,'Rider 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider2"','33','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','33',NULL,'Rider 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider3"','34','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','34',NULL,'Rider 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider4"','35','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','35',NULL,'Rider 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRider5"','36','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','36',NULL,'Rider 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdResponse"','37','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','37',NULL,'Response to Replacement Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCarriersName"','38','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','38',NULL,'Prior Carrier''s Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdCertNumber"','39','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','39',NULL,'Prior Carrier''s Certificate Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ1"','40','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','40',NULL,'HQ 1 - TOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ2"','41','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','41',NULL,'HQ 2 - AIDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ3"','42','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','42',NULL,'HQ 3 - CANCER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ4"','43','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','43',NULL,'HQ 4 - MED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ5"','44','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','44',NULL,'HQ 5 - 5 DAYS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ6"','45','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','45',NULL,'HQ 6 - RX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ7"','46','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','46',NULL,'HQ 7 - ALCOHOL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ8"','47','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','47',NULL,'HQ 8 - HOS TREAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ9"','48','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','48',NULL,'HQ 9 - MAJ HLTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ10"','49','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','49',NULL,'HQ 10 - MEDICAID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdElimPeriod"','50','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','50',NULL,'Elimination Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdBenPeriod"','51','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','51',NULL,'Benefit Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdOptionalBenefitInd"','52','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','52',NULL,'Product Optional Benefit Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdDependentId"','53','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','53',NULL,'Dependent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRiderIndc"','54','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','54',NULL,'RIDER Premium Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdPremiumMode"','55','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','55',NULL,'PREMIUM MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdUnion"','56','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','56',NULL,'UNION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdRollOverCov"','57','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','57',NULL,'Roll Over Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ11"','58','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','58',NULL,'HQ 11 - Major Medical',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12"','59','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','59',NULL,'HQ 12 - Other Coverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12C"','60','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','60',NULL,'HQ 12 - Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12CP"','61','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','61',NULL,'HQ 12 - PolicyType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ12B"','62','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','62',NULL,'HQ 12 - Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ13"','63','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','63',NULL,'HQ 13 - Medical Condition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ14"','64','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','64',NULL,'HQ 14 - Vehicle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ15"','65','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','65',NULL,'HQ 15 - Mental',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ16"','66','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','66',NULL,'HQ 16 - Joint',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdMinAnnPayQuestion"','67','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','67',NULL,'Minimum Annual Pay question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdWorkCompQuestion"','68','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','68',NULL,'Workers Compensation Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdPriorEffectiveDate"','69','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','69',NULL,'Prior Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ17"','70','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','70',NULL,'HQ 17 -Comp Health Benefit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ18"','71','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','71',NULL,'HQ 18 -Existing CI Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ19"','72','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','72',NULL,'HQ 19 - Number of CI Policies',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ20"','73','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','73',NULL,'HQ 20 - Medicaid Eligibility',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdAflacARO"','74','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','74',NULL,'Aflac Individual ARO Replacement Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdIndPolicyReplace"','75','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','75',NULL,'Individual Policy being replaced',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdTDIQuestion"','76','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','76',NULL,'TDI States Coverage Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdGroupNumber"','77','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','77',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ21"','78','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','78',NULL,'HQ 21 - Disorder Nerv System',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ22"','79','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','79',NULL,'HQ 22 - Unconsciousness',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ23"','80','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','80',NULL,'HQ 23 - Prog Disease',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ24"','81','(''UA''=''T,'')','EAFLENREXPZ0','50','D','30','81',NULL,'HQ 24 - Results Not Received',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProdHQ26"','82','(''UA''=''T'')','EAFLENREXPZ0','50','D','30','82',NULL,'HQ 25 - Blood Pressure',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRecordDisc"','1','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenProdInd"','2','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','2',NULL,'Product Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRecType"','3','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','3',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEmpSSN"','4','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','4',NULL,'Employee ID/SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenFullName"','5','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','5',NULL,'Beneficiary Full Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenSSN"','6','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','6',NULL,'Beneficiary''s SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenPercentage"','7','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','7',NULL,'Beneficiary''s Percentage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRelationship"','8','(''UA''=''T,'')','EAFLENREXPZ0','50','D','40','8',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenGroupNumber"','9','(''UA''=''T'')','EAFLENREXPZ0','50','D','40','9',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaRecDisc"','1','(''UA''=''T,'')','EAFLENREXPZ0','50','D','50','1',NULL,'Record Discriminator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaGroupNumber"','2','(''UA''=''T,'')','EAFLENREXPZ0','50','D','50','2',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaVendorId"','3','(''UA''=''T,'')','EAFLENREXPZ0','50','D','50','3',NULL,'Vendor ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaFileType"','4','(''UA''=''T,'')','EAFLENREXPZ0','50','D','50','4',NULL,'File Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaFileStatus"','5','(''UA''=''T,'')','EAFLENREXPZ0','50','D','50','5',NULL,'File Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaEnrollmentType"','6','(''UA''=''T,'')','EAFLENREXPZ0','50','D','50','6',NULL,'Enrollment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMetaFileLayoutVersion"','7','(''UA''=''T'')','EAFLENREXPZ0','50','D','50','7',NULL,'File Layout Version',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAFLENREXP_20200514.txt',NULL,'','',NULL,NULL,NULL,NULL,'Aflac Enrollment Export','201912129','EMPEXPORT','ONDEMAND',NULL,'EAFLENREXP',NULL,NULL,NULL,'201912129','Dec 12 2019  3:35PM','Dec 12 2019  3:35PM','201912121',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAFLENREXP_20200514.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201912129','EMPEXPORT','SCHEDULED',NULL,'EAFLENREXP',NULL,NULL,NULL,'201912129','Dec 12 2019  3:35PM','Dec 12 2019  3:35PM','201912121',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAFLENREXP_20200514.txt',NULL,NULL,NULL,',0N6CG',NULL,NULL,NULL,'Passive Open Enrollment Export','202001019','EMPEXPORT','OEPASSIVE',NULL,'EAFLENREXP',NULL,NULL,NULL,'202001019','Dec 12 2019  3:35PM','Dec 12 2019  3:35PM','201912311',NULL,'','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAFLENREXP_20200514.txt',NULL,'','','0N6CG',NULL,NULL,NULL,'Active Open Enrollment Export','201912309','EMPEXPORT','OEACTIVE','Dec 30 2019 12:00AM','EAFLENREXP',NULL,NULL,NULL,'201912309','Dec 30 2019 12:00AM','Dec 30 1899 12:00AM','201912121',NULL,'','','201912121',dbo.fn_GetTimedKey(),NULL,'us3tKiVIL1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EAFLENREXP_20200514.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202005149','EMPEXPORT','TEST','May 14 2020  5:00PM','EAFLENREXP',NULL,NULL,NULL,'202005149','May 14 2020 12:00AM','Dec 30 1899 12:00AM','202004301','779','','','202004301',dbo.fn_GetTimedKey(),NULL,'us3lKiVIL1001',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EAFLENREXP_20200514.txt' END WHERE expFormatCode = 'EAFLENREXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLENREXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLENREXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLENREXP','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLENREXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLENREXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAFLENREXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EAFLENREXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EAFLENREXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EAFLENREXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAFLENREXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLENREXP','D10','dbo.U_EAFLENREXP_drvTblEmp',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLENREXP','D20','dbo.U_EAFLENREXP_drvTblDep',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLENREXP','D30','dbo.U_EAFLENREXP_drvTblProd',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLENREXP','D40','dbo.U_EAFLENREXP_drvTblBen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAFLENREXP','D50','dbo.U_EAFLENREXP_drvTblMeta',NULL);
IF OBJECT_ID('dboU_EAFLENREXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[dboU_EAFLENREXP_BdmConsolidated] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmrelationship] char(3) NULL,
    [bdmdedcode] char(5) NULL,
    [bdmbenoption] char(6) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmBenStartDate] datetime NULL,
    [bdmBenStopDate] datetime NULL
);
IF OBJECT_ID('U_dsi_BDM_EAFLENREXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAFLENREXP] (
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
IF OBJECT_ID('U_EAFLENREXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_BdmConsolidated] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmrelationship] char(3) NULL,
    [bdmdedcode] char(5) NULL,
    [bdmdeprecid] char(12) NULL,
    [bdmbenoption] char(6) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmBenStartDate] datetime NULL,
    [bdmBenStopDate] datetime NULL
);
IF OBJECT_ID('U_EAFLENREXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EAFLENREXP_drvTblBen') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_drvTblBen] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvBenRecordDisc] varchar(4) NOT NULL,
    [drvBenProdInd] varchar(4) NULL,
    [drvBenRecType] varchar(1) NOT NULL,
    [drvBenEmpSSN] char(11) NULL,
    [drvBenFullName] varchar(201) NULL,
    [drvBenSSN] char(11) NULL,
    [drvBenPercentage] varchar(3) NULL,
    [drvBenRelationship] varchar(2) NOT NULL,
    [drvBenGroupNumber] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EAFLENREXP_drvTblDep') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_drvTblDep] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
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
IF OBJECT_ID('U_EAFLENREXP_drvTblEmp') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_drvTblEmp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvEmpRecDisc] varchar(4) NOT NULL,
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
    [drvEmpTerminationDate] varchar(1) NOT NULL,
    [drvEmpDateofHire] datetime NULL,
    [drvEmpBenefitEligibleDate] datetime NULL,
    [drvEmpHomePhoneNumber] varchar(50) NULL,
    [drvEmpAnnSalary] money NULL,
    [drvEmpHoursWorkedPerWeek] varchar(2) NOT NULL,
    [drvEmpSalaryMode] varchar(1) NOT NULL,
    [drvEmpBillingFreq] varchar(1) NOT NULL,
    [drvEmpEmployer] varchar(23) NOT NULL,
    [drvEmpOccupation] varchar(8000) NULL,
    [drvEmpHeight] varchar(1) NOT NULL,
    [drvEmpWeight] varchar(1) NOT NULL,
    [drvEmpResponse] varchar(1) NOT NULL,
    [drvEmpEmailAddress] varchar(50) NULL,
    [drvEmpGroupNumber] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EAFLENREXP_drvTblMeta') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_drvTblMeta] (
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
    [drvMetaEnrollmentType] varchar(1) NOT NULL,
    [drvMetaFileLayoutVersion] varchar(6) NOT NULL
);
IF OBJECT_ID('U_EAFLENREXP_drvTblProd') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_drvTblProd] (
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvProdRecDisc] varchar(4) NULL,
    [drvProdRecInd] varchar(4) NULL,
    [drvProdRecType] varchar(1) NOT NULL,
    [drvProdEmpSSN] char(11) NULL,
    [drvProdBenAmt] varchar(24) NULL,
    [drvProdBenAmtRaw] money NULL,
    [drvProdBenPrm] varchar(24) NULL,
    [drvProdBenPrmRaw] money NULL,
    [drvProdCovOption] varchar(1) NULL,
    [drvProdCovTier] varchar(1) NOT NULL,
    [drvProdApplicationDate] datetime NULL,
    [drvProdEffectiveDate] datetime NULL,
    [drvProdTerminationDate] datetime NULL,
    [drvProdTeminatingCovOption] varchar(1) NOT NULL,
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
    [drvProdFTPT] char(1) NULL,
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
    [drvProdHQ1] varchar(1) NULL,
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
    [drvProdPremiumMode] varchar(2) NULL,
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
    [drvEEGender] char(1) NULL
);
IF OBJECT_ID('U_EAFLENREXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EAFLENREXP_File') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_EAFLENREXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_PDedHist] (
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
IF OBJECT_ID('U_EAFLENREXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EAFLENREXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAFLENREXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Village Green Holding LLC

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 12/12/2019
Service Request Number: TekP -2019-09-19-0001

Purpose: Aflac Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAFLENREXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAFLENREXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAFLENREXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAFLENREXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAFLENREXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLENREXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLENREXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLENREXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAFLENREXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAFLENREXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAFLENREXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAFLENREXP';

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
    DELETE FROM dbo.U_EAFLENREXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAFLENREXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'AFLCA,AFLCH,AF5KA,AF10A,AF15A,AF20A,AF25A,AF30A,AF5S,AF7S,AF10S,AF12S,AF15S ';

    IF OBJECT_ID('U_EAFLENREXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAFLENREXP_DedList
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



      --=====================================================

    -- Update BdmUSGField2 with EmpDedTVID for Employees

    --=====================================================

    UPDATE dbo.U_dsi_bdm_EAFLENREXP

        SET BdmUSGField2 = EedEmpDedTVID

    FROM dbo.U_dsi_bdm_EAFLENREXP

    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)

        ON EedEEID = BdmEEID

        AND EedCOID = BdmCOID

        AND EedDedCode = BdmDedCode

    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';



    --=======================================================

    -- Update BdmUSGField2 with        BPlanTVID for Dependents

    --=======================================================

    UPDATE dbo.U_dsi_bdm_EAFLENREXP

        SET BdmUSGField2 = DbnDepBPlanTVID

    FROM dbo.U_dsi_bdm_EAFLENREXP

    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)

        ON DbnEEID = BdmEEID

        AND DbnCOID = BdmCOID

        AND DbnDedCode = BdmDedCode

    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';



    --======================================================

    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)

    --======================================================

    UPDATE dbo.U_dsi_bdm_EAFLENREXP

        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)

    FROM dbo.U_dsi_bdm_EAFLENREXP

    JOIN dbo.EmpDedFull WITH (NOLOCK)

        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EAFLENREXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_PDedHist;
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
    INTO dbo.U_EAFLENREXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EAFLENREXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EAFLENREXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_PEarHist;
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
    INTO dbo.U_EAFLENREXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    IF OBJECT_ID('U_EAFLENREXP_BdmConsolidated','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_BdmConsolidated;
    select bdmeeid,
          bdmcoid,
          bdmrectype,
          bdmrelationship,
          bdmdedcode,
          bdmdeprecid,
          bdmbenoption,max(BdmUSGField1) as BdmUSGField1,
          max(bdmBenStartDate) as bdmBenStartDate, 
          max(bdmBenStopDate) as bdmBenStopDate 
          INTO dbo.U_EAFLENREXP_BdmConsolidated
          from dbo.U_dsi_BDM_EAFLENREXP 
        group by bdmeeid,bdmcoid,bdmrectype,bdmrelationship,bdmdedcode,bdmdeprecid,bdmbenoption
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EAFLENREXP_drvTblEmp
    ---------------------------------
    IF OBJECT_ID('U_EAFLENREXP_drvTblEmp','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_drvTblEmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvEmpRecDisc = 'EMPL'
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
        ,drvEmpTerminationDate = ''
        ,drvEmpDateofHire = EecDateOfOriginalHire 
        ,drvEmpBenefitEligibleDate = bdmBenStartDate --CASE WHEN EecDateOfLastHire <> EecDateOfOriginalHire then EecDateOfLastHire Else EecDateOfOriginalHire END
        ,drvEmpHomePhoneNumber = EepPhoneHomeNumber
        ,drvEmpAnnSalary = EecAnnSalary
        ,drvEmpHoursWorkedPerWeek = '30'
        ,drvEmpSalaryMode = 'A'

        ,drvEmpBillingFreq = ''
        ,drvEmpEmployer = 'Village Green Companies'
        ,drvEmpOccupation =  REPLACE(REPLACE((SELECT Top 1JbcDesc FROM JobCode where JbcJobCode = EecJobCode), CHAR(13), ''), CHAR(10), '')
        ,drvEmpHeight = ''
        ,drvEmpWeight = ''
        ,drvEmpResponse = 'Y'
        ,drvEmpEmailAddress = EepAddressEMail
        ,drvEmpGroupNumber = '17179'
    INTO dbo.U_EAFLENREXP_drvTblEmp
    FROM dbo.U_EAFLENREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (select bdmeeid,bdmcoid,max(bdmbenstartdate ) as bdmbenstartdate from dbo.U_dsi_BDM_EAFLENREXP WITH (NOLOCK) Where bdmRecType = 'EMP'
group by bdmeeid,bdmcoid ) as bdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
  
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAFLENREXP_drvTblDep
    ---------------------------------
    IF OBJECT_ID('U_EAFLENREXP_drvTblDep','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_drvTblDep;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
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
        ,drvDepGroupNumber = '17179'
    INTO dbo.U_EAFLENREXP_drvTblDep
    FROM dbo.U_EAFLENREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAFLENREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    Where bdmRecType = 'DEP'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EAFLENREXP_drvTblProd
    ---------------------------------
   
    IF OBJECT_ID('U_EAFLENREXP_drvTblProd','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_drvTblProd;
    SELECT DISTINCT
        drvInitialSort = eepSSN
        ,drvSubSort = '4'
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvProdRecDisc = CASE WHEN BdmDedCode IN ('AFLCA') THEN 'ACCD'
                             WHEN BdmDedCode IN ('AFLCH') THEN 'HIPL'
                              WHEN BdmDedCode IN ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A') and bdmrectype = 'EMP' THEN 'CRIT'
                                      WHEN BdmDedCode IN ('AF5S', 'AF7S', 'AF10S', 'AF12S', 'AF15S' ) and bdmrectype = 'DEP' THEN 'CRIT'

                END 
        ,drvProdRecInd = CASE WHEN bdmRecType = 'EMP' THEN 'EMPL'
                              WHEN bdmRecType = 'DEP' THEN
                                CASE WHEN bdmrelationship IN ('SPS') THEN 'SPSE'
                                    ELSE 'DPDT'
                                END
                         END
        ,drvProdRecType = 'A'
        ,drvProdEmpSSN = eepSSN
        ,drvProdBenAmt = CASE WHEN BdmDedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A' )  THEN  dbo.dsi_fnPadZero(CAST(Isnull(BdmUSGField1,0) as money) ,7,0)  
                               WHEN BdmDedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S' )  THEN dbo.dsi_fnPadZero(CAST(Isnull((Select top 1 BdmUSGField1 from dbo.U_EAFLENREXP_BdmConsolidated A where A.bdmdedcode = bdmdedcode and A.bdmeeid = xeeid and bdmrectype = 'EMP' ),0) as money)  ,7,0)
                              END
        ,drvProdBenAmtRaw = CASE WHEN BdmDedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A' ) THEN  CAST(Isnull(BdmUSGField1,0) as money) 
                               WHEN BdmDedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S',  'AF15S' )  THEN CAST(Isnull((Select top 1 BdmUSGField1 from dbo.U_EAFLENREXP_BdmConsolidated A where A.bdmdedcode = bdmdedcode and A.bdmeeid = xeeid and bdmrectype = 'EMP' ),0) as money)
                              END
        ,drvProdBenPrm =  CASE WHEN BdmDedCode IN ('AFLCA') THEN  dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100 , 7,0)
                             WHEN BdmDedCode IN ('AFLCH') THEN dbo.dsi_fnPadZero( (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) * 100, 7,0)
                          END 
                                      
        ,drvProdBenPrmRaw =  CASE WHEN BdmDedCode IN ('AFLCA') THEN   (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption) 
                             WHEN BdmDedCode IN ('AFLCH') THEN  (Select top 1 CorEERate from OptRate where CorDedCode = BdmDedCode and corpayfreq in (SELECT top 1 PgrPayFrequency from PayGroup where PgrPayGroup = EecPayGroup) and CorBenOption = bdmbenoption)
                          END 

        /*
        If EedBenOption is EE send 1, 
EES send 2
If EEC send 3 or EEF send 4
If eeddedcode is AF5KA, AF10A, AF15A, AF20A, AF25A or AF30A send 1
If eeddedcode is AF5S, AF7S, AF10S, AF12S or AF15S send 2                    
        */
        ,drvProdCovOption = CASE WHEN bdmBenOption IN ('EE') THEN '1'
                                WHEN bdmBenOption IN ('EES') THEN '2'
                                WHEN bdmBenOption IN ('EEC') THEN '3'
                                WHEN bdmBenOption IN ('EEF') THEN '4'
                                WHEN BdmDedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A' , 'AF30A') THEN '1'
                                WHEN BdmDedcode in ('AF5S', 'AF7S', 'AF10S', 'AF12S' , 'AF15S') THEN '2'

                    END 
        ,drvProdCovTier = ''
        ,drvProdApplicationDate = bdmBenStartDate
        ,drvProdEffectiveDate = bdmBenStartDate
        ,drvProdTerminationDate = bdmBenStopDate
        ,drvProdTeminatingCovOption = ''
        ,drvProdAddCov = ''
        ,drvProdBenefitChange = ''
        ,drvProdDemoChanges = ''
        ,drvProdEmpStatsChange = ''
        ,drvProdEmplStatChangeReason = ''
        ,drvProdEmpStatusChangeDate = ''
        ,drvProdRollOver = ''
        ,drvProdRollOverBenAmt = ''
        ,drvProdRecordSet = ''
        ,drvProdSection125 = case when bdmdedcode in  ('AFLCH','AFLCA') THEN 'Y' ELSE 'N' END 
        ,drvProdFTPT = EecFullTimeOrPartTime
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
        ,drvProdHQ1 = EepIsSmoker /*CASE WHEN BdmRecType = 'EMP' THEN EepIsSmoker  
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
        ,drvProdDependentId = CASE WHEN BdmRecType = 'DEP' THEN  conssn
                                  Else eepssn
                                END

        ,drvProdRiderIndc = CASE WHEN BdmDedCode  IN ('AFLCA','AFLCH') THEN 'Y'
                                 ELSE 'N'
                            END
        ,drvProdPremiumMode = CASE WHEN EecPayPeriod = 'B' THEN '26'
                                WHEN EecPayPeriod = 'W' THEN '52'
                                WHEN EecPayPeriod = 'S' THEN '24'
                                WHEN EecPayPeriod = 'M' THEN '12'
                            END
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
        ,drvProdAflacARO = 'N'
        ,drvProdIndPolicyReplace = ''
        ,drvProdTDIQuestion = ''
        ,drvProdGroupNumber = '17179'
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

    INTO dbo.U_EAFLENREXP_drvTblProd
    FROM dbo.U_EAFLENREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EAFLENREXP_BdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
      LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    Delete from dbo.U_EAFLENREXP_drvTblProd where  drvProdRecDisc is null




    ---------------------------------
    -- DETAIL RECORD - U_EAFLENREXP_drvTblBen
    ---------------------------------
    IF OBJECT_ID('U_EAFLENREXP_drvTblBen','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_drvTblBen;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        ,drvSubSort = '5'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvBenRecordDisc = 'BENE'
        ,drvBenProdInd = CASE WHEN BdmDedCode IN ('AFLCA') THEN 'ACCD' 
                              When BdmDedCode IN ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A',  'AF5S', 'AF7S', 'AF10S', 'AF12S', 'AF15S' ) THEN 'CRIT'
                         END
        ,drvBenRecType = 'A'
        ,drvBenEmpSSN = eepSSN
        ,drvBenFullName = ConNameFirst + ' ' + ConNameLast
        ,drvBenSSN = ConSSN
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
        ,drvBenGroupNumber = '17179'
    INTO dbo.U_EAFLENREXP_drvTblBen
    FROM dbo.U_EAFLENREXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EAFLENREXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
        JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    LEFT JOIN dbo.BnfBPlan WITH (NOLOCK)
        on BfpEEID = XEEID
        and BfpConRecID = BdmDepRecID
        and bfpdedcode =  bdmdedcode
    WHERE ConIsBeneficiary = 'Y' and bdmdedcode in ('AF5KA', 'AF10A', 'AF15A', 'AF20A', 'AF25A', 'AF30A',  'AF5S', 'AF7S', 'AF10S', 'AF12S', 'AF15S','AFLCA' )
    ;

    
    Update D set drvProdBenPrm = dbo.dsi_fnPadZero( (CASE WHEN drvProdRecInd = 'EMPL' THEN A.EmpPremAmount ELSE A.SpsPremAmt END) *100,7,0)
FROM U_EAFLENREXP_drvTblProd D 
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

 from U_EAFLENREXP_drvTblProd where drvProdRecDisc not IN ('ACCD','HIPL') ) A

  ON A.drveeid = D.drveeid
 and D.drvProdRecDisc not IN('ACCD','HIPL')
 and drvProdBenPrm is  null;
    
    ---------------------------------
    -- DETAIL RECORD - U_EAFLENREXP_drvTblMeta
    ---------------------------------
    IF OBJECT_ID('U_EAFLENREXP_drvTblMeta','U') IS NOT NULL
        DROP TABLE dbo.U_EAFLENREXP_drvTblMeta;
    SELECT DISTINCT
         drvEEID = ''
        ,drvCoID = ''
        ,drvInitialSort = '99999999999999'
        ,drvSubSort = '6'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvMetaRecDisc = 'META'
        ,drvMetaGroupNumber = '17179'
        ,drvMetaVendorId = '100055'
        ,drvMetaFileType = 'F'
        ,drvMetaFileStatus = 'T'
        ,drvMetaEnrollmentType = ''
        ,drvMetaFileLayoutVersion = 'CSV2.6'
    INTO dbo.U_EAFLENREXP_drvTblMeta
 
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
ALTER VIEW dbo.dsi_vwEAFLENREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAFLENREXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAFLENREXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912051'
       ,expStartPerControl     = '201912051'
       ,expLastEndPerControl   = '201912129'
       ,expEndPerControl       = '201912129'
WHERE expFormatCode = 'EAFLENREXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAFLENREXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAFLENREXP_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;