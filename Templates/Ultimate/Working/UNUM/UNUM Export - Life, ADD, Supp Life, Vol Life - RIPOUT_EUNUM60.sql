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
@CustomFormatCode - Replace with Format Code (i.e., @CustomFormatCode)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., UNUM Export - Life, ADD, Supp. Life, and Vol. Life)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Export parameters
@ClientName - Replace with Client Name in Header Record
@DedCodeList - Replace with list of Deduction Codes (i.e., @CustomFormatCode)

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\UNUM\)
@FileTestPath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\UNUM\)
@FileUDESPath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@CompanyCode - Replace with Company Code in File Name

*/
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
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

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"eEnroll2"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','01','1',NULL,'eEnroll2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"POLICY"','2','(''DA''=''T,'')',@AdhSystemID,'50','H','01','2',NULL,'POLICY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DIVISION"','3','(''DA''=''T,'')',@AdhSystemID,'50','H','01','3',NULL,'DIVISION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MEMBER ID"','4','(''DA''=''T,'')',@AdhSystemID,'50','H','01','4',NULL,'MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRI DIV"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','01','5',NULL,'PRI DIV',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DOH"','6','(''DA''=''T,'')',@AdhSystemID,'50','H','01','6',NULL,'DOH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SALARY"','7','(''DA''=''T,'')',@AdhSystemID,'50','H','01','7',NULL,'SALARY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SALARY MODE"','8','(''DA''=''T,'')',@AdhSystemID,'50','H','01','8',NULL,'SALARY MODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"HOURS"','9','(''DA''=''T,'')',@AdhSystemID,'50','H','01','9',NULL,'HOURS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TERM DATE"','10','(''DA''=''T,'')',@AdhSystemID,'50','H','01','10',NULL,'TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"TERM REASON"','11','(''DA''=''T,'')',@AdhSystemID,'50','H','01','11',NULL,'TERM REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"NEW MEMBER ID"','12','(''DA''=''T,'')',@AdhSystemID,'50','H','01','12',NULL,'NEW MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FIRST NAME"','13','(''DA''=''T,'')',@AdhSystemID,'50','H','01','13',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MIDDLE NAME"','14','(''DA''=''T,'')',@AdhSystemID,'50','H','01','14',NULL,'MIDDLE NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LAST NAME"','15','(''DA''=''T,'')',@AdhSystemID,'50','H','01','15',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SUFFIX"','16','(''DA''=''T,'')',@AdhSystemID,'50','H','01','16',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"GENDER"','17','(''DA''=''T,'')',@AdhSystemID,'50','H','01','17',NULL,'GENDER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DOB"','18','(''DA''=''T,'')',@AdhSystemID,'50','H','01','18',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SPOUSE FIRST NAME"','19','(''DA''=''T,'')',@AdhSystemID,'50','H','01','19',NULL,'SPOUSE FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SPOUSE GDR"','20','(''DA''=''T,'')',@AdhSystemID,'50','H','01','20',NULL,'SPOUSE GDR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SPOUSE DOB"','21','(''DA''=''T,'')',@AdhSystemID,'50','H','01','21',NULL,'SPOUSE DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CLASS"','22','(''DA''=''T,'')',@AdhSystemID,'50','H','01','22',NULL,'CLASS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SIGNATURE DATE"','23','(''DA''=''T,'')',@AdhSystemID,'50','H','01','23',NULL,'SIGNATURE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EFFECTIVE DATE"','24','(''DA''=''T,'')',@AdhSystemID,'50','H','01','24',NULL,'EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ADD TYPE"','25','(''DA''=''T,'')',@AdhSystemID,'50','H','01','25',NULL,'ADD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT ID"','26','(''DA''=''T,'')',@AdhSystemID,'50','H','01','26',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PLAN CODE"','27','(''DA''=''T,'')',@AdhSystemID,'50','H','01','27',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT QUALIFYING DATE"','28','(''DA''=''T,'')',@AdhSystemID,'50','H','01','28',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT TERM DATE"','29','(''DA''=''T,'')',@AdhSystemID,'50','H','01','29',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION AMOUNT"','30','(''DA''=''T,'')',@AdhSystemID,'50','H','01','30',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION"','31','(''DA''=''T,'')',@AdhSystemID,'50','H','01','31',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT ID"','32','(''DA''=''T,'')',@AdhSystemID,'50','H','01','32',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PLAN CODE"','33','(''DA''=''T,'')',@AdhSystemID,'50','H','01','33',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT QUALIFYING DATE"','34','(''DA''=''T,'')',@AdhSystemID,'50','H','01','34',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT TERM DATE"','35','(''DA''=''T,'')',@AdhSystemID,'50','H','01','35',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION AMOUNT"','36','(''DA''=''T,'')',@AdhSystemID,'50','H','01','36',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION"','37','(''DA''=''T,'')',@AdhSystemID,'50','H','01','37',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT ID"','38','(''DA''=''T,'')',@AdhSystemID,'50','H','01','38',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PLAN CODE"','39','(''DA''=''T,'')',@AdhSystemID,'50','H','01','39',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT QUALIFYING DATE"','40','(''DA''=''T,'')',@AdhSystemID,'50','H','01','40',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT TERM DATE"','41','(''DA''=''T,'')',@AdhSystemID,'50','H','01','41',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION AMOUNT"','42','(''DA''=''T,'')',@AdhSystemID,'50','H','01','42',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION"','43','(''DA''=''T,'')',@AdhSystemID,'50','H','01','43',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT ID"','44','(''DA''=''T,'')',@AdhSystemID,'50','H','01','44',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PLAN CODE"','45','(''DA''=''T,'')',@AdhSystemID,'50','H','01','45',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT QUALIFYING DATE"','46','(''DA''=''T,'')',@AdhSystemID,'50','H','01','46',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT TERM DATE"','47','(''DA''=''T,'')',@AdhSystemID,'50','H','01','47',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION AMOUNT"','48','(''DA''=''T,'')',@AdhSystemID,'50','H','01','48',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION"','49','(''DA''=''T,'')',@AdhSystemID,'50','H','01','49',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT ID"','50','(''DA''=''T,'')',@AdhSystemID,'50','H','01','50',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PLAN CODE"','51','(''DA''=''T,'')',@AdhSystemID,'50','H','01','51',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT QUALIFYING DATE"','52','(''DA''=''T,'')',@AdhSystemID,'50','H','01','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT TERM DATE"','53','(''DA''=''T,'')',@AdhSystemID,'50','H','01','53',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION AMOUNT"','54','(''DA''=''T,'')',@AdhSystemID,'50','H','01','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION"','55','(''DA''=''T,'')',@AdhSystemID,'50','H','01','55',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT ID"','56','(''DA''=''T,'')',@AdhSystemID,'50','H','01','56',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PLAN CODE"','57','(''DA''=''T,'')',@AdhSystemID,'50','H','01','57',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT QUALIFYING DATE"','58','(''DA''=''T,'')',@AdhSystemID,'50','H','01','58',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT TERM DATE"','59','(''DA''=''T,'')',@AdhSystemID,'50','H','01','59',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION AMOUNT"','60','(''DA''=''T,'')',@AdhSystemID,'50','H','01','60',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"BENEFIT SELECTION"','61','(''DA''=''T'')',@AdhSystemID,'50','H','01','61',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drveEnroll2"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','10','1',NULL,'eEnroll2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPOLICY"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','10','2',NULL,'POLICY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDIVISION"','3','(''UA''=''T,'')',@AdhSystemID,'50','D','10','3',NULL,'DIVISION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEMBERID"','4','(''UA''=''T,'')',@AdhSystemID,'50','D','10','4',NULL,'MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRIDIV"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'PRI DIV',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOH"','6','(''UA''=''T,'')',@AdhSystemID,'50','D','10','6',NULL,'DOH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSALARY"','7','(''UNT2''=''T,'')',@AdhSystemID,'50','D','10','7',NULL,'SALARY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSALARYMODE"','8','(''UA''=''T,'')',@AdhSystemID,'50','D','10','8',NULL,'SALARY MODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHOURS"','9','(''UNT2''=''T,'')',@AdhSystemID,'50','D','10','9',NULL,'HOURS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTERMDATE"','10','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','10',NULL,'TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTERMREASON"','11','(''UA''=''T,'')',@AdhSystemID,'50','D','10','11',NULL,'TERM REASON',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNEWMEMBERID"','12','(''UA''=''T,'')',@AdhSystemID,'50','D','10','12',NULL,'NEW MEMBER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFIRSTNAME"','13','(''UA''=''T,'')',@AdhSystemID,'50','D','10','13',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMIDDLENAME"','14','(''UA''=''T,'')',@AdhSystemID,'50','D','10','14',NULL,'MIDDLE NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLASTNAME"','15','(''UA''=''T,'')',@AdhSystemID,'50','D','10','15',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSUFFIX"','16','(''UA''=''T,'')',@AdhSystemID,'50','D','10','16',NULL,'SUFFIX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGENDER"','17','(''UA''=''T,'')',@AdhSystemID,'50','D','10','17',NULL,'GENDER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDOB"','18','(''UA''=''T,'')',@AdhSystemID,'50','D','10','18',NULL,'DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPOUSEFIRSTNAME"','19','(''UA''=''T,'')',@AdhSystemID,'50','D','10','19',NULL,'SPOUSE FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPOUSEGDR"','20','(''UA''=''T,'')',@AdhSystemID,'50','D','10','20',NULL,'SPOUSE GDR',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSPOUSEDOB"','21','(''UA''=''T,'')',@AdhSystemID,'50','D','10','21',NULL,'SPOUSE DOB',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCLASS"','22','(''UA''=''T,'')',@AdhSystemID,'50','D','10','22',NULL,'CLASS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSIGNATUREDATE"','23','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','23',NULL,'SIGNATURE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEFFECTIVEDATE"','24','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','24',NULL,'EFFECTIVE DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvADDTYPE"','25','(''UA''=''T,'')',@AdhSystemID,'50','D','10','25',NULL,'ADD TYPE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITID1"','26','(''UA''=''T,'')',@AdhSystemID,'50','D','10','26',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANCODE1"','27','(''UA''=''T,'')',@AdhSystemID,'50','D','10','27',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITQUALIFYINGDATE1"','28','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','28',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITTERMDATE1"','29','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','29',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTIONAMOUNT1"','30','(''UNT0''=''T,'')',@AdhSystemID,'50','D','10','30',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTION1"','31','(''UA''=''T,'')',@AdhSystemID,'50','D','10','31',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITID2"','32','(''UA''=''T,'')',@AdhSystemID,'50','D','10','32',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANCODE2"','33','(''UA''=''T,'')',@AdhSystemID,'50','D','10','33',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITQUALIFYINGDATE2"','34','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','34',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITTERMDATE2"','35','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','35',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTIONAMOUNT2"','36','(''UNT0''=''T,'')',@AdhSystemID,'50','D','10','36',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTION2"','37','(''UA''=''T,'')',@AdhSystemID,'50','D','10','37',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITID3"','38','(''UA''=''T,'')',@AdhSystemID,'50','D','10','38',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANCODE3"','39','(''UA''=''T,'')',@AdhSystemID,'50','D','10','39',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITQUALIFYINGDATE3"','40','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','40',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITTERMDATE3"','41','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','41',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTIONAMOUNT3"','42','(''UNT0''=''T,'')',@AdhSystemID,'50','D','10','42',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTION3"','43','(''UA''=''T,'')',@AdhSystemID,'50','D','10','43',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITID4"','44','(''UA''=''T,'')',@AdhSystemID,'50','D','10','44',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANCODE4"','45','(''UA''=''T,'')',@AdhSystemID,'50','D','10','45',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITQUALIFYINGDATE4"','46','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','46',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITTERMDATE4"','47','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','47',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTIONAMOUNT4"','48','(''UNT0''=''T,'')',@AdhSystemID,'50','D','10','48',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTION4"','49','(''UA''=''T,'')',@AdhSystemID,'50','D','10','49',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITID5"','50','(''UA''=''T,'')',@AdhSystemID,'50','D','10','50',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANCODE5"','51','(''UA''=''T,'')',@AdhSystemID,'50','D','10','51',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITQUALIFYINGDATE5"','52','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','52',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITTERMDATE5"','53','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','53',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTIONAMOUNT5"','54','(''UNT0''=''T,'')',@AdhSystemID,'50','D','10','54',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTION5"','55','(''UA''=''T,'')',@AdhSystemID,'50','D','10','55',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITID6"','56','(''UA''=''T,'')',@AdhSystemID,'50','D','10','56',NULL,'BENEFIT ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPLANCODE6"','57','(''UA''=''T,'')',@AdhSystemID,'50','D','10','57',NULL,'PLAN CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITQUALIFYINGDATE6"','58','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','58',NULL,'BENEFIT QUALIFYING DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITTERMDATE6"','59','(''UD101''=''T,'')',@AdhSystemID,'50','D','10','59',NULL,'BENEFIT TERM DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTIONAMOUNT6"','60','(''UNT0''=''T,'')',@AdhSystemID,'50','D','10','60',NULL,'BENEFIT SELECTION AMOUNT',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvBENEFITSELECTION6"','61','(''UA''=''T'')',@AdhSystemID,'50','D','10','61',NULL,'BENEFIT SELECTION',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName2,CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','SCHEDULED',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@FileTestPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@FileUDESPath');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl',NULL);
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
    [Data] varchar(4000) NULL
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
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = '@IsWebFlag';
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_@CustomFormatCode_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_AuditFields;
    CREATE TABLE dbo.U_@CustomFormatCode_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenAmt');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_@CustomFormatCode_AuditFields VALUES ('EmpPers','EepSSN');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_@CustomFormatCode_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --==========================================
    -- Clean EE List 
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Changes Only
    IF (@ExportCode NOT LIKE 'OE%')
    BEGIN
        DELETE FROM dbo.U_@CustomFormatCode_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_@CustomFormatCode_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','<ENTER DEDCODE(S): VLIFE,VLIFS,VLIFC,ADDE,ADDS,ADDC>');
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
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================

    ---------------------------------
    -- DETAIL RECORD - U_@CustomFormatCode_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
        drveEnroll2 = ''
        ,drvPOLICY = '000000'
        ,drvDIVISION = '0001'
        ,drvMEMBERID = CASE WHEN ISNULL(EepOldSSN,'') <> '' THEN EepOldSSN ELSE EepSSN END
        ,drvPRIDIV = ''
        ,drvDOH = REPLACE(CONVERT(VARCHAR(10),MAX(EedBenStartDate),101),'/',SPACE(0))
        ,drvSALARY = CASE WHEN EecSalaryOrHourly = 'H' THEN EecHourlyPayRate
                          ELSE EecAnnSalary
                     END
        ,drvSALARYMODE = CASE WHEN EecSalaryOrHourly = 'H' THEN 'H' --Hourly
                              ELSE 'A' --Annual
                         END
        ,drvHOURS = CASE EecPayPeriod
                         WHEN 'B' THEN EecScheduledWorkHrs / 2
                         WHEN 'S' THEN (EecScheduledWorkHrs*24) / 52
                         WHEN 'M' THEN (EecScheduledWorkHrs*12) / 52
                         ELSE EecScheduledWorkHrs
                    END
        ,drvTERMDATE = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTERMREASON = CASE WHEN EecEmplStatus = 'T' THEN
                                CASE EecTermReason
                                     WHEN '202' THEN 'RT'
                                     WHEN '203' THEN 'DT'
                                     ELSE 'TE'
                                END
                              WHEN MAX(EedBenStopDate) IS NOT NULL THEN 'IN'
                         END
        ,drvNEWMEMBERID = CASE WHEN ISNULL(EepOldSSN,'') <> '' THEN EepSSN END
        ,drvFIRSTNAME = EepNameFirst
        ,drvMIDDLENAME = LEFT(EepNameMiddle,1)
        ,drvLASTNAME = EepNameLast
        ,drvSUFFIX = NULLIF(EepNameSuffix,'Z')
        ,drvGENDER = EepGender
        ,drvDOB = EepDateOfBirth
        ,drvSPOUSEFIRSTNAME = Spouse.ConNameFirst
        ,drvSPOUSEGDR = Spouse.ConGender
        ,drvSPOUSEDOB = Spouse.ConDateOfBirth
        ,drvCLASS = '0001'
        ,drvSIGNATUREDATE = MAX(EedBenStatusDate)
        ,drvEFFECTIVEDATE = CASE WHEN audReHire = 'Y' THEN EecDateOfLastHire
                                 WHEN audTerm = 'Y' THEN EecDateOfTermination
                                 WHEN audSalaryChange = 'Y' THEN EjhJobEffDate
                                 ELSE MAX(EedBenStartDate)
                            END
        ,drvADDTYPE = 'O'
        --Benefit Loops: Employee, Spouse, Child
        ,drvBENEFITID1 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee Life>' THEN 'LM' END)
        ,drvPLANCODE1 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee Life>' THEN 'PLAN1' END)
        ,drvBENEFITQUALIFYINGDATE1 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee Life>' THEN EedBenStartDate END)
        ,drvBENEFITTERMDATE1 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee Life>' THEN EedBenStopDate END)
        ,drvBENEFITSELECTIONAMOUNT1 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee Life>' THEN EedBenAmt END)
        ,drvBENEFITSELECTION1 = ''
        ,drvBENEFITID2 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse Life>' THEN 'LS' END)
        ,drvPLANCODE2 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse Life>' THEN 'PLAN2' END)
        ,drvBENEFITQUALIFYINGDATE2 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse Life>' THEN EedBenStartDate END)
        ,drvBENEFITTERMDATE2 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse Life>' THEN EedBenStopDate END)
        ,drvBENEFITSELECTIONAMOUNT2 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse Life>' THEN EedBenAmt END)
        ,drvBENEFITSELECTION2 = ''
        ,drvBENEFITID3 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child Life>' THEN 'LC' END)
        ,drvPLANCODE3 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child Life>' THEN 'PLAN3' END)
        ,drvBENEFITQUALIFYINGDATE3 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child Life>' THEN EedBenStartDate END)
        ,drvBENEFITTERMDATE3 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child Life>' THEN EedBenStopDate END)
        ,drvBENEFITSELECTIONAMOUNT3 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child Life>' THEN EedBenAmt END)
        ,drvBENEFITSELECTION3 = ''
        ,drvBENEFITID4 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee ADD>' THEN 'AM' END)
        ,drvPLANCODE4 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee ADD>' THEN 'PLAN4' END)
        ,drvBENEFITQUALIFYINGDATE4 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee ADD>' THEN EedBenStartDate END)
        ,drvBENEFITTERMDATE4 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee ADD>' THEN EedBenStopDate END)
        ,drvBENEFITSELECTIONAMOUNT4 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Employee ADD>' THEN EedBenAmt END)
        ,drvBENEFITSELECTION4 = ''
        ,drvBENEFITID5 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse ADD>' THEN 'AS' END)
        ,drvPLANCODE5 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse ADD>' THEN 'PLAN5' END)
        ,drvBENEFITQUALIFYINGDATE5 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse ADD>' THEN EedBenStartDate END)
        ,drvBENEFITTERMDATE5 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse ADD>' THEN EedBenStopDate END)
        ,drvBENEFITSELECTIONAMOUNT5 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Spouse ADD>' THEN EedBenAmt END)
        ,drvBENEFITSELECTION5 = ''
        ,drvBENEFITID6 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child ADD>' THEN 'AC' END)
        ,drvPLANCODE6 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child ADD>' THEN 'PLAN6' END)
        ,drvBENEFITQUALIFYINGDATE6 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child ADD>' THEN EedBenStartDate END)
        ,drvBENEFITTERMDATE6 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child ADD>' THEN EedBenStopDate END)
        ,drvBENEFITSELECTIONAMOUNT6 = MAX(CASE WHEN EedDedCode = '<Enter DedCode for Child ADD>' THEN EedBenAmt END)
        ,drvBENEFITSELECTION6 = ''
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.Contacts Spouse WITH (NOLOCK)
        ON Spouse.ConEEID = xEEID
        AND Spouse.ConIsActive = 'Y'
        AND Spouse.ConRelationship = 'SPS'
    LEFT JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT audEEID
            ,audNewHire = MAX(audNewHire)
            ,audReHire = MAX(audReHire)
            ,audTerm = MAX(audTerm)
            ,audSalaryChange = MAX(audSalaryChange)
        FROM dbo.U_@CustomFormatCode_Audit
        WHERE audRowNo = 1
        AND (audNewHire = 'Y'
            OR audReHire = 'Y'
            OR audTerm = 'Y'
            OR audSalaryChange = 'Y'
        )
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
    LEFT JOIN (
        -- Get Most Recent Salary Change Date
        SELECT EjhEEID, EjhCOID
            ,EjhJobEffDate = MAX(EjhJobEffDate)
        FROM dbo.EmpHJob
        WHERE EjhIsRateChange = 'Y'
        GROUP BY EjhEEID, EjhCOID
    ) EmpHJob
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
    GROUP BY EepOldSSN,EepSSN,EecSalaryOrHourly,EecHourlyPayRate,EecAnnSalary,EecPayPeriod,EecScheduledWorkHrs,EecEmplStatus,EecDateOfTermination,EecTermReason
        ,EepNameFirst,EepNameMiddle,EepNameLast,EepNameSuffix,EepGender,EepDateOfBirth,Spouse.ConNameFirst,Spouse.ConGender,Spouse.ConDateOfBirth,audReHire,audTerm
        ,audSalaryChange,EecDateOfLastHire,EecDateOfTermination,EjhJobEffDate,xEEID,xCoID;

    -------------------------
    -- Update Record Count
    -------------------------
    UPDATE dbo.U_@CustomFormatCode_drvTbl SET drveEnroll2 = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_drvTbl);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('@CustomFormatCode','Testing') = 'Y' THEN 'TEST_@CompanyCode_UNUM_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE '@CompanyCode_UNUM_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = '@CustomFormatCode';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202005051'
       ,ExpStartPerControl     = '202005051'
       ,ExpLastEndPerControl   = '202005059'
       ,ExpEndPerControl       = '202005059'
WHERE ExpFormatCode = '@CustomFormatCode';

-- Remove Prior Division (Field "PRI DIV")
SELECT * FROM dbo.AscDefF JOIN dbo.AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatName' AND AdfFieldNumber = '5'
DELETE FROM dbo.AscDefF JOIN dbo.AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatName' AND AdfFieldNumber = '5'

-- Add Prior Division (Field "PRI DIV")
DECLARE @AdhSystemID VARCHAR(50);
SET @AdhSystemID = (SELECT AdhSystemID FROM dbo.AscDefH WHERE AdhFormatCode = '@CustomFormatName');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRI DIV"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','01','5',NULL,'PRI DIV',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRIDIV"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'PRI DIV',NULL,NULL;
SELECT * FROM dbo.AscDefF JOIN dbo.AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatName' AND AdfFieldNumber = '5'

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort
GO