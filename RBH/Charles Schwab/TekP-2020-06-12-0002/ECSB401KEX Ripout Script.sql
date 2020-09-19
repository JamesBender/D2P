SET NOCOUNT ON;
IF OBJECT_ID('U_ECSB401KEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECSB401KEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECSB401KEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECSB401KEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECSB401KEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECSB401KEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSB401KEX];
GO
IF OBJECT_ID('U_ECSB401KEX_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_Trailer];
GO
IF OBJECT_ID('U_ECSB401KEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_PEarHist];
GO
IF OBJECT_ID('U_ECSB401KEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_PDedHist];
GO
IF OBJECT_ID('U_ECSB401KEX_File') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_File];
GO
IF OBJECT_ID('U_ECSB401KEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_EEList];
GO
IF OBJECT_ID('U_ECSB401KEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_drvTbl];
GO
IF OBJECT_ID('U_ECSB401KEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECSB401KEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECSB401KEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECSB401KEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECSB401KEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECSB401KEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECSB401KEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECSB401KEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ECSB401KEX','Charles Schwab 401k Export-TEK','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ECSB401KEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"100"','1','(''DA''=''F'')','ECSB401KEXZ0','3','D','10','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RBH"','2','(''DA''=''F'')','ECSB401KEXZ0','3','D','10','4',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''F'')','ECSB401KEXZ0','11','D','10','7',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','4','(''UA''=''F'')','ECSB401KEXZ0','32','D','10','18',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc1"','5','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','50',NULL,'Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc2"','6','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','62',NULL,'Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc3"','7','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','74',NULL,'Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc4"','8','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','86',NULL,'Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','98',NULL,'Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','110',NULL,'Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','122',NULL,'Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','134',NULL,'Contribution Source 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','146',NULL,'Contribution Source 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','158',NULL,'Contribution Source 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment1"','15','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','170',NULL,'Loan Payment #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment2"','16','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','182',NULL,'Loan Payment #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment3"','17','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','194',NULL,'Loan Payment #3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment4"','18','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','206',NULL,'Loan Payment #4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPayment5"','19','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','218',NULL,'Loan Payment #5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerDefAllComp"','20','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','230',NULL,'Pay Period Deferral/Allocation Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerTestingComp"','21','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','242',NULL,'Pay Period Plan Testing Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerTotalComp"','22','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','254',NULL,'Pay Period Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','266',NULL,'Pay Period Additional Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPerHoursPaid"','24','(''UA''=''F'')','ECSB401KEXZ0','4','D','10','278',NULL,'Pay Period Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"        401F"','25','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','282',NULL,'Plan YTD Contribution Source 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"        401C"','26','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','294',NULL,'Plan YTD Contribution Source 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"        ROTH"','27','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','306',NULL,'Plan YTD Contribution Source 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"       ROTHC"','28','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','318',NULL,'Plan YTD Contribution Source 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','330',NULL,'Plan YTD Contribution Source 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','342',NULL,'Plan YTD Contribution Source 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','354',NULL,'Plan YTD Contribution Source 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','32','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','366',NULL,'Plan YTD Contribution Source 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','378',NULL,'Plan YTD Contribution Source 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','34','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','390',NULL,'Plan YTD Contribution Source 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDDefAllocComp"','35','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','402',NULL,'Plan YTD Deferral/Allocation Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanTestComp"','36','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','414',NULL,'YTD Plan Testing Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDPlanTotalComp"','37','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','426',NULL,'Plan YTD Total Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','ECSB401KEXZ0','12','D','10','438',NULL,'YTD Additional Compensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','39','(''UA''=''F'')','ECSB401KEXZ0','12','D','10','450',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYTDHoursPaid"','40','(''UA''=''F'')','ECSB401KEXZ0','4','D','10','462',NULL,'Plan YTD Hours Paid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','41','(''UA''=''F'')','ECSB401KEXZ0','1','D','10','466',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','42','(''UA''=''F'')','ECSB401KEXZ0','40','D','10','467',NULL,'Primary Address Line #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','43','(''UA''=''F'')','ECSB401KEXZ0','40','D','10','507',NULL,'Primary Address Line #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','44','(''UA''=''F'')','ECSB401KEXZ0','80','D','10','547',NULL,'Primary City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','45','(''UA''=''F'')','ECSB401KEXZ0','2','D','10','627',NULL,'Primary State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','46','(''UA''=''F'')','ECSB401KEXZ0','10','D','10','629',NULL,'Primary Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','47','(''UA''=''F'')','ECSB401KEXZ0','30','D','10','639',NULL,'Primary Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','ECSB401KEXZ0','1','D','10','669',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','49','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','670',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','50','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','678',NULL,'Hire Date (original)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEntryDate1"','51','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','686',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','ECSB401KEXZ0','8','D','10','694',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','ECSB401KEXZ0','8','D','10','702',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','ECSB401KEXZ0','8','D','10','710',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','55','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','718',NULL,'Termination Date (if applicable)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','56','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','726',NULL,'Rehire Date (date of most recent rehire)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''DA''=''F'')','ECSB401KEXZ0','8','D','10','734',NULL,'Alternate Vesting Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','ECSB401KEXZ0','1','D','10','742',NULL,'Restricted Status (officer status field)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','ECSB401KEXZ0','5','D','10','743',NULL,'Loan Restriction',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','ECSB401KEXZ0','1','D','10','748',NULL,'Collective Bargaining Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollStatus"','61','(''UA''=''F'')','ECSB401KEXZ0','1','D','10','749',NULL,'Payroll Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''F'')','ECSB401KEXZ0','1','D','10','750',NULL,'Highly Compensated Status (HCE)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','ECSB401KEXZ0','1','D','10','751',NULL,'Ineligible Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','ECSB401KEXZ0','15','D','10','752',NULL,'Pay Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','ECSB401KEXZ0','5','D','10','767',NULL,'Reporting Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','ECSB401KEXZ0','15','D','10','772',NULL,'Alternate Key #1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','ECSB401KEXZ0','15','D','10','787',NULL,'Alternate Key #2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','ECSB401KEXZ0','5','D','10','802',NULL,'Transfer Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkHomePhone"','69','(''UA''=''F'')','ECSB401KEXZ0','15','D','10','807',NULL,'Work/Home Telephone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','70','(''UA''=''F'')','ECSB401KEXZ0','50','D','10','822',NULL,'E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLanguageCode"','71','(''UA''=''F'')','ECSB401KEXZ0','1','D','10','872',NULL,'Language Preference Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','72','(''UA''=''F'')','ECSB401KEXZ0','1','D','10','873',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','73','(''UA''=''F'')','ECSB401KEXZ0','1','D','10','874',NULL,'Marital Status – Taxable',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFederalExemptions"','74','(''UA''=''F'')','ECSB401KEXZ0','2','D','10','875',NULL,'Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobCodeIndicator"','75','(''UA''=''F'')','ECSB401KEXZ0','1','D','10','877',NULL,'Job Code Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAStartDate"','76','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','878',NULL,'Leave of Absence – Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAEndDate"','77','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','886',NULL,'Leave of Absence – End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLOAIndicator"','78','(''UA''=''F'')','ECSB401KEXZ0','1','D','10','894',NULL,'Leave of Absence Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfRetirement"','79','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','895',NULL,'Retirement Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfDeath"','80','(''UDMDY''=''F'')','ECSB401KEXZ0','8','D','10','903',NULL,'Death Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','81','(''DA''=''F'')','ECSB401KEXZ0','40','D','10','911',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"101"','1','(''DA''=''F'')','ECSB401KEXZ0','3','T','90','1',NULL,'Record ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RBH"','2','(''DA''=''F'')','ECSB401KEXZ0','3','T','90','4',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayPeriodEndDate"','3','(''UDMDY''=''F'')','ECSB401KEXZ0','11','T','90','7',NULL,'Pay Period Ending Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc1Total"','4','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','18',NULL,'Contribution Source 1 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc2Total"','5','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','30',NULL,'Contribution Source 2 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc3Total"','6','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','42',NULL,'Contribution Source 3 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSrc4Total"','7','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','54',NULL,'Contribution Source 4 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','ECSB401KEXZ0','12','T','90','66',NULL,'Contribution Source 5 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''F'')','ECSB401KEXZ0','12','T','90','78',NULL,'Contribution Source 6 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','ECSB401KEXZ0','12','T','90','90',NULL,'Contribution Source 7 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''F'')','ECSB401KEXZ0','12','T','90','102',NULL,'Contribution Source 8 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','ECSB401KEXZ0','12','T','90','114',NULL,'Contribution Source 9 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','ECSB401KEXZ0','12','T','90','126',NULL,'Contribution Source 10 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal1"','14','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','138',NULL,'Loan Payment #1 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal2"','15','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','150',NULL,'Loan Payment #2 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal3"','16','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','162',NULL,'Loan Payment #3 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal4"','17','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','174',NULL,'Loan Payment #4 Total',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanPaymentTotal5"','18','(''UA''=''F'')','ECSB401KEXZ0','12','T','90','186',NULL,'Loan Payment #5 Total',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECSB401KEX_20200918.txt',NULL,'','',NULL,NULL,NULL,NULL,'Charles Schwab 401k Export','202008319','EMPEXPORT','ONDEMAND',NULL,'ECSB401KEX',NULL,NULL,NULL,'202008319','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202008311',NULL,'','','202008311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECSB401KEX_20200918.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202008319','EMPEXPORT','SCHEDULED',NULL,'ECSB401KEX',NULL,NULL,NULL,'202008319','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202008311',NULL,'','','202008311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECSB401KEX_20200918.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202008319','EMPEXPORT','OEACTIVE',NULL,'ECSB401KEX',NULL,NULL,NULL,'202008319','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202008311',NULL,'','','202008311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECSB401KEX_20200918.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202008319','EMPEXPORT','OEPASSIVE',NULL,'ECSB401KEX',NULL,NULL,NULL,'202008319','Aug  7 2020  1:39PM','Aug  7 2020  1:39PM','202008311',NULL,'','','202008311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECSB401KEX_20200918.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008319','EMPEXPORT','TEST','Sep 18 2020  1:56PM','ECSB401KEX',NULL,NULL,NULL,'202008319','Aug 31 2020 12:00AM','Aug 31 2020 12:00AM','202008311','350','eecPayGroup','MONTH,SEMIMO','202008311',dbo.fn_GetTimedKey(),NULL,'us3rVaROB1010',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECSB401KEX_20200918.txt' END WHERE expFormatCode = 'ECSB401KEX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSB401KEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECSB401KEX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECSB401KEX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECSB401KEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECSB401KEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSB401KEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSB401KEX','D10','dbo.U_ECSB401KEX_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSB401KEX','T90','dbo.U_ECSB401KEX_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ECSB401KEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECSB401KEX] (
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
IF OBJECT_ID('U_ECSB401KEX_DedList') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECSB401KEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(5) NULL,
    [drvSSN] varchar(11) NULL,
    [drvName] varchar(253) NULL,
    [drvContribSrc1] nvarchar(12) NULL,
    [drvContribSrc2] nvarchar(12) NULL,
    [drvContribSrc3] nvarchar(12) NULL,
    [drvContribSrc4] nvarchar(12) NULL,
    [drvLoanPayment1] nvarchar(12) NULL,
    [drvLoanPayment2] nvarchar(12) NULL,
    [drvLoanPayment3] nvarchar(12) NULL,
    [drvLoanPayment4] nvarchar(12) NULL,
    [drvLoanPayment5] nvarchar(12) NULL,
    [drvPayPerDefAllComp] nvarchar(12) NULL,
    [drvPayPerTestingComp] nvarchar(12) NULL,
    [drvPayPerTotalComp] nvarchar(12) NULL,
    [drvPayPerHoursPaid] nvarchar(4) NULL,
    [drvYTDDefAllocComp] nvarchar(12) NULL,
    [drvYTDPlanTestComp] nvarchar(12) NULL,
    [drvYTDPlanTotalComp] nvarchar(12) NULL,
    [drvSalary] nvarchar(12) NULL,
    [drvPlanYTDHoursPaid] nvarchar(4) NULL,
    [drvPayFrequency] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvPlanEntryDate1] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvPayrollStatus] char(1) NULL,
    [drvWorkHomePhone] varchar(12) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvLanguageCode] char(2) NOT NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvFederalExemptions] nvarchar(2) NULL,
    [drvJobCodeIndicator] char(1) NULL,
    [drvLOAStartDate] datetime NULL,
    [drvLOAEndDate] datetime NULL,
    [drvLOAIndicator] varchar(1) NULL,
    [drvDateOfRetirement] datetime NULL,
    [drvDateOfDeath] datetime NULL
);
IF OBJECT_ID('U_ECSB401KEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECSB401KEX_File') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_ECSB401KEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401FAmt] numeric NULL,
    [Pdh401CAmt] numeric NULL,
    [PdhRothAmt] numeric NULL,
    [PdhRothCAmt] numeric NULL,
    [Pdh401L1Amt] numeric NULL,
    [Pdh401L2Amt] numeric NULL,
    [Pdh401L3Amt] numeric NULL,
    [Pdh401L4Amt] numeric NULL,
    [Pdh401L5Amt] numeric NULL
);
IF OBJECT_ID('U_ECSB401KEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehPayPerDefAllComp] numeric NULL,
    [PehPayPerTestingComp] numeric NULL,
    [PehPayPerTotalComp] numeric NULL,
    [PehYTDDefAllocComp] numeric NULL,
    [PehYTDPlanTestComp] numeric NULL,
    [PehYTDPlanTotalComp] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_ECSB401KEX_Trailer') IS NULL
CREATE TABLE [dbo].[U_ECSB401KEX_Trailer] (
    [drvPayPeriodEndDate] datetime NULL,
    [drvContribSrc1Total] nvarchar(12) NULL,
    [drvContribSrc2Total] nvarchar(12) NULL,
    [drvContribSrc3Total] nvarchar(12) NULL,
    [drvContribSrc4Total] nvarchar(12) NULL,
    [drvLoanPaymentTotal1] nvarchar(12) NULL,
    [drvLoanPaymentTotal2] nvarchar(12) NULL,
    [drvLoanPaymentTotal3] nvarchar(12) NULL,
    [drvLoanPaymentTotal4] nvarchar(12) NULL,
    [drvLoanPaymentTotal5] nvarchar(12) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSB401KEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: RBH

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 08/07/2020
Service Request Number: TekP-2020-06-12-0002

Purpose: Charles Schwab 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECSB401KEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECSB401KEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECSB401KEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECSB401KEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECSB401KEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSB401KEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSB401KEX', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSB401KEX', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECSB401KEX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECSB401KEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECSB401KEX';

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
    DELETE FROM dbo.U_ECSB401KEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECSB401KEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ROTH,ROTHC,401F,401C,401L,401L2,401L3,401L4,401L5';

    IF OBJECT_ID('U_ECSB401KEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ECSB401KEX_DedList
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
    IF OBJECT_ID('U_ECSB401KEX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401FAmt     = SUM(CASE WHEN PdhDedCode IN ('401F') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401CAmt     = SUM(CASE WHEN PdhDedCode IN ('401C') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhRothAmt     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhRothCAmt     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401L1Amt     = SUM(CASE WHEN PdhDedCode IN ('401L1') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401L2Amt     = SUM(CASE WHEN PdhDedCode IN ('401L2') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401L3Amt     = SUM(CASE WHEN PdhDedCode IN ('401L3') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401L4Amt     = SUM(CASE WHEN PdhDedCode IN ('401L4') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh401L5Amt     = SUM(CASE WHEN PdhDedCode IN ('401L5') THEN PdhEECurAmt ELSE 0.00 END)
    INTO dbo.U_ECSB401KEX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ECSB401KEX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ECSB401KEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehPayPerDefAllComp    = SUM(CASE WHEN ErnEarnCode IN ('BONUS','DOT','HBON','OCALL','OT','OTHER','REG','RETRO','SEV','SOT') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehPayPerTestingComp    = SUM(CASE WHEN ErnEarnCode IN ('BONUS','DOT','HBON','OCALL','OT','OTHER','REG','RETRO','SEV','SOT') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehPayPerTotalComp        = SUM(CASE WHEN ErnEarnCode IN ('BONUS','DOT','HBON','OCALL','OT','OTHER','REG','RETRO','SEV','SOT') AND PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDDefAllocComp        = SUM(CASE WHEN ErnEarnCode IN ('BONUS','DOT','HBON','OCALL','OT','OTHER','REG','RETRO','SEV','SOT') AND ErnInclInDefComp = 'Y' THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDPlanTestComp        = SUM(CASE WHEN ErnEarnCode IN ('BONUS','DOT','HBON','OCALL','OT','OTHER','REG','RETRO','SEV','SOT') THEN PehCurAmt ELSE 0.00 END)
        ,PehYTDPlanTotalComp    = SUM(CASE WHEN ErnEarnCode IN ('BONUS','DOT','HBON','OCALL','OT','OTHER','REG','RETRO','SEV','SOT') THEN PehCurAmt ELSE 0.00 END)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ECSB401KEX_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EarnCode WITH (NOLOCK)
        ON ErnEarnCode = PehEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ECSB401KEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECSB401KEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = BdmDedCode
        -- standard fields above and additional driver fields below
        ,drvSSN = LEFT(eepSSN, 3) + '-' + RIGHT(LEFT(EepSSN, 5), 2) + '-' + RIGHT(REPLACE(EepSSN, ' ', ''), 4)
        ,drvName = EepNameLast + ', ' + EepNameFirst + ' ' + ISNULL(EepNameMiddle, '')
        ,drvContribSrc1 = RIGHT(SPACE(12) + FORMAT(Pdh401FAmt*100, '#0'), 12)
        ,drvContribSrc2 = RIGHT(SPACE(12) + FORMAT(Pdh401CAmt*100, '#0'), 12)
        ,drvContribSrc3 = RIGHT(SPACE(12) + FORMAT(RothEEAmt*100, '#0'), 12)
        -- RIGHT(SPACE(12) + FORMAT(PdhRothAmt*100, '#0'), 12)
        ,drvContribSrc4 = RIGHT(SPACE(12) + FORMAT(PdhRothCAmt*100, '#0'), 12)
        ,drvLoanPayment1 = RIGHT(SPACE(12) + FORMAT(Pdh401L1Amt*100, '#0'), 12)
        ,drvLoanPayment2 = RIGHT(SPACE(12) + FORMAT(Pdh401L2Amt*100, '#0'), 12)
        ,drvLoanPayment3 = RIGHT(SPACE(12) + FORMAT(Pdh401L3Amt*100, '#0'), 12)
        ,drvLoanPayment4 = RIGHT(SPACE(12) + FORMAT(Pdh401L4Amt*100, '#0'), 12)
        ,drvLoanPayment5 = RIGHT(SPACE(12) + FORMAT(Pdh401L5Amt*100, '#0'), 12)
        ,drvPayPerDefAllComp = RIGHT(SPACE(12) + FORMAT(PehPayPerDefAllComp*100, '#0'), 12)
        ,drvPayPerTestingComp = RIGHT(SPACE(12) + FORMAT(PehPayPerTestingComp*100, '#0'), 12)
        ,drvPayPerTotalComp = RIGHT(SPACE(12) + FORMAT(PehPayPerTotalComp*100, '#0'), 12)
        ,drvPayPerHoursPaid = RIGHT(SPACE(4) + FORMAT(PehCurHrs, '#0'), 4)
        ,drvYTDDefAllocComp = RIGHT(SPACE(12) + FORMAT(PehYTDDefAllocComp*100, '#0'), 12)
        ,drvYTDPlanTestComp = RIGHT(SPACE(12) + FORMAT(PehYTDPlanTestComp*100, '#0'), 12)
        ,drvYTDPlanTotalComp = RIGHT(SPACE(12) + FORMAT(PehYTDPlanTotalComp*100, '#0'), 12)
        ,drvSalary = RIGHT(SPACE(12) + FORMAT(EecAnnSalary*100, '#0'), 12)
        ,drvPlanYTDHoursPaid = RIGHT(SPACE(4) + FORMAT(EeeYTDHrs*100, '#0'), 4)
        ,drvPayFrequency =    CASE WHEN PgrPayFrequency = 'W' THEN 'W'
                                WHEN PgrPayFrequency = 'M' THEN 'M'
                                WHEN PgrPayFrequency = 'B' THEN 'B'
                                WHEN PgrPayFrequency = 'S' THEN 'S'
                                WHEN PgrPayFrequency = 'Q' THEN 'Q'
                            END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvDateOfBirth = EepDateOfBirth
        ,drvHireDate = EecDateOfOriginalHire
        ,drvPlanEntryDate1 = EligDate
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire < EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvPayrollStatus = EecEmplStatus
        ,drvWorkHomePhone = CASE WHEN ISNULL(eecPhoneBusinessNumber, '') <> '' THEN LEFT(eecPhoneBusinessNumber, 3) + '-' + RIGHT(LEFT(eecPhoneBusinessNumber, 6),3) + '-' + RIGHT(EecPhoneBusinessNumber, 4) ELSE '704-377-2536' END
        ,drvAddressEmail = EepAddressEMail
        ,drvLanguageCode = EecLanguageCode
        ,drvGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvFederalExemptions = RIGHT(' ' + FORMAT(EetExemptions, '#0'), 2)
        ,drvJobCodeIndicator = EecFullTimeOrPartTime
        ,drvLOAStartDate = CASE WHEN EecEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvLOAEndDate = CASE WHEN EecEmplStatus = 'L' THEN EshStatusStopDate END
        ,drvLOAIndicator = CASE WHEN EecEmplStatus = 'L' THEN 'L' END
        ,drvDateOfRetirement = CASE WHEN EecEmplStatus = 'R' THEN RetStatusStartDate END
        ,drvDateOfDeath = EepDateDeceased
    INTO dbo.U_ECSB401KEX_drvTbl
    FROM dbo.U_ECSB401KEX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN dbo.U_dsi_BDM_ECSB401KEX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
       -- AND EedFormatCode = @FormatCode 
       -- AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_ECSB401KEX_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID    
    LEFT JOIN dbo.U_ECSB401KEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN (
            SELECT EeeEEID, EeeCOID, SUM(EeeYTDHrs) AS EeeYTDHrs
            FROM dbo.EmpEarn WITH (NOLOCK)
            GROUP BY EeeEEID, EeeCOID
        ) AS Emp_Earnings
        ON EeeEEID = xEEID
        AND EeeCOID = xCOID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
            SELECT EedEEID, EedCOID, EedDedCode, MAX(EedEEEligDate) AS EligDate
            FROM dbo.EmpDedFull WITH (NOLOCK)
            WHERE EedDedCode IN ('ROTH','ROTHC','401F','401L','401L2','401L3','401L4','401L5')
            GROUP BY EedEEID, EedCOID, EedDedCode
        ) AS Emp_Eligbility
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND BdmDedCode = EedDedCode
    JOIN (
            SELECT EetEEID, EetCOID, SUM(EetExemptions) AS EetExemptions
            FROM dbo.EmpTax WITH (NOLOCK)
            WHERE LEFT(EetTaxCode, 2) = 'US'
            GROUP By EetEEID, EetCOID
        ) AS Tax_Exemptions
        ON EetEEID = xEEID
        AND EetCOID = xCOID
    LEFT JOIN (
                SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'L'
                    ) AS LOA_Dates 
                WHERE RN = 1
            ) AS Leave_StartEnd_Date
        ON EshEEID = xEEID
        AND EshCOID = xCOID
    LEFT JOIN (
                SELECT EshEEID AS RetEEID, EshCOID AS RetCOID, EshStatusStartDate AS RetStatusStartDate, EshStatusStopDate AS RetStatusStopDate
                FROM (
                        SELECT EshEEID, EshCOID, EshStatusStartDate, EshStatusStopDate, EshEmplStatus, ROW_NUMBER() OVER (PARTITION BY EshEEID, EshCOID ORDER BY EshStatusStartDate DESC) AS RN
                        FROM dbo.EmpHStat WITH (NOLOCK) 
                        WHERE EshEmplStatus = 'R'
                    ) AS LOA_Dates 
                WHERE RN = 1
            ) AS Retire_StartEnd_Date
        ON RetEEID = xEEID
        AND RetCOID = xCOID
    LEFT JOIN (
                SELECT EedEEID AS RothEEID, EedCOID AS RothCOID, EedEEAmt AS RothEEAmt
                FROM (
                        SELECT EedEEID, EedCOID, EedEEAmt, ROW_NUMBER() OVER (PARTITION BY EedEEID, EedCOID ORDER BY EedBenStartDate DESC) AS RN
                        FROM dbo.EmpDedFull WITH (NOLOCK)
                        WHERE EedDedCode = 'ROTH'
                        --and EedEEID IN ('D1OMF2002040','D1OLA4000040','D1OLM1002040')
                        ) AS R
                WHERE RN = 1) AS ROTH
        ON RothEEID = xEEID
        AND RothCOID = xCOID
    WHERE EecEmplStatus <> 'T' OR (EecEmplStatus = 'T' AND DATEPART(YEAR, EecDateOfTermination) = DATEPART(YEAR, @ENDDATE))
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------

    DECLARE @Contrib1 AS INTEGER
        ,@Contrib2 AS INTEGER
        ,@Contrib3 AS INTEGER
        ,@Contrib4 AS INTEGER
        ,@Payment1 AS INTEGER
        ,@Payment2 AS INTEGER
        ,@Payment3 AS INTEGER
        ,@Payment4 AS INTEGER
        ,@Payment5 AS INTEGER;

    SET @Contrib1 = (SELECT SUM(CAST(drvContribSrc1 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Contrib2 = (SELECT SUM(CAST(drvContribSrc2 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Contrib3 = (SELECT SUM(CAST(drvContribSrc3 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Contrib4 = (SELECT SUM(CAST(drvContribSrc4 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);

    SET @Payment1 = (SELECT SUM(CAST(drvLoanPayment1 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Payment2 = (SELECT SUM(CAST(drvLoanPayment2 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Payment3 = (SELECT SUM(CAST(drvLoanPayment3 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Payment4 = (SELECT SUM(CAST(drvLoanPayment4 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);
    SET @Payment5 = (SELECT SUM(CAST(drvLoanPayment5 AS INTEGER)) FROM dbo.U_ECSB401KEX_drvTbl);

    IF OBJECT_ID('U_ECSB401KEX_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ECSB401KEX_Trailer;
    SELECT DISTINCT
         drvPayPeriodEndDate = (SELECT distinct MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   AND PgpPayGroup NOT IN ('HRONLY')
                   GROUP BY PgpPayGroup)
        ,drvContribSrc1Total = RIGHT(SPACE(12) + CASE WHEN @Contrib1 > 0 THEN FORMAT(@Contrib1, '#') ELSE '0' END, 12)
        ,drvContribSrc2Total = RIGHT(SPACE(12) + CASE WHEN @Contrib2 > 0 THEN FORMAT(@Contrib2, '#') ELSE '0' END, 12)
        ,drvContribSrc3Total = RIGHT(SPACE(12) + CASE WHEN @Contrib3 > 0 THEN FORMAT(@Contrib3, '#') ELSE '0' END, 12)
        ,drvContribSrc4Total = RIGHT(SPACE(12) + CASE WHEN @Contrib4 > 0 THEN FORMAT(@Contrib4, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal1 = RIGHT(SPACE(12) + CASE WHEN @Payment1 > 0 THEN FORMAT(@Payment1, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal2 = RIGHT(SPACE(12) + CASE WHEN @Payment2 > 0 THEN FORMAT(@Payment2, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal3 = RIGHT(SPACE(12) + CASE WHEN @Payment3 > 0 THEN FORMAT(@Payment3, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal4 = RIGHT(SPACE(12) + CASE WHEN @Payment4 > 0 THEN FORMAT(@Payment4, '#') ELSE '0' END, 12)
        ,drvLoanPaymentTotal5 = RIGHT(SPACE(12) + CASE WHEN @Payment5 > 0 THEN FORMAT(@Payment5, '#') ELSE '0' END, 12)
    INTO dbo.U_ECSB401KEX_Trailer
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
ALTER VIEW dbo.dsi_vwECSB401KEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECSB401KEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECSB401KEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202008311'
       ,expStartPerControl     = '202008311'
       ,expLastEndPerControl   = '202008319'
       ,expEndPerControl       = '202008319'
WHERE expFormatCode = 'ECSB401KEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwECSB401KEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECSB401KEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort