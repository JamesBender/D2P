SET NOCOUNT ON;
IF OBJECT_ID('U_EASC401CEN_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EASC401CEN_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EASC401CEN' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEASC401CEN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASC401CEN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASC401CEN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASC401CEN];
GO
IF OBJECT_ID('U_EASC401CEN_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_PEarHist];
GO
IF OBJECT_ID('U_EASC401CEN_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_PDedHist];
GO
IF OBJECT_ID('U_EASC401CEN_Header') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_Header];
GO
IF OBJECT_ID('U_EASC401CEN_File') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_File];
GO
IF OBJECT_ID('U_EASC401CEN_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_EEList];
GO
IF OBJECT_ID('U_EASC401CEN_drvInfo') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_drvInfo];
GO
IF OBJECT_ID('U_EASC401CEN_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_DedList];
GO
IF OBJECT_ID('U_EASC401CEN_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_AuditFields];
GO
IF OBJECT_ID('U_EASC401CEN_Audit') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EASC401CEN') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EASC401CEN];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EASC401CEN';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EASC401CEN';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EASC401CEN';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EASC401CEN';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EASC401CEN';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASC401CEN','Ascensus 401k Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EASC401CENZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EASC401CEN' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeader"','1','(''UA''=''F'')','EASC401CENZ0','5','H','01','1',NULL,'Header',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileType"','2','(''UA''=''F'')','EASC401CENZ0','12','H','01','2',NULL,'FileType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientId"','3','(''UA''=''F'')','EASC401CENZ0','20','H','01','3',NULL,'ClientId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBlankSpaces"','4','(''UA''=''F'')','EASC401CENZ0','1','H','01','4',NULL,'BlankSpaces',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','5','(''UA''=''F'')','EASC401CENZ0','15','H','01','5',NULL,'ClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFilecreationdate"','6','(''UDMDY''=''F'')','EASC401CENZ0','11','H','01','6',NULL,'Filecreationdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSiteCode"','7','(''UA''=''F'')','EASC401CENZ0','1','H','01','7',NULL,'SiteCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBlankFill"','8','(''UA''=''F'')','EASC401CENZ0','109','H','01','8',NULL,'BlankFill',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','1','(''DA''=''F'')','EASC401CENZ0','5','H','02','1',NULL,'Detail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Soc. Sec #"','2','(''DA''=''F'')','EASC401CENZ0','12','H','02','2',NULL,'Soc. Sec #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''F'')','EASC401CENZ0','20','H','02','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','4','(''DA''=''F'')','EASC401CENZ0','1','H','02','4',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','5','(''DA''=''F'')','EASC401CENZ0','15','H','02','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code"','6','(''DA''=''F'')','EASC401CENZ0','10','H','02','6',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','7','(''DA''=''F'')','EASC401CENZ0','10','H','02','7',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','8','(''DA''=''F'')','EASC401CENZ0','30','H','02','8',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','9','(''DA''=''F'')','EASC401CENZ0','30','H','02','9',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','10','(''DA''=''F'')','EASC401CENZ0','23','H','02','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','11','(''DA''=''F'')','EASC401CENZ0','2','H','02','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip Code"','12','(''DA''=''F'')','EASC401CENZ0','10','H','02','12',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','13','(''DA''=''F'')','EASC401CENZ0','1','H','02','13',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','14','(''DA''=''F'')','EASC401CENZ0','8','H','02','14',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Hire Date"','15','(''DA''=''F'')','EASC401CENZ0','8','H','02','15',NULL,'Current Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Termination Date"','16','(''DA''=''F'')','EASC401CENZ0','8','H','02','16',NULL,'Current Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Prior Hire Date"','17','(''DA''=''F'')','EASC401CENZ0','8','H','02','17',NULL,'Prior Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Prior Termination Date"','18','(''DA''=''F'')','EASC401CENZ0','8','H','02','18',NULL,'Prior Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Estimated Annual Comp"','19','(''DA''=''F'')','EASC401CENZ0','10','H','02','19',NULL,'Estimated Annual Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Thousand Hours Service Code"','20','(''DA''=''F'')','EASC401CENZ0','1','H','02','20',NULL,'Thousand Hours Service Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Number of Federal Exemptions"','21','(''DA''=''F'')','EASC401CENZ0','3','H','02','21',NULL,'Number of Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','22','(''DA''=''F'')','EASC401CENZ0','1','H','02','1',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status Code"','23','(''DA''=''F'')','EASC401CENZ0','4','H','02','2',NULL,'Employee Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency Code"','24','(''DA''=''F'')','EASC401CENZ0','1','H','02','3',NULL,'Payroll Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Highly Compensated Code"','25','(''DA''=''F'')','EASC401CENZ0','1','H','02','4',NULL,'Highly Compensated Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Insider Code"','26','(''DA''=''F'')','EASC401CENZ0','1','H','02','5',NULL,'Insider Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Classification Code"','27','(''DA''=''F'')','EASC401CENZ0','1','H','02','6',NULL,'Union Classification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Status Code"','28','(''DA''=''F'')','EASC401CENZ0','4','H','02','7',NULL,'Payroll Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetail"','1','(''UA''=''F'')','EASC401CENZ0','5','D','10','1',NULL,'Detail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocSec"','2','(''UA''=''F'')','EASC401CENZ0','12','D','10','2',NULL,'Soc. Sec #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''F'')','EASC401CENZ0','20','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','4','(''UA''=''F'')','EASC401CENZ0','1','D','10','4',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''F'')','EASC401CENZ0','15','D','10','5',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','6','(''UA''=''F'')','EASC401CENZ0','10','D','10','6',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','7','(''UA''=''F'')','EASC401CENZ0','10','D','10','7',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''F'')','EASC401CENZ0','30','D','10','8',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''F'')','EASC401CENZ0','30','D','10','9',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''F'')','EASC401CENZ0','23','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''F'')','EASC401CENZ0','2','D','10','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','12','(''UA''=''F'')','EASC401CENZ0','10','D','10','12',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','13','(''UA''=''F'')','EASC401CENZ0','1','D','10','13',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','14','(''UDMDY''=''F'')','EASC401CENZ0','8','D','10','14',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentHireDate"','15','(''UDMDY''=''F'')','EASC401CENZ0','8','D','10','15',NULL,'Current Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentTerminationDate"','16','(''UDMDY''=''F'')','EASC401CENZ0','8','D','10','16',NULL,'Current Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorHireDate"','17','(''UDMDY''=''F'')','EASC401CENZ0','8','D','10','17',NULL,'Prior Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPriorTerminationDate"','18','(''UDMDY''=''F'')','EASC401CENZ0','8','D','10','18',NULL,'Prior Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEstimatedAnnualComp"','19','(''UA''=''F'')','EASC401CENZ0','10','D','10','19',NULL,'Estimated Annual Comp',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvThousandHoursServiceCode"','20','(''UA''=''F'')','EASC401CENZ0','1','D','10','20',NULL,'Thousand Hours Service Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofFederalExemptions"','21','(''UA''=''F'')','EASC401CENZ0','3','D','10','21',NULL,'Number of Federal Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','22','(''UA''=''F'')','EASC401CENZ0','1','D','10','1',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeStatusCode"','23','(''UA''=''F'')','EASC401CENZ0','4','D','10','2',NULL,'Employee Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollFrequencyCode"','24','(''UA''=''F'')','EASC401CENZ0','1','D','10','3',NULL,'Payroll Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHighlyCompensatedCode"','25','(''UA''=''F'')','EASC401CENZ0','1','D','10','4',NULL,'Highly Compensated Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvInsiderCode"','26','(''UA''=''F'')','EASC401CENZ0','1','D','10','5',NULL,'Insider Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionClassificationCode"','27','(''UA''=''F'')','EASC401CENZ0','1','D','10','6',NULL,'Union Classification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollStatusCode"','28','(''UA''=''F'')','EASC401CENZ0','4','D','10','7',NULL,'Payroll Status Code',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EASC401CEN_20211004.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102159','EMPEXPORT','OEACTIVE',NULL,'EASC401CEN',NULL,NULL,NULL,'202102159','Feb 15 2021 10:08PM','Feb 15 2021 10:08PM','202102151',NULL,'','','202102151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102159','EMPEXPORT','OEPASSIVE',NULL,'EASC401CEN',NULL,NULL,NULL,'202102159','Feb 15 2021 10:08PM','Feb 15 2021 10:08PM','202102151',NULL,'','','202102151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ascensus 401k Export','202102159','EMPEXPORT','ONDEMAND',NULL,'EASC401CEN',NULL,NULL,NULL,'202102159','Feb 15 2021 10:08PM','Feb 15 2021 10:08PM','202102151',NULL,'','','202102151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Scheduled Session A','202102159','EMPEXPORT','SCH_CENASA',NULL,'EASC401CEN',NULL,NULL,NULL,'202102159','Feb 15 2021 10:08PM','Feb 15 2021 10:08PM','202102151',NULL,'','','202102151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Scheduled Session B','202102159','EMPEXPORT','SCH_CENASB',NULL,'EASC401CEN',NULL,NULL,NULL,'202102159','Feb 15 2021 10:08PM','Feb 15 2021 10:08PM','202102151',NULL,'','','202102151',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','FEA60,FEIWL',NULL,NULL,NULL,'Test Purposes Only','202109239','EMPEXPORT','TEST','Sep 23 2021 11:08AM','EASC401CEN',NULL,NULL,NULL,'202109239','Sep 23 2021 12:00AM','Dec 30 1899 12:00AM','202109091','392','eecOrgLvl1','','202109091',dbo.fn_GetTimedKey(),NULL,'us3rVaSAL1011',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CEN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CEN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CEN','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CEN','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CEN','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CEN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CEN','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EASC401CEN' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EASC401CEN' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EASC401CEN_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASC401CEN_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASC401CEN','H01','dbo.U_EASC401CEN_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASC401CEN','H02','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASC401CEN','D10','dbo.U_EASC401CEN_drvInfo',NULL);
IF OBJECT_ID('U_dsi_BDM_EASC401CEN') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EASC401CEN] (
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
IF OBJECT_ID('U_EASC401CEN_Audit') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EASC401CEN_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EASC401CEN_DedList') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EASC401CEN_drvInfo') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_drvInfo] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDetail] varchar(3) NOT NULL,
    [drvSocSec] char(11) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvLocationCode] char(5) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvCurrentHireDate] datetime NULL,
    [drvCurrentTerminationDate] datetime NULL,
    [drvPriorHireDate] datetime NULL,
    [drvPriorTerminationDate] datetime NULL,
    [drvEstimatedAnnualComp] varchar(30) NULL,
    [drvThousandHoursServiceCode] varchar(1) NOT NULL,
    [drvNumberofFederalExemptions] int NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvEmployeeStatusCode] varchar(3) NULL,
    [drvPayrollFrequencyCode] varchar(1) NULL,
    [drvHighlyCompensatedCode] varchar(1) NOT NULL,
    [drvInsiderCode] varchar(1) NOT NULL,
    [drvUnionClassificationCode] varchar(1) NOT NULL,
    [drvPayrollStatusCode] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EASC401CEN_EEList') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EASC401CEN_File') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EASC401CEN_Header') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_Header] (
    [drvHeader] varchar(3) NOT NULL,
    [drvFileType] varchar(4) NOT NULL,
    [drvClientId] varchar(6) NOT NULL,
    [drvBlankSpaces] varchar(1) NOT NULL,
    [drvClientName] varchar(21) NOT NULL,
    [drvFilecreationdate] datetime NOT NULL,
    [drvSiteCode] varchar(1) NOT NULL,
    [drvBlankFill] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EASC401CEN_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_PDedHist] (
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
IF OBJECT_ID('U_EASC401CEN_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASC401CEN_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASC401CEN]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Salem Medical Center

Created By: Marco Lagrosa
Business Analyst: Richard Vars
Create Date: 02/15/2021
Service Request Number: TekP-2020-10-06-0001

Purpose: Ascensus 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASC401CEN';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASC401CEN';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASC401CEN';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASC401CEN';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASC401CEN' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CEN', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CEN', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CEN', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CEN', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CEN', 'SCH_CENASA';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CEN', 'SCH_CENASB';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASC401CEN';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EASC401CEN', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EASC401CEN';

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
    DELETE FROM dbo.U_EASC401CEN_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASC401CEN_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401CU,401LN';

    IF OBJECT_ID('U_EASC401CEN_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CEN_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASC401CEN_DedList
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

    --Audit Table
    IF OBJECT_ID('U_EASC401CEN_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CEN_AuditFields;
    CREATE TABLE dbo.U_EASC401CEN_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EASC401CEN_AuditFields VALUES ('EmpComp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EASC401CEN_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CEN_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EASC401CEN_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EASC401CEN_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EASC401CEN_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EASC401CEN_Audit ON dbo.U_EASC401CEN_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EASC401CEN_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CEN_PDedHist;
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
    INTO dbo.U_EASC401CEN_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EASC401CEN_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EASC401CEN_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CEN_PEarHist;
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
    INTO dbo.U_EASC401CEN_PEarHist
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
    -- DETAIL RECORD - U_EASC401CEN_drvInfo
    ---------------------------------
    IF OBJECT_ID('U_EASC401CEN_drvInfo','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CEN_drvInfo;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvDetail = 'DTL'
        ,drvSocSec = eepSSN
        ,drvLastName = EepNameLast
        ,drvMiddleInitial = ''
        ,drvFirstName = EepNameFirst
        ,drvLocationCode = CmpCompanyCode -- (Select top 1 LocCode from Location where LocCode = eeclocation)
        ,drvEmployeeNumber = EecEmpNo
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvDateofBirth = EepDateOfBirth
        ,drvCurrentHireDate = EecDateOfLastHire
        ,drvCurrentTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvPriorHireDate = EecDateOfOriginalHire
        ,drvPriorTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvEstimatedAnnualComp = Cast(eecAnnSalary as varchar)
        ,drvThousandHoursServiceCode = CASE WHEN PehCurHrs > 100 THEN 'Y' ELSE 'N' END
        ,drvNumberofFederalExemptions = (Select top 1 EetExemptions from EmpTax where eeteeid = xeeid)
        ,drvMaritalStatus = eepmaritalstatus
        ,drvEmployeeStatusCode = CASE WHEN EecEmplStatus = 'A' THEN '003' 
                                      WHEN EecEmplStatus IN ('L','O','S') THEN '006' 
                                      WHEN EecEmplStatus IN ('T','R') and PehCurHrs < 500 THEN '001' 
                                      WHEN EecEmplStatus IN ('T','R') and PehCurHrs > 500 THEN '002' 
                                 END
        ,drvPayrollFrequencyCode = CASE WHEN eecpayperiod = 'W' THEN '0'
                                        WHEN eecpayperiod = 'M' THEN '3'
                                        WHEN eecpayperiod = 'B' THEN '1'
                                        WHEN eecpayperiod = 'S' THEN '2'
                                   END
        ,drvHighlyCompensatedCode = ''
        ,drvInsiderCode = ''
        ,drvUnionClassificationCode = ''
        ,drvPayrollStatusCode = CASE WHEN EecSalaryOrHourly  = 'H' THEN 'HRLY' ELSE 'SLRY' END
    INTO dbo.U_EASC401CEN_drvInfo
    FROM dbo.U_EASC401CEN_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
            and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                        and EXISTS(select 1 from dbo.U_EASC401CEN_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    /*JOIN dbo.U_dsi_BDM_EASC401CEN WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    */
    LEFT JOIN dbo.U_EASC401CEN_PEarHist WITH (NOLOCK)
        on peheeid  = xeeid
    JOIN dbo.Company WITH (NOLOCK)
        ON EecCOID = CmpCOID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASC401CEN_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CEN_Header;
    SELECT DISTINCT
         drvHeader = 'HDR'
        ,drvFileType = 'CENS'
        ,drvClientId = '258952'
        ,drvBlankSpaces = ''
        ,drvClientName = 'SALEM COUNTY HOSPITAL'
        ,drvFilecreationdate = GETDATE()
        ,drvSiteCode = 'A'
        ,drvBlankFill = ''
    INTO dbo.U_EASC401CEN_Header
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
ALTER VIEW dbo.dsi_vwEASC401CEN_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASC401CEN_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASC401CEN%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202102081'
       ,expStartPerControl     = '202102081'
       ,expLastEndPerControl   = '202102159'
       ,expEndPerControl       = '202102159'
WHERE expFormatCode = 'EASC401CEN';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASC401CEN_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EASC401CEN_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2