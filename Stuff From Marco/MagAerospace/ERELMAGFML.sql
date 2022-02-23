SET NOCOUNT ON;
IF OBJECT_ID('U_ERELMAGFML_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ERELMAGFML_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ERELMAGFML' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwERELMAGFML_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERELMAGFML_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERELMAGFML') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELMAGFML];
GO
IF OBJECT_ID('U_ERELMAGFML_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_PEarHist];
GO
IF OBJECT_ID('U_ERELMAGFML_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_PDedHist];
GO
IF OBJECT_ID('U_ERELMAGFML_File') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_File];
GO
IF OBJECT_ID('U_ERELMAGFML_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_EEList];
GO
IF OBJECT_ID('U_ERELMAGFML_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_drvTbl];
GO
IF OBJECT_ID('U_ERELMAGFML_DedList') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_DedList];
GO
IF OBJECT_ID('U_ERELMAGFML_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_AuditFields];
GO
IF OBJECT_ID('U_ERELMAGFML_Audit') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ERELMAGFML') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ERELMAGFML];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ERELMAGFML';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ERELMAGFML';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ERELMAGFML';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ERELMAGFML';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ERELMAGFML';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','ERELMAGFML','Reliance FMLA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','5000','S','N','ERELMAGFMLZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth "','1','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Most Recent "','2','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','52',NULL,'Date of Hire Most Recent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Original"','3','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','103',NULL,'Date of Hire Original',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Adjusted"','4','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','154',NULL,'Date of Hire Adjusted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN "','5','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','205',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID "','6','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','256',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','7','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','307',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','8','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','358',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','9','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','409',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 1"','10','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','460',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 2"','11','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','511',NULL,'Home Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 3"','12','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','562',NULL,'Home Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home City "','13','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','613',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home State"','14','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','664',NULL,'Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Zip             "','15','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','715',NULL,'Home Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Country"','16','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','766',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','17','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','817',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Email Address"','18','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','868',NULL,'Home Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','19','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','919',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender "','20','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','970',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State"','21','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1021',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','22','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1072',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email Address "','23','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1123',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Number "','24','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1174',NULL,'Department Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department / Location Name "','25','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1225',NULL,'Department / Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code "','26','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1276',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Name "','27','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1327',NULL,'Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Position         "','28','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1378',NULL,'Position',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Shift Worked"','29','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1429',NULL,'Shift Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Active"','30','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1480',NULL,'Is Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','31','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1531',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Fulltime "','32','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1582',NULL,'Is Fulltime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Exempt"','33','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1633',NULL,'Is Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','34','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1684',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Rate"','35','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1735',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FICA Year To Date"','36','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1786',NULL,'FICA Year To Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Name  "','37','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1837',NULL,'HR Rep Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Email Address"','38','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1888',NULL,'HR Rep Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Phone "','39','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1939',NULL,'HR Rep Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Name "','40','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','1990',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor  Email Address"','41','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2041',NULL,'Supervisor  Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Phone "','42','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2092',NULL,'Supervisor Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Name"','43','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2143',NULL,'HR Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Email"','44','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2194',NULL,'HR Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Phone"','45','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2245',NULL,'HR Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Name"','46','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2296',NULL,'Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Email"','47','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2347',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Phone"','48','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2398',NULL,'Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group A"','49','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2449',NULL,'Sub Group A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group B "','50','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2500',NULL,'Sub Group B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group C "','51','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2551',NULL,'Sub Group C',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group D "','52','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2602',NULL,'Sub Group D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group E "','53','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2653',NULL,'Sub Group E',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group F"','54','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2704',NULL,'Sub Group F',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is STD Eligible"','55','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2755',NULL,'Is STD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Std Plan Effective   "','56','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2806',NULL,'Std Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is STD Supplemental Eligible (Buy Up / Supp Plan)"','57','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2857',NULL,'Is STD Supplemental Eligible (Buy Up / Supp Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Std Supp Effective"','58','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2908',NULL,'Std Supp Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is California Voluntary Plan Eligible"','59','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','2959',NULL,'Is California Voluntary Plan Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"California Voluntary Plan Effective"','60','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3010',NULL,'California Voluntary Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is LTD Eligible"','61','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3061',NULL,'Is LTD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Effective Date "','62','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3112',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Other Eligible (Buy Up / Supp LTD Plan)"','63','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3163',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Other Eligible (Buy Up / Supp LTD Plan) Effective Date"','64','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3214',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan) Effecti',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked"','65','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3265',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"At Worksite"','66','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3316',NULL,'At Worksite',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Domestic Partner Indicator for Affidavits on-file"','67','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3367',NULL,'Domestic Partner Indicator for Affidavits on-file',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Working at the Same Company"','68','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3418',NULL,'Spouse Working at the Same Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Key Employee Indicator "','69','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3469',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employees 50 in 75 Mile Indicator"','70','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3520',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 01"','71','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3571',NULL,'Add Data 01',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 02 "','72','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3622',NULL,'Add Data 02',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 03 "','73','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3673',NULL,'Add Data 03',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 04 "','74','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3724',NULL,'Add Data 04',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 05 "','75','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3775',NULL,'Add Data 05',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 06 "','76','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3826',NULL,'Add Data 06',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 07 "','77','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3877',NULL,'Add Data 07',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 08 "','78','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3928',NULL,'Add Data 08',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 09 "','79','(''DA''=''T|'')','ERELMAGFMLZ0','50','H','01','3979',NULL,'Add Data 09',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 10 "','80','(''DA''=''T'')','ERELMAGFMLZ0','50','H','01','4030',NULL,'Add Data 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','1','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','1',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMostRecHireDate"','2','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','52',NULL,'Date of Hire Most Recent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigHireDate"','3','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','103',NULL,'Date of Hire Original',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireAdjustdDate"','4','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','154',NULL,'Date of Hire Adjusted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','205',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','6','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','256',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','307',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','8','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','358',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','9','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','409',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','10','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','460',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','11','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','511',NULL,'Home Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','12','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','562',NULL,'Home Address 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCity"','13','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','613',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeState"','14','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','664',NULL,'Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeZip"','15','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','715',NULL,'Home Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCountry"','16','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','766',NULL,'Home Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','17','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','817',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeEmailAddress"','18','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','868',NULL,'Home Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','19','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','919',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','20','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','970',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','21','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1021',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','22','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1072',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','23','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1123',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentNumber"','24','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1174',NULL,'Department Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeptLocName"','25','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1225',NULL,'Department / Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocCode"','26','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1276',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPositionName"','27','(''UA''=''T|'')','ERELMAGFMLZ0','100','D','10','1327',NULL,'Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPosition"','28','(''UA''=''T|'')','ERELMAGFMLZ0','100','D','10','1378',NULL,'Position',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShiftWork"','29','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1429',NULL,'Shift Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsActive"','30','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1480',NULL,'Is Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','31','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','1531',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsFullTime"','32','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1582',NULL,'Is Fulltime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsExempt"','33','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1633',NULL,'Is Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnSalary"','34','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1684',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyRate"','35','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1735',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFICAYTD"','36','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1786',NULL,'FICA Year To Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepName"','37','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1837',NULL,'HR Rep Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepEmailAdd"','38','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1888',NULL,'HR Rep Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepPhone"','39','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1939',NULL,'HR Rep Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorName"','40','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','1990',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuperVisorEmailAdd"','41','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2041',NULL,'Supervisor  Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorPhone"','42','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2092',NULL,'Supervisor Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRManagerName"','43','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2143',NULL,'HR Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRManageEmail"','44','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2194',NULL,'HR Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRManagerPhone"','45','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2245',NULL,'HR Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerName"','46','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2296',NULL,'Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmail"','47','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2347',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerPhone"','48','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2398',NULL,'Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupA"','49','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2449',NULL,'Sub Group A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupB"','50','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2500',NULL,'Sub Group B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupC"','51','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2551',NULL,'Sub Group C',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupD"','52','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2602',NULL,'Sub Group D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupE"','53','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2653',NULL,'Sub Group E',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupF"','54','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2704',NULL,'Sub Group F',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSTDElig"','55','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2755',NULL,'Is STD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStdPlanEffDate"','56','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','2806',NULL,'Std Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsStdSuppElig"','57','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2857',NULL,'Is STD Supplemental Eligible (Buy Up / Supp Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSuppEffDate"','58','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','2908',NULL,'Std Supp Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsCaliVolPlanElig"','59','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','2959',NULL,'Is California Voluntary Plan Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsCaliVolPlanEligDate"','60','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','3010',NULL,'California Voluntary Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsLTDElig"','61','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3061',NULL,'Is LTD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsLTDEligEffDate"','62','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','3112',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsLTDBuyUpElig"','63','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3163',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsLTDBuyUpEligDate"','64','(''UD101''=''T|'')','ERELMAGFMLZ0','50','D','10','3214',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan) Effecti',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','65','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3265',NULL,'Hours Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAtWorkSite"','66','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3316',NULL,'At Worksite',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDomPartIndAffidavit"','67','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3367',NULL,'Domestic Partner Indicator for Affidavits on-file',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseWorkingAtSameComp"','68','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3418',NULL,'Spouse Working at the Same Company',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmpIndicator"','69','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3469',NULL,'Key Employee Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMp5075MileInd"','70','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3520',NULL,'Employees 50 in 75 Mile Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData01"','71','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3571',NULL,'Add Data 01',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData02"','72','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3622',NULL,'Add Data 02',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData03"','73','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3673',NULL,'Add Data 03',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData04"','74','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3724',NULL,'Add Data 04',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData05"','75','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3775',NULL,'Add Data 05',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData06"','76','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3826',NULL,'Add Data 06',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData07"','77','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3877',NULL,'Add Data 07',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData08"','78','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3928',NULL,'Add Data 08',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData09"','79','(''UA''=''T|'')','ERELMAGFMLZ0','50','D','10','3979',NULL,'Add Data 09',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData10"','80','(''UA''=''T'')','ERELMAGFMLZ0','50','D','10','4030',NULL,'Add Data 10',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELMAGFML_20200522.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reliance FMLA Export','202004039','EMPEXPORT','ONDEMAND',NULL,'ERELMAGFML',NULL,NULL,NULL,'202004039','Apr  3 2020  3:43PM','Apr  3 2020  3:43PM','202004031',NULL,'','','202004031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELMAGFML_20200522.txt',NULL,NULL,NULL,',8O2FG,8O35B',NULL,NULL,NULL,'Reliance FMLA - Wednesdays 10a','202004039','EMPEXPORT','SCH_RELMAG',NULL,'ERELMAGFML',NULL,NULL,NULL,'202004039','Apr  3 2020  3:43PM','Apr  3 2020  3:43PM','202004031',NULL,'','','202004031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELMAGFML_20200522.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202004039','EMPEXPORT','OEACTIVE',NULL,'ERELMAGFML',NULL,NULL,NULL,'202004039','Apr  3 2020  3:43PM','Apr  3 2020  3:43PM','202004031',NULL,'','','202004031',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELMAGFML_20200522.txt',NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202007319','EMPEXPORT','OEPASSIVE','Apr  6 2020  4:38PM','ERELMAGFML',NULL,NULL,NULL,'202007319','Jul 31 2020 12:00AM','Dec 30 1899 12:00AM','202001031','1','','','202001031',dbo.fn_GetTimedKey(),NULL,'us3mLaMAG1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ERELMAGFML_20200522.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202005069','EMPEXPORT','TEST','May  6 2020 10:23AM','ERELMAGFML',NULL,NULL,NULL,'202005069','May  6 2020 12:00AM','Dec 30 1899 12:00AM','202004221','1246','','','202004221',dbo.fn_GetTimedKey(),NULL,'us3lKiMAG1008',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ERELMAGFML_20200522.txt' END WHERE expFormatCode = 'ERELMAGFML';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELMAGFML','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELMAGFML','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELMAGFML','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELMAGFML','SubSort','C','drvSubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELMAGFML','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELMAGFML','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELMAGFML','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ERELMAGFML' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ERELMAGFML' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ERELMAGFML_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELMAGFML_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELMAGFML','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELMAGFML','D10','dbo.U_ERELMAGFML_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ERELMAGFML') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ERELMAGFML] (
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
IF OBJECT_ID('U_ERELMAGFML_Audit') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_Audit] (
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
IF OBJECT_ID('U_ERELMAGFML_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ERELMAGFML_DedList') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ERELMAGFML_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubsort] varchar(1) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDOB] datetime NULL,
    [drvMostRecHireDate] datetime NULL,
    [drvOrigHireDate] datetime NULL,
    [drvHireAdjustdDate] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvHomeState] varchar(255) NULL,
    [drvHomeZip] varchar(50) NULL,
    [drvHomeCountry] varchar(1) NOT NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvHomeEmailAddress] varchar(50) NULL,
    [drvMaritalStatus] varchar(1) NULL,
    [drvGender] char(1) NULL,
    [drvWorkState] varchar(255) NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvDepartmentNumber] char(6) NULL,
    [drvDeptLocName] varchar(25) NULL,
    [drvLocCode] char(6) NULL,
    [drvPositionName] varchar(25) NULL,
    [drvPosition] varchar(25) NULL,
    [drvShiftWork] varchar(1) NOT NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvTermDate] datetime NULL,
    [drvIsFullTime] varchar(1) NOT NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvAnnSalary] varchar(1) NOT NULL,
    [drvHourlyRate] varchar(50) NULL,
    [drvFICAYTD] varchar(1) NOT NULL,
    [drvHRRepName] varchar(1) NOT NULL,
    [drvHRRepEmailAdd] varchar(1) NOT NULL,
    [drvHRRepPhone] varchar(1) NOT NULL,
    [drvSupervisorName] varchar(256) NULL,
    [drvSuperVisorEmailAdd] varchar(256) NULL,
    [drvSupervisorPhone] varchar(256) NULL,
    [drvHRManagerName] varchar(1) NOT NULL,
    [drvHRManageEmail] varchar(1) NOT NULL,
    [drvHRManagerPhone] varchar(1) NOT NULL,
    [drvManagerName] varchar(1) NOT NULL,
    [drvManagerEmail] varchar(1) NOT NULL,
    [drvManagerPhone] varchar(1) NOT NULL,
    [drvSubGroupA] varchar(255) NULL,
    [drvSubGroupB] char(6) NULL,
    [drvSubGroupC] varchar(25) NULL,
    [drvSubGroupD] char(6) NULL,
    [drvSubGroupE] char(5) NULL,
    [drvSubGroupF] varchar(1) NOT NULL,
    [drvIsSTDElig] varchar(1) NOT NULL,
    [drvStdPlanEffDate] datetime NULL,
    [drvIsStdSuppElig] varchar(1) NOT NULL,
    [drvSuppEffDate] varchar(1) NOT NULL,
    [drvIsCaliVolPlanElig] varchar(1) NOT NULL,
    [drvIsCaliVolPlanEligDate] varchar(1) NOT NULL,
    [drvIsLTDElig] varchar(1) NOT NULL,
    [drvLTD] varchar(1) NOT NULL,
    [drvIsLTDEligEffDate] datetime NULL,
    [drvIsLTDBuyUpElig] varchar(1) NOT NULL,
    [drvIsLTDBuyUpEligDate] varchar(1) NOT NULL,
    [drvHoursWorked] varchar(50) NULL,
    [drvAtWorkSite] varchar(1) NOT NULL,
    [drvDomPartIndAffidavit] varchar(1) NOT NULL,
    [drvSpouseWorkingAtSameComp] varchar(1) NOT NULL,
    [drvKeyEmpIndicator] varchar(1) NOT NULL,
    [drvEMp5075MileInd] varchar(1) NOT NULL,
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
IF OBJECT_ID('U_ERELMAGFML_EEList') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ERELMAGFML_File') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(5000) NULL
);
IF OBJECT_ID('U_ERELMAGFML_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_PDedHist] (
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
IF OBJECT_ID('U_ERELMAGFML_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ERELMAGFML_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELMAGFML]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: MAG Aerospace

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 04/03/2020
Service Request Number: TekP-2020-03-06-0004

Purpose: Reliance FMLA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERELMAGFML';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERELMAGFML';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERELMAGFML';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERELMAGFML';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERELMAGFML' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELMAGFML', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELMAGFML', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELMAGFML', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELMAGFML', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'ERELMAGFML';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ERELMAGFML', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'ERELMAGFML';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'


    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    /*DELETE FROM dbo.U_ERELMAGFML_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERELMAGFML_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    */
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'STD1,LTD1';

    IF OBJECT_ID('U_ERELMAGFML_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ERELMAGFML_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ERELMAGFML_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate -30);
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


    IF OBJECT_ID('U_ERELMAGFML_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ERELMAGFML_AuditFields;
    CREATE TABLE dbo.U_ERELMAGFML_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ERELMAGFML_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ERELMAGFML_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ERELMAGFML_Audit;
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
    INTO dbo.U_ERELMAGFML_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ERELMAGFML_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ERELMAGFML_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate -30 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ERELMAGFML_Audit ON dbo.U_ERELMAGFML_Audit (audKey1Value, audKey2Value);




    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ERELMAGFML_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELMAGFML_PDedHist;
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
    INTO dbo.U_ERELMAGFML_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ERELMAGFML_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ERELMAGFML_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELMAGFML_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN  PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_ERELMAGFML_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @EndPerControl
    And PehEarnCode IN 
('DR', 'O', 'OTP', 'R', 'RAJ', 'RET', 'OS1', 'SHD', 'SDR', 'TRN', 'TR')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ERELMAGFML_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ERELMAGFML_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ERELMAGFML_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = eepSSN
        ,drvSubsort = ''
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvDOB = EepDateOfBirth
        ,drvMostRecHireDate = EecDateOfLastHire
        ,drvOrigHireDate = eecdateoforiginalhire
        ,drvHireAdjustdDate = ''
        ,drvSSN = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvNameLast = EepNameLast
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressLine3 = ''
        ,drvHomeCity = EepAddressCity
        ,drvHomeState = EepAddressState
        ,drvHomeZip = EepAddressZipCode
        ,drvHomeCountry = ''
        ,drvHomePhone = eepphonehomenumber
        ,drvHomeEmailAddress = eepaddressemailalternate
        ,drvMaritalStatus = CASE WHEN isnull(eepMaritalStatus,'') in ('','Z') THEN 'S' ELSE eepMaritalStatus END
        ,drvGender = EepGender
        ,drvWorkState = Locaddressstate
        ,drvWorkPhone = ''
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvDepartmentNumber = Eecorglvl4
        ,drvDeptLocName = (Select top 1 OrgDesc  from OrgLevel  where OrgCode = Eecorglvl4)
        ,drvLocCode = eeclocation
        ,drvPositionName = LocDesc 
        ,drvPosition = (Select top 1 JbcDesc  from JobCode where JbcJobCode = eecJobCode)
        ,drvShiftWork = ''
        ,drvIsActive =  CASE WHEN EecEmplStatus = 'T' THEN 'N' ELSE 'Y' END
        ,drvTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvIsFullTime = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN 'Y' ELSE  'N' END
        ,drvIsExempt = CASE WHEN (select top  1 EjhFLSACategory from dbo.EmpHJob where EjhCoid = Xcoid and Ejheeid = Xeeid order by EjhDateTimeCreated desc) IN ('E', 'Z') THEN 'Y' ELSE 'N' END 
        ,drvAnnSalary = ''
        ,drvHourlyRate = CAST(EecHourlyPayRate as varchar(50))
        ,drvFICAYTD = ''
        ,drvHRRepName = ''
        ,drvHRRepEmailAdd = ''
        ,drvHRRepPhone = ''
        ,drvSupervisorName = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'NameLast, First')    
        ,drvSuperVisorEmailAdd = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'AddressEMail')    
        ,drvSupervisorPhone = dbo.dsi_fnlib_GetSupervisorField('', EecEEID, 'BusinessPhoneNumber')  
        ,drvHRManagerName = ''
        ,drvHRManageEmail = ''
        ,drvHRManagerPhone = ''
        ,drvManagerName = ''
        ,drvManagerEmail = ''
        ,drvManagerPhone = ''
        ,drvSubGroupA = Locaddressstate 
        ,drvSubGroupB = eeclocation
        ,drvSubGroupC = (select top 1 PgrDesc from dbo.PayGroup where pgrPayGroup = EecPayGroup)
        ,drvSubGroupD = Eecorglvl4
        ,drvSubGroupE = EecDedGroupCode
        ,drvSubGroupF = ''
        ,drvIsSTDElig = CASE WHEN STD1 is not null and EecDedGroupCode  in ('TIER8') THEN 'N'
                             WHEN EecDedGroupCode  in ('TIER3') THEN 'N'
                             WHEN STD1 is not null and eecemplstatus  in ('T') THEN 'N'
                             WHEN STD1 is not null then  'Y'
                             ELSE 'N' 
                       END
        ,drvStdPlanEffDate = CASE WHEN STD1 is not null and EecDedGroupCode  in ('TIER8') THEN NULL
                                    WHEN STD1 is not null and STD1_BenStatus ='A' THEN 
                                        eecdateoflasthire
                               END
        ,drvIsStdSuppElig = ''
        ,drvSuppEffDate = ''
        ,drvIsCaliVolPlanElig = ''
        ,drvIsCaliVolPlanEligDate = ''
        ,drvIsLTDElig =  CASE WHEN LTD1 is not null and EecDedGroupCode  in ('TIER8') THEN 'N'
                             WHEN EecDedGroupCode  in ('TIER3') THEN 'N'
                             WHEN LTD1 is not null and eecemplstatus  in ('T') THEN 'N'
                             WHEN LTD1 is not null  then 'Y'
                             ELSE 'N' 
                       END
        ,drvLTD  = CASE WHEN LTD1_BenefitDate < CAST('01/01/2020' as datetime) then 'A' else 'B' END
        ,drvIsLTDEligEffDate = CASE WHEN LTD1 is not null and EecDedGroupCode  in ('TIER8') THEN NULL
                                  WHEN LTD1 is not null and LTD1_BenStatus = 'A' THEN 

                                                  eecdateoflasthire

                                  
                               END
        ,drvIsLTDBuyUpElig = ''
        ,drvIsLTDBuyUpEligDate = ''
        ,drvHoursWorked = CAST(CONVERT(DECIMAL(10,2),PehCurHrs) as varchar(50))
        ,drvAtWorkSite = ''
        ,drvDomPartIndAffidavit = ''
        ,drvSpouseWorkingAtSameComp = ''
        ,drvKeyEmpIndicator = ''
        ,drvEMp5075MileInd = CASE WHEN EecDedGroupCode in ('TIER2', 'TIR2A') THEN 'N' ELSE 'Y' END
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
    INTO dbo.U_ERELMAGFML_drvTbl
    FROM dbo.U_ERELMAGFML_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ERELMAGFML_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (Select  bdmEEID,bdmcoid
            ,STD1  = MAX((CASE WHEN BDMDedCode = 'STD1' then 'STD1' END))
            ,LTD1  = MAX((CASE WHEN BDMDedCode = 'LTD1 ' then 'LTD1' END))
            ,LTD1_BenefitDate = MAX((CASE WHEN BDMDedCode = 'LTD1' then  bdmbenstartdate END))
            ,STD1_BenefitDate = MAX((CASE WHEN BDMDedCode = 'STD1' then  bdmbenstartdate END))
            ,STD1_BenStatus =  MAX((CASE WHEN BDMDedCode = 'STD1' then  bdmbenstatus END))
            ,LTD1_BenStatus =  MAX((CASE WHEN BDMDedCode = 'LTD1' then  bdmbenstatus END))

            from U_dsi_bdm_ERELMAGFML  group by bdmEEID,bdmcoid) as BdmConsolidated
    ON BdmConsolidated.BdmEEID = xEEID
    AND BdmConsolidated.BdmCOID = xCOID
    LEFT JOIN dbo.Location WITH (NOLOCK)
        ON EecLocation =  LocCode
    LEFT JOIN dbo.U_ERELMAGFML_PEarHist
        ON PEHEEid = Xeeid
    ;


    Delete from U_ERELMAGFML_drvTbl where drvinitialsort = '123456789';
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
ALTER VIEW dbo.dsi_vwERELMAGFML_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ERELMAGFML_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ERELMAGFML%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003271'
       ,expStartPerControl     = '202003271'
       ,expLastEndPerControl   = '202004039'
       ,expEndPerControl       = '202004039'
WHERE expFormatCode = 'ERELMAGFML';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwERELMAGFML_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERELMAGFML_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort, SubSort2 