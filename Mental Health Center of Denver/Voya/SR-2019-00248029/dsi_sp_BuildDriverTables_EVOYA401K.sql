SET NOCOUNT ON;
IF OBJECT_ID('U_EVOYA401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVOYA401K_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVOYA401K' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVOYA401K_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVOYA401K_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVOYA401K') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYA401K];
GO
IF OBJECT_ID('U_EVOYA401K_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_PEarHist];
GO
IF OBJECT_ID('U_EVOYA401K_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_PDedHist];
GO
IF OBJECT_ID('U_EVOYA401K_File') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_File];
GO
IF OBJECT_ID('U_EVOYA401K_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_EEList];
GO
IF OBJECT_ID('U_EVOYA401K_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_drvTbl];
GO
IF OBJECT_ID('U_EVOYA401K_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVOYA401K';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVOYA401K';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVOYA401K';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVOYA401K';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVOYA401K';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EVOYA401K','Voya 401K Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EVOYA401K0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INGWIN6"','1','(''DA''=''F'')','EVOYA401K0Z0','7','D','10','1',NULL,'RECORD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"664449"','2','(''DA''=''F'')','EVOYA401K0Z0','6','D','10','8',NULL,'EMPLOYER ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"6"','3','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','14',NULL,'PAYROLL CYCLE ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrgPayDate"','4','(''UD112''=''F'')','EVOYA401K0Z0','8','D','10','15',NULL,'PAY DATE ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"403B"','5','(''DA''=''F'')','EVOYA401K0Z0','4','D','10','23',NULL,'IRS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','6','(''UA''=''F'')','EVOYA401K0Z0','9','D','10','27',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','7','(''UA''=''F'')','EVOYA401K0Z0','10','D','10','36',NULL,'EMPLOYEE NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','8','(''DA''=''F'')','EVOYA401K0Z0','10','D','10','46',NULL,'DEPARTMENT CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','9','(''DA''=''F'')','EVOYA401K0Z0','4','D','10','56',NULL,'LOCATION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','10','(''UA''=''F'')','EVOYA401K0Z0','20','D','10','60',NULL,'LAST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','11','(''UA''=''F'')','EVOYA401K0Z0','15','D','10','80',NULL,'FIRST NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','12','(''UA''=''F'')','EVOYA401K0Z0','1','D','10','95',NULL,'MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','13','(''UA''=''F'')','EVOYA401K0Z0','25','D','10','96',NULL,'ADDRESS LINE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''F'')','EVOYA401K0Z0','25','D','10','121',NULL,'ADDRESS LINE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','15','(''UA''=''F'')','EVOYA401K0Z0','20','D','10','146',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','16','(''UA''=''F'')','EVOYA401K0Z0','2','D','10','166',NULL,'STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','17','(''UA''=''F'')','EVOYA401K0Z0','5','D','10','168',NULL,'ZIP CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''F'')','EVOYA401K0Z0','4','D','10','173',NULL,'ZIP EXTENSION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','19','(''UA''=''F'')','EVOYA401K0Z0','1','D','10','177',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''DA''=''F'')','EVOYA401K0Z0','20','D','10','178',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','21','(''UA''=''F'')','EVOYA401K0Z0','1','D','10','198',NULL,'MARITAL STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','22','(''UA''=''F'')','EVOYA401K0Z0','1','D','10','199',NULL,'EMPLOYEE STATUS CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','23','(''UD112''=''F'')','EVOYA401K0Z0','8','D','10','200',NULL,'DATE OF BIRTH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOriginalHire"','24','(''UD112''=''F'')','EVOYA401K0Z0','8','D','10','208',NULL,'DATE OF ORIGINAL HIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTermination"','25','(''UD112''=''F'')','EVOYA401K0Z0','8','D','10','216',NULL,'DATE OF TERMINATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','26','(''UD112''=''F'')','EVOYA401K0Z0','8','D','10','224',NULL,'DATE OF REHIRE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoAStartDate"','27','(''UD112''=''F'')','EVOYA401K0Z0','8','D','10','232',NULL,'LEAVE OF ABSENCE START DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLoAStopDate"','28','(''UD112''=''F'')','EVOYA401K0Z0','8','D','10','240',NULL,'LEAVE OF ABSENCE END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''F'')','EVOYA401K0Z0','4','D','10','248',NULL,'PLAN YTD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''F'')','EVOYA401K0Z0','4','D','10','252',NULL,'CURRENT PERIOD HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','31','(''DA''=''F'')','EVOYA401K0Z0','4','D','10','256',NULL,'ANNIVERSARY HOURS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','32','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','260',NULL,'SOURCE CODE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribAmt1"','33','(''UA''=''F'')','EVOYA401K0Z0','9','D','10','261',NULL,'CONTRIBUTION AMOUNT SOURCE # 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"G"','34','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','270',NULL,'SOURCE CODE 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribAmt2"','35','(''UA''=''F'')','EVOYA401K0Z0','9','D','10','271',NULL,'CONTRIBUTION AMOUNT SOURCE # 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D"','36','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','280',NULL,'SOURCE CODE 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribAmt3"','37','(''UA''=''F'')','EVOYA401K0Z0','9','D','10','281',NULL,'CONTRIBUTION AMOUNT SOURCE # 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','290',NULL,'SOURCE CODE 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','291',NULL,'CONTRIBUTION AMOUNT SOURCE # 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','300',NULL,'SOURCE CODE 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','41','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','301',NULL,'CONTRIBUTION AMOUNT SOURCE # 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','42','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','310',NULL,'SOURCE CODE 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','311',NULL,'CONTRIBUTION AMOUNT SOURCE # 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','44','(''DA''=''F'')','EVOYA401K0Z0','3','D','10','320',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLoanPmt1"','45','(''UA''=''F'')','EVOYA401K0Z0','9','D','10','323',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''DA''=''F'')','EVOYA401K0Z0','3','D','10','332',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpLoanPmt2"','47','(''UA''=''F'')','EVOYA401K0Z0','9','D','10','335',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''DA''=''F'')','EVOYA401K0Z0','3','D','10','344',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','49','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','347',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','50','(''DA''=''F'')','EVOYA401K0Z0','3','D','10','356',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','51','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','359',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','52','(''DA''=''F'')','EVOYA401K0Z0','3','D','10','368',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','53','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','371',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''DA''=''F'')','EVOYA401K0Z0','3','D','10','380',NULL,'LOAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','383',NULL,'EMPLOYEE LOAN PAYMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','392',NULL,'UNION MEMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','57','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','393',NULL,'EMPLOYEE ELIGIBILITY CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''DA''=''F'')','EVOYA401K0Z0','8','D','10','394',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''DA''=''F'')','EVOYA401K0Z0','11','D','10','402',NULL,'YTD GROSS COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''DA''=''F'')','EVOYA401K0Z0','11','D','10','413',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''DA''=''F'')','EVOYA401K0Z0','11','D','10','424',NULL,'YTD TEST (ADP/ACP) COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''DA''=''F'')','EVOYA401K0Z0','11','D','10','435',NULL,'YTD ALLOCATION/BENEFIT COMPENSATION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''DA''=''F'')','EVOYA401K0Z0','11','D','10','446',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''DA''=''F'')','EVOYA401K0Z0','11','D','10','457',NULL,'ANNUAL SALARY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''DA''=''F'')','EVOYA401K0Z0','11','D','10','468',NULL,'MISCELLANEOUS COMPENSATION ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','479',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''DA''=''F'')','EVOYA401K0Z0','9','D','10','480',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','489',NULL,'KEY EMPLOYEE INDICATOR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','490',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''DA''=''F'')','EVOYA401K0Z0','5','D','10','491',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','496',NULL,'HIGHLY COMPENSATED EMPLOYEE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','497',NULL,'NON-RESIDENT ALIEN?',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''DA''=''F'')','EVOYA401K0Z0','1','D','10','498',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''DA''=''F'')','EVOYA401K0Z0','40','D','10','499',NULL,'EMAIL ADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''DA''=''F'')','EVOYA401K0Z0','4','D','10','539',NULL,'TIER GROUP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','76','(''DA''=''F'')','EVOYA401K0Z0','10','D','10','543',NULL,'CLIENT DATA 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','77','(''DA''=''F'')','EVOYA401K0Z0','8','D','10','553',NULL,'CLIENT DATE 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','78','(''DA''=''F'')','EVOYA401K0Z0','10','D','10','561',NULL,'FILLER',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVOYA401K_20191227.txt',NULL,'','','',NULL,NULL,NULL,'Voya 401K Export','201912069','EMPEXPORT','ONDEMAND','Dec 11 2019  5:42AM','EVOYA401K',NULL,NULL,NULL,'201912069','Dec 11 2019  5:13AM','Dec 11 2019  5:13AM','201912061','621','','','201912061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVOYA401K_20191227.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','201912069','EMPEXPORT','SCHEDULED','Dec 11 2019  5:42AM','EVOYA401K',NULL,NULL,NULL,'201912069','Dec 11 2019  5:13AM','Dec 11 2019  5:13AM','201912061','621','','','201912061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVOYA401K_20191227.txt',NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','201912069','EMPEXPORT','OEACTIVE','Dec 11 2019  5:42AM','EVOYA401K',NULL,NULL,NULL,'201912069','Dec 11 2019  5:13AM','Dec 11 2019  5:13AM','201912061','295','','','201912061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVOYA401K_20191227.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','201912069','EMPEXPORT','OEPASSIVE','Dec 11 2019  5:42AM','EVOYA401K',NULL,NULL,NULL,'201912069','Dec 11 2019  5:13AM','Dec 11 2019  5:13AM','201912061','621','','','201912061',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EVOYA401K_20191227.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201912069','EMPEXPORT','TEST','Dec 13 2019 12:30PM','EVOYA401K',NULL,NULL,NULL,'201912069','Dec  6 2019 12:00AM','Dec 30 1899 12:00AM','201912061','595','','','201912061',dbo.fn_GetTimedKey(),NULL,'us3lKiMEN1003',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EVOYA401K_20191227.txt' END WHERE expFormatCode = 'EVOYA401K';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYA401K','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYA401K','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYA401K','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYA401K','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYA401K','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EVOYA401K' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EVOYA401K' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EVOYA401K_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYA401K_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYA401K','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYA401K','D10','dbo.U_EVOYA401K_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYA401K','T90','None',NULL);
IF OBJECT_ID('U_EVOYA401K_DedList') IS NULL
CREATE TABLE [dbo].[U_EVOYA401K_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EVOYA401K_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EVOYA401K_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvPrgPayDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfOriginalHire] datetime NULL,
    [drvDateOfTermination] datetime NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvLoAStartDate] datetime NULL,
    [drvLoAStopDate] datetime NULL,
    [drvContribAmt1] nvarchar(4000) NULL,
    [drvContribAmt2] nvarchar(4000) NULL,
    [drvContribAmt3] nvarchar(4000) NULL,
    [drvEmpLoanPmt1] nvarchar(4000) NULL,
    [drvEmpLoanPmt2] nvarchar(4000) NULL,
    [drvAnnualSal] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EVOYA401K_EEList') IS NULL
CREATE TABLE [dbo].[U_EVOYA401K_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVOYA401K_File') IS NULL
CREATE TABLE [dbo].[U_EVOYA401K_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EVOYA401K_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EVOYA401K_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh403B] numeric NULL,
    [Pdh403R] numeric NULL,
    [Pdh403M] numeric NULL,
    [Pdh403L] numeric NULL,
    [Pdh403L2] numeric NULL
);
IF OBJECT_ID('U_EVOYA401K_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EVOYA401K_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYA401K]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Mental Health Center of Denver

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/11/2019
Service Request Number: SR-2019-00248029

Purpose: Voya 401K Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EVOYA401K';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EVOYA401K';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EVOYA401K';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EVOYA401K';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVOYA401K' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYA401K', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYA401K', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EVOYA401K', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EVOYA401K';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EVOYA401K', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EVOYA401K';

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
    DELETE FROM dbo.U_EVOYA401K_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EVOYA401K_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE from  dbo.U_EVOYA401K_EEList  where xeeid in (select distinct EEcEEid  from EmpComp where EecEEType IN ('VOC', 'TMP', 'TST'))

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '403B,403BF,403R,403RF,403M,403L,403L2';

    IF OBJECT_ID('U_EVOYA401K_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYA401K_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVOYA401K_DedList
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
    IF OBJECT_ID('U_EVOYA401K_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYA401K_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh403B     = SUM(CASE WHEN PdhDedCode IN ('403B', '403BF') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403R     = SUM(CASE WHEN PdhDedCode IN ('403R', '403RF') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403M     = SUM(CASE WHEN PdhDedCode IN ('403M') THEN PdhERCurAmt ELSE 0.00 END) 
        ,Pdh403L     = SUM(CASE WHEN PdhDedCode IN ('403L') THEN PdhEECurAmt ELSE 0.00 END)
        ,Pdh403L2     = SUM(CASE WHEN PdhDedCode IN ('403L2') THEN PdhEECurAmt ELSE 0.00 END)
/*        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)*/
    INTO dbo.U_EVOYA401K_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EVOYA401K_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EVOYA401K_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYA401K_PEarHist;
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
    INTO dbo.U_EVOYA401K_PEarHist
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
    -- DETAIL RECORD - U_EVOYA401K_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EVOYA401K_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYA401K_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvPrgPayDate = NextPayDate
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvGender = EepGender
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'M' 
                                WHEN eepMaritalStatus = 'S' THEN 'S'
                                WHEN eepMaritalStatus NOT IN ('M', 'S') THEN 'S'
                                ELSE '' 
                            END
        ,drvEmplStatus =    CASE EecEmplStatus
                                WHEN 'T' THEN 'T'
                                WHEN 'L' THEN 'L'
                                ELSE 'A'
                            END
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfOriginalHire = EecDateOfOriginalHire
        ,drvDateOfTermination = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateOfLastHire = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvLoAStartDate = CASE WHEN eecEmplStatus = 'L' THEN (
                                SELECT MAX(EshStatusStartDate) 
                                FROM EmpHStat WITH (NOLOCK) 
                                WHERE EshEmplStatus = 'L' 
                                AND EshEEID = xEEID 
                                AND EshCOID = xCOID) 
                            END 
        ,drvLoAStopDate = CASE WHEN eecEmplStatus = 'L' THEN (
                                SELECT EshStatusStopDate 
                                FROM EmpHStat WITH (NOLOCK) 
                                WHERE EshEmplStatus = 'L' 
                                AND EshEEID = xEEID 
                                AND EshCOID = xCOID 
                                AND EshStatusStartDate = (
                                            SELECT MAX(EshStatusStartDate) 
                                            FROM EmpHStat WITH (NOLOCK) 
                                            WHERE EshEmplStatus = 'L' 
                                            AND EshEEID = xEEID 
                                            AND EshCOID = xCOID))
                            END 
        ,drvContribAmt1 = FORMAT(Pdh403B*100, '000000000')
        ,drvContribAmt2 =   FORMAT(Pdh403R*100, '000000000')
        ,drvContribAmt3 = FORMAT(Pdh403M*100, '000000000')
        ,drvEmpLoanPmt1 = CASE WHEN Pdh403L > 0 THEN FORMAT(Pdh403L*100, '000000000') END
        ,drvEmpLoanPmt2 =  CASE WHEN Pdh403L2 > 0 THEN FORMAT(Pdh403L2*100, '000000000') END
        ,drvAnnualSal = FORMAT(eecAnnSalary*100, '000000000')
    INTO dbo.U_EVOYA401K_drvTbl
    FROM dbo.U_EVOYA401K_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EVOYA401K_PDedHist WITH (NOLOCK)
        ON pdhEEID = xEEID
    JOIN (SELECT prgEEID
            ,MAX(prgPayDate)  as NextPayDate 
                from payReg  WITH (NOLOCK)
                WHERE prgPayDate between LEFT(@StartPerControl, 8) AND LEFT(@EndPerControl, 8)
                --LEFT('201912061', 8) AND LEFT('201912069', 8)
                GROUP BY PrgEEId) as payRegConsolidated
        ON payRegConsolidated.prgEEID = xEEId
    WHERE eecEEType NOT IN ('VOC', 'TMP')
    AND EecEmplStatus <> 'T'
        OR (EecEmplStatus = 'T'
            AND EecDateOfTermination >= DATEADD(day, -30, GETDATE()))
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
ALTER VIEW dbo.dsi_vwEVOYA401K_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EVOYA401K_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EVOYA401K%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912061'
       ,expStartPerControl     = '201912061'
       ,expLastEndPerControl   = '201912069'
       ,expEndPerControl       = '201912069'
WHERE expFormatCode = 'EVOYA401K';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEVOYA401K_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EVOYA401K_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort