SET NOCOUNT ON;
IF OBJECT_ID('U_EALLSTACCI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EALLSTACCI_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EALLSTACCI' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEALLSTACCI_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEALLSTACCI_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EALLSTACCI') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALLSTACCI];
GO
IF OBJECT_ID('U_EALLSTACCI_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_PEarHist];
GO
IF OBJECT_ID('U_EALLSTACCI_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_PDedHist];
GO
IF OBJECT_ID('U_EALLSTACCI_OptTable') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_OptTable];
GO
IF OBJECT_ID('U_EALLSTACCI_InsRate') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_InsRate];
GO
IF OBJECT_ID('U_EALLSTACCI_File') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_File];
GO
IF OBJECT_ID('U_EALLSTACCI_EEList') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_EEList];
GO
IF OBJECT_ID('U_EALLSTACCI_drvTbl_55') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_drvTbl_55];
GO
IF OBJECT_ID('U_EALLSTACCI_drvTbl_40') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_drvTbl_40];
GO
IF OBJECT_ID('U_EALLSTACCI_drvTbl_38') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_drvTbl_38];
GO
IF OBJECT_ID('U_EALLSTACCI_drvTbl_15_or_29') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_drvTbl_15_or_29];
GO
IF OBJECT_ID('U_EALLSTACCI_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_drvTbl_01];
GO
IF OBJECT_ID('U_EALLSTACCI_DedList') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EALLSTACCI') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EALLSTACCI];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EALLSTACCI';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EALLSTACCI';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EALLSTACCI';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EALLSTACCI';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EALLSTACCI';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EALLSTACCI','Allstate ACC CI HOSP Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EALLSTACCIZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','1','(''DA''=''F'')','EALLSTACCIZ0','2','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EALLSTACCIZ0','9','D','10','3',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','12',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsPeopInsur"','4','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','27',NULL,'Is Proposed Insured',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsEmployee"','5','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','28',NULL,'Is Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsPolicyOwner"','6','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','29',NULL,'Is Policy Owner',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsDependent"','7','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','30',NULL,'Is Dependent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IsBeneficiary"','8','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','31',NULL,'Is Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EALLSTACCIZ0','1','D','10','32',NULL,'Beneficiary Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EALLSTACCIZ0','5','D','10','33',NULL,'Beneficiary Percentage',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','11','(''UA''=''F'')','EALLSTACCIZ0','2','D','10','38',NULL,'Relationship To Primary Insured',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationToEE"','12','(''UA''=''F'')','EALLSTACCIZ0','2','D','10','40',NULL,'Relationship To Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','13','(''UA''=''F'')','EALLSTACCIZ0','35','D','10','42',NULL,'Last Name or Name of Trust Estate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','14','(''UA''=''F'')','EALLSTACCIZ0','35','D','10','77',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddleInit"','15','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','112',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPerSSN"','16','(''UA''=''F'')','EALLSTACCIZ0','9','D','10','113',NULL,'Person SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','122',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','18','(''UD112''=''F'')','EALLSTACCIZ0','8','D','10','123',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','19','(''UA''=''F'')','EALLSTACCIZ0','15','D','10','131',NULL,'Home Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EALLSTACCIZ0','1','D','10','146',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EALLSTACCIZ0','3','D','10','147',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EALLSTACCIZ0','3','D','10','150',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressFull"','23','(''UA''=''F'')','EALLSTACCIZ0','71','D','10','153',NULL,'Full Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','24','(''UA''=''F'')','EALLSTACCIZ0','20','D','10','224',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','25','(''UA''=''F'')','EALLSTACCIZ0','2','D','10','244',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZip"','26','(''UA''=''F'')','EALLSTACCIZ0','9','D','10','246',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccocOrUnion"','27','(''UA''=''F'')','EALLSTACCIZ0','35','D','10','255',NULL,'Employer or Association or Union',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEligDate"','28','(''UD112''=''F'')','EALLSTACCIZ0','8','D','10','290',NULL,'Benefit Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EALLSTACCIZ0','8','D','10','298',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EALLSTACCIZ0','25','D','10','306',NULL,'Plant or Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActiveAtWork"','31','(''UA''=''F'')','EALLSTACCIZ0','1','D','10','331',NULL,'Active at Work',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','EALLSTACCIZ0','75','D','10','332',NULL,'Reason for not active at work',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','EALLSTACCIZ0','10','D','10','407',NULL,'Employee or Member ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','EALLSTACCIZ0','8','D','10','417',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EALLSTACCIZ0','35','D','10','425',NULL,'Occupation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''DA''=''F'')','EALLSTACCIZ0','35','D','10','460',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','37','(''UA''=''F'')','EALLSTACCIZ0','45','D','10','495',NULL,'Employee Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EALLSTACCIZ0','100','D','10','540',NULL,'Remarks',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','640',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','655',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','670',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','685',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','700',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','715',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','730',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','745',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','760',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EALLSTACCIZ0','15','D','10','775',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EALLSTACCIZ0','36','D','10','790',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EALLSTACCIZ0','1','D','10','826',NULL,'IsSecondaryContact',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"38"','1','(''DA''=''F'')','EALLSTACCIZ0','2','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EALLSTACCIZ0','9','D','20','3',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','3','(''UA''=''F'')','EALLSTACCIZ0','1','D','20','12',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSection125"','4','(''UA''=''F'')','EALLSTACCIZ0','1','D','20','13',NULL,'Section 125',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalModePrem"','5','(''UA''=''F'')','EALLSTACCIZ0','6','D','20','14',NULL,'Total Mode Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasePlanUnit"','6','(''UA''=''F'')','EALLSTACCIZ0','3','D','20','20',NULL,'Base Plan Units',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1"','7','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','23',NULL,'Rider1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1UnitAmt"','8','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','33',NULL,'Rider1 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2"','9','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','43',NULL,'Rider2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2UnitAmt"','10','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','53',NULL,'Rider2 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3"','11','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','63',NULL,'Rider3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3UnitAmt"','12','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','73',NULL,'Rider3 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4"','13','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','83',NULL,'Rider4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4UnitAmt"','14','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','93',NULL,'Rider4 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5"','15','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','103',NULL,'Rider5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5UnitAmt"','16','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','113',NULL,'Rider5 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6"','17','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','123',NULL,'Rider6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6UnitAmt"','18','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','133',NULL,'Rider6 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','143',NULL,'Rider7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','153',NULL,'Rider7 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','163',NULL,'Rider8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','173',NULL,'Rider8 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','183',NULL,'Rider9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','193',NULL,'Rider9 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','203',NULL,'Rider10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','213',NULL,'Rider10 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','223',NULL,'Rider11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','233',NULL,'Rider11 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','243',NULL,'Rider12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','253',NULL,'Rider12 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"12"','31','(''DA''=''F'')','EALLSTACCIZ0','2','D','20','263',NULL,'Premium Billing Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate1stDed"','32','(''UD112''=''F'')','EALLSTACCIZ0','8','D','20','265',NULL,'Date of First Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReqCovEffDate"','33','(''UD112''=''F'')','EALLSTACCIZ0','8','D','20','273',NULL,'Requested Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaseNumber"','34','(''UA''=''F'')','EALLSTACCIZ0','10','D','20','281',NULL,'Case Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode"','35','(''UA''=''F'')','EALLSTACCIZ0','1','D','20','291',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReqCovEndDate"','36','(''UD112''=''F'')','EALLSTACCIZ0','8','D','20','292',NULL,'Requested Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignedCityState"','37','(''UA''=''F'')','EALLSTACCIZ0','100','D','20','300',NULL,'Signed City and State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignedByEmpl"','38','(''UD112''=''F'')','EALLSTACCIZ0','8','D','20','400',NULL,'Date signed by Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EALLSTACCIZ0','35','D','20','408',NULL,'Producer''s name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','443',NULL,'Servicing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EALLSTACCIZ0','5','D','20','453',NULL,'Servicing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','458',NULL,'Writing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EALLSTACCIZ0','5','D','20','468',NULL,'Writing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','473',NULL,'Other Agent1 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EALLSTACCIZ0','5','D','20','483',NULL,'Other Agent1 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','488',NULL,'Other Agent2 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EALLSTACCIZ0','5','D','20','498',NULL,'Other Agent2 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','503',NULL,'Other Agent3 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EALLSTACCIZ0','5','D','20','513',NULL,'Other Agent3 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','518',NULL,'Other Agent4 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EALLSTACCIZ0','5','D','20','528',NULL,'Other Agent4 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EALLSTACCIZ0','10','D','20','533',NULL,'Other Agent5 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EALLSTACCIZ0','5','D','20','543',NULL,'Other Agent5 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EALLSTACCIZ0','3','D','20','548',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EALLSTACCIZ0','1','D','20','551',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EALLSTACCIZ0','25','D','20','552',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','EALLSTACCIZ0','6','D','20','577',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EALLSTACCIZ0','4','D','20','583',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"40"','1','(''DA''=''F'')','EALLSTACCIZ0','2','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EALLSTACCIZ0','9','D','30','3',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','3','(''UA''=''F'')','EALLSTACCIZ0','1','D','30','12',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSection125"','4','(''UA''=''F'')','EALLSTACCIZ0','1','D','30','13',NULL,'Section 125',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicBenAmt"','5','(''UA''=''F'')','EALLSTACCIZ0','8','D','30','14',NULL,'Basic Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalModePrem"','6','(''UA''=''F'')','EALLSTACCIZ0','6','D','30','22',NULL,'Total Mode Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1"','7','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','28',NULL,'Rider1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider1UnitAmt"','8','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','38',NULL,'Rider1 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2"','9','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','48',NULL,'Rider2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider2UnitAmt"','10','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','58',NULL,'Rider2 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3"','11','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','68',NULL,'Rider3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider3UnitAmt"','12','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','78',NULL,'Rider3 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4"','13','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','88',NULL,'Rider4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider4UnitAmt"','14','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','98',NULL,'Rider4 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5"','15','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','108',NULL,'Rider5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider5UnitAmt"','16','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','118',NULL,'Rider5 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6"','17','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','128',NULL,'Rider6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRider6UnitAmt"','18','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','138',NULL,'Rider6 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','148',NULL,'Rider7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','158',NULL,'Rider7 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','168',NULL,'Rider8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','22','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','178',NULL,'Rider8 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','188',NULL,'Rider9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','198',NULL,'Rider9 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','208',NULL,'Rider10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','218',NULL,'Rider10 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','228',NULL,'Rider11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','28','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','238',NULL,'Rider11 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','248',NULL,'Rider12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','258',NULL,'Rider12 UnitsAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreimBillMode"','31','(''UA''=''F'')','EALLSTACCIZ0','2','D','30','268',NULL,'Premium Billing Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate1stDed"','32','(''UD112''=''F'')','EALLSTACCIZ0','8','D','30','270',NULL,'Date of First Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReqCovEffDate"','33','(''UD112''=''F'')','EALLSTACCIZ0','8','D','30','278',NULL,'Requested Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaseNumber"','34','(''UA''=''F'')','EALLSTACCIZ0','10','D','30','286',NULL,'Case Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','296',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode"','36','(''UA''=''F'')','EALLSTACCIZ0','1','D','30','306',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignedCityState"','37','(''UA''=''F'')','EALLSTACCIZ0','100','D','30','307',NULL,'Signed City and State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSignedByEmpl"','38','(''UD112''=''F'')','EALLSTACCIZ0','8','D','30','407',NULL,'Date signed by Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EALLSTACCIZ0','35','D','30','415',NULL,'Producer''s name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','450',NULL,'Servicing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EALLSTACCIZ0','5','D','30','460',NULL,'Servicing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','465',NULL,'Writing Agent Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EALLSTACCIZ0','5','D','30','475',NULL,'Writing Agent Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','480',NULL,'Other Agent1 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''F'')','EALLSTACCIZ0','5','D','30','490',NULL,'Other Agent1 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','495',NULL,'Other Agent2 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EALLSTACCIZ0','5','D','30','505',NULL,'Other Agent2 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','510',NULL,'Other Agent3 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EALLSTACCIZ0','5','D','30','520',NULL,'Other Agent3 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','525',NULL,'Other Agent4 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EALLSTACCIZ0','5','D','30','535',NULL,'Other Agent4 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EALLSTACCIZ0','10','D','30','540',NULL,'Other Agent5 Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EALLSTACCIZ0','5','D','30','550',NULL,'Other Agent5 Split',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReqCovEndDate"','54','(''UD112''=''F'')','EALLSTACCIZ0','8','D','30','555',NULL,'Requested Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"55"','1','(''DA''=''F'')','EALLSTACCIZ0','2','D','40','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EALLSTACCIZ0','9','D','40','3',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','3','(''UA''=''F'')','EALLSTACCIZ0','1','D','40','12',NULL,'Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSection125"','4','(''UA''=''F'')','EALLSTACCIZ0','1','D','40','13',NULL,'Section 125',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductTypeName"','5','(''UA''=''F'')','EALLSTACCIZ0','35','D','40','14',NULL,'Product Type/Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanDesignation"','6','(''UA''=''F'')','EALLSTACCIZ0','35','D','40','49',NULL,'Plan Designation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate1stDed"','7','(''UD112''=''F'')','EALLSTACCIZ0','8','D','40','84',NULL,'Date of First Deduction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReqCovEffDate"','8','(''UD112''=''F'')','EALLSTACCIZ0','8','D','40','92',NULL,'Requested Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber"','9','(''UA''=''F'')','EALLSTACCIZ0','10','D','40','100',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountBilling"','10','(''UA''=''F'')','EALLSTACCIZ0','5','D','40','110',NULL,'Account (Billing)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusCode"','11','(''UA''=''F'')','EALLSTACCIZ0','1','D','40','115',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationBilling"','12','(''UA''=''F'')','EALLSTACCIZ0','10','D','40','116',NULL,'Location (Billing)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocEffDate"','13','(''UD112''=''F'')','EALLSTACCIZ0','8','D','40','126',NULL,'Location Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplPaid100pct"','14','(''UA''=''F'')','EALLSTACCIZ0','1','D','40','134',NULL,'Employer Paid 100%',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenfitFaceAmt"','15','(''UA''=''F'')','EALLSTACCIZ0','9','D','40','135',NULL,'Benefit/Face Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReqCovEndDate"','16','(''UD112''=''F'')','EALLSTACCIZ0','8','D','40','144',NULL,'Requested Coverage End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EALLSTACCIZ0','2','D','40','152',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalModePrem"','18','(''UA''=''F'')','EALLSTACCIZ0','6','D','40','154',NULL,'Total Mode Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreimBillMode"','19','(''UA''=''F'')','EALLSTACCIZ0','2','D','40','160',NULL,'Premium Billing Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','EALLSTACCIZ0','2','D','50','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','EALLSTACCIZ0','9','D','50','3',NULL,'Application ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQuestion"','3','(''UA''=''F'')','EALLSTACCIZ0','5','D','50','12',NULL,'Question',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResponse"','4','(''UA''=''F'')','EALLSTACCIZ0','1','D','50','17',NULL,'Response',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''F'')','EALLSTACCIZ0','70','D','50','18',NULL,'Person or Carrier Name/Details',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''F'')','EALLSTACCIZ0','70','D','50','88',NULL,'Details/Policy Number/Disease or Injury',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''DA''=''F'')','EALLSTACCIZ0','20','D','50','158',NULL,'Date and/or Duration',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EALLSTACCIZ0','70','D','50','178',NULL,'Name/Results',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','EALLSTACCIZ0','110','D','50','248',NULL,'Name/Address',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALLSTACCI_20200413.txt',NULL,'','',NULL,NULL,NULL,NULL,'Allstate ACC CI HOSP Export','202003139','EMPEXPORT','ONDEMAND',NULL,'EALLSTACCI',NULL,NULL,NULL,'202003139','Feb  7 2020  8:51AM','Feb  7 2020  8:51AM','202001311',NULL,'','','202001311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALLSTACCI_20200413.txt',NULL,NULL,NULL,',PJAB9,PJBW6,PJA2Z,PJC0T,PJBUE,3MY3M,PJB2F,PJAU5,PJ9ZY,PJAQR,PJA9N,PJAKE,PJAZN,PJBNQ,PJBAC,PJAE3,PJBL0,PJAW6,PJB62,PJAGS,PJBXO,PJBZT',NULL,NULL,NULL,'Allstate ACC CI HOSP-Wed 7am','202003139','EMPEXPORT','SCHEDULED',NULL,'EALLSTACCI',NULL,NULL,NULL,'202003139','Feb  7 2020  8:51AM','Feb  7 2020  8:51AM','202001311',NULL,'','','202001311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALLSTACCI_20200413.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202003139','EMPEXPORT','OEACTIVE',NULL,'EALLSTACCI',NULL,NULL,NULL,'202003139','Feb  7 2020  8:51AM','Feb  7 2020  8:51AM','202001311',NULL,'','','202001311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALLSTACCI_20200413.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202003139','EMPEXPORT','OEPASSIVE',NULL,'EALLSTACCI',NULL,NULL,NULL,'202003139','Feb  7 2020  8:51AM','Feb  7 2020  8:51AM','202001311',NULL,'','','202001311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EALLSTACCI_20200413.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003139','EMPEXPORT','TEST','Apr  8 2020  8:23AM','EALLSTACCI',NULL,NULL,NULL,'202003139','Apr  8 2020 12:00AM','Dec 30 1899 12:00AM','202001311','884','','','202001311',dbo.fn_GetTimedKey(),NULL,'us3lKiYOU1007',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EALLSTACCI_20200413.txt' END WHERE expFormatCode = 'EALLSTACCI';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','InitialSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','SubSort2','C','drvSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','SubSort3','C','drvSort4');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EALLSTACCI','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EALLSTACCI' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EALLSTACCI' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EALLSTACCI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EALLSTACCI_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALLSTACCI','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALLSTACCI','D10','dbo.U_EALLSTACCI_drvTbl_01',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALLSTACCI','D20','dbo.U_EALLSTACCI_drvTbl_38',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALLSTACCI','D30','dbo.U_EALLSTACCI_drvTbl_40',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALLSTACCI','D40','dbo.U_EALLSTACCI_drvTbl_55',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EALLSTACCI','D50','dbo.U_EALLSTACCI_drvTbl_15_or_29',NULL);
IF OBJECT_ID('U_dsi_BDM_EALLSTACCI') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EALLSTACCI] (
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
IF OBJECT_ID('U_EALLSTACCI_DedList') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EALLSTACCI_drvTbl_01') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_drvTbl_01] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvIsPeopInsur] varchar(1) NOT NULL,
    [drvIsEmployee] varchar(1) NOT NULL,
    [drvIsPolicyOwner] varchar(1) NOT NULL,
    [drvIsDependent] varchar(1) NOT NULL,
    [IsBeneficiary] varchar(1) NOT NULL,
    [drvRelationship] varchar(2) NULL,
    [drvRelationToEE] varchar(2) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddleInit] varchar(1) NULL,
    [drvPerSSN] char(11) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvAddressFull] varchar(511) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZip] varchar(50) NULL,
    [drvAccocOrUnion] varchar(22) NULL,
    [drvBenEligDate] datetime NULL,
    [drvActiveAtWork] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL
);
IF OBJECT_ID('U_EALLSTACCI_drvTbl_15_or_29') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_drvTbl_15_or_29] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvRecordType] varchar(2) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvQuestion] varchar(3) NOT NULL,
    [drvResponse] varchar(1) NULL
);
IF OBJECT_ID('U_EALLSTACCI_drvTbl_38') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_drvTbl_38] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvSection125] varchar(1) NOT NULL,
    [drvTotalModePrem] nvarchar(4000) NULL,
    [drvBasePlanUnit] varchar(3) NOT NULL,
    [drvRider1] varchar(6) NOT NULL,
    [drvRider1UnitAmt] varchar(3) NOT NULL,
    [drvRider2] varchar(6) NOT NULL,
    [drvRider2UnitAmt] varchar(3) NOT NULL,
    [drvRider3] varchar(6) NOT NULL,
    [drvRider3UnitAmt] varchar(3) NOT NULL,
    [drvRider4] varchar(5) NOT NULL,
    [drvRider4UnitAmt] varchar(3) NOT NULL,
    [drvRider5] varchar(5) NOT NULL,
    [drvRider5UnitAmt] varchar(3) NOT NULL,
    [drvRider6] varchar(6) NOT NULL,
    [drvRider6UnitAmt] varchar(3) NOT NULL,
    [drvDate1stDed] datetime NULL,
    [drvReqCovEffDate] datetime NULL,
    [drvCaseNumber] varchar(5) NOT NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvReqCovEndDate] datetime NULL,
    [drvSignedCityState] varchar(9) NOT NULL,
    [drvSignedByEmpl] datetime NULL
);
IF OBJECT_ID('U_EALLSTACCI_drvTbl_40') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_drvTbl_40] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(67) NULL,
    [drvSort4] int NULL,
    [drvSSN] char(11) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvSection125] varchar(1) NOT NULL,
    [drvBasicBenAmt] varchar(5) NULL,
    [drvTotalModePrem] nvarchar(4000) NULL,
    [drvRider1] varchar(5) NOT NULL,
    [drvRider1UnitAmt] varchar(1) NOT NULL,
    [drvRider2] varchar(6) NOT NULL,
    [drvRider2UnitAmt] varchar(1) NOT NULL,
    [drvRider3] varchar(6) NOT NULL,
    [drvRider3UnitAmt] varchar(1) NOT NULL,
    [drvRider4] varchar(8) NOT NULL,
    [drvRider4UnitAmt] varchar(1) NOT NULL,
    [drvRider5] varchar(8) NOT NULL,
    [drvRider5UnitAmt] varchar(3) NULL,
    [drvRider6] varchar(8) NOT NULL,
    [drvRider6UnitAmt] varchar(3) NOT NULL,
    [drvPreimBillMode] varchar(2) NOT NULL,
    [drvDate1stDed] datetime NULL,
    [drvReqCovEffDate] datetime NULL,
    [drvCaseNumber] varchar(5) NOT NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvSignedCityState] varchar(9) NOT NULL,
    [drvSignedByEmpl] datetime NULL,
    [drvReqCovEndDate] datetime NULL
);
IF OBJECT_ID('U_EALLSTACCI_drvTbl_55') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_drvTbl_55] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] char(12) NULL,
    [drvSort2] int NOT NULL,
    [drvSort3] varchar(1) NOT NULL,
    [drvSort4] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvCoverageLevel] varchar(1) NULL,
    [drvSection125] varchar(1) NOT NULL,
    [drvProductTypeName] varchar(4) NOT NULL,
    [drvPlanDesignation] varchar(3) NOT NULL,
    [drvDate1stDed] datetime NULL,
    [drvReqCovEffDate] datetime NULL,
    [drvGroupNumber] varchar(5) NOT NULL,
    [drvAccountBilling] varchar(1) NOT NULL,
    [drvStatusCode] varchar(1) NULL,
    [drvLocationBilling] varchar(1) NOT NULL,
    [drvLocEffDate] datetime NULL,
    [drvEmplPaid100pct] varchar(1) NOT NULL,
    [drvBenfitFaceAmt] varchar(1) NOT NULL,
    [drvReqCovEndDate] datetime NULL,
    [drvTotalModePrem] nvarchar(4000) NULL,
    [drvPreimBillMode] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EALLSTACCI_EEList') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EALLSTACCI_File') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EALLSTACCI_InsRate') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_InsRate] (
    [RatDedCode] char(5) NOT NULL,
    [RatMinAge] decimal NOT NULL,
    [RatMaxAge] decimal NULL,
    [RatEERateNSFemale] money NULL,
    [RatEERateSMFemale] money NULL,
    [RatEERateNSmale] money NULL,
    [RatEERateSMmale] money NULL
);
IF OBJECT_ID('U_EALLSTACCI_OptTable') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_OptTable] (
    [CorDedCode] char(5) NOT NULL,
    [CorBenOption] char(6) NOT NULL,
    [CorEERate] money NULL
);
IF OBJECT_ID('U_EALLSTACCI_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_PDedHist] (
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
IF OBJECT_ID('U_EALLSTACCI_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EALLSTACCI_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EALLSTACCI]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Young Automotive

Created By: James Bender
Business Analyst: Lea King
Create Date: 02/07/2020
Service Request Number: TekP-2019-10-24-0003

Purpose: Allstate ACC CI HOSP Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EALLSTACCI';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EALLSTACCI';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EALLSTACCI';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EALLSTACCI';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EALLSTACCI' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALLSTACCI', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALLSTACCI', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EALLSTACCI', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EALLSTACCI';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EALLSTACCI', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EALLSTACCI';
    SELECT @FileMinCovDate = '1/1/2020';

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
    DELETE FROM dbo.U_EALLSTACCI_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EALLSTACCI_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACC2,CEC10,CEC20,CIE10,CIE20,CIF10,CIF20,HOS2';

    IF OBJECT_ID('U_EALLSTACCI_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EALLSTACCI_DedList
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EALLSTACCI_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_PDedHist;
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
    INTO dbo.U_EALLSTACCI_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EALLSTACCI_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EALLSTACCI_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_PEarHist;
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
    INTO dbo.U_EALLSTACCI_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    -- Temp Tables for coverage rates

    IF OBJECT_ID('U_EALLSTACCI_OptTable', 'U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_OptTable;
    SELECT CorDedCode, CorBenOption, CorEERate 
    INTO dbo.U_EALLSTACCI_OptTable
    FROM dbo.OptRate WITH (NOLOCK)
    WHERE CorDedCode IN ('ACC2', 'HOS2')


    IF OBJECT_ID('U_EALLSTACCI_InsRate', 'U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_InsRate;
    SELECT RatDedCode, RatMinAge, (RatMaxAge-1) AS RatMaxAge, RatEERateNSFemale, RatEERateSMFemale, RatEERateNSmale, RatEERateSMmale 
    INTO dbo.U_EALLSTACCI_InsRate 
    FROM InsRate 
    WHERE RatDedCode IN ('CEC10','CEC20','CIE10','CIE20','CIF10','CIF20')

    Update dbo.U_EALLSTACCI_InsRate
    SET RatEERateNSFemale = RatEERateNSFemale * 2
        ,RatEERateSMFemale = RatEERateSMFemale* 2
        ,RatEERateNSMale = RatEERateNSMale * 2
        ,RatEERateSMmale = RatEERateSMmale * 2        
    WHERE RatDedCode IN ('CEC20','CIE20','CIF20')


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EALLSTACCI_drvTbl_01
    ---------------------------------
    IF OBJECT_ID('U_EALLSTACCI_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_drvTbl_01;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 1
        ,drvSort3 = ''
        ,drvSort4 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvIsPeopInsur = CASE WHEN BdmRecType = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvIsEmployee = CASE WHEN BdmRecType = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvIsPolicyOwner = CASE WHEN BdmRecType = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvIsDependent = CASE WHEN BdmRecType = 'EMP' THEN 'N' ELSE 'Y' END
        ,IsBeneficiary = 'N' --ConIsBeneficiary
        ,drvRelationship =    CASE WHEN BdmRecType = 'EMP' THEN  '14'
                                ELSE
                                    CASE WHEN ConRelationship = 'SPS' THEN '12'
                                        WHEN ConRelationship IN ('STC', 'CHL', 'DD', 'DPC') THEN '17'
                                        WHEN ConRelationship = 'DP' THEN '35'
                                    END
                            END
        ,drvRelationToEE =    CASE WHEN BdmRecType = 'EMP' THEN  '14'
                                ELSE
                                    CASE WHEN ConRelationship = 'SPS' THEN '12'
                                        WHEN ConRelationship IN ('STC', 'CHL', 'DD', 'DPC') THEN '17'
                                        WHEN ConRelationship = 'DP' THEN '35'
                                    END
                            END
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddleInit = CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle, 1) END
        ,drvPerSSN = CASE WHEN BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvGender = CASE WHEN BdmRecType = 'EMP' THEN EepGender ELSE ConGender END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvAddressFull = ISNULL(EepAddressLine1, '') + ' ' + ISNULL(EepAddressLine2, '')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZip = EepAddressZipCode
        ,drvAccocOrUnion = CASE WHEN BdmRecType = 'EMP' THEN 'Young Automotive Group' END
        ,drvBenEligDate = EecDateOfLastHire
        ,drvActiveAtWork = 'Y' --CASE WHEN BdmRecType = 'EMP' THEN 'Y' ELSE 'N' END
        ,drvEmailAddress = EepAddressEMail
    INTO dbo.U_EALLSTACCI_drvTbl_01
    FROM dbo.U_EALLSTACCI_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EALLSTACCI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON xEEID = ConEEID 
        AND ConSystemID = BdmDepRecId
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EALLSTACCI_drvTbl_38
    ---------------------------------
    IF OBJECT_ID('U_EALLSTACCI_drvTbl_38','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_drvTbl_38;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 2
        ,drvSort3 = ''
        ,drvSort4 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCoverageTier =    CASE WHEN BdmBenOption = 'EE' THEN '1'
                                WHEN BdmBenOption = 'EECS' THEN '3'
                                WHEN BdmBenOption = 'EEF' THEN '4'
                                WHEN BdmBenOption = 'EES' THEN '2'
                            END
        ,drvSection125 = 'Y'
        --dbo.U_EALLSTACCI_OptTable
        ,drvTotalModePrem =    FORMAT((SELECT CorEERate*200 FROM dbo.U_EALLSTACCI_OptTable WITH (NOLOCK) WHERE CorDedCode = 'ACC2' AND CorBenOption = BdmBenOption), '000000')
        ,drvBasePlanUnit = '200'
        ,drvRider1 = 'GP6AUC'
        ,drvRider1UnitAmt = '150'
        ,drvRider2 = 'GP6ERS'
        ,drvRider2UnitAmt = '150'
        ,drvRider3 = 'GP6OPT'
        ,drvRider3UnitAmt = '150'
        ,drvRider4 = 'GP6DF'
        ,drvRider4UnitAmt = '150'
        ,drvRider5 = 'GP6BE'
        ,drvRider5UnitAmt = '200'
        ,drvRider6 = 'GP6ADD'
        ,drvRider6UnitAmt = '150'
        ,drvDate1stDed = BdmBenStartDate
        ,drvReqCovEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvCaseNumber = '39868'
        ,drvStatusCode =    CASE WHEN EecEmplStatus = 'T' THEN 'T'
                                WHEN EecEmplStatus = 'A' AND BdmBenStatus <> 'A' THEN 'X'
                            END
        ,drvReqCovEndDate = BdmBenStopDate
        ,drvSignedCityState = 'Layton UT'
        ,drvSignedByEmpl = DATEADD(DAY, -1, GETDATE())
    INTO dbo.U_EALLSTACCI_drvTbl_38
    FROM dbo.U_EALLSTACCI_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EALLSTACCI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE BdmDedCode = 'ACC2'
    ;
    ---------------------------------    
    -- DETAIL RECORD - U_EALLSTACCI_drvTbl_40
    ---------------------------------
    IF OBJECT_ID('U_EALLSTACCI_drvTbl_40','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_drvTbl_40;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 3
        ,drvSort3 = BdmDedCode + ' ' + CAST(EepDateOfBirth AS VARCHAR) + ' ' + CAST(BdmBenStartDate AS VARCHAR)
        ,drvSort4 = (SELECT DATEDIFF(MONTH, eepDateOFBirth,
                                             dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
                                             ))/12
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCoverageTier =    CASE WHEN BdmDedCode IN ('CEC10', 'CEC20') THEN '3'
                                WHEN BdmDedCode IN ('CIE10', 'CIE20') THEN '1' 
                                WHEN BdmDedCode IN ('CIF10', 'CIF20') THEN '4' 
                            END
        ,drvSection125 = 'Y'
        ,drvBasicBenAmt =    CASE WHEN BdmDedCode IN ('CEC10', 'CIE10', 'CIF10') THEN '10000'
                                WHEN BdmDedCode IN ('CEC20', 'CIE20', 'CIF20') THEN '20000'
                            END
                            -- dbo.U_EALLSTACCI_InsRate
        ,drvTotalModePrem =  FORMAT((CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN -- JCB
                                    --CAST(
                                    (SELECT TOP 1 RatEERateNsMale FROM dbo.U_EALLSTACCI_InsRate WITH (NOLOCK) WHERE RatDedCode = BdmDedCode AND (SELECT DATEDIFF(MONTH, eepDateOFBirth, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)))/12 BETWEEN RatMinAge AND RatMaxAge) -- AS VARCHAR)
                                WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN
                                    --CAST(
                                    (SELECT TOP 1 RatEERateSmMale FROM dbo.U_EALLSTACCI_InsRate WITH (NOLOCK) WHERE RatDedCode = BdmDedCode AND (SELECT DATEDIFF(MONTH, eepDateOFBirth, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)))/12 BETWEEN RatMinAge AND RatMaxAge) --AS VARCHAR)
                                WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN
                                    --CAST(
                                    (SELECT TOP 1 RatEERateNSFemale FROM dbo.U_EALLSTACCI_InsRate WITH (NOLOCK) WHERE RatDedCode = BdmDedCode AND (SELECT DATEDIFF(MONTH, eepDateOFBirth, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)))/12 BETWEEN RatMinAge AND RatMaxAge) --AS VARCHAR)
                                WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN
                                    --CAST(
                                    (SELECT TOP 1 RatEERateSMFemale FROM dbo.U_EALLSTACCI_InsRate WITH (NOLOCK) WHERE RatDedCode = BdmDedCode AND (SELECT DATEDIFF(MONTH, eepDateOFBirth, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)))/12 BETWEEN RatMinAge AND RatMaxAge)-- AS VARCHAR)
                            END)*2000, '000000')
        ,drvRider1 = 'CICR1'
        ,drvRider1UnitAmt = ''
        ,drvRider2 = 'CIHCR1'
        ,drvRider2UnitAmt = ''
        ,drvRider3 = 'CIHCR2'
        ,drvRider3UnitAmt = ''
        ,drvRider4 = 'GCIP4SR2'
        ,drvRider4UnitAmt = ''
        ,drvRider5 = 'GCIP4FWR'
        ,drvRider5UnitAmt =    CASE WHEN BdmDedCode IN ('CEC10', 'CIE10', 'CIF10') THEN '200'
                                WHEN BdmDedCode IN ('CEC20', 'CIE20', 'CIF20') THEN '200'
                            END
        ,drvRider6 = 'GCIP4SCR'
        ,drvRider6UnitAmt = '100'
        ,drvPreimBillMode = '12'
        ,drvDate1stDed = BdmBenStartDate
        ,drvReqCovEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvCaseNumber = '39868'
        ,drvStatusCode =    CASE WHEN EecEmplStatus = 'T' THEN 'T'
                                WHEN EecEmplStatus = 'A' AND BdmBenStatus <> 'A' THEN 'X'
                            END
        ,drvSignedCityState = 'Layton UT'
        ,drvSignedByEmpl = DATEADD(DAY, -1, GETDATE())
        ,drvReqCovEndDate = BdmBenStopDate
    INTO dbo.U_EALLSTACCI_drvTbl_40
    FROM dbo.U_EALLSTACCI_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EALLSTACCI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE BdmDedCode IN ('CEC10', 'CIE10', 'CIF10', 'CEC20', 'CIE20', 'CIF20')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EALLSTACCI_drvTbl_55
    ---------------------------------
    IF OBJECT_ID('U_EALLSTACCI_drvTbl_55','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_drvTbl_55;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 4
        ,drvSort3 = ''
        ,drvSort4 = ''
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCoverageLevel =    CASE WHEN BdmBenOption = 'EE' THEN '1'
                                WHEN BdmBenOption = 'EECS' THEN '3'
                                WHEN BdmBenOption = 'EEF' THEN '4'
                                WHEN BdmBenOption = 'EES' THEN '2'
                            END
        ,drvSection125 = 'Y'
        ,drvProductTypeName = 'GIM2'
        ,drvPlanDesignation = 'HSA'
        ,drvDate1stDed = BdmBenStartDate
        ,drvReqCovEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvGroupNumber = '95666'
        ,drvAccountBilling = '1'
        ,drvStatusCode =    CASE WHEN EecEmplStatus = 'T' THEN 'T'
                                WHEN EecEmplStatus = 'A' AND BdmBenStatus <> 'A' THEN 'X'
                            END
        ,drvLocationBilling = '1'
        ,drvLocEffDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        ,drvEmplPaid100pct = 'N'
        ,drvBenfitFaceAmt = '0'
        ,drvReqCovEndDate = BdmBenStopDate        
        ,drvTotalModePrem = FORMAT((SELECT CorEERate*100 FROM dbo.U_EALLSTACCI_OptTable WITH (NOLOCK) WHERE CorDedCode = 'HOS2' AND CorBenOption = BdmBenOption), '000000')
        ,drvPreimBillMode = '24'
    INTO dbo.U_EALLSTACCI_drvTbl_55
    FROM dbo.U_EALLSTACCI_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EALLSTACCI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    WHERE BdmDedCode = 'HOS2'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EALLSTACCI_drvTbl_15_or_29
    ---------------------------------
    IF OBJECT_ID('U_EALLSTACCI_drvTbl_15_or_29','U') IS NOT NULL
        DROP TABLE dbo.U_EALLSTACCI_drvTbl_15_or_29;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = xEEID
        ,drvSort2 = 5
        ,drvSort3 = ''
        ,drvSort4 = ''
        -- standard fields above and additional driver fields below
        ,drvRecordType = CASE WHEN BdmRecType = 'EMP' THEN '15' ELSE '29' END
        ,drvSSN = eepSSN
        ,drvQuestion = CASE WHEN BdmRecType = 'EMP' THEN '214' ELSE '215' END
        ,drvResponse = CASE WHEN BdmRecType = 'EMP' THEN EepIsSmoker ELSE ConIsSmoker END
    INTO dbo.U_EALLSTACCI_drvTbl_15_or_29
    FROM dbo.U_EALLSTACCI_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EALLSTACCI WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
        ON xEEID = ConEEID 
        AND ConSystemID = BdmDepRecId
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
ALTER VIEW dbo.dsi_vwEALLSTACCI_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EALLSTACCI_File (NOLOCK)
    ORDER BY InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EALLSTACCI%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001311'
       ,expStartPerControl     = '202001311'
       ,expLastEndPerControl   = '202003139'
       ,expEndPerControl       = '202003139'
WHERE expFormatCode = 'EALLSTACCI';

**********************************************************************************/
/*go
ALTER VIEW dbo.dsi_vwEALLSTACCI_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EALLSTACCI_File (NOLOCK)
    ORDER BY InitialSort, SubSort;*/
GO
CREATE VIEW dbo.dsi_vwEALLSTACCI_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EALLSTACCI_File (NOLOCK)
    ORDER BY InitialSort, SubSort;