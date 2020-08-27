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
@CustomFormatCode - Replace with Format Code (i.e., EXMLSUNBEN)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., SunLife Demographic Benefits XML Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Sunlife\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\Sunlife\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

--Data Parameters
@DedCodeList - Replace with the Deduction Code List (Ex:'MED','DEN','VIS')
@PolicyNumber - Replace with the Deduction Code List (Ex:'100000')
@ClientName - Replace with the Deduction Code List (Ex:'Client Name, LLC')
@FamilyBenOption - Replace with the Deduction Code List (Ex:'FAM')
@EEOnlyBenOption - Replace with the Deduction Code List (Ex:'EE')
@SpouseRelationshipCodes - Replace with the Deduction Code List (Ex:'SPS','DP')
@ChildRelationshipCodes - Replace with the Deduction Code List (Ex:'CHL','STC')

*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_fn_@CustomFormatCode_GetBeneficiaries') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_@CustomFormatCode_GetBeneficiaries];
GO
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList_Detail') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList_Detail];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_XMLVersion') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_XMLVersion];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Salary') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Salary];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Provinces') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Provinces];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_PersonLink') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_PersonLink];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Person') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Person];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_MemberClose') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_MemberClose];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_LoaderOpen') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_LoaderOpen];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_LoaderClose') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_LoaderClose];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Benefits') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Benefits];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_BeneficiaryList') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_BeneficiaryList];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Audit];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Address') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Address];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_SwitchBox_v2','2500','S','N',@AdhSystemID,'N',NULL,'C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvXMLVersion"','1','(''UA''=''T'')',@AdhSystemID,'100','D','10','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvLoaderOpen"','1','(''UA''=''T'')',@AdhSystemID,'100','D','20','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPolicyNum"','2','(''UA''=''T'')',@AdhSystemID,'100','D','20','101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvClientName"','3','(''UA''=''T'')',@AdhSystemID,'100','D','20','201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvReportLanguageCD"','4','(''UA''=''T'')',@AdhSystemID,'100','D','20','301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvLoaderClose"','5','(''UA''=''T'')',@AdhSystemID,'100','D','20','401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvMemberOpen"','1','(''UA''=''T'')',@AdhSystemID,'100','D','30','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPolicyNum"','2','(''UA''=''T'')',@AdhSystemID,'100','D','30','101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvLocationNum"','3','(''UA''=''T'')',@AdhSystemID,'100','D','30','201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvClassNum"','4','(''UA''=''T'')',@AdhSystemID,'100','D','30','301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPlanNum"','5','(''UA''=''T'')',@AdhSystemID,'100','D','30','401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCertificateNum"','6','(''UA''=''T'')',@AdhSystemID,'100','D','30','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPayrollNum"','7','(''UA''=''T'')',@AdhSystemID,'100','D','30','601','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEmploymentDt"','8','(''UA''=''T'')',@AdhSystemID,'100','D','30','701','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvWorkResidenceCd"','9','(''UA''=''T'')',@AdhSystemID,'100','D','30','801','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBeneficiary"','10','(''UA''=''T'')',@AdhSystemID,'265','D','30','901','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAltBillSort5"','11','(''UA''=''T'')',@AdhSystemID,'100','D','30','1001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAltBillSort6"','12','(''UA''=''T'')',@AdhSystemID,'100','D','30','1101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvStatusCd"','13','(''UA''=''T'')',@AdhSystemID,'100','D','30','1201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTermDt"','14','(''UA''=''T'')',@AdhSystemID,'100','D','30','1301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTermReasonCd"','15','(''UA''=''T'')',@AdhSystemID,'100','D','30','1401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvUpdateFlag"','16','(''UA''=''T'')',@AdhSystemID,'100','D','30','1501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvApplyDate"','17','(''UA''=''T'')',@AdhSystemID,'100','D','30','1601','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTransferFlg"','18','(''UA''=''T'')',@AdhSystemID,'100','D','30','1701','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvReinstatementFlg"','19','(''UA''=''T'')',@AdhSystemID,'100','D','30','1801','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvMemberClose"','20','(''UA''=''T'')',@AdhSystemID,'100','D','30','1901','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPersonOpen"','1','(''UA''=''T'')',@AdhSystemID,'100','D','40','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvFirstNm"','2','(''UA''=''T'')',@AdhSystemID,'100','D','40','101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvMiddleInitialNm"','3','(''UA''=''T'')',@AdhSystemID,'100','D','40','201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvLastNm"','4','(''UA''=''T'')',@AdhSystemID,'100','D','40','301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBirthDt"','5','(''UA''=''T'')',@AdhSystemID,'100','D','40','401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvResidenceCd"','6','(''UA''=''T'')',@AdhSystemID,'100','D','40','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvGenderCd"','7','(''UA''=''T'')',@AdhSystemID,'100','D','40','601','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvDepTypeCd"','8','(''UA''=''T'')',@AdhSystemID,'100','D','40','701','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvLanguageCd"','9','(''UA''=''T'')',@AdhSystemID,'100','D','40','801','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPersonClose"','10','(''UA''=''T'')',@AdhSystemID,'100','D','40','901','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSalaryOpen"','1','(''UA''=''T'')',@AdhSystemID,'100','D','50','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSalaryDescCd"','2','(''UA''=''T'')',@AdhSystemID,'100','D','50','101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSalaryBasisCd"','3','(''UA''=''T'')',@AdhSystemID,'100','D','50','201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSalaryAmt"','4','(''UA''=''T'')',@AdhSystemID,'100','D','50','301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvHoursPerWeekAmt"','5','(''UA''=''T'')',@AdhSystemID,'100','D','50','401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvStatusCd"','6','(''UA''=''T'')',@AdhSystemID,'100','D','50','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSalaryClose"','7','(''UA''=''T'')',@AdhSystemID,'100','D','50','601','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressOpen"','1','(''UA''=''T'')',@AdhSystemID,'100','D','60','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressTypeCd"','2','(''UA''=''T'')',@AdhSystemID,'100','D','60','101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressNm"','3','(''UA''=''T'')',@AdhSystemID,'100','D','60','201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvStreetAddressNm"','4','(''UA''=''T'')',@AdhSystemID,'100','D','60','301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvSuiteNm"','5','(''UA''=''T'')',@AdhSystemID,'100','D','60','401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCityNm"','6','(''UA''=''T'')',@AdhSystemID,'100','D','60','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvStateOrProvCd"','7','(''UA''=''T'')',@AdhSystemID,'100','D','60','601','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPostalNum"','8','(''UA''=''T'')',@AdhSystemID,'100','D','60','701','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvCountryCd"','9','(''UA''=''T'')',@AdhSystemID,'100','D','60','801','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvStatusCd"','10','(''UA''=''T'')',@AdhSystemID,'100','D','60','901','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvAddressClose"','11','(''UA''=''T'')',@AdhSystemID,'100','D','60','1001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPersonLinkOpen"','1','(''UA''=''T'')',@AdhSystemID,'100','D','70','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPersonLinkTypeCd"','2','(''UA''=''T'')',@AdhSystemID,'100','D','70','101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvFirstNm"','3','(''UA''=''T'')',@AdhSystemID,'100','D','70','201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvLastNm"','4','(''UA''=''T'')',@AdhSystemID,'100','D','70','301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBirthDt"','5','(''UA''=''T'')',@AdhSystemID,'100','D','70','401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvGenderCd"','6','(''UA''=''T'')',@AdhSystemID,'100','D','70','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvInSchoolFlg"','7','(''UA''=''T'')',@AdhSystemID,'100','D','70','601','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEffectiveDt"','8','(''UA''=''T'')',@AdhSystemID,'100','D','70','701','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTermDt"','9','(''UA''=''T'')',@AdhSystemID,'100','D','70','801','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTermReasonCd"','10','(''UA''=''T'')',@AdhSystemID,'100','D','70','901','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvStatusCd"','11','(''UA''=''T'')',@AdhSystemID,'100','D','70','1001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvPersonLinkClose"','12','(''UA''=''T'')',@AdhSystemID,'100','D','70','1101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBenefitsOpen"','1','(''UA''=''T'')',@AdhSystemID,'100','D','80','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBenefitType"','2','(''UA''=''T'')',@AdhSystemID,'100','D','80','101','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvFlexCodeNm"','3','(''UA''=''T'')',@AdhSystemID,'100','D','80','201','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvDepTypeCd"','4','(''UA''=''T'')',@AdhSystemID,'100','D','80','301','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvEffectiveDt"','5','(''UA''=''T'')',@AdhSystemID,'100','D','80','401','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvRequestedAmt"','6','(''UA''=''T'')',@AdhSystemID,'100','D','80','501','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvRequestedUnitsAmt"','7','(''UA''=''T'')',@AdhSystemID,'100','D','80','601','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvStatusCd"','8','(''UA''=''T'')',@AdhSystemID,'100','D','80','701','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTermDt"','9','(''UA''=''T'')',@AdhSystemID,'100','D','80','801','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvTermReasonCd"','10','(''UA''=''T'')',@AdhSystemID,'100','D','80','901','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvBenefitsClose"','11','(''UA''=''T'')',@AdhSystemID,'100','D','80','1001','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvMemberClose"','1','(''UA''=''T'')',@AdhSystemID,'100','D','90','1','','',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DrvLoaderClose"','1','(''UA''=''T'')',@AdhSystemID,'100','D','95','101','','',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'On Demand Export',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ON_DEMAND','Oct  1 2018 12:00AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Automated Scheduled Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','SCHEDULED','Oct  1 2018  2:00PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Testing Purposes Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST','Oct  1 2018  3:42PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','DrvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','DrvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_Dsi_DrvTbl_@CustomFormatCode_XMLVersion',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderOpen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_Dsi_DrvTbl_@CustomFormatCode_Person',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_Dsi_DrvTbl_@CustomFormatCode_Salary',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D60','dbo.U_Dsi_DrvTbl_@CustomFormatCode_Address',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D70','dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D80','dbo.U_Dsi_DrvTbl_@CustomFormatCode_Benefits',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D90','dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberClose',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D95','dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderClose',NULL);
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
    [Data] varchar(2069) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID VARCHAR(15) = NULL
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
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ON_DEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'N'
**********************************************************************************/
BEGIN

    -----------
    -- Declare variables
    -----------
    DECLARE @FormatCode VARCHAR(10) = '@CustomFormatCode';
    DECLARE @ExportCode CHAR(10);
    DECLARE @StartDateTime DATETIME;
    DECLARE @EndDateTime DATETIME;
    DECLARE @StartPerControl CHAR(9);
    DECLARE @EndPerControl CHAR(9);
    DECLARE @TestingFlag CHAR(1);

    -----------
    -- Set start and end dates
    -----------
    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDateTime   = LEFT(StartPerControl,8)
        ,@EndDateTime     = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@TestingFlag     = dbo.dsi_fnVariable(FormatCode, 'Testing')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    -- Scheduled Run
    IF @ExportCode = 'SCHEDULED'
    BEGIN
        SET @EndDateTime = GETDATE();
        SET @StartDateTime = DATEADD(DD, - 7, @EndDateTime);
        SET @StartPerControl = CONVERT(VARCHAR(8), @StartDateTime, 112) + '1';
        SET @EndPerControl = CONVERT(VARCHAR(8), @EndDateTime, 112) + '9';
    END;

    -----------
    -- Drop tables
    -----------
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit;
    IF OBJECT_ID('dbo.U_@CustomFormatCode_EEList_Detail') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_EEList_Detail;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_Address') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Address;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_Benefits') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Benefits;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderClose') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderClose;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderOpen') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderOpen;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberClose') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberClose;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_Person') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Person;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_Salary') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Salary;
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_XMLVersion') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_XMLVersion;

    -----------
    -- For testing only
    -----------
    --DELETE FROM dbo.U_@CustomFormatCode_EEList WHERE xEEID NOT IN ('BA8UWS0000K0','C22OQR0000K0','C6T69Y0000K0');

    -----------
    -- Clean up EE List
    -----------
    DELETE A
    FROM dbo.U_@CustomFormatCode_EEList A
    WHERE A.xCOID <> dbo.dsi_fn_GetCurrentCOID(A.xEEID)
    AND EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_EEList B WHERE A.xEEID = B.xEEID AND A.xCOID <> B.xCOID AND B.xCOID = dbo.dsi_fn_GetCurrentCOID(B.xEEID));

    -----------
    -- Benefits Deduction Module
    -----------
    -- Identify New Enrollees
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes','CNDEN,CNDLF,CNELF,CNOLD,CNHSA,CNHTI');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption','StopDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'NewEnrolleeType','2');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'ExclFutureDatedStartDates','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'ExclFutureDatedStopDates','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RunID','NEW');

    EXECUTE dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    -- Identify Terms
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes','CNDEN,CNDLF,CNELF,CNOLD,CNHSA,CNHTI');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption','StopDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'ExclFutureDatedStartDates','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'ExclFutureDatedStopDates','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'AddToPreviousRun','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RunID','TERM');

    EXECUTE dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    -----------
    -- Gather audit data for employees
    -----------
    CREATE TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Audit] (
        [AudKey1Value] [VARCHAR](255) NULL
        ,[AudKey2Value] [VARCHAR](255) NULL
        ,[AudKey3Value] [VARCHAR](255) NULL
        ,[AudTableName] [VARCHAR](128) NULL
        ,[AudFieldName] [VARCHAR](128) NULL
        ,[AudOldValue] [VARCHAR](256) NULL
        ,[AudNewValue] [VARCHAR](256) NULL
        ,[AudDateTime] [DATETIME] NULL
    ) ON [PRIMARY];

    INSERT INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
    SELECT DISTINCT AudKey1Value
        ,AudKey2Value
        ,AudKey3Value
        ,AudTableName
        ,AudFieldName
        ,AudOldValue
        ,AudNewValue
        ,AudDateTime
    FROM dbo.vw_AuditEEdata
    WHERE ((AudTableName = 'EmpPers' AND AudFieldName IN ('EepAddressCity','EepAddressCountry','EepAddressLine1','EepAddressLine2','EepAddressState','EepAddressStateCode','EepAddressZipCode','EepDateOfBirth','EepGender','EepNameFirst','EepNameLast'))
        OR (AudTableName = 'EmpComp' AND AudFieldName IN ('EecAnnSalary','EecDateOfLastHire','EecDateOfTermination','EecEmplStatus','EecSITWorkInStateCode','EecTermReason','EecLanguageCode','EecLocation','EecEEType'))
        OR (AudTableName = 'EmpDed' AND AudFieldName IN ('EedDedCode','EedBenOption','EedBenStartDate','EedBenStopDate') AND audKey3Value IN (@DedCodeList))
        OR (AudTableName = 'DepBPlan' AND AudFieldName IN ('DbnBenStopDate','DbnBenStartDate','DbnDedCode') AND audKey2Value IN (@DedCodeList))
        OR (AudTableName = 'Contacts' AND AudFieldName IN ('ConDateOfBirth','ConGender','ConIsStudent','ConNameFirst','ConNameLast','ConRelationship'))
        OR (AudTableName = 'EmpPers' AND AudFieldName = 'EepNameMiddle' AND LEFT(AudOldValue, 1) <> LEFT(AudNewValue, 1))
        OR (AudTableName = 'Contacts' AND AudFieldName = 'ConNameMiddle' AND LEFT(AudOldValue, 1) <> LEFT(AudNewValue, 1))
    )
    AND AudDateTime BETWEEN @StartDateTime AND @EndDateTime;

    -- Delete future dated records
    DELETE FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
    WHERE AudFieldName LIKE '%Date%'
    AND AudFieldName NOT LIKE '%Birth%'
    AND ISNULL(AudNewValue, '') <> ''
    AND DATEDIFF(DD, @EndDateTime, CAST(AudNewValue AS DATETIME)) > 0;

    -- Delete location changes that do not result in a state/province change
    DELETE A
    FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit A
    INNER JOIN dbo.Location OldLoc WITH (NOLOCK)
        ON AudOldValue = OldLoc.LocCode
    INNER JOIN dbo.Location NewLoc WITH (NOLOCK)
        ON AudNewValue = NewLoc.LocCode
    WHERE ISNULL(OldLoc.LocAddressState, '') = ISNULL(NewLoc.LocAddressState, '');

    --BDM UPDATE - include deds stopped before @StartDate according to Audit
    UPDATE dbo.U_dsi_BDM_EmpDeductions
    SET EedValidForExport = 'Y'
        ,EedDedRowStatus = RTRIM(EedDedRowStatus) + '-MANUALLY CHANGED'
    FROM dbo.U_dsi_BDM_EmpDeductions
    INNER JOIN dbo.EmpComp
        ON EecEEID = EedEEID
        AND EecCoID = EedCOID
        AND ISNULL(eectermreason, '') NOT IN ('TRO')
    INNER JOIN dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
        ON AudKey1Value = EedEEID
        AND AudKey2Value = EedCoID
        AND AudFieldName = ('EedBenStopDate')
        AND AudKey3Value = EedDedCode
    WHERE eedformatcode = @formatcode
    AND EedRunID = 'TERM'
    AND EedValidForExport = 'N'
    AND EedBenStopDate < @StartDateTime
    AND EedBenStartDate <> EedBenStopDate
    AND AudNewValue = EedBenStopDate;

    UPDATE dbo.U_dsi_BDM_DepDeductions
    SET DbnValidForExport = 'Y'
        ,DbnDedRowStatus = RTRIM(DbnDedRowStatus) + '-MANUALLY CHANGED'
    FROM dbo.U_dsi_BDM_DepDeductions
    INNER JOIN dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
        ON AudKey1Value = DbnEEID
        AND AudKey2Value = DbnDedCode
        AND AudKey3Value = DbnSystemID
        AND AudFieldName = ('DbnBenStopDate')
    WHERE Dbnformatcode = '@CustomFormatCode'
    AND DbnRunID = 'TERM'
    AND DbnValidForExport = 'N'
    AND DbnBenStopDate < @StartDateTime
    AND DbnBenStartDate <> DbnBenStopDate
    AND AudNewValue = DbnBenStopDate;

    EXECUTE dbo.dsi_bdm_sp_BuildConsolidatedTable '@CustomFormatCode','Standard';

    ALTER TABLE dbo.U_dsi_bdm_@CustomFormatCode
    ALTER COLUMN BdmUSGField1 MONEY;

    -- Add Benefit Amount to user defined field in consolidated table
    UPDATE dbo.U_dsi_bdm_@CustomFormatCode
    SET BdmUSGField1 = EedBenAmt
    FROM dbo.EmpDed
    WHERE EedEEID = BdmEEID
    AND EedCoID = BdmCOID
    AND BdmRecType = 'EMP'
    AND EedDedCode = BdmDedCode
    AND EedBenStatus = BdmBenStatus
    AND EedBenStartDate = BdmBenStartDate
    AND EedBenStopDate = BdmBenStopDate;

    UPDATE dbo.U_dsi_bdm_@CustomFormatCode
    SET BdmUSGField1 = DbnBenAmt
    FROM dbo.DepBPlan
    WHERE DbnEEID = BdmEEID
    AND DbnCoID = BdmCOID
    AND DbnDepRecID = BdmDepRecID
    AND BdmRecType = 'DEP'
    AND DbnDedCode = BdmDedCode
    AND DbnBenStatus = BdmBenStatus
    AND DbnBenStartDate = BdmBenStartDate
    AND DbnBenStopDate = BdmBenStopDate;

    -----------------------
    -- Identify Employee Changes
    -----------------------
    SELECT DISTINCT DetEEID = xEEID
        ,DetCOID = xCOID
        ,DetUDField01 = EecUDField01
        ,DetNewHire = SPACE(1)
        ,DetHireDate = CONVERT(VARCHAR(10), EecDateOfOriginalHire, 120)
        ,DetRehire = SPACE(1)
        ,DetRehireDate = CONVERT(VARCHAR(10), EecDateOfLastHire, 120)
        ,DetTerm = SPACE(1)
        ,DetTermDate = CONVERT(VARCHAR(10), EecDateOfTermination, 120)
        ,DetBenNew = SPACE(1)
        ,DetBenTerm = SPACE(1)
        ,DetLocChange = SPACE(1)
        ,DetMember = SPACE(1)
        ,DetPerson = SPACE(1)
        ,DetSalary = SPACE(1)
        ,DetSalaryDate = SPACE(10)
        ,DetAddress = SPACE(1)
        ,DetPersonLink = SPACE(1)
        ,DetBenefits = SPACE(1)
    INTO dbo.U_@CustomFormatCode_EEList_Detail
    FROM dbo.U_@CustomFormatCode_EEList
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCOID
    INNER JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCOID
    INNER JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID;

    -- Identify New Hires
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetNewHire = 'Y'
        ,DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetSalary = 'Y'
        ,DetAddress = 'Y'
        ,DetPersonLink = 'Y'
        ,DetBenefits = 'Y'
    WHERE ISNULL(DetUDField01, '') <> ''
    AND (DetHireDate BETWEEN @StartDateTime AND @EndDateTime
        OR (DetHireDate < @StartDateTime
            AND EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID AND AudFieldName = 'EecEmplStatus' AND ISNULL(AudOldValue, '') = '' AND AudNewValue = 'A')
        )
    );

    -- Identify Rehires
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetRehire = 'Y'
        ,DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetSalary = 'Y'
        ,DetAddress = 'Y'
        ,DetPersonLink = 'Y'
        ,DetBenefits = 'Y'
    WHERE DetRehireDate <> DetHireDate
    AND ISNULL(DetUDField01, '') <> ''
    AND (DetRehireDate BETWEEN @StartDateTime AND @EndDateTime
        OR (DetRehireDate < @StartDateTime
            AND EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID AND AudFieldName = 'EecEmplStatus' AND AudOldValue = 'T' AND AudNewValue = 'A')
        )
    );

    -- Identify Terms
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetTerm = 'Y'
        ,DetMember = 'Y'
        ,DetPerson = 'Y'
    WHERE ISNULL(DetUDField01, '') <> ''
    AND (DetTermDate BETWEEN @StartDateTime AND @EndDateTime
        OR (DetTermDate < @StartDateTime
            AND EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID AND AudFieldName = 'EecEmplStatus' AND AudOldValue <> 'T' AND AudNewValue = 'T')
        )
    );

    -- Identify Newly Enrolled all benefits
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetBenNew = 'Y'
        ,DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetBenefits = 'N'
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmEEID = DetEEID AND BdmCOID = DetCOID AND BdmBenStartDate BETWEEN @StartDateTime AND @EndDateTime)
    AND NOT EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmEEID = DetEEID AND BdmCOID = DetCOID AND BdmBenStartDate IS NULL);

    -- Identify Terming all benefits
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetBenTerm = 'Y'
        ,DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetBenefits = 'N'
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmEEID = DetEEID AND BdmCOID = DetCOID AND BdmBenStopDate IS NOT NULL)
    AND NOT EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmEEID = DetEEID AND BdmCOID = DetCOID AND BdmBenStopDate IS NULL);

    -- Identify changes for Member/Person record
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetMember = 'Y'
        ,DetPerson = 'Y'
    WHERE EXISTS (
        SELECT 1
        FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
        WHERE AudKey1Value = DetEEID
        AND (AudTableName = 'EmpPers'
            OR AudKey2Value = DetCOID
        )
        AND AudFieldName IN ('EecEmplStatus','EecDateOfLastHire','EecDateOfTermination','EepNameFirst','EepNameMiddle','EepNameLast','EepDateOfBirth'
            ,'EepGender','EecSITWorkInStateCode','EepAddressStateCode','EecTermReason','EecLanguageCode','EecLocation','EecEEType')
    );

    -- Identify location changes
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetLocChange = 'Y'
        ,DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetBenefits = 'Y'
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode B WHERE DetEEID = B.BdmEEID AND DetCOID = B.BdmCOID AND B.BdmRecType = 'EMP' AND B.BdmBenStatus = 'T' AND B.BdmDedCode IN (@DedCodeList))
    AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode C WHERE DetEEID = C.BdmEEID AND DetCOID = C.BdmCOID AND C.BdmRecType = 'EMP' AND C.BdmBenStatus = 'A' AND C.BdmDedCode IN (@DedCodeList) AND C.BdmBenStartDate BETWEEN @StartDateTime AND @EndDateTime);

    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetLocChange = 'Y'
        ,DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetBenefits = 'Y'
    WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode B WHERE DetEEID = B.BdmEEID AND DetCOID = B.BdmCOID AND B.BdmRecType = 'EMP' AND B.BdmBenStatus = 'T' AND B.BdmDedCode IN (@DedCodeList))
    AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode C WHERE DetEEID = C.BdmEEID AND DetCOID = C.BdmCOID AND C.BdmRecType = 'EMP' AND C.BdmBenStatus = 'A' AND C.BdmDedCode IN (@DedCodeList) AND C.BdmBenStartDate BETWEEN @StartDateTime AND @EndDateTime);

    -- Identify changes for Salary record
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetSalary = 'Y'
        ,DetSalaryDate = CONVERT(VARCHAR(10), @EndDateTime, 120)
    FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
    WHERE AudKey1Value = DetEEID
    AND AudKey2Value = DetCOID
    AND AudFieldName IN ('EecAnnSalary');

    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetSalary = 'Y'
        ,DetSalaryDate = CONVERT(VARCHAR(10), EjhJobEffDate, 120)
    FROM dbo.EmpHJob
    WHERE EjhEEID = DetEEID
    AND EjhCoID = DetCOID
    AND EjhIsRateChange = 'Y'
    AND (EjhJobEffDate BETWEEN @StartDateTime AND @EndDateTime
        OR (EjhJobEffDate < @StartDateTime
            AND EjhDateTimeCreated BETWEEN @StartDateTime AND @EndDateTime
        )
    );

    -- Identify changes for Address record
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetAddress = 'Y'
    WHERE EXISTS (
        SELECT 1
        FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
        WHERE AudKey1Value = DetEEID
        AND (AudTableName = 'EmpPers'
            OR AudKey2Value = DetCOID
        )
        AND AudFieldName IN ('EepAddressLine1','EepAddressLine2','EepAddressCity','EepAddressState','EepAddressCountry','EepAddressZipCode')
    );

    -- Identify changes for PersonLink record
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetPersonLink = 'Y'
    WHERE EXISTS (
        SELECT 1
        FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit
        WHERE AudKey1Value = DetEEID
        AND AudFieldName IN ('DbnDedCode','ConNameFirst','ConNameMiddle','ConNameLast','ConDateOfBirth','ConGender','ConRelationship','ConIsStudent')
    );

    -- Identify changes for Benefits record
    UPDATE dbo.U_@CustomFormatCode_EEList_Detail
    SET DetMember = 'Y'
        ,DetPerson = 'Y'
        ,DetBenefits = 'Y'
    WHERE EXISTS (SELECT 1 FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit WHERE AudKey1Value = DetEEID AND AudKey2Value = DetCOID AND AudFieldName IN ('EedBenStartDate','EedBenStopDate','EedBenOption'));

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_XMLVersion
    -----------------------
    SELECT DISTINCT DrvSort = '1'
        ,DrvSubSort = ''
        ,DrvXMLVersion = '<?xml version="1.0" ?>'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_XMLVersion;

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderOpen
    -----------------------
    SELECT DISTINCT DrvSort = '2'
        ,DrvSubSort = ''
        ,DrvLoaderOpen = '<Loader '
        ,DrvPolicyNum = ' PolicyNum="@PolicyNumber"'
        ,DrvClientName = ' ClientName="@ClientName"'
        ,DrvReportLanguageCD = ' ReportLanguageCd="1"'
        ,DrvLoaderClose = '>'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderOpen;

    -----------------------
    -- Find beneficiaries
    -----------------------
    IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries') IS NOT NULL
        DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries;

    CREATE TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries] (
        [BfyEEID] [VARCHAR](20) NULL
        ,[BfyCOID] [VARCHAR](5) NULL
        ,[BfyDepRecID] [VARCHAR](20) NULL
        ,[BfyName] [VARCHAR](255) NULL
        ,[BfyRel] [VARCHAR](50) NULL
        ,[BfyPct] [INT] NULL
        ,[BfyRecord] [VARCHAR](255) NULL
    ) ON [PRIMARY];

    INSERT INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries
    SELECT DISTINCT BfyEEID = DetEEID
        ,BfyCOID = DetCOID
        ,BfyDepRecID = ConSystemID
        ,BfyName = dbo.usi_fn_RemovePunctuation(RTRIM(ConNameFirst), '', '') + ' ' + dbo.usi_fn_RemovePunctuation(RTRIM(ConNameLast), '', '')
        ,BfyRel = dbo.usi_fn_RemovePunctuation(RTRIM(CodDesc), '', '')
        ,BfyPct = CAST(BfpPctToAlloc AS INT)
        ,BfyRecord = SPACE(255)
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    INNER JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = DetEEID
        AND ConIsBeneficiary = 'Y'
    INNER JOIN dbo.Codes WITH (NOLOCK)
        ON CodCode = ConRelationship
        AND CodTable = 'RELATION'
    INNER JOIN dbo.BnfBPlan WITH (NOLOCK)
        ON BfpEEID = DetEEID
        AND BfpConRecID = ConSystemID
        AND BfpDedCode IN (@DedCodeList)
        AND BfpStatus = 'A';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries
    SET BfyRecord = BfyName + ', ' + BfyRel + ' ' + dbo.usi_fn_RemovePunctuation(RTRIM(CONVERT(VARCHAR(3), BfyPct)), '', '') + '%';

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    -----------------------
    SELECT DISTINCT DrvSort = '3' + DetCOID + DetEEID
        ,DrvSubSort = '1'
        ,DrvCOID = DetCOID
        ,DrvEEID = DetEEID
        ,DrvMemberOpen = '<Member'
        ,DrvPolicyNum = ' PolicyNum="@PolicyNumber"'
        ,DrvLocationNum = ' LocationNum="' + SPACE(3) + '"'
        ,DrvClassNum = ' ClassNum="' + SPACE(1) + '"'
        ,DrvPlanNum = ' PlanNum="' + SPACE(1) + '"'
        ,DrvCertificateNum = ' CertificateNum="' + dbo.usi_fn_RemovePunctuation(RTRIM(EecUDField02), '', '') + '"'
        ,DrvPayrollNum = ' PayrollNum="' + dbo.usi_fn_RemovePunctuation(RTRIM(EecEmpNo), '', '') + '"'
        ,DrvEmploymentDt = ' EmploymentDt="' + CASE WHEN DetNewHire = 'Y' THEN CONVERT(VARCHAR(10), EecDateOfOriginalHire, 120) END + '"'
        ,DrvWorkResidenceCd = ' WorkResidenceCd="' + PrvCode + '"'
        ,DrvBeneficiary = ' Beneficiary="' + LEFT(dbo.usi_fn_RemovePunctuation(RTRIM(dbo.dsi_fn_@CustomFormatCode_GetBeneficiaries(DetEEID, DetCOID)), '', ''), 250) + '"'
        ,DrvAltBillSort5 = ' AltBillSort5="' + dbo.usi_fn_RemovePunctuation(RTRIM(EecOrgLvl4), '', '') + '"'
        ,DrvAltBillSort6 = ''
        ,DrvStatusCd = ' StatusCd="'
                        + CASE DetBenTerm
                               WHEN 'Y' THEN '3'
                               ELSE '1'
                        END + '"'
        ,DrvTermDt = ' TermDt="' + CASE DetBenTerm WHEN 'Y' THEN CONVERT(VARCHAR(10), EecDateOfTermination, 120) ELSE '' END + '"'
        ,DrvTermReasonCd = ' TermReasonCd="'
                            + CASE DetBenTerm
                                   WHEN 'Y' THEN
                                    CASE EecTermReason
                                         WHEN '203' THEN '6'
                                         ELSE '2'
                                    END
                            END + '"'
        ,DrvUpdateFlag = ' UpdateFlag="'
                        + CASE WHEN DetNewHire = 'Y' THEN 'False'
                               WHEN DetRehire = 'Y' THEN 'True'
                               WHEN DetBenNew = 'Y' THEN 'False'
                               ELSE 'True'
                        END + '"'
        ,DrvApplyDate = ' ApplyDate="'
                        + CASE WHEN DetNewHire = 'Y' THEN CONVERT(VARCHAR(10), EecDateOfOriginalHire, 120)
                               WHEN DetRehire = 'Y' THEN CONVERT(VARCHAR(10), EecDateOfLastHire, 120)
                               WHEN DetBenTerm = 'Y' THEN (SELECT CONVERT(VARCHAR(10), MAX(BdmBenStopDate), 120) FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmEEID = DetEEID AND BdmCOID = DetCOID AND BdmBenStopDate IS NOT NULL)
                               WHEN DetTerm = 'Y' THEN CONVERT(VARCHAR(10), EecDateOfTermination, 120)
                               WHEN DetSalary = 'Y' THEN CONVERT(VARCHAR(10), DetSalaryDate, 120)
                               ELSE CONVERT(VARCHAR(10), @EndDateTime, 120)
                        END + '"'
        ,DrvTransferFlg = ' TransferFlg="' + CASE DetLocChange WHEN 'Y' THEN 'True' END + '"'
        ,DrvReinstatementFlg = ' ReinstatementFlg="' + CASE DetRehire WHEN 'Y' THEN 'True' END + '"'
        ,DrvMemberClose = ' >'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = DetEEID
        AND EecCOID = DetCOID
    INNER JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation = LocCode
    LEFT JOIN dbo.U_Dsi_DrvTbl_@CustomFormatCode_Provinces WITH (NOLOCK)
        ON LEFT(LocAddressState, 2) = PrvAbbr
    WHERE DetMember = 'Y';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvLocationNum = ' LocationNum="001"'
        ,DrvClassNum = ' ClassNum="1"'
        ,DrvPlanNum = ' PlanNum="1"'
    FROM dbo.U_dsi_bdm_@CustomFormatCode
    WHERE BdmEEID = DrvEEID
    AND BdmCOID = DrvCOID
    AND BdmRecType = 'EMP'
    AND BdmDedCode IN (@DedCodeList)
    AND BdmBenStopDate IS NULL;

    --update for seasonal only where Employment Type is 'SEA':
    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvLocationNum = ' LocationNum="006"'
        ,DrvClassNum = ' ClassNum="6"'
        ,DrvPlanNum = ' PlanNum="6"'
    FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    INNER JOIN dbo.EmpComp
        ON EecEEID = DrvEEID
        AND EecCoID = drvcoid
    INNER JOIN dbo.U_dsi_bdm_@CustomFormatCode
        ON BdmEEID = DrvEEID
        AND BdmCOID = DrvCOID
        AND BdmRecType = 'EMP'
        AND BdmDedCode IN (@DedCodeList)
        AND BdmBenStopDate IS NULL
        AND EecEEType IN ('SEA');

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvLocationNum = ' LocationNum="002"'
        ,DrvClassNum = ' ClassNum="2"'
        ,DrvPlanNum = ' PlanNum="2"'
    FROM dbo.U_dsi_bdm_@CustomFormatCode
    WHERE BdmEEID = DrvEEID
    AND BdmCOID = DrvCOID
    AND BdmRecType = 'EMP'
    AND BdmDedCode IN (@DedCodeList)
    AND BdmBenStopDate IS NULL;

    --update for seasonal only where Employment Type is 'SEA':
    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvLocationNum = ' LocationNum="007"'
        ,DrvClassNum = ' ClassNum="7"'
        ,DrvPlanNum = ' PlanNum="7"'
    FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    INNER JOIN dbo.EmpComp
        ON EecEEID = DrvEEID
        AND EecCoID = drvcoid
    INNER JOIN dbo.U_dsi_bdm_@CustomFormatCode
        ON BdmEEID = DrvEEID
        AND BdmCOID = DrvCOID
        AND BdmRecType = 'EMP'
        AND BdmDedCode IN (@DedCodeList)
        AND BdmBenStopDate IS NULL
        AND EecEEType IN ('SEA');

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvLocationNum = NULL
    WHERE DrvLocationNum = ' LocationNum="   "';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvClassNum = NULL
    WHERE DrvClassNum = ' ClassNum=" "';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvPlanNum = NULL
    WHERE DrvPlanNum = ' PlanNum=" "';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvBeneficiary = NULL
    WHERE DrvBeneficiary = ' Beneficiary=""';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberOpen
    SET DrvTermDt = NULL
    WHERE DrvTermDt = ' TermDt=""';

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_Person
    -----------------------
    SELECT DISTINCT DrvSort = '3' + DetCOID + DetEEID
        ,DrvSubSort = '2'
        ,DrvCOID = DetCOID
        ,DrvEEID = DetEEID
        ,DrvPersonOpen = '<Person'
        ,DrvFirstNm = ' FirstNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(EepNameFirst), '', '') + '"'
        ,DrvMiddleInitialNm = ' MiddleInitialNm="' + LEFT(EepNameMiddle, 1) + '"'
        ,DrvLastNm = ' LastNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(EepNameLast), '', '') + '"'
        ,DrvBirthDt = ' BirthDt="' + CONVERT(VARCHAR(10), EepDateOfBirth, 120) + '"'
        ,DrvResidenceCd = ' ResidenceCd="' + PrvCode + '"'
        ,DrvGenderCd = ' GenderCd="'
                        + CASE EepGender
                               WHEN 'M' THEN '1'
                               WHEN 'F' THEN '2'
                               ELSE ''
                         END + '"'
        ,DrvDepTypeCd = ' DepTypeCd="' + SPACE(1) + '"'
        ,DrvLanguageCd = ' LanguageCd="'
                        + CASE EecLanguageCode
                               WHEN 'EN' THEN '1'
                               WHEN 'FR' THEN '2'
                               ELSE ''
                         END + '"'
        ,DrvPersonClose = ' />'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_Person
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    INNER JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = DetEEID
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = DetEEID
        AND EecCOID = DetCOID
    LEFT JOIN dbo.U_Dsi_DrvTbl_@CustomFormatCode_Provinces WITH (NOLOCK)
        ON EepAddressState = PrvAbbr
    WHERE DetPerson = 'Y';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Person
    SET DrvDepTypeCd = ' DepTypeCd="'
                        + CASE WHEN BdmBenOption IN (@FamilyBenOption) THEN '3'
                               WHEN BdmBenOption IN (@ChildBenOption) THEN '2'
                         END + '"'
    FROM dbo.U_dsi_bdm_@CustomFormatCode
    WHERE BdmEEID = DrvEEID
    AND BdmCOID = DrvCOID;

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Person
    SET DrvDepTypeCd = NULL
    WHERE DrvDepTypeCd IN (' DepTypeCd=""',' DepTypeCd=" "');

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_Salary
    -----------------------
    SELECT DISTINCT DrvSort = '3' + DetCOID + DetEEID
        ,DrvSubSort = '3'
        ,DrvCOID = DetCOID
        ,DrvEEID = DetEEID
        ,DrvSalaryOpen = '<Salary'
        ,DrvSalaryDescCd = ' SalaryDescCd="1"'
        ,DrvSalaryBasisCd = ' SalaryBasisCd="1"'
        ,DrvSalaryAmt = ' SalaryAmt="' + CONVERT(VARCHAR(40), CONVERT(DECIMAL(38, 2), JbcJobPremiumRateOrPct + EecAnnSalary)) + '"'
        ,DrvHoursPerWeekAmt = ' HoursPerWeekAmt=""'
        ,DrvStatusCd = ' StatusCd="1"'
        ,DrvSalaryClose = ' />'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_Salary
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = DetEEID
        AND EecCOID = DetCOID
    INNER JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    WHERE DetSalary = 'Y';

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_Address
    -----------------------
    SELECT DISTINCT DrvSort = '3' + DetCOID + DetEEID
        ,DrvSubSort = '4'
        ,DrvCOID = DetCOID
        ,DrvEEID = DetEEID
        ,DrvAddressOpen = '<Address'
        ,DrvAddressTypeCd = ' AddressTypeCd="1"'
        ,DrvAddressNm = ' AddressNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(EepNameFirst), '', '') + ', ' + dbo.usi_fn_RemovePunctuation(RTRIM(EepNameLast), '', '') + dbo.usi_fn_RemovePunctuation(RTRIM(' ' + ISNULL(EepNameSuffix, '')), '', '') + '"'
        ,DrvStreetAddressNm = ' StreetAddressNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(EepAddressLine1), '', '') + '"'
        ,DrvSuiteNm = ' SuiteNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(EepAddressLine2), '', '') + '"'
        ,DrvCityNm = ' CityNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(EepAddressCity), '', '') + '"'
        ,DrvStateOrProvCd = ' StateOrProvCd="' + PrvCode + '"'
        ,DrvPostalNum = ' PostalNum="'
                        + CASE LEN(RTRIM(EepAddressZipCode))
                               WHEN 5 THEN EepAddressZipCode
                               WHEN 6 THEN SUBSTRING(EepAddressZipCode, 1, 3) + ' ' + SUBSTRING(EepAddressZipCode, 4, 6)
                               ELSE SUBSTRING(EepAddressZipCode, 1, 5) + '-' + SUBSTRING(EepAddressZipCode, 6, 4)
                        END + '"'
        ,DrvCountryCd = ' CountryCd="'
                        + CASE EepAddressCountry
                               WHEN 'CAN' THEN '1'
                               WHEN 'USA' THEN '2'
                               ELSE ''
                        END + '"'
        ,DrvStatusCd = ' StatusCd="1"'
        ,DrvAddressClose = ' />'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_Address
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    INNER JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = DetEEID
    LEFT JOIN dbo.U_Dsi_DrvTbl_@CustomFormatCode_Provinces WITH (NOLOCK)
        ON EepAddressState = PrvAbbr
    WHERE DetAddress = 'Y';

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink
    -----------------------
    SELECT DISTINCT DrvSort = '3' + DetCOID + DetEEID
        ,DrvSubSort = '5'
        ,DrvCOID = DetCOID
        ,DrvEEID = DetEEID
        ,DrvDepRecID = ConSystemID
        ,DrvPersonLinkOpen = '<PersonLink'
        ,DrvPersonLinkTypeCd = ' PersonLinkTypeCd="'
                                + CASE WHEN ConRelationship IN (@SpouseRelationshipCodes) THEN '2'
                                       WHEN ConRelationship IN (@ChildRelationshipCodes) THEN '3'
                                END + '"'
        ,DrvFirstNm = ' FirstNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(ConNameFirst), '', '') + '"'
        ,DrvLastNm = ' LastNm="' + dbo.usi_fn_RemovePunctuation(RTRIM(ConNameLast), '', '') + '"'
        ,DrvBirthDt = ' BirthDt="' + CONVERT(VARCHAR(10), ConDateOfBirth, 120) + '"'
        ,DrvGenderCd = ' GenderCd="'
                        + CASE ConGender
                               WHEN 'M' THEN '1'
                               WHEN 'F' THEN '2'
                        END + '"'
        ,DrvInSchoolFlg = ' InSchoolFlg="'
                        + CASE ConIsStudent
                               WHEN 'Y' THEN 'True'
                               ELSE 'False'
                        END + '"'
        ,DrvEffectiveDt = ' EffectiveDt="' + SPACE(10) + '"'
        ,DrvTermDt = ' TermDt="' + SPACE(10) + '"'
        ,DrvTermReasonCd = ' TermReasonCd="' + SPACE(1) + '"'
        ,DrvStatusCd = ' StatusCd="1"'
        ,DrvPersonLinkClose = ' />'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    INNER JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = DetEEID
    LEFT JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = DetEEID
        AND BdmCOID = DetCOID
        AND BdmDepRecID = ConSystemID
        AND BdmRecType = 'DEP'
        AND BdmDedCode IN (@DedCodeList)
    LEFT JOIN dbo.U_Dsi_DrvTbl_@CustomFormatCode_Audit WITH (NOLOCK)
        ON AudKey1Value = DetEEID
        AND AudKey3Value = ConSystemID
    WHERE (AudFieldName IN ('DbnDedCode','ConNameFirst','ConNameMiddle','ConNameLast','ConDateOfBirth','ConGender','ConRelationship','ConIsStudent')
        OR BdmDedRowStatus <> ''
    )
    AND ConRelationship IN (@RelationshipCodes)
    AND conisdependent = 'Y'
    AND DetTerm <> 'Y';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink
    SET DrvEffectiveDt = ' EffectiveDt="'
                        + (SELECT CONVERT(VARCHAR(10), MIN(BdmBenStartDate), 120)
                           FROM dbo.U_dsi_bdm_@CustomFormatCode
                           WHERE BdmEEID = DrvEEID
                           AND BdmCOID = DrvCOID
                           AND BdmDepRecID = DrvDepRecID
                           AND BdmRecType = 'DEP'
                           AND BdmDedCode IN (@DedCodeList)
                        ) + '"';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink
    SET DrvTermDt = ' TermDt="'
                    + (SELECT CONVERT(VARCHAR(10), MAX(BdmBenStopDate), 120)
                       FROM dbo.U_dsi_bdm_@CustomFormatCode
                       INNER JOIN dbo.U_@CustomFormatCode_EEList_Detail
                            ON BdmEEID = DetEEID
                            AND BdmCOID = DetCOID
                       WHERE BdmEEID = DrvEEID
                       AND BdmCOID = DrvCOID
                       AND BdmDepRecID = DrvDepRecID
                       AND BdmRecType = 'DEP'
                       AND BdmDedCode IN (@DedCodeList)
                    ) + '"'
        ,DrvTermReasonCd = ' TermReasonCd="2"'
        ,DrvStatusCd = ' StatusCd="3"'
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmEEID = DrvEEID AND BdmCOID = DrvCOID AND BdmDepRecID = DrvDepRecID AND BdmRecType = 'DEP' AND BdmDedCode IN (@DedCodeList) AND BdmBenStopDate IS NULL)
    AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_@CustomFormatCode WHERE BdmEEID = DrvEEID AND BdmCOID = DrvCOID AND BdmDepRecID = DrvDepRecID AND BdmRecType = 'DEP' AND BdmDedCode IN (@DedCodeList) AND BdmBenStopDate IS NOT NULL);

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_PersonLink
    SET DrvTermDt = NULL
        ,DrvTermReasonCd = NULL
    WHERE DrvTermReasonCd = ' TermReasonCd=" "';

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_Benefits
    -----------------------
    SELECT DISTINCT DrvSort = '3' + DetCOID + DetEEID
        ,DrvSubSort = '6'
        ,DrvCOID = DetCOID
        ,DrvEEID = DetEEID
        ,DrvDepRecID = BdmDepRecID
        ,DrvBenefitsOpen = '<Benefits'
        ,DrvBenefitType = ' BenefitType="'
                            + CASE BdmDedCode
                                   WHEN 'MED' THEN '101'
                                   WHEN 'DEN' THEN '502'
                                   WHEN 'VIS' THEN '512'
                            END + '"'
        ,DrvFlexCodeNm = ' FlexCodeNm="A"'
        ,DrvDepTypeCd = ' DepTypeCd="'
                        + CASE WHEN BdmBenOption IN (@FamilyBenOption) THEN '3'
                               WHEN BdmBenOption IN (@EEOnlyBenOption) THEN '2'
							   ELSE '2'
                        END + '"'
        ,DrvEffectiveDt = ' EffectiveDt="' + CASE WHEN DetNewHire = 'Y' THEN CONVERT(VARCHAR(10), BdmBenStartDate, 120) END + '"'
        ,DrvRequestedAmt = ''
        ,DrvRequestedUnitsAmt = ''
        ,DrvStatusCd = ' StatusCd="1"'
        ,DrvTermDt = ' TermDt="' + CONVERT(VARCHAR(10), BdmBenStopDate, 120) + '"'
        ,DrvTermReasonCd = ' TermReasonCd="' + SPACE(1) + '"'
        ,DrvBenefitsClose = ' />'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_Benefits
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    INNER JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = DetEEID
        AND EecCOID = DetCOID
    INNER JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = DetEEID
        AND BdmCOID = DetCOID
        AND BdmRecType = 'EMP'
    WHERE DetBenefits = 'Y';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Benefits
    SET DrvStatusCd = ' StatusCd="3"'
        ,DrvTermReasonCd = ' TermReasonCd="2"'
    WHERE ISNULL(DrvTermDt, '') <> '';

    UPDATE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Benefits
    SET DrvTermDt = NULL
        ,DrvTermReasonCd = NULL
    WHERE DrvTermReasonCd = ' TermReasonCd=" "';

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberClose
    -----------------------
    SELECT DISTINCT DrvSort = '3' + DetCOID + DetEEID
        ,DrvSubSort = '7'
        ,DrvCOID = DetCOID
        ,DrvEEID = DetEEID
        ,DrvMemberClose = '</Member>'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_MemberClose
    FROM dbo.U_@CustomFormatCode_EEList_Detail
    WHERE DetMember = 'Y';

    -----------------------
    -- Build dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderClose
    -----------------------
    SELECT DISTINCT DrvSort = '4'
        ,DrvSubSort = ''
        ,DrvLoaderClose = '</Loader>'
    INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_LoaderClose;

    -----------------------
    -- Update filename
    -----------------------
    UPDATE dbo.U_dsi_Parameters
    SET ExportFile = 'T@PolicyNumber' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19), GETDATE(), 120), '-', ''), ' ', ''), ':', '') + '.txt'
    WHERE FormatCode = @FormatCode;

END
/**********************************************************************************

--Alter the View
ALTER VIEW [dbo].[dsi_vw@CustomFormatCode_Export] AS
    SELECT TOP 2000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY InitialSort,SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
SET expLastStartPerControl = '201810251'
   ,expStartPerControl     = '201810251'
   ,expLastEndPerControl   = '201811019'
   ,expEndPerControl       = '201811019'
WHERE expFormatCode = '@CustomFormatCode';

-- Create State/Province Code Translation Table

IF OBJECT_ID('dbo.U_Dsi_DrvTbl_@CustomFormatCode_Provinces') IS NOT NULL DROP TABLE dbo.U_Dsi_DrvTbl_@CustomFormatCode_Provinces

CREATE TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Provinces](
  [PrvCode] [VARCHAR](2)   NULL,
  [PrvAbbr] [VARCHAR](2)   NULL,
  [PrvDesc] [VARCHAR](255) NULL
) ON [PRIMARY]

INSERT INTO dbo.U_Dsi_DrvTbl_@CustomFormatCode_Provinces VALUES
     ('1', 'NL', 'Newfoundland')
    ,('2', 'PE', 'Prince Edward Island')
    ,('3', 'NB', 'New Brunswick')
    ,('4', 'NS', 'Nova Scotia')
    ,('5', 'ON', 'Ontario')
    ,('6', 'QC', 'Quebec')
    ,('7', 'MB', 'Manitoba')
    ,('8', 'SK', 'Saskatchewan')
    ,('9', 'AB', 'Alberta')
    ,('10', 'BC', 'British Columbia')
    ,('11', 'NT', 'Northwest Territories')
    ,('12', 'YT', 'Yukon')
    ,('13', 'NU', 'Nunavut')
    ,('14', 'AL', 'Alabama')
    ,('15', 'AK', 'Alaska')
    ,('16', 'AZ', 'Arizona')
    ,('17', 'AR', 'Arkansas')
    ,('18', 'CA', 'California')
    ,('19', 'CO', 'Colorado')
    ,('20', 'CT', 'Connecticut')
    ,('21', 'DE', 'Delaware')
    ,('22', 'DC', 'District of Columbia')
    ,('23', 'FL', 'Florida')
    ,('24', 'GA', 'Georgia')
    ,('25', 'HI', 'Hawaii')
    ,('26', 'ID', 'Idaho')
    ,('27', 'IL', 'Illinois')
    ,('28', 'IN', 'Indiana')
    ,('29', 'IA', 'Iowa')
    ,('30', 'KS', 'Kansas')
    ,('31', 'KY', 'Kentucky')
    ,('32', 'LA', 'Louisianna')
    ,('33', 'ME', 'Maine')
    ,('34', 'MD', 'Maryland')
    ,('35', 'MA', 'Massachusetts')
    ,('36', 'MI', 'Michigan')
    ,('37', 'MN', 'Minnesota')
    ,('38', 'MS', 'Mississippi')
    ,('39', 'MO', 'Missouri')
    ,('40', 'MT', 'Montana')
    ,('41', 'NE', 'Nebraska')
    ,('42', 'NV', 'Nevada')
    ,('43', 'NH', 'New Hampshire')
    ,('44', 'NJ', 'New Jersey')
    ,('45', 'NM', 'New Mexico')
    ,('46', 'NY', 'New York')
    ,('47', 'NC', 'North Carolina')
    ,('48', 'ND', 'North Dakota')
    ,('49', 'OH', 'Ohio')
    ,('50', 'OK', 'Oklahoma')
    ,('51', 'OR', 'Oregon')
    ,('52', 'PA', 'Pennsylvania')
    ,('53', 'RI', 'Rhode Island')
    ,('54', 'SC', 'South Carolina')
    ,('55', 'SD', 'South Dakota')
    ,('56', 'TN', 'Tennessee')
    ,('57', 'TX', 'Texas')
    ,('58', 'UT', 'Utah')
    ,('59', 'VT', 'Vermont')
    ,('60', 'VA', 'Virginia')
    ,('61', 'WA', 'Washington')
    ,('62', 'WV', 'West Virginia')
    ,('63', 'WI', 'Wisconsin')
    ,('64', 'WY', 'Wyoming')
    ,('65', 'OT', 'Other')

SELECT * FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Provinces

**********************************************************************************/
GO
CREATE VIEW [dbo].[dsi_vw@CustomFormatCode_Export] AS
    SELECT TOP 2000000 DATA FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY InitialSort,SubSort;
GO
CREATE FUNCTION [dbo].[dsi_fn_@CustomFormatCode_GetBeneficiaries] (
	@EEID VARCHAR(12)
   ,@COID VARCHAR(5)
)
RETURNS VARCHAR(1024)
AS
/************************************************************

Created By: @DeveloperName
Create Date: @CreateDate

Purpose: Removes non-printing characters in a string

Commands: PRINT dbo.dsi_fn_@CustomFormatCode_GetBeneficiaries('8WP1TI0020K0','UR169')

Revision History
----------------
Update By         Date          CP Num         Descr
xxxxxxxxxxxxxxxx  xx/xx/xxxxx   CS-xxxx-xxxxx  xxxxxxxx

************************************************************/
BEGIN

	DECLARE @Temp VARCHAR(1024);
	SET @Temp = '';

	SELECT @Temp = @Temp + BfyRecord + ', ' FROM dbo.U_Dsi_DrvTbl_@CustomFormatCode_Beneficiaries WHERE BfyCOID = @COID AND BfyEEID = @EEID;

	RETURN LEFT(RTRIM(@Temp),CASE WHEN @Temp = '' THEN 1 ELSE LEN(@Temp)-1 END);

END