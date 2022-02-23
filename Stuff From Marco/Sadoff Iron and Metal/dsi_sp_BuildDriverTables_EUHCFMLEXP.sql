SET NOCOUNT ON;
IF OBJECT_ID('U_EUHCFMLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUHCFMLEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUHCFMLEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUHCFMLEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUHCFMLEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUHCFMLEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFMLEXP];
GO
IF OBJECT_ID('U_EUHCFMLEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_PEarHist];
GO
IF OBJECT_ID('U_EUHCFMLEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_PDedHist];
GO
IF OBJECT_ID('U_EUHCFMLEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_File];
GO
IF OBJECT_ID('U_EUHCFMLEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_EEList];
GO
IF OBJECT_ID('U_EUHCFMLEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_drvTbl];
GO
IF OBJECT_ID('U_EUHCFMLEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_DedList];
GO
IF OBJECT_ID('U_EUHCFMLEXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_BdmConsolidated];
GO
IF OBJECT_ID('U_dsi_BDM_EUHCFMLEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EUHCFMLEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUHCFMLEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUHCFMLEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUHCFMLEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUHCFMLEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUHCFMLEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUHCFMLEXP','UHC FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EUHCFMLEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNofClaimant"','1','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','1',NULL,'SSNofClaimant',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNofEmployee"','2','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','2',NULL,'SSNofEmployee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimantLastName"','3','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','3',NULL,'ClaimantLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimantFirstName"','4','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','4',NULL,'ClaimantFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClaimantMiddleName"','5','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','5',NULL,'ClaimantMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','6','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','6',NULL,'EmployeeLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','7','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','7',NULL,'EmployeeFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMiddleName"','8','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','8',NULL,'EmployeeMiddleName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingAddress1"','9','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','9',NULL,'MailingAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMailingAddress2"','10','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','10',NULL,'MailingAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','13','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','14','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','14',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','15',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','16','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','16',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectivedateofCoverage"','17','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','17',NULL,'EffectivedateofCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageAmount"','18','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','18',NULL,'CoverageAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanCode"','19','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','19',NULL,'PlanCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','20','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','20',NULL,'HireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','21','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','21',NULL,'WorkState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeeklyWorkHours"','22','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','22',NULL,'WeeklyWorkHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','23','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','23',NULL,'EmploymentStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','24','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','24',NULL,'TerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','25','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','25',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollPeriod"','26','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','26',NULL,'PayrollPeriod',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFTPTIndicator"','27','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','27',NULL,'FT/PTIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualHours"','28','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','28',NULL,'AnnualHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','29','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','29',NULL,'JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','30','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','30',NULL,'JobCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExemptStatus"','31','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','31',NULL,'ExemptStatus',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployersDepartment"','32','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','32',NULL,'EmployersDepartment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','33','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','33',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCostCenterCode"','34','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','34',NULL,'CostCenterCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','35','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','35',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBuildingCode"','36','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','36',NULL,'BuildingCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGeneralLegerCode"','37','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','37',NULL,'GeneralLegerCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganizationLevel1"','38','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','38',NULL,'OrganizationLevel1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganizationLevel2"','39','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','39',NULL,'OrganizationLevel2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganizationLevel3"','40','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','40',NULL,'OrganizationLevel3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayRate"','41','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','41',NULL,'PayRate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','42','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','42',NULL,'AnnualSalary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorLastName"','43','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','43',NULL,'SupervisorLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorFirstName"','44','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','44',NULL,'SupervisorFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmail"','45','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','45',NULL,'SupervisorEmail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEEIdentifier"','46','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','46',NULL,'SupervisorEEIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorIdentifierCode"','47','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','47',NULL,'SupervisorIdentifierCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepEEIdentifier"','48','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','48',NULL,'HRRepEEIdentifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepEEIdentifierCode"','49','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','49',NULL,'HRRepEEIdentifierCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepLastName"','50','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','50',NULL,'HRRepLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepFirstName"','51','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','51',NULL,'HRRepFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepEmailAddress"','52','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','52',NULL,'HRRepEmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','53','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','53',NULL,'RehireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayCycle"','54','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','54',NULL,'PayCycle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilityPlanCode"','55','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','55',NULL,'DisabilityPlanCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerName"','56','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','56',NULL,'EmployerName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvdrvBlankField"','57','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','57',NULL,'drvBlankField',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDateofCoverageAPP"','58','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','58',NULL,'EffectiveDateofCoverageAPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDateTermCIPP"','59','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','59',NULL,'EffectiveDateTermCIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDateTermAPP"','60','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','60',NULL,'EffectiveDateTermAPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorEffDateofCoverageCIPP"','61','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','61',NULL,'PriorEffectiveDateofCoverageCIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorEffEndDateofCovCIPP"','62','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','62',NULL,'PriorEffectiveEndDateofCoverageCIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorCoverageAmountCIPP"','63','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','63',NULL,'PriorCoverageAmountCIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrior2EffDateofCovCIPP"','64','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','64',NULL,'Prior2EffectiveDateofCoverageCIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorEffEndDateofCov2CIPP"','65','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','65',NULL,'PriorEffectiveEndDateofCoverage2CIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrior2CoverageAmount"','66','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','66',NULL,'Prior2CoverageAmount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDateofCoverage2"','67','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','67',NULL,'EffectiveDateofCoverage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanSelectionHIPP"','68','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','68',NULL,'PlanSelectionHIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOption"','69','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','69',NULL,'Option',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateofCovTerm"','70','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','70',NULL,'EffectiveDateofCoverageTerm',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorEffectiveDateHIPP"','71','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','71',NULL,'PriorEffectiveDateHIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorEffEndDateofCovHIPP"','72','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','72',NULL,'PriorEffectiveEndDateofCoverageHIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorPlanSelectionHIPP"','73','(''UA''=''T|'')','EUHCFMLEXPZ0','50','D','10','73',NULL,'PriorPlanSelectionHIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrior2EffDateofCovHIPP"','74','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','74',NULL,'Prior2EffectiveDateofCoverageHIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorEffEndDateofCov2HIPP"','75','(''UD101''=''T|'')','EUHCFMLEXPZ0','50','D','10','75',NULL,'PriorEffectiveEndDateofCoverage2HIPP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrior2PlanSelectionHIPP"','76','(''UA''=''T'')','EUHCFMLEXPZ0','50','D','10','76',NULL,'Prior2PlanSelectionHIPP',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUHCFMLEXP_20200901.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC FMLA Export','202008289','EMPEXPORT','ONDEM_XOE',NULL,'EUHCFMLEXP',NULL,NULL,NULL,'202008289','Aug 28 2020 12:17PM','Aug 28 2020 12:17PM','202008281',NULL,'','','202008281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUHCFMLEXP_20200901.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC FMLA Export-Sched','202008289','EMPEXPORT','SCH_EUHCFM',NULL,'EUHCFMLEXP',NULL,NULL,NULL,'202008289','Aug 28 2020 12:17PM','Aug 28 2020 12:17PM','202008281',NULL,'','','202008281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUHCFMLEXP_20200901.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202008289','EMPEXPORT','OEACTIVE',NULL,'EUHCFMLEXP',NULL,NULL,NULL,'202008289','Aug 28 2020 12:17PM','Aug 28 2020 12:17PM','202008281',NULL,'','','202008281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUHCFMLEXP_20200901.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202008289','EMPEXPORT','OEPASSIVE',NULL,'EUHCFMLEXP',NULL,NULL,NULL,'202008289','Aug 28 2020 12:17PM','Aug 28 2020 12:17PM','202008281',NULL,'','','202008281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EUHCFMLEXP_20200901.txt',NULL,'','','',NULL,NULL,NULL,'UHC FMLA Export-Test','202008319','EMPEXPORT','TEST_XOE','Sep  1 2020 12:05PM','EUHCFMLEXP',NULL,NULL,NULL,'202008319','Aug 31 2020 12:00AM','Dec 30 1899 12:00AM','202008011','144','','','202008011',dbo.fn_GetTimedKey(),NULL,'us3mLaSAD1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EUHCFMLEXP_20200901.txt' END WHERE expFormatCode = 'EUHCFMLEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFMLEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFMLEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFMLEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFMLEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFMLEXP','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFMLEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCFMLEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EUHCFMLEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUHCFMLEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EUHCFMLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCFMLEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCFMLEXP','D10','dbo.U_EUHCFMLEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EUHCFMLEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EUHCFMLEXP] (
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
IF OBJECT_ID('U_EUHCFMLEXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[U_EUHCFMLEXP_BdmConsolidated] (
    [bdmrectype] varchar(3) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmeeid] char(12) NOT NULL,
    [bdmdeprecid] char(12) NULL,
    [bdmrelationship] char(3) NULL,
    [VACC] char(5) NULL,
    [VACC_StartDate] datetime NULL,
    [VACC_StopDate] datetime NULL,
    [ILE10] char(5) NULL,
    [ILE10_StartDate] datetime NULL,
    [ILE10_Amount] varchar(256) NULL,
    [ILE10_StopDate] datetime NULL,
    [ILE20] char(5) NULL,
    [ILE20_StartDate] datetime NULL,
    [ILE20_StopDate] datetime NULL,
    [ILE20_Amount] varchar(256) NULL,
    [ILCH] char(5) NULL,
    [ILCH_StartDate] datetime NULL,
    [ILCH_StopDate] datetime NULL,
    [ILCH_Amount] varchar(256) NULL,
    [ILS10] char(5) NULL,
    [ILS10_StartDate] datetime NULL,
    [ILS10_StopDate] datetime NULL,
    [ILS10_Amount] varchar(256) NULL,
    [ILS5] char(5) NULL,
    [ILS5_StartDate] datetime NULL,
    [ILS5_StopDate] datetime NULL,
    [ILS5_Amount] varchar(256) NULL
);
IF OBJECT_ID('U_EUHCFMLEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EUHCFMLEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EUHCFMLEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EUHCFMLEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvSSNofClaimant] char(11) NULL,
    [drvSSNofEmployee] char(11) NULL,
    [drvClaimantLastName] varchar(100) NULL,
    [drvClaimantFirstName] varchar(100) NULL,
    [drvClaimantMiddleName] varchar(1) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(1) NULL,
    [drvMailingAddress1] varchar(255) NULL,
    [drvMailingAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvDOB] datetime NULL,
    [drvEffectivedateofCoverage] datetime NULL,
    [drvCoverageAmount] varchar(256) NULL,
    [drvPlanCode] varchar(6) NULL,
    [drvHireDate] datetime NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWeeklyWorkHours] varchar(12) NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvEmail] varchar(50) NULL,
    [drvPayrollPeriod] varchar(1) NOT NULL,
    [drvFTPTIndicator] varchar(2) NULL,
    [drvAnnualHours] varchar(12) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvJobCode] char(8) NULL,
    [drvExemptStatus] varchar(1) NOT NULL,
    [drvEmployersDepartment] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvCostCenterCode] varchar(1) NOT NULL,
    [drvLocation] char(6) NULL,
    [drvBuildingCode] varchar(1) NOT NULL,
    [drvGeneralLegerCode] varchar(1) NOT NULL,
    [drvOrganizationLevel1] varchar(1) NOT NULL,
    [drvOrganizationLevel2] varchar(1) NOT NULL,
    [drvOrganizationLevel3] varchar(1) NOT NULL,
    [drvPayRate] varchar(12) NULL,
    [drvAnnualSalary] varchar(12) NULL,
    [drvSupervisorLastName] varchar(1) NOT NULL,
    [drvSupervisorFirstName] varchar(1) NOT NULL,
    [drvSupervisorEmail] varchar(1) NOT NULL,
    [drvSupervisorEEIdentifier] varchar(1) NOT NULL,
    [drvSupervisorIdentifierCode] varchar(1) NOT NULL,
    [drvHRRepEEIdentifier] varchar(1) NOT NULL,
    [drvHRRepEEIdentifierCode] varchar(1) NOT NULL,
    [drvHRRepLastName] varchar(1) NOT NULL,
    [drvHRRepFirstName] varchar(1) NOT NULL,
    [drvHRRepEmailAddress] varchar(1) NOT NULL,
    [drvRehireDate] datetime NULL,
    [drvPayCycle] varchar(2) NULL,
    [drvDisabilityPlanCode] varchar(1) NOT NULL,
    [drvEmployerName] varchar(27) NOT NULL,
    [drvdrvBlankField] varchar(1) NOT NULL,
    [drvEffectiveDateofCoverageAPP] datetime NULL,
    [drvEffectiveDateTermCIPP] datetime NULL,
    [drvEffectiveDateTermAPP] datetime NULL,
    [drvPriorEffDateofCoverageCIPP] varchar(1) NOT NULL,
    [drvPriorEffEndDateofCovCIPP] varchar(1) NOT NULL,
    [drvPriorCoverageAmountCIPP] varchar(1) NOT NULL,
    [drvPrior2EffDateofCovCIPP] varchar(1) NOT NULL,
    [drvPriorEffEndDateofCov2CIPP] varchar(1) NOT NULL,
    [drvPrior2CoverageAmount] varchar(1) NOT NULL,
    [drvEffectiveDateofCoverage2] varchar(1) NOT NULL,
    [drvPlanSelectionHIPP] varchar(1) NOT NULL,
    [drvOption] varchar(1) NOT NULL,
    [drvEffDateofCovTerm] varchar(1) NOT NULL,
    [drvPriorEffectiveDateHIPP] varchar(1) NOT NULL,
    [drvPriorEffEndDateofCovHIPP] varchar(1) NOT NULL,
    [drvPriorPlanSelectionHIPP] varchar(1) NOT NULL,
    [drvPrior2EffDateofCovHIPP] varchar(1) NOT NULL,
    [drvPriorEffEndDateofCov2HIPP] varchar(1) NOT NULL,
    [drvPrior2PlanSelectionHIPP] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EUHCFMLEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EUHCFMLEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUHCFMLEXP_File') IS NULL
CREATE TABLE [dbo].[U_EUHCFMLEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EUHCFMLEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EUHCFMLEXP_PDedHist] (
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
IF OBJECT_ID('U_EUHCFMLEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EUHCFMLEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCFMLEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Sadoff Iron & Metal Company

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 08/28/2020
Service Request Number: TekP-2020-07-08-0001

Purpose: UHC FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCFMLEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCFMLEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCFMLEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EUHCFMLEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUHCFMLEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFMLEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFMLEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFMLEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFMLEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCFMLEXP', 'SCH_EUHCFM';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUHCFMLEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUHCFMLEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EUHCFMLEXP';

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
    DELETE FROM dbo.U_EUHCFMLEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUHCFMLEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ILCH,ILE10,ILE20,ILS10,ILS5,VACC';

    IF OBJECT_ID('U_EUHCFMLEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFMLEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EUHCFMLEXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');


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
    IF OBJECT_ID('U_EUHCFMLEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFMLEXP_PDedHist;
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
    INTO dbo.U_EUHCFMLEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EUHCFMLEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUHCFMLEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFMLEXP_PEarHist;
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
    INTO dbo.U_EUHCFMLEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EUHCFMLEXP D
    JOIN dbo.U_dsi_bdm_EUHCFMLEXP E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EUHCFMLEXP
        SET BdmUSGField2 = EedEmpDedTVID
        ,BdmUSGField1 = CONVERT(VARCHAR(20),dedeebenamt)
    FROM dbo.U_dsi_bdm_EUHCFMLEXP
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EUHCFMLEXP
        SET BdmUSGField2 = DbnDepBPlanTVID
        ,BdmUSGField1 = CONVERT(VARCHAR(20),dedeebenamt)
    FROM dbo.U_dsi_bdm_EUHCFMLEXP
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================



     IF OBJECT_ID('U_EUHCFMLEXP_BdmConsolidated','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFMLEXP_BdmConsolidated;
    Select bdmrectype,bdmcoid,bdmeeid,bdmdeprecid,bdmrelationship
       ,VACC = MAX((CASE WHEN BDMDedCode = 'VACC' then BDMDedCode END)) 
       ,VACC_StartDate = MAX((CASE WHEN BDMDedCode = 'VACC' then bdmbenstartdate END)) 
        ,VACC_StopDate = MAX((CASE WHEN BDMDedCode = 'VACC' then bdmbenstopdate END)) 
      ,ILE10  = MAX((CASE WHEN BDMDedCode = 'ILE10' then BDMDedCode END)) 
      ,ILE10_StartDate = MAX((CASE WHEN BDMDedCode = 'ILE10' then bdmbenstartdate END)) 
      ,ILE10_Amount = MAX((CASE WHEN BDMDedCode = 'ILE10' then bdmUsgfield1 END)) 
      ,ILE10_StopDate = MAX((CASE WHEN BDMDedCode = 'ILE10' then bdmbenstopdate END)) 
      ,ILE20  = MAX((CASE WHEN BDMDedCode = 'ILE20' then BDMDedCode END)) 
      ,ILE20_StartDate = MAX((CASE WHEN BDMDedCode = 'ILE20' then bdmbenstartdate END)) 
      ,ILE20_StopDate = MAX((CASE WHEN BDMDedCode = 'ILE20' then bdmbenstopdate END)) 
      ,ILE20_Amount = MAX((CASE WHEN BDMDedCode = 'ILE20' then bdmUsgfield1 END)) 

      ,ILCH  = MAX((CASE WHEN BDMDedCode = 'ILCH' then BDMDedCode END)) 
      ,ILCH_StartDate = MAX((CASE WHEN BDMDedCode = 'ILCH' then bdmbenstartdate END)) 
      ,ILCH_StopDate = MAX((CASE WHEN BDMDedCode = 'ILCH' then bdmbenstopdate END)) 
      ,ILCH_Amount = MAX((CASE WHEN BDMDedCode = 'ILCH' then bdmUsgfield1 END))

      ,ILS10  = MAX((CASE WHEN BDMDedCode = 'ILS10' then BDMDedCode END)) 
      ,ILS10_StartDate = MAX((CASE WHEN BDMDedCode = 'ILS10' then bdmbenstartdate END)) 
      ,ILS10_StopDate = MAX((CASE WHEN BDMDedCode = 'ILS10' then bdmbenstopdate END)) 

      ,ILS10_Amount = MAX((CASE WHEN BDMDedCode = 'ILS10' then bdmUsgfield1 END))
      ,ILS5  = MAX((CASE WHEN BDMDedCode = 'ILS5' then BDMDedCode END)) 
      ,ILS5_StartDate = MAX((CASE WHEN BDMDedCode = 'ILS5' then bdmbenstartdate END)) 
      ,ILS5_StopDate = MAX((CASE WHEN BDMDedCode = 'ILS5' then bdmbenstopdate END)) 

      ,ILS5_Amount = MAX((CASE WHEN BDMDedCode = 'ILS5' then bdmUsgfield1 END)) 
       INTO dbo.U_EUHCFMLEXP_BdmConsolidated
       from dbo.U_dsi_BDM_EUHCFMLEXP
       
    group by bdmrectype,bdmcoid,bdmeeid,bdmdeprecid,bdmrelationship

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EUHCFMLEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EUHCFMLEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCFMLEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSSNofClaimant = CASE WHEN bdmrectype = 'EMP' THEN eepssn else conssn END
        ,drvSSNofEmployee = eepssn
        ,drvClaimantLastName = LTRIM(CASE WHEN bdmrectype = 'EMP' THEN EepNameLast else ConNameLast END)
        ,drvClaimantFirstName =  LTRIM(CASE WHEN bdmrectype = 'EMP' THEN EepNameFirst ELSE ConNameFirst END)
        ,drvClaimantMiddleName = CASE WHEN bdmrectype = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle,1) END 
        ,drvEmployeeLastName = LTRIM(EepNameLast)
        ,drvEmployeeFirstName = LTRIM(EepNameFirst)
        ,drvEmployeeMiddleName = LTRIM(LEFT(ISNULL(EepNameMiddle,''),1))
        ,drvMailingAddress1 = EepAddressLine1
        ,drvMailingAddress2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = Eepaddresszipcode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvGender = CASE WHEN bdmrectype = 'EMP' THEN EepGender else ConGender END   
        ,drvDOB =  CASE WHEN bdmrectype = 'EMP' THEN EepDateOfBirth else condateofbirth end
        ,drvEffectivedateofCoverage = CASE WHEN VACC_StartDate is not null then VACC_StartDate
                                           WHEN ILE10_StartDate is not null then ILE10_StartDate    
                                           WHEN ILE20_StartDate is not null then ILE20_StartDate    
                                           WHEN ILCH_StartDate is not null then ILCH_StartDate    
                                           WHEN ILS10_StartDate is not null then ILS10_StartDate    
                                           WHEN ILS5_StartDate is not null then ILS5_StartDate    
                                      END
        ,drvCoverageAmount =  CASE WHEN ILE10 is not null then ILE10_Amount    
                                    WHEN ILE20 is not null then ILE20_Amount    
                                    WHEN ILCH is not null then ILCH_Amount    
                                    WHEN ILS10 is not null then ILS10_Amount    
                                    WHEN ILS5 is not null then ILS5_Amount    
                            END
        ,drvPlanCode = CASE WHEN VACC is not null then 'Silver' END
        ,drvHireDate = EecDateOfOriginalHire
        ,drvWorkState = (Select top 1 LocAddressState from dbo.Location where LocCode = eeclocation)
        ,drvWeeklyWorkHours =CAST ( CONVERT(DECIMAL(10,2), ( CASE WHEN eecpayperiod = 'W' THEN EecScheduledWorkHrs 
                                   WHEN eecpayperiod = 'S' THEN (EecScheduledWorkHrs  * 24) / 52
                              END) )
                              
                              as varchar(12))
        ,drvEmploymentStatus = ''
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmail = CASE WHEN ISNULL(Eepaddressemail,'') <> '' THEN Eepaddressemail 
                    ELSE Eepaddressemailalternate END

        ,drvPayrollPeriod = ''
        ,drvFTPTIndicator = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN 'FT'
                                  WHEN EecFullTimeOrPartTime  = 'P' THEN 'PT'
                            END
        ,drvAnnualHours = CAST ( CONVERT(DECIMAL(10,2),(CASE WHEN eecpayperiod = 'W' THEN EecScheduledWorkHrs  * 52
                                   WHEN eecpayperiod = 'S' THEN (EecScheduledWorkHrs  * 24) 
                              END) )as varchar(12))
        ,drvJobTitle = JbcDesc 
        ,drvJobCode = EecJobCode
        ,drvExemptStatus = CASE WHEN JbcFLSAType  = 'E' THEN 'E' ELSE 'N' END
        ,drvEmployersDepartment = ''
        ,drvDivision = ''
        ,drvCostCenterCode = ''
        ,drvLocation = EecLocation
        ,drvBuildingCode = ''
        ,drvGeneralLegerCode = ''
        ,drvOrganizationLevel1 = ''
        ,drvOrganizationLevel2 = ''
        ,drvOrganizationLevel3 = ''
        ,drvPayRate = CASE WHEN EecSalaryOrHourly = 'H' THEN   CAST(CONVERT(DECIMAL(10,2),EecHourlyPayRate) as varchar(12))  END
        ,drvAnnualSalary = CASE WHEN EecSalaryOrHourly = 'S' THEN   CAST( CONVERT(DECIMAL(10,2),EecAnnSalary) as varchar(12))  END
        ,drvSupervisorLastName = ''
        ,drvSupervisorFirstName = ''
        ,drvSupervisorEmail = ''
        ,drvSupervisorEEIdentifier = ''
        ,drvSupervisorIdentifierCode = ''
        ,drvHRRepEEIdentifier = ''
        ,drvHRRepEEIdentifierCode = ''
        ,drvHRRepLastName = ''
        ,drvHRRepFirstName = ''
        ,drvHRRepEmailAddress = ''
        ,drvRehireDate = EecDateOfLastHire
        ,drvPayCycle = CASE WHEN eecpayperiod = 'W' THEN 'W' 
                                   WHEN eecpayperiod = 'S' THEN 'BM' 
                              END
        ,drvDisabilityPlanCode = ''
        ,drvEmployerName = 'Sadoff Iron & Metal Company'
        ,drvdrvBlankField = ''
        ,drvEffectiveDateofCoverageAPP = CASE WHEN VACC is not null then VACC_StartDate END
        ,drvEffectiveDateTermCIPP = CASE WHEN ILE10 is not null then ILE10_StopDate    
                                    WHEN ILE20 is not null then ILE20_StopDate    
                                    WHEN ILCH is not null then ILCH_StopDate    
                                    WHEN ILS10 is not null then ILS10_StopDate    
                                    WHEN ILS5 is not null then ILS5_StopDate    
                            END
        ,drvEffectiveDateTermAPP =CASE WHEN VACC is not null then VACC_StopDate END
        ,drvPriorEffDateofCoverageCIPP = ''
        ,drvPriorEffEndDateofCovCIPP = ''
        ,drvPriorCoverageAmountCIPP = ''
        ,drvPrior2EffDateofCovCIPP = ''
        ,drvPriorEffEndDateofCov2CIPP = ''
        ,drvPrior2CoverageAmount = ''
        ,drvEffectiveDateofCoverage2 = ''
        ,drvPlanSelectionHIPP = ''
        ,drvOption = ''
        ,drvEffDateofCovTerm = ''
        ,drvPriorEffectiveDateHIPP = ''
        ,drvPriorEffEndDateofCovHIPP = ''
        ,drvPriorPlanSelectionHIPP = ''
        ,drvPrior2EffDateofCovHIPP = ''
        ,drvPriorEffEndDateofCov2HIPP = ''
        ,drvPrior2PlanSelectionHIPP = ''
    INTO dbo.U_EUHCFMLEXP_drvTbl
    FROM dbo.U_EUHCFMLEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_EUHCFMLEXP_BdmConsolidated WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
    ON ConEEID = xEEID
    AND ConSystemID = BdmDepRecID;
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
ALTER VIEW dbo.dsi_vwEUHCFMLEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EUHCFMLEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EUHCFMLEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008211'
       ,expStartPerControl     = '202008211'
       ,expLastEndPerControl   = '202008289'
       ,expEndPerControl       = '202008289'
WHERE expFormatCode = 'EUHCFMLEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUHCFMLEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EUHCFMLEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2