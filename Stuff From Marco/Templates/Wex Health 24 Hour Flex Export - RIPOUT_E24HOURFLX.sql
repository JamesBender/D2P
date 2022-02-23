/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., E24HOURFLX)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Wex Health 24 Hour Flex Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@ClientName - Replace with Client Name in Header Record
@AdministratorCode - Replace with Administrator Code
@EmployerCode - Replace with Employer Code

-- Data parameters
@DedCodeFSAMedical - Replace with FSA Medical Deduction Code (i.e., FSAM)
@DedCodeFSADependent - Replace with FSA Dependent Care Deduction Code (i.e., FSAD)
@DedCodeFSALimited - Replace with FSA Dependent Care Deduction Code (i.e., HSALT)
@DedCodeHSA - Replace with HSA (Health Savings Account) Deduction code (i.e., HSAC)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\WexHealth\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\WexHealth\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@FileGroupName - Replace with File Group Number for Filename

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Trailer') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Trailer];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_Header') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Header];
GO
IF OBJECT_ID('U_@CustomFormatCode_HdrTrl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_HdrTrl];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_UD') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_UD];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_PT];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PN') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_PN];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PC') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_PC];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PB') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_PB];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PA') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_PA];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_LC') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_LC];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_IX') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_IX];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_EN];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_DX') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_DX];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_DP') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_DP];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CX') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_CX];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_CT];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_BK') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_BK];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode','Wex Health 24 Hour Flex Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FH"','1','(''DA''=''T|'')',@AdhSystemID,'2','H','01','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdministratorCode"','2','(''UA''=''T|'')',@AdhSystemID,'3','H','01','2',NULL,'Administrator Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','3','(''UA''=''T|'')',@AdhSystemID,'6','H','01','3',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSynchronizeFlag"','4','(''UA''=''T|'')',@AdhSystemID,'1','H','01','4',NULL,'Synchronize Flag',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','H','01','5',NULL,'Submitted Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedTime"','6','(''UDMDY''=''T|'')',@AdhSystemID,'6','H','01','6',NULL,'Submitted Time',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFileVersion"','7','(''UA''=''T'')',@AdhSystemID,'6','H','01','7',NULL,'File Version',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','10','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PT"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','10','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','10','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerEmployeeID"','4','(''UA''=''T|'')',@AdhSystemID,'20','D','10','4',NULL,'Employer Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeNumber"','5','(''UA''=''T|'')',@AdhSystemID,'15','D','10','5',NULL,'Employee Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','6','(''UA''=''T|'')',@AdhSystemID,'30','D','10','6',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','7','(''UA''=''T|'')',@AdhSystemID,'30','D','10','7',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleInitial"','8','(''UA''=''T|'')',@AdhSystemID,'1','D','10','8',NULL,'Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','9','(''UA''=''T|'')',@AdhSystemID,'1','D','10','9',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMaritalStatus"','10','(''UA''=''T|'')',@AdhSystemID,'1','D','10','10',NULL,'Marital Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMothersMaidenName"','11','(''UA''=''T|'')',@AdhSystemID,'50','D','10','11',NULL,'Mothers Maiden Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateOfBirth"','12','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','12',NULL,'Date Of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','13','(''UA''=''T|'')',@AdhSystemID,'9','D','10','13',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1"','14','(''UA''=''T|'')',@AdhSystemID,'50','D','10','14',NULL,'Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2"','15','(''UA''=''T|'')',@AdhSystemID,'50','D','10','15',NULL,'Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine3"','16','(''UA''=''T|'')',@AdhSystemID,'50','D','10','16',NULL,'Address Line 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine4"','17','(''UA''=''T|'')',@AdhSystemID,'50','D','10','17',NULL,'Address Line 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','18','(''UA''=''T|'')',@AdhSystemID,'30','D','10','18',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','19','(''UA''=''T|'')',@AdhSystemID,'2','D','10','19',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZipCode"','20','(''UA''=''T|'')',@AdhSystemID,'10','D','10','20',NULL,'Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountry"','21','(''UA''=''T|'')',@AdhSystemID,'2','D','10','21',NULL,'Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHomePhone"','22','(''UA''=''T|'')',@AdhSystemID,'10','D','10','22',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhone"','23','(''UA''=''T|'')',@AdhSystemID,'10','D','10','23',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhoneExtension"','24','(''UA''=''T|'')',@AdhSystemID,'6','D','10','24',NULL,'Work Phone Extension',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmailAddress"','25','(''UA''=''T|'')',@AdhSystemID,'125','D','10','25',NULL,'Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvUsername"','26','(''UA''=''T|'')',@AdhSystemID,'100','D','10','26',NULL,'Username',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPassword"','27','(''UA''=''T|'')',@AdhSystemID,'100','D','10','27',NULL,'Password',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHireDate"','28','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','28',NULL,'Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivision"','29','(''UA''=''T|'')',@AdhSystemID,'100','D','10','29',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHoursPerWeek"','30','(''UNT0''=''T|'')',@AdhSystemID,'2','D','10','30',NULL,'Hours Per Week',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeClass"','31','(''UA''=''T|'')',@AdhSystemID,'100','D','10','31',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollFrequency"','32','(''UA''=''T|'')',@AdhSystemID,'50','D','10','32',NULL,'Payroll Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollFrequencyEffDate"','33','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','33',NULL,'Payroll Frequency Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantStatus"','34','(''UA''=''T|'')',@AdhSystemID,'20','D','10','34',NULL,'Participant Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatusEffectiveDate"','35','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','35',NULL,'Status Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHoldPayrollDeductions"','36','(''UA''=''T|'')',@AdhSystemID,'1','D','10','36',NULL,'Hold Payroll Deductions',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHoldEmployerContributions"','37','(''UA''=''T|'')',@AdhSystemID,'1','D','10','37',NULL,'Hold Employer Contributions',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIncurServices"','38','(''UA''=''T|'')',@AdhSystemID,'1','D','10','38',NULL,'Incur Services',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFinalPayrollProcessDate"','39','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','39',NULL,'Final Payroll Process Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFinalContribProcessDate"','40','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','40',NULL,'Final Contribution Process Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHSACustodian"','41','(''UA''=''T|'')',@AdhSystemID,'100','D','10','41',NULL,'HSA Custodian (Version 2.0/2.2/3.0/3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMedicareBeneficiary"','42','(''UA''=''T|'')',@AdhSystemID,'1','D','10','42',NULL,'Medicare Beneficiary (Version 2.2/3.0/3.2/3.3 Only',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMedicareID"','43','(''UA''=''T|'')',@AdhSystemID,'12','D','10','43',NULL,'Medicare ID (Version 2.2/3.0/3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExchangeIntegrationID"','44','(''UA''=''T|'')',@AdhSystemID,'50','D','10','44',NULL,'Exchange Integration ID (Version 3.0/3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingHierarchyLevel1"','45','(''UA''=''T|'')',@AdhSystemID,'100','D','10','45',NULL,'Reporting Hierarchy Level1 (Version 3.0/3.2/3.3 On',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingHierarchyLevel2"','46','(''UA''=''T|'')',@AdhSystemID,'100','D','10','46',NULL,'Reporting Hierarchy Level2 (Version 3.0/3.2/3.3 On',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingHierarchyLevel3"','47','(''UA''=''T|'')',@AdhSystemID,'100','D','10','47',NULL,'Reporting Hierarchy Level3 (Version 3.0/3.2/3.3 On',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReportingHierarchyLevel4"','48','(''UA''=''T|'')',@AdhSystemID,'100','D','10','48',NULL,'Reporting Hierarchy Level4 (Version 3.0/3.2/3.3 On',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCDDCitizenship"','49','(''UA''=''T|'')',@AdhSystemID,'20','D','10','49',NULL,'CDD_Citizenship (Version 3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCDDCountry"','50','(''UA''=''T|'')',@AdhSystemID,'2','D','10','50',NULL,'CDD_Country (Version 3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCDDEmploymentStatus"','51','(''UA''=''T|'')',@AdhSystemID,'20','D','10','51',NULL,'CDD_EmploymentStatus (Version 3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCDDEmployer"','52','(''UA''=''T|'')',@AdhSystemID,'30','D','10','52',NULL,'CDD_Employer (Version 3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCDDJobTitle"','53','(''UA''=''T|'')',@AdhSystemID,'30','D','10','53',NULL,'CDD_JobTitle (Version 3.2/3.3 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClassEffectiveDate"','54','(''UDMDY''=''T'')',@AdhSystemID,'8','D','10','54',NULL,'Class Effective Date (Version 3.3)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','15','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BK"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','15','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','15','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNickname"','4','(''UA''=''T|'')',@AdhSystemID,'20','D','15','4',NULL,'Nickname',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountUse"','5','(''UA''=''T|'')',@AdhSystemID,'30','D','15','5',NULL,'Account Use',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountType"','6','(''UA''=''T|'')',@AdhSystemID,'1','D','15','6',NULL,'Account Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountStatus"','7','(''UA''=''T|'')',@AdhSystemID,'1','D','15','7',NULL,'Account Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankName"','8','(''UA''=''T|'')',@AdhSystemID,'30','D','15','8',NULL,'Bank Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRoutingNumber"','9','(''UA''=''T|'')',@AdhSystemID,'9','D','15','9',NULL,'Routing Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountNumber"','10','(''UA''=''T|'')',@AdhSystemID,'17','D','15','10',NULL,'Account Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPrenote"','11','(''UA''=''T|'')',@AdhSystemID,'1','D','15','11',NULL,'Prenote',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankAccountAddressLine1"','12','(''UA''=''T|'')',@AdhSystemID,'30','D','15','12',NULL,'Bank Account Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankAccountAddressLine2"','13','(''UA''=''T|'')',@AdhSystemID,'30','D','15','13',NULL,'Bank Account Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankCity"','14','(''UA''=''T|'')',@AdhSystemID,'30','D','15','14',NULL,'Bank City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankState"','15','(''UA''=''T|'')',@AdhSystemID,'2','D','15','15',NULL,'Bank State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankZipCode"','16','(''UA''=''T|'')',@AdhSystemID,'10','D','15','16',NULL,'Bank Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankCountry"','17','(''UA''=''T'')',@AdhSystemID,'2','D','15','17',NULL,'Bank Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','20','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EN"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','20','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','20','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','4','(''UA''=''T|'')',@AdhSystemID,'255','D','20','4',NULL,'Plan Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEnrollmentEffectiveDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','20','5',NULL,'Enrollment Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantElectionAmount"','6','(''UNT2''=''T|'')',@AdhSystemID,'12','D','20','6',NULL,'Participant Election Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEnrollmentTerminationDate"','7','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','20','7',NULL,'Enrollment Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerContributionLevel"','8','(''UA''=''T|'')',@AdhSystemID,'10','D','20','8',NULL,'Employer Contribution Level',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerContributionAmount"','9','(''UNT2''=''T|'')',@AdhSystemID,'12','D','20','9',NULL,'Employer Contribution Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPrimaryReimbursement"','10','(''UA''=''T|'')',@AdhSystemID,'30','D','20','10',NULL,'Primary Reimbursement',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAlternateReimbursement"','11','(''UA''=''T|'')',@AdhSystemID,'30','D','20','11',NULL,'Alternate Reimbursement',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEnrolledInClaimsExchange"','12','(''UA''=''T|'')',@AdhSystemID,'1','D','20','12',NULL,'Enrolled In Claims Exchange',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvElectionAmountIndicator"','13','(''UA''=''T|'')',@AdhSystemID,'8','D','20','13',NULL,'ElectionAmount Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHDHPCoverageLevel"','14','(''UA''=''T|'')',@AdhSystemID,'6','D','20','14',NULL,'HDHP Coverage Level',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanYearStartDate"','15','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','20','15',NULL,'Plan Year Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTermsandConditionsAccepted"','16','(''UA''=''T|'')',@AdhSystemID,'1','D','20','16',NULL,'Terms and Conditions Accepted (Version 2.0 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateTermsConditionsAcceptd"','17','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','20','17',NULL,'DateTerms Conditions Accepted (Version 2.0 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTimeTermsConditionsAcceptd"','18','(''UA''=''T|'')',@AdhSystemID,'6','D','20','18',NULL,'TimeTerms Conditions Accepted (Version 2.0 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvChangeDate"','19','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','20','19',NULL,'ChangeDate (Version 2.0 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSpendDown"','20','(''UA''=''T'')',@AdhSystemID,'1','D','20','20',NULL,'Spend Down (Version 2.0 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','25','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DP"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','25','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','25','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDependentFileImportId"','4','(''UA''=''T|'')',@AdhSystemID,'20','D','25','4',NULL,'Dependent File Import Id',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDependentNumber"','5','(''UA''=''T|'')',@AdhSystemID,'10','D','25','5',NULL,'Dependent Number (Version 1.0 and 2.0 Only)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRelationship"','6','(''UA''=''T|'')',@AdhSystemID,'9','D','25','6',NULL,'Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRelationshipType"','7','(''UA''=''T|'')',@AdhSystemID,'16','D','25','7',NULL,'Relationship Type (Version 2.1)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','8','(''UA''=''T|'')',@AdhSystemID,'30','D','25','8',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','9','(''UA''=''T|'')',@AdhSystemID,'30','D','25','9',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleInitial"','10','(''UA''=''T|'')',@AdhSystemID,'1','D','25','10',NULL,'Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','11','(''UA''=''T|'')',@AdhSystemID,'1','D','25','11',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOB"','12','(''UA''=''T|'')',@AdhSystemID,'8','D','25','12',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','13','(''UA''=''T|'')',@AdhSystemID,'9','D','25','13',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMedicareBeneficiary"','14','(''UA''=''T|'')',@AdhSystemID,'2','D','25','14',NULL,'Medicare Beneficiary (Version 2.1)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMedicareID"','15','(''UA''=''T|'')',@AdhSystemID,'12','D','25','15',NULL,'Medicare ID (Version 2.1)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatus"','16','(''UA''=''T|'')',@AdhSystemID,'8','D','25','16',NULL,'Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStudent"','17','(''UA''=''T|'')',@AdhSystemID,'1','D','25','17',NULL,'Student',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIssueCard"','18','(''UA''=''T|'')',@AdhSystemID,'1','D','25','18',NULL,'Issue Card',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHRAEnrollmentEffectiveDate"','19','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','25','19',NULL,'HRA Enrollment Effective Date (Version 2.1)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHRAEnrollmentTermDate"','20','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','25','20',NULL,'HRA Enrollment Termination Date (Version 2.1)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalDependentID"','21','(''UA''=''T'')',@AdhSystemID,'20','D','25','21',NULL,'External Dependent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','30','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CT"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','30','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','30','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','4','(''UA''=''T|'')',@AdhSystemID,'255','D','30','4',NULL,'Plan Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','30','5',NULL,'Contribution Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionDescription"','6','(''UA''=''T|'')',@AdhSystemID,'30','D','30','6',NULL,'Contribution Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionAmount"','7','(''UNT2''=''T|'')',@AdhSystemID,'12','D','30','7',NULL,'Contribution Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAmountType"','8','(''UA''=''T|'')',@AdhSystemID,'6','D','30','8',NULL,'Amount Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTaxYear"','9','(''UA''=''T|'')',@AdhSystemID,'7','D','30','9',NULL,'Tax Year',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNotes"','10','(''UA''=''T|'')',@AdhSystemID,'500','D','30','10',NULL,'Notes',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanYearStartDate"','11','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','30','11',NULL,'Plan Year Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanYearEndDate"','12','(''UDMDY''=''T'')',@AdhSystemID,'8','D','30','12',NULL,'Plan Year End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','35','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PC"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','35','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','35','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCarrierID"','4','(''UA''=''T|'')',@AdhSystemID,'20','D','35','4',NULL,'Carrier ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanType"','5','(''UA''=''T|'')',@AdhSystemID,'3','D','35','5',NULL,'Plan Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanIdentifier"','6','(''UA''=''T|'')',@AdhSystemID,'30','D','35','6',NULL,'Plan Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberEffectiveDate"','7','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','35','7',NULL,'Member Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMemberTerminationDate"','8','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','35','8',NULL,'Member Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCarrierMemberIdentifier"','9','(''UA''=''T'')',@AdhSystemID,'20','D','35','9',NULL,'Carrier Member Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','40','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PB"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','40','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','40','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBeneficiarySSN"','4','(''UA''=''T|'')',@AdhSystemID,'20','D','40','4',NULL,'Beneficiary SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRelationship"','5','(''UA''=''T|'')',@AdhSystemID,'9','D','40','5',NULL,'Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','6','(''UA''=''T|'')',@AdhSystemID,'30','D','40','6',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','7','(''UA''=''T|'')',@AdhSystemID,'30','D','40','7',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleInitial"','8','(''UA''=''T|'')',@AdhSystemID,'1','D','40','8',NULL,'Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOB"','9','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','40','9',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatus"','10','(''UA''=''T|'')',@AdhSystemID,'8','D','40','10',NULL,'Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBeneficiaryType"','11','(''UA''=''T|'')',@AdhSystemID,'10','D','40','11',NULL,'Beneficiary Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvShare"','12','(''UNT0''=''T|'')',@AdhSystemID,'3','D','40','12',NULL,'Share',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1"','13','(''UA''=''T|'')',@AdhSystemID,'50','D','40','13',NULL,'Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2"','14','(''UA''=''T|'')',@AdhSystemID,'50','D','40','14',NULL,'Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','15','(''UA''=''T|'')',@AdhSystemID,'50','D','40','15',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','16','(''UA''=''T|'')',@AdhSystemID,'2','D','40','16',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZipCode"','17','(''UA''=''T|'')',@AdhSystemID,'10','D','40','17',NULL,'Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountry"','18','(''UA''=''T'')',@AdhSystemID,'2','D','40','18',NULL,'Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','45','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CX"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','45','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','45','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanYearName"','4','(''UA''=''T|'')',@AdhSystemID,'100','D','45','4',NULL,'Plan Year Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','45','5',NULL,'Contribution Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionType"','6','(''UA''=''T|'')',@AdhSystemID,'30','D','45','6',NULL,'Contribution Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionAmount"','7','(''UNT2''=''T|'')',@AdhSystemID,'12','D','45','7',NULL,'Contribution Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','50','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DX"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','50','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','50','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFCPlanYearName"','4','(''UA''=''T|'')',@AdhSystemID,'100','D','50','4',NULL,'DFC Plan Year Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIsPartialEnrollment"','5','(''UA''=''T|'')',@AdhSystemID,'1','D','50','5',NULL,'Is Partial Enrollment?',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFCTotalContributionAmount"','6','(''UNT2''=''T|'')',@AdhSystemID,'12','D','50','6',NULL,'DFC Total Contribution Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFCCoverageTier"','7','(''UA''=''T|'')',@AdhSystemID,'10','D','50','7',NULL,'DFC Coverage Tier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFCEnrollmentEffectiveDate"','8','(''UDMDY''=''T'')',@AdhSystemID,'8','D','50','8',NULL,'DFC Enrollment Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','55','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"IX"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','55','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','55','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalInsurancePlanId"','4','(''UA''=''T|'')',@AdhSystemID,'50','D','55','4',NULL,'External Insurance Plan Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFCPlanYearName"','5','(''UA''=''T|'')',@AdhSystemID,'100','D','55','5',NULL,'DFC Plan Year Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFCPlanYearStartDate"','6','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','55','6',NULL,'DFC Plan Year Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInsuranceCompanyName"','7','(''UA''=''T|'')',@AdhSystemID,'50','D','55','7',NULL,'Insurance Company Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInsurancePlanName"','8','(''UA''=''T|'')',@AdhSystemID,'80','D','55','8',NULL,'Insurance Plan Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInsuranceEffectiveDate"','9','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','55','9',NULL,'Insurance Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInsuranceType"','10','(''UA''=''T|'')',@AdhSystemID,'50','D','55','10',NULL,'Insurance Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanCoverageLevel"','11','(''UA''=''T|'')',@AdhSystemID,'16','D','55','11',NULL,'Plan Coverage Level',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanMonthlyPremium"','12','(''UNT2''=''T|'')',@AdhSystemID,'12','D','55','12',NULL,'Plan Monthly Premium',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanAnnualDeductible"','13','(''UNT2''=''T|'')',@AdhSystemID,'12','D','55','13',NULL,'Plan Annual Deductible',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanOutofPocket"','14','(''UNT2''=''T|'')',@AdhSystemID,'12','D','55','14',NULL,'Plan Out of Pocket',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvConsumerResponsibility"','15','(''UNT2''=''T|'')',@AdhSystemID,'12','D','55','15',NULL,'Consumer Responsibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerResponsibility"','16','(''UNT2''=''T|'')',@AdhSystemID,'12','D','55','16',NULL,'Employer Responsibility',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanApplicationStatus"','17','(''UA''=''T|'')',@AdhSystemID,'50','D','55','17',NULL,'Plan Application Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanApplicationDescription"','18','(''UA''=''T|'')',@AdhSystemID,'50','D','55','18',NULL,'Plan Application Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInsurancePlanTermDate"','19','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','55','19',NULL,'Insurance Plan Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIsEmployerPostTax"','20','(''UA''=''T|'')',@AdhSystemID,'1','D','55','20',NULL,'Is Employer Post Tax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIsPayrollPostTax"','21','(''UA''=''T|'')',@AdhSystemID,'1','D','55','21',NULL,'Is Payroll Post Tax',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDFCIneligible"','22','(''UA''=''T'')',@AdhSystemID,'1','D','55','22',NULL,'DFC Ineligible',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','60','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PA"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','60','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','60','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanYearName"','4','(''UA''=''T|'')',@AdhSystemID,'100','D','60','4',NULL,'Plan Year Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','5','(''UA''=''T|'')',@AdhSystemID,'255','D','60','5',NULL,'Plan Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTransactionType"','6','(''UA''=''T|'')',@AdhSystemID,'1','D','60','6',NULL,'Transaction Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTransactionDescription"','7','(''UA''=''T|'')',@AdhSystemID,'50','D','60','7',NULL,'Transaction Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTransactionDate"','8','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','60','8',NULL,'Transaction Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAmount"','9','(''UNT2''=''T|'')',@AdhSystemID,'12','D','60','9',NULL,'Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvConsumerNote"','10','(''UA''=''T|'')',@AdhSystemID,'500','D','60','10',NULL,'Consumer Note',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTransactionMethod"','11','(''UA''=''T|'')',@AdhSystemID,'50','D','60','11',NULL,'Transaction Method',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTaxYear"','12','(''UA''=''T|'')',@AdhSystemID,'7','D','60','12',NULL,'Tax Year',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateFundsAvailable"','13','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','60','13',NULL,'Date Funds Available',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSourceAccount"','14','(''UA''=''T|'')',@AdhSystemID,'3','D','60','14',NULL,'Source Account',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCheckNumber"','15','(''UA''=''T|'')',@AdhSystemID,'20','D','60','15',NULL,'Check Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateReceived"','16','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','60','16',NULL,'Date Received',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDistributionRecipient"','17','(''UA''=''T|'')',@AdhSystemID,'15','D','60','17',NULL,'Distribution Recipient',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdjustmentType"','18','(''UA''=''T|'')',@AdhSystemID,'100','D','60','18',NULL,'Adjustment Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdjustmentReason"','19','(''UA''=''T|'')',@AdhSystemID,'50','D','60','19',NULL,'Adjustment Reason',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeName"','20','(''UA''=''T|'')',@AdhSystemID,'50','D','60','20',NULL,'Payee Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeAddress1"','21','(''UA''=''T|'')',@AdhSystemID,'50','D','60','21',NULL,'Payee Address 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeAddress2"','22','(''UA''=''T|'')',@AdhSystemID,'50','D','60','22',NULL,'Payee Address 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeAddress3"','23','(''UA''=''T|'')',@AdhSystemID,'50','D','60','23',NULL,'Payee Address 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeCity"','24','(''UA''=''T|'')',@AdhSystemID,'50','D','60','24',NULL,'Payee City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeState"','25','(''UA''=''T|'')',@AdhSystemID,'2','D','60','25',NULL,'Payee State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeZipCode"','26','(''UA''=''T|'')',@AdhSystemID,'10','D','60','26',NULL,'Payee Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRecipientName"','27','(''UA''=''T|'')',@AdhSystemID,'50','D','60','27',NULL,'Recipient Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayeeAccountNumber"','28','(''UA''=''T|'')',@AdhSystemID,'30','D','60','28',NULL,'Payee Account Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActivityCompletionDate"','29','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','60','29',NULL,'Activity Completion Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActivity"','30','(''UA''=''T|'')',@AdhSystemID,'100','D','60','30',NULL,'Activity',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActivityID"','31','(''UA''=''T|'')',@AdhSystemID,'30','D','60','31',NULL,'Activity ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCompletedBy"','32','(''UA''=''T|'')',@AdhSystemID,'50','D','60','32',NULL,'Completed By',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWellnessTransactionID"','33','(''UA''=''T|'')',@AdhSystemID,'30','D','60','33',NULL,'Wellness Transaction ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdjustEmployerAccount"','34','(''UA''=''T'')',@AdhSystemID,'1','D','60','34',NULL,'Adjust Employer Account',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','65','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"UD"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','65','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','65','3',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvUserDefinedFieldName"','4','(''UA''=''T|'')',@AdhSystemID,'25','D','65','4',NULL,'User Defined Field Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvUserDefinedFieldValue"','5','(''UA''=''T'')',@AdhSystemID,'200','D','65','5',NULL,'User Defined Field Value',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','70','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PN"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','70','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPaymentNumber"','3','(''UA''=''T|'')',@AdhSystemID,'20','D','70','3',NULL,'Payment Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEffectiveDate"','4','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','70','4',NULL,'Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalPaymentNumber"','5','(''UA''=''T'')',@AdhSystemID,'20','D','70','5',NULL,'External Payment Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','1','(''UA''=''T|'')',@AdhSystemID,'6','D','75','1',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LC"','2','(''DA''=''T|'')',@AdhSystemID,'2','D','75','2',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','3','(''UA''=''T|'')',@AdhSystemID,'50','D','75','3',NULL,'ParticipantFileImportID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContactType"','4','(''UA''=''T|'')',@AdhSystemID,'15','D','75','4',NULL,'ContactType',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContactDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','75','5',NULL,'ContactDate',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNotes"','6','(''UA''=''T'')',@AdhSystemID,'800','D','75','6',NULL,'Notes',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FF"','1','(''DA''=''T|'')',@AdhSystemID,'2','T','90','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRecordCount"','2','(''UNT0''=''T|'')',@AdhSystemID,'20','T','90','2',NULL,'Record Count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdministratorCode"','3','(''UA''=''T|'')',@AdhSystemID,'3','T','90','3',NULL,'Administrator Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','4','(''UA''=''T|'')',@AdhSystemID,'6','T','90','4',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','T','90','5',NULL,'Submitted Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedTime"','6','(''UDHMS''=''T'')',@AdhSystemID,'6','T','90','6',NULL,'Submitted Time',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_@CustomFormatCode_20171019.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Wex Health 24 Hour Flex Export','201710199','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710199','Oct 19 2017  9:13AM','Oct 19 2017  9:13AM','201710191',NULL,'','','201710191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_@CustomFormatCode_20171019.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201710199','EMPEXPORT','SCHEDULED',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710199','Oct 19 2017  9:13AM','Oct 19 2017  9:13AM','201710191',NULL,'','','201710191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_@CustomFormatCode_20171019.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201710199','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710199','Oct 19 2017  9:13AM','Oct 19 2017  9:13AM','201710191',NULL,'','','201710191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_@CustomFormatCode_20171019.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201710199','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710199','Oct 19 2017  9:13AM','Oct 19 2017  9:13AM','201710191',NULL,'','','201710191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_@CustomFormatCode_20171019.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201710199','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710199','Oct 19 2017  9:13AM','Oct 19 2017  9:13AM','201710191',NULL,'','','201710191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','dbo.U_@CustomFormatCode_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_PT','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D15','dbo.U_@CustomFormatCode_drvTbl_BK','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_EN','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D25','dbo.U_@CustomFormatCode_drvTbl_DP','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_drvTbl_CT','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D35','dbo.U_@CustomFormatCode_drvTbl_PC','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_@CustomFormatCode_drvTbl_PB','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D45','dbo.U_@CustomFormatCode_drvTbl_CX','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_@CustomFormatCode_drvTbl_DX','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D55','dbo.U_@CustomFormatCode_drvTbl_IX','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D60','dbo.U_@CustomFormatCode_drvTbl_PA','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D65','dbo.U_@CustomFormatCode_drvTbl_UD','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D70','dbo.U_@CustomFormatCode_drvTbl_PN','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D75','dbo.U_@CustomFormatCode_drvTbl_LC','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','dbo.U_@CustomFormatCode_Trailer',NULL);
GO
DECLARE @ISWEB CHAR(1) = '@IsWebFlag';
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
IF (@ISWEB = 'Y')
BEGIN
	UPDATE dbo.AscExp SET expAscFileName = '\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_@CustomFormatCode_YYYYMMDD.txt' WHERE expFormatCode = '@CustomFormatCode';

	UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_@CustomFormatCode_YYYYMMDD.txt' END WHERE expFormatCode = '@CustomFormatCode';
	IF LEFT(@UDENV,2) = 'NW' UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'Exports\',SPACE(0)) WHERE expFormatCode = '@CustomFormatCode';

    UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'YYYYMMDD',CONVERT(char(8),GETDATE(),112)) WHERE expFormatCode = '@CustomFormatCode';

	UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = '@CustomFormatCode' AND CfgName IN ('UseFileName','ExportPath');
	
	DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName IN ('TestPath','UDESPath');

	INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
END
IF OBJECT_ID('U_@CustomFormatCode_SavePath') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_SavePath];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: Wex Health 24 Hour Flex Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           DATETIME
            ,@PlanYearStart     DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = '@CustomFormatCode';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- Set Plan Year Start (i.e., HSA/FSA Plans)
    SET @PlanYearStart = CASE WHEN MONTH(@EndDate) = 12 THEN '01/01/' + CONVERT(CHAR(4),YEAR(DATEADD(YEAR,1,@EndDate)))
                              ELSE '01/01/' + CONVERT(CHAR(4),YEAR(@EndDate))
                         END;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes','FSA,HSA');
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
    IF OBJECT_ID('U_@CustomFormatCode_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PDedHist;

    -- Insert employee contributions (EE Amount)
    SELECT DISTINCT
         PdhEEID
        ,PdhPlanName    = CASE WHEN PdhDedCode = '@DedCodeFSAMedical' THEN 'Medical FSA'
                               WHEN PdhDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
                               WHEN PdhDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
                               WHEN PdhDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
                          END
        ,PdhPerControl  = MAX(LEFT(PdhPerControl,8))
        ,PdhContribDesc = 'Payroll Deduction'
        ,PdhCurAmt      = SUM(PdhEECurAmt)
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PdhDedCode IN ('@DedCodeFSAMedical','@DedCodeFSADependent','@DedCodeFSALimited','@DedCodeHSA')
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode = '@DedCodeFSAMedical' THEN 'Medical FSA'
              WHEN PdhDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
              WHEN PdhDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
              WHEN PdhDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
         END
    HAVING (SUM(PdhEECurAmt) <> 0.00);

    -- Insert employer contributions (ER Amount)
    INSERT INTO dbo.U_@CustomFormatCode_PDedHist (PdhEEID,PdhPlanName,PdhPerControl,PdhContribDesc,PdhCurAmt)
    SELECT DISTINCT
         PdhEEID
        ,PdhPlanName    = CASE WHEN PdhDedCode = '@DedCodeFSAMedical' THEN 'Medical FSA'
                               WHEN PdhDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
                               WHEN PdhDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
                               WHEN PdhDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
                          END
        ,PdhPerControl  = MAX(LEFT(PdhPerControl,8))
        ,PdhContribDesc = 'Employer Contribution'
        ,PdhCurAmt      = SUM(PdhERCurAmt)
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode = '@DedCodeFSAMedical' THEN 'Medical FSA'
              WHEN PdhDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
              WHEN PdhDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
              WHEN PdhDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
         END
    HAVING (SUM(PdhERCurAmt) <> 0.00);

    --==========================================
    -- Build Driver Tables
    --==========================================

    ----------------------------------------------
    -- Detail Record - Participant Record (PT)
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '1'
        ,drvSendRecord = 'Y' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvEmployerEmployeeID = EecEmpNo
        ,drvEmployeeNumber = ''
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvMaritalStatus = CASE WHEN EepMaritalStatus IN ('M','S') THEN eepMaritalStatus END
        ,drvMothersMaidenName = ''
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvAddressLine4 = ''
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkPhoneExtension = EecPhoneBusinessExt
        ,drvEmailAddress = EepAddressEMail
        ,drvUsername = ''
        ,drvPassword = ''
        ,drvHireDate = EecDateOfLastHire
        ,drvDivision = ''
        ,drvHoursPerWeek = CASE EecPayPeriod
                                WHEN 'W' THEN EecScheduledWorkHrs
                                WHEN 'B' THEN EecScheduledWorkHrs / 2
                                WHEN 'S' THEN (EecScheduledWorkHrs * 2) / 4
                                WHEN 'M' THEN EecScheduledWorkHrs / 4
                           END
        ,drvEmployeeClass = ''
        ,drvPayrollFrequency = CASE EecPayPeriod
                                    WHEN 'W' THEN 'Weekly'
                                    WHEN 'B' THEN 'Bi-Weekly'
                                    WHEN 'S' THEN 'Semi-Monthly'
                                    WHEN 'M' THEN 'Monthly'
                               END
        ,drvPayrollFrequencyEffDate = ''
        ,drvParticipantStatus = CASE EecEmplStatus
                                     WHEN 'A' THEN 'Active'
                                     WHEN 'L' THEN 'LOA'
                                     WHEN 'T' THEN 'Terminated'
                                END
        ,drvStatusEffectiveDate = CASE WHEN EecEmplStatus = 'T' THEN DATEADD(DAY,1,EecDateOfTermination)
                                       WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate
                                       ELSE EecDateOfLastHire
                                  END
        -- For LOA Employees: Hold Payroll, Hold Employer, Incur Services
        ,drvHoldPayrollDeductions = ''
        ,drvHoldEmployerContributions = ''
        ,drvIncurServices = ''
        ,drvFinalPayrollProcessDate = EecDatePaidThru
        ,drvFinalContribProcessDate = EecDatePaidThru
        ,drvHSACustodian = ''
        ,drvMedicareBeneficiary = ''
        ,drvMedicareID = ''
        ,drvExchangeIntegrationID = ''
        ,drvReportingHierarchyLevel1 = ''
        ,drvReportingHierarchyLevel2 = ''
        ,drvReportingHierarchyLevel3 = ''
        ,drvReportingHierarchyLevel4 = ''
        -- Consumer’s citizenship information
        ,drvCDDCitizenship = ''
        ,drvCDDCountry = ''
        ,drvCDDEmploymentStatus = ''
        ,drvCDDEmployer = ''
        ,drvCDDJobTitle = ''
        ,drvClassEffectiveDate = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_PT
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE BdmRecType = 'EMP';

    ----------------------------------------------
    -- Detail Record - Bank Account Record (BK)
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_BK','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_BK;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '2'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvNickname = ''
        ,drvAccountUse = 'Direct Deposit'
        ,drvAccountType = EddAcctType --C = Checking, S = Savings
        ,drvAccountStatus = CASE EddAccountIsInactive
                                 WHEN 'N' THEN 'Y'
                                 ELSE 'Y'
                            END
        ,drvBankName = EddEEBankName
        ,drvRoutingNumber = EddEEBankRoute
        ,drvAccountNumber = EddAcct
        ,drvPrenote = EddDdOrPreNote
        ,drvBankAccountAddressLine1 = BnkBankAddressLine1
        ,drvBankAccountAddressLine2 = BnkBankAddressLine2
        ,drvBankCity = BnkBankAddressCity
        ,drvBankState = BnkBankAddressState
        ,drvBankZipCode = BnkBankAddressZipCode
        ,drvBankCountry = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_BK
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpDirDP WITH (NOLOCK)
        ON EddEEID = xEEID 
        AND EddCoID = xCoID
    LEFT JOIN dbo.Bank WITH (NOLOCK)
        ON BnkAchBankRoutingNo = EddEEBankRoute;

    ----------------------------------------------
    -- Detail Record - Enrollment Record (EN)
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '3'
        ,drvSendRecord = 'Y' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName = CASE WHEN BdmDedCode = '@DedCodeFSAMedical' THEN 'Medical FSA'
                            WHEN BdmDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
                            WHEN BdmDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
                            WHEN BdmDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
                       END
        ,drvEnrollmentEffectiveDate = CASE WHEN BdmDedType IN ('HSA','FSA') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate,@PlanYearStart)
                                           ELSE BdmBenStartDate
                                      END
        ,drvParticipantElectionAmount = CASE WHEN BdmDedType = 'FSA' THEN BdmEEGoalAmt --Annual election amounts for FSAs.
                                             WHEN BdmDedCode IN ('PARKING','TRANSIT') THEN BdmEEAmt --Monthly election amounts for Parking and Transit plans.
                                             ELSE 0.00 --0 for HSAs.
                                        END
        ,drvEnrollmentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEmployerContributionLevel = '' --Ind, IndSpouse, IndChild, Family
        ,drvEmployerContributionAmount = ''
        ,drvPrimaryReimbursement = 'Debit Card'
        ,drvAlternateReimbursement = '' --Direct Deposit, Check, Debit Card
        ,drvEnrolledInClaimsExchange = ''
        ,drvElectionAmountIndicator = CASE WHEN BdmDedType = 'HSA' THEN 'PerPay' END --PlanYear, PerPay, PerMonth
        ,drvHDHPCoverageLevel = CASE WHEN NULLIF(BdmBenOption,'') = 'EE' THEN 'Single'
                                     WHEN NULLIF(BdmBenOption,'') IS NOT NULL THEN 'Family'
                                END
        ,drvPlanYearStartDate = ''
        ,drvTermsandConditionsAccepted = ''
        ,drvDateTermsConditionsAcceptd = ''
        ,drvTimeTermsConditionsAcceptd = ''
        ,drvChangeDate = ''
        ,drvSpendDown = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_EN
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    WHERE BdmRecType = 'EMP';

    ----------------------------------------------
    -- Detail Record - Dependent Record (DP)
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_DP','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_DP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '4' + ISNULL(BdmDepRecID,'')
        ,drvSendRecord = 'Y' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvDependentFileImportId = ConSSN
        ,drvDependentNumber = ''
        ,drvRelationship = CASE WHEN BdmRelationship IN ('SPS') THEN 'Spouse'
                                ELSE 'Dependent'
                           END
        ,drvRelationshipType = CASE WHEN BdmRelationship IN ('DP') THEN 'Domestic Partner'
                                    WHEN BdmRelationship IN ('CHL','STC') THEN 'Child'
                                    ELSE 'Other'
                               END
        ,drvLastName = ConNameLast
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender END
        ,drvDOB = ConDateOfBirth
        ,drvSSN = ConSSN
        ,drvMedicareBeneficiary = 'N'
        ,drvMedicareID = ''
        ,drvStatus = 'Active'
        ,drvStudent = ConIsStudent
        ,drvIssueCard = 'N'
        ,drvHRAEnrollmentEffectiveDate = ''
        ,drvHRAEnrollmentTermDate = ''
        ,drvExternalDependentID = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_DP
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE BdmRecType = 'DEP';

    ----------------------------------------------
    -- Detail Record - Contribution Record (CT)
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '5'
        ,drvSendRecord = 'Y' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName = PdhPlanName
        ,drvContributionDate = PdhPerControl
        ,drvContributionDescription = PdhContribDesc
        ,drvContributionAmount = PdhCurAmt
        ,drvAmountType = 'Actual'
        ,drvTaxYear = 'Current'
        ,drvNotes = ''
        ,drvPlanYearStartDate = ''
        ,drvPlanYearEndDate = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_CT
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID;

    ----------------------------------------------------
    -- Detail Record - Participant Carrier Record (PC)
    ----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PC','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_PC;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '6'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvCarrierID = ''
        ,drvPlanType = ''
        ,drvPlanIdentifier = ''
        ,drvMemberEffectiveDate = ''
        ,drvMemberTerminationDate = ''
        ,drvCarrierMemberIdentifier = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_PC
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    ----------------------------------------------
    -- Detail Record - Beneficiary Record (PB)
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PB','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_PB;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '7' + ISNULL(BdmDepRecID,'')
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvBeneficiarySSN = ConSSN
        ,drvRelationship = BdmRelationship
        ,drvLastName = ConNameLast
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvDOB = ConDateOfBirth
        ,drvStatus = 'Active'
        ,drvBeneficiaryType = CASE BfpBeneficiaryType
                                   WHEN 'P' THEN 'Primary'
                                   WHEN 'C' THEN 'Contingent'
                              END
        ,drvShare = BfpPctToAlloc
        ,drvAddressLine1 = ConAddressLine1
        ,drvAddressLine2 = ConAddressLine2
        ,drvCity = ConAddressCity
        ,drvState = ConAddressState
        ,drvZipCode = ConAddressZipCode
        ,drvCountry = ConAddressCountry
    INTO dbo.U_@CustomFormatCode_drvTbl_PB
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.BnfBPlan WITH (NOLOCK)
        ON BfpEEID = xEEID
        AND BfpConRecID = BdmDepRecID
        AND BfpDedCode = BdmDedCode
    ;

    -----------------------------------------------------
    -- Detail Record - Defined Contribution Record (CX)
    -----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CX','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_CX;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '8'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanYearName = ''
        ,drvContributionDate = ''
        ,drvContributionType = ''
        ,drvContributionAmount = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_CX
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    -----------------------------------------------------------------
    -- Detail Record - Defined Contribution Enrollment Record (DX)
    -----------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_DX','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_DX;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '9'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvDFCPlanYearName = ''
        ,drvIsPartialEnrollment = ''
        ,drvDFCTotalContributionAmount = ''
        ,drvDFCCoverageTier = ''
        ,drvDFCEnrollmentEffectiveDate = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_DX
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    -----------------------------------------------------------------
    -- Detail Record - Defined Contribution Insurance Record (IX)
    -----------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_IX','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_IX;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '10'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvExternalInsurancePlanId = ''
        ,drvDFCPlanYearName = ''
        ,drvDFCPlanYearStartDate = ''
        ,drvInsuranceCompanyName = ''
        ,drvInsurancePlanName = ''
        ,drvInsuranceEffectiveDate = ''
        ,drvInsuranceType = ''
        ,drvPlanCoverageLevel = ''
        ,drvPlanMonthlyPremium = ''
        ,drvPlanAnnualDeductible = ''
        ,drvPlanOutofPocket = ''
        ,drvConsumerResponsibility = ''
        ,drvEmployerResponsibility = ''
        ,drvPlanApplicationStatus = ''
        ,drvPlanApplicationDescription = ''
        ,drvInsurancePlanTermDate = ''
        ,drvIsEmployerPostTax = ''
        ,drvIsPayrollPostTax = ''
        ,drvDFCIneligible = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_IX
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    -------------------------------------------------
    -- Detail Record - Plan Activity Record (PA)
    -------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PA','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_PA;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '11'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanYearName = ''
        ,drvPlanName = ''
        ,drvTransactionType = ''
        ,drvTransactionDescription = ''
        ,drvTransactionDate = ''
        ,drvAmount = ''
        ,drvConsumerNote = ''
        ,drvTransactionMethod = ''
        ,drvTaxYear = ''
        ,drvDateFundsAvailable = ''
        ,drvSourceAccount = ''
        ,drvCheckNumber = ''
        ,drvDateReceived = ''
        ,drvDistributionRecipient = ''
        ,drvAdjustmentType = ''
        ,drvAdjustmentReason = ''
        ,drvPayeeName = ''
        ,drvPayeeAddress1 = EepAddressLine1
        ,drvPayeeAddress2 = EepAddressLine2
        ,drvPayeeAddress3 = ''
        ,drvPayeeCity = EepAddressCity
        ,drvPayeeState = EepAddressState
        ,drvPayeeZipCode = EepAddressZipCode
        ,drvRecipientName = ''
        ,drvPayeeAccountNumber = ''
        ,drvActivityCompletionDate = ''
        ,drvActivity = ''
        ,drvActivityID = ''
        ,drvCompletedBy = ''
        ,drvWellnessTransactionID = ''
        ,drvAdjustEmployerAccount = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_PA
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    ----------------------------------------------------
    -- Detail Record - User Defined Fields Record (UD)
    ----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_UD','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_UD;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '12'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvUserDefinedFieldName = ''
        ,drvUserDefinedFieldValue = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_UD
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    ----------------------------------------------------
    -- Detail Record - Payment Number Record (PN)
    ----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PN','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_PN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '13'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvPaymentNumber = ''
        ,drvEffectiveDate = ''
        ,drvExternalPaymentNumber = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_PN
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    ----------------------------------------------
    -- Detail Record - Last Contact Record (LC)
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_LC','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_LC;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '14'
        ,drvSendRecord = 'N' -- If you don't want to send this Record, then set to 'N'
        -- standard fields above and additional driver fields below
        ,drvEmployerCode = '@EmployerCode'
        ,drvParticipantFileImportID = EepSSN
        ,drvContactType = ''
        ,drvContactDate = ''
        ,drvNotes = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_LC
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;

    ------------------------------------------------
    -- Header Record - Header Record (FH)
    -- Trailer Record - Footer Record Layout (FF)
    ------------------------------------------------
    DECLARE @rCount INT = 0;
    SET @rCount = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_PT)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_BK)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_EN)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_DP)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_CT)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_PC)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_PB)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_CX)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_DX)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_IX)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_PA)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_UD)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_PN)
                + (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl_LC);

    IF OBJECT_ID('U_@CustomFormatCode_HdrTrl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_HdrTrl;
    SELECT DISTINCT
         drvRecordCount = ISNULL(@rCount,0)
        ,drvAdministratorCode = '@AdministratorCode'
        ,drvEmployerCode = '@EmployerCode'
        ,drvSynchronizeFlag = 'N'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunDate
        ,drvFileVersion = '@FileVersion'
    INTO dbo.U_@CustomFormatCode_HdrTrl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = '@CustomerName_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201710091'
       ,expStartPerControl     = '201710091'
       ,expLastEndPerControl   = '201710169'
       ,expEndPerControl       = '201710169'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY InitialSort, SubSort;
GO