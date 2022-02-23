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
@CustomFormatCode - Replace with Format Code (i.e., ISCHWAB401)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Schwab Deferral and Loan Import)

-- File parameters
@FileArchivePath - Replace with the Archive Path where the Vendor Import File is located (i.e., \\us.saas\e1\Public\[Client ARNum]\Imports\[Vendor]\Archive\)
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Imports\[Vendor]\Logs\)
@FileImportPath - Replace with the Import Path where the Vendor Import File is located (i.e., \\us.saas\e1\Public\[Client ARNum]\Imports\[Vendor]\)

-- Data parameters
@401kDedCode - Replace with the 401k Deduction Code (i.e., 401K)
@RothDedCode - Replace with the Roth Deduction Code (i.e., ROTH)

@LoanDedCode - Replace with the Loan Deduction Code (i.e., 401L)

*** Loan Notes ***:
Loan Recycling may need custom coding when Multiple Loan Deduction Codes are involved.

NOTE: This utilizes the New Benefit Import Module (BIM) tool, which should be installed on all UDE client boxes.  If not, then please manually deploy.
*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_Raw') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Raw];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_Import') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Import];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscImp] FROM [dbo].[AscImp] WHERE impFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID1 VARCHAR(12), @AdhSystemID2 VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID1 = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @AdhSystemID2 = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z1';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N',NULL,'Y','0',NULL,NULL,'N',NULL,'N','E','013010','BENEFITIMP','SDF','@CustomFormatCode',@FixedFormatName1,'N','I','FORM_ASCIIIMPORTBENEFITS','N','N',dbo.fn_GetTimedKey(),'D',NULL,NULL,'S','N',@AdhSystemID2,'N',NULL,'N','N',NULL,'N';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_switchbox_v2','2000','S','N',@AdhSystemID1,'N',NULL,'C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee#"','1','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','1',NULL,'Employee#',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee Name"','2','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','2',NULL,'Employee Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Participant_SSN"','3','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','3',NULL,'Participant_SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Loan_ID"','4','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','4',NULL,'Loan_ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Loan_First_Payment_Date"','5','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','5',NULL,'Loan_First_Payment_Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Loan_Payment_Amount"','6','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','6',NULL,'Loan_Payment_Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"UltiPro Deduction Code"','7','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','7',NULL,'UltiPro Deduction Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Action"','8','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','8',NULL,'Action',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Error Message"','9','(''DA''=''T'')',@AdhSystemID1,'50','H','01','9',NULL,'Error Message',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmpNo"','1','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','1',NULL,'Employee#',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmpName"','2','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','2',NULL,'Employee Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantSSN"','3','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','3',NULL,'Participant_SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanID"','4','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','4',NULL,'Loan_ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanFirstPaymentDate"','5','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','5',NULL,'Loan_First_Payment_Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanPaymentAmount"','6','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','6',NULL,'Loan_Payment_Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDedCode"','7','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','7',NULL,'UltiPro Deduction Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAction"','8','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','8',NULL,'Action',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvError"','9','(''UA''=''T'')',@AdhSystemID1,'250','D','10','9',NULL,'Error Message',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee#"','1','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','1',NULL,'Employee#',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Employee Name"','2','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','2',NULL,'Employee Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Participant_SSN"','3','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','3',NULL,'Participant_SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Deferral_Change_Source_Index"','4','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','4',NULL,'Deferral_Change_Source_Index',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Deferral_Change_New_Percentage"','5','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','5',NULL,'Deferral_Change_New_Percentage',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Deferral_Change_New_Dollar_Amt"','6','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','6',NULL,'Deferral_Change_New_Dollar_Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Deferral_Change_Effective_Date"','7','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','7',NULL,'Deferral_Change_Effective_Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"UltiPro Deduction Code"','8','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','8',NULL,'UltiPro Deduction Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Action"','9','(''DA''=''T,'')',@AdhSystemID1,'50','H','01','9',NULL,'Action',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Error Message"','10','(''DA''=''T'')',@AdhSystemID1,'50','H','01','10',NULL,'Error Message',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmpNo"','1','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','1',NULL,'Employee#',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmpName"','2','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','2',NULL,'Employee Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantSSN"','3','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','3',NULL,'Participant_SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferralChangeSourceIndex"','4','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','4',NULL,'Deferral_Change_Source_Index',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferralChangeNewPercentage"','5','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','5',NULL,'Deferral_Change_New_Percentage',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferralChangeNewDollarAmt"','6','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','6',NULL,'Deferral_Change_New_Dollar_Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferralChangeEffDate"','7','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','7',NULL,'Deferral_Change_Effective_Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDedCode"','8','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','8',NULL,'UltiPro Deduction Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAction"','9','(''UA''=''T,'')',@AdhSystemID1,'50','D','10','9',NULL,'Action',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvError"','10','(''UA''=''T'')',@AdhSystemID1,'250','D','10','10',NULL,'Error Message',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'Enter Deferral File Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Schwab Deferral File',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','DEFERRAL','Jun 01 2018 12:17PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Jun 01 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'Enter Loan File Name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Schwab Loan File',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','LOAN','Jun 01 2018 12:17PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Jun 01 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscImp] (impCOID,impDateAccruedThru,impDateOfRollover,impDatePendingMoved,impDesc,impEEIdentifier,impEngine,impExceptions,impFormatCode,impImportCode,impImported,impPayPeriodID,impPosted,impReset,impSessionType,impSource,impSystemID,impUser,impValid,impVerified) SELECT '',NULL,NULL,NULL,@FixedFormatName2,'E','BENEFITIMP','0','@CustomFormatCode','@CustomFormatCode',NULL,NULL,'Jun 01 2018 12:17PM','Jun 01 2018 12:17PM',NULL,'VALIDATE / POST / RESET ONLY (DO NOT CLICK IMPORT)',dbo.fn_GetTimedKey(),'ULTI','0','Jun 01 2018 12:17PM';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ArchivePath','V','@FileArchivePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ImportPath','V','@FileImportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','NoEmpty','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','U_@CustomFormatCode_DrvTbl',NULL);
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
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By            Date            Request Num                Desc
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE ExpFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'DEFERRAL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'LOAN';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
**********************************************************************************/
BEGIN

    --==================================================
    -- Declare Variables
    --==================================================
    DECLARE  @FormatCode VARCHAR(10)
            ,@ExportCode VARCHAR(10)
            ,@ImportPath VARCHAR(500)
            ,@FileName VARCHAR(500)
			,@EnableStandardWebImport CHAR(1);

    SET @FormatCode = '@CustomFormatCode';
    SET @ExportCode = (SELECT ExportCode FROM dbo.U_dsi_Parameters (NOLOCK) WHERE FormatCode = @FormatCode);

    --Set directory and filename where import file is located
    SET @ImportPath = dbo.Dsi_fnVariable(@FormatCode,'ImportPath');
    SET @FileName = (SELECT expAscFileName FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = @ExportCode);
	SET @EnableStandardWebImport = 'N'; --Enables Standard Web Import ('Y'), or BackOffice LOD Tables ('N')

    --========================================
    -- Update Settings for Web/BackOffice
    --========================================
    IF (@EnableStandardWebImport = 'Y')
    BEGIN
        UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = @FormatCode AND CfgName = 'ExportPath'; -- needed for web to work
        UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y' WHERE FormatCode = @FormatCode AND CfgName = 'UseFileName';
    END
    ELSE
    BEGIN
        UPDATE dbo.U_dsi_Configuration SET CfgValue = dbo.Dsi_fnVariable(@FormatCode,'ImportPath') + 'Logs\' WHERE FormatCode = @FormatCode AND CfgName = 'ExportPath';
        UPDATE dbo.U_dsi_Configuration SET CfgValue = 'N' WHERE FormatCode = @FormatCode AND CfgName = 'UseFileName';
    END;

    --==================================================
    -- Set FileName
    --==================================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
		UPDATE dbo.U_dsi_Parameters
		SET ExportFile = 'SchwabImport_' + LTRIM(RTRIM(ExportCode)) + '_'
						+ CONVERT(CHAR(8),GETDATE(),112)                          -- YYYYMMDD
						+ REPLACE(CONVERT(VARCHAR(8),GETDATE(),108),':',SPACE(0)) -- HHMMss
						+ '.csv'
		WHERE FormatCode = @FormatCode;
	END;

    --==================================================
    -- Create Driver Table for Error Report
    --==================================================
    IF object_id('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    CREATE TABLE dbo.U_@CustomFormatCode_drvTbl (
		 drvSurrogateKey VARCHAR(50) NULL
		,drvEmpNo VARCHAR(50) NULL
		,drvEmpName VARCHAR(50) NULL
		,drvParticipantSSN VARCHAR(50) NULL
		,drvDeferralChangeNewPercentage VARCHAR(50) NULL
		,drvLoanID VARCHAR(50) NULL
		,drvLoanPaymentAmount VARCHAR(50) NULL
		,drvLoanGoalAmount VARCHAR(50) NULL
		,drvAction VARCHAR(50) NULL
		,drvError VARCHAR(250) NULL
		,drvImported TINYINT DEFAULT 0 NOT NULL
		,drvEEID VARCHAR(12) NULL
		,drvCOID VARCHAR(5) NULL
		,drvDedCode VARCHAR(50) NULL
		,drvImportType VARCHAR(50) NULL
		,drvPeriodStartDate VARCHAR(50) NULL
		,drvPendingUpdateID VARCHAR(50) NULL
		,drvInitialSort VARCHAR(50) NULL
    );

    --===================================================
    -- BIM CODE - Deferral (Contribution Rate Change)
    --===================================================
    IF (@ExportCode = 'DEFERRAL')
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','DEFERRAL');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileFormat','Fixed');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','9'); -- MAX Field Count should match for all layouts
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- Fixed Length File Format
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',1,1,15,'Participant_SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',2,16,5,'Participant_Division');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',3,21,15,'Participant_Alt_Key1');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',4,36,15,'Participant_Alt_Key2');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',5,51,5,'Deferral_Change_Source_Index');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',6,56,5,'Deferral_Change_New_Percentage');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',7,61,11,'Deferral_Change_New_Dollar_Amt');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',8,72,1,'Deferral_Change_New_Frequency');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',9,73,10,'Deferral_Change_Effective_Date');

        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        -- For Web, Sweep Files in 'ImportPath' folder for Deferral Files Only
        IF (@EnableStandardWebImport = 'Y')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
			INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*Deferral*'); --File Name contains "Deferral"
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName',@FileName);
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        --------------------------------------------------------------------
        -- Only Retain Records where Participant SSN in Field# 1 is Numeric
        --------------------------------------------------------------------
        DELETE FROM dbo.U_@CustomFormatCode_Import WHERE ISNUMERIC(REPLACE(Field1,'-','') = 0 AND RunID = 'DEFERRAL' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvError)
       SELECT 'Error Processing Fixed File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================================
    -- BIM CODE - Loan (Combined Loan Origination and Loan Payoff)
    --==============================================================
    IF (@ExportCode = 'LOANS')
    BEGIN TRY
        DELETE FROM dbo.U_dsi_BIM_Configuration WHERE FormatCode = @FormatCode;

        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'RunID','LOAN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FilePath',@ImportPath);
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileFormat','Fixed');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FieldCount','16'); -- MAX Field Count should match for all layouts
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2) VALUES (@FormatCode,'KeyEEID','Field1','SSN');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'PayrollType','Regular'); --Regular --PayGroup --Non-Closed --Non-Opened

        -- Fixed Length File Format
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',1,1,15,'Participant_SSN')
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',2,16,5,'Participant_Division');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',3,21,15,'Participant_Alt_Key1');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',4,36,15,'Participant_Alt_Key2');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',5,51,3,'Loan_ID');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',6,54,5,'Loan_Number_of_Payments');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',7,59,1,'Loan_Payment_Frequency');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',8,60,5,'Loan_Term in Months');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',9,65,10,'Loan_Origination_Date');
        INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',10,77,10,'Loan_First_Payment_Date');
		INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',11,85,10,'Loan_Maturity_Date');
		INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',12,95,15,'Loan_Payment_Amount');
		INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',13,110,15,'Loan_Total_Principle');
		INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',14,125,15,'Loan_Total_Interest');
		INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',15,140,15,'Loan_Goal_Amount');
		INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1,ParmValue2,ParmValue3,ParmValue4) VALUES (@FormatCode,'FixedLayout',16,155,10,'Loan_Payoff_Date');

        -- For Web Validate Mode Only, then Copy Files.  Otherwise Archive Files
        IF (dbo.dsi_BIM_fn_GetValidateModeSetting() = 'TRUE')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'CopyFiles','Y');
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'ArchiveFiles','Y');
        END;

        -- For Web, Sweep Files in 'ImportPath' folder for Deferral Files Only
        IF (@EnableStandardWebImport = 'Y')
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'MultipleFiles','Y'); -- Sweep Folder and Import Files
			INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName','*Loan*'); --File Name contains "Loan"
        END
        ELSE
        BEGIN
            INSERT INTO dbo.U_dsi_BIM_Configuration (FormatCode,ParmName,ParmValue1) VALUES (@FormatCode,'FileName',@FileName);
        END;

        EXEC dbo.dsi_BIM_sp_PopulateImportTable @FormatCode;

        --------------------------------------------------------------------
        -- Only Retain Records where Participant SSN in Field# 1 is Numeric
        --------------------------------------------------------------------
        DELETE FROM dbo.U_@CustomFormatCode_Import WHERE ISNUMERIC(REPLACE(Field1,'-','') = 0 AND RunID = 'LOAN' AND ISNULL(Error,'') = '';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvError)
       SELECT 'Error Processing Fixed File (BIM): ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==============================================
    -- Report Error Parsing File - Stop Processing
    --==============================================
    IF EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Import WHERE ISNULL(Error,'') <> '')
    BEGIN
       -- Report Error in Error Report File
       INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvError)
       SELECT DISTINCT Error FROM dbo.U_@CustomFormatCode_Import WHERE ISNULL(Error,'') <> '';

       -- Stop Processing
       RETURN;
    END;

    --==================================================
    -- Build Driver Table - Deferral
    --==================================================
	BEGIN TRY
		INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvSurrogateKey,drvEmpNo,drvEmpName,drvParticipantSSN,drvDeferralChangeNewPercentage,drvAction
			,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort)
		SELECT DISTINCT
			drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
			,drvEmpNo = EmployeeNo
			,drvEmpName = EmployeeName
			,drvParticipantSSN = NULLIF(Field1,'')
			,drvDeferralChangeNewPercentage = CONVERT(MONEY,Field6)/100
			,drvAction = CASE WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match [Participant SSN] in File to Employee in UltiPro
							  WHEN EecEmplStatus = 'T' THEN 'REJECTED' -- Terminated Employee
							  WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.
							  WHEN CONVERT(MONEY,Field6)/100 = 0.00 THEN
								CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
									 ELSE 'REJECTED' --No Deduction/Benefit Plan to Stop
								END
							ELSE
								CASE WHEN EedDedCode IS NOT NULL THEN
										CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
											 ELSE 'CHANGE'
										END
									 ELSE 'ADD'
								END
						 END
			,drvError = CASE WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match [Participant SSN] in File to Employee in UltiPro.'
							 WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Terminated Employee in UltiPro.'
							 WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
							 WHEN EedDedCode IS NULL AND CONVERT(MONEY,Field6)/100 = 0.00 THEN 'Record Rejected: Cannot STOP Record - Deduction/Benefit Plan Does Not Exist for Employee in UltiPro.'
						END
			,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
								WHEN EEID IS NULL THEN 2 --Unable to Match [Participant SSN] in File to Employee in UltiPro
								WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
								WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.
								WHEN EedDedCode IS NULL AND CONVERT(MONEY,Field6)/100 = 0.00 THEN 2 --No Deduction/Benefit Plan to Stop
								ELSE 0
						   END
			,drvEEID = EEID
			,drvCOID = COID
			,drvDedCode = CASE WHEN Field5 = '00001' THEN '@401kDedCode' --401K Plan
							   WHEN Field5 ='00002' THEN '@RothDedCode' --Roth Plan
						  END
			,drvImportType = RunID
			,drvPeriodStartDate = CONVERT(VARCHAR(10),PayPeriodStartDate,101))
			,drvInitialSort = ISNULL(Field1,'')
		INTO dbo.U_@CustomFormatCode_drvTbl
		FROM dbo.U_@CustomFormatCode_Import
		LEFT JOIN dbo.EmpComp WITH (NOLOCK)
			ON EecEEID = EEID
			AND EecCoID = COID
		LEFT JOIN dbo.DedCode WITH (NOLOCK)
			ON DedDedCode = CASE WHEN Field5 = '00001' THEN '@401kDedCode' --401K Plan
								 WHEN Field5 = '00002' THEN '@RothDedCode' --Roth Plan
							END
		LEFT JOIN dbo.EmpDed WITH (NOLOCK)
			ON  EedEEID = EEID
			AND EedCOID = COID
			AND EedDedCode = DedDedCode
		WHERE RunID = 'DEFERRAL';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvError)
       SELECT 'Error Processing Deferral File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==================================================
    -- Build Driver Table - Loans
    -- NOTE: Loan Recycling may need custom coding when Multiple Loan Deduction Codes are involved.
    --==================================================
	BEGIN TRY
		INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvSurrogateKey,drvEmpNo,drvEmpName,drvParticipantSSN,drvLoanID,drvLoanPaymentAmount,drvLoanGoalAmount
			,drvAction,drvError,drvImported,drvEEID,drvCOID,drvDedCode,drvImportType,drvPeriodStartDate,drvInitialSort)
		SELECT DISTINCT
			drvSurrogateKey = RTRIM(EEID) + RTRIM(COID) + RTRIM(DedDedCode)
			,drvEmpNo = EmployeeNo
			,drvEmpName = EmployeeName
			,drvParticipantSSN = NULLIF(Field1,'')
			,drvLoanID = NULLIF(Field5,'')
			,drvLoanPaymentAmount = NULLIF(Field12,'')
			,drvLoanGoalAmount = NULLIF(Field15,'')
			,drvAction = CASE WHEN EEID IS NULL THEN 'REJECTED' --Unable to Match [Participant SSN] in File to Employee in UltiPro
							  WHEN EecEmplStatus = 'T' THEN 'REJECTED' --Terminated Employee
							  WHEN DedDedCode IS NULL THEN 'REJECTED' --Deduction/Benefit Plan NOT in UltiPro Setup Tables.
							  WHEN CONVERT(MONEY,Field12) = 0.00 THEN
								CASE WHEN EedDedCode IS NOT NULL THEN 'STOP'
									 ELSE 'REJECTED' --No Deduction/Benefit Plan to Stop
								END
							  ELSE
								CASE WHEN EedDedCode IS NOT NULL THEN
										CASE WHEN COALESCE(EedBenStopDate,EedStopDate) IS NOT NULL THEN 'RESTART'
											 ELSE 'CHANGE'
										END
									 ELSE 'ADD'
								END
						 END
			,drvError = CASE WHEN EEID IS NULL THEN 'Record Rejected: Unable to Match [Participant SSN] in File to Employee in UltiPro.'
							 WHEN EecEmplStatus = 'T' THEN 'Record Rejected: Terminated Employee in UltiPro.'
							 WHEN DedDedCode IS NULL THEN 'Record Rejected: Deduction/Benefit Plan NOT in UltiPro Setup Tables.'
							 WHEN EedDedCode IS NULL AND CONVERT(MONEY,Field12) = 0.00 THEN 'Record Rejected: Unable to Match [Loan Number]:' + ISNULL(Field5,'') + ' in File with Member/Case number/Reference number in UltiPro.'
						END
			,drvImported = CASE -- 0 = Initial Load, 1 = Imported/Updated, 2 = Rejected
								WHEN EEID IS NULL THEN 2 --Unable to Match [Participant SSN] in File to Employee in UltiPro
								WHEN EecEmplStatus = 'T' THEN 2 --Terminated Employee
								WHEN DedDedCode IS NULL THEN 2 --Deduction/Benefit Plan NOT in UltiPro Setup Tables.
								WHEN EedDedCode IS NULL AND CONVERT(MONEY,Field12) = 0.00 THEN 2 --No Deduction/Benefit Plan to Stop
								ELSE 0
						   END
			,drvEEID = EEID
			,drvCOID = COID
			,drvDedCode = DedDedCode
			,drvImportType = RunID
			,drvPeriodStartDate = CONVERT(VARCHAR(10),PayPeriodStartDate,101)
			,drvInitialSort = ISNULL(Field1,'')
		INTO dbo.U_@CustomFormatCode_drvTbl
		FROM dbo.U_@CustomFormatCode_Import
		LEFT JOIN dbo.EmpComp WITH (NOLOCK)
			ON EecEEID = EEID
			AND EecCoID = COID
		LEFT JOIN dbo.DedCode WITH (NOLOCK)
			ON DedDedCode = '@LoanDedCode' --401k Loan
		LEFT JOIN dbo.EmpDed WITH (NOLOCK)
			ON  EedEEID = EEID
			AND EedCOID = COID
			AND EedDedCode = DedDedCode
		WHERE RunID = 'LOAN';

        --=====================================================
        -- Reject Add/Restarts where Deduction Code is NULL
        --=====================================================
        UPDATE D1
        SET D1.drvError = 'Record Ignored: Recycling Deduction Code: ' + ISNULL(D1.DrvDedCode,'')
            ,drvAction = 'IGNORED'
            ,DrvImported = 2
        FROM dbo.U_@CustomFormatCode_drvTbl D1
        JOIN dbo.U_@CustomFormatCode_drvTbl D2
            ON D2.DrvEEID = D1.DrvEEID
            AND D2.DrvCOID = D1.DrvCOID
            AND D2.DrvDedCode = D1.DrvDedCode
            AND D2.drvImported = D1.drvImported
        WHERE D1.drvImported = 0 AND D1.drvAction = 'STOP' AND D2.drvAction <> 'STOP';

        --=====================================================
        -- Reject Add/Restarts where Deduction Code is NULL
        --=====================================================
        UPDATE dbo.U_@CustomFormatCode_drvTbl
        SET drvError = 'Record Rejected: Maximum Allowed Active Loans Exceeded.'
            ,drvAction = 'REJECTED'
            ,DrvImported = 2
        WHERE drvImported = 0 AND drvAction IN ('ADD','RESTART') AND drvDedCode IS NULL;

        --=====================================================
        -- Reject Stops/Changes where Deduction Code is NULL
        --=====================================================
        UPDATE dbo.U_@CustomFormatCode_drvTbl
        SET drvError = 'Record Rejected: No Active Deduction Code to STOP/CHANGE in UltiPro.'
            ,drvAction = 'REJECTED'
            ,DrvImported = 2
        WHERE drvImported = 0 AND drvAction IN ('STOP','CHANGE') AND drvDedCode IS NULL;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvError)
       SELECT 'Error Processing Loan File: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --============================================
    -- Update PendingUpdateID for Valid Records
    --============================================
    UPDATE dbo.U_@CustomFormatCode_drvTbl
    SET PendingUpdateID = LEFT('@CustomFormatCode' + dbo.fn_GetTimedKey(),20)
    WHERE drvImported = 0;

    --==================================================
    -- Populate LOD Tables (BackOffice Validation/Posting)
    --==================================================
	IF (@EnableStandardWebImport = 'N')
	BEGIN TRY
		--=========================================
		-- Populate Lod Control Table (LodCntrl)
		--=========================================
		INSERT INTO dbo.LodCntrl (CntCoID,CntEEID,CntPendingEffDate,CntPendingImportType,CntPendingSource,CntPendingStatus,CntPendingUpdateID,CntSessionID)
		SELECT
			CntCoID = drvCOID
			,CntEEID = drvEEID
			,CntPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
			,CntPendingImportType = 'P'
			,CntPendingSource = 'C'
			,CntPendingStatus = 'A'
			,CntPendingUpdateID = drvPendingUpdateID
			,CntSessionID = '@CustomFormatCode'
		FROM dbo.U_@CustomFormatCode_drvTbl WITH (NOLOCK)
		WHERE drvImported = 0;

		--==============================================
		-- Populate Lod Employee Comp Table (LodEComp)
		--==============================================
		INSERT INTO dbo.LodEComp (EecEEID,EecCOID,EecEmpNo,EecCompanyCode,EecPendingEffDate,EecPendingTransType,EecPendingUpdateID,EecSessionID)
		SELECT
			EecEEID = drvEEID
			,EecCOID = drvCOID
			,EecEmpNo = EecEmpNo
			,EecCompanyCode = CmpCompanyCode
			,EecPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
			,EecPendingTransType = 'U'
			,EecPendingUpdateID = drvPendingUpdateID
			,EecSessionID = '@CustomFormatCode'
		FROM dbo.U_@CustomFormatCode_drvTbl WITH (NOLOCK)
		JOIN dbo.EmpComp WITH (NOLOCK)
			ON EecEEID = drvEEID
			AND EecCOID = drvCOID
		JOIN dbo.Company WITH (NOLOCK)
			ON CmpCOID = drvCOID
		WHERE drvImported = 0;

		--======================================================
		-- Populate Lod Deduction Table (LodEDed) - Deferrals
		--======================================================
		INSERT INTO dbo.LodEDed (EedEEID,EedCOID,EedDedCode,EedEECalcRateOrPct,EedBenStartDate,EedStartDate,EedBenStatusDate,EedBenStopDate
			,EedStopDate,EedPendingEffDate,EedPendingTransType,EedChangeReason,EedBenStatus,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
		SELECT EedEEID = drvEEID
			,EedCOID = drvCOID
			,EedDedCode = drvDedCode
			,EedEECalcRateOrPct = CASE -- Only Populate for Employee (EE) Non-Flat Amount Calc Rule ('20')
			                           WHEN DedEECalcRule <> '20' THEN
									       CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
												WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(MONEY,drvDeferralChangeNewPercentage)
											END
								  END
			,EedBenStartDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
									WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
									ELSE '12/30/1899'
							   END
			,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
								 ELSE '12/30/1899'
							END
			,EedBenStatusDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
									 WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
									 ELSE '12/30/1899'
								END
			,EedBenStopDate = CASE 	WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
									WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
									ELSE '01/01/1900'
							  END
			,EedStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
								ELSE '01/01/1900'
						   END
			,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
			,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
										ELSE 'U'
								   END
			,EedChangeReason = CASE WHEN drvAction = 'STOP' THEN '401'
									WHEN drvAction = 'ADD' THEN '400'
									WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
								END
			,EedBenStatus = CASE WHEN drvAction = 'STOP' THEN 'T' ELSE 'A' END
			,EedInclInAddlChk = DedInclInAddlChk
			,EedInclInManlChk = DedInclInManlChk
			,EedPendingUpdateID = drvPendingUpdateID
		FROM dbo.U_@CustomFormatCode_drvTbl WITH (NOLOCK)
		JOIN dbo.DedCode WITH (NOLOCK)
			ON DedDedCode = drvDedCode
		WHERE drvImported = 0 AND drvImportType = 'DEFERRAL';

		--======================================================
		-- Populate Lod Deduction Table (LodEDed) - Loans
		--======================================================
		INSERT INTO dbo.LodEDed (EedEEID,EedCOID,EedDedCode,EedEEAmt,EedEEMemberOrCaseNo,EedEEGTDAmt,EedStartDate,EedStopDate,EedPendingEffDate,EedPendingTransType
			,EedChangeReason,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
		SELECT EedEEID = drvEEID
			,EedCOID = drvCOID
			,EedDedCode = drvDedCode
			,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
			                 WHEN DedEECalcRule = '20' THEN
								CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
									 WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvLoanPaymentAmount
								END
						END
			,EedEEMemberOrCaseNo = drvLoanID
			,EedEEGTDAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
			                    WHEN DedEEGoalRule <> 'Z' THEN
			                        CASE WHEN drvAction = 'RESTART' THEN CONVERT(MONEY,0.00) END
                           END
			,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
								 ELSE '12/30/1899'
							END
			,EedStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
								ELSE '01/01/1900'
						   END
			,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
			,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
										ELSE 'U'
								   END
			,EedChangeReason = CASE WHEN drvAction = 'STOP' THEN '401'
									WHEN drvAction = 'ADD' THEN '400'
									WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
								END
			,EedInclInAddlChk = DedInclInAddlChk
			,EedInclInManlChk = DedInclInManlChk
			,EedPendingUpdateID = drvPendingUpdateID
		FROM dbo.U_@CustomFormatCode_drvTbl WITH (NOLOCK)
		JOIN dbo.DedCode WITH (NOLOCK)
			ON DedDedCode = drvDedCode
		WHERE drvImported = 0 AND drvImportType = 'LOAN';
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvError)
       SELECT 'Error Loading Records for Validation/Posting: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --============================================================
    -- Generate XML File for Standard Web Import for Automation
    --============================================================
    IF (@EnableStandardWebImport = 'Y')
    BEGIN TRY
        --------------------------------------------
        -- Populate BIM Lod Deduction Table for Web
        --------------------------------------------
        DELETE FROM dbo.U_dsi_BIM_LodEDed WHERE EedFormatCode = @FormatCode;

		--=========================================================
		-- Populate Lod Deduction Table (BIM LodEDed) - Deferrals
		--=========================================================
		INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEECalcRateOrPct,EedBenStartDate,EedStartDate,EedBenStatusDate,EedBenStopDate
			,EedStopDate,EedPendingEffDate,EedPendingTransType,EedChangeReason,EedBenStatus,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
		SELECT EedFormatCode = @FormatCode
			,EedEEID = drvEEID
			,EedCOID = drvCOID
			,EedDedCode = drvDedCode
			,EedEECalcRateOrPct = CASE -- Only Populate for Employee (EE) Non-Flat Amount Calc Rule ('20')
			                           WHEN DedEECalcRule <> '20' THEN
									       CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
												WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(MONEY,drvDeferralChangeNewPercentage)
											END
								  END
			,EedBenStartDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
									WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
									ELSE '12/30/1899'
							   END
			,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
								 ELSE '12/30/1899'
							END
			,EedBenStatusDate = CASE WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
									 WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
									 ELSE '12/30/1899'
								END
			,EedBenStopDate = CASE 	WHEN ISNULL(DedIsBenefit,'N') = 'N' THEN '01/01/1900'
									WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
									ELSE '01/01/1900'
							  END
			,EedStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
								ELSE '01/01/1900'
						   END
			,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
			,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
										ELSE 'U'
								   END
			,EedChangeReason = CASE WHEN drvAction = 'STOP' THEN '401'
									WHEN drvAction = 'ADD' THEN '400'
									WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
								END
			,EedBenStatus = CASE WHEN drvAction = 'STOP' THEN 'T' ELSE 'A' END
			,EedInclInAddlChk = DedInclInAddlChk
			,EedInclInManlChk = DedInclInManlChk
			,EedPendingUpdateID = drvPendingUpdateID
		FROM dbo.U_@CustomFormatCode_drvTbl WITH (NOLOCK)
		JOIN dbo.DedCode WITH (NOLOCK)
			ON DedDedCode = drvDedCode
		WHERE drvImported = 0 AND drvImportType = 'DEFERRAL';

		--======================================================
		-- Populate Lod Deduction Table (BIM LodEDed) - Loans
		--======================================================
		INSERT INTO dbo.U_dsi_BIM_LodEDed (EedFormatCode,EedEEID,EedCOID,EedDedCode,EedEEAmt,EedEEMemberOrCaseNo,EedEEGTDAmt,EedStartDate,EedStopDate,EedPendingEffDate,EedPendingTransType
			,EedChangeReason,EedInclInAddlChk,EedInclInManlChk,EedPendingUpdateID)
		SELECT EedFormatCode = @FormatCode
			,EedEEID = drvEEID
			,EedCOID = drvCOID
			,EedDedCode = drvDedCode
			,EedEEAmt = CASE -- Only Populate for Employee (EE) Flat Amount Calc Rule ('20')
			                 WHEN DedEECalcRule = '20' THEN
								CASE WHEN drvAction = 'STOP' THEN CONVERT(MONEY,0.00)
									 WHEN drvAction IN ('ADD','CHANGE','RESTART') THEN drvLoanPaymentAmount
								END
						END
			,EedEEMemberOrCaseNo = drvLoanID
			,EedEEGTDAmt = CASE -- Only Populate if Deduction Goal Rule is Setup ('Z' = <No goal>)
			                    WHEN DedEEGoalRule <> 'Z' THEN
			                        CASE WHEN drvAction = 'RESTART' THEN CONVERT(MONEY,0.00) END
                           END
			,EedStartDate = CASE WHEN drvAction IN ('ADD','RESTART') THEN CONVERT(CHAR(10),drvPeriodStartDate,101)
								 ELSE '12/30/1899'
							END
			,EedStopDate = CASE WHEN drvAction = 'STOP' THEN CONVERT(CHAR(10),DATEADD(DAY,-1,drvPeriodStartDate),101)
								ELSE '01/01/1900'
						   END
			,EedPendingEffDate = CONVERT(CHAR(10),GETDATE(),101)
			,EedPendingTransType = CASE WHEN drvAction = 'ADD' THEN 'A'
										ELSE 'U'
								   END
			,EedChangeReason = CASE WHEN drvAction = 'STOP' THEN '401'
									WHEN drvAction = 'ADD' THEN '400'
									WHEN drvAction IN ('CHANGE','RESTART') THEN '402'
								END
			,EedInclInAddlChk = DedInclInAddlChk
			,EedInclInManlChk = DedInclInManlChk
			,EedPendingUpdateID = drvPendingUpdateID
		FROM dbo.U_@CustomFormatCode_drvTbl WITH (NOLOCK)
		JOIN dbo.DedCode WITH (NOLOCK)
			ON DedDedCode = drvDedCode
		WHERE drvImported = 0 AND drvImportType = 'LOAN';

        ------------------------------------------------------------------------
        -- Generate XML File for Standard Web Import to Validate/Post Records
        ------------------------------------------------------------------------
        DECLARE @XMLFilePath VARCHAR(1000) = '' --dbo.Dsi_fnVariable(@FormatCode,'XMLPath')
               ,@XMLArchiveFilePath VARCHAR(1000) = dbo.Dsi_fnVariable(@FormatCode,'ArchivePath');

        EXEC dbo.dsi_BIM_sp_GenerateXML @FormatCode, 'Deductions', @XMLFilePath, @XMLArchiveFilePath;
    END TRY
    BEGIN CATCH
       -- Report SQL Error in Error Report File
       INSERT INTO dbo.U_@CustomFormatCode_drvTbl (drvError)
       SELECT 'Error Generating XML File for Standard Web Import: ' + ISNULL(ERROR_MESSAGE(),'');

       -- Stop Processing
       RETURN;
    END CATCH;

    --==========================
    -- Report Successful Update
    --==========================
    UPDATE dbo.U_@CustomFormatCode_drvTbl
        SET drvError = 'Loaded Successfully'
            ,drvImported = 1
    WHERE drvImported = 0
    AND ((@EnableStandardWebImport = 'Y' AND EXISTS (SELECT * FROM dbo.U_dsi_BIM_LodEDed WHERE EedPendingUpdateID = drvPendingUpdateID))
		OR (@EnableStandardWebImport = 'N' AND EXISTS (SELECT * FROM dbo.LodEDed WHERE EedPendingUpdateID = drvPendingUpdateID))
	);

    --==========================
    -- Reject Remaining Records
    --==========================
    UPDATE dbo.U_@CustomFormatCode_drvTbl
        SET drvError = 'Record Rejected'
            ,drvAction = 'REJECTED'
            ,drvImported = 2
    WHERE drvImported = 0;

END
/******************************************************************

--Create the View
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID IN (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = '@CustomFormatCode')
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201806011'
       ,ExpStartPerControl     = '201806011'
       ,ExpLastEndPerControl   = '201806019'
       ,ExpEndPerControl       = '201806019'
WHERE ExpFormatCode = '@CustomFormatCode';

******************************************************************/
GO
--Create the View
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;
GO