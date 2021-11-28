SET NOCOUNT ON;
IF OBJECT_ID('U_ESTANDAR2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESTANDAR2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESTANDAR2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESTANDAR2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTANDAR2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTANDAR2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANDAR2];
GO
IF OBJECT_ID('U_ESTANDAR2_File') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_File];
GO
IF OBJECT_ID('U_ESTANDAR2_EmpAge') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_EmpAge];
GO
IF OBJECT_ID('U_ESTANDAR2_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_EEList];
GO
IF OBJECT_ID('U_ESTANDAR2_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_DedList];
GO
IF OBJECT_ID('U_ESTANDAR2_D10') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_D10];
GO
IF OBJECT_ID('U_ESTANDAR2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_AuditFields];
GO
IF OBJECT_ID('U_ESTANDAR2_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESTANDAR2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESTANDAR2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESTANDAR2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESTANDAR2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESTANDAR2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTANDAR2','The Standard Export V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','6000','S','N','ESTANDAR20Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization ID Code"','1','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','1',NULL,'Organization ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sub Org Text"','2','(''DA''=''T|'')','ESTANDAR20Z0','12','H','01','2',NULL,'Sub Org Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','3','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','3',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','4','(''DA''=''T|'')','ESTANDAR20Z0','11','H','01','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Name Prefix"','5','(''DA''=''T|'')','ESTANDAR20Z0','11','H','01','5',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','7','(''DA''=''T|'')','ESTANDAR20Z0','11','H','01','7',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','8','(''DA''=''T|'')','ESTANDAR20Z0','9','H','01','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Name Suffix"','9','(''DA''=''T|'')','ESTANDAR20Z0','11','H','01','9',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','10','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Death"','11','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','11',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','12','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','13','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','13',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 1"','14','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','14',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 2"','15','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','15',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Line 3"','16','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','16',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','17','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State/Province"','18','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','18',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Postal Code"','19','(''DA''=''T|'')','ESTANDAR20Z0','11','H','01','19',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','20','(''DA''=''T|'')','ESTANDAR20Z0','7','H','01','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Non-Work Phone"','21','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','21',NULL,'Non-Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Hire Date"','22','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','22',NULL,'Current Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','23','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','23',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Adjusted Hire Date"','24','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','24',NULL,'Adjusted Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Termination Date"','25','(''DA''=''T|'')','ESTANDAR20Z0','27','H','01','25',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State"','26','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','26',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','27','(''DA''=''T|'')','ESTANDAR20Z0','9','H','01','27',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','28','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','28',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Work Hours"','29','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','29',NULL,'Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Work Hours Frequency"','30','(''DA''=''T|'')','ESTANDAR20Z0','30','H','01','30',NULL,'Scheduled Work Hours Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Pay Type"','31','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','31',NULL,'Employee Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Full/Part Time"','32','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','32',NULL,'Full/Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Type"','33','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','33',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email Address"','34','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','34',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Exempt Status"','35','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','35',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Flag"','36','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','36',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Name"','37','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','37',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Affiliate"','38','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','38',NULL,'Employer Affiliate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Location Code"','39','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','39',NULL,'Employer Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Location Name"','40','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','40',NULL,'Employer Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Code"','41','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','41',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department Name"','42','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','42',NULL,'Department Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Occupation code"','43','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','43',NULL,'Occupation code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific 1"','44','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','44',NULL,'User Specific 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific 2"','45','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','45',NULL,'User Specific 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific 3"','46','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','46',NULL,'User Specific 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific 4"','47','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','47',NULL,'User Specific 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific 5"','48','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','48',NULL,'User Specific 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earning Category 1"','49','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','49',NULL,'Earning Category 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Type 1"','50','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','50',NULL,'Earnings Type 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Amount 1"','51','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','51',NULL,'Earnings Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Amount Expression 1"','52','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','52',NULL,'Earnings Amount Expression 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Effective Date 1 OR Earnings Pay Date 1"','53','(''DA''=''T|'')','ESTANDAR20Z0','48','H','01','53',NULL,'Earnings Effective Date 1 OR Earnings Pay Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency 1"','54','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','54',NULL,'Payroll Frequency 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Start Date 1"','55','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','55',NULL,'Pay Start Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay End Date 1"','56','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','56',NULL,'Pay End Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Hours 1"','57','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','57',NULL,'Pay Period Hours 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earning Category 2"','58','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','58',NULL,'Earning Category 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Type 2"','59','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','59',NULL,'Earnings Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Amount 2"','60','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','60',NULL,'Earnings Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Amount Expression 2"','61','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','61',NULL,'Earnings Amount Expression 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Effective Date 2"','62','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','62',NULL,'Earnings Effective Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency 2"','63','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','63',NULL,'Payroll Frequency 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Start Date 2"','64','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','64',NULL,'Pay Start Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay End Date 2"','65','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','65',NULL,'Pay End Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Hours 2"','66','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','66',NULL,'Pay Period Hours 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earning Category 3"','67','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','67',NULL,'Earning Category 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Type 3"','68','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','68',NULL,'Earnings Type 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Amount 3"','69','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','69',NULL,'Earnings Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Amount Expression 3"','70','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','70',NULL,'Earnings Amount Expression 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Earnings Effective Date 3"','71','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','71',NULL,'Earnings Effective Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Payroll Frequency 3"','72','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','72',NULL,'Payroll Frequency 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Start Date 3"','73','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','73',NULL,'Pay Start Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay End Date 3"','74','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','74',NULL,'Pay End Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Period Hours 3"','75','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','75',NULL,'Pay Period Hours 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked in the Last 12 months"','76','(''DA''=''T|'')','ESTANDAR20Z0','34','H','01','76',NULL,'Hours Worked in the Last 12 months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Worked in the Last 12 Months THRU DATE "','77','(''DA''=''T|'')','ESTANDAR20Z0','45','H','01','77',NULL,'Hours Worked in the Last 12 Months THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Supervisor/Manager Employee ID"','78','(''DA''=''T|'')','ESTANDAR20Z0','30','H','01','78',NULL,'Supervisor/Manager Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Future use field"','79','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','79',NULL,'Future use field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 1"','80','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','80',NULL,'AMS Reporting Group 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 2"','81','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','81',NULL,'AMS Reporting Group 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 3"','82','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','82',NULL,'AMS Reporting Group 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 4"','83','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','83',NULL,'AMS Reporting Group 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 5"','84','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','84',NULL,'AMS Reporting Group 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 6"','85','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','85',NULL,'AMS Reporting Group 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 7"','86','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','86',NULL,'AMS Reporting Group 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 8"','87','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','87',NULL,'AMS Reporting Group 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AMS Reporting Group 9"','88','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','88',NULL,'AMS Reporting Group 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Contact Recipient"','89','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','89',NULL,'HR Contact Recipient',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Contact Email Address"','90','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','90',NULL,'HR Contact Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HR Contact Work Phone"','91','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','91',NULL,'HR Contact Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Category 1"','92','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','92',NULL,'Reporting Category 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Category 2"','93','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','93',NULL,'Reporting Category 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Category 3"','94','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','94',NULL,'Reporting Category 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Category 4"','95','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','95',NULL,'Reporting Category 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reporting Category 5"','96','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','96',NULL,'Reporting Category 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','97','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','97',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan"','98','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','98',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product"','99','(''DA''=''T|'')','ESTANDAR20Z0','7','H','01','99',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Plan Code"','100','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','100',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Waiting Period"','101','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','101',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','102','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','102',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Selected Amount"','103','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','103',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Am Class"','104','(''DA''=''T|'')','ESTANDAR20Z0','8','H','01','104',NULL,'Am Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class Name"','105','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','105',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','106','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','106',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','107','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','107',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','108','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','108',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan"','109','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','109',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product"','110','(''DA''=''T|'')','ESTANDAR20Z0','7','H','01','110',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Plan Code"','111','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','111',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Waiting Period"','112','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','112',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','113','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','113',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Selected Amount"','114','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','114',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Am Class"','115','(''DA''=''T|'')','ESTANDAR20Z0','8','H','01','115',NULL,'Am Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class Name"','116','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','116',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','117','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','117',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','118','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','118',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','119','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','119',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan"','120','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','120',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product"','121','(''DA''=''T|'')','ESTANDAR20Z0','7','H','01','121',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Plan Code"','122','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','122',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Waiting Period"','123','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','123',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','124','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','124',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Selected Amount"','125','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','125',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class Name"','126','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','126',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','127','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','127',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','128','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','128',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','129','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','129',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan"','130','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','130',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product"','131','(''DA''=''T|'')','ESTANDAR20Z0','7','H','01','131',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer Plan Code"','132','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','132',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Waiting Period"','133','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','133',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','134','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','134',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Selected Amount"','135','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','135',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Class Name"','136','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','136',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','137','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','137',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','138','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','138',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Policy"','139','(''DA''=''T|'')','ESTANDAR20Z0','12','H','01','139',NULL,'OTHER Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Plan"','140','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','140',NULL,'OTHER Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Product"','141','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','141',NULL,'OTHER Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Employer Plan Code"','142','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','142',NULL,'OTHER Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Benefit Waiting Period"','143','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','143',NULL,'OTHER Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Benefit Percent"','144','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','144',NULL,'OTHER Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Selected Amount"','145','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','145',NULL,'OTHER Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER AM Class"','146','(''DA''=''T|'')','ESTANDAR20Z0','14','H','01','146',NULL,'OTHER AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Class Name"','147','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','147',NULL,'OTHER Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Effective Date"','148','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','148',NULL,'OTHER Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER Termination Date"','149','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','149',NULL,'OTHER Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NJ TDB Policy"','150','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','150',NULL,'NJ TDB Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NJ TDB Plan"','151','(''DA''=''T|'')','ESTANDAR20Z0','11','H','01','151',NULL,'NJ TDB Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NJ TDB Employer Plan Code"','152','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','152',NULL,'NJ TDB Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NJ TDB Policy Begin Date"','153','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','153',NULL,'NJ TDB Policy Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NY DBL Policy"','154','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','154',NULL,'NY DBL Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NY DBL Plan"','155','(''DA''=''T|'')','ESTANDAR20Z0','11','H','01','155',NULL,'NY DBL Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NY DBL Employer Plan Code"','156','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','156',NULL,'NY DBL Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NY DBL Policy Begin Date"','157','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','157',NULL,'NY DBL Policy Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Policy"','158','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','158',NULL,'Basic Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Plan"','159','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','159',NULL,'Basic Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Product"','160','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','160',NULL,'Basic Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Amount"','161','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','161',NULL,'Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Class Name"','162','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','162',NULL,'Basic Life Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life User Specific"','163','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','163',NULL,'Basic Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Effective Date"','164','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','164',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic Life Termination Date"','165','(''DA''=''T|'')','ESTANDAR20Z0','27','H','01','165',NULL,'Basic Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Policy"','166','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','166',NULL,'Basic AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Plan"','167','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','167',NULL,'Basic AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Product"','168','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','168',NULL,'Basic AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Amount"','169','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','169',NULL,'Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D User Specific"','170','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','170',NULL,'Basic AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Effective Date"','171','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','171',NULL,'Basic AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Basic AD&D Termination Date"','172','(''DA''=''T|'')','ESTANDAR20Z0','27','H','01','172',NULL,'Basic AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Policy"','173','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','173',NULL,'Additional Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Plan"','174','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','174',NULL,'Additional Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Product"','175','(''DA''=''T|'')','ESTANDAR20Z0','23','H','01','175',NULL,'Additional Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Amount"','176','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','176',NULL,'Additional Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Earnings Multiplier"','177','(''DA''=''T|'')','ESTANDAR20Z0','35','H','01','177',NULL,'Additional Life Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Tobacco User"','178','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','178',NULL,'Additional Life Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life User Specific"','179','(''DA''=''T|'')','ESTANDAR20Z0','29','H','01','179',NULL,'Additional Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Effective Date"','180','(''DA''=''T|'')','ESTANDAR20Z0','30','H','01','180',NULL,'Additional Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional Life Termination Date"','181','(''DA''=''T|'')','ESTANDAR20Z0','32','H','01','181',NULL,'Additional Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D Policy"','182','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','182',NULL,'Additional AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D Plan"','183','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','183',NULL,'Additional AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D Product"','184','(''DA''=''T|'')','ESTANDAR20Z0','23','H','01','184',NULL,'Additional AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D Amount"','185','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','185',NULL,'Additional AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D Class Name"','186','(''DA''=''T|'')','ESTANDAR20Z0','26','H','01','186',NULL,'Additional AD&D Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D User Specific"','187','(''DA''=''T|'')','ESTANDAR20Z0','29','H','01','187',NULL,'Additional AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D Effective Date"','188','(''DA''=''T|'')','ESTANDAR20Z0','30','H','01','188',NULL,'Additional AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Additional AD&D Termination Date"','189','(''DA''=''T|'')','ESTANDAR20Z0','32','H','01','189',NULL,'Additional AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life Policy"','190','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','190',NULL,'Spouse Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life Plan"','191','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','191',NULL,'Spouse Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life Product"','192','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','192',NULL,'Spouse Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life Amount"','193','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','193',NULL,'Spouse Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life Tobacco User"','194','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','194',NULL,'Spouse Life Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Date of Birth"','195','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','195',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life User Specific"','196','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','196',NULL,'Spouse Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life Effective Date"','197','(''DA''=''T|'')','ESTANDAR20Z0','26','H','01','197',NULL,'Spouse Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Life Termination Date"','198','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','198',NULL,'Spouse Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse AD&D Policy"','199','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','199',NULL,'Spouse AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse AD&D Plan"','200','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','200',NULL,'Spouse AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse AD&D Product"','201','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','201',NULL,'Spouse AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse AD&D Amount"','202','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','202',NULL,'Spouse AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Date of Birth"','203','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','203',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse AD&D User Specific"','204','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','204',NULL,'Spouse AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse AD&D Effective Date"','205','(''DA''=''T|'')','ESTANDAR20Z0','26','H','01','205',NULL,'Spouse AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse AD&D Termination Date"','206','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','206',NULL,'Spouse AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Life Policy"','207','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','207',NULL,'Child Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Life Plan"','208','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','208',NULL,'Child Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Life Product"','209','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','209',NULL,'Child Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Life Amount"','210','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','210',NULL,'Child Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Life User Specific"','211','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','211',NULL,'Child Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Life Effective Date"','212','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','212',NULL,'Child Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child Life Termination Date"','213','(''DA''=''T|'')','ESTANDAR20Z0','27','H','01','213',NULL,'Child Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child AD&D Policy"','214','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','214',NULL,'Child AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child AD&D Plan"','215','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','215',NULL,'Child AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child AD&D Product"','216','(''DA''=''T|'')','ESTANDAR20Z0','18','H','01','216',NULL,'Child AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child AD&D Amount"','217','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','217',NULL,'Child AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child AD&D User Specific"','218','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','218',NULL,'Child AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child AD&D Effective Date"','219','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','219',NULL,'Child AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Child AD&D Termination Date"','220','(''DA''=''T|'')','ESTANDAR20Z0','27','H','01','220',NULL,'Child AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Policy"','221','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','221',NULL,'StandAlone AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Plan"','222','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','222',NULL,'StandAlone AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Product"','223','(''DA''=''T|'')','ESTANDAR20Z0','23','H','01','223',NULL,'StandAlone AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Amount"','224','(''DA''=''T|'')','ESTANDAR20Z0','22','H','01','224',NULL,'StandAlone AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Earnings Multiplier"','225','(''DA''=''T|'')','ESTANDAR20Z0','35','H','01','225',NULL,'StandAlone AD&D Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Tobacco User"','226','(''DA''=''T|'')','ESTANDAR20Z0','28','H','01','226',NULL,'StandAlone AD&D Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Date of Birth (SP only)"','227','(''DA''=''T|'')','ESTANDAR20Z0','39','H','01','227',NULL,'StandAlone AD&D Date of Birth (SP only)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D User Specific"','228','(''DA''=''T|'')','ESTANDAR20Z0','29','H','01','228',NULL,'StandAlone AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Effective Date"','229','(''DA''=''T|'')','ESTANDAR20Z0','30','H','01','229',NULL,'StandAlone AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StandAlone AD&D Termination Date"','230','(''DA''=''T|'')','ESTANDAR20Z0','32','H','01','230',NULL,'StandAlone AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Policy"','231','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','231',NULL,'OTHER LIFE 2 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Plan"','232','(''DA''=''T|'')','ESTANDAR20Z0','17','H','01','232',NULL,'OTHER LIFE 2 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Product"','233','(''DA''=''T|'')','ESTANDAR20Z0','20','H','01','233',NULL,'OTHER LIFE 2 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Amount"','234','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','234',NULL,'OTHER LIFE 2 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Earnings Multiplier"','235','(''DA''=''T|'')','ESTANDAR20Z0','32','H','01','235',NULL,'OTHER LIFE 2 Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Tobacco User"','236','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','236',NULL,'OTHER LIFE 2 Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Date of Birth (SP only)"','237','(''DA''=''T|'')','ESTANDAR20Z0','36','H','01','237',NULL,'OTHER LIFE 2 Date of Birth (SP only)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 User Specific"','238','(''DA''=''T|'')','ESTANDAR20Z0','26','H','01','238',NULL,'OTHER LIFE 2 User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Effective Date"','239','(''DA''=''T|'')','ESTANDAR20Z0','27','H','01','239',NULL,'OTHER LIFE 2 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OTHER LIFE 2 Termination Date"','240','(''DA''=''T|'')','ESTANDAR20Z0','29','H','01','240',NULL,'OTHER LIFE 2 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Federal Allowances Claimed"','241','(''DA''=''T|'')','ESTANDAR20Z0','26','H','01','241',NULL,'Federal Allowances Claimed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Federal Additional Amount"','242','(''DA''=''T|'')','ESTANDAR20Z0','25','H','01','242',NULL,'Federal Additional Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Federal Claimed Exemptions"','243','(''DA''=''T|'')','ESTANDAR20Z0','26','H','01','243',NULL,'Federal Claimed Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Federal Filing Status"','244','(''DA''=''T|'')','ESTANDAR20Z0','21','H','01','244',NULL,'Federal Filing Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tax State"','245','(''DA''=''T|'')','ESTANDAR20Z0','9','H','01','245',NULL,'Tax State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Allowances Claimed"','246','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','246',NULL,'State Allowances Claimed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Additional Amount"','247','(''DA''=''T|'')','ESTANDAR20Z0','23','H','01','247',NULL,'State Additional Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Claimed Exemptions"','248','(''DA''=''T|'')','ESTANDAR20Z0','24','H','01','248',NULL,'State Claimed Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State Filing Status"','249','(''DA''=''T|'')','ESTANDAR20Z0','19','H','01','249',NULL,'State Filing Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','250','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','250',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan "','251','(''DA''=''T|'')','ESTANDAR20Z0','5','H','01','251',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product "','252','(''DA''=''T|'')','ESTANDAR20Z0','8','H','01','252',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Amount"','253','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','253',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Multiplier"','254','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','254',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','255','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','255',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Type"','256','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','256',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific"','257','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','257',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Application Date"','258','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','258',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','259','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','259',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan "','260','(''DA''=''T|'')','ESTANDAR20Z0','5','H','01','260',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product "','261','(''DA''=''T|'')','ESTANDAR20Z0','8','H','01','261',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Amount"','262','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','262',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Multiplier"','263','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','263',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','264','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','264',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Type"','265','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','265',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific"','266','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','266',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Application Date"','267','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','267',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','268','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','268',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan "','269','(''DA''=''T|'')','ESTANDAR20Z0','5','H','01','269',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product "','270','(''DA''=''T|'')','ESTANDAR20Z0','8','H','01','270',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Amount"','271','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','271',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Multiplier"','272','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','272',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','273','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','273',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Type"','274','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','274',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific"','275','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','275',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Application Date"','276','(''DA''=''T|'')','ESTANDAR20Z0','16','H','01','276',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy"','277','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','277',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan "','278','(''DA''=''T|'')','ESTANDAR20Z0','5','H','01','278',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Product "','279','(''DA''=''T|'')','ESTANDAR20Z0','8','H','01','279',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Amount"','280','(''DA''=''T|'')','ESTANDAR20Z0','6','H','01','280',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Multiplier"','281','(''DA''=''T|'')','ESTANDAR20Z0','10','H','01','281',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Percent"','282','(''DA''=''T|'')','ESTANDAR20Z0','15','H','01','282',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Type"','283','(''DA''=''T|'')','ESTANDAR20Z0','4','H','01','283',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"User Specific"','284','(''DA''=''T|'')','ESTANDAR20Z0','13','H','01','284',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Application Date"','285','(''DA''=''T'')','ESTANDAR20Z0','16','H','01','285',NULL,'Application Date',NULL,NULL);
-- JCB
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrganizationIDCode"','1','(''UA''=''T|'')','ESTANDAR20Z0','8','D','10','1',NULL,'Organization ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','2',NULL,'Sub Org Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T|'')','ESTANDAR20Z0','9','D','10','3',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''T|'')','ESTANDAR20Z0','20','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','5',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','6','(''UA''=''T|'')','ESTANDAR20Z0','40','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','7','(''UA''=''T|'')','ESTANDAR20Z0','40','D','10','7',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','8','(''UA''=''T|'')','ESTANDAR20Z0','40','D','10','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','9','(''UA''=''T|'')','ESTANDAR20Z0','10','D','10','9',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','10','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofDeath"','11','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','11',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T|'')','ESTANDAR20Z0','1','D','10','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''T|'')','ESTANDAR20Z0','16','D','10','13',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','14','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','14',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','15','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','15',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','16',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','17','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateProvince"','18','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','18',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','19','(''UA''=''T|'')','ESTANDAR20Z0','20','D','10','19',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','20','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonWorkPhone"','21','(''UA''=''T|'')','ESTANDAR20Z0','15','D','10','21',NULL,'Non-Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentHireDate"','22','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','22',NULL,'Current Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','23','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','23',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedHireDate"','24','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','24',NULL,'Adjusted Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentTerminationDate"','25','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','25',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','26','(''UA''=''T|'')','ESTANDAR20Z0','2','D','10','26',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','27','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','27',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','28','(''UA''=''T|'')','ESTANDAR20Z0','26','D','10','28',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledWorkHours"','29','(''UNT0''=''T|'')','ESTANDAR20Z0','8','D','10','29',NULL,'Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSchWorkHoursFrequency"','30','(''UA''=''T|'')','ESTANDAR20Z0','12','D','10','30',NULL,'Scheduled Work Hours Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayType"','31','(''UA''=''T|'')','ESTANDAR20Z0','11','D','10','31',NULL,'Employee Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullPartTime"','32','(''UA''=''T|'')','ESTANDAR20Z0','9','D','10','32',NULL,'Full/Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','33','(''UA''=''T|'')','ESTANDAR20Z0','9','D','10','33',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','34','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','34',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','35','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','35',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','36','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','36',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','37',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','38',NULL,'Employer Affiliate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','39',NULL,'Employer Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','40',NULL,'Employer Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentCode"','41','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','41',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartmentName"','42','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','42',NULL,'Department Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','43','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','43',NULL,'Occupation code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserSpecific1"','44','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','44',NULL,'User Specific 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserSpecific2"','45','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','45',NULL,'User Specific 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','46','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','46',NULL,'User Specific 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','47','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','47',NULL,'User Specific 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','48','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','48',NULL,'User Specific 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningCategory1"','49','(''UA''=''T|'')','ESTANDAR20Z0','9','D','10','49',NULL,'Earning Category 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsType1"','50','(''UA''=''T|'')','ESTANDAR20Z0','18','D','10','50',NULL,'Earnings Type 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmount1"','51','(''UA''=''T|'')','ESTANDAR20Z0','13','D','10','51',NULL,'Earnings Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmtExp1"','52','(''UA''=''T|'')','ESTANDAR20Z0','22','D','10','52',NULL,'Earnings Amount Expression 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsEffectiveDate1"','53','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','53',NULL,'Earnings Effective Date 1 OR Earnings Pay Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','54','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','54',NULL,'Payroll Frequency 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','55','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','55',NULL,'Pay Start Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','56','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','56',NULL,'Pay End Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','57','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','57',NULL,'Pay Period Hours 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','58','(''SS''=''T|'')','ESTANDAR20Z0','9','D','10','58',NULL,'Earning Category 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','59','(''SS''=''T|'')','ESTANDAR20Z0','18','D','10','59',NULL,'Earnings Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','60','(''SS''=''T|'')','ESTANDAR20Z0','13','D','10','60',NULL,'Earnings Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','61','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','61',NULL,'Earnings Amount Expression 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','62','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','62',NULL,'Earnings Effective Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','63','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','63',NULL,'Payroll Frequency 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','64','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','64',NULL,'Pay Start Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','65','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','65',NULL,'Pay End Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','66','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','66',NULL,'Pay Period Hours 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','67','(''SS''=''T|'')','ESTANDAR20Z0','9','D','10','67',NULL,'Earning Category 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','68','(''SS''=''T|'')','ESTANDAR20Z0','18','D','10','68',NULL,'Earnings Type 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','69','(''SS''=''T|'')','ESTANDAR20Z0','13','D','10','69',NULL,'Earnings Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','70','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','70',NULL,'Earnings Amount Expression 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','71','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','71',NULL,'Earnings Effective Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','72','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','72',NULL,'Payroll Frequency 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','73','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','73',NULL,'Pay Start Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','74','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','74',NULL,'Pay End Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','75','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','75',NULL,'Pay Period Hours 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked12Mnths"','76','(''UNT0''=''T|'')','ESTANDAR20Z0','8','D','10','76',NULL,'Hours Worked in the Last 12 months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked12MnthTHRUDATE"','77','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','77',NULL,'Hours Worked in the Last 12 Months THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupervisorNum"','78','(''UA''=''T|'')','ESTANDAR20Z0','20','D','10','78',NULL,'Supervisor/Manager Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','79','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','79',NULL,'Future use field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMSReportingGroup1"','80','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','80',NULL,'AMS Reporting Group 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMSReportingGroup2"','81','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','81',NULL,'AMS Reporting Group 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMSReportingGroup3"','82','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','82',NULL,'AMS Reporting Group 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMSReportingGroup4"','83','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','83',NULL,'AMS Reporting Group 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMSReportingGroup5"','84','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','84',NULL,'AMS Reporting Group 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMSReportingGroup6"','85','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','85',NULL,'AMS Reporting Group 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMSReportingGroup7"','86','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','86',NULL,'AMS Reporting Group 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','87','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','87',NULL,'AMS Reporting Group 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','88','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','88',NULL,'AMS Reporting Group 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRContactRecipient"','89','(''UA''=''T|'')','ESTANDAR20Z0','50','D','10','89',NULL,'HR Contact Recipient',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRContactEmailAddress"','90','(''UA''=''T|'')','ESTANDAR20Z0','100','D','10','90',NULL,'HR Contact Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHRContactWorkPhone"','91','(''UA''=''T|'')','ESTANDAR20Z0','15','D','10','91',NULL,'HR Contact Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','92','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','92',NULL,'Reporting Category 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','93','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','93',NULL,'Reporting Category 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','94','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','94',NULL,'Reporting Category 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','95','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','95',NULL,'Reporting Category 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','96','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','96',NULL,'Reporting Category 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','97','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','97',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan"','98','(''UA''=''T|'')','ESTANDAR20Z0','1','D','10','98',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct"','99','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','99',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','100','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','100',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','101','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','101',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPercent"','102','(''UA''=''T|'')','ESTANDAR20Z0','20','D','10','102',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','103','(''SS''=''T|'')','ESTANDAR20Z0','13','D','10','103',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','104','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','104',NULL,'Am Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','105','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','105',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','106','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','106',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','107','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','107',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','108','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','108',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','109','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','109',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','110','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','110',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','111','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','111',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','112','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','112',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','113','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','113',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','114','(''SS''=''T|'')','ESTANDAR20Z0','13','D','10','114',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','115','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','115',NULL,'Am Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','116','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','116',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','117','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','117',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','118','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','118',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy1"','119','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','119',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan1"','120','(''UA''=''T|'')','ESTANDAR20Z0','1','D','10','120',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct1"','121','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','121',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','122','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','122',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','123','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','123',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPercent1"','124','(''UA''=''T|'')','ESTANDAR20Z0','20','D','10','124',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','125','(''SS''=''T|'')','ESTANDAR20Z0','13','D','10','125',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','126','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','126',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate1"','127','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','127',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate1"','128','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','128',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','129','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','129',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','130','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','130',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','131','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','131',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','132','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','132',NULL,'Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','133','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','133',NULL,'Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','134','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','134',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','135','(''SS''=''T|'')','ESTANDAR20Z0','13','D','10','135',NULL,'Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','136','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','136',NULL,'Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','137','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','137',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','138','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','138',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','139','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','139',NULL,'OTHER Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','140','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','140',NULL,'OTHER Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','141','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','141',NULL,'OTHER Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','142','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','142',NULL,'OTHER Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','143','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','143',NULL,'OTHER Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','144','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','144',NULL,'OTHER Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','145','(''SS''=''T|'')','ESTANDAR20Z0','13','D','10','145',NULL,'OTHER Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','146','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','146',NULL,'OTHER AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','147','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','147',NULL,'OTHER Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','148','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','148',NULL,'OTHER Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','149','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','149',NULL,'OTHER Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','150','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','150',NULL,'NJ TDB Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','151','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','151',NULL,'NJ TDB Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','152','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','152',NULL,'NJ TDB Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','153','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','153',NULL,'NJ TDB Policy Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','154','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','154',NULL,'NY DBL Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','155','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','155',NULL,'NY DBL Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','156','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','156',NULL,'NY DBL Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','157','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','157',NULL,'NY DBL Policy Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifePolicy"','158','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','158',NULL,'Basic Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifePlan"','159','(''UA''=''T|'')','ESTANDAR20Z0','2','D','10','159',NULL,'Basic Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeProduct"','160','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','160',NULL,'Basic Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeAmount"','161','(''UA''=''T|'')','ESTANDAR20Z0','10','D','10','161',NULL,'Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','162','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','162',NULL,'Basic Life Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','163','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','163',NULL,'Basic Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeEffectiveDate"','164','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','164',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeTerminationDate"','165','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','165',NULL,'Basic Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDPolicy"','166','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','166',NULL,'Basic AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDPlan"','167','(''UA''=''T|'')','ESTANDAR20Z0','2','D','10','167',NULL,'Basic AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDProduct"','168','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','168',NULL,'Basic AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDAmount"','169','(''UA''=''T|'')','ESTANDAR20Z0','10','D','10','169',NULL,'Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','170','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','170',NULL,'Basic AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDEffectiveDate"','171','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','171',NULL,'Basic AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicADDTerminationDate"','172','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','172',NULL,'Basic AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifePolicy"','173','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','173',NULL,'Additional Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifePlan"','174','(''UA''=''T|'')','ESTANDAR20Z0','2','D','10','174',NULL,'Additional Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifeProduct"','175','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','175',NULL,'Additional Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifeAmount"','176','(''UA''=''T|'')','ESTANDAR20Z0','10','D','10','176',NULL,'Additional Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','177','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','177',NULL,'Additional Life Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','178','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','178',NULL,'Additional Life Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','179','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','179',NULL,'Additional Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifeEffDate"','180','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','180',NULL,'Additional Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifeTermDate"','181','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','181',NULL,'Additional Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','182','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','182',NULL,'Additional AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','183','(''SS''=''T|'')','ESTANDAR20Z0','2','D','10','183',NULL,'Additional AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','184','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','184',NULL,'Additional AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','185','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','185',NULL,'Additional AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','186','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','186',NULL,'Additional AD&D Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','187','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','187',NULL,'Additional AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','188','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','188',NULL,'Additional AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','189','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','189',NULL,'Additional AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifePolicy"','190','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','190',NULL,'Spouse Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifePlan"','191','(''UA''=''T|'')','ESTANDAR20Z0','2','D','10','191',NULL,'Spouse Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeProduct"','192','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','192',NULL,'Spouse Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeAmount"','193','(''UA''=''T|'')','ESTANDAR20Z0','10','D','10','193',NULL,'Spouse Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','194','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','194',NULL,'Spouse Life Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','195','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','195',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','196','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','196',NULL,'Spouse Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeEffDate"','197','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','197',NULL,'Spouse Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeTermDate"','198','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','198',NULL,'Spouse Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','199','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','199',NULL,'Spouse AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','200','(''SS''=''T|'')','ESTANDAR20Z0','2','D','10','200',NULL,'Spouse AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','201','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','201',NULL,'Spouse AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','202','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','202',NULL,'Spouse AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','203','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','203',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','204','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','204',NULL,'Spouse AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','205','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','205',NULL,'Spouse AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','206','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','206',NULL,'Spouse AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildLifePolicy"','207','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','207',NULL,'Child Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildLifePlan"','208','(''UA''=''T|'')','ESTANDAR20Z0','2','D','10','208',NULL,'Child Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildLifeProduct"','209','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','209',NULL,'Child Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildLifeAmount"','210','(''UA''=''T|'')','ESTANDAR20Z0','10','D','10','210',NULL,'Child Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','211','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','211',NULL,'Child Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildLifeEffDate"','212','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','212',NULL,'Child Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChildLifeTermDate"','213','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','213',NULL,'Child Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','214','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','214',NULL,'Child AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','215','(''SS''=''T|'')','ESTANDAR20Z0','2','D','10','215',NULL,'Child AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','216','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','216',NULL,'Child AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','217','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','217',NULL,'Child AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','218','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','218',NULL,'Child AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','219','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','219',NULL,'Child AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','220','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','220',NULL,'Child AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandAloneADDPolicy"','221','(''UA''=''T|'')','ESTANDAR20Z0','6','D','10','221',NULL,'StandAlone AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandAloneADDPlan"','222','(''UA''=''T|'')','ESTANDAR20Z0','2','D','10','222',NULL,'StandAlone AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandAloneADDProduct"','223','(''UA''=''T|'')','ESTANDAR20Z0','4','D','10','223',NULL,'StandAlone AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandAloneADDAmount"','224','(''UA''=''T|'')','ESTANDAR20Z0','10','D','10','224',NULL,'StandAlone AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','225','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','225',NULL,'StandAlone AD&D Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','226','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','226',NULL,'StandAlone AD&D Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','227','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','227',NULL,'StandAlone AD&D Date of Birth (SP only)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','228','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','228',NULL,'StandAlone AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandAloneADDEffDate"','229','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','229',NULL,'StandAlone AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStandAloneADDTermDate"','230','(''UD112''=''T|'')','ESTANDAR20Z0','8','D','10','230',NULL,'StandAlone AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','231','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','231',NULL,'OTHER LIFE 2 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','232','(''SS''=''T|'')','ESTANDAR20Z0','2','D','10','232',NULL,'OTHER LIFE 2 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','233','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','233',NULL,'OTHER LIFE 2 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','234','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','234',NULL,'OTHER LIFE 2 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','235','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','235',NULL,'OTHER LIFE 2 Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','236','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','236',NULL,'OTHER LIFE 2 Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','237','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','237',NULL,'OTHER LIFE 2 Date of Birth (SP only)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','238','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','238',NULL,'OTHER LIFE 2 User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','239','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','239',NULL,'OTHER LIFE 2 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','240','(''SS''=''T|'')','ESTANDAR20Z0','8','D','10','240',NULL,'OTHER LIFE 2 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','241','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','241',NULL,'Federal Allowances Claimed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','242','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','242',NULL,'Federal Additional Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','243','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','243',NULL,'Federal Claimed Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','244','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','244',NULL,'Federal Filing Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''SS''=''T|'')','ESTANDAR20Z0','2','D','10','245',NULL,'Tax State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','246',NULL,'State Allowances Claimed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','247',NULL,'State Additional Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','248',NULL,'State Claimed Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','249',NULL,'State Filing Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','250','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','250',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','251','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','251',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','252','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','252',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','253','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','253',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','254','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','254',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','255','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','255',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','256','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','256',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','257','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','257',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','258','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','258',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','259','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','259',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','260','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','260',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','261','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','261',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','262','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','262',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','263','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','263',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','264','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','264',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','265','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','265',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','266','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','266',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','267','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','267',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','268',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','269','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','269',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','270','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','270',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','271','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','271',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','272','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','272',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','273','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','273',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','274',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','275',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','276',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''SS''=''T|'')','ESTANDAR20Z0','6','D','10','277',NULL,'Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','278',NULL,'Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''SS''=''T|'')','ESTANDAR20Z0','4','D','10','279',NULL,'Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','280',NULL,'Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''SS''=''T|'')','ESTANDAR20Z0','10','D','10','281',NULL,'Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''SS''=''T|'')','ESTANDAR20Z0','20','D','10','282',NULL,'Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','283','(''SS''=''T|'')','ESTANDAR20Z0','1','D','10','283',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','284','(''SS''=''T|'')','ESTANDAR20Z0','50','D','10','284',NULL,'User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''SS''=''T'')','ESTANDAR20Z0','20','D','10','285',NULL,'Application Date',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202011289','EMPEXPORT','OEACTIVE',NULL,'ESTANDAR2',NULL,NULL,NULL,'202011289','Nov 28 2020  6:51AM','Nov 28 2020  6:51AM','202011281',NULL,'','','202011281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202101019','EMPEXPORT','OEPASSIVE','Dec 29 2020 12:35PM','ESTANDAR2',NULL,NULL,NULL,'202101019','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202101011','2532','','','202101011',dbo.fn_GetTimedKey(),NULL,'RBONOAN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The Standard Export','202102149','EMPEXPORT','ONDEMAND','Feb 15 2021 10:33AM','ESTANDAR2',NULL,NULL,NULL,'202102149','Feb 14 2021 12:00AM','Dec 30 1899 12:00AM','202101011','2626','','','202101011',dbo.fn_GetTimedKey(),NULL,'RBONOAN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202110249','EMPEXPORT','SCHEDULED','Oct 24 2021 10:30PM','ESTANDAR2',NULL,NULL,NULL,'202110249','Jan 10 2021 12:00AM','Dec 30 1899 12:00AM','202110171','2562','','','202110171',dbo.fn_GetTimedKey(),NULL,'RBONOAN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202107181','EMPEXPORT','TEST','Jul 23 2021  9:09AM','ESTANDAR2',NULL,NULL,NULL,'202107181','Jul 18 2021 12:00AM','Dec 30 1899 12:00AM','202107111','2577','','','202107111',dbo.fn_GetTimedKey(),NULL,'RBONOAN',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','ExportPath','V','\\us.saas\n0\data_exchange\SWE1003\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','TestPath','V','\\us.saas\n2\Public\SWE1003\Exports\Standard\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','UDESPath','C','\\us.saas\n0\data_exchange\SWE1003\Exports\');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDAR2','UseFileName','V','N');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_ESTANDAR2_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_ESTANDAR2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTANDAR2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTANDAR2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTANDAR2','D10','dbo.U_ESTANDAR2_D10',NULL);
IF OBJECT_ID('U_ESTANDAR2_Audit') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL
);
IF OBJECT_ID('U_ESTANDAR2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ESTANDAR2_D10') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_D10] (
    [drvEEID] char(12) NULL,
    [drvCOID] char(5) NULL,
    [drvOrganizationIDCode] varchar(8) NOT NULL,
    [drvSubOrgText] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleName] varchar(50) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvDateofBirth] datetime NULL,
    [drvDateofDeath] datetime NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvStateProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvNonWorkPhone] varchar(50) NULL,
    [drvCurrentHireDate] datetime NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvAdjustedHireDate] datetime NULL,
    [drvEmploymentTerminationDate] datetime NULL,
    [drvWorkState] varchar(2) NULL,
    [drvJobTitle] varchar(150) NULL,
    [drvEmploymentStatus] varchar(25) NOT NULL,
    [drvScheduledWorkHours] decimal NULL,
    [drvSchWorkHoursFrequency] varchar(6) NOT NULL,
    [drvEmployeePayType] varchar(6) NOT NULL,
    [drvFullPartTime] varchar(9) NOT NULL,
    [drvEmploymentType] varchar(7) NOT NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvDepartmentCode] char(10) NULL,
    [drvDepartmentName] varchar(25) NULL,
    [drvUserSpecific1] varchar(40) NULL,
    [drvUserSpecific2] char(8) NULL,
    [drvEarningCategory1] varchar(9) NOT NULL,
    [drvEarningsType1] varchar(9) NOT NULL,
    [drvEarningsAmount1] varchar(20) NULL,
    [drvEarningsAmtExp1] varchar(6) NOT NULL,
    [drvEarningsEffectiveDate1] datetime NULL,
    [drvHoursWorked12Mnths] decimal NOT NULL,
    [drvHoursWorked12MnthTHRUDATE] datetime NOT NULL,
    [drvSupervisorNum] char(9) NOT NULL,
    [drvAMSReportingGroup1] char(1) NULL,
    [drvAMSReportingGroup2] varchar(50) NOT NULL,
    [drvAMSReportingGroup3] varchar(11) NOT NULL,
    [drvAMSReportingGroup4] varchar(40) NULL,
    [drvAMSReportingGroup5] char(5) NULL,
    [drvAMSReportingGroup6] varchar(1) NOT NULL,
    [drvAMSReportingGroup7] varchar(1) NOT NULL,
    [drvHRContactRecipient] varchar(11) NOT NULL,
    [drvHRContactEmailAddress] varchar(25) NOT NULL,
    [drvHRContactWorkPhone] varchar(10) NOT NULL,
    [drvPolicy] varchar(6) NULL,
    [drvPlan] varchar(1) NULL,
    [drvProduct] varchar(2) NULL,
    [drvBenefitPercent] varchar(3) NOT NULL,
    [drvEffectiveDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvPolicy1] varchar(6) NULL,
    [drvPlan1] varchar(1) NULL,
    [drvProduct1] varchar(2) NULL,
    [drvBenefitPercent1] varchar(2) NOT NULL,
    [drvEffectiveDate1] datetime NULL,
    [drvTerminationDate1] datetime NULL,
    [drvBasicLifePolicy] varchar(6) NULL,
    [drvBasicLifePlan] varchar(1) NULL,
    [drvBasicLifeProduct] varchar(2) NULL,
    [drvBasicLifeAmount] varchar(30) NULL,
    [drvBasicLifeEffectiveDate] datetime NULL,
    [drvBasicLifeTerminationDate] datetime NULL,
    [drvBasicADDPolicy] varchar(6) NULL,
    [drvBasicADDPlan] varchar(1) NULL,
    [drvBasicADDProduct] varchar(2) NULL,
    [drvBasicADDAmount] varchar(30) NULL,
    [drvBasicADDEffectiveDate] datetime NULL,
    [drvBasicADDTerminationDate] datetime NULL,
    [drvAdditionalLifePolicy] varchar(6) NULL,
    [drvAdditionalLifePlan] varchar(1) NULL,
    [drvAdditionalLifeProduct] varchar(2) NULL,
    [drvAdditionalLifeAmount] varchar(30) NULL,
    [drvAdditionalLifeEffDate] datetime NULL,
    [drvAdditionalLifeTermDate] datetime NULL,
    [drvSpouseLifePolicy] varchar(6) NULL,
    [drvSpouseLifePlan] varchar(1) NULL,
    [drvSpouseLifeProduct] varchar(3) NULL,
    [drvSpouseLifeAmount] varchar(30) NULL,
    [drvSpouseLifeEffDate] datetime NULL,
    [drvSpouseLifeTermDate] datetime NULL,
    [drvChildLifePolicy] varchar(6) NULL,
    [drvChildLifePlan] varchar(1) NULL,
    [drvChildLifeProduct] varchar(3) NULL,
    [drvChildLifeAmount] varchar(8) NULL,
    [drvChildLifeEffDate] datetime NULL,
    [drvChildLifeTermDate] datetime NULL,
    [drvStandAloneADDPolicy] varchar(6) NULL,
    [drvStandAloneADDPlan] varchar(1) NULL,
    [drvStandAloneADDProduct] varchar(3) NULL,
    [drvStandAloneADDAmount] varchar(30) NULL,
    [drvStandAloneADDEffDate] datetime NULL,
    [drvStandAloneADDTermDate] datetime NULL,
    [drvInitialSort] char(9) NULL
);
IF OBJECT_ID('U_ESTANDAR2_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESTANDAR2_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESTANDAR2_EmpAge') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_EmpAge] (
    [drvEmployeeSSN] char(11) NULL,
    [Gender] char(1) NULL,
    [IsSmoker] varchar(1) NULL,
    [Age] int NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL
);
IF OBJECT_ID('U_ESTANDAR2_File') IS NULL
CREATE TABLE [dbo].[U_ESTANDAR2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANDAR2]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Swedish Covenant Hospital

Created By: Sai Kiran Gandu (COM4 Global)
Business Analyst: Bridget Amsden
Create Date: 10/29/2020
Service Request Number: 2020-00282672

Purpose: The Standard Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTANDAR2';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTANDAR2';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTANDAR2';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ESTANDAR2';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTANDAR2' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTANDAR2';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESTANDAR2', @AllObjects = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE @FormatCode     VARCHAR(10)
        ,@ExportCode        VARCHAR(10)
        ,@StartDate         DATETIME
        ,@EndDate           DATETIME
        ,@StartPerControl   VARCHAR(9)
        ,@EndPerControl     VARCHAR(9);

    -- Declare dates from Parameter file
    SELECT
        @StartPerControl  = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'ESTANDAR2';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESTANDAR2_EEList WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID);

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_ESTANDAR2_AuditFields') IS NOT NULL
    DROP TABLE dbo.U_ESTANDAR2_AuditFields;
    CREATE TABLE dbo.U_ESTANDAR2_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_ESTANDAR2_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_ESTANDAR2_Audit') IS NOT NULL
        DROP TABLE dbo.U_ESTANDAR2_Audit;
    SELECT 
        audEEID = audKey1Value
        ,audCOID = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
    INTO dbo.U_ESTANDAR2_Audit
    FROM dbo.U_ESTANDAR2_EEList WITH (NOLOCK)
    JOIN dbo.U_ESTANDAR2_AuditFields WITH (NOLOCK) 
        ON 1 = 1
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
        AND audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';

    --==========================================
    -- BDM Section                                
    --========================================== 
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','LFE1X,LFE2X,LFX4X,LFP4X,LFP3X,ADPHY,SLEE1,SLEE2,SLEX1,SLEX2,SLSPS,SLCHL,SLADE,SLADF,SLTD4,SLTD6,GRLTD,STDHR,STDSL,STDPH');  
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','StopDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES(@FormatCode,'AllowMultiDedType', 'N');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RelationshipsChild','CHA,CHL,STC');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'RelationshipsDomPartner','PAR'); 

    -- Required OE parameters
    IF @ExportCode LIKE '%ACTIVE%'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');  
    END;

    If @exportcode like '%PASSIVE%' 
    BEGIN
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE')
    END

    -- Run BDM Module
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;
    
    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    ---------------------------------
    -- DETAIL RECORD - U_ESTANDAR2_D10
    ---------------------------------
    IF OBJECT_ID('U_ESTANDAR2_D10') IS NOT NULL
        DROP TABLE dbo.U_ESTANDAR2_D10;
    SELECT DISTINCT
         drvEEID                        = xEEID 
        ,drvCOID                        = xCOID
        ,drvOrganizationIDCode          = '10149659'
        ,drvSubOrgText                  = ''
        ,drvSSN                         = EepSSN
        ,drvEmployeeID                  = EecEmpNo
        ,drvFirstName                   = EepNameFirst
        ,drvMiddleName                  = ISNULL(LTRIM(RTRIM(EepNameMiddle)),'')
        ,drvLastName                    = EepNameLast
        ,drvNameSuffix                  = CASE WHEN ISNULL(LTRIM(RTRIM(NULLIF(EepNameSuffix,'Z'))),'') > '' 
                                                THEN LTRIM(RTRIM(EepNameSuffix)) ELSE '' END 
        ,drvDateofBirth                 = EepDateOfBirth
        ,drvDateofDeath                 = CASE WHEN EecTermReason = '203' 
                                                THEN COALESCE(EepDateDeceased,EecDateOfTermination) 
                                                ELSE NULLIF('',SPACE(0)) END 
        ,drvGender                      = CASE EepGender WHEN 'M' THEN 'M'
                                                         WHEN 'F' THEN 'F'  
                                                         ELSE 'U' END 
        ,drvAddressLine1                = EepAddressLine1
        ,drvAddressLine2                = ISNULL(LTRIM(RTRIM(EepAddressLine2)),'')
        ,drvCity                        = EepAddressCity
        ,drvStateProvince               = EepAddressState
        ,drvPostalCode                  = EepAddressZipCode
        ,drvCountry                     = EepAddressCountry
        ,drvNonWorkPhone                = CASE WHEN ISNULL(LTRIM(RTRIM(EepPhoneHomeNumber)),'') > '' THEN EepPhoneHomeNumber 
                                                ELSE ISNULL((SELECT TOP 1 EfoPhoneNumber FROM dbo.EmpMPhon WITH (NOLOCK)
                                                                 WHERE EfoPhoneType='CEL' AND EfoEEID = EecEEID),'')  END 
        ,drvCurrentHireDate             = NULLIF(EecDateOfLastHire,SPACE(0))
        ,drvOriginalHireDate            = EecDateOfOriginalHire
        ,drvAdjustedHireDate            = EecDateofSeniority
        ,drvEmploymentTerminationDate   = CASE WHEN EecEmplStatus = 'T' THEN NULLIF(EecDateOfTermination,SPACE(0)) 
                                                ELSE NULLIF('',SPACE(0)) END
        ,drvWorkState                   = SUBSTRING(EecStateSUI,1,2)  
        ,drvJobTitle                    = JbcLongDesc            
        ,drvEmploymentStatus            = CASE WHEN EecEmplStatus= 'S' THEN 'Suspended'
                                                 WHEN EecEmplStatus= 'R' THEN 'Retired'
                                                 WHEN EecEmplStatus= 'T' THEN
                                                    CASE WHEN EecTermReason = '203' THEN 'Deceased' 
                                                         WHEN EecTermReason = '202' THEN 'Retired' 
                                                         ELSE 'Terminated' END 
                                                 WHEN EecEmplStatus= 'L'THEN
                                                    CASE WHEN LchFMLAQualified = 'Y' THEN 'Leave of Absence FMLA' 
                                                         WHEN EecLeaveReason  = '300' THEN 'Leave of Absence Military' 
                                                         ELSE 'Leave of Absence' END 
                                                ELSE 'Active' END  
        ,drvScheduledWorkHours          = CASE WHEN EecScheduledAnnualHrs = 0 THEN '1.00' ELSE (EecScheduledAnnualHrs/52) END
        ,drvSchWorkHoursFrequency       = 'Weekly'
        ,drvEmployeePayType             = CASE WHEN EecSalaryOrHourly = 'H' THEN 'Hourly' ELSE 'Salary' END 
        ,drvFullPartTime                =  CASE WHEN  EecFullTimeOrPartTime = 'F' THEN 'Full Time' ELSE 'Part Time' END
        ,drvEmploymentType              = 'Regular'
        ,drvWorkEmailAddress            = EepAddressEmail
        ,drvDepartmentCode              = EecOrgLvl2
        ,drvDepartmentName              = OrgDesc 
        ,drvUserSpecific1               = CmpCompanyName
        ,drvUserSpecific2               = EecJobCode
        ,drvEarningCategory1            = 'Scheduled' 
        ,drvEarningsType1               = 'Base Rate'
        ,drvEarningsAmount1             = CASE WHEN ISNULL(EecAnnSalary,0.00)>0 THEN CONVERT(VARCHAR(20),CAST(EecAnnSalary AS DECIMAL(18,2)))
                                                ELSE '' END 
        ,drvEarningsAmtExp1             = CASE WHEN ISNULL(EecAnnSalary,0.00)>0 THEN 'Annual' ELSE '' END 
        ,drvEarningsEffectiveDate1      = CASE WHEN ISNULL(EecAnnSalary,0.00)>0 THEN 
                                                 ISNULL((SELECT TOP 1 MAX(EjhJobEffDate) FROM dbo.EmpHJob WITH (NOLOCK) 
                                                    WHERE EjhCOID = EecCOID AND EjhEEID = EecEEID AND EjhIsRateChange = 'Y' 
                                                    AND EjhJobEffDate <= @EndDate),EecDateOfLasthire) 
                                                    ELSE NULLIF('',SPACE(0)) END
        ,drvHoursWorked12Mnths           = isnull((select TOP 1 sum(PehCurhrs) from PayReg as P with(nolock) 
                                                     join iPEarHist as ER with (nolock)  
                                                    ON  P.PrgGenNumber  = ER.PehGenNumber and P.Prgpaydate between dateadd(year,-1,@EndDate) and @EndDate
                                                    WHERE prgcoid = xCOID and prgeeid = xEEID
                                                    AND ER.PehInclInTotalHoursWorked ='Y'),0) 
        ,drvHoursWorked12MnthTHRUDATE    = GETDATE()
        ,drvSupervisorNum                = ISNULL((SELECT TOP 1 SUP.EecEmpno FROM dbo.EmpComp SUP WITH (NOLOCK)
                                                     WHERE SUP.EecEEID = EmpComp.EecSuperVisorID),'')
        ,drvAMSReportingGroup1           = EecIsKeyEmployee
        ,drvAMSReportingGroup2           = ISNULL((SELECT TOP 1 SUPE.EepAddressEmail FROM dbo.Emppers SUPE WITH (NOLOCK) 
                                                    JOIN dbo.EmpComp SUP WITH (NOLOCK) ON SUPE.EepEEID = SUP.EecEEID  
                                                    WHERE SUP.EecEEID = EmpComp.EecSuperVisorID),'')
        ,drvAMSReportingGroup3           = CASE WHEN JbcIsSuperVisor = 'Y' THEN 'Manager' ELSE 'Non-Manager' END   
        ,drvAMSReportingGroup4           = CmpCompanyName
        ,drvAMSReportingGroup5           = CmpCompanyCode
        ,drvAMSReportingGroup6           = 'N'
        ,drvAMSReportingGroup7           = 'N'
        ,drvHRContactRecipient           = 'HR Services'
        ,drvHRContactEmailAddress        = 'HRServices@northshore.org'
        ,drvHRContactWorkPhone           = '8475705111'
-----
        ,drvPolicy                       = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN '758191' END
        ,drvPlan                         = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN 'A' END
        ,drvProduct                      = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN 'ST' END
        ,drvBenefitPercent               = CASE WHEN ISNULL(A.EedEEID,'') <> '' AND A.EedDedCode = 'STDHR' THEN '60'
                                               WHEN A.EedDedCode IN ('STDSL','STDPH') THEN '100' 
                                               ELSE '' END  
        ,drvEffectiveDate                = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN NULLIF(A.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvTerminationDate              = CASE WHEN ISNULL(A.EedEEID,'') <> '' THEN NULLIF(A.EedBenStopDate,SPACE(0))  ELSE NULLIF('',SPACE(0)) END 
-----
        ,drvPolicy1                      = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN '758190' END
        ,drvPlan1                        = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN 'B' END
        ,drvProduct1                     = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN 'LT' END
        ,drvBenefitPercent1              = CASE WHEN ISNULL(B.EedEEID,'') <> '' AND B.EedDedCode = 'SLTD4' THEN '40'
                                               WHEN B.EedDedCode IN ('SLTD6','GRLTD') THEN '60'  
                                               ELSE '' END 
        ,drvEffectiveDate1               = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN NULLIF(B.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvTerminationDate1             = CASE WHEN ISNULL(B.EedEEID,'') <> '' THEN NULLIF(B.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 

-----

        ,drvBasicLifePolicy              = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN '758190' END
        ,drvBasicLifePlan                = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN 'A' END
        ,drvBasicLifeProduct             = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN 'BL' END
        ,drvBasicLifeAmount              = CASE WHEN ISNULL(C.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = C.EedDedCode),'')     
                                           END 
          
        ,drvBasicLifeEffectiveDate       = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN NULLIF(C.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvBasicLifeTerminationDate     = CASE WHEN ISNULL(C.EedEEID,'') <> '' THEN NULLIF(C.EedBenStopDate,SPACE(0))  ELSE NULLIF('',SPACE(0)) END 

-----

        ,drvBasicADDPolicy               = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN '758190' END
        ,drvBasicADDPlan                 = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN 'A' END
        ,drvBasicADDProduct              = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN 'BA' END
        ,drvBasicADDAmount               = CASE WHEN ISNULL(D.EedEEID,'') <> '' 
                                                THEN CASE WHEN ISNULL((SELECT TOP 1 BcaBenAmtCalc FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = D.EedEEID 
                                                                and bcacoid = D.EedCOID 
                                                                and bcaDedCode = D.EedDedCode),0.00)>800000 THEN '800000.00'
                                                           ELSE
                                                           ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = D.EedEEID 
                                                                and bcacoid = D.EedCOID 
                                                                and bcaDedCode = D.EedDedCode),'')
                                                     END 
                                            END
        ,drvBasicADDEffectiveDate        = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN NULLIF(D.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvBasicADDTerminationDate      = CASE WHEN ISNULL(D.EedEEID,'') <> '' THEN NULLIF(D.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 

-----

        ,drvAdditionalLifePolicy         = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN '758190' END
        ,drvAdditionalLifePlan           = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN 'A' END
        ,drvAdditionalLifeProduct        = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN 'AL' END
        ,drvAdditionalLifeAmount         = CASE WHEN ISNULL(E.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = E.EedDedCode),'')     
                                           END 
        ,drvAdditionalLifeEffDate        = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN NULLIF(E.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvAdditionalLifeTermDate       = CASE WHEN ISNULL(E.EedEEID,'') <> '' THEN NULLIF(E.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 

-----

        ,drvSpouseLifePolicy             = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN '758190' END
        ,drvSpouseLifePlan               = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN 'A' END
        ,drvSpouseLifeProduct            = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN 'XSL' END
        ,drvSpouseLifeAmount             = CASE WHEN ISNULL(F.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = F.EedDedCode),'')     
                                           END 
        ,drvSpouseLifeEffDate            = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN NULLIF(F.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 
        ,drvSpouseLifeTermDate           = CASE WHEN ISNULL(F.EedEEID,'') <> '' THEN NULLIF(F.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END 

-----

        ,drvChildLifePolicy              = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN '758190' END
        ,drvChildLifePlan                = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN 'A' END
        ,drvChildLifeProduct             = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN 'XCL' END
        ,drvChildLifeAmount              = CASE G.EedbenOption 
                                                WHEN 'C02' THEN '2000.00'
                                                WHEN 'C04' THEN '4000.00'
                                                WHEN 'C06' THEN '6000.00'
                                                WHEN 'C08' THEN '8000.00'
                                                WHEN 'C10' THEN '10000.00'
                                            END          
        ,drvChildLifeEffDate             = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN NULLIF(G.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END
        ,drvChildLifeTermDate            = CASE WHEN ISNULL(G.EedEEID,'') <> '' THEN NULLIF(G.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END

-----

        ,drvStandAloneADDPolicy          = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN '758190' END
        ,drvStandAloneADDPlan            = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN 'C' END
        ,drvStandAloneADDProduct         = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN
                                                CASE WHEN H.EedDedCode = 'SLADE' THEN 'SA' 
                                                     WHEN H.EedDedCode = 'SLADF' THEN 'SAF' 
                                                     ELSE ''
                                                END
                                            END  
        ,drvStandAloneADDAmount          =  CASE WHEN ISNULL(H.EedEEID,'') <> '' 
                                                THEN ISNULL((SELECT TOP 1 CONVERT(VARCHAR,BcaBenAmtCalc) FROM dbo.u_dsi_bdm_BenCalculationAmounts 
                                                                WHERE bcaeeid = xEEID
                                                                and bcacoid = xCOID
                                                                and bcaDedCode = H.EedDedCode),'')     
                                           END 
        ,drvStandAloneADDEffDate         = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN NULLIF(H.EedBenStartDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END
        ,drvStandAloneADDTermDate        = CASE WHEN ISNULL(H.EedEEID,'') <> '' THEN NULLIF(H.EedBenStopDate,SPACE(0)) ELSE NULLIF('',SPACE(0)) END
        ,drvInitialSort = EecEmpno
    INTO dbo.U_ESTANDAR2_D10
    FROM dbo.U_ESTANDAR2_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS A WITH (NOLOCK)
        ON A.EedEEID = xEEID 
        AND A.EedCoID = xCoID
        AND A.EedFormatCode = @FormatCode 
        AND A.EedValidForExport = 'Y'
        AND A.EedDedCode IN ('STDHR','STDSL','STDPH') 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS B WITH (NOLOCK)
        ON B.EedEEID = xEEID 
        AND B.EedCoID = xCoID
        AND B.EedFormatCode = @FormatCode 
        AND B.EedValidForExport = 'Y'
        AND B.EedDedCode IN ('SLTD4','SLTD6','GRLTD') 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS C WITH (NOLOCK)
        ON C.EedEEID = xEEID 
        AND C.EedCoID = xCoID
        AND C.EedFormatCode = @FormatCode 
        AND C.EedValidForExport = 'Y'
        AND C.EedDedCode IN ('LFE1X','LFE2X','LFX4X','LFP4X','LFP3X') 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS D WITH (NOLOCK)
        ON D.EedEEID = xEEID 
        AND D.EedCoID = xCoID
        AND D.EedFormatCode = @FormatCode 
        AND D.EedValidForExport = 'Y'
        AND D.EedDedCode IN ('LFE1X','LFE2X','LFX4X','LFP4X','ADPHY') 
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS E WITH (NOLOCK)
        ON E.EedEEID = xEEID 
        AND E.EedCoID = xCoID
        AND E.EedFormatCode = @FormatCode 
        AND E.EedValidForExport = 'Y'
        AND E.EedDedCode IN ('SLEE1','SLEE2','SLEX1','SLEX2')  
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS F WITH (NOLOCK)
        ON F.EedEEID = xEEID 
        AND F.EedCoID = xCoID
        AND F.EedFormatCode = @FormatCode 
        AND F.EedValidForExport = 'Y'
        AND F.EedDedCode = 'SLSPS'
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS G WITH (NOLOCK)
        ON G.EedEEID = xEEID 
        AND G.EedCoID = xCoID
        AND G.EedFormatCode = @FormatCode 
        AND G.EedValidForExport = 'Y'
        AND G.EedDedCode = 'SLCHL'
    LEFT JOIN dbo.U_dsi_bdm_EmpDeductions AS H WITH (NOLOCK)
        ON H.EedEEID = xEEID 
        AND H.EedCoID = xCoID
        AND H.EedFormatCode = @FormatCode 
        AND H.EedValidForExport = 'Y'
        AND H.EedDedCode IN ('SLADE','SLADF')
    LEFT JOIN dbo.Company WITH (NOLOCK)
        ON CmpCOID = xCOID
    LEFT JOIN dbo.JobCode WITH (NOLOCK)
        ON EecJobCode = JbcJobCode
    LEFT JOIN dbo.LoaReasn WITH (NOLOCK)
        ON LchCode = EecLeaveReason 
    LEFT JOIN dbo.OrgLevel WITH (NOLOCK) 
        ON OrgCode = EecOrgLvl2 
        AND OrgLvl = '2'
    WHERE (EecEmplStatus <> 'T' OR (EecEmplStatus= 'T' AND EecTermReason  NOT IN ('TRO','TRI')
              AND EXISTS (SELECT TOP 1 1 FROM dbo.U_ESTANDAR2_Audit AS aud WITH (NOLOCK)
                            WHERE aud.audCOID = xCOID AND aud.audEEID= xEEID AND aud.audFieldName = 'EecEmplStatus' 
             AND ISNULL(aud.audOldValue,' ') <> aud.audNewValue  AND aud.audNewValue ='T'))
             AND EecDateOfTermination >= @EndDate-60)
;
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('ESTANDAR2','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'northshoreuniversity_10149659_2_'+CONVERT(VARCHAR(10),GETDATE(),112)+REPLACE(CONVERT(VARCHAR(5),GETDATE(),108),':','')+'.txt'
            WHERE FormatCode = 'ESTANDAR2';
    END
    END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESTANDAR2_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTANDAR2_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDAR2', 'SCHEDULED';

SELECT * FROM U_ESTANDAR2_D10 ORDER BY drvEmployeeID

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTANDAR2%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202010021'
       ,ExpStartPerControl     = '202010021'
       ,ExpLastEndPerControl   = '202010099'
       ,ExpEndPerControl       = '202010099'
WHERE ExpFormatCode = 'ESTANDAR2';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTANDAR2_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTANDAR2_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort