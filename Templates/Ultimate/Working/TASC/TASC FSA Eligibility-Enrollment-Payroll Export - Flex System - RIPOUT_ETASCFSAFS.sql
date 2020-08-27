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
@CustomFormatCode - Replace with Format Code (i.e., ETASCFSAFS)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., TASC FSA Export - Flex System)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@ClientTASCID - Replace with Client ID assigned by TASC
@PlanTASCID - Plan ID number assigned by TASC

-- Data parameters
@DedCodeList - Replace with Deduction Code List (i.e., FSAMD,FSADC,TRANSIT,PARKING)
@FSAMedicalDedCodes - Replace with FSA Medical Deduction Code List (i.e., FSAMD)
@FSADependentCareDedCodes - Replace with FSA Dependent Care Deduction Code List (i.e., FSADC)
@106DedCodes - Replace with 106 for Non-Employer Sponsored Health Premiums Deduction Code List
@TransitDedCodes - Replace with Transportation - Transit Deduction Code List (i.e., TRANSIT)
@ParkingDedCodes - Replace with Transportation - Parking Deduction Code List (i.e., PARKING)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\WexHealth\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\WexHealth\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_DedCodes') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DedCodes];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode','TASC FSA Export - Flex System','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Client TASC ID"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','01','1',NULL,'Client TASC ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Plan TASC ID"','2','(''DA''=''T,'')',@AdhSystemID,'50','H','01','2',NULL,'Plan TASC ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Participant TASC ID"','3','(''DA''=''T,'')',@AdhSystemID,'50','H','01','3',NULL,'Participant TASC ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee ID"','4','(''DA''=''T,'')',@AdhSystemID,'50','H','01','4',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Action Code (C T A)"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','01','5',NULL,'Action Code(C,T,A)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Email Address - Participant"','6','(''DA''=''T,'')',@AdhSystemID,'50','H','01','6',NULL,'Email Address - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Last Name - Participant"','7','(''DA''=''T,'')',@AdhSystemID,'50','H','01','7',NULL,'Last Name - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"First Name - Participant"','8','(''DA''=''T,'')',@AdhSystemID,'50','H','01','8',NULL,'First Name - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Middle Initial - Participant"','9','(''DA''=''T,'')',@AdhSystemID,'50','H','01','9',NULL,'Middle Initial - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Address Line 1 - Participant"','10','(''DA''=''T,'')',@AdhSystemID,'50','H','01','10',NULL,'Address Line 1 - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Address Line 2 - Participant"','11','(''DA''=''T,'')',@AdhSystemID,'50','H','01','11',NULL,'Address Line 2 - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"City - Participant"','12','(''DA''=''T,'')',@AdhSystemID,'50','H','01','12',NULL,'City - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"State - Participant"','13','(''DA''=''T,'')',@AdhSystemID,'50','H','01','13',NULL,'State - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Zip Code - Participant"','14','(''DA''=''T,'')',@AdhSystemID,'50','H','01','14',NULL,'Zip Code - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Payroll Date"','15','(''DA''=''T,'')',@AdhSystemID,'50','H','01','15',NULL,'Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MED Eligibility Start Date"','16','(''DA''=''T,'')',@AdhSystemID,'50','H','01','16',NULL,'MED Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MED Eligibility End Date"','17','(''DA''=''T,'')',@AdhSystemID,'50','H','01','17',NULL,'MED Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DEP Eligibility Start Date"','18','(''DA''=''T,'')',@AdhSystemID,'50','H','01','18',NULL,'DEP Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DEP Eligibility End Date"','19','(''DA''=''T,'')',@AdhSystemID,'50','H','01','19',NULL,'DEP Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"106 Eligibility Start Date"','20','(''DA''=''T,'')',@AdhSystemID,'50','H','01','20',NULL,'106 Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"106 Eligibility End Date"','21','(''DA''=''T,'')',@AdhSystemID,'50','H','01','21',NULL,'106 Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TRN Eligibility Start Date"','22','(''DA''=''T,'')',@AdhSystemID,'50','H','01','22',NULL,'TRN Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TRN Eligibility End Date"','23','(''DA''=''T,'')',@AdhSystemID,'50','H','01','23',NULL,'TRN Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRK Eligibility Start Date"','24','(''DA''=''T,'')',@AdhSystemID,'50','H','01','24',NULL,'PRK Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRK Eligibility End Date"','25','(''DA''=''T,'')',@AdhSystemID,'50','H','01','25',NULL,'PRK Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employment Termination Date"','26','(''DA''=''T,'')',@AdhSystemID,'50','H','01','26',NULL,'Employment Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Termination Last Payroll Date"','27','(''DA''=''T,'')',@AdhSystemID,'50','H','01','27',NULL,'Termination Last Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employment Termination Type (1 2 or 3)"','28','(''DA''=''T,'')',@AdhSystemID,'50','H','01','28',NULL,'Employment Termination Type (1,2 or 3)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MED Acct. - Participants Per Pay-Period Contribution"','29','(''DA''=''T,'')',@AdhSystemID,'60','H','01','29',NULL,'MED Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DEP Acct. - Participants Per Pay-Period Contribution"','30','(''DA''=''T,'')',@AdhSystemID,'60','H','01','30',NULL,'DEP Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"106 Acct. - Participants Per Pay-Period Contribution"','31','(''DA''=''T,'')',@AdhSystemID,'60','H','01','31',NULL,'106 Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TRN Acct. - Participants Per Pay-Period Contribution"','32','(''DA''=''T,'')',@AdhSystemID,'60','H','01','32',NULL,'TRN Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRK Acct. - Participants Per Pay-Period Contribution"','33','(''DA''=''T,'')',@AdhSystemID,'60','H','01','33',NULL,'PRK Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MED Acct. - Clients Per Pay-Period Contribution"','34','(''DA''=''T,'')',@AdhSystemID,'60','H','01','34',NULL,'MED Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DEP Acct. - Clients Per Pay-Period Contribution"','35','(''DA''=''T,'')',@AdhSystemID,'60','H','01','35',NULL,'DEP Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"106 Acct. -  Clients Per Pay-Period Contribution"','36','(''DA''=''T,'')',@AdhSystemID,'60','H','01','36',NULL,'106 Acct. -  Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TRN Acct. - Clients Per Pay-Period Contribution"','37','(''DA''=''T,'')',@AdhSystemID,'60','H','01','37',NULL,'TRN Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRK Acct. - Clients Per Pay-Period Contribution"','38','(''DA''=''T,'')',@AdhSystemID,'60','H','01','38',NULL,'PRK Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MED Acct. - Participants Annual Election"','39','(''DA''=''T,'')',@AdhSystemID,'50','H','01','39',NULL,'MED Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DEP Acct. - Participants Annual Election"','40','(''DA''=''T,'')',@AdhSystemID,'50','H','01','40',NULL,'DEP Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"106 Acct. - Participants Annual Election"','41','(''DA''=''T,'')',@AdhSystemID,'50','H','01','41',NULL,'106 Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TRN Acct. - Participants Annual Election"','42','(''DA''=''T,'')',@AdhSystemID,'50','H','01','42',NULL,'TRN Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRK Acct. - Participants Annual Election"','43','(''DA''=''T,'')',@AdhSystemID,'50','H','01','43',NULL,'PRK Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MED Acct. - Clients Annual Election"','44','(''DA''=''T,'')',@AdhSystemID,'50','H','01','44',NULL,'MED Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DEP Acct. - Clients Annual Election"','45','(''DA''=''T,'')',@AdhSystemID,'50','H','01','45',NULL,'DEP Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"106 Acct. - Clients Annual Election"','46','(''DA''=''T,'')',@AdhSystemID,'50','H','01','46',NULL,'106 Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TRN Acct. - Clients Annual Election"','47','(''DA''=''T,'')',@AdhSystemID,'50','H','01','47',NULL,'TRN Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRK Acct. - Clients Annual Election"','48','(''DA''=''T,'')',@AdhSystemID,'50','H','01','48',NULL,'PRK Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Division"','49','(''DA''=''T,'')',@AdhSystemID,'50','H','01','49',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Section"','50','(''DA''=''T,'')',@AdhSystemID,'50','H','01','50',NULL,'Section',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Alternate Participant ID"','51','(''DA''=''T'')',@AdhSystemID,'50','H','01','51',NULL,'Alternate Participant ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClientTASCID"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','10','1',NULL,'Client TASC ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanTASCID"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','10','2',NULL,'Plan TASC ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantTASCID"','3','(''UA''=''T,'')',@AdhSystemID,'50','D','10','3',NULL,'Participant TASC ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeID"','4','(''UA''=''T,'')',@AdhSystemID,'50','D','10','4',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvActionCodeCTA"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'Action Code(C,T,A)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmailAddressParticipant"','6','(''UA''=''T,'')',@AdhSystemID,'50','D','10','6',NULL,'Email Address - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastNameParticipant"','7','(''UA''=''T,'')',@AdhSystemID,'50','D','10','7',NULL,'Last Name - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstNameParticipant"','8','(''UA''=''T,'')',@AdhSystemID,'50','D','10','8',NULL,'First Name - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleInitialParticipant"','9','(''UA''=''T,'')',@AdhSystemID,'50','D','10','9',NULL,'Middle Initial - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1Participant"','10','(''UA''=''T,'')',@AdhSystemID,'50','D','10','10',NULL,'Address Line 1 - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2Participant"','11','(''UA''=''T,'')',@AdhSystemID,'50','D','10','11',NULL,'Address Line 2 - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCityParticipant"','12','(''UA''=''T,'')',@AdhSystemID,'50','D','10','12',NULL,'City - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStateParticipant"','13','(''UA''=''T,'')',@AdhSystemID,'50','D','10','13',NULL,'State - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZipCodeParticipant"','14','(''UA''=''T,'')',@AdhSystemID,'50','D','10','14',NULL,'Zip Code - Participant',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDate"','15','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','15',NULL,'Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEDEligibilityStartDate"','16','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','16',NULL,'MED Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEDEligibilityEndDate"','17','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','17',NULL,'MED Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDEPEligibilityStartDate"','18','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','18',NULL,'DEP Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDEPEligibilityEndDate"','19','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','19',NULL,'DEP Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drv106EligibilityStartDate"','20','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','20',NULL,'106 Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drv106EligibilityEndDate"','21','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','21',NULL,'106 Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTRNEligibilityStartDate"','22','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','22',NULL,'TRN Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTRNEligibilityEndDate"','23','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','23',NULL,'TRN Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRKEligibilityStartDate"','24','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','24',NULL,'PRK Eligibility Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRKEligibilityEndDate"','25','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','25',NULL,'PRK Eligibility End Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmploymentTerminationDate"','26','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','26',NULL,'Employment Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTerminationLastPayrollDate"','27','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','27',NULL,'Termination Last Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmploymentTerminationType"','28','(''UA''=''T,'')',@AdhSystemID,'50','D','10','28',NULL,'Employment Termination Type (1,2 or 3)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEDAcctParticipantsPPPCont"','29','(''UA''=''T,'')',@AdhSystemID,'50','D','10','29',NULL,'MED Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDEPAcctParticipantsPPPCont"','30','(''UA''=''T,'')',@AdhSystemID,'50','D','10','30',NULL,'DEP Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drv106AcctParticipantsPPPCont"','31','(''UA''=''T,'')',@AdhSystemID,'50','D','10','31',NULL,'106 Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTRNAcctParticipantsPPPCont"','32','(''UA''=''T,'')',@AdhSystemID,'50','D','10','32',NULL,'TRN Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRKAcctParticipantsPPPCont"','33','(''UA''=''T,'')',@AdhSystemID,'50','D','10','33',NULL,'PRK Acct. - Participant''s Per Pay-Period Contribut',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEDAcctClientsPPPCont"','34','(''UA''=''T,'')',@AdhSystemID,'50','D','10','34',NULL,'MED Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDEPAcctClientsPPPCont"','35','(''UA''=''T,'')',@AdhSystemID,'50','D','10','35',NULL,'DEP Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drv106AcctClientsPPPCont"','36','(''UA''=''T,'')',@AdhSystemID,'50','D','10','36',NULL,'106 Acct. -  Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTRNAcctClientsPPPCont"','37','(''UA''=''T,'')',@AdhSystemID,'50','D','10','37',NULL,'TRN Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRKAcctClientsPPPCont"','38','(''UA''=''T,'')',@AdhSystemID,'50','D','10','38',NULL,'PRK Acct. - Client''s Per Pay-Period Contribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEDAcctParticipantAnnElect"','39','(''UA''=''T,'')',@AdhSystemID,'50','D','10','39',NULL,'MED Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDEPAcctParticipantAnnElect"','40','(''UA''=''T,'')',@AdhSystemID,'50','D','10','40',NULL,'DEP Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drv106AcctParticipantAnnElect"','41','(''UA''=''T,'')',@AdhSystemID,'50','D','10','41',NULL,'106 Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTRNAcctParticipantAnnElect"','42','(''UA''=''T,'')',@AdhSystemID,'50','D','10','42',NULL,'TRN Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRKAcctParticipantAnnElect"','43','(''UA''=''T,'')',@AdhSystemID,'50','D','10','43',NULL,'PRK Acct. - Participant''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEDAcctClientsAnnElect"','44','(''UA''=''T,'')',@AdhSystemID,'50','D','10','44',NULL,'MED Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDEPAcctClientsAnnElect"','45','(''UA''=''T,'')',@AdhSystemID,'50','D','10','45',NULL,'DEP Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drv106AcctClientsAnnElect"','46','(''UA''=''T,'')',@AdhSystemID,'50','D','10','46',NULL,'106 Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTRNAcctClientsAnnElect"','47','(''UA''=''T,'')',@AdhSystemID,'50','D','10','47',NULL,'TRN Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRKAcctClientsAnnElect"','48','(''UA''=''T,'')',@AdhSystemID,'50','D','10','48',NULL,'PRK Acct. - Client''s Annual Election',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivision"','49','(''UA''=''T,'')',@AdhSystemID,'50','D','10','49',NULL,'Division',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSection"','50','(''UA''=''T,'')',@AdhSystemID,'50','D','10','50',NULL,'Section',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAlternateParticipantID"','51','(''UA''=''T'')',@AdhSystemID,'50','D','10','51',NULL,'Alternate Participant ID',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201710209','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017  2:21PM','Oct 20 2017  2:21PM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201710209','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017  2:21PM','Oct 20 2017  2:21PM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Enrollment File - OnDemand','201710209','EMPEXPORT','ENROLLMENT','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Eligibility File - OnDemand','201710209','EMPEXPORT','ELIGIBILTY','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Payroll File - OnDemand','201710209','EMPEXPORT','PAYROLL','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Enrollment File - Test','201710209','EMPEXPORT','TESTENROLL','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Eligibility File - Test','201710209','EMPEXPORT','TESTELIG','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Payroll File - Test','201710209','EMPEXPORT','TESTPAYROL','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Enrollment File - Scheduled','201710209','EMPEXPORT','SHDENROLL','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Eligibility File - Scheduled','201710209','EMPEXPORT','SHDELIG','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Payroll File - Scheduled','201710209','EMPEXPORT','SHDPAYROLL','Oct 20 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201710209','Oct 20 2017 12:00AM','Dec 30 1899 12:00AM','201710201',NULL,'','','201710201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
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
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
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

Purpose: TASC FSA Eligibility-Enrollment-Payroll Export

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
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ENROLLMENT';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ELIGIBILTY';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'PAYROLL';

EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';

EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TESTENROLL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TESTELIG';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TESTPAYROL';

EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SHDENROLL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SHDELIG';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SHDPAYROLL';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'N'
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
            ,@PlanStartDate     DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = '@CustomFormatCode';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@PlanStartDate   = '01/01/' + LEFT(EndPerControl,4)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Deduction Code List
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_DedCodes','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DedCodes;
    SELECT DISTINCT
         DedDedCode
        ,DedDedType
        ,DedPlanType = CASE WHEN DedDedCode IN ('@FSAMedicalDedCodes') THEN 'MED'
                            WHEN DedDedCode IN ('@FSADependentCareDedCodes') THEN 'DEP'
                            WHEN DedDedCode IN ('@106DedCodes') THEN '106'
                            WHEN DedDedCode IN ('@TransitDedCodes') THEN 'TRN'
                            WHEN DedDedCode IN ('@ParkingDedCodes') THEN 'PRK'
                       END
    INTO dbo.U_@CustomFormatCode_DedCodes
    FROM dbo.DedCode WITH (NOLOCK)
    WHERE DedDedCode IN ('@FSAMedicalDedCodes','@FSADependentCareDedCodes','@106DedCodes','@TransitDedCodes','@ParkingDedCodes')

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','@DedCodeList');
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
    SELECT DISTINCT
         PdhEEID
        ,PdhPerControl = LEFT(PdhPerControl,8)
        ,PdhPlanType = DedPlanType
        -- Categorize Payroll Amounts
        -- Employee (EE) Amount
        ,MEDEmployeeAmt  = SUM(CASE WHEN DedPlanType = 'MED' THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,DEPEmployeeAmt  = SUM(CASE WHEN DedPlanType = 'DEP' THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,x106EmployeeAmt = SUM(CASE WHEN DedPlanType = '106' THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,TRNEmployeeAmt  = SUM(CASE WHEN DedPlanType = 'TRN' THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PRKEmployeeAmt  = SUM(CASE WHEN DedPlanType = 'PRK' THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        -- Employer (ER) Amount
        ,MEDEmployerAmt  = SUM(CASE WHEN DedPlanType = 'MED' THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,DEPEmployerAmt  = SUM(CASE WHEN DedPlanType = 'DEP' THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,x106EmployerAmt = SUM(CASE WHEN DedPlanType = '106' THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,TRNEmployerAmt  = SUM(CASE WHEN DedPlanType = 'TRN' THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
        ,PRKEmployerAmt  = SUM(CASE WHEN DedPlanType = 'PRK' THEN ISNULL(PdhERCurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_DedCodes WITH (NOLOCK)
        ON DedDedCode = PdhDedCode
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, LEFT(PdhPerControl,8), DedPlanType
    HAVING (SUM(PdhEECurAmt) <> 0.00 OR SUM(PdhERCurAmt) <> 0.00);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EecEmpNo)
        -- standard fields above and additional driver fields below
        ,drvClientTASCID = '@ClientTASCID'
        ,drvPlanTASCID = '@PlanTASCID'
        ,drvParticipantTASCID = ''
        ,drvEmployeeID = EecEmpNo
        ,drvActionCodeCTA = CASE WHEN @ExportCode LIKE '%OE%' THEN 'A'
								 WHEN EecEmplStatus = 'T' THEN 'T' 
								 WHEN EecDateOfLastHire >= @PlanStartDate THEN 'A'
                                 ELSE 'C'
                            END
        ,drvEmailAddressParticipant = EepAddressEMail
        ,drvLastNameParticipant = EepNameLast
        ,drvFirstNameParticipant = EepNameFirst
        ,drvMiddleInitialParticipant = LEFT(EepNameMiddle,1)
        ,drvAddressLine1Participant = EepAddressLine1
        ,drvAddressLine2Participant = EepAddressLine2
        ,drvCityParticipant = EepAddressCity
        ,drvStateParticipant = EepAddressState
        ,drvZipCodeParticipant = EepAddressZipCode
        ,drvPayrollDate = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN PdhPerControl END)
        ,drvMEDEligibilityStartDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'MED' THEN BdmBenStartDate END)
        ,drvMEDEligibilityEndDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND DedPlanType = 'MED' THEN BdmBenStopDate END)
        ,drvDEPEligibilityStartDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'DEP' THEN BdmBenStartDate END)
        ,drvDEPEligibilityEndDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND DedPlanType = 'DEP' THEN BdmBenStopDate END)
        ,drv106EligibilityStartDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = '106' THEN BdmBenStartDate END)
        ,drv106EligibilityEndDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND DedPlanType = '106' THEN BdmBenStopDate END)
        ,drvTRNEligibilityStartDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'TRN' THEN BdmBenStartDate END)
        ,drvTRNEligibilityEndDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND DedPlanType = 'TRN' THEN BdmBenStopDate END)
        ,drvPRKEligibilityStartDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'PRK' THEN BdmBenStartDate END)
        ,drvPRKEligibilityEndDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND DedPlanType = 'PRK' THEN BdmBenStopDate END)
        ,drvEmploymentTerminationDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND EecEmplStatus = 'T' THEN EecDateOfTermination END)
        ,drvTerminationLastPayrollDate = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND EecEmplStatus = 'T' THEN EecDateLastPayDatePaid END)
        ,drvEmploymentTerminationType = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' AND EecEmplStatus = 'T' THEN '3' END) --3 = Terminate employment, retain current annual elections.
        ,drvMEDAcctParticipantsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),MEDEmployeeAmt) END)
        ,drvDEPAcctParticipantsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),DEPEmployeeAmt) END)
        ,drv106AcctParticipantsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),x106EmployeeAmt) END)
        ,drvTRNAcctParticipantsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),TRNEmployeeAmt) END)
        ,drvPRKAcctParticipantsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),PRKEmployeeAmt) END)
        ,drvMEDAcctClientsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),MEDEmployerAmt) END)
        ,drvDEPAcctClientsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),DEPEmployerAmt) END)
        ,drv106AcctClientsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),x106EmployerAmt) END)
        ,drvTRNAcctClientsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),TRNEmployerAmt) END)
        ,drvPRKAcctClientsPPPCont = MAX(CASE WHEN @ExportCode LIKE '%PAY%' THEN CONVERT(VARCHAR(11),PRKEmployerAmt) END)
        ,drvMEDAcctParticipantAnnElect = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'MED' THEN CONVERT(VARCHAR(11),BdmEEGoalAmt) END)
        ,drvDEPAcctParticipantAnnElect = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'DEP' THEN CONVERT(VARCHAR(11),BdmEEGoalAmt) END)
        ,drv106AcctParticipantAnnElect = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = '106' THEN CONVERT(VARCHAR(11),BdmEEGoalAmt) END)
        ,drvTRNAcctParticipantAnnElect = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'TRN' THEN CONVERT(VARCHAR(11),BdmEEGoalAmt) END)
        ,drvPRKAcctParticipantAnnElect = MAX(CASE WHEN @ExportCode LIKE '%ELIG%' OR @ExportCode LIKE '%ENROLL%' AND DedPlanType = 'PRK' THEN CONVERT(VARCHAR(11),BdmEEGoalAmt) END)
        ,drvMEDAcctClientsAnnElect = ''
        ,drvDEPAcctClientsAnnElect = ''
        ,drv106AcctClientsAnnElect = ''
        ,drvTRNAcctClientsAnnElect = ''
        ,drvPRKAcctClientsAnnElect = ''
        ,drvDivision = ''
        ,drvSection = ''
        ,drvAlternateParticipantID = ''
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_@CustomFormatCode_DedCodes WITH (NOLOCK)
        ON DedDedCode = BdmDedCode
    LEFT JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    GROUP BY xEEID,xCoID,EecEmpNo,EecEmplStatus,EecDateOfLastHire,EepAddressEMail,EepNameLast,EepNameFirst,EepNameMiddle,EepAddressLine1,EepAddressLine2,EepAddressCity,EepAddressState,EepAddressZipCode;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
         SET ExportFile = CASE WHEN @ExportCode LIKE 'TEST%' OR dbo.dsi_fnVariable('ETASC','Testing') = 'Y' THEN 'TEST_' ELSE '' END
                            + '@ClientTASCID_'
                            + CASE WHEN @ExportCode LIKE '%ENROLL%' THEN '@PlanTASCID_ENR_'
                                   WHEN @ExportCode LIKE '%ELIG%' THEN 'ELI_'
                                   WHEN @ExportCode LIKE '%PAY%' THEN 'PVR_'
                              END
                            + CONVERT(VARCHAR(10),GETDATE(),120)
                            + '.csv'
        WHERE FormatCode = @FormatCode;
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201710131'
       ,expStartPerControl     = '201710131'
       ,expLastEndPerControl   = '201710209'
       ,expEndPerControl       = '201710209'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO