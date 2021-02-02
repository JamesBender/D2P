SET NOCOUNT ON;
IF OBJECT_ID('U_EACCLDMOEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EACCLDMOEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EACCLDMOEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEACCLDMOEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEACCLDMOEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EACCLDMOEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EACCLDMOEX];
GO
IF OBJECT_ID('U_EACCLDMOEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_Trailer];
GO
IF OBJECT_ID('U_EACCLDMOEX_Header') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_Header];
GO
IF OBJECT_ID('U_EACCLDMOEX_File') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_File];
GO
IF OBJECT_ID('U_EACCLDMOEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_EEList];
GO
IF OBJECT_ID('U_EACCLDMOEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_drvTbl];
GO
IF OBJECT_ID('U_EACCLDMOEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EACCLDMOEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EACCLDMOEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EACCLDMOEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EACCLDMOEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EACCLDMOEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EACCLDMOEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EACCLDMOEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EACCLDMOEX','Accolade Demo & Eligibiliy Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EACCLDMOEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EACCLDMOEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NSM"','1','(''DA''=''T|'')','EACCLDMOEXZ0','50','H','01','1',NULL,'Plan Sponsor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NSM"','2','(''DA''=''T|'')','EACCLDMOEXZ0','50','H','01','2',NULL,'Data Partner Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDateAndTime"','3','(''UA''=''T'')','EACCLDMOEXZ0','50','H','01','3',NULL,'Date/Time of Extract',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','1','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','1',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','2','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','2',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','3',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentID"','4','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','4',NULL,'Dependent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','5',NULL,'Alternate Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','6',NULL,'Alternate Dependent ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','8','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','8',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','9','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','9',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','10','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','10',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','11','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','11',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','12','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','12',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipToEmployee"','13','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','13',NULL,'Relationship to Employee',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentSpecialStatus"','14','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','14',NULL,'Dependent Special Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualifiedMedSupportOrder"','15','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','15',NULL,'Qualified Medical Support Order',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','16','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','16',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','17','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','17',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','18','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','18',NULL,'Address City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','19','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','19',NULL,'Address State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','20','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','20',NULL,'Address Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','21','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','21',NULL,'Address Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryPhoneNumber"','22','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','22',NULL,'Primary Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','23',NULL,'Mobile Cell Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress1"','24','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','24',NULL,'Email Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','25',NULL,'Email Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','26','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','26',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeHireDate"','27','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','27',NULL,'Employee Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTerminationDate"','28','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','28',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRegTempIndicator"','29','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','29',NULL,'Reg/Temp Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullPartTimeIndicator"','30','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','30',NULL,'Full-Time / Part-Time Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','31','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','31',NULL,'Benefit Eligibility Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitEligbilityDate"','32','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','32',NULL,'Benefit Eligibility Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','33','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','33',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkLocation"','34','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','34',NULL,'Work Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCode"','35','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','35',NULL,'Job Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobDescription"','36','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','36',NULL,'Job Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','37',NULL,'Union Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','38','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','38',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','39','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','39',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','40','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','40',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','41',NULL,'Status Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','42',NULL,'Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','43',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','44',NULL,'Pay Group',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','45','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','45',NULL,'Company ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','46',NULL,'Directory Key',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitType"','47','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','47',NULL,'Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPlanId"','48','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','48',NULL,'Benefit Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','49','(''UA''=''T|'')','EACCLDMOEXZ0','50','D','10','49',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitCoverageEffDate"','50','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','50',NULL,'Benefit Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitCoverageExpDate"','51','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','51',NULL,'Benefit Coverage Expiration Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPlanYear"','52','(''UD112''=''T|'')','EACCLDMOEXZ0','50','D','10','52',NULL,'Benefit Plan Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','53',NULL,'Coverage Status Modifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','54',NULL,'COBRA Paid Through Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','55',NULL,'COBRA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','56',NULL,'CDF 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','57',NULL,'CDF 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','58',NULL,'CDF 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','59',NULL,'CDF 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','60',NULL,'CDF 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','61',NULL,'CDF 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','62',NULL,'CDF 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','63',NULL,'CDF 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''T|'')','EACCLDMOEXZ0','50','D','10','64',NULL,'CDF 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''T'')','EACCLDMOEXZ0','50','D','10','65',NULL,'CDF 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NSM"','1','(''DA''=''T|'')','EACCLDMOEXZ0','50','T','90','1',NULL,'Plan Sponsor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NSM"','2','(''DA''=''T|'')','EACCLDMOEXZ0','50','T','90','2',NULL,'Data Partner Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDateAndTime"','3','(''UA''=''T|'')','EACCLDMOEXZ0','50','T','90','3',NULL,'Date/Time of Extract',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalNumberOfRecords"','4','(''UA''=''T'')','EACCLDMOEXZ0','50','T','90','4',NULL,'Total Number of Records',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EACCLDMOEX_20210201.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202101019','EMPEXPORT','OEACTIVE','Dec 23 2020  2:09PM','EACCLDMOEX',NULL,NULL,NULL,'202101019','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202101011','7722','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3lKiNAT1046',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202012159','EMPEXPORT','OEPASSIVE',NULL,'EACCLDMOEX',NULL,NULL,NULL,'202012159','Dec 15 2020  2:04PM','Dec 15 2020  2:04PM','202012151',NULL,'','','202012151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Accolade Demo & Eligibiliy Exp','202012159','EMPEXPORT','ONDEM_XOE',NULL,'EACCLDMOEX',NULL,NULL,NULL,'202012159','Dec 15 2020  2:04PM','Dec 15 2020  2:04PM','202012151',NULL,'','','202012151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Accolade Demo & Eligibil-Sched','202012159','EMPEXPORT','SCH_EACCLD',NULL,'EACCLDMOEX',NULL,NULL,NULL,'202012159','Dec 15 2020  2:04PM','Dec 15 2020  2:04PM','202012151',NULL,'','','202012151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Accolade Demo & Eligibil-Test','202101139','EMPEXPORT','TEST_XOE','Jan 13 2021 10:36AM','EACCLDMOEX',NULL,NULL,NULL,'202101139','Jan 13 2021 12:00AM','Dec 30 1899 12:00AM','202101011','8461','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3lKiNAT1046',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EACCLDMOEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EACCLDMOEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EACCLDMOEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EACCLDMOEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EACCLDMOEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACCLDMOEX','H01','dbo.U_EACCLDMOEX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACCLDMOEX','D10','dbo.U_EACCLDMOEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EACCLDMOEX','T90','dbo.U_EACCLDMOEX_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EACCLDMOEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EACCLDMOEX] (
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
IF OBJECT_ID('U_EACCLDMOEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EACCLDMOEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(13) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvSSN] char(11) NULL,
    [drvDependentID] nvarchar(4000) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvMaritalStatus] varchar(2) NOT NULL,
    [drvRelationshipToEmployee] varchar(1) NULL,
    [drvDependentSpecialStatus] varchar(1) NULL,
    [drvQualifiedMedSupportOrder] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvPrimaryPhoneNumber] varchar(50) NULL,
    [drvEmailAddress1] varchar(50) NULL,
    [drvEmployeeStatus] varchar(1) NOT NULL,
    [drvEmployeeHireDate] datetime NULL,
    [drvEmployeeTerminationDate] datetime NULL,
    [drvRegTempIndicator] varchar(1) NOT NULL,
    [drvFullPartTimeIndicator] char(1) NULL,
    [drvBenefitEligbilityDate] datetime NULL,
    [drvDivision] char(5) NULL,
    [drvWorkLocation] char(6) NULL,
    [drvJobCode] char(8) NULL,
    [drvJobDescription] varchar(25) NOT NULL,
    [drvDepartment] varchar(10) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvRehireDate] datetime NULL,
    [drvBenefitType] varchar(1) NULL,
    [drvBenefitPlanId] varchar(40) NULL,
    [drvCoverageTier] varchar(1) NULL,
    [drvBenefitCoverageEffDate] datetime NULL,
    [drvBenefitCoverageExpDate] datetime NULL,
    [drvBenefitPlanYear] int NULL
);
IF OBJECT_ID('U_EACCLDMOEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EACCLDMOEX_File') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EACCLDMOEX_Header') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_Header] (
    [drvCurrentDateAndTime] varchar(17) NULL
);
IF OBJECT_ID('U_EACCLDMOEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_EACCLDMOEX_Trailer] (
    [drvCurrentDateAndTime] varchar(17) NULL,
    [drvTotalNumberOfRecords] int NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EACCLDMOEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: National Seating & Mobility

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/15/2020
Service Request Number: TekP-2020-11-02-0001

Purpose: Accolade Demo & Eligibiliy Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EACCLDMOEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EACCLDMOEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EACCLDMOEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EACCLDMOEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EACCLDMOEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EACCLDMOEX', 'SCH_EACCLD';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EACCLDMOEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EACCLDMOEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EACCLDMOEX';

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
    DELETE FROM dbo.U_EACCLDMOEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EACCLDMOEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EACCLDMOEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE EecDedGroupCode IN ('PTEE')
    )

    DELETE FROM dbo.U_EACCLDMOEX_EEList WHERE xEEID IN ('C1GLT600Z0K0','C7DCV600M0K0','C7HHZS0000K0','C8YWUV0000K0');

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DEN1,DEN2,MED1,MED2,MED3,VIS,MED4,MED5';

    IF OBJECT_ID('U_EACCLDMOEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EACCLDMOEX_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate'); --'AuditDate');

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


    INSERT INTO [dbo].[U_dsi_BDM_EACCLDMOEX]
           ([BdmRecType]
           ,[BdmCOID]
           ,[BdmEEID]
           ,[BdmDepRecID]
           ,[BdmSystemID]
           ,[BdmRunID]
           ,[BdmDedRowStatus]
           ,[BdmRelationship]
           ,[BdmDateOfBirth]
           ,[BdmDedCode]
           ,[BdmBenOption]
           ,[BdmBenStatus]
           ,[BdmBenStartDate]
           ,[BdmBenStopDate]
           ,[BdmBenStatusDate]
           ,[BdmChangeReason]
           ,[BdmStartDate]
           ,[BdmStopDate]
           ,[BdmIsPQB])
    SELECT DISTINCT RecType = 'DEP' 
        ,EecCOID 
        ,EecEEID 
        ,DbnDepRecID
        ,DbnDepRecID
        ,''
        ,'Deduction termed within/after date range'
        ,DbnRelationship
        ,DbnDateOfBirth
        ,DbnDedCode 
        ,EedBenOption
        ,EedBenStatus
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,DbnBenStatusDate
        ,''
        ,DbnBenStartDate
        ,DbnBenStopDate
        ,'N'
    FROM dbo.U_dsi_BDM_DepDeductions 
        JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = DbnEEID
        JOIN dbo.EmpDed ON EedEEID = DbnEEID AND EedDedCode = DbnDedCode
    WHERE DbnBenStartDate = DbnBenStopDate 
        AND DbnBenStartDate BETWEEN @StartDate AND @EndDate
        AND DbnFormatCode = 'EACCLDMOEX'    



    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EACCLDMOEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EACCLDMOEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EepSSN + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeSSN = eepSSN
        ,drvSSN = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN eepSSN ELSE ConSSN END
        ,drvDependentID = CASE WHEN BdmRecType = 'DEP' THEN ISNULL(ConNameLast, '') + ISNULL(FORMAT(ConDateOfBirth, 'MMddyyyy'), '') + ISNULL(RIGHT(RTRIM(ConSSN),4), '') END
        ,drvNameFirst = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvNameMiddle = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1) ELSE LEFT(ConNameMiddle, 1) END
        ,drvNameLast = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvGender = EepGender
        ,drvDateOfBirth = CASE WHEN BdmRecType IS NULL OR BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMaritalStatus = CASE EepMaritalStatus
                                WHEN 'M' THEN '1'
                                WHEN 'S' THEN '2'
                                WHEN 'D' THEN '3'
                                WHEN 'W' THEN '4'
                                ELSE '10'
                            END
        ,drvRelationshipToEmployee =    CASE WHEN BdmRecType = 'DEP' THEN
                                            CASE WHEN ConRelationship = 'SPS' THEN '3'
                                                WHEN ConRelationship = 'DP' THEN '5'
                                                WHEN ConRelationship IN ('CHL','DIS','DPC','LEG','STC') THEN '7'
                                            END
                                        END
        ,drvDependentSpecialStatus = CASE WHEN BdmRecType = 'DEP' AND ConRelationship = 'DIS' AND ConIsDisabled = 'Y' THEN '2' END
        ,drvQualifiedMedSupportOrder = CASE WHEN BdmRecType = 'DEP' AND ConRelationship = 'LEG' THEN 'Y' ELSE 'N' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvPrimaryPhoneNumber = CASE WHEN EepPhoneHomeNumber IS NOT NULL THEN EepPhoneHomeNumber ELSE EfoPhoneNumber END
        ,drvEmailAddress1 = EepAddressEmail
        ,drvEmployeeStatus =    CASE WHEN EecEmplStatus = 'T' AND EdhChangeReason = '210' THEN '2'
                                    WHEN EecEmplStatus = 'T' THEN '7'
                                    WHEN EecEmplStatus = 'L' AND EecLeaveReason <> '300' THEN '3'
                                    WHEN EecEmplStatus = 'L' AND EecLeaveReason = '300' THEN '4'
                                    ELSE '1'
                                END
        ,drvEmployeeHireDate = EecDateOfLastHire
        ,drvEmployeeTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRegTempIndicator = CASE WHEN EecEEType = 'TMP' THEN '0' ELSE '1' END
        ,drvFullPartTimeIndicator = EecFullTimeOrPartTime
        ,drvBenefitEligbilityDate = EecDateOfBenefitSeniority
        ,drvDivision = EecDedGroupCode
        ,drvWorkLocation = EecLocation
        ,drvJobCode = EecJobCode
        ,drvJobDescription = JbcDesc
        ,drvDepartment = EecOrgLvl3
        ,drvWorkState = LocAddressState
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvBenefitType =    CASE WHEN BdmDedCode IN ('MED1','MED2','MED3','MED4','MED5') THEN '1'
                                WHEN BdmDedCode IN ('DEN1','DEN2') THEN '2'
                                WHEN BdmDedCode IN ('VIS') THEN '3'
                            END
        ,drvBenefitPlanId = DedLongDesc
        ,drvCoverageTier =    CASE WHEN BdmBenOption = 'EE' THEN '1'
                                WHEN BdmBenOption IN ('EES','EEDP') THEN '2'
                                WHEN BdmBenOption IN ('EEC') THEN '3'
                                WHEN BdmBenOption IN ('EEF','EEDPF') THEN '4'
                                --ELSE '10'
                            END
        ,drvBenefitCoverageEffDate = BdmBenStartDate
        ,drvBenefitCoverageExpDate = BdmBenStopDate
        ,drvBenefitPlanYear =    CASE WHEN BdmDedCode IN ('MED1','MED2','MED3','MED4','MED5','DEN1','DEN2','VIS') THEN
                                    CASE WHEN @ExportCode NOT IN ('OEPASSIVE','OEACTIVE') THEN DATEPART(YEAR,GETDATE()) ELSE DATEPART(YEAR,GETDATE()) + 1 END
                                END
    INTO dbo.U_EACCLDMOEX_drvTbl
    FROM dbo.U_EACCLDMOEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_EACCLDMOEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    LEFT JOIN dbo.EmpMPhon WITH (NOLOCK)
        ON EfoEEID = xEEID
        AND efoPhoneType = 'CEL'
    LEFT JOIN (
                SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason
                FROM (
                        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhChangeReason, EdhBenStatusDate, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhBenStatusDate DESC) AS RN 
                        FROM EmpHDed
                        WHERE EdhDedCode IN ('DEN1','DEN2','MED1','MED2','MED3','VIS')) AS X
                WHERE RN = 1) AS Edh
        ON EdhEEID = xEEID
        AND EdhCOID = xCOID
        AND EdhDedCode = BdmDedCode
    LEFT JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = BdmDedCode
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND EecDateOfTermination BETWEEN @StartDate AND @EndDate)
    ;


    ---------------------------------
    -- HEADER RECORD
    ---------------------------------

    DECLARE @CurrentDate VARCHAR(17);

    SELECT @CurrentDate = FORMAT(GETDATE(), 'yyyyMMdd hh:mm:ss');

    IF OBJECT_ID('U_EACCLDMOEX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_Header;
    SELECT DISTINCT
         drvCurrentDateAndTime = @CurrentDate
    INTO dbo.U_EACCLDMOEX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EACCLDMOEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EACCLDMOEX_Trailer;
    SELECT DISTINCT
         drvCurrentDateAndTime = @CurrentDate
        ,drvTotalNumberOfRecords = (SELECT COUNT(*) FROM dbo.U_EACCLDMOEX_drvTbl)
    INTO dbo.U_EACCLDMOEX_Trailer
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
ALTER VIEW dbo.dsi_vwEACCLDMOEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EACCLDMOEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EACCLDMOEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202012081'
       ,expStartPerControl     = '202012081'
       ,expLastEndPerControl   = '202012159'
       ,expEndPerControl       = '202012159'
WHERE expFormatCode = 'EACCLDMOEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEACCLDMOEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EACCLDMOEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort