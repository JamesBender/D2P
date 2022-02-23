SET NOCOUNT ON;
IF OBJECT_ID('U_EMERCATDE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMERCATDE_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMERCATDE_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMERCATDE' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMERCATDE_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMERCATDE_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMERCATDE') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMERCATDE];
GO
IF OBJECT_ID('U_EMERCATDE_File') IS NOT NULL DROP TABLE [dbo].[U_EMERCATDE_File];
GO
IF OBJECT_ID('U_EMERCATDE_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMERCATDE_EEList];
GO
IF OBJECT_ID('U_EMERCATDE_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMERCATDE_drvTbl];
GO
IF OBJECT_ID('U_EMERCATDE_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMERCATDE_AuditFields];
GO
IF OBJECT_ID('U_EMERCATDE_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMERCATDE_Audit];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMERCATDE';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMERCATDE';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMERCATDE';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMERCATDE';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMERCATDE';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EMERCATDE','Mercer Demo Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EMERCATDE0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EffectiveDate"','1','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','1',NULL,'EffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','2','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Number"','3','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','4','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Initial"','5','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','5',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','6','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','7','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','7',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','8','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 1"','9','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','9',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address 2"','10','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','10',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','11','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','12','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','13','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','14','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','14',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Telephone"','15','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','15',NULL,'Home Telephone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Office Telephone"','16','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','16',NULL,'Office Telephone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Company Email"','17','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','17',NULL,'Company Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Home Email"','18','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','18',NULL,'Home Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Original Hire Date"','19','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','19',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Latest Hire Date"','20','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','20',NULL,'Latest Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Other Date"','21','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','21',NULL,'Other Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Termination Date"','22','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','22',NULL,'Last Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Reason"','23','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','23',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status"','24','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','24',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Executive Status"','25','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','25',NULL,'Executive Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employment Status"','26','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','26',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work State"','27','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','27',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Job Title"','28','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','28',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Location"','29','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','29',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','30','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','30',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay Calendar Name"','31','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','31',NULL,'Pay Calendar Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Current Salary"','32','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','32',NULL,'Current Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Salary"','33','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','33',NULL,'Benefit Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pay"','34','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','34',NULL,'Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Scheduled Hours"','35','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','35',NULL,'Scheduled Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Wellness Indicator"','36','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','36',NULL,'Wellness Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 1"','37','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','37',NULL,'Custom Factor 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 2"','38','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','38',NULL,'Custom Factor 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 3"','39','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','39',NULL,'Custom Factor 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 4"','40','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','40',NULL,'Custom Factor 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 5"','41','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','41',NULL,'Custom Factor 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 6"','42','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','42',NULL,'Custom Factor 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 7"','43','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','43',NULL,'Custom Factor 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 8"','44','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','44',NULL,'Custom Factor 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 9"','45','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','45',NULL,'Custom Factor 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 10"','46','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','46',NULL,'Custom Factor 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 11"','47','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','47',NULL,'Custom Factor 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 12"','48','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','48',NULL,'Custom Factor 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 13"','49','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','49',NULL,'Custom Factor 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 14"','50','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','50',NULL,'Custom Factor 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Custom Factor 15"','51','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','51',NULL,'Custom Factor 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 1"','52','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','52',NULL,'Client Defined Reporting 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 2"','53','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','53',NULL,'Client Defined Reporting 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 3"','54','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','54',NULL,'Client Defined Reporting 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 4"','55','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','55',NULL,'Client Defined Reporting 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 5"','56','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','56',NULL,'Client Defined Reporting 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 6"','57','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','57',NULL,'Client Defined Reporting 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 7"','58','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','58',NULL,'Client Defined Reporting 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 8"','59','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','59',NULL,'Client Defined Reporting 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 9"','60','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','60',NULL,'Client Defined Reporting 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 10"','61','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','61',NULL,'Client Defined Reporting 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 11"','62','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','62',NULL,'Client Defined Reporting 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 12"','63','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','63',NULL,'Client Defined Reporting 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 13"','64','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','64',NULL,'Client Defined Reporting 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 14"','65','(''DA''=''T,'')','EMERCATDE0Z0','50','H','01','65',NULL,'Client Defined Reporting 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Defined Reporting 15"','66','(''DA''=''T'')','EMERCATDE0Z0','50','H','01','66',NULL,'Client Defined Reporting 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','1','(''UD101''=''T,'')','EMERCATDE0Z0','50','D','10','1',NULL,'EffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','2',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeNumber"','3','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','3',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','4','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','5','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','5',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','7','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','7',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','8','(''UD101''=''T,'')','EMERCATDE0Z0','50','D','10','8',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddresLine1"','9','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','9',NULL,'Address 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','10','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','10',NULL,'Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','11','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','11',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','12','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','12',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','13','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','13',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','14','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','14',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeTelephone"','15','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','15',NULL,'Home Telephone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficeTelephone"','16','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','16',NULL,'Office Telephone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyEmail"','17','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','17',NULL,'Company Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomeEmail"','18','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','18',NULL,'Home Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginalHireDate"','19','(''UD101''=''T,'')','EMERCATDE0Z0','50','D','10','19',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastHireDate"','20','(''UD101''=''T,'')','EMERCATDE0Z0','50','D','10','20',NULL,'Latest Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOtherDate"','21','(''UD101''=''T,'')','EMERCATDE0Z0','50','D','10','21',NULL,'Other Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastTerminationDate"','22','(''UD101''=''T,'')','EMERCATDE0Z0','50','D','10','22',NULL,'Last Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationReason"','23','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','23',NULL,'Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','24','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','24',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvExecutiveStatus"','25','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','25',NULL,'Executive Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','26','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','26',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','27','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','27',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','28','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','28',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','29','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','29',NULL,'Location',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','30','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','30',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayCalendarName"','31','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','31',NULL,'Pay Calendar Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentSalary"','32','(''UNT2''=''T,'')','EMERCATDE0Z0','50','D','10','32',NULL,'Current Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitSalary"','33','(''UNT2''=''T,'')','EMERCATDE0Z0','50','D','10','33',NULL,'Benefit Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPay"','34','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','34',NULL,'Pay',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledHours"','35','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','35',NULL,'Scheduled Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWellnesIndicator"','36','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','36',NULL,'Wellness Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor1"','37','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','37',NULL,'Custom Factor 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor2"','38','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','38',NULL,'Custom Factor 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor3"','39','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','39',NULL,'Custom Factor 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor4"','40','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','40',NULL,'Custom Factor 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor5"','41','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','41',NULL,'Custom Factor 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor6"','42','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','42',NULL,'Custom Factor 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor7"','43','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','43',NULL,'Custom Factor 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor8"','44','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','44',NULL,'Custom Factor 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor9"','45','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','45',NULL,'Custom Factor 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor10"','46','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','46',NULL,'Custom Factor 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor11"','47','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','47',NULL,'Custom Factor 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor12"','48','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','48',NULL,'Custom Factor 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor13"','49','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','49',NULL,'Custom Factor 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor14"','50','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','50',NULL,'Custom Factor 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomFactor15"','51','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','51',NULL,'Custom Factor 15',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep1"','52','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','52',NULL,'Client Defined Reporting 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep2"','53','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','53',NULL,'Client Defined Reporting 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep3"','54','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','54',NULL,'Client Defined Reporting 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep4"','55','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','55',NULL,'Client Defined Reporting 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep5"','56','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','56',NULL,'Client Defined Reporting 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep6"','57','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','57',NULL,'Client Defined Reporting 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep7"','58','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','58',NULL,'Client Defined Reporting 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep8"','59','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','59',NULL,'Client Defined Reporting 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep9"','60','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','60',NULL,'Client Defined Reporting 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep10"','61','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','61',NULL,'Client Defined Reporting 10',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep11"','62','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','62',NULL,'Client Defined Reporting 11',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep12"','63','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','63',NULL,'Client Defined Reporting 12',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep13"','64','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','64',NULL,'Client Defined Reporting 13',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep14"','65','(''UA''=''T,'')','EMERCATDE0Z0','50','D','10','65',NULL,'Client Defined Reporting 14',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDefRep15"','66','(''UA''=''T'')','EMERCATDE0Z0','50','D','10','66',NULL,'Client Defined Reporting 15',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERCATDE_20191022.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mercer Demo Export','201910019','EMPEXPORT','ONDEMAND',NULL,'EMERCATDE',NULL,NULL,NULL,'201910019','Oct  1 2019  1:07PM','Oct  1 2019  1:07PM','201910011',NULL,'','','201910011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERCATDE_20191022.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201910019','EMPEXPORT','SCHEDULED',NULL,'EMERCATDE',NULL,NULL,NULL,'201910019','Oct  1 2019  1:07PM','Oct  1 2019  1:07PM','201910011',NULL,'','','201910011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERCATDE_20191022.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201910019','EMPEXPORT','OEACTIVE',NULL,'EMERCATDE',NULL,NULL,NULL,'201910019','Oct  1 2019  1:07PM','Oct  1 2019  1:07PM','201910011',NULL,'','','201910011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERCATDE_20191022.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201910019','EMPEXPORT','OEPASSIVE',NULL,'EMERCATDE',NULL,NULL,NULL,'201910019','Oct  1 2019  1:07PM','Oct  1 2019  1:07PM','201910011',NULL,'','','201910011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERCATDE_20191022.txt',NULL,'','','P33R0,OS7EC,P33WT,ONIYH,P33VC,P33YR,PFH04',NULL,NULL,NULL,'Test Purposes Only','201910149','EMPEXPORT','TEST','Oct 22 2019  4:04PM','EMERCATDE',NULL,NULL,NULL,'201910149','Oct 14 2019 12:00AM','Dec 30 1899 12:00AM','201910011','271','','','201910011',dbo.fn_GetTimedKey(),NULL,'us3mLaLAI1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERCATDE_20191022.txt',NULL,'','','ONIYH',NULL,NULL,NULL,'FulFile','201910229','EMPEXPORT','FULLFILE','Oct 22 2019 11:39AM','EMERCATDE',NULL,NULL,NULL,'201910229','Oct 22 2019 12:00AM','Dec 30 1899 12:00AM','201910081','134','','','201910081',dbo.fn_GetTimedKey(),NULL,'us3tKiLAI1003',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMERCATDE_20191022.txt' END WHERE expFormatCode = 'EMERCATDE';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERCATDE','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERCATDE','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERCATDE','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERCATDE','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERCATDE','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMERCATDE' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMERCATDE' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMERCATDE_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMERCATDE_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERCATDE','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERCATDE','D10','dbo.U_EMERCATDE_drvTbl',NULL);
IF OBJECT_ID('U_EMERCATDE_Audit') IS NULL
CREATE TABLE [dbo].[U_EMERCATDE_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EMERCATDE_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMERCATDE_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EMERCATDE_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMERCATDE_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeNumber] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddresLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountry] varchar(3) NOT NULL,
    [drvHomeTelephone] varchar(50) NOT NULL,
    [drvOfficeTelephone] char(10) NOT NULL,
    [drvCompanyEmail] varchar(50) NULL,
    [drvHomeEmail] varchar(50) NOT NULL,
    [drvOriginalHireDate] datetime NULL,
    [drvLastHireDate] datetime NULL,
    [drvOtherDate] varchar(1) NOT NULL,
    [drvLastTerminationDate] datetime NULL,
    [drvTerminationReason] char(6) NULL,
    [drvStatus] varchar(2) NULL,
    [drvExecutiveStatus] varchar(2) NOT NULL,
    [drvEmploymentStatus] varchar(1) NOT NULL,
    [drvWorkState] varchar(255) NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvLocation] varchar(1) NOT NULL,
    [drvDivision] varchar(1) NOT NULL,
    [drvPayCalendarName] varchar(2) NOT NULL,
    [drvCurrentSalary] money NULL,
    [drvBenefitSalary] money NULL,
    [drvPay] varchar(6) NULL,
    [drvScheduledHours] varchar(1) NOT NULL,
    [drvWellnesIndicator] varchar(1) NOT NULL,
    [drvCustomFactor1] varchar(1) NOT NULL,
    [drvCustomFactor2] varchar(1) NOT NULL,
    [drvCustomFactor3] varchar(1) NOT NULL,
    [drvCustomFactor4] varchar(1) NOT NULL,
    [drvCustomFactor5] varchar(1) NOT NULL,
    [drvCustomFactor6] varchar(1) NOT NULL,
    [drvCustomFactor7] varchar(1) NOT NULL,
    [drvCustomFactor8] varchar(1) NOT NULL,
    [drvCustomFactor9] varchar(1) NOT NULL,
    [drvCustomFactor10] varchar(1) NOT NULL,
    [drvCustomFactor11] varchar(1) NOT NULL,
    [drvCustomFactor12] varchar(1) NOT NULL,
    [drvCustomFactor13] varchar(1) NOT NULL,
    [drvCustomFactor14] varchar(1) NOT NULL,
    [drvCustomFactor15] varchar(1) NOT NULL,
    [drvClientDefRep1] varchar(1) NOT NULL,
    [drvClientDefRep2] varchar(1) NOT NULL,
    [drvClientDefRep3] varchar(1) NOT NULL,
    [drvClientDefRep4] varchar(1) NOT NULL,
    [drvClientDefRep5] varchar(1) NOT NULL,
    [drvClientDefRep6] varchar(1) NOT NULL,
    [drvClientDefRep7] varchar(1) NOT NULL,
    [drvClientDefRep8] varchar(1) NOT NULL,
    [drvClientDefRep9] varchar(1) NOT NULL,
    [drvClientDefRep10] varchar(1) NOT NULL,
    [drvClientDefRep11] varchar(1) NOT NULL,
    [drvClientDefRep12] varchar(1) NOT NULL,
    [drvClientDefRep13] varchar(1) NOT NULL,
    [drvClientDefRep14] varchar(1) NOT NULL,
    [drvClientDefRep15] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EMERCATDE_EEList') IS NULL
CREATE TABLE [dbo].[U_EMERCATDE_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMERCATDE_File') IS NULL
CREATE TABLE [dbo].[U_EMERCATDE_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMERCATDE]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cattron Holdings, Inc.

Created By: Marco Lagrosa
Business Analyst: Trena King
Create Date: 10/01/2019
Service Request Number: SR-2019-00247614

Purpose: Mercer Demo Export

Revision History
----------------
Update By           Date           Request Num        Desc
Marco Lagrosa       10/16/2019     SR-2019-000XXXXX   Changes to Status,Executive status and Work State
Marco Lagrosa       10/21/2019     SR-2019-000XXXXX   Remove OUT,TMP and TES type of employee
Marco Lagrosa       10/22/2019     SR-2019-000XXXXX   Update scripts to remove # in addressline and put . as allowed


SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMERCATDE';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMERCATDE';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMERCATDE';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMERCATDE';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMERCATDE' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERCATDE', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERCATDE', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERCATDE', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERCATDE', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMERCATDE', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMERCATDE';

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
    DELETE FROM dbo.U_EMERCATDE_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMERCATDE_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --Remove TMP and TES employee
    
    DELETE FROM dbo.U_EMERCATDE_EEList where xEEID IN (
    select distinct eeceeid from empcomp where eecEEType IN('TMP','TES','OUT')
    )


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EMERCATDE_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMERCATDE_AuditFields;
    CREATE TABLE dbo.U_EMERCATDE_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EMERCATDE_AuditFields VALUES ('EmpComp','EecEmplStatus');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EMERCATDE_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMERCATDE_Audit;
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
    INTO dbo.U_EMERCATDE_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EMERCATDE_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMERCATDE_Audit ON dbo.U_EMERCATDE_Audit (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EMERCATDE_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EMERCATDE_Audit WHERE audEEID = xEEID AND audRowNo = 1);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMERCATDE_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMERCATDE_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMERCATDE_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = eepSSN
        -- standard fields above and additional driver fields below
        ,drvEffectiveDate = 
        CASE WHEN EXISTS 
            (SELECT audFieldName  from dbo.U_EMERCATDE_Audit with (NOLOCK) 
            Where audFieldName = 'EecEmplStatus' and audOldValue IS NULL and audEEID = eepEEID and audAction = 'INSERT' and audNewValue = 'A')  THEN EecDateOfOriginalHire
            WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN getdate()
            WHEN EecEmplStatus IN ('T') THEN EecDateOfTermination
            WHEN EecEmplStatus IN ('A') AND (Select Top 1 EshEmplStatus from EmpHStat where esheeid in (eepEEID) order by eshStatusStartDate desc) = 'L' THEN EecEmplStatusStartDate
            WHEN EecEmplStatus IN ('L') AND (Select Top 1 EshEmplStatus from EmpHStat where esheeid in (eepEEID) order by eshStatusStartDate desc) = 'A' THEN EecEmplStatusStartDate
        WHEN EXISTS 
        (SELECT audFieldName  from dbo.U_EMERCATDE_Audit with (NOLOCK) Where 
                audFieldName= 'EecEmplStatus' and audEEID = eepEEID)  THEN audDateTime
        ELSE getdate()
        END
        ,drvSSN = eepSSN
        ,drvEmployeeNumber = eecEmpNo
        ,drvNameFirst = RTRIM(EepNameFirst)
        ,drvNameMiddle = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvNameLast = RTRIM(EepNameLast)
        ,drvGender = EepGender
        ,drvDateOfBirth = EepDateOfBirth
        ,drvAddresLine1 = dbo.dsi_fnRemoveChars('#,/-',EepAddressLine1)
        ,drvAddressLine2 = dbo.dsi_fnRemoveChars('#,/-',EepAddressLine2)
        ,drvCity = dbo.dsi_fnRemoveChars('#,/-',EepAddressCity)
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvCountry = 'USA'
        ,drvHomeTelephone = CASE WHEN efoPhoneType = 'CEL' THEN ISNULL(efoPhoneNumber,'5555555555') ELSE '5555555555' END
        ,drvOfficeTelephone = ISNULL(EecPhoneBusinessNumber,'')
        ,drvCompanyEmail = CASE WHEN ISNULL(eepAddressEmail,'') = '' or eepAddressEmail = ''  THEN 'invalid@mercer.com' ELSE eepAddressEmail END
        ,drvHomeEmail = ISNULL(eepAddressEMailAlternate,'')
        ,drvOriginalHireDate = EecDateOfOriginalHire
        ,drvLastHireDate = EecDateOfLastHire
        ,drvOtherDate = ''
        ,drvLastTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvTerminationReason = CASE WHEN EecEmplStatus = 'T' THEN EecTermType END
        ,drvStatus = CASE WHEN EecFullTimeOrPartTime  = 'F' THEN 'FT' 
                          WHEN EecFullTimeOrPartTime  = 'P' THEN 'PT'
                     END 
        ,drvExecutiveStatus = 'NA'
        ,drvEmploymentStatus = CASE WHEN EecEmplStatus = 'A' THEN 'A'
                                    WHEN EecEmplStatus = 'T' THEN
                                     CASE WHEN EecTermReason = '203' THEN 'D'
                                                 WHEN EecTermReason IN ('202','213') THEN 'R'
                                                 ELSE 'T'
                                    END

                                WHEN EecEmplStatus in ('L') AND (Select Top 1 EshEmplStatusReason from EmpHStat where esheeid in (eepEEID) order by eshStatusStartDate desc) = '500' THEN 'L'
                                WHEN EecEmplStatus in ('L') AND (Select Top 1 EshEmplStatusReason from EmpHStat where esheeid in (eepEEID) order by eshStatusStartDate desc) <> '500' THEN 'P'
                                ELSE ''
                            END
    ,drvWorkState =  (Select Top 1 LocAddressState from Location where LocCode in (EEcLocation))
        ,drvJobTitle = ''
        ,drvLocation = ''
        ,drvDivision = ''
        ,drvPayCalendarName = CASE WHEN EecSalaryOrHourly = 'H'  THEN 'B1' 
                       ELSE 'B2'   
                  END 
        ,drvCurrentSalary = EecAnnSalary
        ,drvBenefitSalary = EecAnnSalary
        ,drvPay = CASE WHEN EecSalaryOrHourly = 'S'  THEN 'SALARY' 
                       WHEN EecSalaryOrHourly = 'H'  THEN 'HOURLY'     
                  END    
        ,drvScheduledHours = ''
        ,drvWellnesIndicator = ''
        ,drvCustomFactor1 = ''
        ,drvCustomFactor2 = ''
        ,drvCustomFactor3 = ''
        ,drvCustomFactor4 = ''
        ,drvCustomFactor5 = ''
        ,drvCustomFactor6 = ''
        ,drvCustomFactor7 = ''
        ,drvCustomFactor8 = ''
        ,drvCustomFactor9 = ''
        ,drvCustomFactor10 = ''
        ,drvCustomFactor11 = ''
        ,drvCustomFactor12 = ''
        ,drvCustomFactor13 = ''
        ,drvCustomFactor14 = ''
        ,drvCustomFactor15 = ''
        ,drvClientDefRep1 = ''
        ,drvClientDefRep2 = ''
        ,drvClientDefRep3 = ''
        ,drvClientDefRep4 = ''
        ,drvClientDefRep5 = ''
        ,drvClientDefRep6 = ''
        ,drvClientDefRep7 = ''
        ,drvClientDefRep8 = ''
        ,drvClientDefRep9 = ''
        ,drvClientDefRep10 = ''
        ,drvClientDefRep11 = ''
        ,drvClientDefRep12 = ''
        ,drvClientDefRep13 = ''
        ,drvClientDefRep14 = ''
        ,drvClientDefRep15 = ''
    INTO dbo.U_EMERCATDE_drvTbl
    FROM dbo.U_EMERCATDE_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    LEFT JOIN (Select Max(audDateTime) as audDateTime,audEEID from U_EMERCATDE_Audit where audFieldName = 'EecEmplStatus' group by audEEID)
        as Audit_EmpStatus
        ON audEEID =  xEEID 
    LEFT JOIN EmpMPhon
    on EfoEEID = xEEID
    ;


    --Delete employee whose TermDate is not in the last 12 months
    DELETE from U_EMERCATDE_drvTbl
    WHERE drvEmploymentStatus IN ('T','D','R','P') 
    --AND drvEffectiveDate < DATEADD(MM, - 12, @EndDate)

    --Delete test employee with SSN equal to 999999911,123521234,999999999
    Delete from U_EMERCATDE_drvTbl WHERE drvSSN in ('999999911','123521234','999999999','123551234')  or drvNameLast = 'Test'



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
ALTER VIEW dbo.dsi_vwEMERCATDE_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMERCATDE_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMERCATDE%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201909241'
       ,expStartPerControl     = '201909241'
       ,expLastEndPerControl   = '201910019'
       ,expEndPerControl       = '201910019'
WHERE expFormatCode = 'EMERCATDE';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMERCATDE_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMERCATDE_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort