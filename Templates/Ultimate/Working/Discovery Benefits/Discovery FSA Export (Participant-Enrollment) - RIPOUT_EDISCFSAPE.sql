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
@CustomFormatCode - Replace with Format Code (i.e., EDISCFSAPE)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Discovery FSA Export - Participant-Enrollment)
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
@DedCodeTransit - Replace with Transit Deduction code (i.e., TRANS)
@DedCodeParking - Replace with Parking Deduction code (i.e., PARK)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Discovery\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Discovery\)
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
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PT') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_PT];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_EN') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_EN];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_DP') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_DP];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CT') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_CT];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_BK') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_BK];
GO
IF OBJECT_ID('U_@CustomFormatCode_DedList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DedList];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode','Discovery FSA Export (PT,EN,CT,BK,DP)','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FH"','1','(''DA''=''T|'')',@AdhSystemID,'2','H','01','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdministratorCode"','2','(''UA''=''T|'')',@AdhSystemID,'3','H','01','2',NULL,'Administrator Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','3','(''UA''=''T|'')',@AdhSystemID,'6','H','01','3',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"N"','4','(''DA''=''T|'')',@AdhSystemID,'1','H','01','4',NULL,'Synchronize Flag',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','H','01','5',NULL,'Submitted Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedTime"','6','(''UHMS''=''TI'')',@AdhSystemID,'6','H','01','6',NULL,'Submitted Time',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFileVersion"','7','(''UA''=''T'')',@AdhSystemID,'6','H','01','7',NULL,'File Version',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PT"','1','(''DA''=''T|'')',@AdhSystemID,'2','D','10','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','2','(''UA''=''T|'')',@AdhSystemID,'20','D','10','2',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerEmployeeID"','3','(''UA''=''T|'')',@AdhSystemID,'20','D','10','3',NULL,'Employer Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeNumber"','4','(''UA''=''T|'')',@AdhSystemID,'15','D','10','4',NULL,'Employee Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','5','(''UA''=''T|'')',@AdhSystemID,'30','D','10','5',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','6','(''UA''=''T|'')',@AdhSystemID,'30','D','10','6',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleInitial"','7','(''UA''=''T|'')',@AdhSystemID,'1','D','10','7',NULL,'Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','8','(''UA''=''T|'')',@AdhSystemID,'1','D','10','8',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMaritalStatus"','9','(''UA''=''T|'')',@AdhSystemID,'1','D','10','9',NULL,'Marital Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''T|'')',@AdhSystemID,'50','D','10','10',NULL,'Mothers Maiden Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateOfBirth"','11','(''UDMDY''=''T|'')',@AdhSystemID,'80','D','10','11',NULL,'Date Of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','12','(''UA''=''T|'')',@AdhSystemID,'9','D','10','12',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1"','13','(''UA''=''T|'')',@AdhSystemID,'30','D','10','13',NULL,'Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2"','14','(''UA''=''T|'')',@AdhSystemID,'30','D','10','14',NULL,'Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''T|'')',@AdhSystemID,'30','D','10','15',NULL,'Address Line 3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''T|'')',@AdhSystemID,'30','D','10','16',NULL,'Address Line 4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','17','(''UA''=''T|'')',@AdhSystemID,'30','D','10','17',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','18','(''UA''=''T|'')',@AdhSystemID,'2','D','10','18',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZipCode"','19','(''UA''=''T|'')',@AdhSystemID,'10','D','10','19',NULL,'Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountry"','20','(''UA''=''T|'')',@AdhSystemID,'2','D','10','20',NULL,'Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHomePhone"','21','(''UA''=''T|'')',@AdhSystemID,'10','D','10','21',NULL,'Home Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhone"','22','(''UA''=''T|'')',@AdhSystemID,'10','D','10','22',NULL,'Work Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvWorkPhoneExtension"','23','(''UA''=''T|'')',@AdhSystemID,'6','D','10','23',NULL,'Work Phone Extension',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmailAddress"','24','(''UA''=''T|'')',@AdhSystemID,'125','D','10','24',NULL,'Email Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','25','(''SS''=''T|'')',@AdhSystemID,'100','D','10','25',NULL,'Username',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','26','(''SS''=''T|'')',@AdhSystemID,'100','D','10','26',NULL,'Password',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHireDate"','27','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','27',NULL,'Hire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivision"','28','(''UA''=''T|'')',@AdhSystemID,'100','D','10','28',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHoursPerWeek"','29','(''UNT0''=''T|'')',@AdhSystemID,'2','D','10','29',NULL,'Hours Per Week',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"E"','30','(''DA''=''T|'')',@AdhSystemID,'100','D','10','30',NULL,'Employee Class',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollFrequency"','31','(''UA''=''T|'')',@AdhSystemID,'100','D','10','31',NULL,'Payroll Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','32','(''SS''=''T|'')',@AdhSystemID,'8','D','10','32',NULL,'Payroll Frequency Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantStatus"','33','(''UA''=''T|'')',@AdhSystemID,'20','D','10','33',NULL,'Participant Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatusEffectiveDate"','34','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','34',NULL,'Status Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHoldPayrollDeductions"','35','(''UA''=''T|'')',@AdhSystemID,'1','D','10','35',NULL,'Hold Payroll Deductions',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHoldEmployerContributions"','36','(''UA''=''T|'')',@AdhSystemID,'1','D','10','36',NULL,'Hold Employer Contributions',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIncurServices"','37','(''UA''=''T|'')',@AdhSystemID,'1','D','10','37',NULL,'Incur Services',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFinalPayrollProcessDate"','38','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','10','38',NULL,'Final Payroll Process Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFinalContribProcessDate"','39','(''UDMDY''=''T'')',@AdhSystemID,'8','D','10','39',NULL,'Final Contribution Process Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EN"','1','(''DA''=''T|'')',@AdhSystemID,'2','D','20','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','2','(''UA''=''T|'')',@AdhSystemID,'20','D','20','2',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','3','(''UA''=''T|'')',@AdhSystemID,'100','D','20','3',NULL,'Plan Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEnrollmentEffectiveDate"','4','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','20','4',NULL,'Enrollment Effective Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantElectionAmount"','5','(''UNT2''=''T|'')',@AdhSystemID,'8','D','20','5',NULL,'Participant Election Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEnrollmentTerminationDate"','6','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','20','6',NULL,'Enrollment Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''T|'')',@AdhSystemID,'10','D','20','7',NULL,'Employer Contribution Level',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''T|'')',@AdhSystemID,'8','D','20','8',NULL,'Employer Contribution Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''T|'')',@AdhSystemID,'30','D','20','9',NULL,'Primary Reimbursement',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''T|'')',@AdhSystemID,'30','D','20','10',NULL,'Alternate Reimbursement',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''T|'')',@AdhSystemID,'1','D','20','11',NULL,'Enrolled In Claims Exchange',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvElectionAmountIndicator"','12','(''UA''=''T|'')',@AdhSystemID,'8','D','20','12',NULL,'Election Amount Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHDHPCoverageLevel"','13','(''UA''=''T|'')',@AdhSystemID,'6','D','20','13',NULL,'HDHP Coverage Level',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''T|'')',@AdhSystemID,'8','D','20','14',NULL,'Plan Year Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','15','(''SS''=''T|'')',@AdhSystemID,'1','D','20','15',NULL,'Terms and Conditions Accepted',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''T|'')',@AdhSystemID,'8','D','20','16',NULL,'Date Terms Conditions Accepted',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','17','(''SS''=''T|'')',@AdhSystemID,'6','D','20','17',NULL,'Time Terms Conditions Accepted',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''T|'')',@AdhSystemID,'8','D','20','18',NULL,'Change Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','19','(''SS''=''T'')',@AdhSystemID,'1','D','20','19',NULL,'Spend Down',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CT"','1','(''DA''=''T|'')',@AdhSystemID,'2','D','30','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','2','(''UA''=''T|'')',@AdhSystemID,'20','D','30','2',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanName"','3','(''UA''=''T|'')',@AdhSystemID,'100','D','30','3',NULL,'Plan Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionDate"','4','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','30','4',NULL,'Contribution Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionDescription"','5','(''UA''=''T|'')',@AdhSystemID,'30','D','30','5',NULL,'Contribution Description',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvContributionAmount"','6','(''UNT2''=''T|'')',@AdhSystemID,'9','D','30','6',NULL,'Contribution Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Actual"','7','(''DA''=''T|'')',@AdhSystemID,'6','D','30','7',NULL,'Amount Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''T'')',@AdhSystemID,'7','D','30','8',NULL,'Tax Year',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BK"','1','(''DA''=''T|'')',@AdhSystemID,'2','D','40','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','2','(''UA''=''T|'')',@AdhSystemID,'20','D','40','2',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNickname"','3','(''UA''=''T|'')',@AdhSystemID,'20','D','40','3',NULL,'Nickname',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountUse"','4','(''UA''=''T|'')',@AdhSystemID,'30','D','40','4',NULL,'Account Use',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountType"','5','(''UA''=''T|'')',@AdhSystemID,'1','D','40','5',NULL,'Account Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountStatus"','6','(''UA''=''T|'')',@AdhSystemID,'1','D','40','6',NULL,'Account Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankName"','7','(''UA''=''T|'')',@AdhSystemID,'30','D','40','7',NULL,'Bank Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRoutingNumber"','8','(''UA''=''T|'')',@AdhSystemID,'9','D','40','8',NULL,'Routing Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountNumber"','9','(''UA''=''T|'')',@AdhSystemID,'17','D','40','9',NULL,'Account Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPrenote"','10','(''UA''=''T|'')',@AdhSystemID,'1','D','40','10',NULL,'Prenote',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankAccountAddressLine1"','11','(''UA''=''T|'')',@AdhSystemID,'30','D','40','11',NULL,'Bank Account Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankAccountAddressLine2"','12','(''UA''=''T|'')',@AdhSystemID,'30','D','40','12',NULL,'Bank Account Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankCity"','13','(''UA''=''T|'')',@AdhSystemID,'30','D','40','13',NULL,'Bank City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankState"','14','(''UA''=''T|'')',@AdhSystemID,'2','D','40','14',NULL,'Bank State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankZipCode"','15','(''UA''=''T|'')',@AdhSystemID,'10','D','40','15',NULL,'Bank Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBankCountry"','16','(''UA''=''T'')',@AdhSystemID,'2','D','40','16',NULL,'Bank Country',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DP"','1','(''DA''=''T|'')',@AdhSystemID,'2','D','50','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFileImportID"','2','(''UA''=''T|'')',@AdhSystemID,'20','D','50','2',NULL,'Participant File Import ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDependentFileImportId"','3','(''UA''=''T|'')',@AdhSystemID,'20','D','50','3',NULL,'Dependent File Import Id',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDependentNumber"','4','(''UA''=''T|'')',@AdhSystemID,'10','D','50','4',NULL,'Dependent Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRelationship"','5','(''UA''=''T|'')',@AdhSystemID,'9','D','50','5',NULL,'Relationship',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','6','(''UA''=''T|'')',@AdhSystemID,'30','D','50','6',NULL,'Last Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','7','(''UA''=''T|'')',@AdhSystemID,'30','D','50','7',NULL,'First Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleInitial"','8','(''UA''=''T|'')',@AdhSystemID,'1','D','50','8',NULL,'Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','9','(''UA''=''T|'')',@AdhSystemID,'1','D','50','9',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateOfBirth"','10','(''UDMDY''=''T|'')',@AdhSystemID,'8','D','50','10',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','11','(''UA''=''T|'')',@AdhSystemID,'9','D','50','11',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatus"','12','(''UA''=''T|'')',@AdhSystemID,'8','D','50','12',NULL,'Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStudent"','13','(''UA''=''T|'')',@AdhSystemID,'1','D','50','13',NULL,'Student',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvIssueCard"','14','(''UA''=''T|'')',@AdhSystemID,'1','D','50','14',NULL,'Issue Card',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvExternalDependentID"','15','(''UA''=''T'')',@AdhSystemID,'20','D','50','15',NULL,'External Dependent ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FF"','1','(''DA''=''T|'')',@AdhSystemID,'2','T','90','1',NULL,'Record Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRecordCount"','2','(''UA''=''T|'')',@AdhSystemID,'20','T','90','2',NULL,'Record Count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdministratorCode"','3','(''UA''=''T|'')',@AdhSystemID,'3','T','90','3',NULL,'Administrator Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerCode"','4','(''UA''=''T|'')',@AdhSystemID,'6','T','90','4',NULL,'Employer Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedDate"','5','(''UDMDY''=''T|'')',@AdhSystemID,'8','T','90','5',NULL,'Submitted Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubmittedTime"','6','(''UHMS''=''T'')',@AdhSystemID,'6','T','90','6',NULL,'Submitted Time',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Export','201710019','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710019','Oct  1 2017  5:20PM','Oct  1 2017  5:20PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201710019','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710019','Oct  1 2017  5:20PM','Oct  1 2017  5:20PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201710019','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710019','Oct  1 2017  5:20PM','Oct  1 2017  5:20PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201710019','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710019','Oct  1 2017  5:20PM','Oct  1 2017  5:20PM','201710011',NULL,'','','201710011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','dbo.U_@CustomFormatCode_HdrTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_PT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_EN',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_drvTbl_CT',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_@CustomFormatCode_drvTbl_BK',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_@CustomFormatCode_drvTbl_DP',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','dbo.U_@CustomFormatCode_HdrTrl',NULL);
GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(2000) NULL
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

Purpose: Discovery FSA Export (PT,EN,CT,BK,DP)

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@RunDate         = GETDATE()
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    -- Set FSA Plan Year Start
    SET @PlanYearStart = CASE WHEN MONTH(@EndDate) = 12 THEN '01/01/' + CONVERT(CHAR(4),YEAR(DATEADD(YEAR,1,@EndDate)))
                              ELSE '01/01/' + CONVERT(CHAR(4),YEAR(@EndDate))
                         END;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedTypes','FSA,HSA');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'IncludeOEDrops','N');
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
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

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
                               WHEN PdhDedCode = '@DedCodeTransit' THEN 'Mass Transit'
                               WHEN PdhDedCode = '@DedCodeParking' THEN 'Parking'
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
              WHEN PdhDedCode = '@DedCodeTransit' THEN 'Mass Transit'
              WHEN PdhDedCode = '@DedCodeParking' THEN 'Parking'
        END
    HAVING (SUM(PdhEECurAmt) <> 0.00);

    -- Insert employer contributions (ER Amount)
    INSERT INTO dbo.U_@CustomFormatCode_PDedHist
    SELECT DISTINCT
         PdhEEID
        ,PdhPlanName    = CASE WHEN PdhDedCode = 'FSAHC' THEN 'Medical FSA'
                               WHEN PdhDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
                               WHEN PdhDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
                               WHEN PdhDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
                               WHEN PdhDedCode = '@DedCodeTransit' THEN 'Mass Transit'
                               WHEN PdhDedCode = '@DedCodeParking' THEN 'Parking'
                          END
        ,PdhPerControl  = MAX(LEFT(PdhPerControl,8))
        ,PdhContribDesc = 'Employer Contribution'
        ,PdhCurAmt      = SUM(PdhERCurAmt)
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    AND PdhDedCode IN ('@DedCodeFSAMedical','@DedCodeFSADependent','@DedCodeFSALimited','@DedCodeHSA')
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode = 'FSAHC' THEN 'Medical FSA'
              WHEN PdhDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
              WHEN PdhDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
              WHEN PdhDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
              WHEN PdhDedCode = '@DedCodeTransit' THEN 'Mass Transit'
              WHEN PdhDedCode = '@DedCodeParking' THEN 'Parking'
         END
    HAVING (SUM(PdhERCurAmt) <> 0.00);

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ----------------------------------------
    -- Detail Record - Participant (PT)
    ----------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_PT','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_PT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = EepSSN
        ,drvEmployerEmployeeID = ''
        ,drvEmployeeNumber = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSSN = EepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkPhoneExtension = EecPhoneBusinessNumber
        ,drvEmailAddress = EepAddressEMail
        ,drvHireDate = EecDateOfLastHire
        ,drvDivision = ''
        ,drvHoursPerWeek = CASE EecPayPeriod
                                WHEN 'W' THEN EecScheduledWorkHrs
                                WHEN 'B' THEN EecScheduledWorkHrs / 2
                                WHEN 'S' THEN (EecScheduledWorkHrs * 2) / 4
                                WHEN 'M' THEN EecScheduledWorkHrs / 4
                           END
        ,drvPayrollFrequency = CASE EecPayPeriod
                                    WHEN 'W' THEN 'Weekly'
                                    WHEN 'B' THEN 'Bi-Weekly'
                                    WHEN 'S' THEN 'Semi-Monthly'
                                    WHEN 'M' THEN 'Monthly'
                               END
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
    INTO dbo.U_@CustomFormatCode_drvTbl_PT
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID;

    ----------------------------------------
    -- Detail Record - Enrollment (EN)
    ----------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_EN','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_EN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = EepSSN
        ,drvPlanName = CASE WHEN BdmDedCode = '@DedCodeFSAMedical' THEN 'Medical FSA'
                            WHEN BdmDedCode = '@DedCodeFSADependent' THEN 'Dependent Care FSA'
                            WHEN BdmDedCode = '@DedCodeFSALimited' THEN 'Limited Medical FSA'
                            WHEN BdmDedCode = '@DedCodeHSA' THEN 'Health Savings Account'
                            WHEN BdmDedCode = '@DedCodeTransit' THEN 'Mass Transit'
                            WHEN BdmDedCode = '@DedCodeParking' THEN 'Parking'
                       END
        ,drvEnrollmentEffectiveDate = CASE WHEN BdmDedType IN ('HSA','FSA') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate,@PlanYearStart)
                                           ELSE BdmBenStartDate
                                      END
        ,drvParticipantElectionAmount = CASE WHEN BdmDedType = 'FSA' THEN BdmEEGoalAmt --Annual election amounts for FSAs.
                                             WHEN BdmDedCode IN ('PARKING','TRANSIT') THEN BdmEEAmt --Monthly election amounts for Parking and Transit plans.
                                             ELSE 0.00 --0 for HSAs.
                                        END
        ,drvEnrollmentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvElectionAmountIndicator = CASE WHEN DedDedType = 'HSA' THEN 'PerPay'
                                           WHEN BdmDedCode IN ('@DedCodeTransit','@DedCodeParking') THEN 'Per Month'
                                      END
        ,drvHDHPCoverageLevel = CASE WHEN NULLIF(BdmBenOption,'') = 'EE' THEN 'Single'
                                     WHEN NULLIF(BdmBenOption,'') IS NOT NULL THEN 'Family'
                                END
    INTO dbo.U_@CustomFormatCode_drvTbl_EN
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID;

    ----------------------------------------
    -- Detail Record - Contribution (CT)
    ----------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_CT','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_CT;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvInitialSort = RTRIM(EepSSN)
        -- standard fields above and additional driver fields below
        drvParticipantFileImportID = EepSSN
        ,drvPlanName = PdhPlanName
        ,drvContributionDate = PdhPerControl
        ,drvContributionDescription = PdhContribDesc
        ,drvContributionAmount = PdhCurAmt
        ,drvEEID = xEEID
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl_CT
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    WHERE @ExportCode NOT LIKE 'OE%';

    ----------------------------------------
    -- Detail Record - Bank Account (BK)
    ----------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_BK','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_BK;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
        -- standard fields above and additional driver fields below
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

    ----------------------------------------
    -- Detail Record - Dependent (DP)
    ----------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_DP','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_DP;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID
        ,drvInitialSort = RTRIM(EepSSN)
        -- standard fields above and additional driver fields below
        ,drvParticipantFileImportID = EepSSN
        ,drvDependentFileImportId = ConSSN
        ,drvDependentNumber = ''
        ,drvRelationship = CASE WHEN ConRelationship = 'SPS' THEN 'Spouse'
                                ELSE 'Dependent'
                           END
        ,drvLastName = ConNameLast
        ,drvFirstName = ConNameFirst
        ,drvMiddleInitial = LEFT(ConNameMiddle,1)
        ,drvGender = CASE WHEN ConGender IN ('M','F') THEN ConGender END
        ,drvDateOfBirth = ConDateOfBirth
        ,drvSSN = ConSSN
        ,drvStatus = 'Active'
        ,drvStudent = ConIsStudent
        ,drvIssueCard = ''
        ,drvExternalDependentID = ''
    INTO dbo.U_@CustomFormatCode_drvTbl_DP
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID;

    ----------------------------------------
    -- Header / Trailer Record
    ----------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_HdrTrl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_HdrTrl;
    SELECT DISTINCT
         drvAdministratorCode = '@AdministratorCode'
        ,drvRecordCount = (SELECT COUNT(1) FROM dbo.U_@CustomFormatCode_drvTbl_PT) +
                          (SELECT COUNT(1) FROM dbo.U_@CustomFormatCode_drvTbl_EN) +
                          (SELECT COUNT(1) FROM dbo.U_@CustomFormatCode_drvTbl_CT) + 
                          (SELECT COUNT(1) FROM dbo.U_@CustomFormatCode_drvTbl_BK) + 
                          (SELECT COUNT(1) FROM dbo.U_@CustomFormatCode_drvTbl_DP)
        ,drvEmployerCode = '@EmployerCode'
        ,drvSubmittedDate = @RunDate
        ,drvSubmittedTime = @RunDate
        ,drvFileVersion = '2.0'
    INTO dbo.U_@CustomFormatCode_HdrTrl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('@CustomFormatCode','Testing') = 'Y' THEN '_TEST_' + CONVERT(VARCHAR(8),GETDATE(),112) + '_@FileGroupName_@EmployerCode.txt'
                                  ELSE '' + CONVERT(VARCHAR(8),GETDATE(),112) + '_@FileGroupName_@EmployerCode.txt'
                             END
        WHERE FormatCode = '@CustomFormatCode';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY InitialSort, SubSort, RIGHT(RecordSet,2);

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201710011'
       ,ExpStartPerControl     = '201710011'
       ,ExpLastEndPerControl   = '201710019'
       ,ExpEndPerControl       = '201710019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY InitialSort, SubSort, RIGHT(RecordSet,2)
GO