SET NOCOUNT ON;
IF OBJECT_ID('U_EFSACOBBIL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFSACOBBIL_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFSACOBBIL' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFSACOBBIL_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFSACOBBIL_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFSACOBBIL') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFSACOBBIL];
GO
IF OBJECT_ID('U_EFSACOBBIL_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_PEarHist];
GO
IF OBJECT_ID('U_EFSACOBBIL_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_PDedHist];
GO
IF OBJECT_ID('U_EFSACOBBIL_OptRate') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_OptRate];
GO
IF OBJECT_ID('U_EFSACOBBIL_File') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_File];
GO
IF OBJECT_ID('U_EFSACOBBIL_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_EEList];
GO
IF OBJECT_ID('U_EFSACOBBIL_drvTbl_30') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_drvTbl_30];
GO
IF OBJECT_ID('U_EFSACOBBIL_drvTbl_20') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_drvTbl_20];
GO
IF OBJECT_ID('U_EFSACOBBIL_drvTbl_10') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_drvTbl_10];
GO
IF OBJECT_ID('U_EFSACOBBIL_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EFSACOBBIL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFSACOBBIL];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFSACOBBIL';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFSACOBBIL';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFSACOBBIL';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFSACOBBIL';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFSACOBBIL';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EFSACOBBIL','NuSynergy FSA, Cobra, Billing Combined Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EFSACOBBILZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Record Type"','1','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TPA ID"','2','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','2',NULL,'TPA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer ID"','3','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','3',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','4','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN"','5','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','5',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name"','6','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name"','7','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','7',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Middle Initial"','8','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','8',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Birthdate"','9','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','9',NULL,'Birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','10','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','10',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','11','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','11',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','12','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','12',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','13','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','13',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','14','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','14',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','15','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','15',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone"','16','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','16',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E-mail"','17','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','17',NULL,'E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Status"','18','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','18',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan ID"','19','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','19',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Type"','20','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','20',NULL,'Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Start Date"','21','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','21',NULL,'Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan End Date"','22','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','22',NULL,'Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Status"','23','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','23',NULL,'Account Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Pay Period Election"','24','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','24',NULL,'Employee Pay Period Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Pay Period Election"','25','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','25',NULL,'Employer Pay Period Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Prefunded-Annual Election Amount"','26','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','26',NULL,'Original Prefunded-Annual Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSA Effective Date"','27','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','27',NULL,'FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSA Termination Date"','28','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','28',NULL,'FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ER_TAXID"','29','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','30',NULL,'ER_TAXID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_SSN"','30','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','31',NULL,'MM_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_LAST"','31','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','32',NULL,'MM_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_FIRST"','32','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','33',NULL,'MM_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_INITIAL"','33','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','34',NULL,'MM_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_BORN"','34','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','35',NULL,'MM_BORN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_ADDR1"','35','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','36',NULL,'MM_ADDR1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_ADDR2"','36','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','37',NULL,'MM_ADDR2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_CITY"','37','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','38',NULL,'MM_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_STATE"','38','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','39',NULL,'MM_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_ZIP"','39','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','40',NULL,'MM_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_COUNTRY"','40','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','41',NULL,'MM_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_GENDER"','41','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','42',NULL,'MM_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DIV_NAME"','42','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','43',NULL,'DIV_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP_LAST"','43','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','44',NULL,'SP_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP_FIRST"','44','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','45',NULL,'SP_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP_SSN"','45','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','46',NULL,'SP_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SP_DOB"','46','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','47',NULL,'SP_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_RELAT"','47','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','48',NULL,'DEP1_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_LAST"','48','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','49',NULL,'DEP1_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_FIRST"','49','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','50',NULL,'DEP1_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_SSN"','50','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','51',NULL,'DEP1_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP1_DOB"','51','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','52',NULL,'DEP1_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_RELAT"','52','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','53',NULL,'DEP2_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_LAST"','53','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','54',NULL,'DEP2_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_FIRST"','54','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','55',NULL,'DEP2_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_SSN"','55','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','56',NULL,'DEP2_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP2_DOB"','56','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','57',NULL,'DEP2_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_RELAT"','57','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','58',NULL,'DEP3_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_LAST"','58','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','59',NULL,'DEP3_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_FIRST"','59','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','60',NULL,'DEP3_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_SSN"','60','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','61',NULL,'DEP3_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP3_DOB"','61','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','62',NULL,'DEP3_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_RELAT"','62','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','63',NULL,'DEP4_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_LAST"','63','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','64',NULL,'DEP4_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_FIRST"','64','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','65',NULL,'DEP4_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_SSN"','65','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','66',NULL,'DEP4_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP4_DOB"','66','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','67',NULL,'DEP4_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_RELAT"','67','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','68',NULL,'DEP5_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_LAST"','68','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','69',NULL,'DEP5_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_FIRST"','69','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','70',NULL,'DEP5_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_SSN"','70','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','71',NULL,'DEP5_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP5_DOB"','71','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','72',NULL,'DEP5_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_RELAT"','72','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','73',NULL,'DEP6_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_LAST"','73','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','74',NULL,'DEP6_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_FIRST"','74','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','75',NULL,'DEP6_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_SSN"','75','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','76',NULL,'DEP6_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP6_DOB"','76','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','77',NULL,'DEP6_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_RELAT"','77','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','78',NULL,'DEP7_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_LAST"','78','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','79',NULL,'DEP7_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_FIRST"','79','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','80',NULL,'DEP7_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_SSN"','80','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','81',NULL,'DEP7_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP7_DOB"','81','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','82',NULL,'DEP7_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_RELAT"','82','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','83',NULL,'DEP8_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_LAST"','83','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','84',NULL,'DEP8_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_FIRST"','84','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','85',NULL,'DEP8_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_SSN"','85','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','86',NULL,'DEP8_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP8_DOB"','86','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','87',NULL,'DEP8_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BN1_IMP"','87','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','88',NULL,'BN1_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BNT1_IMP"','88','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','89',NULL,'BNT1_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BN2_IMP"','89','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','90',NULL,'BN2_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BNT2_IMP"','90','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','91',NULL,'BNT2_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BN3_IMP"','91','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','92',NULL,'BN3_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BNT3_IMP"','92','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','93',NULL,'BNT3_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BN4_IMP"','93','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','94',NULL,'BN4_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BNT4_IMP"','94','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','95',NULL,'BNT4_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BN5_IMP"','95','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','96',NULL,'BN5_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BNT5_IMP"','96','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','97',NULL,'BNT5_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BN6_IMP"','97','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','98',NULL,'BN6_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BNT6_IMP"','98','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','99',NULL,'BNT6_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MM_HIPAA"','99','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','100',NULL,'MM_HIPAA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BN_EFFECT"','100','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','101',NULL,'BN_EFFECT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QE_DATE"','101','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','102',NULL,'QE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QE_TYPE"','102','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','103',NULL,'QE_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Name"','103','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','105',NULL,'Group Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Carrier Name"','104','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','106',NULL,'Carrier Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Number"','105','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','107',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Number"','106','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','108',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Type"','107','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','109',NULL,'Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Name"','108','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','110',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Start Date"','109','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','111',NULL,'Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan End Date"','110','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','112',NULL,'Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN"','111','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','113',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name"','112','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','114',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name"','113','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','115',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Active-Inactive"','114','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','116',NULL,'Active-Inactive',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Relationship"','115','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','117',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Type"','116','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','118',NULL,'Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Name"','117','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','119',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Carrier Name"','118','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','120',NULL,'Carrier Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Level"','119','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','121',NULL,'Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Amount"','120','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','122',NULL,'Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Start Date"','121','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','123',NULL,'Effective Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective End Date"','122','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','124',NULL,'Effective End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Monthly Premium"','123','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','125',NULL,'Employee Monthly Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Monthly Premium"','124','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','126',NULL,'Employer Monthly Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Account Number"','125','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','127',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Group Number"','126','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','128',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Per Pay Contribution"','127','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','129',NULL,'Employee Per Pay Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Per Pay Contribution"','128','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','130',NULL,'Employer Per Pay Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','129','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','131',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Middle Name"','130','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','132',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','131','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','133',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Gender"','132','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','134',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','133','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','135',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tobacco User Status"','134','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','136',NULL,'Tobacco User Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Salary"','135','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','137',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Frequency"','136','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','138',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','137','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','139',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','138','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','140',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class"','139','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','141',NULL,'Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','140','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','142',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Termination Date"','141','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','143',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Modified"','142','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','144',NULL,'Last Modified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Student"','143','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','145',NULL,'Student',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','144','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','146',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Date Of Hire"','145','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','147',NULL,'Employee Date Of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Cobra Enrollment"','146','(''DA''=''T,'')','EFSACOBBILZ0','50','H','01','148',NULL,'Cobra Enrollment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Type Code"','147','(''DA''=''T'')','EFSACOBBILZ0','50','H','01','149',NULL,'Plan Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FL"','1','(''DA''=''T,'')','EFSACOBBILZ0','50','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"T00445"','2','(''DA''=''T,'')','EFSACOBBILZ0','50','D','10','2',NULL,'TPA ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NUEDELTA"','3','(''DA''=''T,'')','EFSACOBBILZ0','50','D','10','3',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','4','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','5','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','5',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','6',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','7',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMI"','8','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','8',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','9','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','10','9',NULL,'Birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','10','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','10',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','11','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','11',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','12','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','12',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','13','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','13',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','14','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','14',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddrssCountry"','15','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','15',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressPhone"','16','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','16',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','17','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','17',NULL,'E-mail',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplStatus"','18','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','18',NULL,'Employee Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId"','19','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','19',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountType"','20','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','20',NULL,'Account Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanStartDate"','21','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','10','21',NULL,'Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEndDate"','22','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','10','22',NULL,'Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountSatus"','23','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','23',NULL,'Account Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplePayPeriodElect"','24','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','24',NULL,'Employee Pay Period Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmplrPayPeriodElect"','25','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','25',NULL,'Employer Pay Period Election',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgPrefAnnElecAmt"','26','(''UA''=''T,'')','EFSACOBBILZ0','50','D','10','26',NULL,'Original Prefunded-Annual Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFsaEffDate"','27','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','10','27',NULL,'FSA Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFsaTermDate"','28','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','10','28',NULL,'FSA Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CA"','1','(''DA''=''T,'')','EFSACOBBILZ0','50','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCAOffset"','2','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','2',NULL,'ER_TAXID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerTaxId"','3','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','2',NULL,'ER_TAXID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','4','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','3',NULL,'MM_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','4',NULL,'MM_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','5',NULL,'MM_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMi"','7','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','6',NULL,'MM_INITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','8','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','7',NULL,'MM_BORN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','9','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','8',NULL,'MM_ADDR1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','9',NULL,'MM_ADDR2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','10',NULL,'MM_CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','11',NULL,'MM_STATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','12',NULL,'MM_ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','14','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','13',NULL,'MM_COUNTRY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','14',NULL,'MM_GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionName"','16','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','15',NULL,'DIV_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameLast"','17','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','16',NULL,'SP_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseNameFirst"','18','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','17',NULL,'SP_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseSsn"','19','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','18',NULL,'SP_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateOfBirth"','20','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','19',NULL,'SP_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Relationship"','21','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','20',NULL,'DEP1_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1NameLast"','22','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','21',NULL,'DEP1_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1NameFirst"','23','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','22',NULL,'DEP1_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1Ssn"','24','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','23',NULL,'DEP1_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep1DateOfBirth"','25','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','24',NULL,'DEP1_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Relationship"','26','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','25',NULL,'DEP2_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2NameLast"','27','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','26',NULL,'DEP2_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2NameFirst"','28','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','27',NULL,'DEP2_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2Ssn"','29','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','28',NULL,'DEP2_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep2DateOfBirth"','30','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','29',NULL,'DEP2_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Relationship"','31','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','30',NULL,'DEP3_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3NameLast"','32','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','31',NULL,'DEP3_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3NameFirst"','33','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','32',NULL,'DEP3_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3Ssn"','34','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','33',NULL,'DEP3_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep3DateOfBirth"','35','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','34',NULL,'DEP3_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Relationship"','36','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','35',NULL,'DEP4_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4NameLast"','37','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','36',NULL,'DEP4_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4NameFirst"','38','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','37',NULL,'DEP4_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4Ssn"','39','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','38',NULL,'DEP4_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep4DateOfBirth"','40','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','39',NULL,'DEP4_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Relationship"','41','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','40',NULL,'DEP5_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5NameLast"','42','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','41',NULL,'DEP5_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5NameFirst"','43','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','42',NULL,'DEP5_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5Ssn"','44','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','43',NULL,'DEP5_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep5DateOfBirth"','45','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','44',NULL,'DEP5_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Relationship"','46','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','45',NULL,'DEP6_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6NameLast"','47','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','46',NULL,'DEP6_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6NameFirst"','48','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','47',NULL,'DEP6_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6Ssn"','49','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','48',NULL,'DEP6_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep6DateOfBirth"','50','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','49',NULL,'DEP6_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Relationship"','51','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','50',NULL,'DEP7_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7NameLast"','52','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','51',NULL,'DEP7_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7NameFirst"','53','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','52',NULL,'DEP7_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7Ssn"','54','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','53',NULL,'DEP7_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep7DateOfBirth"','55','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','54',NULL,'DEP7_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8Relationship"','56','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','55',NULL,'DEP8_RELAT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8NameLast"','57','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','56',NULL,'DEP8_LAST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8NameFirst"','58','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','57',NULL,'DEP8_FIRST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8Ssn"','59','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','58',NULL,'DEP8_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDep8DateOfBirth"','60','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','59',NULL,'DEP8_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBene1Imp"','61','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','60',NULL,'BN1_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneTier1Imp"','62','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','61',NULL,'BNT1_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBene2Imp"','63','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','62',NULL,'BN2_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneTier2Imp"','64','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','63',NULL,'BNT2_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBene3Imp"','65','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','64',NULL,'BN3_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneTier3Imp"','66','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','65',NULL,'BNT3_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBene4Imp"','67','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','66',NULL,'BN4_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneTier4Imp"','68','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','67',NULL,'BNT4_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBene5Imp"','69','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','68',NULL,'BN5_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneTier5Imp"','70','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','69',NULL,'BNT5_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBene6Imp"','71','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','70',NULL,'BN6_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBeneTier6Imp"','72','(''UA''=''T,'')','EFSACOBBILZ0','50','D','20','71',NULL,'BNT6_IMP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHippaEffDate"','73','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','72',NULL,'MM_HIPAA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitsEffDate"','74','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','73',NULL,'BN_EFFECT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualEventDate"','75','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','20','74',NULL,'QE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQualEventType"','76','(''UA''=''T'')','EFSACOBBILZ0','50','D','20','75',NULL,'QE_TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CB"','1','(''DA''=''T,'')','EFSACOBBILZ0','50','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCBOffSet"','2','(''UA''=''T,'')','EFSACOBBILZ0','500','D','30','3',NULL,'Carrier Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Delta Dental of Washington"','3','(''DA''=''T,'')','EFSACOBBILZ0','50','D','30','2',NULL,'Group Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierName"','4','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','3',NULL,'Carrier Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber"','5','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','4',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber"','6','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','5',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitType"','7','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','6',NULL,'Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','8','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','7',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanStartDate"','9','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','8',NULL,'Plan Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEndDate"','10','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','9',NULL,'Plan End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','11','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','10',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','12','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','11',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','13','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','12',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActiveOrInactive"','14','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','13',NULL,'Active-Inactive',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationship"','15','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','14',NULL,'Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitType2"','16','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','15',NULL,'Benefit Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName2"','17','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','16',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCarrierName2"','18','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','17',NULL,'Carrier Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageLevel"','19','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','18',NULL,'Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitAmt"','20','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','19',NULL,'Benefit Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffStartDate"','21','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','20',NULL,'Effective Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffEndDate"','22','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','21',NULL,'Effective End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMonthPrem"','23','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','22',NULL,'Employee Monthly Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerMonthPrem"','24','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','23',NULL,'Employer Monthly Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNumber2"','25','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','24',NULL,'Account Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupNumber2"','26','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','25',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePerPayContrib"','27','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','26',NULL,'Employee Per Pay Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerPerPayContrib"','28','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','27',NULL,'Employer Per Pay Contribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','29','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','28',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpMI"','30','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','29',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','31','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','30',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeGender"','33','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','31',NULL,'Employee Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','34','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','32',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTabaccoStatus"','35','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','33',NULL,'Tobacco User Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','36','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','34',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','37','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','35',NULL,'Pay Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','38','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','36',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','39','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','37',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClass"','40','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','38',NULL,'Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivisionName"','41','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','39',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeTermDate"','42','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','40',NULL,'Employee Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastModifiedDate"','43','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','41',NULL,'Last Modified',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStudent"','44','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','42',NULL,'Student',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','45','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','43',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeDateOfHire"','46','(''UD112''=''T,'')','EFSACOBBILZ0','50','D','30','44',NULL,'Employee Date Of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCobraEnrollment"','47','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','45',NULL,'Cobra Enrollment',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanTypeCode"','48','(''UA''=''T,'')','EFSACOBBILZ0','50','D','30','46',NULL,'Plan Type Code',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSACOBBIL_20200416.txt',NULL,'','',NULL,NULL,NULL,NULL,'NuSynergy FSA/Cobra/Billing Ex','202012319','EMPEXPORT','ONDEMAND',NULL,'EFSACOBBIL',NULL,NULL,NULL,'202012319','Dec 12 2019 11:44AM','Dec 12 2019 11:44AM','202003011',NULL,'','','202003011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSACOBBIL_20200416.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202012319','EMPEXPORT','SCHEDULED',NULL,'EFSACOBBIL',NULL,NULL,NULL,'202012319','Dec 12 2019 11:44AM','Dec 12 2019 11:44AM','202003011',NULL,'','','202003011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSACOBBIL_20200416.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202012319','EMPEXPORT','OEACTIVE',NULL,'EFSACOBBIL',NULL,NULL,NULL,'202012319','Dec 12 2019 11:44AM','Dec 12 2019 11:44AM','202003011',NULL,'','','202003011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSACOBBIL_20200416.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202012319','EMPEXPORT','OEPASSIVE',NULL,'EFSACOBBIL',NULL,NULL,NULL,'202012319','Dec 12 2019 11:44AM','Dec 12 2019 11:44AM','202003011',NULL,'','','202003011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EFSACOBBIL_20200416.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202004019','EMPEXPORT','TEST','Apr  1 2020  2:42PM','EFSACOBBIL',NULL,NULL,NULL,'202004019','Apr  1 2020 12:00AM','Dec 30 1899 12:00AM','202003181','4169','','','202003181',dbo.fn_GetTimedKey(),NULL,'us3lKiWAS1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EFSACOBBIL_20200416.txt' END WHERE expFormatCode = 'EFSACOBBIL';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSACOBBIL','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSACOBBIL','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSACOBBIL','SubSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSACOBBIL','SubSort2','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSACOBBIL','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFSACOBBIL','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EFSACOBBIL' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EFSACOBBIL' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EFSACOBBIL_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFSACOBBIL_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSACOBBIL','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSACOBBIL','D10','dbo.U_EFSACOBBIL_drvTbl_10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSACOBBIL','D20','dbo.U_EFSACOBBIL_drvTbl_20',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFSACOBBIL','D30','dbo.U_EFSACOBBIL_drvTbl_30',NULL);
IF OBJECT_ID('U_dsi_BDM_EFSACOBBIL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFSACOBBIL] (
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
IF OBJECT_ID('U_EFSACOBBIL_DedList') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFSACOBBIL_drvTbl_10') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_drvTbl_10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] int NOT NULL,
    [drvSort2] char(11) NULL,
    [drvEmpId] varchar(8000) NULL,
    [drvSsn] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMI] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddrssCountry] varchar(2) NOT NULL,
    [drvAddressPhone] varchar(50) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvEmplStatus] varchar(1) NOT NULL,
    [drvPlanId] varchar(33) NULL,
    [drvAccountType] varchar(3) NULL,
    [drvPlanStartDate] varchar(34) NULL,
    [drvPlanEndDate] varchar(34) NULL,
    [drvAccountSatus] varchar(1) NOT NULL,
    [drvEmplePayPeriodElect] nvarchar(4000) NULL,
    [drvEmplrPayPeriodElect] varchar(1) NOT NULL,
    [drvOrgPrefAnnElecAmt] nvarchar(4000) NULL,
    [drvFsaEffDate] datetime NULL,
    [drvFsaTermDate] datetime NULL
);
IF OBJECT_ID('U_EFSACOBBIL_drvTbl_20') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_drvTbl_20] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] int NOT NULL,
    [drvSort2] char(5) NULL,
    [drvCAOffset] varchar(26) NULL,
    [drvEmployerTaxId] char(9) NULL,
    [drvSsn] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvMi] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvGender] char(1) NULL,
    [drvDivisionName] varchar(1) NOT NULL,
    [drvSpouseNameLast] varchar(100) NULL,
    [drvSpouseNameFirst] varchar(100) NULL,
    [drvSpouseSsn] char(11) NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvDep1Relationship] char(3) NULL,
    [drvDep1NameLast] varchar(100) NULL,
    [drvDep1NameFirst] varchar(100) NULL,
    [drvDep1Ssn] char(11) NULL,
    [drvDep1DateOfBirth] datetime NULL,
    [drvDep2Relationship] char(3) NULL,
    [drvDep2NameLast] varchar(100) NULL,
    [drvDep2NameFirst] varchar(100) NULL,
    [drvDep2Ssn] char(11) NULL,
    [drvDep2DateOfBirth] datetime NULL,
    [drvDep3Relationship] char(3) NULL,
    [drvDep3NameLast] varchar(100) NULL,
    [drvDep3NameFirst] varchar(100) NULL,
    [drvDep3Ssn] char(11) NULL,
    [drvDep3DateOfBirth] datetime NULL,
    [drvDep4Relationship] char(3) NULL,
    [drvDep4NameLast] varchar(100) NULL,
    [drvDep4NameFirst] varchar(100) NULL,
    [drvDep4Ssn] char(11) NULL,
    [drvDep4DateOfBirth] datetime NULL,
    [drvDep5Relationship] char(3) NULL,
    [drvDep5NameLast] varchar(100) NULL,
    [drvDep5NameFirst] varchar(100) NULL,
    [drvDep5Ssn] char(11) NULL,
    [drvDep5DateOfBirth] datetime NULL,
    [drvDep6Relationship] char(3) NULL,
    [drvDep6NameLast] varchar(100) NULL,
    [drvDep6NameFirst] varchar(100) NULL,
    [drvDep6Ssn] char(11) NULL,
    [drvDep6DateOfBirth] datetime NULL,
    [drvDep7Relationship] char(3) NULL,
    [drvDep7NameLast] varchar(100) NULL,
    [drvDep7NameFirst] varchar(100) NULL,
    [drvDep7Ssn] char(11) NULL,
    [drvDep7DateOfBirth] datetime NULL,
    [drvDep8Relationship] char(3) NULL,
    [drvDep8NameLast] varchar(100) NULL,
    [drvDep8NameFirst] varchar(100) NULL,
    [drvDep8Ssn] char(11) NULL,
    [drvDep8DateOfBirth] datetime NULL,
    [drvBene1Imp] varchar(8) NULL,
    [drvBeneTier1Imp] varchar(3) NULL,
    [drvBene2Imp] varchar(7) NULL,
    [drvBeneTier2Imp] varchar(3) NULL,
    [drvBene3Imp] varchar(7) NULL,
    [drvBeneTier3Imp] varchar(3) NULL,
    [drvBene4Imp] varchar(3) NULL,
    [drvBeneTier4Imp] varchar(5) NULL,
    [drvBene5Imp] varchar(1) NOT NULL,
    [drvBeneTier5Imp] varchar(1) NOT NULL,
    [drvBene6Imp] varchar(1) NOT NULL,
    [drvBeneTier6Imp] varchar(1) NOT NULL,
    [drvHippaEffDate] varchar(1) NOT NULL,
    [drvBenefitsEffDate] datetime NULL,
    [drvQualEventDate] datetime NULL,
    [drvQualEventType] varchar(3) NULL
);
IF OBJECT_ID('U_EFSACOBBIL_drvTbl_30') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_drvTbl_30] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] int NOT NULL,
    [drvSort2] char(5) NULL,
    [drvCBOffSet] varchar(100) NULL,
    [drvCarrierName] varchar(12) NULL,
    [drvAccountNumber] varchar(1) NOT NULL,
    [drvGroupNumber] varchar(1) NOT NULL,
    [drvBenefitType] varchar(14) NULL,
    [drvPlanName] varchar(14) NULL,
    [drvPlanStartDate] varchar(8) NULL,
    [drvPlanEndDate] varchar(10) NULL,
    [drvSsn] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvActiveOrInactive] varchar(8) NOT NULL,
    [drvRelationship] varchar(6) NULL,
    [drvBenefitType2] varchar(7) NULL,
    [drvPlanName2] varchar(11) NULL,
    [drvCarrierName2] varchar(12) NULL,
    [drvCoverageLevel] varchar(3) NULL,
    [drvBenefitAmt] nvarchar(4000) NULL,
    [drvEffStartDate] datetime NULL,
    [drvEffEndDate] datetime NULL,
    [drvEmployeeMonthPrem] money NULL,
    [drvEmployerMonthPrem] money NULL,
    [drvAccountNumber2] varchar(1) NOT NULL,
    [drvGroupNumber2] varchar(1) NOT NULL,
    [drvEmployeePerPayContrib] varchar(1) NOT NULL,
    [drvEmployerPerPayContrib] varchar(1) NOT NULL,
    [drvEmployeeNumber] varchar(8000) NULL,
    [drvEmpMI] varchar(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvEmployeeGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvTabaccoStatus] varchar(1) NULL,
    [drvSalary] money NULL,
    [drvPayFrequency] char(1) NULL,
    [drvDepartment] varchar(1) NOT NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvClass] varchar(1) NOT NULL,
    [drvDivisionName] varchar(1) NOT NULL,
    [drvEmployeeTermDate] datetime NULL,
    [drvLastModifiedDate] varchar(1) NOT NULL,
    [drvStudent] varchar(1) NOT NULL,
    [drvZipCode] varchar(1) NOT NULL,
    [drvEmployeeDateOfHire] datetime NULL,
    [drvCobraEnrollment] varchar(1) NOT NULL,
    [drvPlanTypeCode] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EFSACOBBIL_EEList') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFSACOBBIL_File') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EFSACOBBIL_OptRate') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_OptRate] (
    [CorDedCode] char(5) NOT NULL,
    [CorBenOption] char(6) NOT NULL,
    [CoreEERate] money NULL
);
IF OBJECT_ID('U_EFSACOBBIL_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhFsaCurAmt] numeric NULL,
    [PdhLifeCurAmt] numeric NULL,
    [PdhCalcBasisCurAmt] numeric NULL,
    [PdhEmpMonthPreimAmt] numeric NULL,
    [PdhFlCurAmt] numeric NULL,
    [PdhFlDCurAmt] numeric NULL,
    [PdhFlGoalAmt] numeric NULL,
    [PdhFlDGoalAmt] numeric NULL,
    [PdhLIFEEAmt] numeric NULL,
    [PdhLIFECAmt] numeric NULL,
    [PdhLIFESAmt] numeric NULL,
    [PdhSADDAmt] numeric NULL
);
IF OBJECT_ID('U_EFSACOBBIL_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFSACOBBIL_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFSACOBBIL]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Delta Dental of Washington

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/12/2019
Service Request Number: SR-2016-00012345

Purpose: NuSynergy FSA, Cobra, Billing Combined Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFSACOBBIL';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFSACOBBIL';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFSACOBBIL';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EFSACOBBIL';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFSACOBBIL' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSACOBBIL', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSACOBBIL', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFSACOBBIL', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EFSACOBBIL';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFSACOBBIL', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EFSACOBBIL';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = '1/1/2020'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFSACOBBIL_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFSACOBBIL_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EFSACOBBIL_EEList where xEEID IN (
        select distinct eeceeid from empcomp where eecEEType IN('TES')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE    @DedList VARCHAR(MAX)
            ,@NonCobraDedList VARCHAR(MAX)
        --    ,@FsaDedList VARCHAR(MAX)
            ,@CobraDedList VARCHAR(MAX)
            ,@CombDedList VARCHAR(MAX);

    SET @DedList = 'FSA4, FSAHC, FSAI, FSAL, FSANM, FSAO, FSAU or FSADC, MC4, MCI, MCU, ME4, MEI, MEU, MG4, MGI, MGU, FSA4, FSAHC, FSAI, FSAL, FSANM, FSAO,FSAU, MC4, MCI, MCU, ME4, MEI, MEU, MG4, MGI, MGU, GADD, GLIFE, ELTD, LTD, STDB, LIFEC, LIFEE, LIFES,SADD';
    SET @NonCobraDedList = 'FSA4,FSAHC,FSAI,FSAL,FSANM,FSAO,FSAU,FSADC,MC4,MCI,MCU,ME4,MEI,MEU,MG4,MGI,MGU,GADD,GLIFE,ELTD,LTD,STDB,LIFEC,LIFES,LIFEE,SADD';
    --SET @FsaDedList = 'FSA4, FSAHC,FSAI,FSAL,FSANM,FSAO,FSAU,FSADC';
    SET @CobraDedList = 'MC4,MCI,MCU,ME4,MEI,MEU,MG4,MGI,MGU,FSA4,FSAHC,FSAI,FSAL,FSANM,FSAO,FSAU';
    SET @CombDedList = 'MC4,MCI,MCU,ME4,MEI,MEU,MG4,MGI,MGU,GADD,GLIFE,ELTD,LTD,STDB,LIFEC,LIFES,LIFEE,SADD';


    IF OBJECT_ID('U_EFSACOBBIL_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFSACOBBIL_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EFSACOBBIL_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;
    
    --******************************************
    -- NON-COBRA SECTION
    --******************************************
    
    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@NonCobraDedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'NONCOB')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','DAU,SON,DIS,STC')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');

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
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    --******************************************
    -- COBRA SECTION
    --******************************************

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@CobraDedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '201,204,LEVNT3,LEVNT4,206,207,203,200') 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '201,204,LEVNT3,LEVNT4,206,207,203,200')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','4'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','3'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exist
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,LEVNT3,LEVNT4,206,207,203,200'); -- Valid dependent PQB reasons
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,LEVNT3,LEVNT4,206,207,203,200'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
   
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','DAU,SON,DIS,STC')
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'Cobra')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')

    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EFSACOBBIL_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFSACOBBIL_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhFsaCurAmt     = SUM(CASE WHEN PdhDedCode IN ('SA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU', 'FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhLifeCurAmt    = SUM(CASE WHEN PdhDedCode IN ('GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFES', 'SADD') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhCalcBasisCurAmt    = SUM(CASE WHEN PdhDedCode IN ('GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFES', 'SADD') THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhEmpMonthPreimAmt    = SUM(CASE WHEN PdhDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFES', 'SADD') THEN PdhDedCalcBasisAmt ELSE 0.00 END) -- use BdmEEAmt
        ,PdhFlCurAmt = SUM(CASE WHEN PdhDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFlDCurAmt = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhFlGoalAmt = MAX(CASE WHEN PdhDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN PdhEEGoalAmt ELSE 0.00 END)
        ,PdhFlDGoalAmt = MAX(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEEGoalAmt ELSE 0.00 END)
        ,PdhLIFEEAmt = MAX(CASE WHEN PdhDedCode = 'LIFEE' THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhLIFECAmt = MAX(CASE WHEN PdhDedCode = 'LIFEC' THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhLIFESAmt = MAX(CASE WHEN PdhDedCode = 'LIFES' THEN PdhDedCalcBasisAmt ELSE 0.00 END)
        ,PdhSADDAmt = MAX(CASE WHEN PdhDedCode = 'SADD' THEN PdhDedCalcBasisAmt ELSE 0.00 END)
    INTO dbo.U_EFSACOBBIL_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EFSACOBBIL_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EFSACOBBIL_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFSACOBBIL_PEarHist;
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
    INTO dbo.U_EFSACOBBIL_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;


    IF OBJECT_ID('U_EFSACOBBIL_OptRate','U') IS NOT NULL
        DROP TABLE dbo.U_EFSACOBBIL_OptRate;
    SELECT CorDedCode, CorBenOption, CorEERate*2 AS CoreEERate
    INTO dbo.U_EFSACOBBIL_OptRate
    FROM (
        SELECT CorDedCode, CorBenOption, CorEERate, CorEffDate, ROW_NUMBER() OVER(PARTITION BY CorDedCode, CorBenOption ORDER BY CorEffDate DESC) AS RN
        FROM dbo.OptRate WITH (NOLOCK)
        WHERE CorDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU')) AS T
    WHERE RN = 1
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EFSACOBBIL_drvTbl_10
    ---------------------------------
    IF OBJECT_ID('U_EFSACOBBIL_drvTbl_10','U') IS NOT NULL
        DROP TABLE dbo.U_EFSACOBBIL_drvTbl_10;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = 1
        ,drvSort2 = EepSSN
        -- standard fields above and additional driver fields below
        ,drvEmpId = REPLACE(EepUDField02, '-', '')
        ,drvSsn = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMI = LEFT(EepNameMiddle, 1)
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddrssCountry = 'US'
        ,drvAddressPhone = EepPhoneHomeNumber -- rename this on next ripout
        ,drvEmailAddress = EepAddressEMail
        ,drvEmplStatus = CASE WHEN EecEmplStatus = 'T' THEN '5' ELSE '2' END
        ,drvPlanId =    CASE WHEN BdmDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN 'FSA' + CAST(YEAR(GETDATE()) AS VARCHAR)
                            WHEN BdmDedCode IN ('FSADC') THEN 'DCS' + CAST(YEAR(GETDATE()) AS VARCHAR) END
        ,drvAccountType =    CASE WHEN BdmDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN 'FSA'
                                WHEN BdmDedCode IN ('FSADC') THEN 'DCA'
                                WHEN BdmDedCode IN ('HS4F', 'HS4FC', 'HS4I', 'HS4IC', 'HSACU', 'HSAM', 'HSANO', 'HSIF', 'HSIFC', 'HSII', 'HSIIC', 'HSUF', 'HSUFC', 'HSUIC', 'HSUI') THEN 'ABH'
                                WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU') THEN 'LP2'
                            END
        ,drvPlanStartDate = CAST(YEAR(GETDATE()) AS VARCHAR) + '0101'
        ,drvPlanEndDate = CAST(YEAR(GETDATE()) AS VARCHAR) + '1231'
        ,drvAccountSatus = CASE WHEN EecEmplStatus = 'T' THEN '5' ELSE '2' END
        --PdhGoalAmt
        ,drvEmplePayPeriodElect =    CASE WHEN BdmDedCode in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') AND PdhFlCurAmt >= 0 THEN FORMAT(BdmEEAmt, '#0.00') -- JCB
                                        --WHEN BdmDedCode in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') AND PdhFlCurAmt >= 0 THEN FORMAT(PdhFlCurAmt, '#0.00') -- JCB
                                        WHEN BdmDedCode in ('FSADC') AND PdhFlDCurAmt >= 0 THEN FORMAT(BdmEEAmt, '#0.00') -- JCB    
                                        --WHEN BdmDedCode in ('FSADC') AND PdhFlDCurAmt >= 0 THEN FORMAT(PdhFlDCurAmt, '#0.00') -- JCB    
                                        ELSE '0.00' 
                                    END 
        ,drvEmplrPayPeriodElect = '0'
        ,drvOrgPrefAnnElecAmt =    CASE WHEN BdmDedCode in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU','FSADC') AND BdmEEGoalAmt >= 0 THEN FORMAT(BdmEEGoalAmt, '#0.00') 
                                    --BdmDedCode in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') AND PdhFlGoalAmt >= 0 THEN FORMAT(PdhFlGoalAmt, '#0.00') 
                                    --WHEN BdmDedCode in ('FSADC') AND PdhFlDGoalAmt >= 0 THEN FORMAT(PdhFlDGoalAmt, '#0.00') 
                                    ELSE '0.00' 
                                END
        ,drvFsaEffDate = BdmBenStartDate
        ,drvFsaTermDate = BdmBenStopDAte
    INTO dbo.U_EFSACOBBIL_drvTbl_10
    FROM dbo.U_EFSACOBBIL_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFSACOBBIL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EFSACOBBIL_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    WHERE BdmDedCode in ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU', 'FSADC')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EFSACOBBIL_drvTbl_20
    ---------------------------------
    IF OBJECT_ID('U_EFSACOBBIL_drvTbl_20','U') IS NOT NULL
        DROP TABLE dbo.U_EFSACOBBIL_drvTbl_20;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = 2
        ,drvSort2 = BdmDedCode -- EepSSN
        -- standard fields above and additional driver fields below
        ,drvCAOffset = REPLICATE(',', 26) 
        ,drvEmployerTaxId = (SELECT TOP 1 CmmFedTaxId from CompMast)
        ,drvSsn = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvMi = LEFT(EepNameMiddle, 1)
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvGender = EepGender
        ,drvDivisionName = ''
        ,drvSpouseNameLast = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConNameLast END
        ,drvSpouseNameFirst = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConNameFirst END
        ,drvSpouseSsn = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConSsn END
        ,drvSpouseDateOfBirth = CASE WHEN ConRelationship in ('SPS', 'DP') THEN ConDateOfBirth END
        ,drvDep1Relationship = DepRelationship1 -- CASE WHEN ConRelationship in ('SPS', 'DP') THEN 'Spouse' END
        ,drvDep1NameLast = DepLastName1
        ,drvDep1NameFirst = DepFirstName1
        ,drvDep1Ssn = DepSsn1
        ,drvDep1DateOfBirth = DepDateOfBirth1
        ,drvDep2Relationship = DepRelationship2
        ,drvDep2NameLast = DepLastName2
        ,drvDep2NameFirst = DepFirstName2
        ,drvDep2Ssn = DepSsn2
        ,drvDep2DateOfBirth = DepDateOfBirth2
        ,drvDep3Relationship = DepRelationship3
        ,drvDep3NameLast = DepLastName3
        ,drvDep3NameFirst = DepFirstName3
        ,drvDep3Ssn = DepSsn3
        ,drvDep3DateOfBirth = DepDateOfBirth3
        ,drvDep4Relationship = DepRelationship4
        ,drvDep4NameLast = DepLastName4
        ,drvDep4NameFirst = DepFirstName4
        ,drvDep4Ssn = DepSsn4
        ,drvDep4DateOfBirth = DepDateOfBirth4
        ,drvDep5Relationship = DepRelationship5
        ,drvDep5NameLast = DepLastName5
        ,drvDep5NameFirst = DepFirstName5
        ,drvDep5Ssn = DepSsn5
        ,drvDep5DateOfBirth = DepDateOfBirth5
        ,drvDep6Relationship = DepRelationship6
        ,drvDep6NameLast = DepLastName6
        ,drvDep6NameFirst = DepFirstName6
        ,drvDep6Ssn = DepSsn6
        ,drvDep6DateOfBirth = DepDateOfBirth6
        ,drvDep7Relationship = DepRelationship7
        ,drvDep7NameLast = DepLastName7
        ,drvDep7NameFirst = DepFirstName7
        ,drvDep7Ssn = DepSsn7
        ,drvDep7DateOfBirth = DepDateOfBirth7
        ,drvDep8Relationship = DepRelationship8
        ,drvDep8NameLast = DepLastName8
        ,drvDep8NameFirst = DepFirstName8
        ,drvDep8Ssn = DepSsn8
        ,drvDep8DateOfBirth = DepDateOfBirth8
        ,drvBene1Imp =     CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU') THEN 'MEDICAL1' 
                            WHEN BdmDedCode IN ('ME4', 'MEI', 'MEU') THEN 'MEDICAL3'
                            WHEN BdmDedCode IN ('MG4', 'MGI', 'MGU') THEN 'MEDICAL2'
                        END 
        ,drvBeneTier1Imp =    CASE WHEN BdmBenOption IN ('E') THEN 'EMP'
                                WHEN BdmBenOption IN ('EC', 'EK') THEN 'ECH'
                                WHEN BdmBenOption IN ('ES') THEN 'ESP'
                                WHEN BdmBenOption IN ('ESC', 'ESK') THEN 'FAM'
                            END
        ,drvBene2Imp =    CASE WHEN BdmDedCode in ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'DENTAL1' END
        ,drvBeneTier2Imp =    CASE WHEN BdmBenOption IN ('E') THEN 'EMP'
                                WHEN BdmBenOption IN ('EC', 'EK') THEN 'ECH'
                                WHEN BdmBenOption IN ('ES') THEN 'ESP'
                                WHEN BdmBenOption IN ('ESC', 'ESK') THEN 'FAM'
                            END
        ,drvBene3Imp = CASE WHEN BdmDedCode in ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'VISION1' END
        ,drvBeneTier3Imp = CASE WHEN BdmBenOption IN ('E') THEN 'EMP'
                                WHEN BdmBenOption IN ('EC', 'EK') THEN 'ECH'
                                WHEN BdmBenOption IN ('ES') THEN 'ESP'
                                WHEN BdmBenOption IN ('ESC', 'ESK') THEN 'FAM'
                            END
        ,drvBene4Imp = CASE WHEN BdmDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN 'FSA' END
        ,drvBeneTier4Imp = CASE WHEN BdmDedCode IN ('FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN 'OTHER' END
        ,drvBene5Imp =    ''
        ,drvBeneTier5Imp = ''
        ,drvBene6Imp = ''
        ,drvBeneTier6Imp = ''
        ,drvHippaEffDate = ''
        ,drvBenefitsEffDate = CASE WHEN BdmDedCode in ('MC4', 'MCI', 'MCU', 'MIE4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN BdmBenStartDate END
        ,drvQualEventDate =    BdmDateOFCobraEvent 
        ,drvQualEventType = --ISNULL(BdmDedCode, 'nope') + ' - ' + ISNULL(EecTermReason, 'nope') + ' - ' + ISNULL(BdmChangeReason, 'nope')
            CASE WHEN EecTermReason = '203' THEN '100'
                                WHEN (SELECT TOP 1 EdhChangeReason FROM EmpHDed a WHERE EdhEEID = xEEID AND EdhCOID = xCOID AND EdhDedCode = BdmDedCode ORDER BY EdhEffDate DESC) = '204' THEN '101'
                                WHEN (SELECT TOP 1 EdhChangeReason FROM EmpHDed a WHERE EdhEEID = xEEID AND EdhCOID = xCOID AND EdhDedCode = BdmDedCode ORDER BY EdhEffDate DESC) = '201' THEN '102'
                                WHEN (SELECT TOP 1 EdhChangeReason FROM EmpHDed a WHERE EdhEEID = xEEID AND EdhCOID = xCOID AND EdhDedCode = BdmDedCode ORDER BY EdhEffDate DESC) = '205' THEN '103'
                                WHEN EecTermReason <> '203' AND (SELECT TOP 1 TchType FROM dbo.TrmReasn WHERE TchCode = EecTermReason) = 'I' THEN '104'
                                WHEN EecTermReason = '202' THEN '106'
                                WHEN EecTermReason <> '202' AND (SELECT TOP 1 TchType FROM dbo.TrmReasn WHERE TchCode = EecTermReason) = 'V' THEN '108'
                            END
        --BdmCobraReason 
    INTO dbo.U_EFSACOBBIL_drvTbl_20
    FROM dbo.U_EFSACOBBIL_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EFSACOBBIL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRunId = 'Cobra'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConRelationship in ('SPS', 'DP')
    --JOIN dob.EmpHDed

    LEFT JOIN (
        Select KidEEID --ConEEID AS KidEEID
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameLast END) AS DepLastName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConNameFirst END) AS DepFirstName1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConSSN END) AS DepSsn1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConDateOfBirth END) AS DepDateOfBirth1
            ,MAX(CASE WHEN Dep_Number = 1 THEN ConRelationship END) AS DepRelationship1
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameLast END) AS DepLastName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConNameFirst END) AS DepFirstName2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConSSN END) AS DepSsn2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConDateOfBirth END) AS DepDateOfBirth2
            ,MAX(CASE WHEN Dep_Number = 2 THEN ConRelationship END) AS DepRelationship2
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameLast END) AS DepLastName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConNameFirst END) AS DepFirstName3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConSSN END) AS DepSsn3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConDateOfBirth END) AS DepDateOfBirth3
            ,MAX(CASE WHEN Dep_Number = 3 THEN ConRelationship END) AS DepRelationship3
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameLast END) AS DepLastName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConNameFirst END) AS DepFirstName4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConSSN END) AS DepSsn4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConDateOfBirth END) AS DepDateOfBirth4
            ,MAX(CASE WHEN Dep_Number = 4 THEN ConRelationship END) AS DepRelationship4
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameLast END) AS DepLastName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConNameFirst END) AS DepFirstName5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConSSN END) AS DepSsn5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConDateOfBirth END) AS DepDateOfBirth5
            ,MAX(CASE WHEN Dep_Number = 5 THEN ConRelationship END) AS DepRelationship5
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameLast END) AS DepLastName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConNameFirst END) AS DepFirstName6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConSSN END) AS DepSsn6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConDateOfBirth END) AS DepDateOfBirth6
            ,MAX(CASE WHEN Dep_Number = 6 THEN ConRelationship END) AS DepRelationship6
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameLast END) AS DepLastName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConNameFirst END) AS DepFirstName7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConSSN END) AS DepSsn7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConDateOfBirth END) AS DepDateOfBirth7
            ,MAX(CASE WHEN Dep_Number = 7 THEN ConRelationship END) AS DepRelationship7
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameLast END) AS DepLastName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConNameFirst END) AS DepFirstName8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConSSN END) AS DepSsn8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConDateOfBirth END) AS DepDateOfBirth8
            ,MAX(CASE WHEN Dep_Number = 8 THEN ConRelationship END) AS DepRelationship8
        FROM (
                SELECT ConEEID AS KidEEID, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship, ROW_NUMBER() OVER (PARTITION BY ConEEID ORDER BY ConSSN) AS Dep_Number
                FROM (
                        SELECT ConEEID, ConNameLast, ConNameFirst, ConSSN, ConDateOfBirth, ConRelationship,ROW_NUMBER() OVER (PARTITION BY ConSSN ORDER BY ConSSN) AS RN
                        FROM dbo.Contacts WITH (NOLOCK)
                        JOIN dbo.U_EFSACOBBIL_EEList
                            ON xEEID = ConEEID
                        JOIN dbo.U_dsi_BDM_EFSACOBBIL WITH (NOLOCK)
                            ON ConSystemID = BdmDepRecID
                        WHERE ConRelationship IN ('DAU', 'SON', 'DIS', 'STC') 
                    ) AS Source 
                WHERE RN = 1 ) AS T
        GROUP BY KidEEID) AS Kids 
    on KidEEID = xEEID
    WHERE BdmDedCode in ('MC4','MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU')
    ;

    ---------------------------------
    -- DETAIL RECORD - U_EFSACOBBIL_drvTbl_30
    ---------------------------------

    --********************************************************************
    -- Create copies in the BDM table for Den AND VIS based on the MED record
    --********************************************************************

    INSERT INTO dbo.U_dsi_BDM_EFSACOBBIL (BdmRecType,BdmCOID,BdmEEID,BdmDepRecID,BdmSystemID,BdmRunID,BdmDedRowStatus,BdmRelationship,BdmDateOfBirth,BdmDedCode,BdmDedType,BdmBenOption,BdmBenStatus,BdmBenStartDate,BdmBenStopDate,BdmBenStatusDate,BdmBenOptionDate,BdmChangeReason,BdmStartDate,BdmStopDate,BdmIsCobraCovered,BdmCobraReason,BdmDateOfCOBRAEvent,BdmIsPQB,BdmIsChildOldest,BdmUSGField1,BdmUSGField2,BdmUSGDate1,BdmUSGDate2,BdmTVStartDate,BdmSessionID,BdmEEAmt,BdmEECalcRateOrPct,BdmEEGoalAmt,BdmEEMemberOrCaseNo,BdmERAmt,BdmNumSpouses,BdmNumChildren,BdmNumDomPartners,BdmNumDPChildren) select BdmRecType,BdmCOID,BdmEEID,BdmDepRecID,BdmSystemID,BdmRunID,BdmDedRowStatus,BdmRelationship,BdmDateOfBirth,BdmDedCode,'VIS' AS BdmDedType,BdmBenOption,BdmBenStatus,BdmBenStartDate,BdmBenStopDate,BdmBenStatusDate,BdmBenOptionDate,BdmChangeReason,BdmStartDate,BdmStopDate,BdmIsCobraCovered,BdmCobraReason,BdmDateOfCOBRAEvent,BdmIsPQB,BdmIsChildOldest,BdmUSGField1,BdmUSGField2,BdmUSGDate1,BdmUSGDate2,BdmTVStartDate,BdmSessionID,BdmEEAmt,BdmEECalcRateOrPct,BdmEEGoalAmt,BdmEEMemberOrCaseNo,BdmERAmt,BdmNumSpouses,BdmNumChildren,BdmNumDomPartners,BdmNumDPChildren from dbo.U_dsi_BDM_EFSACOBBIL WITH (NOLOCK) where BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'VSP') AND BdmDedType = 'MED'

    INSERT INTO dbo.U_dsi_BDM_EFSACOBBIL (BdmRecType,BdmCOID,BdmEEID,BdmDepRecID,BdmSystemID,BdmRunID,BdmDedRowStatus,BdmRelationship,BdmDateOfBirth,BdmDedCode,BdmDedType,BdmBenOption,BdmBenStatus,BdmBenStartDate,BdmBenStopDate,BdmBenStatusDate,BdmBenOptionDate,BdmChangeReason,BdmStartDate,BdmStopDate,BdmIsCobraCovered,BdmCobraReason,BdmDateOfCOBRAEvent,BdmIsPQB,BdmIsChildOldest,BdmUSGField1,BdmUSGField2,BdmUSGDate1,BdmUSGDate2,BdmTVStartDate,BdmSessionID,BdmEEAmt,BdmEECalcRateOrPct,BdmEEGoalAmt,BdmEEMemberOrCaseNo,BdmERAmt,BdmNumSpouses,BdmNumChildren,BdmNumDomPartners,BdmNumDPChildren) select BdmRecType,BdmCOID,BdmEEID,BdmDepRecID,BdmSystemID,BdmRunID,BdmDedRowStatus,BdmRelationship,BdmDateOfBirth,BdmDedCode,'DEN' AS BdmDedType,BdmBenOption,BdmBenStatus,BdmBenStartDate,BdmBenStopDate,BdmBenStatusDate,BdmBenOptionDate,BdmChangeReason,BdmStartDate,BdmStopDate,BdmIsCobraCovered,BdmCobraReason,BdmDateOfCOBRAEvent,BdmIsPQB,BdmIsChildOldest,BdmUSGField1,BdmUSGField2,BdmUSGDate1,BdmUSGDate2,BdmTVStartDate,BdmSessionID,BdmEEAmt,BdmEECalcRateOrPct,BdmEEGoalAmt,BdmEEMemberOrCaseNo,BdmERAmt,BdmNumSpouses,BdmNumChildren,BdmNumDomPartners,BdmNumDPChildren from dbo.U_dsi_BDM_EFSACOBBIL where BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'VSP') AND BdmDedType = 'MED'

    IF OBJECT_ID('U_EFSACOBBIL_drvTbl_30','U') IS NOT NULL
        DROP TABLE dbo.U_EFSACOBBIL_drvTbl_30;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = 3
        ,drvSort2 = BdmDedCode -- EepSSN
        -- standard fields above and additional driver fields below - BdmDedType Dependant
        ,drvCBOffSet = REPLICATE(',', 100) 
        ,drvCarrierName =  CASE WHEN BdmDedType IN ('MED') THEN -- ABC
                                    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU') THEN 'Regence'
                                        WHEN BdmDedCode IN ('MG4', 'MGI', 'MGU') THEN 'Kaiser'
                                    END
                                WHEN BdmDedType IN ('DEN') THEN
                                    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'Delta Dental' END
                                WHEN BdmDedType IN ('VIS') THEN 
                                    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'VSP' END
                                WHEN BdmDedType IN ('LTD', 'ADD', 'GTL', 'OPC', 'OPS', 'ADD', 'STD', 'OPT') THEN 
                                    CASE WHEN BdmDedCode IN ('GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFES', 'LIFEE', 'SADD') THEN 'Cigna' END
                            END
        ,drvAccountNumber = ''
        ,drvGroupNumber = ''
        ,drvBenefitType =    CASE WHEN BdmDedType = 'MED' THEN 'Medical'
                                WHEN BdmDedType = 'DEN' THEN 'Dental'
                                WHEN BdmDedType = 'VIS' THEN 'Vision'
                                WHEN BdmDedCode = 'GADD' THEN 'AD&D'
                                WHEN BdmDedCode = 'GLIFE' THEN 'Basic Life'
                                WHEN BdmDedCode IN ('ELTD', 'LTD') THEN 'LTD'
                                WHEN BdmDedCode = 'STDB' THEN 'STD'
                                WHEN BdmDedCode = 'LIFEE' THEN 'Employee Life'
                                WHEN BdmDedCode = 'LIFEC' THEN 'Child Life'
                                WHEN BdmDedCode = 'LIFES' THEN 'Spouse Life'
                                WHEN BdmDedCode = 'SADD' THEN 'Voluntary AD&D'
                            END
        ,drvPlanName =    CASE WHEN BdmDedType IN ('MED') THEN
                            CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU') THEN 'Medical HSA'
                                WHEN BdmDedCode IN ('ME4', 'MEI', 'MEU') THEN 'Medical PPO'
                                WHEN BdmDedCode IN ('MG4', 'MGI', 'MGU') THEN 'KP HMO'
                            END
                            WHEN BdmDedType IN ('DEN') THEN
                                CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'Dental' END
                            WHEN BdmDedType IN ('VIS') THEN 
                                CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'Vision' END
                            ELSE    
                                CASE WHEN BdmDedCode = 'GADD' THEN 'AD&D'
                                    WHEN BdmDedCode = 'GLIFE' THEN 'Basic Life'
                                    WHEN BdmDedCode IN ('ELTD', 'LTD') THEN 'LTD'
                                    WHEN BdmDedCode = 'STDB' THEN 'STD'
                                    WHEN BdmDedCode = 'LIFEE' THEN 'Employee Life'
                                    WHEN BdmDedCode = 'LIFEC' THEN 'Child Life'
                                    WHEN BdmDedCode = 'LIFES' THEN 'Spouse Life'
                                    WHEN BdmDedCode = 'SADD' THEN 'Voluntary AD&D'
                                END 
                        END
        ,drvPlanStartDate = '1/1/' + CONVERT(VARCHAR(4), DATEPART(YEAR, GETDATE()))
        ,drvPlanEndDate = '12/31/' + CONVERT(VARCHAR(4), DATEPART(YEAR, GETDATE()))
        ,drvSsn = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvActiveOrInactive = CASE WHEN EecEmplStatus = 'T' THEN 'Inactive' ELSE 'Active' END
        ,drvRelationship =    CASE WHEN ConRelationship IN ('SPS', 'DP') AND BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'Spouse'
                                WHEN ConRelationship IN ('DAU', 'SON', 'DIS', 'STC') AND BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGU') THEN 'Child'
                            END
        ,drvBenefitType2 =    CASE WHEN BdmDedType = 'MED' THEN 'Medical'
                                WHEN BdmDedType = 'DEN' THEN 'Dental'
                                WHEN BdmDedType = 'VIS' THEN 'Vision'
                            END
        ,drvPlanName2 =    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU') AND BdmDedType = 'MED' THEN 'Medical HAS'
                            WHEN BdmDedCode IN ('ME4', 'MEI', 'MEU') AND BdmDedType = 'MED' THEN 'Medical PPO'
                            WHEN BdmDedCode IN ('MG4', 'MGI', 'MGU') AND BdmDedType = 'MED' THEN 'KP HMO'
                            WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') AND BdmDedType = 'DEN' THEN 'Dental'
                            WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') AND BdmDedType = 'VIS' THEN 'Vision'
                        END
        ,drvCarrierName2 =    CASE WHEN BdmDedType IN ('MED') THEN -- ABC
                                    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU') THEN 'Regence'
                                        WHEN BdmDedCode IN ('MG4', 'MGI', 'MGU') THEN 'Kaiser'
                                    END
                                WHEN BdmDedType IN ('DEN') THEN
                                    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'Delta Dental' END
                                WHEN BdmDedType IN ('VIS') THEN 
                                    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN 'VSP' END
                                WHEN BdmDedType IN ('LTD', 'ADD', 'GTL', 'OPC', 'OPS', 'ADD', 'STD', 'OPT') THEN 
                                    CASE WHEN BdmDedCode IN ('GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFES', 'LIFEE', 'SADD') THEN 'Cigna' END
                            END
        ,drvCoverageLevel =    CASE WHEN BdmBenOption IN ('E') THEN 'EMP' -- jcb
                                WHEN BdmBenOption IN ('EC', 'EK') THEN 'ECH'
                                WHEN BdmBenOption IN ('ES') THEN 'ESP'
                                WHEN BdmBenOption IN ('ESC', 'ESK') THEN 'FAM'
                            END                            
        ,drvBenefitAmt =    CASE WHEN BdmDedCode IN ('ELTD', 'LTD') THEN FORMAT(ROUND(EecAnnSalary/12*.6667, 2), '#0.00')
                                WHEN BdmDedCode IN ('STDB')    THEN FORMAT(ROUND(EecAnnSalary/52*.6667, 2), '#0.00')
                                WHEN BdmDedCode IN ('LIFEE') THEN FORMAT(PdhLIFEEAmt, '#0.00')
                                WHEN BdmDedCode IN ('LIFES') THEN FORMAT(PdhLIFESAmt, '#0.00')
                                WHEN BdmDedCode IN ('LIFEC') THEN FORMAT(PdhLIFECAmt, '#0.00')
                                WHEN BdmDedCode IN ('SADD')    THEN FORMAT(PdhSADDAmt, '#0.00')
                                /*THEN
                                    CASE WHEN ISNULL(BdmEEAmt, '') <> '' THEN FORMAT(BdmEEAmt, '#0.00') 
                                        ELSE FORMAT(PdhCalcBasisCurAmt, '#0.00') 
                                    END*/
                                WHEN BdmDedCode IN ('GADD', 'GLIFE') THEN FORMAT(CEILING((EecAnnSalary*2)/1000)*1000, '#0.00')
                            END
        ,drvEffStartDate = CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFEE', 'LIFES', 'SADD') THEN BdmBenStartDate END
        ,drvEffEndDate = CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFEE', 'LIFES', 'SADD') THEN BdmBenStopDate END
        
        ,drvEmployeeMonthPrem =    CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN FORMAT(EedEELstAmt, '#0.00') 
                                    WHEN BdmDedCode IN ('LIFEE') THEN
                                        CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatEERateNSMale*LIFEE_EE_AMT)/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatEERateSMMale*LIFEE_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatEERateNSFemale*LIFEE_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatEERateSMFemale*LIFEE_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                        END
                                    WHEN BdmDedCode IN ('LIFES') THEN -- This needs to use spouses age
                                        CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatEERateNSMale*LIFES_EE_AMT)/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatEERateSMMale*LIFES_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatEERateNSFemale*LIFES_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC) 
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatEERateSMFemale*LIFES_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                        END
                                    WHEN BdmDedCode IN ('GADD', 'GLIFE') THEN FORMAT(ROUND(EecAnnSalary*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode)/1000* (SELECT TOP 1 DedEECalcRateOrPct from DedCode where DedDedCode = BdmDedCode),2)*2, '#0.0000') 
                                    WHEN BdmDedCode IN ('LTD', 'ELTD') THEN FORMAT(ROUND(CASE WHEN ROUND(EecAnnSalary/12,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) > (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) THEN(SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) ELSE ROUND(EecAnnSalary/12,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) END /1000*(SELECT TOP 1 DedEECalcRateOrPct from DedCode where DedDedCode = BdmDedCode),2)*2, '#0.00')
                                    WHEN BdmDedCode IN ('STDB') THEN FORMAT(ROUND(CASE WHEN ROUND(EecAnnSalary/52,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) > (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) THEN (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) ELSE ROUND(EecAnnSalary/52,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) END /1000*(SELECT TOP 1 DedEECalcRateOrPct from DedCode where DedDedCode = BdmDedCode),2)*2, '#0.00')
                                    WHEN BdmDedCode IN ('SADD') THEN FORMAT(SADD_BEN_AMT/1000*(SELECT TOP 1 DedEECalcRateOrPct from DedCode where DedDedCode = BdmDedCode)*2, '#0.00')
                                    WHEN BdmDedCode IN ('LIFEC') THEN FORMAT(LIFEC_BEN_AMT/1000*(SELECT TOP 1 DedEECalcRateOrPct from DedCode where DedDedCode = BdmDedCode)*2, '#0.00')
                                END
        ,drvEmployerMonthPrem =  CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') THEN FORMAT(EedERLstAmt, '#0.00') 
                                    WHEN BdmDedCode IN ('LIFEE') THEN
                                        CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatERRateNSMale*LIFEE_EE_AMT)/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatERRateSMMale*LIFEE_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatERRateNSFemale*LIFEE_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatERRateSMFemale*LIFEE_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFEE' WHERE RatDedCode IN ('LIFEE') AND DateDiff(YEAR, EepDateOfBirth, DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                        END
                                    WHEN BdmDedCode IN ('LIFES') THEN -- This needs to use spouses age
                                        CASE WHEN EepGender = 'M' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatERRateNSMale*LIFES_EE_AMT)/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'M' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatERRateSMMale*LIFES_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'N' THEN (SELECT TOP 1 (((RatERRateNSFemale*LIFES_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC) 
                                            WHEN EepGender = 'F' AND EepIsSmoker = 'Y' THEN (SELECT TOP 1 (((RatERRateSMFemale*LIFES_EE_AMT )/1000)*2) FROM dbo.InsRate WITH (NOLOCK) JOIN dbo.DedCode WITH (NOLOCK) ON DedDedCode = 'LIFES' WHERE RatDedCode IN ('LIFES') AND DateDiff(YEAR, (SELECT TOP 1 ConDateOfBirth FROM dbo.Contacts WITH (NOLOCK) WHERE ConEEID = xEEID AND ConRelationship IN ('SPS', 'DP') AND ConDateOfBirth IS NOT NULL), DedAgeAsOfDate) BETWEEN RatMinAge AND RatMaxAge ORDER BY RatEffDate DESC)
                                        END
                                    WHEN BdmDedCode IN ('GADD', 'GLIFE') THEN FORMAT(ROUND(CASE WHEN ROUND(EecAnnSalary,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) > (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) THEN (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) ELSE ROUND(EecAnnSalary,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) END /1000*(SELECT TOP 1 DedERCalcRateOrPct from DedCode where DedDedCode = BdmDedCode),2)*2, '#0.00')
                                    WHEN BdmDedCode IN ('LTD', 'ELTD') THEN FORMAT(ROUND(CASE WHEN ROUND(EecAnnSalary/12,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) > (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) THEN (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) ELSE ROUND(EecAnnSalary/12,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) END /1000*(SELECT TOP 1 DedERCalcRateOrPct from DedCode where DedDedCode = BdmDedCode),2)*2, '#0.00')
                                    WHEN BdmDedCode IN ('STDB') THEN FORMAT(ROUND(CASE WHEN ROUND(EecAnnSalary/52,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) > (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) THEN (SELECT TOP 1 DedBenAmtMax from DedCode where DedDedCode = BdmDedCode) ELSE ROUND(EecAnnSalary/52,2)*(SELECT TOP 1 DedBenAmtRateOrPct from DedCode where DedDedCode = BdmDedCode) END /1000*(SELECT TOP 1 DedERCalcRateOrPct from DedCode where DedDedCode = BdmDedCode),2)*2, '#0.00')
                                    WHEN BdmDedCode IN ('SADD') THEN FORMAT(SADD_BEN_AMT/1000*(SELECT TOP 1 DedERCalcRateOrPct from DedCode where DedDedCode = BdmDedCode)*2, '#0.00')
                                    WHEN BdmDedCode IN ('LIFEC') THEN FORMAT(LIFEC_BEN_AMT/1000*(SELECT TOP 1 DedERCalcRateOrPct from DedCode where DedDedCode = BdmDedCode)*2, '#0.00')
                                END
        ,drvAccountNumber2 = ''
        ,drvGroupNumber2 = ''
        ,drvEmployeePerPayContrib = ''
        ,drvEmployerPerPayContrib = ''
        ,drvEmployeeNumber = REPLACE(EepUDField02, '-', '')
        ,drvEmpMI = LEFT(EepNameMiddle, 1)
        ,drvDateOfBirth = EepDateOfBirth
        ,drvEmployeeGender = EepGender
        ,drvMaritalStatus = eepMaritalStatus
        ,drvTabaccoStatus = EepIsSmoker
        ,drvSalary = EecAnnSalary
        ,drvPayFrequency = PgrPayFrequency 
        ,drvDepartment = ''
        ,drvLocation = '' --EecLocation
        ,drvClass = ''
        ,drvDivisionName = ''        
        ,drvEmployeeTermDate = CASE WHEN BdmDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'FSA4', 'FSAHC', 'FSAI', 'FSAL', 'FSANM', 'FSAO', 'FSAU') THEN BdmBenStopDate END
        --CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvLastModifiedDate = ''
        ,drvStudent = ''
        ,drvZipCode = ''
        ,drvEmployeeDateOfHire = EecDateOfLastHire
        ,drvCobraEnrollment = ''
        ,drvPlanTypeCode = ''
    INTO dbo.U_EFSACOBBIL_drvTbl_30
    FROM dbo.U_EFSACOBBIL_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EFSACOBBIL WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        AND BdmRecType = 'EMP'
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    JOIN dbo.U_EFSACOBBIL_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN (
                SELECT EedEEID AS MpEEID, EedCOID AS MpCOID, EedDedCode, EedEELstAmt, EedERLstAmt, EedBenAmt
                FROM dbo.EmpDed WITH (NOLOCK)
                WHERE EedDedCode IN ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU') 
                AND EedBenStatus = 'A'
                ) AS MED_PRIEM
        ON MpEEID = xEEID
        AND MpCOID = xCOID
    LEFT JOIN (
                SELECT DISTINCT EedEEID AS LpEEID, EedCOID AS LpCOID
                    ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN FORMAT(EedBenAmt, '#0.00') END) AS LIFEE_EE_AMT
                    ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN FORMAT(EedBenAmt, '#0.00') END) AS LIFES_EE_AMT
                FROM dbo.EmpDed WITH (NOLOCK)
                WHERE EedDedCode IN ('LIFEE', 'LIFES')
                GROUP BY EedEEID, EedCOID) AS LIFE_PRIEM
        ON LpEEID = xEEID 
        AND LpCOID = xCOID
    LEFT JOIN (
                SELECT EedEEID AS BeEEID, EedCOID AS BeCOID
    ,MAX(CASE WHEN EedDedCode = 'SADD' THEN EedBenAmt END) AS SADD_BEN_AMT
    ,MAX(CASE WHEN EedDedCode = 'LIFEC' THEN EedBenAmt END) AS LIFEC_BEN_AMT
FROM dbo.EmpDed WITH (NOLOCK)
WHERE EedDedCode IN ('SADD', 'LIFEC')
GROUP BY EedEEID, EedCOID
        ) AS BEN_AMT
        ON BeEEID = xEEID
        AND BeCOID = xCOID
    WHERE BdmDedCode in ('MC4', 'MCI', 'MCU', 'ME4', 'MEI', 'MEU', 'MG4', 'MGI', 'MGU', 'GADD', 'GLIFE', 'ELTD', 'LTD', 'STDB', 'LIFEC', 'LIFES', 'LIFEE', 'SADD') 
        AND BdmBenStatus = 'A'
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
ALTER VIEW dbo.dsi_vwEFSACOBBIL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFSACOBBIL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFSACOBBIL%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003011'
       ,expStartPerControl     = '202003011'
       ,expLastEndPerControl   = '202012319'
       ,expEndPerControl       = '202012319'
WHERE expFormatCode = 'EFSACOBBIL';

**********************************************************************************/
GO
CREATE   VIEW dbo.dsi_vwEFSACOBBIL_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFSACOBBIL_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2;