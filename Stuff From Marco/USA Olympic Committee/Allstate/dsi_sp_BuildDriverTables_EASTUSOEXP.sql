SET NOCOUNT ON;
IF OBJECT_ID('U_EASTUSOEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EASTUSOEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EASTUSOEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEASTUSOEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASTUSOEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASTUSOEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASTUSOEXP];
GO
IF OBJECT_ID('U_EASTUSOEXP_Person') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_Person];
GO
IF OBJECT_ID('U_EASTUSOEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_PEarHist];
GO
IF OBJECT_ID('U_EASTUSOEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_PDedHist];
GO
IF OBJECT_ID('U_EASTUSOEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_File];
GO
IF OBJECT_ID('U_EASTUSOEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_EEList];
GO
IF OBJECT_ID('U_EASTUSOEXP_drvTblCancer') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_drvTblCancer];
GO
IF OBJECT_ID('U_EASTUSOEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_DedList];
GO
IF OBJECT_ID('U_EASTUSOEXP_Accident') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_Accident];
GO
IF OBJECT_ID('U_dsi_BDM_EASTUSOEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EASTUSOEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EASTUSOEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EASTUSOEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EASTUSOEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EASTUSOEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EASTUSOEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASTUSOEXP','Allstate Cancer and Accident Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EASTUSOEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EASTUSOEXPZ0','2','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApplicationID"','2','(''UA''=''F'')','EASTUSOEXPZ0','9','D','10','2',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','3','(''UA''=''F'')','EASTUSOEXPZ0','15','D','10','3',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsProposedInsured"','4','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','4',NULL,'Is Proposed Insured',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsEmployee"','5','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','5',NULL,'Is Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsPolicyOwner"','6','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','6',NULL,'Is Policy Owner',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsDependent"','7','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','7',NULL,'Is Dependent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsBeneficiary"','8','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','8',NULL,'Is Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiaryType"','9','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','9',NULL,'Beneficiary Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneficiaryPercentage"','10','(''UA''=''F'')','EASTUSOEXPZ0','5','D','10','10',NULL,'Beneficiary Percentage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelToPrimaryInsured"','11','(''UA''=''F'')','EASTUSOEXPZ0','2','D','10','11',NULL,'Relationship To Primary Insured',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipToEmployee"','12','(''UA''=''F'')','EASTUSOEXPZ0','2','D','10','12',NULL,'Relationship To Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLNameorNameofTrustEstate"','13','(''UA''=''F'')','EASTUSOEXPZ0','35','D','10','13',NULL,'Last Name or Name of Trust Estate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','14','(''UA''=''F'')','EASTUSOEXPZ0','35','D','10','14',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','15','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','15',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPersonSSN"','16','(''UA''=''F'')','EASTUSOEXPZ0','9','D','10','16',NULL,'Person SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','17',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','18','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','10','18',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhoneNumber"','19','(''UA''=''F'')','EASTUSOEXPZ0','15','D','10','19',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','20','(''UA''=''F'')','EASTUSOEXPZ0','1','D','10','20',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeight"','21','(''UA''=''F'')','EASTUSOEXPZ0','3','D','10','21',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeight"','22','(''UA''=''F'')','EASTUSOEXPZ0','3','D','10','22',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullStreetAddress"','23','(''UA''=''F'')','EASTUSOEXPZ0','71','D','10','23',NULL,'Full Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','24','(''UA''=''F'')','EASTUSOEXPZ0','20','D','10','24',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','25','(''UA''=''F'')','EASTUSOEXPZ0','2','D','10','25',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','26','(''UA''=''F'')','EASTUSOEXPZ0','9','D','10','26',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERorAssociationorUnion"','27','(''UA''=''F'')','EASTUSOEXPZ0','35','D','10','27',NULL,'Employer or Association or Union',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitEligibilityDate"','28','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','10','28',NULL,'Benefit Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EASTUSOEXPZ0','8','D','10','29',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EASTUSOEXPZ0','25','D','10','30',NULL,'Plant or Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EASTUSOEXPZ0','1','D','10','31',NULL,'Active at Work',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','EASTUSOEXPZ0','75','D','10','32',NULL,'Reason for not active at work',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemberId"','33','(''UA''=''F'')','EASTUSOEXPZ0','10','D','10','33',NULL,'Employee or Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','EASTUSOEXPZ0','8','D','10','34',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EASTUSOEXPZ0','35','D','10','35',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EASTUSOEXPZ0','35','D','10','36',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''F'')','EASTUSOEXPZ0','45','D','10','37',NULL,'Employee Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EASTUSOEXPZ0','100','D','10','38',NULL,'Remarks',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','39',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','40',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','41',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','42',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','43',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','44',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','45',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','46',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','47',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EASTUSOEXPZ0','15','D','10','48',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EASTUSOEXPZ0','36','D','10','49',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EASTUSOEXPZ0','1','D','10','50',NULL,'IsSecondaryContact',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EASTUSOEXPZ0','2','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApplicationID"','2','(''UA''=''F'')','EASTUSOEXPZ0','9','D','20','2',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','3','(''UA''=''F'')','EASTUSOEXPZ0','1','D','20','3',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSection125"','4','(''UA''=''F'')','EASTUSOEXPZ0','1','D','20','4',NULL,'Section 125',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalModePremium"','5','(''UA''=''F'')','EASTUSOEXPZ0','6','D','20','5',NULL,'Total Mode Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasePlanUnits"','6','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','6',NULL,'Base Plan Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1"','7','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','7',NULL,'Rider1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1UnitsAmt"','8','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','8',NULL,'Rider1 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2"','9','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','9',NULL,'Rider2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2UnitsAmt"','10','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','10',NULL,'Rider2 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3"','11','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','11',NULL,'Rider3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3UnitsAmt"','12','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','12',NULL,'Rider3 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4"','13','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','13',NULL,'Rider4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4UnitsAmt"','14','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','14',NULL,'Rider4 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5"','15','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','15',NULL,'Rider5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5UnitsAmt"','16','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','16',NULL,'Rider5 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6"','17','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','17',NULL,'Rider6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6UnitsAmt"','18','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','18',NULL,'Rider6 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','19',NULL,'Rider7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','20',NULL,'Rider7 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','21',NULL,'Rider8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','22',NULL,'Rider8 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','23',NULL,'Rider9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','24',NULL,'Rider9 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','25',NULL,'Rider10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','26',NULL,'Rider10 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','27',NULL,'Rider11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','28',NULL,'Rider11 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','29',NULL,'Rider12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','30',NULL,'Rider12 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumBillingMode"','31','(''UA''=''F'')','EASTUSOEXPZ0','2','D','20','31',NULL,'Premium Billing Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofFirstDeduction"','32','(''UD112''=''F'')','EASTUSOEXPZ0','8','D','20','32',NULL,'Date of First Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequestedCoverageEffDate"','33','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','20','33',NULL,'Requested Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaseNumber"','34','(''UA''=''F'')','EASTUSOEXPZ0','10','D','20','34',NULL,'Case Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode"','35','(''UA''=''F'')','EASTUSOEXPZ0','1','D','20','35',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequestedCoverageEndDate"','36','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','20','36',NULL,'Requested Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignedCityandState"','37','(''''UD112''=''F'')','EASTUSOEXPZ0','100','D','20','37',NULL,'Signed City and State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDatesignedbyEmployee"','38','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','20','38',NULL,'Date signed by Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EASTUSOEXPZ0','35','D','20','39',NULL,'Producer''s name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','40',NULL,'Servicing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EASTUSOEXPZ0','5','D','20','41',NULL,'Servicing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','42',NULL,'Writing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EASTUSOEXPZ0','5','D','20','43',NULL,'Writing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','44',NULL,'Other Agent1 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EASTUSOEXPZ0','5','D','20','45',NULL,'Other Agent1 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','46',NULL,'Other Agent2 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EASTUSOEXPZ0','5','D','20','47',NULL,'Other Agent2 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','48',NULL,'Other Agent3 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EASTUSOEXPZ0','5','D','20','49',NULL,'Other Agent3 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','50',NULL,'Other Agent4 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EASTUSOEXPZ0','5','D','20','51',NULL,'Other Agent4 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EASTUSOEXPZ0','10','D','20','52',NULL,'Other Agent5 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EASTUSOEXPZ0','5','D','20','53',NULL,'Other Agent5 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EASTUSOEXPZ0','2','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvApplicationID"','2','(''UA''=''F'')','EASTUSOEXPZ0','9','D','30','2',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','3','(''UA''=''F'')','EASTUSOEXPZ0','1','D','30','3',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSection125"','4','(''UA''=''F'')','EASTUSOEXPZ0','1','D','30','4',NULL,'Section 125',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalModePremium"','5','(''UA''=''F'')','EASTUSOEXPZ0','6','D','30','5',NULL,'Total Mode Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasePlanUnits"','6','(''UA''=''F'')','EASTUSOEXPZ0','3','D','30','6',NULL,'Base Plan Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1"','7','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','7',NULL,'Rider1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1UnitsAmt"','8','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','8',NULL,'Rider1 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2"','9','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','9',NULL,'Rider2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2UnitsAmt"','10','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','10',NULL,'Rider2 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3"','11','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','11',NULL,'Rider3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3UnitsAmt"','12','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','12',NULL,'Rider3 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4"','13','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','13',NULL,'Rider4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4UnitsAmt"','14','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','14',NULL,'Rider4 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5"','15','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','15',NULL,'Rider5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5UnitsAmt"','16','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','16',NULL,'Rider5 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6"','17','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','17',NULL,'Rider6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6UnitsAmt"','18','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','18',NULL,'Rider6 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','19',NULL,'Rider7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','20',NULL,'Rider7 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','21',NULL,'Rider8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','22',NULL,'Rider8 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','23',NULL,'Rider9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','24',NULL,'Rider9 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','25',NULL,'Rider10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','26',NULL,'Rider10 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','27',NULL,'Rider11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','28',NULL,'Rider11 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','29',NULL,'Rider12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','30',NULL,'Rider12 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumBillingMode"','31','(''UA''=''F'')','EASTUSOEXPZ0','2','D','30','31',NULL,'Premium Billing Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofFirstDeduction"','32','(''UD112''=''F'')','EASTUSOEXPZ0','8','D','30','32',NULL,'Date of First Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequestedCoverageEffDate"','33','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','30','33',NULL,'Requested Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaseNumber"','34','(''UA''=''F'')','EASTUSOEXPZ0','10','D','30','34',NULL,'Case Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode"','35','(''UA''=''F'')','EASTUSOEXPZ0','1','D','30','35',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRequestedCoverageEndDate"','36','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','30','36',NULL,'Requested Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignedCityandState"','37','(''''UD112''=''F'')','EASTUSOEXPZ0','100','D','30','37',NULL,'Signed City and State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDatesignedbyEmployee"','38','(''''UD112''=''F'')','EASTUSOEXPZ0','8','D','30','38',NULL,'Date signed by Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EASTUSOEXPZ0','35','D','30','39',NULL,'Producer''s name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','40',NULL,'Servicing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EASTUSOEXPZ0','5','D','30','41',NULL,'Servicing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','42',NULL,'Writing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EASTUSOEXPZ0','5','D','30','43',NULL,'Writing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','44',NULL,'Other Agent1 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EASTUSOEXPZ0','5','D','30','45',NULL,'Other Agent1 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','46',NULL,'Other Agent2 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EASTUSOEXPZ0','5','D','30','47',NULL,'Other Agent2 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','48',NULL,'Other Agent3 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EASTUSOEXPZ0','5','D','30','49',NULL,'Other Agent3 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','50',NULL,'Other Agent4 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EASTUSOEXPZ0','5','D','30','51',NULL,'Other Agent4 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EASTUSOEXPZ0','10','D','30','52',NULL,'Other Agent5 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EASTUSOEXPZ0','5','D','30','53',NULL,'Other Agent5 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EASTUSOEXPZ0','3','D','30','54',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EASTUSOEXPZ0','1','D','30','55',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EASTUSOEXPZ0','25','D','30','56',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','EASTUSOEXPZ0','6','D','30','57',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EASTUSOEXPZ0','4','D','30','58',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EASTUSOEXP_20201006.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Allstate Cancer and Accident E','202010029','EMPEXPORT','ONDEMAND',NULL,'EASTUSOEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:53AM','Oct  2 2020 11:53AM','202010021',NULL,'','','202010021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EASTUSOEXP_20201006.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202010029','EMPEXPORT','TEST',NULL,'EASTUSOEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:53AM','Oct  2 2020 11:53AM','202010021',NULL,'','','202010021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EASTUSOEXP_20201006.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202010029','EMPEXPORT','SCH_ALLST','Oct  2 2020 12:30PM','EASTUSOEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:53AM','Oct  2 2020 11:53AM','202010021','444','','','202010021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EASTUSOEXP_20201006.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202010029','EMPEXPORT','OEACTIVE',NULL,'EASTUSOEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:53AM','Oct  2 2020 11:53AM','202010021',NULL,'','','202010021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EASTUSOEXP_20201006.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202010029','EMPEXPORT','OEPASSIVE',NULL,'EASTUSOEXP',NULL,NULL,NULL,'202010029','Oct  2 2020 11:53AM','Oct  2 2020 11:53AM','202010021',NULL,'','','202010021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EASTUSOEXP_20201006.txt' END WHERE expFormatCode = 'EASTUSOEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUSOEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUSOEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUSOEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUSOEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUSOEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASTUSOEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EASTUSOEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EASTUSOEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EASTUSOEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASTUSOEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASTUSOEXP','D10','dbo.U_EASTUSOEXP_Person',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASTUSOEXP','D20','dbo.U_EASTUSOEXP_drvTblCancer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASTUSOEXP','D30','dbo.U_EASTUSOEXP_Accident',NULL);
IF OBJECT_ID('U_dsi_BDM_EASTUSOEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EASTUSOEXP] (
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
IF OBJECT_ID('U_EASTUSOEXP_Accident') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_Accident] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvApplicationID] char(11) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvSection125] varchar(1) NOT NULL,
    [drvTotalModePremium] varchar(30) NULL,
    [drvBasePlanUnits] varchar(3) NOT NULL,
    [drvRider1] varchar(6) NOT NULL,
    [drvRider1UnitsAmt] varchar(3) NOT NULL,
    [drvRider2] varchar(6) NOT NULL,
    [drvRider2UnitsAmt] varchar(3) NOT NULL,
    [drvRider3] varchar(5) NOT NULL,
    [drvRider3UnitsAmt] varchar(3) NOT NULL,
    [drvRider4] varchar(5) NOT NULL,
    [drvRider4UnitsAmt] varchar(3) NOT NULL,
    [drvRider5] varchar(6) NOT NULL,
    [drvRider5UnitsAmt] varchar(3) NOT NULL,
    [drvRider6] varchar(1) NOT NULL,
    [drvRider6UnitsAmt] varchar(1) NOT NULL,
    [drvPremiumBillingMode] varchar(2) NOT NULL,
    [drvDateofFirstDeduction] datetime NULL,
    [drvRequestedCoverageEffDate] datetime NULL,
    [drvCaseNumber] varchar(5) NOT NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvRequestedCoverageEndDate] datetime NULL,
    [drvSignedCityandState] varchar(19) NOT NULL,
    [drvDatesignedbyEmployee] datetime NULL
);
IF OBJECT_ID('U_EASTUSOEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EASTUSOEXP_drvTblCancer') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_drvTblCancer] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvApplicationID] char(11) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvSection125] varchar(1) NOT NULL,
    [drvTotalModePremium] varchar(30) NULL,
    [drvBasePlanUnits] varchar(3) NOT NULL,
    [drvRider1] varchar(4) NOT NULL,
    [drvRider1UnitsAmt] varchar(3) NOT NULL,
    [drvRider2] varchar(3) NOT NULL,
    [drvRider2UnitsAmt] varchar(3) NOT NULL,
    [drvRider3] varchar(4) NOT NULL,
    [drvRider3UnitsAmt] varchar(3) NOT NULL,
    [drvRider4] varchar(4) NOT NULL,
    [drvRider4UnitsAmt] varchar(3) NOT NULL,
    [drvRider5] varchar(3) NOT NULL,
    [drvRider5UnitsAmt] varchar(3) NOT NULL,
    [drvRider6] varchar(2) NOT NULL,
    [drvRider6UnitsAmt] varchar(3) NOT NULL,
    [drvPremiumBillingMode] varchar(2) NOT NULL,
    [drvDateofFirstDeduction] datetime NULL,
    [drvRequestedCoverageEffDate] datetime NULL,
    [drvCaseNumber] varchar(5) NOT NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvRequestedCoverageEndDate] datetime NULL,
    [drvSignedCityandState] varchar(19) NOT NULL,
    [drvDatesignedbyEmployee] datetime NULL
);
IF OBJECT_ID('U_EASTUSOEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EASTUSOEXP_File') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EASTUSOEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_PDedHist] (
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
IF OBJECT_ID('U_EASTUSOEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_PEarHist] (
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
IF OBJECT_ID('U_EASTUSOEXP_Person') IS NULL
CREATE TABLE [dbo].[U_EASTUSOEXP_Person] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvApplicationID] char(11) NULL,
    [drvFiller] varchar(1) NOT NULL,
    [drvIsProposedInsured] varchar(1) NOT NULL,
    [drvIsEmployee] varchar(1) NOT NULL,
    [drvIsPolicyOwner] varchar(1) NOT NULL,
    [drvIsDependent] varchar(1) NOT NULL,
    [drvIsBeneficiary] varchar(1) NOT NULL,
    [drvBeneficiaryType] varchar(1) NOT NULL,
    [drvBeneficiaryPercentage] varchar(1) NOT NULL,
    [drvRelToPrimaryInsured] varchar(2) NULL,
    [drvRelationshipToEmployee] varchar(2) NULL,
    [drvLNameorNameofTrustEstate] varchar(100) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvPersonSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvHomePhoneNumber] varchar(50) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvHeight] varchar(1) NOT NULL,
    [drvWeight] varchar(1) NOT NULL,
    [drvFullStreetAddress] varchar(511) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvERorAssociationorUnion] varchar(31) NULL,
    [drvBenefitEligibilityDate] datetime NULL,
    [drvMemberId] char(9) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASTUSOEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: USA Olympic Committee

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 10/02/2020
Service Request Number: TekP-2020-07-21-0004

Purpose: Allstate Cancer and Accident Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASTUSOEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASTUSOEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASTUSOEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASTUSOEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASTUSOEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUSOEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUSOEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUSOEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUSOEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASTUSOEXP', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASTUSOEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EASTUSOEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EASTUSOEXP';

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
    DELETE FROM dbo.U_EASTUSOEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASTUSOEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACCDT,CANCR';

    IF OBJECT_ID('U_EASTUSOEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUSOEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASTUSOEXP_DedList
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

     EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;


    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EASTUSOEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUSOEXP_PDedHist;
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
    INTO dbo.U_EASTUSOEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EASTUSOEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EASTUSOEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUSOEXP_PEarHist;
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
    INTO dbo.U_EASTUSOEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EASTUSOEXP_Person
    ---------------------------------
    IF OBJECT_ID('U_EASTUSOEXP_Person','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUSOEXP_Person;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmdeprecid --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2' + eepssn
        ,drvSubSort = bdmdeprecid
        -- standard fields above and additional driver fields below
        ,drvRecordType = '01'
        ,drvApplicationID = eepssn
        ,drvFiller = ''
        ,drvIsProposedInsured = CASE WHEN bdmrectype = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvIsEmployee = CASE WHEN bdmrectype = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvIsPolicyOwner = CASE WHEN bdmrectype = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvIsDependent = CASE WHEN bdmrectype = 'EMP' THEN 'N' ELSE 'Y' END
        ,drvIsBeneficiary = 'N'
        ,drvBeneficiaryType = ''
        ,drvBeneficiaryPercentage = ''
        ,drvRelToPrimaryInsured =  CASE WHEN bdmREctype = 'EMP' THEN '14' ELSE
                                        CASE WHEN ConRelationship ='SPS' THEN '12'
                                              WHEN ConRelationship ='DP' THEN '35'
                                               WHEN ConRelationship in ('CHL', 'DCH', 'DPC' ,'STC') THEN '35'
                                        END
                                   END
        ,drvRelationshipToEmployee =  CASE WHEN bdmREctype = 'EMP' THEN '14' ELSE
                                        CASE WHEN ConRelationship ='SPS' THEN '12'
                                              WHEN ConRelationship ='DP' THEN '35'
                                               WHEN ConRelationship in ('CHL', 'DCH', 'DPC' ,'STC') THEN '35'
                                        END
                                   END
        ,drvLNameorNameofTrustEstate = CASE WHEN bdmrectype = 'EMP' THEN eepNameLast ELSE connamelast END
        ,drvFirstName = CASE WHEN bdmrectype = 'EMP' THEN eepNameFirst ELSE connamefirst END
        ,drvMiddleInitial = CASE WHEN bdmrectype = 'EMP' THEN LEFT(ISNULL(EepNameMiddle,''),1) ELSE LEFT(ISNULL(ConNameMiddle,''),1) END 
        ,drvPersonSSN = CASE WHEN bdmrectype = 'EMP' THEN eepSSN ELSE conSSN END 
        ,drvGender = CASE WHEN bdmrectype = 'EMP' THEN 
                                CASE WHEN EepGender in ('M','F') THEN EepGender END ELSE CASE WHEN ConGender in ('M','F') THEN ConGender END END   
        ,drvDateofBirth =  CASE WHEN bdmrectype = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvHomePhoneNumber = CASE WHEN bdmrectype = 'EMP' THEN  EepPhoneHomeNumber END
        ,drvMaritalStatus = ''
        ,drvHeight = ''
        ,drvWeight = ''
        ,drvFullStreetAddress = CONCAT(eepaddressline1,' ', eepaddressline2)
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = eepAddressZipCode
        ,drvERorAssociationorUnion = CASE WHEN bdmrectype = 'EMP' THEN 'United States Olympic Committee'  END
        ,drvBenefitEligibilityDate = eecdateoflasthire
        ,drvMemberId =  eecempno
    INTO dbo.U_EASTUSOEXP_Person
    FROM dbo.U_EASTUSOEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK) 
        ON EecEEID = xEEID 
        AND EecCOID = xCOID 
    JOIN dbo.U_dsi_BDM_EASTUSOEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON ConEEID = xEEID 
        AND ConSystemID = BdmDepRecID;
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EASTUSOEXP_drvTblCancer
    ---------------------------------
    IF OBJECT_ID('U_EASTUSOEXP_drvTblCancer','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUSOEXP_drvTblCancer;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmdeprecid --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2' + eepssn
        ,drvSubSort = bdmdeprecid
        -- standard fields above and additional driver fields below
        ,drvRecordType = '13'
        ,drvApplicationID = eepSSN
        ,drvCoverageTier = CASE WHEN bdmbenoption in ('EE','ATH') THEN '1'
                                WHEN bdmbenoption in ('EES', 'EEDP', 'ATHS', 'EEC', 'EECH', 'ATHC', 'EEF', 'EEDPF', 'ATHF') THEN '2'
                           END
        ,drvSection125 = 'Y'
        ,drvTotalModePremium = CAST(bcaeeamt as varchar)
        ,drvBasePlanUnits = '100'
        ,drvRider1 = 'HOSP'
        ,drvRider1UnitsAmt = '200'
        ,drvRider2 = 'RAD'
        ,drvRider2UnitsAmt = '200'
        ,drvRider3 = 'SURG'
        ,drvRider3UnitsAmt = '100'
        ,drvRider4 = 'MISC'
        ,drvRider4UnitsAmt = '100'
        ,drvRider5 = 'CID'
        ,drvRider5UnitsAmt = '300'
        ,drvRider6 = 'CS'
        ,drvRider6UnitsAmt = '200'
        ,drvPremiumBillingMode = '26'
        ,drvDateofFirstDeduction = bdmbenstartdate
        ,drvRequestedCoverageEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, CAST('01/01/2020' as datetime))
        ,drvCaseNumber = '32810'
        ,drvStatusCode = CASE WHEN eecemplStatus = 'T' THEN 'T'
                               WHEN eecemplStatus = 'A'  and bdmbenstatus <> 'A' THEN 'X'
                         END
        ,drvRequestedCoverageEndDate = bdmbenstopdate
        ,drvSignedCityandState = 'Colorado Springs CO'
        ,drvDatesignedbyEmployee = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, CAST('01/01/2020' as datetime))
    INTO dbo.U_EASTUSOEXP_drvTblCancer
    FROM dbo.U_EASTUSOEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        JOIN dbo.EmpComp WITH (NOLOCK) 
        ON EecEEID = xEEID 
        AND EecCOID = xCOID 
    JOIN dbo.U_dsi_BDM_EASTUSOEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and bdmdedcode = 'CANCR'
    JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
        on bcaeeid =  xeeid
        and bcadedcode = bdmdedcode
        and bcadedcode = 'CANCR'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EASTUSOEXP_Accident
    ---------------------------------
    IF OBJECT_ID('U_EASTUSOEXP_Accident','U') IS NOT NULL
        DROP TABLE dbo.U_EASTUSOEXP_Accident;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = bdmdeprecid --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2' + eepSSN
        ,drvSubSort = bdmdeprecid
        -- standard fields above and additional driver fields below
        ,drvRecordType = '38'
        ,drvApplicationID = eepSSN
        ,drvCoverageTier = CASE WHEN bdmbenoption in ('EE','ATH') THEN '1'
                                WHEN bdmbenoption in ('EES', 'EEDP', 'ATHS')  THEN '2'
                                WHEN bdmbenoption in ('EEC', 'EECH', 'ATHC') THEN '3'
                                WHEN  bdmbenoption in ('EEF', 'EEDPF', 'ATHF') THEN '4'
                           END
        ,drvSection125 = 'Y'
        ,drvTotalModePremium = CAST(bcaeeamt as varchar)
        ,drvBasePlanUnits = '200'
        ,drvRider1 = 'GP6AUC'
        ,drvRider1UnitsAmt = '300'
        ,drvRider2 = 'GP6ERS'
        ,drvRider2UnitsAmt = '300'
        ,drvRider3 = 'GP6DF'
        ,drvRider3UnitsAmt = '300'
        ,drvRider4 = 'GP6BE'
        ,drvRider4UnitsAmt = '200'
        ,drvRider5 = 'GP6OPT'
        ,drvRider5UnitsAmt = '200'
        ,drvRider6 = ''
        ,drvRider6UnitsAmt = ''
        ,drvPremiumBillingMode = '26'
        ,drvDateofFirstDeduction = bdmbenstartdate
        ,drvRequestedCoverageEffDate =  dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, CAST('01/01/2020' as datetime))
        ,drvCaseNumber = '32810'
        ,drvStatusCode = CASE WHEN eecemplStatus = 'T' THEN 'T'
                               WHEN eecemplStatus = 'A'  and bdmbenstatus <> 'A' THEN 'X'
                         END
        ,drvRequestedCoverageEndDate = bdmbenstopdate
        ,drvSignedCityandState = 'Colorado Springs CO'
        ,drvDatesignedbyEmployee =  dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, CAST('01/01/2020' as datetime))
    INTO dbo.U_EASTUSOEXP_Accident
    FROM dbo.U_EASTUSOEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK) 
    ON EecEEID = xEEID 
    AND EecCOID = xCOID 
    JOIN dbo.U_dsi_BDM_EASTUSOEXP WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and bdmdedcode = 'ACCDT'
    JOIN dbo.u_dsi_bdm_BenCalculationAmounts WITH (NOLOCK)
        on bcaeeid =  xeeid
        and bcadedcode = bdmdedcode
        and bcadedcode = 'CANCR'
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEASTUSOEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASTUSOEXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort, Right(Recordset,2) ;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASTUSOEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202009251'
       ,expStartPerControl     = '202009251'
       ,expLastEndPerControl   = '202010029'
       ,expEndPerControl       = '202010029'
WHERE expFormatCode = 'EASTUSOEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASTUSOEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASTUSOEXP_File (NOLOCK)
    ORDER BY InitialSort, SubSort, Right(Recordset,2) ;