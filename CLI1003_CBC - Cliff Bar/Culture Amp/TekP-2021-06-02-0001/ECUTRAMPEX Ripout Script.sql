SET NOCOUNT ON;
IF OBJECT_ID('U_ECUTRAMPEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECUTRAMPEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECUTRAMPEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECUTRAMPEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECUTRAMPEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECUTRAMPEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUTRAMPEX];
GO
IF OBJECT_ID('U_ECUTRAMPEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_PEarHist];
GO
IF OBJECT_ID('U_ECUTRAMPEX_File') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_File];
GO
IF OBJECT_ID('U_ECUTRAMPEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_EEList];
GO
IF OBJECT_ID('U_ECUTRAMPEX_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_drvTbl];
GO
IF OBJECT_ID('U_ECUTRAMPEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_AuditFields];
GO
IF OBJECT_ID('U_ECUTRAMPEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECUTRAMPEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECUTRAMPEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECUTRAMPEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECUTRAMPEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECUTRAMPEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECUTRAMPEX','Culture Amp Demographic Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECUTRAMPEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECUTRAMPEX' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Name"','1','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','1',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Preferred Name"','2','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','2',NULL,'Preferred Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Id"','3','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','3',NULL,'Employee Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','4','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','4',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','5','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','5',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Start Date"','6','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','6',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"End Date"','7','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','7',NULL,'End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Language"','8','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','8',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Performance Rating"','9','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','9',NULL,'Performance Rating',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager"','10','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','10',NULL,'Manager',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Email"','11','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','11',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','12','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','13','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','13',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Business Unit"','14','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','13',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','15','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','15',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Type"','16','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','16',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','17','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','17',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ALT"','18','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','18',NULL,'Org Level 1 Manager',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Level"','19','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','19',NULL,'Org Level 3 Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Age"','20','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','20',NULL,'Age',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Time in Role"','21','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','21',NULL,'Time in Role',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Race/Ethnicity"','22','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','22',NULL,'Race/Ethnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State/Province"','23','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','23',NULL,'Org Level 2 Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FLSA Type"','24','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','24',NULL,'FLSA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company"','25','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','25',NULL,'Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','26','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','26',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','27','(''DA''=''T,'')','ECUTRAMPEXZ0','50','H','01','27',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number (Supervisor)"','28','(''DA''=''T'')','ECUTRAMPEXZ0','50','H','01','28',NULL,'Manager EEID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvName"','1','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','1',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrefferedName"','2','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','2',NULL,'Preferred Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','3',NULL,'Employee Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressEmail"','4','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','4',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','5','(''UD23''=''T,'')','ECUTRAMPEXZ0','50','D','10','5',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','6','(''UD23''=''T,'')','ECUTRAMPEXZ0','50','D','10','6',NULL,'Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDate"','7','(''UD23''=''T,'')','ECUTRAMPEXZ0','50','D','10','7',NULL,'End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''T,'')','ECUTRAMPEXZ0','50','D','10','8',NULL,'Language',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','9','(''DA''=''T,'')','ECUTRAMPEXZ0','50','D','10','9',NULL,'Performance Rating',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManager"','10','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','10',NULL,'Manager',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmail"','11','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','11',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','13','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','13',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBusinessUnit"','14','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','14',NULL,'Business Unit',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','15','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','15',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','16','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','16',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','17','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','17',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl1Manager"','18','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','18',NULL,'Org Level 1 Manager',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLvl3Description"','19','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','19',NULL,'Org Level 3 Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAge"','20','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','20',NULL,'Age',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTimeInRole"','21','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','21',NULL,'Time in Role',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRateEthnicity"','22','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','22',NULL,'Race/Ethnicity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrvLvl2Description"','23','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','23',NULL,'Org Level 2 Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSLAType"','24','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','24',NULL,'FLSA Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompany"','25','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','25',NULL,'Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','26','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','26',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','27','(''UA''=''T,'')','ECUTRAMPEXZ0','50','D','10','27',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEEID"','28','(''UA''=''T'')','ECUTRAMPEXZ0','50','D','10','28',NULL,'Manager EEID',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECUTRAMPEX_20210616.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Culture Amp Demographic Export','202010129','EMPEXPORT','ONDEM_XOE',NULL,'ECUTRAMPEX',NULL,NULL,NULL,'202010129','Oct 12 2020  1:04PM','Oct 12 2020  1:04PM','202009201',NULL,'','','202009201',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','IAGFG,Y5USD,XI0GS,HG0SP,VLYMR,368IV,B57L5',NULL,NULL,NULL,'Culture Amp Demographic -Sched','202104229','EMPEXPORT','SCH_ECUTRA','Apr 22 2021 12:46PM','ECUTRAMPEX',NULL,NULL,NULL,'202106169','Apr 22 2021 12:00AM','Dec 30 1899 12:00AM','202106151','124','','','202104011',dbo.fn_GetTimedKey(),NULL,'us3rVaCLI1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Culture Amp Demographic -Test','202105051','EMPEXPORT','TEST_XOE','May 17 2021 10:46AM','ECUTRAMPEX',NULL,NULL,NULL,'202105051','May  5 2021 12:00AM','Dec 30 1899 12:00AM','202104011','287','','','202104011',dbo.fn_GetTimedKey(),NULL,'us3rVaCLI1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECUTRAMPEX','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECUTRAMPEX' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECUTRAMPEX' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECUTRAMPEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECUTRAMPEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUTRAMPEX','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECUTRAMPEX','D10','dbo.U_ECUTRAMPEX_drvTbl',NULL);
IF OBJECT_ID('U_ECUTRAMPEX_Audit') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_Audit] (
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
IF OBJECT_ID('U_ECUTRAMPEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ECUTRAMPEX_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(9) NULL,
    [drvName] varchar(201) NULL,
    [drvPrefferedName] varchar(100) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvAddressEmail] varchar(50) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvStartDate] datetime NULL,
    [drvEndDate] datetime NULL,
    [drvManager] varchar(201) NULL,
    [drvManagerEmail] varchar(50) NULL,
    [drvGender] varchar(10) NOT NULL,
    [drvLocation] varchar(25) NULL,
    [drvBusinessUnit] varchar(25) NULL,
    [drvDepartment] varchar(45) NULL,
    [drvEmploymentType] varchar(9) NOT NULL,
    [drvJobTitle] varchar(152) NULL,
    [drvOrgLvl1Manager] varchar(201) NOT NULL,
    [drvOrgLvl3Description] varchar(25) NULL,
    [drvAge] int NULL,
    [drvTimeInRole] int NULL,
    [drvRateEthnicity] varchar(45) NULL,
    [drvOrvLvl2Description] varchar(255) NULL,
    [drvFSLAType] varchar(10) NOT NULL,
    [drvCompany] varchar(40) NULL,
    [drvEmploymentStatus] varchar(16) NOT NULL,
    [drvCountry] varchar(45) NULL,
    [drvManagerEEID] char(9) NULL
);
IF OBJECT_ID('U_ECUTRAMPEX_EEList') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECUTRAMPEX_File') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECUTRAMPEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ECUTRAMPEX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECUTRAMPEX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CBC

Created By: James Bender
Business Analyst: Richard Vars
Create Date: 10/12/2020
Service Request Number: TekP-2020-09-04-0001

Purpose: Culture Amp Demographic Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECUTRAMPEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECUTRAMPEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECUTRAMPEX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ECUTRAMPEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECUTRAMPEX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUTRAMPEX', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUTRAMPEX', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECUTRAMPEX', 'SCH_ECUTRA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECUTRAMPEX', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ECUTRAMPEX';

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
    -- Audit Code
    --==========================================
    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_ECUTRAMPEX_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_AuditFields;
    CREATE TABLE dbo.U_ECUTRAMPEX_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNamePreferred');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpPers','EepEthnicID');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecSupervisorId');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecOrgLvl1');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecOrgLvl2');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecOrgLvl3');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecJobCode');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Dependent Information
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('Contacts','ConAddressCountry');

    -- PlatformConfigFields
    --INSERT INTO dbo.U_ECUTRAMPEX_AuditFields VALUES ('SEmployment','_BCultureAmpDepartment'); -- took this out and added the table/field to the where clause because this was taking FOREVER to run.
    
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ECUTRAMPEX_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_Audit;
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
    INTO dbo.U_ECUTRAMPEX_Audit
    FROM dbo.U_ECUTRAMPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    --INNER JOIN dbo.vw_dsi_CfgAuditData WITH (NOLOCK) ON xEEID = CfgAudKey1Value
    JOIN dbo.U_ECUTRAMPEX_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
   ;


   INSERT INTO dbo.U_ECUTRAMPEX_Audit
   SELECT xEEID
    ,xCOID
    ,NULL
    ,xEEID 
    ,xCOID
    ,''
    ,CfgAudClass
    ,CfgAudFieldName
    ,CfgAudAction
    ,CfgAudDateTime
    ,CfgAudOldValue
    ,CfgAudNewValue
    ,CfgAudEffDate
    ,ROW_NUMBER() OVER (PARTITION BY xEEID, xCOID, CfgAudFieldName ORDER BY cfgAudDateTime DESC), 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N'
    FROM dbo.U_ECUTRAMPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_dsi_CfgAuditData XX WITH (NOLOCK) ON xEEID = CfgAudKey1Value
    WHERE CfgAudDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(CfgAudNewValue, '') <> ''
    --AND xEEID = 'A5M38E0010K0'
    AND CfgAudClass = 'SEmployment'
    AND CfgAudFieldName = '_BCultureAmpDepartment'

    --================
    -- Changes Only
    --================

    -- Remove Employees with No Changes in Audit
    DELETE FROM dbo.U_ECUTRAMPEX_EELIST
    WHERE NOT EXISTS (SELECT 1 FROM dbo.U_ECUTRAMPEX_Audit WHERE audEEID = xEEID AND audRowNo = 1);












    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ECUTRAMPEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECUTRAMPEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ECUTRAMPEX_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.vw_int_EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES')
    )

    -----------------------------
    -- Working Table - vw_int_PEarHist
    -----------------------------
    IF OBJECT_ID('U_ECUTRAMPEX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_PEarHist;
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
    INTO dbo.U_ECUTRAMPEX_PEarHist
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
    -- DETAIL RECORD - U_ECUTRAMPEX_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ECUTRAMPEX_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ECUTRAMPEX_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = EC.EecEmpNo -- E.EepDateOfBirth
        -- standard fields above and additional driver fields below
        ,drvName = E.EepNameFirst + ' ' + E.EepNameLast
        ,drvPrefferedName = CASE WHEN E.EepNamePreferred IS NOT NULL THEN E.EepNamePreferred ELSE E.EepNameFirst END
        ,drvEmployeeID = EC.EecEmpNo
        ,drvAddressEmail = E.EepAddressEMail
        ,drvDateOfBirth = E.EepDateOfBirth
        ,drvStartDate = EC.EecDateOfLastHire
        ,drvEndDate = EC.EecDateOfTermination
        ,drvManager = SUP.EepNameFirst + ' ' + SUP.EepNameLast
        ,drvManagerEmail = SUP.EepAddressEMail
        ,drvGender = CASE E.EepGender
                        WHEN 'M' THEN 'Male'
                        WHEN 'F' THEN 'Female'
                        ELSE 'Non-Binary'
                    END
        ,drvLocation = OrgDesc2 
        ,drvBusinessUnit = OrgDesc1
        ,drvDepartment = CodDesc -- CustomFields.Employment_CultureAmpDepartment -- OrgDesc1
        ,drvEmploymentType = CASE WHEN EC.EecFulltimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvJobTitle = '"' + EecJobTitle + '"'
        ,drvOrgLvl1Manager = OrgMangerName
        ,drvOrgLvl3Description = OrgDesc3
        ,drvAge = DATEDIFF(hour,E.EepDateOfBirth,GETDATE())/8766
        ,drvTimeInRole = EjhMonthsInJobCode
        ,drvRateEthnicity = EDesc -- E.EepEthnicID
        ,drvOrvLvl2Description = LocAddressState
        ,drvFSLAType = CASE WHEN EjhFLSACategory = 'E' THEN 'Exempt' ELSE 'Non-Exempt' END
        ,drvCompany =    CASE WHEN CmpCompanyCode = 'CBC' THEN 'Clif Bar & Company'
                            WHEN CmpCompanyCode = 'CBCCD' THEN 'Clif Bar & Company Canada'
                            WHEN CmpCompanyCode = 'CIN' THEN 'Clif Bar Baking Company of Indianapolis'
                            WHEN CmpCompanyCode = 'CTF' THEN 'Clif Bar Baking Company of Twin Falls LL'
                            WHEN CmpCompanyCode = 'CBENL' THEN 'Clif Bar Europe B.V. NL'
                            WHEN CmpCompanyCode = 'CBEUK' THEN 'Clif Bar Europe B.V. UK'
                            WHEN CmpCompanyCode = 'CBEDE' THEN 'Clif Bar Europe Germany'
                        END
        ,drvEmploymentStatus =    CASE EC.EecEmplStatus
                                    WHEN 'A' THEN 'Active'
                                    WHEN 'L' THEN 'Leave of Absence'
                                    ELSE 'Terminated'
                                END
        ,drvCountry = CNCdesc-- E.EepAddressCountry
        ,drvManagerEEID = (SELECT TOP 1 SUP.EecEmpNo FROM dbo.EmpComp SUP WITH (NOLOCK) WHERE SUP.EecEEID = EC.EecSupervisorId)
    INTO dbo.U_ECUTRAMPEX_drvTbl
    FROM dbo.U_ECUTRAMPEX_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp EC WITH (NOLOCK)
        ON EC.EecEEID = xEEID 
        AND EC.EecCoID = xCoID
    JOIN dbo.EmpPers E WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EC.EecJobCode
    JOIN dbo.EmpPers SUP WITH (NOLOCK)
        ON Sup.EepEEID = EC.EecSupervisorId
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EC.EecLocation
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.U_ECUTRAMPEX_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID
    JOIN (
            SELECT EjhEEID, EjhCOID, EjhJobCode, DATEDIFF(MONTH, MIN(EjhJobEffDate), GETDATE()) AS EjhMonthsInJobCode, MAX(EjhFLSACategory) AS EjhFLSACategory
            FROM dbo.vw_int_EmpHJob WITH (NOLOCK)
            GROUP BY EjhEEID, EjhCOID, EjhJobCode ) AS JobMonths
        ON EjhEEID = xEEID
        AND EjhCOID = xCOID
        AND EjhJobCode = EC.EecJobCode
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode1, OrgDesc AS OrgDesc1, OrgManagerId AS OrgManagerId1, ISNULL(EepNameFirst, '') + ' ' + ISNULL(EepNameLast, '') As OrgMangerName
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            LEFT JOIN dbo.EmpPers WITH (NOLOCK)
                ON OrgManagerId = EepEEID
            WHERE OrgLvl = 1
            ) AS Org1
        ON OrgCode1 = EC.EecOrgLvl1
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode3, OrgDesc AS OrgDesc3, OrgManagerId AS OrgManagerId3
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 3
            ) AS Org3
        ON OrgCode3 = EC.EecOrgLvl3
    JOIN (
            SELECT DISTINCT OrgCode AS OrgCode2, OrgDesc AS OrgDesc2, OrgManagerId AS OrgManagerId2
            FROM dbo.vw_int_OrgLevel WITH (NOLOCK)
            WHERE OrgLvl = 2
            ) AS Org2
        ON OrgCode2 = EC.EecOrgLvl2
    LEFT JOIN (
            SELECT CodCode AS ECode, CodDesc AS EDesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'ETHNICCODE'
            ) AS EStatus
        ON E.EepEthnicID = ECode
    JOIN (select * from [dbo].[fn_MP_CustomFields_EmpComp_Export] (null, null, null, null)) AS CustomFields
        ON EC.EecEEID = CustomFields.EecEEID
        AND EC.EecCOID = CustomFields.EecCOID
    LEFT JOIN dbo.Codes WITH (NOLOCK)
        ON CustomFields.Employment_CultureAmpDepartment = CodCode
        AND CodTable = 'CO_CULTUREAMPDEP'
    JOIN (
            SELECT CodCode AS CNCode, CodDesc AS CNCdesc
            FROM dbo.Codes WITH (NOLOCK)
            WHERE CodTable = 'COUNTRY'
            ) AS Countries
        ON E.EepAddressCountry = CnCode
    WHERE PehCurAmtYTD > 0
        AND CmpCompanyCode IN ('CBC','CBCCD','CIN','CTF','CBENL','CBEUK','CBEDE')
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
ALTER VIEW dbo.dsi_vwECUTRAMPEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ECUTRAMPEX_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ECUTRAMPEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202009051'
       ,expStartPerControl     = '202009051'
       ,expLastEndPerControl   = '202010129'
       ,expEndPerControl       = '202010129'
WHERE expFormatCode = 'ECUTRAMPEX';

**********************************************************************************/

-- ??
GO
CREATE VIEW dbo.dsi_vwECUTRAMPEX_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ECUTRAMPEX_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort