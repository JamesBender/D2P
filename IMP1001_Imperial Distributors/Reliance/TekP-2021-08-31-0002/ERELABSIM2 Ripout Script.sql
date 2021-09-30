SET NOCOUNT ON;
IF OBJECT_ID('U_ERELABSIM2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ERELABSIM2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ERELABSIM2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwERELABSIM2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwERELABSIM2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERELABSIM2_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELABSIM2_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ERELABSIM2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELABSIM2];
GO
IF OBJECT_ID('U_ERELABSIM2_PTaxHist') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_PTaxHist];
GO
IF OBJECT_ID('U_ERELABSIM2_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_PEarHist];
GO
IF OBJECT_ID('U_ERELABSIM2_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_PDedHist];
GO
IF OBJECT_ID('U_ERELABSIM2_File') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_File];
GO
IF OBJECT_ID('U_ERELABSIM2_EEList') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_EEList];
GO
IF OBJECT_ID('U_ERELABSIM2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_drvTbl];
GO
IF OBJECT_ID('U_ERELABSIM2_DedList') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ERELABSIM2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ERELABSIM2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ERELABSIM2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ERELABSIM2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ERELABSIM2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ERELABSIM2','Reliance Absence Mgmt Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ERELABSIM2Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ERELABSIM2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','1','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','1',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Most Recent"','2','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','2',NULL,'Date of Hire Most Recent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Original"','3','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','3',NULL,'Date of Hire Original',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire Adjusted"','3','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','3',NULL,'Date of Hire Adjusted',NULL,NULL);



INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','4','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','5','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','5',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','7','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','7',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','8','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 1"','9','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','9',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 2"','10','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','10',NULL,'Home Address 2',NULL,NULL);

INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Address 3"','10','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','10',NULL,'Home Address 3',NULL,NULL);



INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home City"','11','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','11',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home State"','12','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','12',NULL,'Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Zip"','13','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','13',NULL,'Home Zip',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Country"','13','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','13',NULL,'Home Country',NULL,NULL);



INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Phone"','14','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','14',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Email Address"','15','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','15',NULL,'Home Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','16','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','16',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','17','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','17',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State"','18','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','18',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Phone"','19','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','19',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email Address"','20','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','20',NULL,'Work Email Address',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Number"','20','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','20',NULL,'Department Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Name"','20','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','20',NULL,'Department Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Code"','20','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','20',NULL,'Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location Name"','20','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','20',NULL,'Location Name',NULL,NULL);



--INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Org Level 2 or 4"','21','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','21',NULL,'Org Level 2 or 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Position"','22','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','22',NULL,'Position',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Shift Worked"','23','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','23',NULL,'Shift Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Active"','24','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','24',NULL,'Is Active',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','24','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','24',NULL,'Termination Date',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Fulltime"','25','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','25',NULL,'Is Fulltime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Exempt"','26','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','26',NULL,'Is Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Annual Salary"','27','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','27',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hourly Rate"','28','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','28',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FICA Year To Date"','29','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','29',NULL,'FICA Year To Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Name"','30','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','30',NULL,'HR Rep Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Email Address"','31','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','31',NULL,'HR Rep Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Rep Phone"','32','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','32',NULL,'HR Rep Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Name"','33','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','33',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor  Email Address"','34','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','34',NULL,'Supervisor  Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor Phone"','35','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','35',NULL,'Supervisor Phone',NULL,NULL);


INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Name"','35','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','35',NULL,'HR Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Email"','35','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','35',NULL,'HR Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Manager Phone"','35','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','35',NULL,'HR Manager Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Namee"','35','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','35',NULL,'Manager Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Email"','35','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','35',NULL,'Manager Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Manager Phone"','35','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','35',NULL,'Manager Phone',NULL,NULL);




INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group A"','36','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','36',NULL,'Sub Group A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group B"','37','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','37',NULL,'Sub Group B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group C"','38','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','38',NULL,'Sub Group C',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group D"','39','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','39',NULL,'Sub Group D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group E"','40','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','40',NULL,'Sub Group E',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Group F"','41','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','41',NULL,'Sub Group F',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is STD Eligible"','42','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','42',NULL,'Is STD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Std Plan Effective"','43','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','43',NULL,'Std Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is STD Supplemental Eligible (Buy Up / Supp Plan)"','44','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','44',NULL,'Is STD Supplemental Eligible (Buy Up / Supp Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Std Supp Effective"','45','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','45',NULL,'Std Supp Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is California Voluntary Plan Eligible"','46','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','46',NULL,'Is California Voluntary Plan Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"California Voluntary Plan Effective"','47','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','47',NULL,'California Voluntary Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is LTD Eligible"','48','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','48',NULL,'Is LTD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTD Effective Date"','49','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','49',NULL,'LTD Effective Date',NULL,NULL);





INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Other Eligible (Buy Up / Supp LTD Plan)"','50','(''DA''=''T|'')','ERELABSIM2Z0','50','H','01','50',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Is Other Eligible (Buy Up / Supp LTD Plan) Effective Date"','51','(''DA''=''T|'')','ERELABSIM2Z0','51','H','01','51',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan) Effecti',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 01"','52','(''DA''=''T|'')','ERELABSIM2Z0','52','H','01','52',NULL,'Add Data 01',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 02"','53','(''DA''=''T|'')','ERELABSIM2Z0','53','H','01','53',NULL,'Add Data 02',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 03"','54','(''DA''=''T|'')','ERELABSIM2Z0','54','H','01','54',NULL,'Add Data 03',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 04"','55','(''DA''=''T|'')','ERELABSIM2Z0','55','H','01','55',NULL,'Add Data 04',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Add Data 05"','56','(''DA''=''T'')','ERELABSIM2Z0','56','H','01','56',NULL,'Add Data 05',NULL,NULL);





INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','1','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','1',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHireMostRecent"','2','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','2',NULL,'Date of Hire Most Recent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHireOriginal"','3','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','3',NULL,'Date of Hire Original',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','4','(''UA''=''T|'')','ERELABSIM2Z0','11','D','10','4',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','5','(''UA''=''T|'')','ERELABSIM2Z0','20','D','10','5',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','6','(''UA''=''T|'')','ERELABSIM2Z0','40','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','7','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','7',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','8','(''UA''=''T|'')','ERELABSIM2Z0','40','D','10','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddress1"','9','(''UA''=''T|'')','ERELABSIM2Z0','50','D','10','9',NULL,'Home Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeAddress2"','10','(''UA''=''T|'')','ERELABSIM2Z0','50','D','10','10',NULL,'Home Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeCity"','11','(''UA''=''T|'')','ERELABSIM2Z0','35','D','10','11',NULL,'Home City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeState"','12','(''UA''=''T|'')','ERELABSIM2Z0','2','D','10','12',NULL,'Home State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeZip"','13','(''UA''=''T|'')','ERELABSIM2Z0','10','D','10','13',NULL,'Home Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','14','(''UA''=''T|'')','ERELABSIM2Z0','25','D','10','14',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeEmailAddress"','15','(''UA''=''T|'')','ERELABSIM2Z0','255','D','10','15',NULL,'Home Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','16','(''UA''=''T|'')','ERELABSIM2Z0','10','D','10','16',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''T|'')','ERELABSIM2Z0','8','D','10','17',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','18','(''UA''=''T|'')','ERELABSIM2Z0','2','D','10','18',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','19','(''UA''=''T|'')','ERELABSIM2Z0','25','D','10','19',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','20','(''UA''=''T|'')','ERELABSIM2Z0','255','D','10','20',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgLevel2or4"','21','(''UA''=''T|'')','ERELABSIM2Z0','40','D','10','21',NULL,'Org Level 2 or 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPosition"','22','(''UA''=''T|'')','ERELABSIM2Z0','50','D','10','22',NULL,'Position',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvShiftWorked"','23','(''UA''=''T|'')','ERELABSIM2Z0','25','D','10','23',NULL,'Shift Worked',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsActive"','24','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','24',NULL,'Is Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsFulltime"','25','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','25',NULL,'Is Fulltime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsExempt"','26','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','26',NULL,'Is Exempt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualSalary"','27','(''UNT2''=''T|'')','ERELABSIM2Z0','16','D','10','27',NULL,'Annual Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlyRate"','28','(''UNT2''=''T|'')','ERELABSIM2Z0','16','D','10','28',NULL,'Hourly Rate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFICAYearToDate"','29','(''UNT2''=''T|'')','ERELABSIM2Z0','16','D','10','29',NULL,'FICA Year To Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepName"','30','(''UA''=''T|'')','ERELABSIM2Z0','50','D','10','30',NULL,'HR Rep Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepEmailAddress"','31','(''UA''=''T|'')','ERELABSIM2Z0','255','D','10','31',NULL,'HR Rep Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRRepPhone"','32','(''UA''=''T|'')','ERELABSIM2Z0','25','D','10','32',NULL,'HR Rep Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorName"','33','(''UA''=''T|'')','ERELABSIM2Z0','50','D','10','33',NULL,'Supervisor Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorEmailAddress"','34','(''UA''=''T|'')','ERELABSIM2Z0','255','D','10','34',NULL,'Supervisor  Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorPhone"','35','(''UA''=''T|'')','ERELABSIM2Z0','25','D','10','35',NULL,'Supervisor Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupA"','36','(''UA''=''T|'')','ERELABSIM2Z0','2','D','10','36',NULL,'Sub Group A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupB"','37','(''UA''=''T|'')','ERELABSIM2Z0','20','D','10','37',NULL,'Sub Group B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupC"','38','(''UA''=''T|'')','ERELABSIM2Z0','20','D','10','38',NULL,'Sub Group C',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupD"','39','(''UA''=''T|'')','ERELABSIM2Z0','20','D','10','39',NULL,'Sub Group D',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupE"','40','(''UA''=''T|'')','ERELABSIM2Z0','20','D','10','40',NULL,'Sub Group E',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubGroupF"','41','(''UA''=''T|'')','ERELABSIM2Z0','20','D','10','41',NULL,'Sub Group F',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSTDEligible"','42','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','42',NULL,'Is STD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStdPlanEffectiveDate"','43','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','43',NULL,'Std Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsSTDSuppEligible"','44','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','44',NULL,'Is STD Supplemental Eligible (Buy Up / Supp Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStdSuppEffectiveDate"','45','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','45',NULL,'Std Supp Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsCAVolPlanEligible"','46','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','46',NULL,'Is California Voluntary Plan Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCAVolPlanEffectiveDate"','47','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','47',NULL,'California Voluntary Plan Effective',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsLTDEligible"','48','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','48',NULL,'Is LTD Eligible',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDEffectiveDate"','49','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','49',NULL,'LTD Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsOtherEligible"','50','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','50',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsOtherEligibleEffDate"','51','(''UD101''=''T|'')','ERELABSIM2Z0','10','D','10','51',NULL,'Is Other Eligible (Buy Up / Supp LTD Plan) Effecti',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData01"','52','(''UA''=''T|'')','ERELABSIM2Z0','50','D','10','52',NULL,'Add Data 01',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData02"','53','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','53',NULL,'Add Data 02',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData03"','54','(''UA''=''T|'')','ERELABSIM2Z0','10','D','10','54',NULL,'Add Data 03',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData04"','55','(''UA''=''T|'')','ERELABSIM2Z0','1','D','10','55',NULL,'Add Data 04',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddData05"','56','(''UA''=''T'')','ERELABSIM2Z0','10','D','10','56',NULL,'Add Data 05',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ERELABSIM2_20210924.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201807109','EMPEXPORT','OEACTIVE',NULL,'ERELABSIM2',NULL,NULL,NULL,'201807109','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','201807101',NULL,'','','201807101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201807109','EMPEXPORT','OEPASSIVE',NULL,'ERELABSIM2',NULL,NULL,NULL,'201807109','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','201807101',NULL,'','','201807101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Reliance Absence Mgmt Export','201807109','EMPEXPORT','ONDEMAND',NULL,'ERELABSIM2',NULL,NULL,NULL,'201807109','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','201807101',NULL,'','','201807101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N',',SQF6O,WYPAI',NULL,NULL,NULL,'Scheduled Session Friday 5pmES','201808319','EMPEXPORT','SCHEDULED',NULL,'ERELABSIM2',NULL,NULL,NULL,'202109179','Jul 10 2018  7:19PM','Jul 10 2018  7:19PM','202109031',NULL,'','','201808171',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','201808299','EMPEXPORT','TEST','Aug 29 2018 11:03AM','ERELABSIM2',NULL,NULL,NULL,'201808299','Aug 29 2018 12:00AM','Dec 30 1899 12:00AM','201808151','771','','','201808151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPIMPD',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIM2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIM2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIM2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIM2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ERELABSIM2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ERELABSIM2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ERELABSIM2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ERELABSIM2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ERELABSIM2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELABSIM2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ERELABSIM2','D10','dbo.U_ERELABSIM2_drvTbl',NULL);
IF OBJECT_ID('U_ERELABSIM2_DedList') IS NULL
CREATE TABLE [dbo].[U_ERELABSIM2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ERELABSIM2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ERELABSIM2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateofHireMostRecent] datetime NULL,
    [drvDateofHireOriginal] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvHomeAddress1] varchar(255) NULL,
    [drvHomeAddress2] varchar(255) NULL,
    [drvHomeCity] varchar(255) NULL,
    [drvHomeState] varchar(255) NULL,
    [drvHomeZip] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvHomeEmailAddress] varchar(1) NOT NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvGender] char(1) NULL,
    [drvWorkState] char(2) NULL,
    [drvWorkPhone] varchar(50) NULL,
    [drvWorkEmailAddress] varchar(1) NOT NULL,
    [drvOrgLevel2or4] varchar(10) NULL,
    [drvPosition] varchar(25) NOT NULL,
    [drvShiftWorked] varchar(1) NOT NULL,
    [drvIsActive] varchar(1) NOT NULL,
    [drvIsFulltime] varchar(1) NOT NULL,
    [drvIsExempt] varchar(1) NOT NULL,
    [drvAnnualSalary] money NULL,
    [drvHourlyRate] decimal NULL,
    [drvFICAYearToDate] money NULL,
    [drvHRRepName] varchar(1) NOT NULL,
    [drvHRRepEmailAddress] varchar(1) NOT NULL,
    [drvHRRepPhone] varchar(1) NOT NULL,
    [drvSupervisorName] varchar(1) NOT NULL,
    [drvSupervisorEmailAddress] varchar(1) NOT NULL,
    [drvSupervisorPhone] varchar(1) NOT NULL,
    [drvSubGroupA] char(2) NULL,
    [drvSubGroupB] varchar(10) NULL,
    [drvSubGroupC] varchar(10) NULL,
    [drvSubGroupD] char(5) NOT NULL,
    [drvSubGroupE] char(5) NOT NULL,
    [drvSubGroupF] varchar(1) NOT NULL,
    [drvIsSTDEligible] varchar(1) NOT NULL,
    [drvStdPlanEffectiveDate] datetime NULL,
    [drvIsSTDSuppEligible] varchar(1) NOT NULL,
    [drvStdSuppEffectiveDate] varchar(1) NOT NULL,
    [drvIsCAVolPlanEligible] varchar(1) NOT NULL,
    [drvCAVolPlanEffectiveDate] varchar(1) NOT NULL,
    [drvIsLTDEligible] varchar(1) NOT NULL,
    [drvLTDEffectiveDate] datetime NULL,
    [drvIsOtherEligible] varchar(1) NOT NULL,
    [drvIsOtherEligibleEffDate] varchar(1) NOT NULL,
    [drvAddData01] varchar(1) NOT NULL,
    [drvAddData02] varchar(1) NOT NULL,
    [drvAddData03] varchar(1) NOT NULL,
    [drvAddData04] varchar(1) NOT NULL,
    [drvAddData05] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ERELABSIM2_EEList') IS NULL
CREATE TABLE [dbo].[U_ERELABSIM2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ERELABSIM2_File') IS NULL
CREATE TABLE [dbo].[U_ERELABSIM2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_ERELABSIM2_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ERELABSIM2_PDedHist] (
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
IF OBJECT_ID('U_ERELABSIM2_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ERELABSIM2_PEarHist] (
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
IF OBJECT_ID('U_ERELABSIM2_PTaxHist') IS NULL
CREATE TABLE [dbo].[U_ERELABSIM2_PTaxHist] (
    [PthEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PthTaxAmtYTD] money NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ERELABSIM2]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Imperial Distributors, Inc.

Created By: Joseph Pham
Business Analyst: Liz Bachan
Create Date: 07/10/2018
Service Request Number: SR-2018-00195969

Purpose: Reliance Absence Mgmt Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2018     SR-2018-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ERELABSIM2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ERELABSIM2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ERELABSIM2';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ERELABSIM2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ERELABSIM2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIM2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIM2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIM2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ERELABSIM2', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ERELABSIM2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ERELABSIM2', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ERELABSIM2';

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
    DELETE FROM dbo.U_ERELABSIM2_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ERELABSIM2_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_ERELABSIM2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIM2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ERELABSIM2_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','GTLC1,GTLC2,GTLC3,GTLC4,GTLC5');
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
    IF OBJECT_ID('U_ERELABSIM2_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIM2_PDedHist;
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
    INTO dbo.U_ERELABSIM2_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ERELABSIM2_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_ERELABSIM2_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIM2_PEarHist;
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
    INTO dbo.U_ERELABSIM2_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    -----------------------------
    -- Working Table - YTD FICA Withholdings
    -----------------------------
    IF OBJECT_ID('U_ERELABSIM2_PTaxHist','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIM2_PTaxHist;
    SELECT DISTINCT
         PthEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- YTD Payroll Amount/Hours
        ,PthTaxAmtYTD           = SUM(PthCurTaxAmt)
    INTO dbo.U_ERELABSIM2_PTaxHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PTaxHist WITH (NOLOCK)
        ON PthGenNumber = PrgGenNumber
    WHERE LEFT(PthPerControl,4) = LEFT(@EndPerControl,4)
    AND PthPerControl <= @EndPerControl
    AND PthTaxCode IN ('USSOCEE','USMEDEE')
    GROUP BY PthEEID
    HAVING SUM(PthCurTaxAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ERELABSIM2_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ERELABSIM2_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ERELABSIM2_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        -- standard fields above and additional driver fields below
        ,drvDateofBirth = EepDateOfBirth
        ,drvDateofHireMostRecent = EecDateOfLastHire
        ,drvDateofHireOriginal = EecDateOfOriginalHire
        ,drvSSN = eepSSN
        ,drvEmployeeID = EecEmpNo
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvHomeAddress1 = EepAddressLine1
        ,drvHomeAddress2 = EepAddressLine2
        ,drvHomeCity = EepAddressCity
        ,drvHomeState = EepAddressState
        ,drvHomeZip = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvHomeEmailAddress = ''
        ,drvMaritalStatus = eepMaritalStatus
        ,drvGender = EepGender
        ,drvWorkState = EecWCState
        ,drvWorkPhone = EecPhoneBusinessNumber
        ,drvWorkEmailAddress = ''
        ,drvOrgLevel2or4 = EecOrgLvl2
        ,drvPosition = JbcDesc
        ,drvShiftWorked = ''
        ,drvIsActive = CASE WHEN EecEmplStatus = 'T' THEN 'N' ELSE 'Y' END
        ,drvIsFulltime = CASE WHEN EecFullTimeOrPartTime = 'P' THEN 'N' ELSE 'Y' END
        ,drvIsExempt = CASE WHEN JbcFLSAType = 'N' THEN 'N' ELSE 'Y' END
        ,drvAnnualSalary = EecAnnSalary
        ,drvHourlyRate = EecHourlyPayRate
        ,drvFICAYearToDate = PthTaxAmtYTD
        ,drvHRRepName = ''
        ,drvHRRepEmailAddress = ''
        ,drvHRRepPhone = ''
        ,drvSupervisorName = ''
        ,drvSupervisorEmailAddress = ''
        ,drvSupervisorPhone = ''
        ,drvSubGroupA = EecWCState
        ,drvSubGroupB = EecOrgLvl2
        ,drvSubGroupC = EecOrgLvl4
        ,drvSubGroupD = EedDedCode
        ,drvSubGroupE = EedDedCode
        ,drvSubGroupF = ''
        ,drvIsSTDEligible = CASE
                                WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC3','GTLC4','GTLC5') THEN 'Y'
                                ELSE 'N'
                            END
        ,drvStdPlanEffectiveDate = CASE
                                        WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC3','GTLC4','GTLC5') THEN EedBenStartDate
                                    END
        ,drvIsSTDSuppEligible = ''
        ,drvStdSuppEffectiveDate = ''
        ,drvIsCAVolPlanEligible = ''
        ,drvCAVolPlanEffectiveDate = ''
        ,drvIsLTDEligible = CASE
                                WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC5') THEN 'Y'
                                ELSE 'N'
                            END
        ,drvLTDEffectiveDate = CASE
                                        WHEN EedDedCode IN ('GTLC1','GTLC2','GTLC5') THEN EedBenStartDate
                                    END
        ,drvIsOtherEligible = ''
        ,drvIsOtherEligibleEffDate = ''
        ,drvAddData01 = ''
        ,drvAddData02 = ''
        ,drvAddData03 = ''
        ,drvAddData04 = ''
        ,drvAddData05 = ''
    INTO dbo.U_ERELABSIM2_drvTbl
    FROM dbo.U_ERELABSIM2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = JbcJobCode
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_ERELABSIM2_PTaxHist WITH (NOLOCK)
        ON PthEEID = xEEID
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_ERELABSIM2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'ERELABSIM2_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwERELABSIM2_Export AS
    SELECT TOP 20000000 Data
    FROM dbo.U_ERELABSIM2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ERELABSIM2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201807031'
       ,expStartPerControl     = '201807031'
       ,expLastEndPerControl   = '201807109'
       ,expEndPerControl       = '201807109'
WHERE expFormatCode = 'ERELABSIM2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwERELABSIM2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ERELABSIM2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort