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
@CustomFormatCode - Replace with Format Code (i.e., EPNC401K)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., PNC 401k Export - Indicative Financial Data)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@TestFilePath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)

-- Data parameters
@Source1DedCodeList - Replace with Source 1 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source2DedCodeList - Replace with Source 2 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source3DedCodeList - Replace with Source 3 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source4DedCodeList - Replace with Source 4 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source5DedCodeList - Replace with Source 5 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source6DedCodeList - Replace with Source 6 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source7DedCodeList - Replace with Source 7 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source8DedCodeList - Replace with Source 8 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source9DedCodeList - Replace with Source 9 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Source10DedCodeList - Replace with Source 10 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)

@Loan1DedCodeList - Replace with Loan 1 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Loan2DedCodeList - Replace with Loan 2 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Loan3DedCodeList - Replace with Loan 3 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@Loan4DedCodeList - Replace with Loan 4 Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)

@PreTaxPercentageDedCodeList - Replace with Pre-Tax Deferral Percentage Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@PreTaxAmountDedCodeList - Replace with Pre-Tax Dollar Amount Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@RothPercentageDedCodeList - Replace with Roth Deferral Percentage Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@RothAmountDedCodeList - Replace with Roth Dollar AmountDeduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@AfterTaxPercentageDedCodeList - Replace with After-Tax Deferral Percentage Deduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)
@AfterTaxAmountDedCodeList - Replace with After-Tax Dollar AmountDeduction Codes in quoted-CSV format (i.e., DED1','DED2','DED3)

@FileNamePreFix - Replace with client prefix for filename

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PEarHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_IND') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_IND];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_FIN') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_FIN];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode','PNC 401K Export - Indicative Financial Data','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','500','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SY"','1','(''DA''=''F'')',@AdhSystemID,'2','D','10','1',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'1','D','10','3',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayPeriodEnding"','3','(''UD101''=''F'')',@AdhSystemID,'10','D','10','4',NULL,'Pay Period Ending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''F'')',@AdhSystemID,'1','D','10','14',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','5','(''UA''=''F'')',@AdhSystemID,'11','D','10','15',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'1','D','10','26',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantFirstNameMiddle"','7','(''UA''=''F'')',@AdhSystemID,'12','D','10','27',NULL,'Participant First Name & Middle Initial',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','10','39',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantLastNameSuffix"','9','(''UA''=''F'')',@AdhSystemID,'20','D','10','40',NULL,'Participant Last Name & Suffix',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','10','60',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine1"','11','(''UA''=''F'')',@AdhSystemID,'30','D','10','61',NULL,'Address Line 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'1','D','10','91',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine2"','13','(''UA''=''F'')',@AdhSystemID,'30','D','10','92',NULL,'Address Line 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','10','122',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','15','(''UA''=''F'')',@AdhSystemID,'17','D','10','123',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','10','140',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','17','(''UA''=''F'')',@AdhSystemID,'2','D','10','141',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','10','143',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZipCode"','19','(''UA''=''F'')',@AdhSystemID,'10','D','10','144',NULL,'Zip Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''F'')',@AdhSystemID,'1','D','10','154',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYeartoDateGross415Comp"','21','(''UN00''=''F'')',@AdhSystemID,'10','D','10','155',NULL,'Year to Date Gross (415) Compensation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','22','(''SS''=''F'')',@AdhSystemID,'1','D','10','165',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYeartoDateEligTestingComp"','23','(''UN00''=''F'')',@AdhSystemID,'10','D','10','166',NULL,'Year to Date Eligible (Testing) Compensation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','24','(''SS''=''F'')',@AdhSystemID,'1','D','10','176',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYeartoDateHours"','25','(''UN00''=''F'')',@AdhSystemID,'6','D','10','177',NULL,'Year to Date Hours',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','26','(''SS''=''F'')',@AdhSystemID,'1','D','10','183',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofBirth"','27','(''UD101''=''F'')',@AdhSystemID,'10','D','10','184',NULL,'Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','28','(''SS''=''F'')',@AdhSystemID,'1','D','10','194',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofHire"','29','(''UD101''=''F'')',@AdhSystemID,'10','D','10','195',NULL,'Date of Hire',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','30','(''SS''=''F'')',@AdhSystemID,'1','D','10','205',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofParticipationEntry"','31','(''UD101''=''F'')',@AdhSystemID,'10','D','10','206',NULL,'Date of Participation / Entry',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','32','(''SS''=''F'')',@AdhSystemID,'1','D','10','216',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofTermination"','33','(''UD101''=''F'')',@AdhSystemID,'10','D','10','217',NULL,'Date of Termination',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','34','(''SS''=''F'')',@AdhSystemID,'1','D','10','227',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRehireDate"','35','(''UD101''=''F'')',@AdhSystemID,'10','D','10','228',NULL,'Rehire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','36','(''SS''=''F'')',@AdhSystemID,'1','D','10','238',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPrimaryStatus"','37','(''UA''=''F'')',@AdhSystemID,'3','D','10','239',NULL,'Primary Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','38','(''SS''=''F'')',@AdhSystemID,'1','D','10','242',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPercentageofOwnership"','39','(''UN00''=''F'')',@AdhSystemID,'5','D','10','243',NULL,'% of Ownership',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','40','(''SS''=''F'')',@AdhSystemID,'1','D','10','248',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFamilyAttribution"','41','(''UA''=''F'')',@AdhSystemID,'3','D','10','249',NULL,'Family Attribution',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','42','(''SS''=''F'')',@AdhSystemID,'1','D','10','252',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatutoryExclusionCovTest"','43','(''UA''=''F'')',@AdhSystemID,'1','D','10','253',NULL,'Statutory Exclusion From Coverage Test',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','44','(''SS''=''F'')',@AdhSystemID,'1','D','10','254',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvClassExclusion"','45','(''UA''=''F'')',@AdhSystemID,'1','D','10','255',NULL,'Class Exclusion',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','46','(''SS''=''F'')',@AdhSystemID,'1','D','10','256',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNonKeyKey"','47','(''UA''=''F'')',@AdhSystemID,'3','D','10','257',NULL,'Non Key / Key',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','48','(''SS''=''F'')',@AdhSystemID,'1','D','10','260',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNonHighlyHigh"','49','(''UA''=''F'')',@AdhSystemID,'3','D','10','261',NULL,'Non Highly / High',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','50','(''SS''=''F'')',@AdhSystemID,'1','D','10','264',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayFrequency"','51','(''UA''=''F'')',@AdhSystemID,'15','D','10','265',NULL,'Pay Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','52','(''SS''=''F'')',@AdhSystemID,'1','D','10','280',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivisionCodeAltKey2"','53','(''UA''=''F'')',@AdhSystemID,'15','D','10','281',NULL,'Division Code (Alt Key 2)',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','54','(''SS''=''F'')',@AdhSystemID,'1','D','10','296',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeePreTaxDeferralPerc"','55','(''UN00''=''F'')',@AdhSystemID,'2','D','10','297',NULL,'Employee Pre-Tax Deferral Percentage',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','56','(''SS''=''F'')',@AdhSystemID,'1','D','10','299',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeePreTaxFlatDolarAmt"','57','(''UN00''=''F'')',@AdhSystemID,'8','D','10','300',NULL,'Employee Pre-Tax Flat Dollar Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','58','(''SS''=''F'')',@AdhSystemID,'1','D','10','308',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeRothDeferralPerc"','59','(''UN00''=''F'')',@AdhSystemID,'2','D','10','309',NULL,'Employee Roth Deferral Percentage',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','60','(''SS''=''F'')',@AdhSystemID,'1','D','10','311',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeRothFlatDollarAmt"','61','(''UN00''=''F'')',@AdhSystemID,'8','D','10','312',NULL,'Employee Roth Flat Dollar Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','62','(''SS''=''F'')',@AdhSystemID,'1','D','10','320',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeAfterTaxDeferPerc"','63','(''UN00''=''F'')',@AdhSystemID,'2','D','10','321',NULL,'Employee After-Tax Deferral Percentage',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','64','(''SS''=''F'')',@AdhSystemID,'1','D','10','323',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeAfterTaxFlatDolAmt"','65','(''UN00''=''F'')',@AdhSystemID,'8','D','10','324',NULL,'Employee After-Tax Flat Dollar Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FN"','1','(''DA''=''F'')',@AdhSystemID,'2','D','20','1',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'1','D','20','3',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayPeriodEnding"','3','(''UD101''=''F'')',@AdhSystemID,'10','D','20','4',NULL,'Pay Period Ending',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','4','(''SS''=''F'')',@AdhSystemID,'1','D','20','14',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','5','(''UA''=''F'')',@AdhSystemID,'11','D','20','15',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'1','D','20','26',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource1"','7','(''UN00''=''F'')',@AdhSystemID,'8','D','20','27',NULL,'Source #1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','20','35',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource2"','9','(''UN00''=''F'')',@AdhSystemID,'8','D','20','36',NULL,'Source #2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','20','44',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource3"','11','(''UN00''=''F'')',@AdhSystemID,'8','D','20','45',NULL,'Source #3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'1','D','20','53',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource4"','13','(''UN00''=''F'')',@AdhSystemID,'8','D','20','54',NULL,'Source #4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','20','62',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource5"','15','(''UN00''=''F'')',@AdhSystemID,'8','D','20','63',NULL,'Source #5',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'1','D','20','71',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource6"','17','(''UN00''=''F'')',@AdhSystemID,'8','D','20','72',NULL,'Source #6',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'1','D','20','80',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource7"','19','(''UN00''=''F'')',@AdhSystemID,'8','D','20','81',NULL,'Source #7',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','20','(''SS''=''F'')',@AdhSystemID,'1','D','20','89',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource8"','21','(''UN00''=''F'')',@AdhSystemID,'8','D','20','90',NULL,'Source #8',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','22','(''SS''=''F'')',@AdhSystemID,'1','D','20','98',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource9"','23','(''UN00''=''F'')',@AdhSystemID,'8','D','20','99',NULL,'Source #9',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','24','(''SS''=''F'')',@AdhSystemID,'1','D','20','107',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource10"','25','(''UN00''=''F'')',@AdhSystemID,'8','D','20','108',NULL,'Source #10',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','26','(''SS''=''F'')',@AdhSystemID,'1','D','20','116',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanRepayment1"','27','(''UN00''=''F'')',@AdhSystemID,'9','D','20','117',NULL,'Loan Repayment #1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','28','(''SS''=''F'')',@AdhSystemID,'1','D','20','126',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanIdentifier1"','29','(''UA''=''F'')',@AdhSystemID,'9','D','20','127',NULL,'Loan Identifier #1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','30','(''SS''=''F'')',@AdhSystemID,'1','D','20','136',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanRepayment2"','31','(''UN00''=''F'')',@AdhSystemID,'9','D','20','137',NULL,'Loan Repayment #2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','32','(''SS''=''F'')',@AdhSystemID,'1','D','20','146',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanIdentifier2"','33','(''UA''=''F'')',@AdhSystemID,'9','D','20','147',NULL,'Loan Identifier #2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','34','(''SS''=''F'')',@AdhSystemID,'1','D','20','156',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanRepayment3"','35','(''UN00''=''F'')',@AdhSystemID,'9','D','20','157',NULL,'Loan Repayment #3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','36','(''SS''=''F'')',@AdhSystemID,'1','D','20','166',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanIdentifier3"','37','(''UA''=''F'')',@AdhSystemID,'9','D','20','167',NULL,'Loan Identifier #3',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','38','(''SS''=''F'')',@AdhSystemID,'1','D','20','176',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanRepayment4"','39','(''UN00''=''F'')',@AdhSystemID,'9','D','20','177',NULL,'Loan Repayment #4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','40','(''SS''=''F'')',@AdhSystemID,'1','D','20','186',NULL,'Filler Space',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanIdentifier4"','41','(''UA''=''F'')',@AdhSystemID,'9','D','20','187',NULL,'Loan Identifier #4',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Test Purposes Only','201707019','EMPEXPORT','TEST','Jul  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'PNC 401K Export','201707019','EMPEXPORT','ONDEMAND','Jul  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201707019','Jul  1 2017 12:00AM','Dec 30 1899 12:00AM','201707011',NULL,'','','201707011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_IND',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_FIN',NULL);
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
    [Data] varchar(500) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Integration Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: PNC 401k Export - Indicative Financial Data

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
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = '@CustomFormatCode';

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
        -- Current Payroll Amounts
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        -- Categorize Payroll Amounts
        ,Source1 = SUM(CASE WHEN PdhDedCode IN ('@Source1DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source2 = SUM(CASE WHEN PdhDedCode IN ('@Source2DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source3 = SUM(CASE WHEN PdhDedCode IN ('@Source3DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source4 = SUM(CASE WHEN PdhDedCode IN ('@Source4DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source5 = SUM(CASE WHEN PdhDedCode IN ('@Source5DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source6 = SUM(CASE WHEN PdhDedCode IN ('@Source6DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source7 = SUM(CASE WHEN PdhDedCode IN ('@Source7DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source8 = SUM(CASE WHEN PdhDedCode IN ('@Source8DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source9 = SUM(CASE WHEN PdhDedCode IN ('@Source9DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,Source10 = SUM(CASE WHEN PdhDedCode IN ('@Source10DedCodeList') THEN PdhEECurAmt ELSE 0.00 END)
        ,LoanRepayment1 = SUM(CASE WHEN PdhDedCode IN ('@Loan1DedCodeList') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,LoanIdentifier1 = MAX(CASE WHEN PdhDedCode IN ('@Loan1DedCodeList') THEN 'LOAN1' END)
        ,LoanRepayment2 = SUM(CASE WHEN PdhDedCode IN ('@Loan2DedCodeList') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,LoanIdentifier2 = MAX(CASE WHEN PdhDedCode IN ('@Loan2DedCodeList') THEN 'LOAN2' END)
        ,LoanRepayment3 = SUM(CASE WHEN PdhDedCode IN ('@Loan3DedCodeList') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,LoanIdentifier3 = MAX(CASE WHEN PdhDedCode IN ('@Loan3DedCodeList') THEN 'LOAN3' END)
        ,LoanRepayment4 = SUM(CASE WHEN PdhDedCode IN ('@Loan4DedCodeList') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,LoanIdentifier4 = MAX(CASE WHEN PdhDedCode IN ('@Loan4DedCodeList') THEN 'LOAN4' END)
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = PdhDedCode
        AND DedDedType IN ('DEF','LON')
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl
    GROUP BY PdhEEID, LEFT(PdhPerControl,8)
    HAVING (SUM(PdhEECurAmt) <> 0.00);

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate = MAX(PrgPayDate)
        --Categorize Payroll Amounts
        ,PreTaxDeferralPercentage = MAX(CASE WHEN EedDedCode IN ('@PreTaxPercentageDedCodeList') THEN EedEECalcRateOrPct END)
        ,PreTaxFlatDollarAmount = MAX(CASE WHEN EedDedCode IN ('@PreTaxAmountDedCodeList') THEN EedEEAmt END)
        ,RothDeferralPercentage = MAX(CASE WHEN EedDedCode IN ('@RothPercentageDedCodeList') THEN EedEECalcRateOrPct END)
        ,RothFlatDollarAmount = MAX(CASE WHEN EedDedCode IN ('@RothAmountDedCodeList') THEN EedEEAmt END)
        ,AfterTaxDeferralPercentage = MAX(CASE WHEN EedDedCode IN ('@AfterTaxPercentageDedCodeList') THEN EedEECalcRateOrPct END)
        ,AfterTaxFlatDollarAmount = MAX(CASE WHEN EedDedCode IN ('@AfterTaxAmountDedCodeList') THEN EedEEAmt END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD = SUM(PehCurAmt)
        ,PehCurHrsYTD = SUM(PehCurHrs)
        -- Include Deferred Comp Amount/Hours
        ,PehCurAmtGross415Compensation = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehCurAmtEligibleTestingCompensation = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
    INTO dbo.U_@CustomFormatCode_PEarHist
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.PayReg WITH (NOLOCK)
        ON PrgEEID = xEEID
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    LEFT JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedDedCode IN (SELECT DedDedCode FROM dbo.DedCode WITH (NOLOCK) WHERE DedDedType IN ('DEF','LON'))
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING ((SUM(PehCurAmt) <> 0.00)
        OR (SUM(PehCurHrs) <> 0.00)
    );

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_IND
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_IND','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_IND;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPayPeriodEnding = PrgPayDate
        ,drvSSN = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvParticipantFirstNameMiddle = RTRIM(EepNameFirst) + ISNULL(LEFT(EepNameMiddle,1),'')
        ,drvParticipantLastNameSuffix = RTRIM(EepNameLast) + ISNULL(NULLIF(EepNameSuffix,'Z'),'')
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-') ELSE EepAddressZipCode END
        ,drvYeartoDateGross415Comp = PehCurAmtGross415Compensation * 100
        ,drvYeartoDateEligTestingComp = PehCurAmtEligibleTestingCompensation * 100
        ,drvYeartoDateHours = PehCurHrsYTD * 100
        ,drvDateofBirth = EepDateOfBirth
        ,drvDateofHire = EecDateOfOriginalHire
        ,drvDateofParticipationEntry = EecDateOfOriginalHire
        ,drvDateofTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = EecDateOfLastHire
        ,drvPrimaryStatus = CASE EecEmplStatus
                                 WHEN 'A' THEN '751' --Active
                                 WHEN 'L' THEN '838' --Leave of Absence
                                 WHEN 'T' THEN 
                                    CASE EecTermReason
                                         WHEN '202' THEN '758' --Retired
                                         WHEN '203' THEN '759' --Deceased
                                         ELSE '753' --Terminated - MUST provide Termination Date
                                    END
                            END
        ,drvPercentageofOwnership = ''
        ,drvFamilyAttribution = ''
        ,drvStatutoryExclusionCovTest = ''
        ,drvClassExclusion = ''
        ,drvNonKeyKey = CASE EecIsKeyEmployee
                             WHEN 'Y' THEN '767' --Key for Top Heavy Test
                             ELSE '766' --Non Key for Top Heavy Test
                        END
        ,drvNonHighlyHigh = CASE EecIsHighlyComp
                                 WHEN 'Y' THEN '768' --Non Highly Compensated
                                 ELSE '769' --Highly Compensated
                            END
        ,drvPayFrequency = EecPayPeriod
        ,drvDivisionCodeAltKey2 = ''
        ,drvEmployeePreTaxDeferralPerc = PreTaxDeferralPercentage * 100
        ,drvEmployeePreTaxFlatDolarAmt = PreTaxFlatDollarAmount * 100
        ,drvEmployeeRothDeferralPerc = RothDeferralPercentage * 100
        ,drvEmployeeRothFlatDollarAmt = RothFlatDollarAmount * 100
        ,drvEmployeeAfterTaxDeferPerc = AfterTaxDeferralPercentage * 100
        ,drvEmployeeAfterTaxFlatDolAmt = AfterTaxFlatDollarAmount * 100
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl_IND
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_@CustomFormatCode_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID;

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl_FIN
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_FIN','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_FIN;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvPayPeriodEnding = PdhPerControl
        ,drvSSN = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSource1 = Source1 * 100
        ,drvSource2 = Source2 * 100
        ,drvSource3 = Source3 * 100
        ,drvSource4 = Source4 * 100
        ,drvSource5 = Source1 * 100
        ,drvSource6 = Source6 * 100
        ,drvSource7 = Source7 * 100
        ,drvSource8 = Source8 * 100
        ,drvSource9 = Source9 * 100
        ,drvSource10 = Source10 * 100
        ,drvLoanRepayment1 = LoanRepayment1 * 100
        ,drvLoanIdentifier1 = LoanIdentifier1
        ,drvLoanRepayment2 = LoanRepayment2 * 100
        ,drvLoanIdentifier2 = LoanIdentifier2
        ,drvLoanRepayment3 = LoanRepayment3 * 100
        ,drvLoanIdentifier3 = LoanIdentifier3
        ,drvLoanRepayment4 = LoanRepayment4 * 100
        ,drvLoanIdentifier4 = LoanIdentifier4
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl_FIN
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN '@FileNamePreFix_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE '@FileNamePreFix_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
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
    SET expLastStartPerControl = '201707011'
       ,expStartPerControl     = '201707011'
       ,expLastEndPerControl   = '201707019'
       ,expEndPerControl       = '201707019'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY InitialSort, SubSort;
GO