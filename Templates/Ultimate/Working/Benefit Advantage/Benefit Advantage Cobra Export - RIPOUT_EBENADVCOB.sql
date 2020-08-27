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
@CustomFormatCode - Replace with Format Code (i.e., EBENADVCOB)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Benefit Advantage Cobra)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)

*/
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_@CustomFormatCode_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = '@CustomFormatCode' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode','Benefit Advantage Cobra','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EMPLOYER NUMBER"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','01','1',NULL,'EMPLOYER NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LAST NAME"','2','(''DA''=''T,'')',@AdhSystemID,'50','H','01','2',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FIRST NAME"','3','(''DA''=''T,'')',@AdhSystemID,'50','H','01','3',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STREET"','4','(''DA''=''T,'')',@AdhSystemID,'50','H','01','4',NULL,'STREET',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SUITE "','5','(''DA''=''T,'')',@AdhSystemID,'50','H','01','5',NULL,'SUITE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CITY STATE"','6','(''DA''=''T,'')',@AdhSystemID,'50','H','01','6',NULL,'CITY STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STATE"','7','(''DA''=''T,'')',@AdhSystemID,'50','H','01','7',NULL,'STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ZIPCODE"','8','(''DA''=''T,'')',@AdhSystemID,'50','H','01','8',NULL,'ZIPCODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CARRIER ID"','9','(''DA''=''T'')',@AdhSystemID,'50','H','01','9',NULL,'CARRIER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMPLOYERNUMBER"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','10','1',NULL,'EMPLOYER NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLASTNAME"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','10','2',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFIRSTNAME"','3','(''UA''=''T,'')',@AdhSystemID,'50','D','10','3',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTREET"','4','(''UA''=''T,'')',@AdhSystemID,'50','D','10','4',NULL,'STREET',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSUITE"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','10','5',NULL,'SUITE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCITYSTATE"','6','(''UA''=''T,'')',@AdhSystemID,'50','D','10','6',NULL,'CITY STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTATE"','7','(''UA''=''T,'')',@AdhSystemID,'50','D','10','7',NULL,'STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZIPCODE"','8','(''UA''=''T,'')',@AdhSystemID,'50','D','10','8',NULL,'ZIPCODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCARRIERID"','9','(''UA''=''T'')',@AdhSystemID,'50','D','10','9',NULL,'CARRIER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SOCIAL SECURITY NUMBER"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','02','1',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"EMPLOYER NUMBER"','2','(''DA''=''T,'')',@AdhSystemID,'50','H','02','2',NULL,'EMPLOYER NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"QUALIFICATION CODE"','3','(''DA''=''T,'')',@AdhSystemID,'50','H','02','3',NULL,'QUALIFICATION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LAST NAME"','4','(''DA''=''T,'')',@AdhSystemID,'50','H','02','4',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FIRST NAME"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','02','5',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STREET"','6','(''DA''=''T,'')',@AdhSystemID,'50','H','02','6',NULL,'STREET',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SUITE "','7','(''DA''=''T,'')',@AdhSystemID,'50','H','02','7',NULL,'SUITE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CITY "','8','(''DA''=''T,'')',@AdhSystemID,'50','H','02','8',NULL,'CITY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"STATE"','9','(''DA''=''T,'')',@AdhSystemID,'50','H','02','9',NULL,'STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"ZIPCODE"','10','(''DA''=''T,'')',@AdhSystemID,'50','H','02','10',NULL,'ZIPCODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DIVISION"','11','(''DA''=''T,'')',@AdhSystemID,'50','H','02','11',NULL,'DIVISION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SEX"','12','(''DA''=''T,'')',@AdhSystemID,'50','H','02','12',NULL,'SEX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DATE OF BIRTH"','13','(''DA''=''T,'')',@AdhSystemID,'50','H','02','13',NULL,'DATE OF BIRTH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MARITAL STATUS"','14','(''DA''=''T,'')',@AdhSystemID,'50','H','02','14',NULL,'MARITAL STATUS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"Original Health Start Date"','15','(''DA''=''T,'')',@AdhSystemID,'50','H','02','15',NULL,'Original Health Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"QUALIFICATION DATE"','16','(''DA''=''T,'')',@AdhSystemID,'50','H','02','16',NULL,'QUALIFICATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"NOTIFICATION DATE"','17','(''DA''=''T,'')',@AdhSystemID,'50','H','02','17',NULL,'NOTIFICATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"END OF ELIGIBILITY DATE"','18','(''DA''=''T,'')',@AdhSystemID,'50','H','02','18',NULL,'END OF ELIGIBILITY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PRINT CERTIFICATE"','19','(''DA''=''T'')',@AdhSystemID,'50','H','02','19',NULL,'PRINT CERTIFICATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','20','1',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMPLOYERNUMBER"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','20','2',NULL,'EMPLOYER NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvQUALIFICATIONCODE"','3','(''UA''=''T,'')',@AdhSystemID,'50','D','20','3',NULL,'QUALIFICATION CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLASTNAME"','4','(''UA''=''T,'')',@AdhSystemID,'50','D','20','4',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFIRSTNAME"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','20','5',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTREET"','6','(''UA''=''T,'')',@AdhSystemID,'50','D','20','6',NULL,'STREET',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSUITE"','7','(''UA''=''T,'')',@AdhSystemID,'50','D','20','7',NULL,'SUITE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCITY"','8','(''UA''=''T,'')',@AdhSystemID,'50','D','20','8',NULL,'CITY',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSTATE"','9','(''UA''=''T,'')',@AdhSystemID,'50','D','20','9',NULL,'STATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZIPCODE"','10','(''UA''=''T,'')',@AdhSystemID,'50','D','20','10',NULL,'ZIPCODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDIVISION"','11','(''UA''=''T,'')',@AdhSystemID,'50','D','20','11',NULL,'DIVISION',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSEX"','12','(''UA''=''T,'')',@AdhSystemID,'50','D','20','12',NULL,'SEX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFBIRTH"','13','(''UD101''=''T,'')',@AdhSystemID,'50','D','20','13',NULL,'DATE OF BIRTH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMARITALSTATUS"','14','(''UA''=''T,'')',@AdhSystemID,'50','D','20','14',NULL,'MARITAL STATUS',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOriginalHealthStartDate"','15','(''UD101''=''T,'')',@AdhSystemID,'50','D','20','15',NULL,'Original Health Start Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvQUALIFICATIONDATE"','16','(''UD101''=''T,'')',@AdhSystemID,'50','D','20','16',NULL,'QUALIFICATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvNOTIFICATIONDATE"','17','(''UD101''=''T,'')',@AdhSystemID,'50','D','20','17',NULL,'NOTIFICATION DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvENDOFELIGIBILITYDATE"','18','(''UD101''=''T,'')',@AdhSystemID,'50','D','20','18',NULL,'END OF ELIGIBILITY DATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPRINTCERTIFICATE"','19','(''UA''=''T'')',@AdhSystemID,'50','D','20','19',NULL,'PRINT CERTIFICATE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SOCIAL SECURITY NUMBER"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','03','1',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"CARRIER ID"','2','(''DA''=''T,'')',@AdhSystemID,'50','H','03','2',NULL,'CARRIER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"COVERAGE CODE"','3','(''DA''=''T'')',@AdhSystemID,'50','H','03','3',NULL,'COVERAGE CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','30','1',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCARRIERID"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','30','2',NULL,'CARRIER ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCOVERAGECODE"','3','(''UA''=''T'')',@AdhSystemID,'50','D','30','3',NULL,'COVERAGE CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"MEMBER SSN"','1','(''DA''=''T,'')',@AdhSystemID,'50','H','04','1',NULL,'MEMBER SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SOCIAL SECURITY NUMBER "','2','(''DA''=''T,'')',@AdhSystemID,'50','H','04','2',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DEPENDENT CODE "','3','(''DA''=''T,'')',@AdhSystemID,'50','H','04','3',NULL,'DEPENDENT CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"LAST NAME"','4','(''DA''=''T,'')',@AdhSystemID,'50','H','04','4',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"FIRST NAME"','5','(''DA''=''T,'')',@AdhSystemID,'50','H','04','5',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"SEX"','6','(''DA''=''T,'')',@AdhSystemID,'50','H','04','6',NULL,'SEX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"DATE OF BIRTH"','7','(''DA''=''T'')',@AdhSystemID,'50','H','04','7',NULL,'DATE OF BIRTH',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMEMBERSSN"','1','(''UA''=''T,'')',@AdhSystemID,'50','D','40','1',NULL,'MEMBER SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSOCIALSECURITYNUMBER"','2','(''UA''=''T,'')',@AdhSystemID,'50','D','40','2',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDEPENDENTCODE"','3','(''UA''=''T,'')',@AdhSystemID,'50','D','40','3',NULL,'DEPENDENT CODE',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLASTNAME"','4','(''UA''=''T,'')',@AdhSystemID,'50','D','40','4',NULL,'LAST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvFIRSTNAME"','5','(''UA''=''T,'')',@AdhSystemID,'50','D','40','5',NULL,'FIRST NAME',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSEX"','6','(''UA''=''T,'')',@AdhSystemID,'50','D','40','6',NULL,'SEX',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDATEOFBIRTH"','7','(''UD101''=''T'')',@AdhSystemID,'50','D','40','7',NULL,'DATE OF BIRTH',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Benefit Adv Cobra Dependent','201705119','EMPEXPORT','DEPENDENT','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Test Dependent File','201705119','EMPEXPORT','TESTDEP','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Benefit Adv Cobra Participant','201705119','EMPEXPORT','PARTICIPNT','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Test Participant File','201705119','EMPEXPORT','TESTPAR','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Benefit Advantage Cobra - DOL','201705119','EMPEXPORT','DOL','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Test DOL File','201705119','EMPEXPORT','TESTDOL','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,'','',NULL,NULL,NULL,NULL,'Test Coverage File','201705119','EMPEXPORT','TESTCOVER','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Benefit Advantage Cobra - Cov','201705119','EMPEXPORT','COVERAGE','May 11 2017 12:00AM','@CustomFormatCode',NULL,NULL,NULL,'201705119','May 11 2017 12:00AM','Dec 30 1899 12:00AM','201705041',NULL,'','','201705041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DOL','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DOL','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DOL','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DOL','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DOL','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DOL','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDOL','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDOL','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDOL','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDOL','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDOL','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDOL','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','PARTICIPNT','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','PARTICIPNT','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','PARTICIPNT','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','PARTICIPNT','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','PARTICIPNT','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','PARTICIPNT','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTPAR','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTPAR','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTPAR','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTPAR','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTPAR','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTPAR','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COVERAGE','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COVERAGE','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COVERAGE','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COVERAGE','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COVERAGE','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','COVERAGE','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTCOVER','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTCOVER','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTCOVER','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTCOVER','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTCOVER','H','04','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTCOVER','D','40','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPENDENT','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPENDENT','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPENDENT','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPENDENT','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPENDENT','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','DEPENDENT','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDEP','H','02','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDEP','D','20','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDEP','H','03','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDEP','D','30','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDEP','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('@CustomFormatCode','TESTDEP','D','10','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','dbo.U_@CustomFormatCode_drvTbl_DOL',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_COV',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_@CustomFormatCode_drvTbl_PAR',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','dbo.U_@CustomFormatCode_drvTbl_DEP',NULL);
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
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
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
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'DOL';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TESTDOL';

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y'
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
    SELECT @FormatCode = '@CustomFormatCode';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section - New Enrollee
    --==========================================
	IF (@ExportCode LIKE '%DOL%')
	BEGIN
		DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

		-- Required parameters
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

		-- Non-Required parameters
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y');
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','1');

		-- Run BDM Module
		EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
	END

    --==========================================
    -- BDM Section - Cobra
    --==========================================
	IF (@ExportCode NOT LIKE '%DOL%')
	BEGIN
		DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

		-- Required parameters
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

		-- Non-Required parameters
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','2');
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','2');
		INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y');

		-- Run BDM Module
		EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
	END

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - DOL
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_DOL','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_DOL;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvEMPLOYERNUMBER = '@EmployerNumberXXXXX'
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAME = EepNameFirst
        ,drvSTREET = EepAddressLine1
        ,drvSUITE = EepAddressLine2
        ,drvCITYSTATE = EepAddressCity
        ,drvSTATE = EepAddressState
        ,drvZIPCODE = EepAddressZipCode
        ,drvCARRIERID = CASE BdmDedType
                             WHEN 'VIS' THEN 'VIS'
                             WHEN 'DEN' THEN 'DEN'
                             WHEN 'MED' THEN 'MED'
                        END 
        ,drvInitialSort = RTRIM(EepSSN)
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
	WHERE @ExportCode LIKE '%DOL%';

    ---------------------------------
    -- DETAIL RECORD - Participant
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID
        -- standard fields above and additional driver fields below
        ,drvSOCIALSECURITYNUMBER = CASE BdmRecType
                                        WHEN 'EMP' THEN EepSSN
                                        WHEN 'DEP' THEN ConSSN
                                   END
        ,drvEMPLOYERNUMBER = '@EmployerNumberXXXXX'
        ,drvQUALIFICATIONCODE = CASE WHEN EecTermReason = '202' THEN 'RE' --Retirement
                                     WHEN EecTermReason = '203' THEN 'WW' -- Death of Covered Employee
                                     WHEN BdmCobraReason IN ('201','LEVNT3') THEN 'DC' --Loss of Dependent Status
                                     WHEN BdmCobraReason IN ('204','LEVNT4') THEN 'DV' --Divorce or Legal Separation
                                     WHEN BdmCobraReason = '210' THEN 'WW' -- Death of Covered Employee
                                     WHEN BdmCobraReason IN ('203','206','207') THEN 'RH' --Reduction in Hours
                                     WHEN BdmCobraReason = '208' THEN 'RE' --Retirement
                                     ELSE 'TE' --Termination
                                END
        ,drvLASTNAME = CASE BdmRecType
                            WHEN 'EMP' THEN EepNameLast
                            WHEN 'DEP' THEN ConNameLast
                       END
        ,drvFIRSTNAME = CASE BdmRecType
                             WHEN 'EMP' THEN EepNameFirst
                             WHEN 'DEP' THEN ConNameFirst
                        END
        ,drvSTREET = CASE BdmRecType
                          WHEN 'EMP' THEN EepAddressLine1
                          WHEN 'DEP' THEN ConAddressLine1
                     END
        ,drvSUITE = CASE BdmRecType
                         WHEN 'EMP' THEN EepAddressLine2
                         WHEN 'DEP' THEN ConAddressLine2
                     END
        ,drvCITY = CASE BdmRecType
                        WHEN 'EMP' THEN EepAddressCity
                        WHEN 'DEP' THEN ConAddressCity
                   END
        ,drvSTATE = CASE BdmRecType
                         WHEN 'EMP' THEN EepAddressState
                         WHEN 'DEP' THEN ConAddressState
                    END
        ,drvZIPCODE = CASE BdmRecType
                           WHEN 'EMP' THEN EepAddressZipCode
                           WHEN 'DEP' THEN ConAddressZipCode
                      END
        ,drvDIVISION = ''
        ,drvSEX = CASE BdmRecType
                       WHEN 'EMP' THEN EepGender
                       WHEN 'DEP' THEN ConGender
                  END
        ,drvDATEOFBIRTH = CASE BdmRecType
                               WHEN 'EMP' THEN EepDateOfBirth
                               WHEN 'DEP' THEN ConDateOfBirth
                          END
        ,drvMARITALSTATUS = eepMaritalStatus
        ,drvOriginalHealthStartDate = ''
        ,drvQUALIFICATIONDATE = BdmDateOfCOBRAEvent
        ,drvNOTIFICATIONDATE = ''
        ,drvENDOFELIGIBILITYDATE = ''
        ,drvPRINTCERTIFICATE = ''
        ,drvInitialSort = RTRIM(EepSSN) + ISNULL(ConSystemID,'')
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN (
        SELECT
             BdmEEID
            ,BdmCoID
            ,BdmDepRecID
            ,BdmRecType
            ,BdmCobraReason = MAX(BdmCobraReason)
            ,BdmBenStartDate = MIN(BdmBenStartDate)
            ,BdmDateOfCOBRAEvent = MAX(BdmDateOfCOBRAEvent)
            ,BdmUSGDate1 = MAX(BdmUSGDate1)
        FROM dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        WHERE BdmIsPQB = 'Y'
        GROUP BY BdmEEID, BdmCoID, BdmDepRecID, BdmRecType
    ) BDM
        ON BdmEEID = xEEID
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
	WHERE @ExportCode NOT LIKE '%DOL%'

    ---------------------------------
    -- DETAIL RECORD - Coverage
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_COV','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_COV;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID
        -- standard fields above and additional driver fields below
        ,drvSOCIALSECURITYNUMBER = CASE BdmRecType
                                        WHEN 'EMP' THEN EepSSN
                                        WHEN 'DEP' THEN ConSSN
                                   END
        ,drvCARRIERID = CASE BdmDedType
                             WHEN 'VIS' THEN 'VIS'
                             WHEN 'DEN' THEN 'DEN'
                             WHEN 'MED' THEN 'MED'
                        END   
        ,drvCOVERAGECODE = CASE BdmBenOption
                                WHEN 'EE' THEN 'EO' --Employee Only
                                WHEN 'EE1' THEN 'E1' --Employee + 1
                                WHEN 'EES' THEN 'E1' --Employee + Spouse
                                WHEN 'EEDP' THEN 'E1' --Employee + Spouse
                                WHEN 'EEC' THEN 'E1' --Employee + Child(ren)
                                WHEN 'EEF' THEN 'FA' --Family
                                WHEN 'EEDPF' THEN 'FA' --Family
                           END
        ,drvInitialSort = RTRIM(EepSSN) + ISNULL(ConSystemID,'')
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE @ExportCode NOT LIKE '%DOL%' AND BdmIsPQB = 'Y';

    ---------------------------------
    -- DETAIL RECORD - Dependent
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID
        -- standard fields above and additional driver fields below
        ,drvMEMBERSSN = eepSSN
        ,drvSOCIALSECURITYNUMBER = ConSSN
        ,drvDEPENDENTCODE = CASE ConRelationship
                                 WHEN 'SPS' THEN 'SPO' --Spouse
                                 WHEN 'DAU' THEN 'DAU' --Daughter
                                 WHEN 'SON' THEN 'SON' --Son
                                 ELSE 'OTH' --Other
                            END
        ,drvLASTNAME = ConNameLast
        ,drvFIRSTNAME = ConNameFirst
        ,drvSEX = ConGender
        ,drvDATEOFBIRTH = ConDateOfBirth
        ,drvInitialSort = RTRIM(EepSSN) + ISNULL(ConSystemID,'')
    INTO dbo.U_@CustomFormatCode_drvTbl
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE @ExportCode NOT LIKE '%DOL%' AND BdmRecType = 'DEP' AND BdmIsPQB = 'N';

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN @ExportCode = 'TESTDOL' OR (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%DOL%') THEN 'Test_DOL_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
								  WHEN @ExportCode = 'TESTPAR' OR (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%PAR%') THEN 'Test_Participant_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
								  WHEN @ExportCode = 'TESTCOV' OR (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%COV%') THEN 'Test_Coverage_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
								  WHEN @ExportCode = 'TESTDEP' OR (dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' AND @ExportCode LIKE '%DEP%') THEN 'Test_Dependent_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
								  WHEN @ExportCode LIKE '%DOL%'THEN 'DOL_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
								  WHEN @ExportCode LIKE '%PAR%'THEN 'Participant_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
								  WHEN @ExportCode LIKE '%COV%'THEN 'Coverage_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
								  WHEN @ExportCode LIKE '%DEP%'THEN 'Dependent_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201705041'
       ,expStartPerControl     = '201705041'
       ,expLastEndPerControl   = '201705119'
       ,expEndPerControl       = '201705119'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort