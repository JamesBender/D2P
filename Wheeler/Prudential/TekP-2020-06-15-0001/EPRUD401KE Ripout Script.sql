SET NOCOUNT ON;
IF OBJECT_ID('U_EPRUD401KE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPRUD401KE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPRUD401KE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPRUD401KE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPRUD401KE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPRUD401KE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUD401KE];
GO
IF OBJECT_ID('U_EPRUD401KE_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_PEarHist];
GO
IF OBJECT_ID('U_EPRUD401KE_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_PDedHist];
GO
IF OBJECT_ID('U_EPRUD401KE_Header') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_Header];
GO
IF OBJECT_ID('U_EPRUD401KE_File') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_File];
GO
IF OBJECT_ID('U_EPRUD401KE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_EEList];
GO
IF OBJECT_ID('U_EPRUD401KE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_drvTbl];
GO
IF OBJECT_ID('U_EPRUD401KE_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EPRUD401KE') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPRUD401KE];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPRUD401KE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPRUD401KE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPRUD401KE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPRUD401KE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPRUD401KE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPRUD401KE','Prudendtial 006764 401K','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EPRUD401KEZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPRUD401KE' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"001"','1','(''DA''=''F'')','EPRUD401KEZ0','3','H','01','1',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COMBINED"','2','(''DA''=''F'')','EPRUD401KEZ0','10','H','01','4',NULL,'FILE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"006764"','3','(''DA''=''F'')','EPRUD401KEZ0','10','H','01','14',NULL,'CLIENT IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreationDate"','4','(''UD112''=''F'')','EPRUD401KEZ0','8','H','01','24',NULL,'FILE CREATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreationTime"','5','(''UA''=''F'')','EPRUD401KEZ0','6','H','01','32',NULL,'FILE CREATION TIME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"P"','6','(''DA''=''F'')','EPRUD401KEZ0','1','H','01','38',NULL,'SENDER (P=Payroll Provider or C=Client)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"V01"','7','(''DA''=''F'')','EPRUD401KEZ0','3','H','01','39',NULL,'FILE FORMAT TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EPRUD401KEZ0','660','H','01','42',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"114"','1','(''DA''=''F'')','EPRUD401KEZ0','3','D','10','1',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','4',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"006764"','3','(''DA''=''F'')','EPRUD401KEZ0','6','D','10','6',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''F'')','EPRUD401KEZ0','3','D','10','12',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvParticipantId"','5','(''UA''=''F'')','EPRUD401KEZ0','9','D','10','15',NULL,'PARTICIPANT ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullPartTimeInd"','7','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','35',NULL,'FULL/PART TIME  INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"**"','8','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','36',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource1"','9','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','38',NULL,'SOURCE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt1"','10','(''UA''=''F'')','EPRUD401KEZ0','9','D','10','39',NULL,'CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"**"','11','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','48',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource2"','12','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','50',NULL,'SOURCE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt2"','13','(''UA''=''F'')','EPRUD401KEZ0','9','D','10','51',NULL,'CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"**"','14','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','60',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource3"','15','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','62',NULL,'SOURCE 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt3"','16','(''UA''=''F'')','EPRUD401KEZ0','9','D','10','63',NULL,'CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"**"','17','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','72',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource4"','18','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','74',NULL,'SOURCE 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt4"','19','(''UA''=''F'')','EPRUD401KEZ0','9','D','10','75',NULL,'CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"**"','20','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','84',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource5"','21','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','86',NULL,'SOURCE 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContributionAmt5"','22','(''UA''=''F'')','EPRUD401KEZ0','9','D','10','87',NULL,'CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','96',NULL,'INVESTMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','24','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','98',NULL,'SOURCE 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''DA''=''F'')','EPRUD401KEZ0','9','D','10','99',NULL,'CONTRIBUTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodEndDate"','26','(''UD112''=''F'')','EPRUD401KEZ0','8','D','10','108',NULL,'PAY PERIOD END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','116',NULL,'INSIDER TRADER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubPlanNumber"','28','(''UA''=''F'')','EPRUD401KEZ0','4','D','10','117',NULL,'SUB PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','29','(''UA''=''F'')','EPRUD401KEZ0','30','D','10','121',NULL,'NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','30','(''UA''=''F'')','EPRUD401KEZ0','30','D','10','151',NULL,'ADDRESS 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','31','(''UA''=''F'')','EPRUD401KEZ0','30','D','10','181',NULL,'ADDRESS 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','32','(''UA''=''F'')','EPRUD401KEZ0','18','D','10','211',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','33','(''UA''=''F'')','EPRUD401KEZ0','2','D','10','229',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','34','(''UA''=''F'')','EPRUD401KEZ0','9','D','10','231',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','35','(''UD112''=''F'')','EPRUD401KEZ0','8','D','10','240',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalDateOfHire"','36','(''UD112''=''F'')','EPRUD401KEZ0','8','D','10','248',NULL,'ORIGINAL DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedHireDate"','37','(''UD112''=''F'')','EPRUD401KEZ0','8','D','10','256',NULL,'ADJUSTED HIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','38','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','264',NULL,'MARITAL STATUS  (Used if Spousal Consent is Requir',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','39','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','265',NULL,'GENDER CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatus"','40','(''UA''=''F'')','EPRUD401KEZ0','2','D','10','266',NULL,'EMPLOYEE STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EPRUD401KEZ0','8','D','10','268',NULL,'EMPLOYEE STATUS DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','42','(''UA''=''F'')','EPRUD401KEZ0','1','D','10','276',NULL,'PAYROLL FREQUENCY  (Loan Frequency)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EPRUD401KEZ0','8','D','10','277',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EPRUD401KEZ0','6','D','10','285',NULL,'YTD HOURS OF SERVICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurPayPeriodHours"','45','(''UA''=''F'')','EPRUD401KEZ0','6','D','10','291',NULL,'CURRENT PAY PERIOD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','297',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','312',NULL,'CURRENT ELIGIBLE GROSS PAY SOURCE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','327',NULL,'CURRENT PAY PERIOD W-2 PAY (Used for Profit Sharin',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EPRUD401KEZ0','8','D','10','338',NULL,'ANNIVERSARY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EPRUD401KEZ0','6','D','10','346',NULL,'ANNIVERSARY HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','51','(''UD112''=''F'')','EPRUD401KEZ0','8','D','10','352',NULL,'CHECK DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIdCode"','52','(''UA''=''F'')','EPRUD401KEZ0','13','D','10','360',NULL,'EMPLOYEE ID/CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EPRUD401KEZ0','4','D','10','373',NULL,'DIV/SUB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EPRUD401KEZ0','10','D','10','377',NULL,'EMPLOYER LOCATION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EPRUD401KEZ0','8','D','10','387',NULL,'LOCATION EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','395',NULL,'GROUP INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','EPRUD401KEZ0','10','D','10','396',NULL,'NEVER ELIGIBLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EPRUD401KEZ0','5','D','10','406',NULL,'ELIGIBLE TO PARTICIPATE IN EMPLOYEE SOURCES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','EPRUD401KEZ0','5','D','10','411',NULL,'ELIGIBLE TO PARTICIPATE IN EMPLOYER SOURCES',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','EPRUD401KEZ0','8','D','10','416',NULL,'ELIGIBILITY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','424',NULL,'AUTO ENROLLMENT DECLINE INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''F'')','EPRUD401KEZ0','5','D','10','425',NULL,'DEFERRAL RATE FOR SOURCE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','430',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','445',NULL,'CASH BONUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','456',NULL,'HCE INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','457',NULL,'UNION EMPLOYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','458',NULL,'MARKET SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','EPRUD401KEZ0','8','D','10','469',NULL,'REHIRE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','477',NULL,'CURRENT PAY PERIOD GROSS PAY/415/HCE/414 COMPENSAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','492',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','493',NULL,'DEFERRAL & PLAN LIMIT COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','508',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','509',NULL,'CURRENT ELIGIBLE GROSS PAY ‘SOURCE 2’',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','524',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','525',NULL,'ADP COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','540',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','541',NULL,'CURRENT ELIGIBLE GROSS PAY ‘SOURCE 3’',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','556',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''DA''=''F'')','EPRUD401KEZ0','15','D','10','557',NULL,'ER MATCH COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','80','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','572',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','573',NULL,'ACP COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','82','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','584',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','83','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','585',NULL,'EXCLUDED COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','84','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','596',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','85','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','597',NULL,'TOP HEAVY/401(a) COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','86','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','608',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''DA''=''F'')','EPRUD401KEZ0','11','D','10','609',NULL,'EE POST TAX COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','620',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','89','(''DA''=''F'')','EPRUD401KEZ0','2','D','10','621',NULL,'SUB STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','90','(''DA''=''F'')','EPRUD401KEZ0','1','D','10','623',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','91','(''DA''=''F'')','EPRUD401KEZ0','8','D','10','624',NULL,'SUB STATUS DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmailWork"','92','(''UA''=''F'')','EPRUD401KEZ0','40','D','10','632',NULL,'WORK E-MAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''DA''=''F'')','EPRUD401KEZ0','40','D','10','672',NULL,'PERSONAL/HOME E-MAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneWork"','94','(''UA''=''F'')','EPRUD401KEZ0','10','D','10','712',NULL,'WORK PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneHome"','95','(''UA''=''F'')','EPRUD401KEZ0','10','D','10','722',NULL,'HOME PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneCell"','96','(''UA''=''F'')','EPRUD401KEZ0','10','D','10','732',NULL,'CELL PHONE',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EPRUD401KE_20200714.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202007149','EMPEXPORT','OEACTIVE','Jul 14 2020  1:26PM','EPRUD401KE',NULL,NULL,NULL,'202007149','Jul 14 2020 12:29PM','Jul 14 2020 12:29PM','202001011','220','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202007149','EMPEXPORT','OEPASSIVE','Jul 14 2020  1:27PM','EPRUD401KE',NULL,NULL,NULL,'202007149','Jul 14 2020 12:29PM','Jul 14 2020 12:29PM','202001011','345','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Prudendtial 006764 401K','202007149','EMPEXPORT','ONDEMAND','Jul 14 2020  1:27PM','EPRUD401KE',NULL,NULL,NULL,'202007149','Jul 14 2020 12:29PM','Jul 14 2020 12:29PM','202001011','345','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202007149','EMPEXPORT','SCHEDULED','Jul 14 2020  1:28PM','EPRUD401KE',NULL,NULL,NULL,'202007149','Jul 14 2020 12:29PM','Jul 14 2020 12:29PM','202001011','345','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202007149','EMPEXPORT','TEST','Jul 14 2020  1:29PM','EPRUD401KE',NULL,NULL,NULL,'202007149','Jul 14 2020 12:29PM','Jul 14 2020 12:29PM','202001011','345','','','202001011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUD401KE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUD401KE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUD401KE','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUD401KE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPRUD401KE','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EPRUD401KE' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EPRUD401KE' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EPRUD401KE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPRUD401KE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUD401KE','H01','dbo.U_EPRUD401KE_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPRUD401KE','D10','dbo.U_EPRUD401KE_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EPRUD401KE') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPRUD401KE] (
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
IF OBJECT_ID('U_EPRUD401KE_DedList') IS NULL
CREATE TABLE [dbo].[U_EPRUD401KE_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EPRUD401KE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EPRUD401KE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvParticipantId] char(11) NULL,
    [drvFullPartTimeInd] varchar(1) NULL,
    [drvSource1] varchar(1) NULL,
    [drvContributionAmt1] nvarchar(4000) NULL,
    [drvSource2] varchar(1) NOT NULL,
    [drvContributionAmt2] nvarchar(4000) NULL,
    [drvSource3] varchar(1) NULL,
    [drvContributionAmt3] nvarchar(4000) NULL,
    [drvSource4] varchar(1) NULL,
    [drvContributionAmt4] nvarchar(4000) NULL,
    [drvSource5] varchar(1) NULL,
    [drvContributionAmt5] nvarchar(4000) NULL,
    [drvPayPeriodEndDate] datetime NULL,
    [drvSubPlanNumber] varchar(6) NULL,
    [drvName] varchar(204) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvOriginalDateOfHire] datetime NULL,
    [drvAdjustedHireDate] datetime NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvEmployeeStatus] varchar(2) NOT NULL,
    [drvPayrollFrequency] varchar(1) NOT NULL,
    [drvCurPayPeriodHours] nvarchar(4000) NULL,
    [drvCheckDate] datetime NULL,
    [drvEmployeeIdCode] char(11) NULL,
    [drvAddressEmailWork] varchar(50) NULL,
    [drvPhoneWork] varchar(50) NULL,
    [drvPhoneHome] varchar(50) NULL,
    [drvPhoneCell] varchar(50) NULL
);
IF OBJECT_ID('U_EPRUD401KE_EEList') IS NULL
CREATE TABLE [dbo].[U_EPRUD401KE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPRUD401KE_File') IS NULL
CREATE TABLE [dbo].[U_EPRUD401KE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EPRUD401KE_Header') IS NULL
CREATE TABLE [dbo].[U_EPRUD401KE_Header] (
    [drvCreationDate] nvarchar(4000) NULL,
    [drvCreationTime] varchar(8000) NULL
);
IF OBJECT_ID('U_EPRUD401KE_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPRUD401KE_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1Amt] numeric NULL,
    [PdhSource2Amt] numeric NULL,
    [PdhSource3Amt] numeric NULL,
    [PdhSource4Amt] numeric NULL,
    [PdhSource5Amt] numeric NULL
);
IF OBJECT_ID('U_EPRUD401KE_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPRUD401KE_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPRUD401KE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Wheeler

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 07/14/2020
Service Request Number: TekP-2020-06-15-0001

Purpose: Prudendtial 006764 401K

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPRUD401KE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPRUD401KE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPRUD401KE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPRUD401KE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPRUD401KE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUD401KE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUD401KE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPRUD401KE', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPRUD401KE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPRUD401KE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EPRUD401KE';

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
    DELETE FROM dbo.U_EPRUD401KE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPRUD401KE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'N401P,N401F,NCUPP,NCUPF,N401R,NCUPR,4ERM,NPRSH,N40AT';

    IF OBJECT_ID('U_EPRUD401KE_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUD401KE_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPRUD401KE_DedList
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
    IF OBJECT_ID('U_EPRUD401KE_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUD401KE_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1Amt     = SUM(CASE WHEN PdhDedCode IN ('N401P', 'N401F', 'NCUPP', 'NCUPF') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2Amt     = SUM(CASE WHEN PdhDedCode IN ('N401R','NCUPR') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3Amt     = SUM(CASE WHEN PdhDedCode IN ('4ERM') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4Amt     = SUM(CASE WHEN PdhDedCode IN ('NPRSH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5Amt     = SUM(CASE WHEN PdhDedCode IN ('N40AT') THEN PdhEECurAmt ELSE 0.00 END)
        /*,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_EPRUD401KE_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPRUD401KE_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EPRUD401KE_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUD401KE_PEarHist;
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
    INTO dbo.U_EPRUD401KE_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl BETWEEN @StartPerControl AND @EndPerControl
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EPRUD401KE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EPRUD401KE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUD401KE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvParticipantId = EepSSN
        ,drvFullPartTimeInd =    CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1'
                                    WHEN EecFullTimeOrPartTime = 'P' THEN '2'    
                                END
        ,drvSource1 = CASE WHEN N401P_DedCode IS NOT NULL OR N401F_DedCode IS NOT NULL OR  NCUPP_DedCode IS NOT NULL OR  NCUPF_DedCode IS NOT NULL THEN 'A' END
        ,drvContributionAmt1 = CASE WHEN N401P_DedCode IS NOT NULL OR N401F_DedCode IS NOT NULL OR  NCUPP_DedCode IS NOT NULL OR  NCUPF_DedCode IS NOT NULL THEN FORMAT(PdhSource1Amt, '#0.00') END
        ,drvSource2 = CASE WHEN N401R_DedCode IS NOT NULL OR 'NCUPR' IS NOT NULL THEN 'J' END
        ,drvContributionAmt2 = CASE WHEN N401R_DedCode IS NOT NULL OR 'NCUPR' IS NOT NULL THEN FORMAT(PdhSource2Amt, '#0.00') END
        ,drvSource3 = CASE WHEN _4ERM_DedCode IS NOT NULL THEN '6' END
        ,drvContributionAmt3 = CASE WHEN _4ERM_DedCode IS NOT NULL THEN FORMAT(PdhSource3Amt, '#0.00') END
        ,drvSource4 = CASE WHEN NPRSH_DedCode IS NOT NULL THEN '1' END
        ,drvContributionAmt4 = CASE WHEN NPRSH_DedCode IS NOT NULL THEN FORMAT(PdhSource4Amt, '#0.00') END
        ,drvSource5 = CASE WHEN N40AT_DedCode IS NOT NULL THEN 'K' END
        ,drvContributionAmt5 = CASE WHEN N40AT_DedCode IS NOT NULL THEN FORMAT(PdhSource5Amt, '#0.00') END
        ,drvPayPeriodEndDate = PrgPeriodEnd 
        ,drvSubPlanNumber =    CASE WHEN PgpPayGroup IN ('CCOBW') AND CmpCompanyCode IN ('CCO') THEN '000001'
                                WHEN PgpPayGroup IN ('BIWEEK') AND CmpCompanyCode IN ('WMC', 'MON', 'SIT') THEN '000002'
                                WHEN PgpPayGroup IN ('ICMBW') AND CmpCompanyCode IN ('ICM') THEN '000003'
                                WHEN PgpPayGroup IN ('HTGBW') AND CmpCompanyCode IN ('HTG') THEN '000004'
                                WHEN PgpPayGroup IN ('BWLBW') AND CmpCompanyCode IN ('BWL') THEN '000005'
                                WHEN PgpPayGroup IN ('MELBW') AND CmpCompanyCode IN ('MEL') THEN '000006'
                                WHEN PgpPayGroup IN ('GDRBW') AND CmpCompanyCode IN ('GDR') THEN '000007'
                                WHEN PgpPayGroup IN ('DRLBW') AND CmpCompanyCode IN ('DRL') THEN '000008'
                            END
        ,drvName = EepNameLast + ', ' + EepNameFirst + ' ' + LEFT(EepNameMiddle, 1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvOriginalDateOfHire = EecDateOfOriginalHire
        ,drvAdjustedHireDate =    CASE WHEN eecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvMaritalStatus =    CASE WHEN eepMaritalStatus = 'S' THEN '1'
                                WHEN eepMaritalStatus = 'M' THEN '2'
                                WHEN eepMaritalStatus IN ('W','Z','D') THEN '0'
                            END
        ,drvGender =    CASE WHEN EepGender = 'M' THEN '1'
                            WHEN EepGender = 'F' THEN '2'
                        END
        ,drvEmployeeStatus = CASE WHEN EecEmplStatus = 'A' THEN '00' ELSE '32' END
        ,drvPayrollFrequency = CASE WHEN PgrPayFrequency = 'W' THEN '7' ELSE '6' END
        ,drvCurPayPeriodHours = FORMAT(PehCurHrsYTD, '0#.00')
        ,drvCheckDate = PgrPayDate
        ,drvEmployeeIdCode = EepSSN
        ,drvAddressEmailWork = EepAddressEMail
        ,drvPhoneWork = EecPhoneBusinessNumber
        ,drvPhoneHome = EepPhoneHomeNumber
        ,drvPhoneCell = EfoPhoneNumber
        /*,drvSource1 = ''
        ,drvContributionAmt1 = ''
        ,drvSource2 = ''
        ,drvContributionAmt2 = ''
        ,drvSource3 = ''
        ,drvContributionAmt3 = ''
        ,drvSource4 = ''
        ,drvContributionAmt4 = ''
        ,drvSource5 = ''
        ,drvContributionAmt5 = ''
        ,drvPayPeriodEndDate = ''
        ,drvSubPlanNumber = ''
        ,drvName = ''
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfBirth = EepDateOfBirth
        ,drvOriginalDateOfHire = ''
        ,drvAdjustedHireDate = EecDateOfLastHire
        ,drvMaritalStatus = eepMaritalStatus
        ,drvGender = EepGender
        ,drvEmployeeStatus = ''
        ,drvPayrollFrequency = ''
        ,drvCurPayPeriodHours = ''
        ,drvCheckDate = ''
        ,drvEmployeeIdCode = EecEmpNo
        ,drvAddressEmailWork = EepAddressEMail
        ,drvPhoneWork = ''
        ,drvPhoneHome = ''
        ,drvPhoneCell = ''*/
    INTO dbo.U_EPRUD401KE_drvTbl
    FROM dbo.U_EPRUD401KE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN (
            SELECT BdmEEID, BdmCOID
            ,MAX(CASE WHEN BdmDedCode = 'N401P' THEN BdmDedCode END) as N401P_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'N401F' THEN BdmDedCode END) as N401F_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'NCUPP' THEN BdmDedCode END) as NCUPP_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'NCUPF' THEN BdmDedCode END) as NCUPF_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'N401R' THEN BdmDedCode END) as N401R_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'NCUPR' THEN BdmDedCode END) as NCUPR_DedCode
            ,MAX(CASE WHEN BdmDedCode = '4ERM' THEN BdmDedCode END) as _4ERM_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'NPRSH' THEN BdmDedCode END) as NPRSH_DedCode
            ,MAX(CASE WHEN BdmDedCode = 'N40AT' THEN BdmDedCode END) as N40AT_DedCode
            FROM dbo.U_dsi_BDM_EPRUD401KE WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID) AS BDM
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN dbo.U_EPRUD401KE_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.U_EPRUD401KE_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN (
            SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
            FROM dbo.PgPayPer WITH (NOLOCK)
            WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
            GROUP BY PgpPayGroup
        ) AS PayGroup
        ON PayGroup.PgpPayGroup = EecPayGroup
    JOIN (
            SELECT CmpCoID, CmpCompanyCode FROM dbo.Company WITH (NOLOCK)
        ) AS CompanyList
        ON CmpCOID = xCOID
    JOIN (
            SELECT PgrPayFrequency, PgrPayGroup, PgrPayDate FROM dbo.PayGroup WITH (NOLOCK)
        ) AS PayFrequency
        ON PgpPayGroup = PgrPayGroup
    LEFT JOIN dbo.EmpMPhon
        ON EfoEEID = xEEID
        AND EfoPhoneType = 'CEL'
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPRUD401KE_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPRUD401KE_Header;
    SELECT DISTINCT
         drvCreationDate = FORMAT(GETDATE(), 'yyyyMMdd')
        ,drvCreationTime = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', SPACE(0))
    INTO dbo.U_EPRUD401KE_Header
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
ALTER VIEW dbo.dsi_vwEPRUD401KE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPRUD401KE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPRUD401KE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001011'
       ,expStartPerControl     = '202001011'
       ,expLastEndPerControl   = '202007149'
       ,expEndPerControl       = '202007149'
WHERE expFormatCode = 'EPRUD401KE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPRUD401KE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EPRUD401KE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort