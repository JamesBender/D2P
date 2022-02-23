SET NOCOUNT ON;
IF OBJECT_ID('U_ERELFMLAMD_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ERELFMLAMD_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ERELFMLAMD' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwERELFMLAMD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERELFMLAMD_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERELFMLAMD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELFMLAMD];
GO
IF OBJECT_ID('U_ERELFMLAMD_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_PEarHist];
GO
IF OBJECT_ID('U_ERELFMLAMD_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_PDedHist];
GO
IF OBJECT_ID('U_ERELFMLAMD_File') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_File];
GO
IF OBJECT_ID('U_ERELFMLAMD_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_EEList];
GO
IF OBJECT_ID('U_ERELFMLAMD_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_drvTbl];
GO
IF OBJECT_ID('U_ERELFMLAMD_DedList') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_DedList];
GO
IF OBJECT_ID('U_ERELFMLAMD_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_AuditFields];
GO
IF OBJECT_ID('U_ERELFMLAMD_Audit') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ERELFMLAMD') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ERELFMLAMD];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ERELFMLAMD';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ERELFMLAMD';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ERELFMLAMD';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ERELFMLAMD';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ERELFMLAMD';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ERELFMLAMD','Reliance FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','ERELFMLAMDZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','1','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','1',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Most Recent"','2','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','2',NULL,'Date of Hire Most Recent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Original"','3','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','3',NULL,'Date of Hire Original',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Adjusted"','4','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','4',NULL,'Date of Hire Adjusted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','5','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','5',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','6','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','6',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','7','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','8','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','8',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','9','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','9',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 1"','10','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','10',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 2"','11','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','11',NULL,'Home Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 3"','12','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','12',NULL,'Home Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home City"','13','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','13',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home State"','14','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','14',NULL,'Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Zip"','15','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','15',NULL,'Home Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Country"','16','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','16',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','17','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','17',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Email Address"','18','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','18',NULL,'Home Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','19','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','19',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','20','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','20',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State"','21','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','21',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','22','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','22',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email Address"','23','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','23',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Number"','24','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','24',NULL,'Department Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Location Name"','25','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','25',NULL,'Department Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code"','26','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','26',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Name"','27','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','27',NULL,'Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Position"','28','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','28',NULL,'Position',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Shift Worked"','29','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','29',NULL,'Shift Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Active"','30','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','30',NULL,'Is Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','31','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','31',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Fulltime "','32','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','32',NULL,'Is Fulltime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Exempt"','33','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','33',NULL,'Is Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','34','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','34',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Rate"','35','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','35',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FICA Year To Date"','36','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','36',NULL,'FICA Year To Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Name"','37','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','37',NULL,'HR Rep Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Email Address"','38','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','38',NULL,'HR Rep Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Phone"','39','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','39',NULL,'HR Rep Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Name"','40','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','40',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor  Email Address"','41','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','41',NULL,'Supervisor  Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Phone"','42','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','42',NULL,'Supervisor Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Name"','43','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','43',NULL,'HR Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Email"','44','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','44',NULL,'HR Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Phone"','45','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','45',NULL,'HR Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Name - level 2 supervisor"','46','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','46',NULL,'Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Email"','47','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','47',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Phone"','48','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','48',NULL,'Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group A - Work State"','49','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','49',NULL,'Sub Group A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group B - Location Description"','50','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','50',NULL,'Sub Group B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group C - Job Code"','51','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','51',NULL,'Sub Group C',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group D - Exempt and Non-Exempt"','52','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','52',NULL,'Sub Group D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group E - Benefit Control Group"','53','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','53',NULL,'Sub Group E',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group F - Company Code"','54','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','54',NULL,'Sub Group F',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is STD Eligible"','55','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','55',NULL,'Is STD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Std Plan Effective"','56','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','56',NULL,'Std Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is STD Supplemental Eligible"','57','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','57',NULL,'Is STD Supplemental Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Std Supp Effective"','58','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','58',NULL,'Std Supp Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is California Voluntary Plan Eligible"','59','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','59',NULL,'Is California Voluntary Plan Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"California Voluntary Plan Effective"','60','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','60',NULL,'California Voluntary Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is LTD Eligible"','61','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','61',NULL,'Is LTD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Effective Date"','62','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','62',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Other Eligible"','63','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','63',NULL,'Is Other Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Other Eligible Effective Date"','64','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','64',NULL,'Is Other Eligible Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked"','65','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','65',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"At Worksite"','66','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','66',NULL,'At Worksite',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Domestic Partner Indicator for Affidavits on-file"','67','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','67',NULL,'Domestic Partner Indicator for Affidavits on-file',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Working at the Same Company"','68','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','68',NULL,'Spouse Working at the Same Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee Indicator"','69','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','69',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employees 50 in 75 Mile Indicator"','70','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','70',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 01"','71','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','71',NULL,'Add Data 01',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 02"','72','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','72',NULL,'Add Data 02',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 03"','73','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','73',NULL,'Add Data 03',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 04"','74','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','74',NULL,'Add Data 04',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 05"','75','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','75',NULL,'Add Data 05',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 06"','76','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','76',NULL,'Add Data 06',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 07"','77','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','77',NULL,'Add Data 07',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 08"','78','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','78',NULL,'Add Data 08',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 09"','79','(''DA''=''T|'')','ERELFMLAMDZ0','50','H','01','79',NULL,'Add Data 09',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 10"','80','(''DA''=''T'')','ERELFMLAMDZ0','50','H','01','80',NULL,'Add Data 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','1','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','1',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHireMostRecent"','2','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','2',NULL,'Date of Hire Most Recent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHireOriginal"','3','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','3',NULL,'Date of Hire Original',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHireAdjusted"','4','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','4',NULL,'Date of Hire Adjusted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN "','5','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','5',NULL,'SSN ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','6','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','6',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','7','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','8','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','8',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','9','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','9',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddress1"','10','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','10',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddress2"','11','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','11',NULL,'Home Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddress3"','12','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','12',NULL,'Home Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCity "','13','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','13',NULL,'Home City ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeState"','14','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','14',NULL,'Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeZip             "','15','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','15',NULL,'Home Zip             ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCountry"','16','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','16',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','17','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','17',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeEmailAddress"','18','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','18',NULL,'Home Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','19','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','19',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','20','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','20',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','21','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','21',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','22','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','22',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','23','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','23',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentNumber"','24','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','24',NULL,'Department Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentLocationName"','25','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','25',NULL,'Department Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationCode"','26','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','26',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocationName"','27','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','27',NULL,'Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPosition"','28','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','28',NULL,'Position',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShiftWorked"','29','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','29',NULL,'Shift Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsActive"','30','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','30',NULL,'Is Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','31','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','31',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsFulltime"','32','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','32',NULL,'Is Fulltime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsExempt"','33','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','33',NULL,'Is Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','34','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','34',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyRate"','35','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','35',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFICAYearToDate"','36','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','36',NULL,'FICA Year To Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepName"','37','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','37',NULL,'HR Rep Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepEmailAddress"','38','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','38',NULL,'HR Rep Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepPhone"','39','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','39',NULL,'HR Rep Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorName"','40','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','40',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmailAddress"','41','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','41',NULL,'Supervisor  Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorPhone"','42','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','42',NULL,'Supervisor Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRManagerName"','43','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','43',NULL,'HR Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRManagerEmail"','44','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','44',NULL,'HR Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRManagerPhone"','45','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','45',NULL,'HR Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerName"','46','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','46',NULL,'Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmail"','47','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','47',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerPhone"','48','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','48',NULL,'Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupA"','49','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','49',NULL,'Sub Group A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupB"','50','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','50',NULL,'Sub Group B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupC"','51','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','51',NULL,'Sub Group C',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupD"','52','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','52',NULL,'Sub Group D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupE"','53','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','53',NULL,'Sub Group E',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupF"','54','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','54',NULL,'Sub Group F',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSTDEligible"','55','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','55',NULL,'Is STD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStdPlanEffective"','56','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','56',NULL,'Std Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSTDSupplementalEligible"','57','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','57',NULL,'Is STD Supplemental Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStdSuppEffective"','58','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','58',NULL,'Std Supp Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsCaliVoluntaryPlanElig"','59','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','59',NULL,'Is California Voluntary Plan Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaliVoluPlanEffective"','60','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','60',NULL,'California Voluntary Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsLTDEligible"','61','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','61',NULL,'Is LTD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffectiveDate"','62','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','62',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsOtherEligible"','63','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','63',NULL,'Is Other Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsOtherEligibleEffDate"','64','(''UD101''=''T|'')','ERELFMLAMDZ0','50','D','10','64',NULL,'Is Other Eligible Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','65','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','65',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAtWorksite"','66','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','66',NULL,'At Worksite',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDomesticPartnerIndicator"','67','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','67',NULL,'Domestic Partner Indicator for Affidavits on-file',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseWorkingSameCo"','68','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','68',NULL,'Spouse Working at the Same Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployeeInd"','69','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','69',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployees50in75MileInd"','70','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','70',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData01"','71','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','71',NULL,'Add Data 01',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData02"','72','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','72',NULL,'Add Data 02',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData03"','73','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','73',NULL,'Add Data 03',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData04"','74','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','74',NULL,'Add Data 04',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData05"','75','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','75',NULL,'Add Data 05',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData06"','76','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','76',NULL,'Add Data 06',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData07"','77','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','77',NULL,'Add Data 07',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData08"','78','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','78',NULL,'Add Data 08',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData09"','79','(''UA''=''T|'')','ERELFMLAMDZ0','50','D','10','79',NULL,'Add Data 09',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData10"','80','(''UA''=''T|)','ERELFMLAMDZ0','50','D','10','80',NULL,'Add Data 10',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELFMLAMD_20200811.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reliance FMLA Export','202005189','EMPEXPORT','ONDEMAND',NULL,'ERELFMLAMD',NULL,NULL,NULL,'202005189','May 18 2020  5:47PM','May 18 2020  5:47PM','202005181',NULL,'','','202005181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELFMLAMD_20200811.txt',NULL,'Null','N',',RI7PU,RI7FO,RI7CI,RI7X0,RI7SP,RI7VN,RI7MV,RI7OF,RI7IY,RI4W0,RI4MV,RI65Y,RI53A,RI5J8,RI62O,RI51B,RI460,RI67F,RI55V,RI4Z5,RI7KD,RI7Z0,RI77C,RI75Y',NULL,NULL,NULL,'Scheduled Session','202006189','EMPEXPORT','SCH_RELFML',NULL,'ERELFMLAMD',NULL,NULL,NULL,'202008059','May 18 2020  5:47PM','May 18 2020  5:47PM','202007291',NULL,'','','202006181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELFMLAMD_20200811.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202005189','EMPEXPORT','OEACTIVE',NULL,'ERELFMLAMD',NULL,NULL,NULL,'202005189','May 18 2020  5:47PM','May 18 2020  5:47PM','202005181',NULL,'','','202005181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELFMLAMD_20200811.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202005189','EMPEXPORT','OEPASSIVE',NULL,'ERELFMLAMD',NULL,NULL,NULL,'202005189','May 18 2020  5:47PM','May 18 2020  5:47PM','202005181',NULL,'','','202005181',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELFMLAMD_20200811.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202008111','EMPEXPORT','TEST','Aug 11 2020 11:24AM','ERELFMLAMD',NULL,NULL,NULL,'202008111','Aug 11 2020 12:00AM','Dec 30 1899 12:00AM','202008041','2462','','','202008041',dbo.fn_GetTimedKey(),NULL,'us3cPeMID1018',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ERELFMLAMD_20200811.txt' END WHERE expFormatCode = 'ERELFMLAMD';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELFMLAMD','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELFMLAMD','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELFMLAMD','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELFMLAMD','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELFMLAMD','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELFMLAMD','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ERELFMLAMD' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ERELFMLAMD' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ERELFMLAMD_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELFMLAMD_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELFMLAMD','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELFMLAMD','D10','dbo.U_ERELFMLAMD_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ERELFMLAMD') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ERELFMLAMD] (
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
IF OBJECT_ID('U_ERELFMLAMD_Audit') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_Audit] (
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
IF OBJECT_ID('U_ERELFMLAMD_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ERELFMLAMD_DedList') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ERELFMLAMD_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateofHireMostRecent] datetime NULL,
    [drvDateofHireOriginal] datetime NULL,
    [drvDateofHireAdjusted] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvHomeAddress1] varchar(255) NULL,
    [drvHomeAddress2] varchar(255) NULL,
    [drvHomeAddress3] varchar(1) NOT NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvHomeState] varchar(255) NULL,
    [drvHomeZip] varchar(50) NULL,
    [drvHomeCountry] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvHomeEmailAddress] varchar(50) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] varchar(1) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvDepartmentNumber] char(6) NULL,
    [drvDepartmentLocationName] varchar(25) NULL,
    [drvLocationCode] char(6) NULL,
    [drvLocationName] varchar(25) NULL,
    [drvPosition] varchar(6000) NULL,
    [drvShiftWorked] varchar(1) NOT NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvTerminationDate] datetime NULL,
    [drvIsFulltime] varchar(1) NOT NULL,
    [drvExemptFlag] char(1) NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvAnnualSalaryRaw] money NULL,
    [drvAnnualSalary] varchar(12) NULL,
    [drvHourlyRate] varchar(12) NULL,
    [drvFICAYearToDate] varchar(1) NOT NULL,
    [drvHRRepName] varchar(1) NOT NULL,
    [drvHRRepEmailAddress] varchar(1) NOT NULL,
    [drvHRRepPhone] varchar(1) NOT NULL,
    [drvSupervisorName] varchar(256) NULL,
    [drvSupervisorEmailAddress] varchar(256) NULL,
    [drvSupervisorPhone] varchar(256) NULL,
    [drvHRManagerName] varchar(1) NOT NULL,
    [drvHRManagerEmail] varchar(1) NOT NULL,
    [drvHRManagerPhone] varchar(1) NOT NULL,
    [drvManagerName] varchar(256) NULL,
    [drvManagerEmail] varchar(256) NULL,
    [drvManagerPhone] varchar(256) NULL,
    [drvSubGroupA] varchar(255) NULL,
    [drvSubGroupB] varchar(20) NULL,
    [drvSubGroupC] char(8) NULL,
    [drvSubGroupD] varchar(10) NOT NULL,
    [drvSubGroupE] char(5) NULL,
    [drvSubGroupF] char(5) NULL,
    [drvIsSTDEligible] varchar(1) NOT NULL,
    [drvStdPlanEffective] datetime NULL,
    [drvIsSTDSupplementalEligible] varchar(1) NOT NULL,
    [drvStdSuppEffective] varchar(1) NOT NULL,
    [drvIsCaliVoluntaryPlanElig] varchar(1) NOT NULL,
    [drvCaliVoluPlanEffective] varchar(1) NOT NULL,
    [drvIsLTDEligible] varchar(1) NOT NULL,
    [drvLTDEffectiveDate] datetime NULL,
    [drvIsOtherEligible] varchar(1) NOT NULL,
    [drvIsOtherEligibleEffDate] varchar(1) NOT NULL,
    [drvHoursWorked] varchar(50) NULL,
    [drvHoursWorkedBefore] varchar(50) NULL,
    [drvAtWorksite] varchar(1) NOT NULL,
    [drvDomesticPartnerIndicator] varchar(1) NOT NULL,
    [drvSpouseWorkingSameCo] varchar(1) NOT NULL,
    [drvKeyEmployeeInd] varchar(1) NOT NULL,
    [drvEmployees50in75MileInd] varchar(1) NOT NULL,
    [drvAddData01] varchar(1) NOT NULL,
    [drvAddData02] varchar(1) NOT NULL,
    [drvAddData03] varchar(1) NOT NULL,
    [drvAddData04] varchar(1) NOT NULL,
    [drvAddData05] varchar(1) NOT NULL,
    [drvAddData06] varchar(1) NOT NULL,
    [drvAddData07] varchar(1) NOT NULL,
    [drvAddData08] varchar(1) NOT NULL,
    [drvAddData09] varchar(1) NOT NULL,
    [drvAddData10] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ERELFMLAMD_EEList') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ERELFMLAMD_File') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ERELFMLAMD_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_PDedHist] (
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
IF OBJECT_ID('U_ERELFMLAMD_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ERELFMLAMD_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELFMLAMD]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MidWest Dental Inc

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 05/18/2020
Service Request Number: TekP-2020-03-10-0005

Purpose: Reliance FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERELFMLAMD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERELFMLAMD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERELFMLAMD';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERELFMLAMD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERELFMLAMD' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELFMLAMD', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELFMLAMD', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELFMLAMD', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELFMLAMD', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'ERELFMLAMD';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ERELFMLAMD', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ERELFMLAMD';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


IF OBJECT_ID('U_ERELFMLAMD_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ERELFMLAMD_AuditFields;
    CREATE TABLE dbo.U_ERELFMLAMD_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ERELFMLAMD_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ERELFMLAMD_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ERELFMLAMD_Audit;
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
    INTO dbo.U_ERELFMLAMD_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ERELFMLAMD_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ERELFMLAMD_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate -30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ERELFMLAMD_Audit ON dbo.U_ERELFMLAMD_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
   /* DELETE FROM dbo.U_ERELFMLAMD_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERELFMLAMD_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    */
    DELETE FROM dbo.U_ERELFMLAMD_EEList where xeeid in (select EecEEID from EmpComp where eecpaygroup in('CONTH','CONTR') or EecEEType = 'TES' )


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STDRS, LTDRS';

    IF OBJECT_ID('U_ERELFMLAMD_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ERELFMLAMD_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ERELFMLAMD_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@EndDate -30 );
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
    IF OBJECT_ID('U_ERELFMLAMD_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELFMLAMD_PDedHist;
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
    INTO dbo.U_ERELFMLAMD_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ERELFMLAMD_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ERELFMLAMD_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELFMLAMD_PEarHist;
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
    INTO dbo.U_ERELFMLAMD_PEarHist
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
    -- DETAIL RECORD - U_ERELFMLAMD_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ERELFMLAMD_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ERELFMLAMD_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvDateofBirth = EepDateOfBirth
        ,drvDateofHireMostRecent = eecdateoflasthire
        ,drvDateofHireOriginal = eecdateoforiginalhire
        ,drvDateofHireAdjusted = ''
        ,drvSSN  = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvFirstName = RTRIM(EepNameFirst)
        ,drvMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvLastName = RTRIM(EepNameLast)
        ,drvHomeAddress1 = RTRIM(EepAddressLine1)
        ,drvHomeAddress2 = RTRIM(EepAddressLine2)
        ,drvHomeAddress3 = ''
        ,drvHomeCity  = EepAddressCity
        ,drvHomeState = EepAddressState
        ,drvHomeZip              = EepAddressZipCode
        ,drvHomeCountry = ''
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvHomeEmailAddress = eepaddressemailalternate
        ,drvMaritalStatus = CASE WHEN eepmaritalstatus  = 'M' THEN 'M' 
                                 WHEN eepmaritalstatus  = 'S' THEN 'S' 
                            END
        ,drvGender = CASE WHEN eepGender  = 'F' THEN 'F' 
                                 WHEN eepGender  = 'M' THEN 'M' 
                            END
        ,drvWorkState = (Select top 1 Locaddressstate from dbo.Location where  LocCode = eeclocation)
        ,drvWorkPhone = EecPhoneBusinessNumber 
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvDepartmentNumber = EecOrgLvl2 --(Select Top 1 OrgDesc from OrgLevel where OrgCode = EecOrgLvl2 and OrgLvl = 2)
        ,drvDepartmentLocationName = (Select top 1 LocDesc from dbo.Location where  LocCode = eeclocation)
        ,drvLocationCode = eeclocation
        ,drvLocationName = (Select top 1 LocDesc from dbo.Location where  LocCode = eeclocation)
        ,drvPosition = dbo.dsi_fnRemoveChars('.,/-',replace(JbcDesc,char(9),' '))
        ,drvShiftWorked = ''
        ,drvIsActive = CASE WHEN eecemplstatus = 'T' THEN 'N' ELSE 'Y' END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvIsFulltime = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN 'Y' ELSE 'N' END
        ,drvExemptFlag = (Select top 1 EjhFLSACategory from dbo.emphjob where ejhcoid = xcoid and ejheeid =  xeeid order by ejhdatetimecreated desc)
        ,drvIsExempt = CASE WHEN (Select top 1 EjhFLSACategory from emphjob where ejhcoid = xcoid and ejheeid =  xeeid order by ejhdatetimecreated desc) IN ('E','Z') THEN 'Y' ELSE 'N' END
        ,drvAnnualSalaryRaw = EecAnnSalary
        ,drvAnnualSalary = CAST(EecAnnSalary as varchar(12))
        ,drvHourlyRate = CAST(CONVERT(DECIMAL(10,2),EecHourlyPayRate) as varchar(12))
        ,drvFICAYearToDate = ''
        ,drvHRRepName = ''
        ,drvHRRepEmailAddress = ''
        ,drvHRRepPhone = ''
        ,drvSupervisorName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameFirst Last')
        ,drvSupervisorEmailAddress = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail')
        ,drvSupervisorPhone = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'PrimayLocationNumber')
        ,drvHRManagerName = ''
        ,drvHRManagerEmail = ''
        ,drvHRManagerPhone = ''
        ,drvManagerName = dbo.dsi_fnlib_GetSupervisorField('', EecSupervisorID, 'NameFirst Last')
        ,drvManagerEmail = dbo.dsi_fnlib_GetSupervisorField('', EecSupervisorID, 'AddressEMail')
        ,drvManagerPhone = dbo.dsi_fnlib_GetSupervisorField('', EecSupervisorID, 'PrimayLocationNumber')
        ,drvSubGroupA = (Select top 1 Locaddressstate from dbo.Location where  LocCode = eeclocation)
        ,drvSubGroupB = CONVERT(VARCHAR(20),(Select top 1 LocDesc from dbo.Location where  LocCode = eeclocation))
        ,drvSubGroupC = EecJobCode
        ,drvSubGroupD = CASE WHEN (Select top 1 EjhFLSACategory from emphjob where ejhcoid = xcoid and ejheeid =  xeeid order by ejhdatetimecreated desc) IN ('E','Z') THEN 'Exempt' ELSE 'Non-Exempt' END
        ,drvSubGroupE = EecDedGroupCode
        ,drvSubGroupF = cmpcompanycode
        ,drvIsSTDEligible = CASE WHEN STDRS is not null then 'Y' ELSE 'N' END
        ,drvStdPlanEffective =  CASE WHEN STDRS_BenefitDate is not null then STDRS_BenefitDate END
        ,drvIsSTDSupplementalEligible = ''
        ,drvStdSuppEffective = ''
        ,drvIsCaliVoluntaryPlanElig = ''
        ,drvCaliVoluPlanEffective = ''
        ,drvIsLTDEligible =  CASE WHEN LTDRS is not null then 'Y' ELSE 'N' END
        ,drvLTDEffectiveDate = CASE WHEN LTDRS_BenefitDate is not null then LTDRS_BenefitDate END
        ,drvIsOtherEligible = ''
        ,drvIsOtherEligibleEffDate = ''
        ,drvHoursWorked = CAST(        
                    (CONVERT(DECIMAL(10,2),
                    (CASE WHEN EecPayPeriod = 'B' THEN (EecScheduledWorkHrs / 2) 
                    ELSE (EecScheduledWorkHrs * 24 ) / 52 END)
                    ))
                     as varchar(50))
        ,drvHoursWorkedBefore = CAST(        
                    (CONVERT(DECIMAL(10,2),
                    (CASE WHEN EecPayPeriod = 'B' THEN (EecScheduledWorkHrs / 2) 
                    ELSE (EecScheduledWorkHrs / (SELECT (DATEPART(dd, EOMONTH(@EndDate )) / 7) + 
                    CASE WHEN (DATEPART(dd, EOMONTH(@EndDate)) % 7) > 0 THEN 1 ELSE 0 END)) END)
                    ))
                     as varchar(50))
        ,drvAtWorksite = ''
        ,drvDomesticPartnerIndicator = ''
        ,drvSpouseWorkingSameCo = ''
        ,drvKeyEmployeeInd = ''
        ,drvEmployees50in75MileInd = ''
        ,drvAddData01 = ''
        ,drvAddData02 = ''
        ,drvAddData03 = ''
        ,drvAddData04 = ''
        ,drvAddData05 = ''
        ,drvAddData06 = ''
        ,drvAddData07 = ''
        ,drvAddData08 = ''
        ,drvAddData09 = ''
        ,drvAddData10 = ''
    INTO dbo.U_ERELFMLAMD_drvTbl
    FROM dbo.U_ERELFMLAMD_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ERELFMLAMD_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (Select  bdmEEID,bdmcoid
            ,LTDRS = MAX((CASE WHEN BDMDedCode = 'LTDRS' then BDMDedCode END))
            ,STDRS = MAX((CASE WHEN BDMDedCode = 'STDRS' then BDMDedCode END))
            ,LTDRS_BenefitDate = MAX((CASE WHEN BDMDedCode = 'LTDRS' then  bdmBenStartDate END))
            ,STDRS_BenefitDate = MAX((CASE WHEN BDMDedCode = 'STDRS' then  bdmBenStartDate END))
            from dbo.U_dsi_bdm_ERELFMLAMD  group by bdmEEID,bdmcoid) as Consolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.JobCode WITH (NOLOCK)
        on EecJobCode = JbcJobCode
    Join dbo.Company WITH (NOLOCK)
        on cmpcoid =  xcoid 
    ;

    Delete from dbo.U_ERELFMLAMD_drvTbl  where drveeid in (
    Select distinct drveeid from dbo.U_ERELFMLAMD_drvTbl   group by drveeid having count(*) > 1)
    and drvcoid <> dbo.dsi_BDM_fn_GetCurrentCOID(drveeid) ;


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
ALTER VIEW dbo.dsi_vwERELFMLAMD_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ERELFMLAMD_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ERELFMLAMD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005111'
       ,expStartPerControl     = '202005111'
       ,expLastEndPerControl   = '202005189'
       ,expEndPerControl       = '202005189'
WHERE expFormatCode = 'ERELFMLAMD';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwERELFMLAMD_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERELFMLAMD_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort