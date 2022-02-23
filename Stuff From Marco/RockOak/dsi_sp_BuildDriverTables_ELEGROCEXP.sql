SET NOCOUNT ON;
IF OBJECT_ID('U_ELEGROCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELEGROCEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELEGROCEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELEGROCEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELEGROCEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELEGROCEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELEGROCEXP];
GO
IF OBJECT_ID('U_ELEGROCEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_PEarHist];
GO
IF OBJECT_ID('U_ELEGROCEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_PDedHist];
GO
IF OBJECT_ID('U_ELEGROCEXP_File') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_File];
GO
IF OBJECT_ID('U_ELEGROCEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_EEList];
GO
IF OBJECT_ID('U_ELEGROCEXP_details') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_details];
GO
IF OBJECT_ID('U_ELEGROCEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_DedList];
GO
IF OBJECT_ID('U_ELEGROCEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_AuditFields];
GO
IF OBJECT_ID('U_ELEGROCEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELEGROCEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELEGROCEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELEGROCEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELEGROCEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELEGROCEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ELEGROCEXP','Legion General Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ELEGROCEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"companyid"','1','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','1',NULL,'companyid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"companyname"','2','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','2',NULL,'compnayname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"externalid"','3','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','3',NULL,'externalid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"firstname"','4','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','4',NULL,'firstname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"lastname"','5','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','5',NULL,'lastname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"middleinitial"','6','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','6',NULL,'middleinitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"costcenter"','7','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','7',NULL,'costcenter',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"locationname"','8','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','8',NULL,'locationname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"jobcode"','9','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','9',NULL,'jobcode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"jobtitle"','10','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','10',NULL,'jobtitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"status"','11','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','11',NULL,'status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"type"','12','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','12',NULL,'type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"phonenumber"','13','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','13',NULL,'phonenumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"email"','14','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','14',NULL,'email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"address1"','15','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','15',NULL,'address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"address2"','16','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','16',NULL,'address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"city"','17','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','17',NULL,'city',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"state"','18','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','18',NULL,'state',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"zip"','19','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','19',NULL,'zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"birthdate"','20','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','20',NULL,'birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hiredate"','21','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','21',NULL,'hiredate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"rehiredate"','22','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','22',NULL,'rehiredate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"terminationdate"','23','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','23',NULL,'terminationdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"terminationreason"','24','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','24',NULL,'terminationreason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"issalaried"','25','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','25',NULL,'issalaried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ishourly"','26','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','26',NULL,'ishourly',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"isexempt"','27','(''DA''=''T,'')','ELEGROCEXPZ0','50','H','01','27',NULL,'isexempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"hourlyrate"','28','(''DA''=''T'')','ELEGROCEXPZ0','50','H','01','28',NULL,'hourlyrate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcompanyid"','1','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','1',NULL,'companyid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcompnayname"','2','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','2',NULL,'compnayname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvexternalid"','3','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','3',NULL,'externalid',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvfirstname"','4','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','4',NULL,'firstname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvlastname"','5','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','5',NULL,'lastname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvmiddleinitial"','6','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','6',NULL,'middleinitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcostcenter"','7','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','7',NULL,'costcenter',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvlocationname"','8','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','8',NULL,'locationname',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvjobcode"','9','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','9',NULL,'jobcode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvjobtitle"','10','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','10',NULL,'jobtitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvstatus"','11','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','11',NULL,'status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvtype"','12','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','12',NULL,'type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvphonenumber"','13','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','13',NULL,'phonenumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvemail"','14','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','14',NULL,'email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvaddress1"','15','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','15',NULL,'address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvaddress2"','16','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','16',NULL,'address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcity"','17','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','17',NULL,'city',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvstate"','18','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','18',NULL,'state',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvzip"','19','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','19',NULL,'zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvbirthdate"','20','(''UD101=''T,'')','ELEGROCEXPZ0','50','D','10','20',NULL,'birthdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvhiredate"','21','(''UD101=''T,'')','ELEGROCEXPZ0','50','D','10','21',NULL,'hiredate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvrehiredate"','22','(''UD101=''T,'')','ELEGROCEXPZ0','50','D','10','22',NULL,'rehiredate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvterminationdate"','23','(''UD101=''T,'')','ELEGROCEXPZ0','50','D','10','23',NULL,'terminationdate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvterminationreason"','24','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','24',NULL,'terminationreason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvissalaried"','25','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','25',NULL,'issalaried',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvishourly"','26','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','26',NULL,'ishourly',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvisexempt"','27','(''UA''=''T,'')','ELEGROCEXPZ0','50','D','10','27',NULL,'isexempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvhourlyrate"','28','(''UA''=''T'')','ELEGROCEXPZ0','50','D','10','28',NULL,'hourlyrate',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGROCEXP_20200420.txt',NULL,'','',NULL,NULL,NULL,NULL,'Legion General Export','202004139','EMPEXPORT','ONDEMAND',NULL,'ELEGROCEXP',NULL,NULL,NULL,'202004139','Apr 13 2020  5:28PM','Apr 13 2020  5:28PM','202004131',NULL,'','','202004131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGROCEXP_20200420.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session Changes','202004139','EMPEXPORT','SCH_CHN','Apr 15 2020 12:00AM','ELEGROCEXP',NULL,NULL,NULL,'202004139','Apr 13 2020 12:00AM','Dec 30 1899 12:00AM','202004131',NULL,'','','202004131',dbo.fn_GetTimedKey(),NULL,'us3mLaROC1013',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGROCEXP_20200420.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled FullFile','202004139','EMPEXPORT','SCH_FFL','Apr 15 2020 12:00AM','ELEGROCEXP',NULL,NULL,NULL,'202004139','Apr 13 2020 12:00AM','Dec 30 1899 12:00AM','202004131',NULL,'','','202004131',dbo.fn_GetTimedKey(),NULL,'us3mLaROC1013',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGROCEXP_20200420.txt',NULL,'','','FPGHC',NULL,NULL,NULL,'Test Fullfile','202004161','EMPEXPORT','TEST_FFL','Apr 20 2020 11:55AM','ELEGROCEXP',NULL,NULL,NULL,'202004161','Apr 16 2020 12:00AM','Dec 30 1899 12:00AM','202001021','639','','','202001021',dbo.fn_GetTimedKey(),NULL,'us3mLaROC1013',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELEGROCEXP_20200420.txt',NULL,'','','FPGHC,XAWFY',NULL,NULL,NULL,'Test Changes Only','202004209','EMPEXPORT','TEST_CHN','Apr 20 2020 11:51AM','ELEGROCEXP',NULL,NULL,NULL,'202004209','Apr 20 2020 12:00AM','Dec 30 1899 12:00AM','202004031','40','','','202004031',dbo.fn_GetTimedKey(),NULL,'us3mLaROC1013',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELEGROCEXP_20200420.txt' END WHERE expFormatCode = 'ELEGROCEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGROCEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGROCEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGROCEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGROCEXP','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGROCEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELEGROCEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELEGROCEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELEGROCEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELEGROCEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELEGROCEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELEGROCEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELEGROCEXP','D10','dbo.U_ELEGROCEXP_details',NULL);
IF OBJECT_ID('U_ELEGROCEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_Audit] (
    [audEEID] char(12) NULL,
    [audCOID] char(5) NULL,
    [audConSystemID] varchar(255) NULL,
    [audKey1] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audEffectiveDate] smalldatetime NULL,
    [audRowNo] bigint NULL,
    [audDedChange] varchar(1) NOT NULL,
    [audBenOptionChange] varchar(1) NOT NULL,
    [audSSNChange] varchar(1) NOT NULL,
    [audNameChange] varchar(1) NOT NULL,
    [audDemoChange] varchar(1) NOT NULL,
    [audAddrChange] varchar(1) NOT NULL,
    [audNewlyEnroll] varchar(1) NOT NULL,
    [audReEnroll] varchar(1) NOT NULL,
    [audTermPlan] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELEGROCEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ELEGROCEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ELEGROCEXP_details') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_details] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(1) NOT NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvcompanyid] varchar(5) NULL,
    [drvcompnayname] varchar(25) NULL,
    [drvexternalid] char(9) NULL,
    [drvfirstname] varchar(100) NULL,
    [drvlastname] varchar(100) NULL,
    [drvmiddleinitial] varchar(1) NULL,
    [drvcostcenter] varchar(15) NULL,
    [drvlocationname] varchar(25) NULL,
    [drvjobcode] char(8) NULL,
    [drvjobtitle] nvarchar(258) NULL,
    [drvstatus] varchar(16) NULL,
    [drvtype] varchar(9) NULL,
    [drvphonenumber] varchar(50) NULL,
    [drvemail] varchar(50) NULL,
    [drvaddress1] nvarchar(258) NULL,
    [drvaddress2] nvarchar(258) NULL,
    [drvcity] nvarchar(258) NULL,
    [drvstate] varchar(255) NULL,
    [drvzip] varchar(50) NULL,
    [drvbirthdate] datetime NULL,
    [drvhiredate] datetime NULL,
    [drvrehiredate] datetime NULL,
    [drvterminationdate] datetime NULL,
    [drvterminationreason] varchar(11) NULL,
    [drvissalaried] varchar(3) NULL,
    [drvishourly] varchar(3) NULL,
    [drvisexempt] varchar(3) NULL,
    [drvhourlyrate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ELEGROCEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELEGROCEXP_File') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ELEGROCEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_PDedHist] (
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
IF OBJECT_ID('U_ELEGROCEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ELEGROCEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELEGROCEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Rock Oak Services Group LLC

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 04/13/2020
Service Request Number: TekP-2020-02-26-0004

Purpose: Legion General Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ELEGROCEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ELEGROCEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ELEGROCEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ELEGROCEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ELEGROCEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELEGROCEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ELEGROCEXP', 'TEST_CHN';


EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ELEGROCEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ELEGROCEXP';

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
    DELETE FROM dbo.U_ELEGROCEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ELEGROCEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ELEGROCEXP_EEList
    WHERE  xEEID NOT IN (SELECT eeceeid FROM dbo.EmpComp Where eecJobCode in ('FRON780','RADI700','NURS175','MEDI105','PRAC200','LPN0355','OPER265','PHYS328','PHYS315','MEDI145','DIRE180','CLNC225','MAIN700','MEDI170','DIAG787'));

    Delete FROM dbo.U_ELEGROCEXP_EEList
    WHERE  xEEID  IN (SELECT eeceeid FROM dbo.EmpComp Where eecJobCode in ('DIRE355'));

    DELETE FROM dbo.U_ELEGROCEXP_EEList
    WHERE  xEEID  IN (SELECT eeceeid FROM dbo.EmpComp Where eecorglvl1 in ('ZMT455'));


    DELETE FROM dbo.U_ELEGROCEXP_EEList
    WHERE  xEEID IN (SELECT eeceeid FROM dbo.EmpComp Where eecemplstatus in ('R'));

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ELEGROCEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGROCEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ELEGROCEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ELEGROCEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGROCEXP_PDedHist;
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
    INTO dbo.U_ELEGROCEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ELEGROCEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ELEGROCEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGROCEXP_PEarHist;
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
    INTO dbo.U_ELEGROCEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;



     --==========================================
    -- Audit Code
    --==========================================

    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ELEGROCEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGROCEXP_AuditFields;
    CREATE TABLE dbo.U_ELEGROCEXP_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_ELEGROCEXP_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ELEGROCEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGROCEXP_Audit;
    SELECT audEEID = xEEID
        ,audCOID = xCOID
        ,audConSystemID =  CASE WHEN audTableName = 'Contacts' THEN audKey3Value
                                WHEN audTableName = 'DepBPlan' THEN DbnDepRecID
                           END
        ,audKey1 = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audEffectiveDate
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audDedChange = CASE WHEN audTableName IN ('EmpDed','DepBPlan','DedCode') THEN 'Y'
                             ELSE 'N'
                        END
        ,audBenOptionChange = CASE WHEN audFieldName IN ('EedBenOption') THEN 'Y'
                                   ELSE 'N'
                              END
        ,audSSNChange = CASE WHEN audFieldName IN ('EepSSN','ConSSN') THEN 'Y'
                              ELSE 'N'
                        END
        ,audNameChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Name%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers') AND audFieldName LIKE '%Prefix%' THEN 'Y'
                              WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Suffix%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audDemoChange = CASE WHEN audFieldName IN ('EepGender','EepDateOfBirth','EepMaritalStatus','ConGender','ConDateOfBirth','ConRelationship') THEN 'Y'
                              ELSE 'N'
                         END
        ,audAddrChange = CASE WHEN audTableName IN ('EmpPers','Contacts') AND audFieldName LIKE '%Address%' THEN 'Y'
                              ELSE 'N'
                         END
        ,audNewlyEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') = '' AND audNewValue = 'A' THEN 'Y'
                               ELSE 'N'
                          END
        ,audReEnroll = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND ISNULL(audOldValue,'') NOT IN ('A','') AND audNewValue = 'A' THEN 'Y'
                            WHEN audFieldName IN ('EedBenStartDate','DbnBenStartDate') AND ISNULL(audOldValue,'') <> '' AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
        ,audTermPlan = CASE WHEN audFieldName IN ('EedBenStatus','DbnBenStatus') AND audOldValue = 'A' AND ISNULL(audNewValue,'') NOT IN ('A','') THEN 'Y'
                            WHEN audFieldName IN ('EedBenStopDate','DbnBenStopDate') AND ISNULL(audNewValue,'') <> '' THEN 'Y'
                            ELSE 'N'
                       END
    INTO dbo.U_ELEGROCEXP_Audit
    FROM dbo.U_ELEGROCEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_ELEGROCEXP_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_ELEGROCEXP_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_ELEGROCEXP_DedList))
    );

    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','SCH_FFL','TEST_FFL'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_ELEGROCEXP_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ELEGROCEXP_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ELEGROCEXP_details 
    ---------------------------------
    IF OBJECT_ID('U_ELEGROCEXP_details ','U') IS NOT NULL
        DROP TABLE dbo.U_ELEGROCEXP_details ;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = ''
        ,drvSubsort = ''
        -- standard fields above and additional driver fields below
        ,drvcompanyid = CASE WHEN XCOID in ('FPGHC') THEN 'ROG11' 
                             WHEN XCOID in ('XAWFY') THEN 'CVA01'
        
                        END
                
        ,drvcompnayname = OrgDesc
        ,drvexternalid = EecEmpNo
        ,drvfirstname = EepNameFirst
        ,drvlastname = EepNameLast
        ,drvmiddleinitial = LEFT(EepNameMiddle,1)
        ,drvcostcenter = LocGLACctNo
        ,drvlocationname = LocDesc
        ,drvjobcode = EecJobCode
        ,drvjobtitle = QuoteName(JbcDesc,'"')

        ,drvstatus = CASE WHEN EecEmplStatus = 'A' THEN 'Active'
                          WHEN EecEmplStatus = 'T' THEN 'Terminated'
                          WHEN EecEmplStatus = 'L' THEN 'Leave of absence'
                     END 
        ,drvtype = CASE WHEN EecFullTimeOrPartTime = 'F' Then  'Full Time'
                        WHEN EecFullTimeOrPartTime = 'P' THEN 'Part Time'
                    END
        ,drvphonenumber = EepPhoneHomeNumber
        ,drvemail = EepAddressEMail
        ,drvaddress1 = Quotename(EepAddressLine1,'"')
        ,drvaddress2 = Quotename(EepAddressLine2,'"')
        ,drvcity = Quotename(EepAddressCity,'"')
        ,drvstate = EepAddressState
        ,drvzip = EepAddressZipCode
        ,drvbirthdate = EepDateOfBirth
        ,drvhiredate = EecDateOfOriginalHire
        ,drvrehiredate = EecDateOfLastHire
        ,drvterminationdate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvterminationreason = CASE WHEN EecTermReason in ('CARADV', 'COMP', '131', '103', '130', '104', '133', '132', '101', '100', '102', 'RETIRE', '202', 'WORCON') THEN 'Voluntary'
                                     WHEN EecTermReason in ('230', '231', 'ATTEND', '203', '200', '206', '232', '205', '233', '234', '235', '201', '207') THEN 'Involuntary'
                                 END
        ,drvissalaried = CASE WHEN EecSalaryOrHourly = 'S' THEN 'Yes' END
        ,drvishourly = CASE WHEN EecSalaryOrHourly = 'H' THEN 'Yes' END
        ,drvisexempt = CASE WHEN jbcFLSAType = 'E' THEN 'Yes' END
        ,drvhourlyrate = ''
    INTO dbo.U_ELEGROCEXP_details 
    FROM dbo.U_ELEGROCEXP_EEList WITH (NOLOCK)
        JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.OrgLevel WITH (NOLOCK)
        ON OrgCode = EecOrgLvl1
        And OrgLvl = 1
    JOIN dbo.JobCode WITH (NOLOCK)
        on JbcJobCode =  eecJobCode
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
ALTER VIEW dbo.dsi_vwELEGROCEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ELEGROCEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ELEGROCEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202004061'
       ,expStartPerControl     = '202004061'
       ,expLastEndPerControl   = '202004139'
       ,expEndPerControl       = '202004139'
WHERE expFormatCode = 'ELEGROCEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwELEGROCEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ELEGROCEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort