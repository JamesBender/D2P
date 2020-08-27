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
@CustomFormatCode - Replace with Format Code (i.e., EHARTFORD)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., The Hartford FMLA-STD-LTD-Voluntary Life Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Hartford\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Hartford\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

-- Client Specific parameters
@ClientName - Replace with the Client Name for the Filename
@DeductionCodeList - Replace with the DedCodeList with the list of deduction codes (i.e., STD,LTD)
@ClassCodeMapping - Replace with the Class Code Mapping provided by Vendor, you may need to perform CASE statement in code
@LTDOption - Replace with the LTD Option provided by Vendor, you may need to perform CASE statement in code

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PEarHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EmpHJob') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EmpHJob];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_Benefits') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Benefits];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','1616','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'9','D','10','1',NULL,'SSNBR',NULL,NULL,'"drvSSNBR"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'15','D','10','10',NULL,'Employee ID',NULL,NULL,'"drvEmployeeID"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'30','D','10','25',NULL,'Employee Last Name',NULL,NULL,'"drvEmployeeLastName"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'30','D','10','55',NULL,'Employee First Name',NULL,NULL,'"drvEmployeeFirstName"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'1','D','10','85',NULL,'Middle Initial',NULL,NULL,'"drvMiddleInitial"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'40','D','10','86',NULL,'Address Line 1',NULL,NULL,'"drvAddressLine1"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'40','D','10','126',NULL,'Address Line 2',NULL,NULL,'"drvAddressLine2"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'30','D','10','166',NULL,'City',NULL,NULL,'"drvCity"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','10','196',NULL,'State Code',NULL,NULL,'"drvStateCode"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'10','D','10','198',NULL,'Zip Code',NULL,NULL,'"drvZipCode"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'3','D','10','208',NULL,'Country Code',NULL,NULL,'"drvCountryCode"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'2','D','10','211',NULL,'Province Code',NULL,NULL,'"drvProvinceCode"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'30','D','10','213',NULL,'Foreign Province Name',NULL,NULL,'"drvForeignProvinceName"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'8','D','10','243',NULL,'Date of Birth',NULL,NULL,'"drvDateofBirth"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '15',@AdhSystemID,'10','D','10','251',NULL,'Home Phone Number',NULL,NULL,'"drvHomePhoneNumber"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '16',@AdhSystemID,'1','D','10','261',NULL,'Marital Status',NULL,NULL,'"drvMaritalStatus"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '17',@AdhSystemID,'1','D','10','262',NULL,'Gender',NULL,NULL,'"drvGender"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '18',@AdhSystemID,'20','D','10','263',NULL,'Employee Status Code',NULL,NULL,'"drvEmployeeStatusCode"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '19',@AdhSystemID,'8','D','10','283',NULL,'Employee Status Eff Date',NULL,NULL,'"drvEmployeeStatusEffDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '20',@AdhSystemID,'8','D','10','291',NULL,'Employee Service Date',NULL,NULL,'"drvEmployeeServiceDate"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '21',@AdhSystemID,'8','D','10','299',NULL,'Rehire Date',NULL,NULL,'"drvRehireDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '22',@AdhSystemID,'8','D','10','307',NULL,'Original Hire Date',NULL,NULL,'"drvOriginalHireDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '23',@AdhSystemID,'2','D','10','315',NULL,'Salary Class',NULL,NULL,'"drvSalaryClass"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '24',@AdhSystemID,'8','D','10','317',NULL,'Salary Effective Date',NULL,NULL,'"drvSalaryEffectiveDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '25',@AdhSystemID,'9','D','10','325',NULL,'Salary Amount',NULL,NULL,'"drvSalaryAmount"','(''UN00''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '26',@AdhSystemID,'1','D','10','334',NULL,'Salary Basis',NULL,NULL,'"drvSalaryBasis"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '27',@AdhSystemID,'2','D','10','335',NULL,'Work State Code',NULL,NULL,'"drvWorkStateCode"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '28',@AdhSystemID,'40','D','10','337',NULL,'Employee Work Address Line 1',NULL,NULL,'"drvEmployeeWorkAddressLine1"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '29',@AdhSystemID,'40','D','10','377',NULL,'Employee Work Address Line 2',NULL,NULL,'"drvEmployeeWorkAddressLine2"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '30',@AdhSystemID,'30','D','10','417',NULL,'Employee Work City',NULL,NULL,'"drvEmployeeWorkCity"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '31',@AdhSystemID,'2','D','10','447',NULL,'Employee Work State or Province',NULL,NULL,'"drvEmployeeWorkStateProvince"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '32',@AdhSystemID,'10','D','10','449',NULL,'Employee Work Postal Code',NULL,NULL,'"drvEmployeeWorkPostalCode"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '33',@AdhSystemID,'3','D','10','459',NULL,'Employee Work Country',NULL,NULL,'"drvEmployeeWorkCountry"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '34',@AdhSystemID,'10','D','10','462',NULL,'Employee Work Phone #',NULL,NULL,'"drvEmployeeWorkPhone#"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '35',@AdhSystemID,'50','D','10','472',NULL,'Employee''s E-Mail Address',NULL,NULL,'"drvEmployeesEMailAddress"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '36',@AdhSystemID,'25','D','10','522',NULL,'Job Title',NULL,NULL,'"drvJobTitle"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '37',@AdhSystemID,'1','D','10','547',NULL,'Job Code',NULL,NULL,'"drvJobCode"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '38',@AdhSystemID,'10','D','10','548',NULL,'Payroll Code',NULL,NULL,'"drvPayrollCode"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '39',@AdhSystemID,'1','D','10','558',NULL,'Exempt',NULL,NULL,'"drvExempt"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '40',@AdhSystemID,'1','D','10','559',NULL,'Union Member',NULL,NULL,'"drvUnionMember"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '41',@AdhSystemID,'30','D','10','560',NULL,'Union Name',NULL,NULL,'"drvUnionName"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '42',@AdhSystemID,'10','D','10','590',NULL,'Department ID',NULL,NULL,'"drvDepartmentID"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '43',@AdhSystemID,'10','D','10','600',NULL,'Division ID',NULL,NULL,'"drvDivisionID"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '44',@AdhSystemID,'10','D','10','610',NULL,'Class code',NULL,NULL,'"drvClasscode"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '45',@AdhSystemID,'10','D','10','620',NULL,'Account ID',NULL,NULL,'"drvAccountID"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '46',@AdhSystemID,'10','D','10','630',NULL,'Region ID',NULL,NULL,'"drvRegionID"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '47',@AdhSystemID,'10','D','10','640',NULL,'Company ID',NULL,NULL,'"drvCompanyID"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '48',@AdhSystemID,'30','D','10','650',NULL,'Supervisor Last Name',NULL,NULL,'"drvSupervisorLastName"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '49',@AdhSystemID,'30','D','10','680',NULL,'Supervisor First Name',NULL,NULL,'"drvSupervisorFirstName"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '50',@AdhSystemID,'50','D','10','710',NULL,'Supervisor Email Address',NULL,NULL,'"drvSupervisorEmailAddress"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '51',@AdhSystemID,'10','D','10','760',NULL,'Filler',NULL,NULL,'"drvFiller1"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '52',@AdhSystemID,'10','D','10','770',NULL,'Supervisor Phone #',NULL,NULL,'"drvSupervisorPhone#"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '53',@AdhSystemID,'30','D','10','780',NULL,'HR First Name',NULL,NULL,'"drvHRFirstName"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '54',@AdhSystemID,'30','D','10','810',NULL,'HR Last Name',NULL,NULL,'"drvHRLastName"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '55',@AdhSystemID,'50','D','10','840',NULL,'HR Partner Email Address',NULL,NULL,'"drvHRPartnerEmailAddress"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '56',@AdhSystemID,'11','D','10','890',NULL,'Filler',NULL,NULL,'"drvFiller2"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '57',@AdhSystemID,'10','D','10','901',NULL,'HR Partner Phone #',NULL,NULL,'"drvHRPartnerPhone#"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '58',@AdhSystemID,'30','D','10','911',NULL,'ER Contact First Name',NULL,NULL,'"drvERContactFirstName"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '59',@AdhSystemID,'30','D','10','941',NULL,'ER Contact Last Name',NULL,NULL,'"drvERContactLastName"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '60',@AdhSystemID,'50','D','10','971',NULL,'ER Contact Email Address',NULL,NULL,'"drvERContactEmailAddress"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '61',@AdhSystemID,'9','D','10','1021',NULL,'EFT – ABA Number',NULL,NULL,'"drvEFT–ABANumber"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '62',@AdhSystemID,'35','D','10','1030',NULL,'EFT – Account Number',NULL,NULL,'"drvEFT–AccountNumber"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '63',@AdhSystemID,'1','D','10','1065',NULL,'EFT – Account Type',NULL,NULL,'"drvEFT–AccountType"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '64',@AdhSystemID,'8','D','10','1066',NULL,'STD Coverage Eff Date',NULL,NULL,'"drvSTDCoverageEffDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '65',@AdhSystemID,'8','D','10','1074',NULL,'STD Coverage Term Date',NULL,NULL,'"drvSTDCoverageTermDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '66',@AdhSystemID,'5','D','10','1082',NULL,'STD Option',NULL,NULL,'"drvSTDOption"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '67',@AdhSystemID,'8','D','10','1087',NULL,'LTD Coverage Eff Date',NULL,NULL,'"drvLTDCoverageEffDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '68',@AdhSystemID,'8','D','10','1095',NULL,'LTD Coverage Term Date',NULL,NULL,'"drvLTDCoverageTermDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '69',@AdhSystemID,'5','D','10','1103',NULL,'LTD Option',NULL,NULL,'"drvLTDOption"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '70',@AdhSystemID,'3','D','10','1108',NULL,'DisabilityFLEX Benefit Commencement Period - Day I',NULL,NULL,'"drvDisabilityFLEXPeriodDayInj"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '71',@AdhSystemID,'3','D','10','1111',NULL,'DisabilityFLEX Benefit Commencement Period - Day S',NULL,NULL,'"drvDisabilityFLEXPeriodDaySic"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '72',@AdhSystemID,'3','D','10','1114',NULL,'DisabilityFLEX Benefit Duration',NULL,NULL,'"drvDisabilityFLEXBenefitDurtn"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '73',@AdhSystemID,'6','D','10','1117',NULL,'DisabilityFLEX Benefit Amount',NULL,NULL,'"drvDisabilityFLEXBenefitAmt"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '74',@AdhSystemID,'4','D','10','1123',NULL,'Filler',NULL,NULL,'"drvFiller3"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '75',@AdhSystemID,'15','D','10','1127',NULL,'Last 8 weeks earnings',NULL,NULL,'"drvLast8weeksearnings"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '76',@AdhSystemID,'15','D','10','1142',NULL,'Company Code',NULL,NULL,'"drvCompanyCode"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '77',@AdhSystemID,'20','D','10','1157',NULL,'Cost Center',NULL,NULL,'"drvCostCenter"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '78',@AdhSystemID,'9','D','10','1177',NULL,'Supp Life EE Amount',NULL,NULL,'"drvSuppLifeEEAmount"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '79',@AdhSystemID,'8','D','10','1186',NULL,'Supp Life EE Effective Date',NULL,NULL,'"drvSuppLifeEEEffectiveDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '80',@AdhSystemID,'4','D','10','1194',NULL,'Supp Life EE Level',NULL,NULL,'"drvSuppLifeEELevel"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '81',@AdhSystemID,'9','D','10','1198',NULL,'Supp Life SP Amount',NULL,NULL,'"drvSuppLifeSPAmount"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '82',@AdhSystemID,'8','D','10','1207',NULL,'Supp Life SP Effective Date',NULL,NULL,'"drvSuppLifeSPEffectiveDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '83',@AdhSystemID,'4','D','10','1215',NULL,'Supp Life SP Level',NULL,NULL,'"drvSuppLifeSPLevel"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '84',@AdhSystemID,'9','D','10','1219',NULL,'Supp Life CH Amount',NULL,NULL,'"drvSuppLifeCHAmount"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '85',@AdhSystemID,'8','D','10','1228',NULL,'Supp Life CH Effective Date',NULL,NULL,'"drvSuppLifeCHEffectiveDate"','(''UD112''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '86',@AdhSystemID,'4','D','10','1236',NULL,'Supp Life CH Level',NULL,NULL,'"drvSuppLifeCHLevel"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '87',@AdhSystemID,'17','D','10','1240',NULL,'Client specific field:',NULL,NULL,'"drvClientspecificfield"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '88',@AdhSystemID,'1','D','10','1257',NULL,'Leave Management Services Indicator',NULL,NULL,'"drvLeaveManagementServicesInd"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '89',@AdhSystemID,'1','D','10','1258',NULL,'Employee Covered by FML 50/75 Rule',NULL,NULL,'"drvEmployeeCoveredFML5075Rule"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '90',@AdhSystemID,'1','D','10','1259',NULL,'Key Employee Indicator',NULL,NULL,'"drvKeyEmployeeIndicator"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '91',@AdhSystemID,'6','D','10','1260',NULL,'Last 12 Months Hours',NULL,NULL,'"drvLast12MonthsHours"','(''UN00''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '92',@AdhSystemID,'4','D','10','1266',NULL,'Sick Leave Hours Remaining',NULL,NULL,'"drvSickLeaveHoursRemaining"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '93',@AdhSystemID,'4','D','10','1270',NULL,'Vacation Hours Remaining',NULL,NULL,'"drvVacationHoursRemaining"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '94',@AdhSystemID,'1','D','10','1274',NULL,'Forced Eligibility',NULL,NULL,'"drvForcedEligibility"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '95',@AdhSystemID,'6','D','10','1275',NULL,'Last 12 Month Paid Hours',NULL,NULL,'"drvLast12MonthPaidHours"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '96',@AdhSystemID,'23','D','10','1281',NULL,'Filler',NULL,NULL,'"drvFiller4"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '97',@AdhSystemID,'3','D','10','1304',NULL,'Work Schedule Type',NULL,NULL,'"drvWorkScheduleType"','(''UA''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '98',@AdhSystemID,'8','D','10','1307',NULL,'Work Schedule From Date',NULL,NULL,'"drvWorkScheduleFromDate"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '99',@AdhSystemID,'4','D','10','1315',NULL,'Scheduled Hours Per Week',NULL,NULL,'"drvScheduledHoursPerWeek"','(''UN00''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '100',@AdhSystemID,'4','D','10','1319',NULL,'Work schedule - Hours Monday',NULL,NULL,'"drvWorkscheduleHoursMonday"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '101',@AdhSystemID,'4','D','10','1323',NULL,'Work Schedule - Hours Tuesday',NULL,NULL,'"drvWorkScheduleHoursTuesday"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '102',@AdhSystemID,'4','D','10','1327',NULL,'Work Schedule - Hours Wednesday',NULL,NULL,'"drvWorkScheduleHoursWednesday"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '103',@AdhSystemID,'4','D','10','1331',NULL,'Work Schedule - Hours Thursday',NULL,NULL,'"drvWorkScheduleHoursThursday"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '104',@AdhSystemID,'4','D','10','1335',NULL,'Work Schedule - Hours Friday',NULL,NULL,'"drvWorkScheduleHoursFriday"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '105',@AdhSystemID,'4','D','10','1339',NULL,'Work Schedule - Hours Saturday',NULL,NULL,'"drvWorkScheduleHoursSaturday"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '106',@AdhSystemID,'4','D','10','1343',NULL,'Work Schedule - Hours Sunday',NULL,NULL,'"drvWorkScheduleHoursSunday"','(''SS''=''F'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '107',@AdhSystemID,'270','D','10','1347',NULL,'Filler',NULL,NULL,'"drvFiller5"','(''SS''=''F'')';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Automated Scheduled Session','201706019','EMPEXPORT','SCHEDULED','Jun  1 2017  4:34PM','@CustomFormatCode',NULL,NULL,NULL,'201706019','Jun  1 2017 12:00AM','Dec 30 1899 12:00AM','201706011',NULL,'','','201706011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201706019','EMPEXPORT','TEST','Jun  1 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201706019','Jun  1 2017 12:00AM','Dec 30 1899 12:00AM','201706011',NULL,'','','201706011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'FileName Is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName,'201706019','EMPEXPORT','ONDEMAND','Jun  1 2017 10:51AM','@CustomFormatCode',NULL,NULL,NULL,'201706019','Jun  1 2017 12:00AM','Dec 30 1899 12:00AM','201706011',NULL,'','','201706011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
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
    [Data] char(1616) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode         VARCHAR(12)
            ,@ExportCode         VARCHAR(12)
            ,@StartDate          DATETIME
            ,@EndDate            DATETIME
            ,@StartPerControl    VARCHAR(9)
            ,@EndPerControl      VARCHAR(9);

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CASE WHEN ExportCode = 'SCHEDULED' THEN DATEADD(DAY,-7,GETDATE())
                                 ELSE CAST(LEFT(StartPerControl,8) AS DATETIME)
                            END
        ,@EndDate         = CASE WHEN ExportCode = 'SCHEDULED' THEN GETDATE()
                                 ELSE DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
                            END
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Audit Section
    --==========================================
    IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT 
         audEEID = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
		,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
        AND audDateTime BETWEEN @StartDate AND @EndDate
        AND audTableName = 'EmpComp' 
        AND audFieldName = 'EecEmplStatus'
        AND audAction <> 'DELETE'
    WHERE ISNULL(audNewValue,'') = 'T';

    --==========================================
    -- Clean EE List 
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID);

    -- Remove Terminated Employees NOT Found in Audit
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
        AND EecEmplStatus = 'T'
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ----------------------------------------------
    -- WORKING TABLE - Benefits (EmpDed/EmpEarn) 
    ----------------------------------------------
	DECLARE @DedCodeList VARCHAR(MAX)
	SET @DedCodeList = '@DeductionCodeList';

    IF OBJECT_ID('U_@CustomFormatCode_Benefits','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Benefits;
    SELECT EedEEID = xEEID
        ,EedCoID = xCOID
        ,EedDedCode
        ,EedBenStartDate
        ,EedBenStopDate
        ,EedBenAmt = DedEEBenAmt
    INTO dbo.U_@CustomFormatCode_Benefits
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    LEFT JOIN dbo.EmpDed WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCOID
	LEFT JOIN dbo.fn_ListToTable (@DedCodeList)
		ON Item = EedDedCode
    LEFT JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = EedDedCode
	WHERE ISNULL(EedBenStopDate, EedStopDate) IS NULL;

    ------------------
    -- DETAIL RECORD
    ------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
        drvSSNBR = EepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeLastName = EepNameLast
        ,drvEmployeeFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvStateCode = EepAddressState
        ,drvZipCode = CASE WHEN LEN(EepAddressZipCode) > 5 THEN STUFF(EepAddressZipCode,6,0,'-')
                           ELSE EepAddressZipCode
                      END
        ,drvCountryCode = '001' --Default is '001' for USA.
        ,drvDateofBirth = EepDateOfBirth
        ,drvHomePhoneNumber = EepPhoneHomeNumber
        ,drvGender = CASE WHEN EepGender IN ('M','F') THEN EepGender END
        ,drvEmployeeStatusCode = EecEmplStatus
        ,drvEmployeeStatusEffDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination
                                         ELSE EecEmplStatusStartDate
                                    END
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire
                              ELSE EecDateOfOriginalHire
                         END
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvSalaryClass = EecFullTimeOrPartTime
        ,drvSalaryEffectiveDate = COALESCE(EjhJobEffDate,EecDateOfLastHire)
        ,drvSalaryAmount = (EecAnnSalary * 100)
        ,drvSalaryBasis = 'A' --"A" = Annual
        ,drvWorkStateCode = LEFT(emlSITWorkInStateCode,2)
        ,drvEmployeesEMailAddress = eepAddressEMail
        ,drvJobTitle = JbcDesc
        ,drvExempt = JbcFLSAType
        ,drvDepartmentID = EecOrgLvl2
        ,drvDivisionID = EecOrgLvl1
        ,drvClasscode = '@ClassCodeMapping'
        ,drvSupervisorLastName = SupNameLast
        ,drvSupervisorFirstName = SupNameFirst
        ,drvSupervisorEmailAddress = SupNameEmail
        ,drvSTDCoverageEffDate = MIN(CASE WHEN DedDedType = 'STD' THEN EedBenStartDate END)
        ,drvSTDCoverageTermDate = MAX(CASE WHEN DedDedType = 'STD' THEN EedBenStopDate END)
        ,drvSTDOption = MAX(CASE WHEN DedDedType = 'STD' THEN 'STD1' END)
        ,drvLTDCoverageEffDate = MIN(CASE WHEN DedDedType = 'LTD' THEN EedBenStartDate END)
        ,drvLTDCoverageTermDate = MAX(CASE WHEN DedDedType = 'LTD' THEN EedBenStopDate END)
         ,drvLTDOption = MAX(CASE WHEN DedDedType = 'LTD' THEN '@LTDOption' END)
        ,drvCompanyCode = CmpCompanyCode
        ,drvSuppLifeEEAmount = MAX(CASE WHEN DedDedType = 'OPT' THEN dbo.dsi_fnPadZero((EedBenAmt * 100),9,0) END)
        ,drvSuppLifeEEEffectiveDate = MAX(CASE WHEN DedDedType = 'OPT' THEN EedBenStartDate END)
        ,drvSuppLifeEELevel = MAX(CASE WHEN DedDedType = 'OPT' THEN EedDedCode END)
        ,drvSuppLifeSPAmount = MAX(CASE WHEN DedDedType = 'OPS' THEN dbo.dsi_fnPadZero((EedBenAmt * 100),9,0) END)
        ,drvSuppLifeSPEffectiveDate = MAX(CASE WHEN DedDedType = 'OPS' THEN EedBenStartDate END)
        ,drvSuppLifeSPLevel = MAX(CASE WHEN DedDedType = 'OPS' THEN EedDedCode END)
        ,drvSuppLifeCHAmount = MAX(CASE WHEN DedDedType = 'OPC' THEN dbo.dsi_fnPadZero((EedBenAmt * 100),9,0) END)
        ,drvSuppLifeCHEffectiveDate = MAX(CASE WHEN DedDedType = 'OPC' THEN EedBenStartDate END)
        ,drvSuppLifeCHLevel = MAX(CASE WHEN DedDedType = 'OPC' THEN EedDedCode END)
        ,drvLeaveManagementServicesInd = 'Y' --"Y" - Yes
        ,drvLast12MonthsHours = (PehCurHrs * 100)
        ,drvWorkScheduleType = 'W' --W - Total Weekly Hours 
        ,drvScheduledHoursPerWeek = CASE EecPayPeriod
										 WHEN 'W' THEN EecScheduledWorkHrs * 100
										 WHEN 'B' THEN (EecScheduledWorkHrs * 26 / 52) * 100
										 WHEN 'S' THEN (EecScheduledWorkHrs * 24 / 52) * 100
										 WHEN 'M' THEN (EecScheduledWorkHrs * 12 / 52) * 100
									END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.EmpMLoc WITH (NOLOCK)
        ON emlEEID = xEEID
        AND emlCoID = xCOID
        AND emlCode = EecLocation
        AND emlIsPrimary = 'Y'
    LEFT JOIN dbo.U_@CustomFormatCode_Benefits WITH (NOLOCK)
        ON EedEEID = xEEID
        AND EedCoID = xCOID
	LEFT JOIN (
		-- Get Most Recent Job Effective Date of Salary Change
		SELECT EjhEEID
			,EjhCOID
			,EjhJobEffDate = MAX(EjhJobEffDate)
		FROM dbo.EmpHJob WITH (NOLOCK)
		WHERE EjhIsRateChange = 'Y'
		GROUP BY EjhEEID, EjhCOID
	) EmpHJob
		ON EjhEEID = xEEID
		AND EjhCoID = xCOID
	LEFT JOIN (
		-- Total YTD Hours in the Last 12 Months
		SELECT PehEEID
			,PehCurHrs = SUM(PehCurHrs)
		FROM dbo.PEarHist WITH (NOLOCK)
		JOIN dbo.EarnCode WITH (NOLOCK)
			ON ErnEarncode = PehEarnCode
		WHERE LEFT(PehPerControl,8) BETWEEN CONVERT(VARCHAR(8),DATEADD(MONTH,-12,@EndDate),112) AND LEFT(@EndPerControl,8)
		GROUP BY PehEEID
		HAVING SUM(PehCurHrs) <> 0.00
	) PEarHist
        ON PehEEID = xEEID
	LEFT JOIN (
		-- Supervisor Name and Email Information
		SELECT DISTINCT SupEEID = SUP.EecEEID
			,SupEmpNo = SUP.EecEmpNo
			,SupNameFirst = EP.EepNameFirst
			,SupNameLast = EP.EepNameLast
			,SupNameEmail = EP.EepAddressEmail
		FROM dbo.EmpComp EC (NOLOCK)
		JOIN dbo.EmpComp SUP (NOLOCK)
			ON EC.EecSupervisorID = SUP.EecEEID
			AND SUP.EecCoID = dbo.dsi_bdm_fn_GetCurrentCOID(SUP.EecEEID)
			AND ISNULL(EC.EecSupervisorID, '') <> ''
		JOIN dbo.EmpPers EP (NOLOCK)
			ON SUP.EecEEID = EP.Eepeeid
	) Supervisor
		ON Supervisor.SupEEID = EmpComp.EecSupervisorID
    GROUP BY EepSSN, EecEmpNo, EepNameLast, EepNameFirst, LEFT(EepNameMiddle,1), EepAddressLine1, EepAddressLine2, EepAddressCity, EepAddressState
        ,EepAddressZipCode, EepDateOfBirth, EepPhoneHomeNumber, EepGender, EecEmplStatus, EecDateOfTermination, EecEmplStatusStartDate, EecDateOfOriginalHire
        ,EecDateOfLastHire, EecFullTimeOrPartTime, EjhJobEffDate, EecAnnSalary, LEFT(emlSITWorkInStateCode,2), EecWCState, eepAddressEMail, JbcDesc, JbcFLSAType
        ,EecOrgLvl2, EecOrgLvl1, CmpCompanyCode, SupNameLast, SupNameFirst, SupNameEmail, PehCurHrs, EecScheduledWorkHrs, xEEID, xCoID;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
	BEGIN
        UPDATE dbo.U_dsi_Parameters
        SET ExportFile = CASE WHEN @ExportCode = 'TEST' OR dbo.dsi_fnVariable('@CustomFormatCode','Testing') = 'Y' THEN 'Test_@ClientName_Hartford_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.dat'
                              ELSE '@ClientName_Hartford_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.dat'
                         END
        WHERE FormatCode = '@CustomFormatCode';
	END;

END
/*

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201706011'
       ,ExpStartPerControl     = '201706011'
       ,ExpLastEndPerControl   = '201706019'
       ,ExpEndPerControl       = '201706019'
WHERE ExpFormatCode = '@CustomFormatCode';

*/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;