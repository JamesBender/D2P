SET NOCOUNT ON;
IF OBJECT_ID('U_ESPAWED401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESPAWED401_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESPAWED401' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESPAWED401_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESPAWED401_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESPAWED401') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESPAWED401];
GO
IF OBJECT_ID('U_ESPAWED401_Trailer') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_Trailer];
GO
IF OBJECT_ID('U_ESPAWED401_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_PEarHist];
GO
IF OBJECT_ID('U_ESPAWED401_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_PDedHist];
GO
IF OBJECT_ID('U_ESPAWED401_Header') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_Header];
GO
IF OBJECT_ID('U_ESPAWED401_File') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_File];
GO
IF OBJECT_ID('U_ESPAWED401_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_EEList];
GO
IF OBJECT_ID('U_ESPAWED401_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_drvTbl];
GO
IF OBJECT_ID('U_ESPAWED401_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESPAWED401') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESPAWED401];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESPAWED401';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESPAWED401';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESPAWED401';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESPAWED401';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESPAWED401';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESPAWED401','TIAA 401(k) Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','ESPAWED401Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeader"','1','(''UA''=''T|'')','ESPAWED401Z0','6','H','01','1',NULL,'HEADER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDataTYpe"','2','(''UA''=''T|'')','ESPAWED401Z0','2','H','01','2',NULL,'DATA TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDataSource"','3','(''UA''=''T|'')','ESPAWED401Z0','30','H','01','3',NULL,'DATA SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCreationDateTime"','4','(''UA''=''T|'')','ESPAWED401Z0','15','H','01','4',NULL,'CREATION DATE / TIME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContact"','5','(''UA''=''T|'')','ESPAWED401Z0','40','H','01','5',NULL,'CONTACT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSender"','6','(''UA''=''T|'')','ESPAWED401Z0','40','H','01','6',NULL,'Sender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSparkVersion"','7','(''UA''=''T|'')','ESPAWED401Z0','4','H','01','7',NULL,'SPARK VERSION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAsOfDate"','8','(''UD112''=''T|'')','ESPAWED401Z0','8','H','01','8',NULL,'AS OF DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanStartDate"','9','(''UD112''=''T'')','ESPAWED401Z0','8','H','01','9',NULL,'PLAN START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordId"','1','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','1',NULL,'DETAIL RECORD ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerName"','2','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','2',NULL,'EMPLOYER NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerEin"','3','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','3',NULL,'EMPLOYER EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerPlanId"','4','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','4',NULL,'EMPLOYER PLAN ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubPlanId"','5','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','5',NULL,'EMPLOYER SUB PLAN ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigVendorPlanId"','6','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','6',NULL,'ORIGINATING VENDOR PLAN ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigVendorSubPlanId"','7','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','7',NULL,'ORIGINATING VENDOR SUB PLAN ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecipientVendorPlanId"','8','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','8',NULL,'RECIPIENT VENDOR PLAN ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecipientVendorSubPlanId"','9','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','9',NULL,'RECIPIENT VENDOR SUB PLAN ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTypeOfAccount"','10','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','10',NULL,'TYPE OF ACCOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequency"','11','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','11',NULL,'PAYROLL FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','12','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','12',NULL,'EMPLOYEE SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','13','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','13',NULL,'EMPLOYEE ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTitile"','14','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','14',NULL,'EMPLOYEE TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpFirstName"','15','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','15',NULL,'EMPLOYEE FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMiddleName"','16','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','16',NULL,'EMPLOYEE MIDDLE NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLastName"','17','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','17',NULL,'EMPLOYEE LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','18','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','18',NULL,'ADDRESS LINE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','19','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','19',NULL,'ADDRESS LINE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','20','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','20',NULL,'ADDRESS LINE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','21','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','21',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','22','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','22',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','23','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','23',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','24','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','24',NULL,'COUNTRY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvResidenceCode"','25','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','25',NULL,'RESIDENCY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','26','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','26',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','27','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','27',NULL,'GENDER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMarialStatus"','28','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','28',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber1"','29','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','29',NULL,'PHONE NUMBER1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumberType1"','30','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','30',NULL,'PHONE NUMBER TYPE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneExt1"','31','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','31',NULL,'PHONE EXTENSION1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber2"','32','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','32',NULL,'PHONE NUMBER2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumberType2"','33','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','33',NULL,'PHONE NUMBER TYPE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneExt2"','34','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','34',NULL,'PHONE EXTENSION2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','35','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','35',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollDate"','36','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','36',NULL,'PAYROLL DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode1"','37','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','37',NULL,'CONTRIBUTION SOURCE CODE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt1"','38','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','38',NULL,'CONTRIBUTION SOURCE AMOUNT1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode2"','39','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','39',NULL,'CONTRIBUTION SOURCE CODE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt2"','40','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','40',NULL,'CONTRIBUTION SOURCE AMOUNT2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode3"','41','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','41',NULL,'CONTRIBUTION SOURCE CODE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt3"','42','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','42',NULL,'CONTRIBUTION SOURCE AMOUNT3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode4"','43','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','43',NULL,'CONTRIBUTION SOURCE CODE4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt4"','44','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','44',NULL,'CONTRIBUTION SOURCE AMOUNT4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode5"','45','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','45',NULL,'CONTRIBUTION SOURCE CODE5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt5"','46','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','46',NULL,'CONTRIBUTION SOURCE AMOUNT5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode6"','47','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','47',NULL,'CONTRIBUTION SOURCE CODE6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt6"','48','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','48',NULL,'CONTRIBUTION SOURCE AMOUNT6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode7"','49','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','49',NULL,'CONTRIBUTION SOURCE CODE7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt7"','50','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','50',NULL,'CONTRIBUTION SOURCE AMOUNT7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCode8"','51','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','51',NULL,'CONTRIBUTION SOURCE CODE8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceAmt8"','52','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','52',NULL,'CONTRIBUTION SOURCE AMOUNT8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber1"','53','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','53',NULL,'LOAN NUMBER 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepaymentAmt1"','54','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','54',NULL,'LOAN REPAYMENT AMOUNT1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber2"','55','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','55',NULL,'LOAN NUMBER 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepaymentAmt2"','56','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','56',NULL,'LOAN REPAYMENT AMOUNT2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber3"','57','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','57',NULL,'LOAN NUMBER 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepaymentAmt3"','58','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','58',NULL,'LOAN REPAYMENT AMOUNT3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber4"','59','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','59',NULL,'LOAN NUMBER 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepaymentAmt4"','60','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','60',NULL,'LOAN REPAYMENT AMOUNT4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanNumber5"','61','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','61',NULL,'LOAN NUMBER 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanRepaymentAmt5"','62','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','62',NULL,'LOAN REPAYMENT AMOUNT5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','63','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','63',NULL,'HR AREA / LOCATION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubArea"','64','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','64',NULL,'HR SUB AREA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','65','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','65',NULL,'DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjDateOfHire"','66','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','66',NULL,'ADJUSTED DATE OF HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','67','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','67',NULL,'EMPLOYMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentSubType"','68','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','68',NULL,'EMPLOYMENT SUB-TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpoymentStatusDate"','69','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','69',NULL,'EMPLOYMENT STATUS DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','70','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','70',NULL,'EMPLOYEE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollMode"','71','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','71',NULL,'PAYROLL MODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfService"','72','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','72',NULL,'YEARS OF SERVICE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','73','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','73',NULL,'ANNUAL SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExcludableCompensation"','74','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','74',NULL,'EXCLUDABLE COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPerPayCompensation"','75','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','75',NULL,'PER PAY COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPerHoursWorked"','76','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','76',NULL,'PER PAY HOURS WORKED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDType"','77','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','77',NULL,'YEAR TO DATE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDBaseCompensation"','78','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','78',NULL,'YEAR TO DATE BASE COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDTotalCompensation"','79','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','79',NULL,'YEAR TO DATE TOTAL COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDHoursWorked"','80','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','80',NULL,'YEAR TO DATE HOURS WORKED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHCEFlag"','81','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','81',NULL,'HCE FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployeeFlag"','82','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','82',NULL,'KEY EMPLOYEE FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAeExclusionFlag"','83','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','83',NULL,'AE EXCLUSION FLAG',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployePlanStatus"','84','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','84',NULL,'EMPLOYEE PLAN STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEntryDate"','85','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','85',NULL,'PLAN ENTRY DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanVestedDate"','86','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','86',NULL,'VESTED DATE VESTED DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustmentEndDate"','87','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','87',NULL,'ADJUSTMENT END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCodeOne"','88','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','88',NULL,'CONTRIBUTION SOURCE CODE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeferallPercentage1"','89','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','89',NULL,'DEFERRAL PERCENTAGE - CS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayperDefAmount1"','90','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','90',NULL,'PAY PER DEFERRAL AMOUNT - CS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCodeTwo"','91','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','91',NULL,'CONTRIBUTION SOURCE CODE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeferallPercentage2"','92','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','92',NULL,'DEFERRAL PERCENTAGE - CS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayperDefAmount2"','93','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','93',NULL,'PAY PER DEFERRAL AMOUNT - CS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribSourceCodeThree"','94','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','94',NULL,'CONTRIBUTION SOURCE CODE3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeferallPercentage3"','95','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','95',NULL,'DEFERRAL PERCENTAGE - CS3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayperDefAmount3"','96','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','96',NULL,'PAY PER DEFERRAL AMOUNT - CS3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanAnnualSalary"','97','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','97',NULL,'PLAN ANNUAL SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribEligSource1"','98','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','98',NULL,'EMPLOYER CONTRIBUTION ELIGIBILITY SOURCE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribEligDate1"','99','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','99',NULL,'EMPLOYER CONTRIBUTION ELIGIBILITY DATE1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribEligSource2"','100','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','100',NULL,'EMPLOYER CONTRIBUTION ELIGIBILITY SOURCE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribEligDate2"','101','(''UD112''=''T|'')','ESPAWED401Z0','50','D','10','101',NULL,'EMPLOYER CONTRIBUTION ELIGIBILITY DATE2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncType"','102','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','102',NULL,'AUTOMATIC DEFERRAL  INCREASE TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncElecDate"','103','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','103',NULL,'AUTOMATIC DEFERRAL INCREASE ELECTION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncNxtEDate"','104','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','104',NULL,'AUTOMATIC DEFERRAL INCREASE NEXT INCREASE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncEndDate"','105','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','105',NULL,'AUTOMATIC DEFERRAL INCREASE END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncFreq1"','106','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','106',NULL,'AUTOMATIC DEFERRAL INCREASE FREQUENCY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncAmt"','107','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','107',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncAmtMax"','108','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','108',NULL,'AUTOMATIC DEFERRAL INCREASE AMOUNT MAXIMUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncPerct"','109','(''UA''=''T|'')','ESPAWED401Z0','50','D','10','109',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoDefIncPerctMax"','110','(''UA''=''T'')','ESPAWED401Z0','50','D','10','110',NULL,'AUTOMATIC DEFERRAL INCREASE PERCENTAGE MAXIMUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailer"','1','(''UA''=''T|'')','ESPAWED401Z0','50','T','90','1',NULL,'TRAILER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordCount"','2','(''UA''=''T|'')','ESPAWED401Z0','50','T','90','2',NULL,'RECORD COUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRemittanceAmount"','3','(''UA''=''T|'')','ESPAWED401Z0','50','T','90','3',NULL,'REMITTANCE AMOUNT TOTAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoanAmountTotal"','4','(''UA''=''T|'')','ESPAWED401Z0','50','T','90','4',NULL,'LOAN AMOUNT TOTAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFiller"','5','(''UA''=''T'')','ESPAWED401Z0','50','T','90','5',NULL,'FILLER',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESPAWED401_20190911.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TIAA 401(k) Export','201909099','EMPEXPORT','ONDEMAND',NULL,'ESPAWED401',NULL,NULL,NULL,'201909099','Sep  9 2019  3:18PM','Sep  9 2019  3:18PM','201909091',NULL,'','','201909091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESPAWED401_20190911.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201909099','EMPEXPORT','TEST','Sep 11 2019 10:51AM','ESPAWED401',NULL,NULL,NULL,'201909099','Sep  9 2019  3:18PM','Sep  9 2019  3:18PM','201909091','831','','','201909091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESPAWED401_20190911.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201909099','EMPEXPORT','SCHEDULED',NULL,'ESPAWED401',NULL,NULL,NULL,'201909099','Sep  9 2019  3:18PM','Sep  9 2019  3:18PM','201909091',NULL,'','','201909091',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ESPAWED401_20190911.txt' END WHERE expFormatCode = 'ESPAWED401';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPAWED401','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPAWED401','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPAWED401','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPAWED401','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESPAWED401','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ESPAWED401' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESPAWED401' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ESPAWED401_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESPAWED401_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPAWED401','H01','dbo.U_ESPAWED401_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPAWED401','D10','dbo.U_ESPAWED401_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESPAWED401','T90','dbo.U_ESPAWED401_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_ESPAWED401') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESPAWED401] (
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
IF OBJECT_ID('U_ESPAWED401_DedList') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESPAWED401_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvRecordId] varchar(1) NOT NULL,
    [drvEmployerName] varchar(6) NOT NULL,
    [drvEmployerEin] varchar(1) NOT NULL,
    [drvEmployerPlanId] varchar(6) NOT NULL,
    [drvSubPlanId] varchar(3) NOT NULL,
    [drvOrigVendorPlanId] varchar(1) NOT NULL,
    [drvOrigVendorSubPlanId] varchar(1) NOT NULL,
    [drvRecipientVendorPlanId] varchar(6) NOT NULL,
    [drvRecipientVendorSubPlanId] varchar(3) NOT NULL,
    [drvTypeOfAccount] varchar(1) NOT NULL,
    [drvPayrollFrequency] varchar(2) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeTitile] varchar(1) NOT NULL,
    [drvEmpFirstName] varchar(100) NULL,
    [drvEmpMiddleName] varchar(1) NULL,
    [drvEmpLastName] varchar(100) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvResidenceCode] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvGender] char(1) NULL,
    [drvMarialStatus] varchar(1) NOT NULL,
    [drvPhoneNumber1] varchar(50) NULL,
    [drvPhoneNumberType1] varchar(2) NOT NULL,
    [drvPhoneExt1] varchar(1) NOT NULL,
    [drvPhoneNumber2] varchar(1) NOT NULL,
    [drvPhoneNumberType2] varchar(1) NOT NULL,
    [drvPhoneExt2] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPayrollDate] varchar(1) NOT NULL,
    [drvContribSourceCode1] varchar(1) NOT NULL,
    [drvContribSourceAmt1] varchar(1) NOT NULL,
    [drvContribSourceCode2] varchar(1) NOT NULL,
    [drvContribSourceAmt2] varchar(1) NOT NULL,
    [drvContribSourceCode3] varchar(1) NOT NULL,
    [drvContribSourceAmt3] varchar(1) NOT NULL,
    [drvContribSourceCode4] varchar(1) NOT NULL,
    [drvContribSourceAmt4] varchar(1) NOT NULL,
    [drvContribSourceCode5] varchar(1) NOT NULL,
    [drvContribSourceAmt5] varchar(1) NOT NULL,
    [drvContribSourceCode6] varchar(1) NOT NULL,
    [drvContribSourceAmt6] varchar(1) NOT NULL,
    [drvContribSourceCode7] varchar(1) NOT NULL,
    [drvContribSourceAmt7] varchar(1) NOT NULL,
    [drvContribSourceCode8] varchar(1) NOT NULL,
    [drvContribSourceAmt8] varchar(1) NOT NULL,
    [drvLoanNumber1] varchar(1) NOT NULL,
    [drvLoanRepaymentAmt1] varchar(1) NOT NULL,
    [drvLoanNumber2] varchar(1) NOT NULL,
    [drvLoanRepaymentAmt2] varchar(1) NOT NULL,
    [drvLoanNumber3] varchar(1) NOT NULL,
    [drvLoanRepaymentAmt3] varchar(1) NOT NULL,
    [drvLoanNumber4] varchar(1) NOT NULL,
    [drvLoanRepaymentAmt4] varchar(1) NOT NULL,
    [drvLoanNumber5] varchar(1) NOT NULL,
    [drvLoanRepaymentAmt5] varchar(1) NOT NULL,
    [drvLocationCode] varchar(1) NOT NULL,
    [drvSubArea] varchar(1) NOT NULL,
    [drvDateOfHire] datetime NULL,
    [drvAdjDateOfHire] datetime NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvEmploymentSubType] varchar(1) NOT NULL,
    [drvEmpoymentStatusDate] datetime NULL,
    [drvEmployeeType] varchar(1) NOT NULL,
    [drvPayrollMode] varchar(3) NOT NULL,
    [drvYearsOfService] varchar(1) NOT NULL,
    [drvAnnualSalary] money NULL,
    [drvExcludableCompensation] varchar(1) NOT NULL,
    [drvPerPayCompensation] varchar(1) NOT NULL,
    [drvPerHoursWorked] varchar(1) NOT NULL,
    [drvYTDType] varchar(1) NOT NULL,
    [drvYTDBaseCompensation] varchar(1) NOT NULL,
    [drvYTDTotalCompensation] varchar(1) NOT NULL,
    [drvYTDHoursWorked] varchar(1) NOT NULL,
    [drvHCEFlag] varchar(1) NOT NULL,
    [drvKeyEmployeeFlag] varchar(1) NOT NULL,
    [drvAeExclusionFlag] varchar(1) NOT NULL,
    [drvEmployePlanStatus] varchar(1) NOT NULL,
    [drvPlanEntryDate] varchar(1) NOT NULL,
    [drvPlanVestedDate] datetime NULL,
    [drvAdjustmentEndDate] varchar(1) NOT NULL,
    [drvContribSourceCodeOne] varchar(1) NOT NULL,
    [drvDeferallPercentage1] varchar(1) NOT NULL,
    [drvPayperDefAmount1] varchar(1) NOT NULL,
    [drvContribSourceCodeTwo] varchar(1) NOT NULL,
    [drvDeferallPercentage2] varchar(1) NOT NULL,
    [drvPayperDefAmount2] varchar(1) NOT NULL,
    [drvContribSourceCodeThree] varchar(1) NOT NULL,
    [drvDeferallPercentage3] varchar(1) NOT NULL,
    [drvPayperDefAmount3] varchar(1) NOT NULL,
    [drvPlanAnnualSalary] varchar(1) NOT NULL,
    [drvContribEligSource1] varchar(1) NOT NULL,
    [drvContribEligDate1] int NULL,
    [drvContribEligSource2] varchar(1) NOT NULL,
    [drvContribEligDate2] int NULL,
    [drvAutoDefIncType] varchar(1) NOT NULL,
    [drvAutoDefIncElecDate] varchar(1) NOT NULL,
    [drvAutoDefIncNxtEDate] varchar(1) NOT NULL,
    [drvAutoDefIncEndDate] varchar(1) NOT NULL,
    [drvAutoDefIncFreq1] varchar(1) NOT NULL,
    [drvAutoDefIncAmt] varchar(1) NOT NULL,
    [drvAutoDefIncAmtMax] varchar(1) NOT NULL,
    [drvAutoDefIncPerct] varchar(1) NOT NULL,
    [drvAutoDefIncPerctMax] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESPAWED401_EEList') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESPAWED401_File') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_ESPAWED401_Header') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_Header] (
    [drvHeader] varchar(6) NOT NULL,
    [drvDataTYpe] varchar(2) NOT NULL,
    [drvDataSource] varchar(6) NOT NULL,
    [drvCreationDateTime] varchar(15) NOT NULL,
    [drvContact] varchar(1) NOT NULL,
    [drvSender] varchar(1) NOT NULL,
    [drvSparkVersion] varchar(4) NOT NULL,
    [drvAsOfDate] varchar(8) NULL,
    [drvPlanStartDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ESPAWED401_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_PDedHist] (
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
IF OBJECT_ID('U_ESPAWED401_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_PEarHist] (
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
IF OBJECT_ID('U_ESPAWED401_Trailer') IS NULL
CREATE TABLE [dbo].[U_ESPAWED401_Trailer] (
    [drvTrailer] varchar(7) NOT NULL,
    [drvRecordCount] varchar(24) NULL,
    [drvRemittanceAmount] varchar(1) NOT NULL,
    [drvLoanAmountTotal] varchar(1) NOT NULL,
    [drvFiller] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESPAWED401]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: WestEd

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 09/09/2019
Service Request Number: TekP-2019-8-28-0002

Purpose: TIAA 401(k) Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESPAWED401';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESPAWED401';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESPAWED401';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESPAWED401';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESPAWED401' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESPAWED401', 'ONDEMAND';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESPAWED401';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESPAWED401', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime Varchar(6);

    -- Set FormatCode
    SELECT @FormatCode = 'ESPAWED401';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108),':',SPACE(0))
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESPAWED401_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESPAWED401_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Clean EE List where Employee Type = TES to avoid Test employee from the file
    DELETE FROM dbo.U_ESPAWED401_EEList
    WHERE xCOID =  dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND  xEEID IN (Select distinct eeceeid from empcomp (nolock) where EecEEType = 'TES')
     

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'TIA3F,TIA3P,TIAAS,TIA3M,TIA7P,TIAA7,TIAA5';

    IF OBJECT_ID('U_ESPAWED401_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESPAWED401_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESPAWED401_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');    
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESPAWED401_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESPAWED401_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('TIA3F','TIA3P') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('TIAAS','TIA3M') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_ESPAWED401_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESPAWED401_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESPAWED401_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESPAWED401_PEarHist;
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
    INTO dbo.U_ESPAWED401_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESPAWED401_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESPAWED401_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESPAWED401_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        --,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        -- standard fields above and additional driver fields below
        ,drvRecordId = 'D'
        ,drvEmployerName = 'WESTED'
        ,drvEmployerEin = ''
        ,drvEmployerPlanId = '104189'
        ,drvSubPlanId = 'GOR'
        ,drvOrigVendorPlanId = ''
        ,drvOrigVendorSubPlanId = ''
        ,drvRecipientVendorPlanId = '104189'
        ,drvRecipientVendorSubPlanId = 'GOR'
        ,drvTypeOfAccount = ''
        ,drvPayrollFrequency = '26'
        ,drvEmployeeSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvEmployeeTitile = ''
        ,drvEmpFirstName = EepNameFirst
        ,drvEmpMiddleName = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvEmpLastName = EepNameLast
        ,drvAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvAddressLine3 = ''
        ,drvCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvCountryCode = 'US'
        ,drvResidenceCode = 'U'
        ,drvDateOfBirth = EepDateOfBirth
        ,drvGender = EepGender
        ,drvMarialStatus = CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'S' END
        ,drvPhoneNumber1 = EepPhoneHomeNumber
        ,drvPhoneNumberType1 = 'HN'
        ,drvPhoneExt1 = ''
        ,drvPhoneNumber2 = ''
        ,drvPhoneNumberType2 = ''
        ,drvPhoneExt2 = ''
        ,drvEmailAddress = EepAddressEMail
        ,drvPayrollDate = ''
        ,drvContribSourceCode1 = ''
        ,drvContribSourceAmt1 = ''
        ,drvContribSourceCode2 = ''
        ,drvContribSourceAmt2 = ''
        ,drvContribSourceCode3 = ''
        ,drvContribSourceAmt3 = ''
        ,drvContribSourceCode4 = ''
        ,drvContribSourceAmt4 = ''
        ,drvContribSourceCode5 = ''
        ,drvContribSourceAmt5 = ''
        ,drvContribSourceCode6 = ''
        ,drvContribSourceAmt6 = ''
        ,drvContribSourceCode7 = ''
        ,drvContribSourceAmt7 = ''
        ,drvContribSourceCode8 = ''
        ,drvContribSourceAmt8 = ''
        ,drvLoanNumber1 = ''
        ,drvLoanRepaymentAmt1 = ''
        ,drvLoanNumber2 = ''
        ,drvLoanRepaymentAmt2 = ''
        ,drvLoanNumber3 = ''
        ,drvLoanRepaymentAmt3 = ''
        ,drvLoanNumber4 = ''
        ,drvLoanRepaymentAmt4 = ''
        ,drvLoanNumber5 = ''
        ,drvLoanRepaymentAmt5 = ''
        ,drvLocationCode = ''
        ,drvSubArea = ''
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvAdjDateOfHire = EecDateOfLastHire
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'T' THEN 'T'
                                    WHEN EecEmplStatus = 'L' THEN  'L'
                                    ELSE 'E' 
                                END
        ,drvEmploymentSubType = CASE  WHEN EecEmplStatus IN ('A','S') AND EecDateOfOriginalHire <> EecDateOfLastHire  THEN 'R'
                                                   ELSE 'O' 
                                END
        ,drvEmpoymentStatusDate = EecDateOfLastHire
        ,drvEmployeeType = 'F'
        ,drvPayrollMode = '100'
        ,drvYearsOfService = ''
        ,drvAnnualSalary = EecAnnSalary
        ,drvExcludableCompensation = ''
        ,drvPerPayCompensation = ''
        ,drvPerHoursWorked = ''
        ,drvYTDType = ''
        ,drvYTDBaseCompensation = ''
        ,drvYTDTotalCompensation = ''
        ,drvYTDHoursWorked = ''
        ,drvHCEFlag = ''
        ,drvKeyEmployeeFlag = ''
        ,drvAeExclusionFlag = ''
        ,drvEmployePlanStatus = ''
        ,drvPlanEntryDate = ''
        ,drvPlanVestedDate = BdmBenStartDate
        ,drvAdjustmentEndDate = ''
        ,drvContribSourceCodeOne = ''
        ,drvDeferallPercentage1 = ''
        ,drvPayperDefAmount1 = ''
        ,drvContribSourceCodeTwo = ''
        ,drvDeferallPercentage2 = ''
        ,drvPayperDefAmount2 = ''
        ,drvContribSourceCodeThree = ''
        ,drvDeferallPercentage3 = ''
        ,drvPayperDefAmount3 = ''
        ,drvPlanAnnualSalary = ''
        ,drvContribEligSource1 = ''
        ,drvContribEligDate1 = NULL
        ,drvContribEligSource2 = ''
        ,drvContribEligDate2 = NULL
        ,drvAutoDefIncType = ''
        ,drvAutoDefIncElecDate = ''
        ,drvAutoDefIncNxtEDate = ''
        ,drvAutoDefIncEndDate = ''
        ,drvAutoDefIncFreq1 = ''
        ,drvAutoDefIncAmt = ''
        ,drvAutoDefIncAmtMax = ''
        ,drvAutoDefIncPerct = ''
        ,drvAutoDefIncPerctMax = ''
    INTO dbo.U_ESPAWED401_drvTbl
    FROM dbo.U_ESPAWED401_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_ESPAWED401 WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESPAWED401_Header','U') IS NOT NULL
        DROP TABLE dbo.U_ESPAWED401_Header;
    SELECT DISTINCT
         drvHeader = 'SPARKH'
        ,drvDataTYpe = '04'
        ,drvDataSource = 'WESTED'
        ,drvCreationDateTime = CONCAT(@RunDate,'-',@RunTime)
        ,drvContact = ''
        ,drvSender = ''
        ,drvSparkVersion = '1.00'
        ,drvAsOfDate = @RunDate
        ,drvPlanStartDate = ''
    INTO dbo.U_ESPAWED401_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_ESPAWED401_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_ESPAWED401_Trailer;
    SELECT DISTINCT
         drvTrailer = 'SPARKTR'
        ,drvRecordCount = dbo.dsi_fnpadzero((ISNULL((Select count(*) + 2 from U_ESPAWED401_drvTbl),0)),10,0)
        ,drvRemittanceAmount = ''
        ,drvLoanAmountTotal = ''
        ,drvFiller = ''
    INTO dbo.U_ESPAWED401_Trailer
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'ESPAWED401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ETESTWED401_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESPAWED401_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESPAWED401_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESPAWED401%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201909021'
       ,expStartPerControl     = '201909021'
       ,expLastEndPerControl   = '201909099'
       ,expEndPerControl       = '201909099'
WHERE expFormatCode = 'ESPAWED401';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESPAWED401_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESPAWED401_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort