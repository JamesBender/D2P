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
@CustomFormatCode - Replace with Format Code (i.e., EALLSTAHI)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., AllState Export - Hospital Indemnity)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@GroupNumber - Replace with AllState Group Number (i.e., 00000)
@AccountNumber - Replace with AllState Account Number (i.e., 11111)

-- Data parameters
@DedCodeList - Replace with Deduction Code List (i.e., LIFE,VOL,LTD,STD)
@ProductTypeName - Replace with Product Type Name, you may need a CASE statement
@PlanDesignation - Replace with Plan Designation, you may need a CASE statement

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\WexHealth\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\WexHealth\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl2') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl2];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl1') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl1];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_depTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_depTbl];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_curRate') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_curRate];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','@CustomFormatCode','AllState Export - Hospital Indemnity','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N',@AdhSystemID,'N','Feb 17 2017  5:06PM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"GroupNumber"','1','(''DA''=''T,'')',@AdhSystemID,'35','H','01','1',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employees SSN"','2','(''DA''=''T,'')',@AdhSystemID,'35','H','01','2',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LastName"','3','(''DA''=''T,'')',@AdhSystemID,'35','H','01','3',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FirstName"','4','(''DA''=''T,'')',@AdhSystemID,'35','H','01','4',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MiddleInitial"','5','(''DA''=''T,'')',@AdhSystemID,'35','H','01','5',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Sex"','6','(''DA''=''T,'')',@AdhSystemID,'35','H','01','6',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DateofBirth"','7','(''DA''=''T,'')',@AdhSystemID,'35','H','01','7',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DateofHire"','8','(''DA''=''T,'')',@AdhSystemID,'35','H','01','8',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Address"','9','(''DA''=''T,'')',@AdhSystemID,'35','H','01','9',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Address2"','10','(''DA''=''T,'')',@AdhSystemID,'35','H','01','10',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"City"','11','(''DA''=''T,'')',@AdhSystemID,'35','H','01','11',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"State"','12','(''DA''=''T,'')',@AdhSystemID,'35','H','01','12',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Zip"','13','(''DA''=''T,'')',@AdhSystemID,'35','H','01','13',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"JobTitle"','14','(''DA''=''T,'')',@AdhSystemID,'35','H','01','14',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EmployerPaid100%"','15','(''DA''=''T,'')',@AdhSystemID,'35','H','01','15',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CoverageLevel"','16','(''DA''=''T,'')',@AdhSystemID,'35','H','01','16',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Section125"','17','(''DA''=''T,'')',@AdhSystemID,'35','H','01','17',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Premium"','18','(''DA''=''T,'')',@AdhSystemID,'35','H','01','18',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DateofstDeduction"','19','(''DA''=''T,'')',@AdhSystemID,'35','H','01','19',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"RequestedEffDate"','20','(''DA''=''T,'')',@AdhSystemID,'35','H','01','20',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Accountnumber"','21','(''DA''=''T,'')',@AdhSystemID,'35','H','01','21',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Location "','22','(''DA''=''T,'')',@AdhSystemID,'35','H','01','22',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LocationEffectiveDate"','23','(''DA''=''T,'')',@AdhSystemID,'35','H','01','23',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ProductTypeName"','24','(''DA''=''T,'')',@AdhSystemID,'35','H','01','24',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PlanDesignation"','25','(''DA''=''T,'')',@AdhSystemID,'35','H','01','25',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"StatusCode"','26','(''DA''=''T,'')',@AdhSystemID,'35','H','01','26',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TerminationDate"','27','(''DA''=''T,'')',@AdhSystemID,'35','H','01','27',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"AnnualSalary"','28','(''DA''=''T,'')',@AdhSystemID,'35','H','01','28',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TobaccoQuestion"','29','(''DA''=''T,'')',@AdhSystemID,'35','H','01','29',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BenefitFaceAmt"','30','(''DA''=''T,'')',@AdhSystemID,'35','H','01','30',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PremiumDeductionMode"','31','(''DA''=''T,'')',@AdhSystemID,'35','H','01','31',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee ID"','32','(''DA''=''T,'')',@AdhSystemID,'35','H','01','32',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Category Indicator"','33','(''DA''=''T'')',@AdhSystemID,'35','H','01','33',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Group Number"','1','(''DA''=''T,'')',@AdhSystemID,'12','H','02','1',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee''''s SSN"','2','(''DA''=''T,'')',@AdhSystemID,'15','H','02','2',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dependent Last Name"','3','(''DA''=''T,'')',@AdhSystemID,'19','H','02','3',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dependent First Name"','4','(''DA''=''T,'')',@AdhSystemID,'20','H','02','4',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dependent Middle Initial"','5','(''DA''=''T,'')',@AdhSystemID,'24','H','02','5',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dependent SSN"','6','(''DA''=''T,'')',@AdhSystemID,'13','H','02','6',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dependent Gender"','7','(''DA''=''T,'')',@AdhSystemID,'16','H','02','7',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dependent Date of Birth"','8','(''DA''=''T,'')',@AdhSystemID,'23','H','02','8',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Dependent Relationship to Employee/Primary Insured"','9','(''DA''=''T,'')',@AdhSystemID,'50','H','02','9',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Smoker Indicator"','10','(''DA''=''T'')',@AdhSystemID,'16','H','02','10',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGroupNumber"','1','(''UA''=''T,'')',@AdhSystemID,'15','D','10','1',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeSSN"','2','(''UA''=''T,'')',@AdhSystemID,'9','D','10','2',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLastName"','3','(''UA''=''T,'')',@AdhSystemID,'25','D','10','3',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFirstName"','4','(''UA''=''T,'')',@AdhSystemID,'25','D','10','4',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMiddleIntitial"','5','(''UA''=''T,'')',@AdhSystemID,'1','D','10','5',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSex"','6','(''UA''=''T,'')',@AdhSystemID,'9','D','10','6',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofBirth"','7','(''UA''=''T,'')',@AdhSystemID,'10','D','10','7',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofHire"','8','(''UA''=''T,'')',@AdhSystemID,'10','D','10','8',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddress1"','9','(''UA''=''T,'')',@AdhSystemID,'35','D','10','9',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddress2"','10','(''UA''=''T,'')',@AdhSystemID,'35','D','10','10',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','11','(''UA''=''T,'')',@AdhSystemID,'20','D','10','11',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','12','(''UA''=''T,'')',@AdhSystemID,'2','D','10','12',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZip"','13','(''UA''=''T,'')',@AdhSystemID,'10','D','10','13',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvJobTitle"','14','(''UA''=''T,'')',@AdhSystemID,'35','D','10','14',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployerPaid100Percent"','15','(''UA''=''T,'')',@AdhSystemID,'9','D','10','15',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCoverageLevel"','16','(''UA''=''T,'')',@AdhSystemID,'5','D','10','16',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSection125"','17','(''UA''=''T,'')',@AdhSystemID,'20','D','10','17',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPremium"','18','(''UA''=''T,'')',@AdhSystemID,'9','D','10','18',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateof1stDeduction"','19','(''UA''=''T,'')',@AdhSystemID,'10','D','10','19',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRequestedEffDate"','20','(''UA''=''T,'')',@AdhSystemID,'10','D','10','20',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAccountNumber"','21','(''UA''=''T,'')',@AdhSystemID,'15','D','10','21',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLocation"','22','(''UA''=''T,'')',@AdhSystemID,'20','D','10','22',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLocationEffDate"','23','(''UA''=''T,'')',@AdhSystemID,'10','D','10','23',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvProductTypeName"','24','(''UA''=''T,'')',@AdhSystemID,'20','D','10','24',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanDesignation"','25','(''UA''=''T,'')',@AdhSystemID,'20','D','10','25',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatusCode"','26','(''UA''=''T,'')',@AdhSystemID,'1','D','10','26',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTerminationDate"','27','(''UA''=''T,'')',@AdhSystemID,'10','D','10','27',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAnnualSalary"','28','(''UA''=''T,'')',@AdhSystemID,'9','D','10','28',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTobaccoQuestion"','29','(''UA''=''T,'')',@AdhSystemID,'1','D','10','29',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBenefitAmt"','30','(''UA''=''T,'')',@AdhSystemID,'9','D','10','30',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPremiumDeductionMode"','31','(''UA''=''T,'')',@AdhSystemID,'1','D','10','31',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeID"','32','(''UA''=''T,'')',@AdhSystemID,'9','D','10','32',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCategoryIndicator"','33','(''UA''=''T'')',@AdhSystemID,'2','D','10','33',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGroupNumber"','1','(''UA''=''T,'')',@AdhSystemID,'10','D','20','1',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEESSN"','2','(''UA''=''T,'')',@AdhSystemID,'9','D','20','2',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameLast"','3','(''UA''=''T,'')',@AdhSystemID,'20','D','20','3',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameFirst"','4','(''UA''=''T,'')',@AdhSystemID,'17','D','20','4',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNameMiddleInit"','5','(''UA''=''T,'')',@AdhSystemID,'1','D','20','5',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','6','(''UA''=''T,'')',@AdhSystemID,'9','D','20','6',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','7','(''UA''=''T,'')',@AdhSystemID,'1','D','20','7',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofBirth"','8','(''UA''=''T,'')',@AdhSystemID,'10','D','20','8',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRelationship"','9','(''UA''=''T,'')',@AdhSystemID,'1','D','20','9',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSmokerInd"','10','(''UA''=''T'')',@AdhSystemID,'1','D','20','10',NULL,NULL,NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'AllState Hosp Indemnity OE Act','201702179','EMPEXPORT','EMPOEACT',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702179',NULL,NULL,'201611191',NULL,NULL,NULL,'201611191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'AllState Hosp Indemnity OE Pas','201702179','EMPEXPORT','EMPOEPAS',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702179',NULL,NULL,'201611191',NULL,NULL,NULL,'201611191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'AllState Hosp Indemnity OE Act','201702179','EMPEXPORT','DEPOEACT',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702179',NULL,NULL,'201611191',NULL,NULL,NULL,'201611191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'AllState Hosp Indemnity OE Pas','201702179','EMPEXPORT','DEPOEPAS',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201702179',NULL,NULL,'201611191',NULL,NULL,NULL,'201611191',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','','',NULL,NULL,NULL,'AllState Hosp Indemn EE Test','201704069','EMPEXPORT','EMPTEST','Apr  6 2017 12:38PM','@CustomFormatCode',NULL,NULL,NULL,'201704069','Apr  6 2017 12:00AM','Dec 30 1899 12:00AM','201704061','119','','','201704061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','','',NULL,NULL,NULL,'AllState Hosp Indemn DEP Test','201702289','EMPEXPORT','DEPTEST','Apr  6 2017 12:40PM','@CustomFormatCode',NULL,NULL,NULL,'201702289','Feb 28 2017 12:00AM','Dec 30 1899 12:00AM','201702281','121','','','201702281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','','',NULL,NULL,NULL,'AllState Hosp Indemn DEP Prod','201705041','EMPEXPORT','DEPPROD','May  4 2017 11:42AM','@CustomFormatCode',NULL,NULL,NULL,'201705041','May  4 2017 12:00AM','Dec 30 1899 12:00AM','201704011','121','','','201704011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','','',NULL,NULL,NULL,'AllState Hosp Indemn EE Prod','201705049','EMPEXPORT','EMPPROD','May  4 2017 11:43AM','@CustomFormatCode',NULL,NULL,NULL,'201705049','May  4 2017 12:00AM','Dec 30 1899 12:00AM','201704011','121','','','201704011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPTEST','H','01','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPTEST','D','10','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPTEST','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPTEST','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPPROD','H','01','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPPROD','D','10','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPPROD','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPPROD','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEACT','H','01','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEACT','D','10','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEACT','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEACT','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEPAS','H','01','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEPAS','D','10','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEPAS','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','EMPOEPAS','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPTEST','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPTEST','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPTEST','H','02','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPTEST','D','20','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPPROD','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPPROD','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPPROD','H','02','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPPROD','D','20','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEACT','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEACT','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEACT','H','02','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEACT','D','20','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEPAS','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEPAS','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEPAS','H','02','N','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPOEPAS','D','20','N','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H02','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_dsi_@CustomFormatCode_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_dsi_@CustomFormatCode_depTbl',NULL);
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
	@systemid VARCHAR(12) = ''
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: AllState Export - Hospital Indemnity

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
	DECLARE @FormatCode VARCHAR(10)
		,@ExportCode VARCHAR(10)
		,@StartDate DATETIME
		,@EndDate DATETIME
		,@StartPerControl VARCHAR(9)
		,@EndPerControl VARCHAR(9)
		,@FileDate DATETIME;

	-- Declare dates from Parameter file
	SELECT @StartPerControl = StartPerControl
		,@EndPerControl = EndPerControl
		,@StartDate = CAST(LEFT(StartPerControl, 8) AS DATETIME)
		,@EndDate = CAST(LEFT(EndPerControl, 8) AS DATETIME)
		,@FormatCode = FormatCode
		,@ExportCode = ExportCode
		,@FileDate = GETDATE()
	FROM dbo.U_dsi_Parameters WITH (NOLOCK)
	WHERE FormatCode = '@CustomFormatCode';

	--==========================================
	-- Clean EE List 
	--==========================================
	-- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
	DELETE FROM dbo.U_@CustomFormatCode_EEList
	WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
	AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

	--==========================================
	-- BDM Section
	--==========================================
	DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes','@DedCodeList');
	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption','AuditDate');

	IF (@ExportCode LIKE '%OEPAS%')
	BEGIN
		INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','Passive');
	END;

	IF (@ExportCode LIKE '%OEACT%')
	BEGIN
		INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','Active');
	END;

	EXECUTE dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

	--==========================================
	-- Build Working Tables
	--==========================================
	IF OBJECT_ID('U_dsi_@CustomFormatCode_curRate','U') IS NOT NULL
		DROP TABLE dbo.U_dsi_@CustomFormatCode_curRate;
	SELECT curDedcode = CorDedCode
		,curBenOption = CorBenOption
		,curEERate = CorEERate
		,curPayFreq = CorPayFreq
		,RowNum = ROW_NUMBER() OVER (PARTITION BY CorDedCode,CorBenOption,CorPayFreq ORDER BY CorEffDate DESC)
	INTO dbo.U_dsi_@CustomFormatCode_curRate
	FROM dbo.OptRate
	WHERE CorDedCode IN (SELECT DISTINCT udcdedcode FROM dbo.U_dsi_BDM_DeductionCodes WHERE UdcFormatCode = @FormatCode)
	AND CorEffDate <= @FileDate
	GROUP BY CorDedCode,CorBenOption,CorEffDate,CorEERate,CorPayFreq;

	--Delete Oldest
	DELETE dbo.U_dsi_@CustomFormatCode_curRate
	FROM dbo.U_dsi_@CustomFormatCode_curRate
	WHERE RowNum <> 1;

	--==========================================
	-- Build Driver Tables
	--==========================================

	---------------------------------
	-- Detail Record - Employee
	---------------------------------
	IF OBJECT_ID('U_dsi_@CustomFormatCode_drvTbl','U') IS NOT NULL
		DROP TABLE dbo.U_dsi_@CustomFormatCode_drvTbl;
	SELECT DISTINCT drvEEID = xEEID
		,drvcoid = xCOID
		,drvdepid = CAST(NULL AS VARCHAR)
		,drvrectype = 'E'
		,drvsort = EepSSN
		-- standard fields above and additional driver fields below
		,drvGroupNumber = '@GroupNumber'
		,drvEmployeeSSN = EepSSN
		,drvLastName = dbo.dsi_fnRemoveChars('.,/', EepNameLast)
		,drvFirstName = EepNameFirst
		,drvMiddleIntitial = LEFT(EepNameMiddle,1)
		,drvSex = EepGender
		,drvDateofBirth = CONVERT(VARCHAR(10), EepDateOfBirth, 101)
		,drvDateofHire = CONVERT(VARCHAR(10), EecDateOfOriginalHire, 101)
		,drvAddress1 = dbo.dsi_fnRemoveChars('.,/', EepAddressLine1)
		,drvAddress2 = dbo.dsi_fnRemoveChars('.,/', EepAddressLine2)
		,drvCity = EepAddressCity
		,drvState = EepAddressState
		,drvZip = EepAddressZipCode
		,drvJobTitle = dbo.dsi_fnRemoveChars('.,/', JbcDesc)
		,drvEmployerPaid100Percent = 'N'
		,drvCoverageLevel = RIGHT(RTRIM(EedBenOption), 1)
		,drvSection125 = ''
		,drvPremium = CONVERT(MONEY,CurEERate)
		,drvDateof1stDeduction = CONVERT(VARCHAR(10), EedStartDate, 101)
		,drvRequestedEffDate = CONVERT(VARCHAR(10), EedBenStartDate, 101)
		,drvAccountNumber = '@AccountNumber'
		,drvLocation = '1'
		,drvLocationEffDate = CONVERT(VARCHAR(10), EedBenStartDate, 101)
		,drvProductTypeName = '@ProductTypeName'
		,drvPlanDesignation = '@PlanDesignation'
		,drvStatusCode = CASE WHEN EedBenStopDate IS NOT NULL THEN 'T'
							  ELSE ' '
						 END
		,drvTerminationDate = CONVERT(VARCHAR(10), EedBenStopDate, 101)
		,drvAnnualSalary = CONVERT(MONEY,EecAnnSalary)
		,drvTobaccoQuestion = ''
		,drvBenefitAmt = '0'
		,drvPremiumDeductionMode = CASE WHEN EecPayPeriod = 'M' THEN '12'
										WHEN EecPayPeriod = 'B' THEN '26'
										WHEN EecPayPeriod = 'S' THEN '24'
										WHEN EecPayPeriod = 'W' THEN '52'
								   END
		,drvEmployeeID = ''
		,drvCategoryIndicator = ''
	INTO dbo.U_dsi_@CustomFormatCode_drvTbl
	FROM dbo.u_@CustomFormatCode_eelist WITH (NOLOCK)
	INNER JOIN dbo.EmpPers WITH (NOLOCK)
		ON eepEEID = xEEID
	INNER JOIN dbo.EmpComp WITH (NOLOCK)
		ON EecEEID = xEEID
		AND EecCOID = xCOID
	INNER JOIN dbo.JobCode WITH (NOLOCK)
		ON JbcJobCode = EecJobCode
	INNER JOIN dbo.U_dsi_bdm_EmpDeductions
		ON EedFormatCode = @FormatCode
		AND EedValidForExport = 'Y'
		AND EedCOID = xCOID
		AND EedEEID = xEEID
	LEFT JOIN (
		SELECT curdedcode
			,curBenOption
			,curPayFreq
			,cureeRate
		FROM dbo.U_dsi_@CustomFormatCode_curRate
	) rate
		ON curDedcode = EedDedCode
		AND curBenOption = EedBenOption
		AND curPayFreq = EecPayPeriod;

	---------------------------------
	-- Detail Record - Dependents
	---------------------------------
	IF OBJECT_ID('U_dsi_@CustomFormatCode_depTbl','U') IS NOT NULL
		DROP TABLE dbo.U_dsi_@CustomFormatCode_depTbl;
	SELECT drvEEID = xEEID
		,drvcoid = xCOID
		,drvdepid = DbnDepRecID
		,drvrectype = 'D'
		,drvsort = ConSSN
		-- standard fields above and additional driver fields below
		,drvGroupNumber = '@GroupNumber'
		,drvEESSN = eepSSN
		,drvNameLast = dbo.dsi_fnRemoveChars('.,/', ConNameLast)
		,drvNameFirst = ConNameFirst
		,drvNameMiddleInit = LEFT(ConNameMiddle,1)
		,drvSSN = ConSSN
		,drvGender = ConGender
		,drvDateofBirth = CONVERT(VARCHAR(10),ConDateofBirth,101)
		,drvRelationship = CASE WHEN ConRelationship IN ('SPS','HUS','WIF','DP') THEN 'S'
								ELSE 'C'
						   END
		,drvSmokerInd = REPLACE(ISNULL(ConIsSmoker, ''), 'Z', '')
	INTO dbo.U_dsi_@CustomFormatCode_depTbl
	FROM dbo.u_@CustomFormatCode_eelist WITH (NOLOCK)
	INNER JOIN dbo.EmpPers WITH (NOLOCK)
		ON eepEEID = xEEID
	INNER JOIN dbo.EmpComp WITH (NOLOCK)
		ON EecEEID = xEEID
		AND EecCOID = xCOID
	INNER JOIN dbo.U_dsi_bdm_DepDeductions
		ON DbnFormatCode = @FormatCode
		AND dbnValidForExport = 'Y'
		AND DbnCOID = xCOID
		AND DbnEEID = xEEID
	INNER JOIN dbo.Contacts WITH (NOLOCK)
		ON ConSystemID = DbnDepRecID;

	--==========================================
	-- Set FileName
	--========================================== 
	IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
	BEGIN
		UPDATE dbo.U_dsi_Parameters
		SET ExportFile = 'ALLSTATE_' + '@GroupNumber_' + CONVERT(CHAR(8), GETDATE(), 112) + '.txt'
		WHERE FormatCode = @FormatCode;
	END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2),InitialSort,SubSort;

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
	SELECT TOP 200000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
	ORDER BY RIGHT(RecordSet,2),InitialSort,SubSort;
GO
