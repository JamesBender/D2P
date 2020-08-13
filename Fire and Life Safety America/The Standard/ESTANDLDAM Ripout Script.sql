SET NOCOUNT ON;
IF OBJECT_ID('U_ESTANDLDAM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESTANDLDAM_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESTANDLDAM' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESTANDLDAM_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESTANDLDAM_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESTANDLDAM') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANDLDAM];
GO
IF OBJECT_ID('U_ESTANDLDAM_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_PEarHist];
GO
IF OBJECT_ID('U_ESTANDLDAM_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_PDedHist];
GO
IF OBJECT_ID('U_ESTANDLDAM_File') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_File];
GO
IF OBJECT_ID('U_ESTANDLDAM_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_EEList];
GO
IF OBJECT_ID('U_ESTANDLDAM_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_drvTbl];
GO
IF OBJECT_ID('U_ESTANDLDAM_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESTANDLDAM') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESTANDLDAM];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESTANDLDAM';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESTANDLDAM';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESTANDLDAM';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESTANDLDAM';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESTANDLDAM';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESTANDLDAM','The Standard Life, Disability, Absensce Mgmt','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','15000','S','N','ESTANDLDAMZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgIdCode"','1','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','1',NULL,'Organization ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','2','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','2',NULL,'Sub Org Text',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','3','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','3',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','4','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','4',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','5','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','5',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','6','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','7',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','8','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','8',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','9','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','9',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','10',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfDeath"','11','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','11',NULL,'Date of Death',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','12',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','13','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','13',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','14','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','14',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','15','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','15',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','16','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','16',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','17','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','18','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','18',NULL,'State/Province',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','19','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','19',NULL,'Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','20','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonWorkPhone"','21','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','21',NULL,'Non-Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentHireDate"','22','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','22',NULL,'Current Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','23','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','23',NULL,'Original Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','24','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','24',NULL,'Adjusted Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTermDate"','25','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','25',NULL,'Employment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','26','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','26',NULL,'Work State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','27','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','27',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployStatus"','28','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','28',NULL,'Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSchedWorkHours"','29','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','29',NULL,'Scheduled Work Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSchedWorkHoursFreq"','30','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','30',NULL,'Scheduled Work Hours Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayType"','31','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','31',NULL,'Employee Pay Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullOrPartTime"','32','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','32',NULL,'Full/Part Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentType"','33','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','33',NULL,'Employment Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmailAddress"','34','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','34',NULL,'Work Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','35','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','35',NULL,'Exempt Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','36','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','36',NULL,'Union Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','37','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','37',NULL,'Union Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','38','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','38',NULL,'Employer Affiliate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerLocationCode"','39','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','39',NULL,'Employer Location Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerLocationName"','40','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','40',NULL,'Employer Location Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','41','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','41',NULL,'Department Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','42','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','42',NULL,'Department Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','43','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','43',NULL,'Occupation Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','44','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','44',NULL,'User Specific 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','45','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','45',NULL,'User Specific 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','46','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','46',NULL,'User Specific 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','47','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','47',NULL,'User Specific 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','48','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','48',NULL,'User Specific 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningCat1"','49','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','49',NULL,'Earnings Category 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningType1"','50','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','50',NULL,'Earnings Type 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmt1"','51','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','51',NULL,'Earnings Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsAmtExp1"','52','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','52',NULL,'Earnings Amount Expression 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsEffDate1"','53','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','53',NULL,'Earnings Effective Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','54','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','54',NULL,'Pay Frequency 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','55','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','55',NULL,'Pay Start Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','56','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','56',NULL,'Pay End Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','57','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','57',NULL,'Pay Period Hours 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','58','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','58',NULL,'Earnings Category 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','59','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','59',NULL,'Earnings Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','60','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','60',NULL,'Earnings Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','61','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','61',NULL,'Earnings Amount Expression 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','62','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','62',NULL,'Earnings Effective Date 2 or Earnings Pay Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','63','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','63',NULL,'Pay Frequency 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','64','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','64',NULL,'Pay Start Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','65','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','65',NULL,'Pay End Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','66','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','66',NULL,'Pay Period Hours 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','67','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','67',NULL,'Earnings Category 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','68','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','68',NULL,'Earnings Type 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','69','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','69',NULL,'Earnings Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','70','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','70',NULL,'Earnings Amount Expression 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','71','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','71',NULL,'Earnings Effective Date 3 or Earnings Pay Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','72','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','72',NULL,'Pay Frequency 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','73','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','73',NULL,'Pay Start Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','74','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','74',NULL,'Pay End Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','75','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','75',NULL,'Pay Period Hours 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorkLast12Mon"','76','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','76',NULL,'Hours Worked in the Last 12 Months',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorkLast12MonThruDate"','77','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','77',NULL,'Hours Worked in the Last 12 Months THRU DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvManagerEmployeeID"','78','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','78',NULL,'Supervisor/Manager Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFutureUser"','79','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','79',NULL,'Future use field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','80','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','80',NULL,'AMS Reporting Group 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','81','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','81',NULL,'AMS Reporting Group 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','82','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','82',NULL,'AMS Reporting Group 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','83','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','83',NULL,'AMS Reporting Group 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','84','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','84',NULL,'AMS Reporting Group 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','85','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','85',NULL,'AMS Reporting Group 6',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','86','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','86',NULL,'AMS Reporting Group 7',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','87','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','87',NULL,'AMS Reporting Group 8',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','88','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','88',NULL,'AMS Reporting Group 9',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrContactRecipient"','89','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','89',NULL,'HR Contact Recipient',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrContactEmail"','90','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','90',NULL,'HR Contact Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','91','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','91',NULL,'HR Contact Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','92','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','92',NULL,'Reporting Category 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','93','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','93',NULL,'Reporting Category 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','94','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','94',NULL,'Reporting Category 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','95','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','95',NULL,'Reporting Category 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','96','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','96',NULL,'Reporting Category 5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStd1Policy"','97','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','97',NULL,'STD1 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStd1Plan"','98','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','98',NULL,'STD1 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStd1Product"','99','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','99',NULL,'STD1 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','100','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','100',NULL,'STD1 Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','101','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','101',NULL,'STD1 Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','102','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','102',NULL,'STD1 Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','103','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','103',NULL,'STD1 Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','104','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','104',NULL,'STD1 AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','105','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','105',NULL,'STD1 Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStd1EffectiveDate"','106','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','106',NULL,'STD1 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStd1TerminationDate"','107','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','107',NULL,'STD1 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','108','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','108',NULL,'STD2 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','109','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','109',NULL,'STD2 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','110','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','110',NULL,'STD2 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','111','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','111',NULL,'STD2 Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','112','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','112',NULL,'STD2 Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','113','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','113',NULL,'STD2 Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','114','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','114',NULL,'STD2 Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','115','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','115',NULL,'STD2 AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','116','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','116',NULL,'STD2 Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','117','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','117',NULL,'STD2 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','118','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','118',NULL,'STD2 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtd1Policy"','119','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','119',NULL,'LTD1 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtd1Plan"','120','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','120',NULL,'LTD1 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtd1Product"','121','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','121',NULL,'LTD1 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','122','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','122',NULL,'LTD1 Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','123','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','123',NULL,'LTD1 Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','124','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','124',NULL,'LTD1 Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','125','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','125',NULL,'LTD1 Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','126','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','126',NULL,'LTD1 Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtd1EffectiveDate"','127','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','127',NULL,'LTD1 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLtd1TerminationDate"','128','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','128',NULL,'LTD1 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','129','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','129',NULL,'LTD2 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','130','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','130',NULL,'LTD2 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','131','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','131',NULL,'LTD2 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','132','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','132',NULL,'LTD2 Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','133','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','133',NULL,'LTD2 Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','134','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','134',NULL,'LTD2 Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','135','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','135',NULL,'LTD2 Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','136','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','136',NULL,'LTD2 Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','137','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','137',NULL,'LTD2 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','138','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','138',NULL,'LTD2 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','139','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','139',NULL,'Other Disability 1 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','140','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','140',NULL,'Other Disability 1 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','141','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','141',NULL,'Other Disability 1 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','142','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','142',NULL,'Other Disability 1 Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','143','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','143',NULL,'Other Disability 1 Benefit Waiting Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','144','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','144',NULL,'Other Disability 1 Benefit Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','145','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','145',NULL,'Other Disability 1 Selected Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','146','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','146',NULL,'Other Disability 1 AM Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','147','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','147',NULL,'Other Disability 1 Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','148','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','148',NULL,'Other Disability 1 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','149','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','149',NULL,'Other Disability 1 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','150','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','150',NULL,'NJ TDB Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','151','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','151',NULL,'NJ TDB Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','152','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','152',NULL,'NJ TDB Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','153','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','153',NULL,'NJ TDB Policy Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','154','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','154',NULL,'NY DBL Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','155','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','155',NULL,'NY DBL Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','156','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','156',NULL,'NY DBL Employer Plan Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','157','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','157',NULL,'NY DBL Policy Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifePolicy"','158','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','158',NULL,'Basic Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifePlan"','159','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','159',NULL,'Basic Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeProduct"','160','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','160',NULL,'Basic Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','161','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','161',NULL,'Basic Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','162','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','162',NULL,'Basic Life Class Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','163','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','163',NULL,'Basic Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeEffectiveDate"','164','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','164',NULL,'Basic Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicLifeTerminationDate"','165','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','165',NULL,'Basic Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','166','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','166',NULL,'Basic AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','167','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','167',NULL,'Basic AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','168','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','168',NULL,'Basic AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','169','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','169',NULL,'Basic AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','170','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','170',NULL,'Basic AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','171','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','171',NULL,'Basic AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','172','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','172',NULL,'Basic AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifePolicy"','173','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','173',NULL,'Additional Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifePlan"','174','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','174',NULL,'Additional Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifeProduct"','175','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','175',NULL,'Additional Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','176','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','176',NULL,'Additional Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','177','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','177',NULL,'Additional Life Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','178','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','178',NULL,'Additional Life Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','179','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','179',NULL,'Additional Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifeEffDate"','180','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','180',NULL,'Additional Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdditionalLifeTermDate"','181','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','181',NULL,'Additional Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','182','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','182',NULL,'Additional AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','183','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','183',NULL,'Additional AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','184','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','184',NULL,'Additional AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','185','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','185',NULL,'Additional AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','186','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','186',NULL,'Additional AD&D Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','187','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','187',NULL,'Additional AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','188','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','188',NULL,'Additional AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','189','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','189',NULL,'Additional AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifePolicy"','190','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','190',NULL,'Spouse Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifePlan"','191','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','191',NULL,'Spouse Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeProduct"','192','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','192',NULL,'Spouse Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','193','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','193',NULL,'Spouse Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','194','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','194',NULL,'Spouse Life Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','195','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','195',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','196','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','196',NULL,'Spouse Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeEffectiveDate"','197','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','197',NULL,'Spouse Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLifeTerminationDate"','198','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','198',NULL,'Spouse Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','199','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','199',NULL,'Spouse AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','200','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','200',NULL,'Spouse AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','201','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','201',NULL,'Spouse AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','202','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','202',NULL,'Spouse AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','203','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','203',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','204','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','204',NULL,'Spouse AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','205','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','205',NULL,'Spouse AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','206','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','206',NULL,'Spouse AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','207','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','207',NULL,'Child Life Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','208','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','208',NULL,'Child Life Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','209','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','209',NULL,'Child Life Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','210','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','210',NULL,'Child Life Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','211','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','211',NULL,'Child Life User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','212','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','212',NULL,'Child Life Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','213','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','213',NULL,'Child Life Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','214','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','214',NULL,'Child AD&D Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','215','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','215',NULL,'Child AD&D Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','216','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','216',NULL,'Child AD&D Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','217','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','217',NULL,'Child AD&D Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','218','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','218',NULL,'Child AD&D User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','219','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','219',NULL,'Child AD&D Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','220','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','220',NULL,'Child AD&D Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOthLif1Policy"','221','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','221',NULL,'Other Life 1 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOthLif1Plan"','222','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','222',NULL,'Other Life 1 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOthLif1Product"','223','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','223',NULL,'Other Life 1 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','224','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','224',NULL,'Other Life 1 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','225','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','225',NULL,'Other Life 1 Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','226','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','226',NULL,'Other Life 1 Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','227','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','227',NULL,'Other Life 1 Date of Birth - Spouse only',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','228','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','228',NULL,'Other Life 1 User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOthLif1EffectiveDate"','229','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','229',NULL,'Other Life 1 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOthLif1TerminationDate"','230','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','230',NULL,'Other Life 1 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','231','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','231',NULL,'Other Life 2 Policy',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','232','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','232',NULL,'Other Life 2 Plan',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','233','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','233',NULL,'Other Life 2 Product',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','234','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','234',NULL,'Other Life 2 Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','235','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','235',NULL,'Other Life 2 Earnings Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','236','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','236',NULL,'Other Life 2 Tobacco User',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','237','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','237',NULL,'Other Life 2 Date of Birth - (Spouse only)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','238','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','238',NULL,'Other Life 2 User Specific',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','239','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','239',NULL,'Other Life 2 Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','240','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','240',NULL,'Other Life 2 Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','241','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','241',NULL,'Federal Allowances Claimed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','242','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','242',NULL,'Federal Additional Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','243','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','243',NULL,'Federal Claimed Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','244','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','244',NULL,'Federal Filing Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','245','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','245',NULL,'Tax State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','246','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','246',NULL,'State Allowances Claimed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','247','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','247',NULL,'State Additional Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','248','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','248',NULL,'State Claimed Exemptions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','249','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','249',NULL,'State Filing Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy1"','250','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','250',NULL,'Policy 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan1"','251','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','251',NULL,'Plan 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct1"','252','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','252',NULL,'Product 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount1"','253','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','253',NULL,'Amount 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMultiplier1"','254','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','254',NULL,'Multiplier 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenePct1"','255','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','255',NULL,'Benefit Percent 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvType1"','256','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','256',NULL,'Type 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserSpec1"','257','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','257',NULL,'User Specific 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppDate1"','258','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','258',NULL,'Application Date 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy2"','259','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','259',NULL,'Policy 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlan2"','260','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','260',NULL,'Plan 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct2"','261','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','261',NULL,'Product 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount2"','262','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','262',NULL,'Amount 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMultiplier2"','263','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','263',NULL,'Multiplier 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenePct2"','264','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','264',NULL,'Benefit Percent 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvType2"','265','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','265',NULL,'Type 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUserSpec2"','266','(''UA''=''T|'')','ESTANDLDAMZ0','50','D','10','266',NULL,'User Specific 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAppDate2"','267','(''UD112''=''T|'')','ESTANDLDAMZ0','50','D','10','267',NULL,'Application Date 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','268','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','268',NULL,'Policy 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','269','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','269',NULL,'Plan 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','270','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','270',NULL,'Product 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','271','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','271',NULL,'Amount 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','272','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','272',NULL,'Multiplier 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','273','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','273',NULL,'Benefit Percent 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','274','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','274',NULL,'Type 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','275','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','275',NULL,'User Specific 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','276','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','276',NULL,'Application Date 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','277','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','277',NULL,'Policy 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','278','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','278',NULL,'Plan 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','279','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','279',NULL,'Product 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','280','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','280',NULL,'Amount 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','281','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','281',NULL,'Multiplier 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','282','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','282',NULL,'Benefit Percent 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','283','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','283',NULL,'Type 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','284','(''DA''=''T|'')','ESTANDLDAMZ0','50','D','10','284',NULL,'User Specific 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','285','(''DA''=''T'')','ESTANDLDAMZ0','50','D','10','285',NULL,'Application Date 4',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTANDLDAM_20200203.txt',NULL,'','',NULL,NULL,NULL,NULL,'The Std Life, Disab, Abs Mgmt','202001279','EMPEXPORT','ONDEMAND',NULL,'ESTANDLDAM',NULL,NULL,NULL,'202001279','Jan 15 2020  3:59AM','Jan 15 2020  3:59AM','202001101',NULL,'','','202001101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTANDLDAM_20200203.txt',NULL,NULL,NULL,',WB9LR,WB9Q1',NULL,NULL,NULL,'Standard Disab FMLA-Wed 7pm','202001279','EMPEXPORT','SCHEDULED',NULL,'ESTANDLDAM',NULL,NULL,NULL,'202001279','Jan 15 2020  3:59AM','Jan 15 2020  3:59AM','202001101',NULL,'','','202001101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTANDLDAM_20200203.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202001279','EMPEXPORT','OEACTIVE',NULL,'ESTANDLDAM',NULL,NULL,NULL,'202001279','Jan 15 2020  3:59AM','Jan 15 2020  3:59AM','202001101',NULL,'','','202001101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTANDLDAM_20200203.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202001279','EMPEXPORT','OEPASSIVE',NULL,'ESTANDLDAM',NULL,NULL,NULL,'202001279','Jan 15 2020  3:59AM','Jan 15 2020  3:59AM','202001101',NULL,'','','202001101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESTANDLDAM_20200203.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202001279','EMPEXPORT','TEST','Jan 27 2020  4:32PM','ESTANDLDAM',NULL,NULL,NULL,'202001279','Jan 27 2020 12:00AM','Dec 30 1899 12:00AM','202001131','1299','','','202001131',dbo.fn_GetTimedKey(),NULL,'us3lKiFIR1046',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ESTANDLDAM_20200203.txt' END WHERE expFormatCode = 'ESTANDLDAM';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDLDAM','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDLDAM','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDLDAM','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDLDAM','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESTANDLDAM','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ESTANDLDAM' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESTANDLDAM' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ESTANDLDAM_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESTANDLDAM_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTANDLDAM','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESTANDLDAM','D10','dbo.U_ESTANDLDAM_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESTANDLDAM') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESTANDLDAM] (
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
IF OBJECT_ID('U_ESTANDLDAM_DedList') IS NULL
CREATE TABLE [dbo].[U_ESTANDLDAM_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESTANDLDAM_drvTbl') IS NULL
CREATE TABLE [dbo].[U_ESTANDLDAM_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] char(5) NULL,
    [drvOrgIdCode] varchar(8) NOT NULL,
    [drvSsn] char(11) NULL,
    [drvEmpNo] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfDeath] datetime NULL,
    [drvGender] varchar(1) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvNonWorkPhone] varchar(50) NULL,
    [drvCurrentHireDate] datetime NULL,
    [drvEmpTermDate] datetime NULL,
    [drvWorkState] varchar(255) NULL,
    [drvJobTitle] varchar(25) NOT NULL,
    [drvEmployStatus] varchar(16) NULL,
    [drvSchedWorkHours] nvarchar(4000) NULL,
    [drvSchedWorkHoursFreq] varchar(45) NULL,
    [drvEmployeePayType] varchar(6) NULL,
    [drvFullOrPartTime] varchar(9) NULL,
    [drvEmploymentType] varchar(9) NOT NULL,
    [drvWorkEmailAddress] varchar(50) NULL,
    [drvEmployerLocationCode] char(6) NULL,
    [drvEmployerLocationName] varchar(45) NULL,
    [drvEarningCat1] varchar(9) NOT NULL,
    [drvEarningType1] varchar(9) NOT NULL,
    [drvEarningsAmt1] nvarchar(4000) NULL,
    [drvEarningsAmtExp1] varchar(6) NULL,
    [drvEarningsEffDate1] datetime NULL,
    [drvHrsWorkLast12Mon] nvarchar(4000) NULL,
    [drvHrsWorkLast12MonThruDate] datetime NULL,
    [drvManagerEmployeeID] char(9) NULL,
    [drvFutureUser] varchar(1) NOT NULL,
    [drvHrContactRecipient] varchar(10) NOT NULL,
    [drvHrContactEmail] varchar(24) NOT NULL,
    [drvStd1Policy] varchar(6) NULL,
    [drvStd1Plan] varchar(1) NULL,
    [drvStd1Product] varchar(2) NULL,
    [drvStd1EffectiveDate] datetime NULL,
    [drvStd1TerminationDate] datetime NULL,
    [drvLtd1Policy] varchar(6) NULL,
    [drvLtd1Plan] varchar(1) NULL,
    [drvLtd1Product] varchar(2) NULL,
    [drvLtd1EffectiveDate] datetime NULL,
    [drvLtd1TerminationDate] datetime NULL,
    [drvBasicLifePolicy] varchar(6) NULL,
    [drvBasicLifePlan] varchar(1) NULL,
    [drvBasicLifeProduct] varchar(2) NULL,
    [drvBasicLifeEffectiveDate] datetime NULL,
    [drvBasicLifeTerminationDate] datetime NULL,
    [drvAdditionalLifePolicy] varchar(6) NULL,
    [drvAdditionalLifePlan] varchar(1) NULL,
    [drvAdditionalLifeProduct] varchar(2) NULL,
    [drvAdditionalLifeEffDate] datetime NULL,
    [drvAdditionalLifeTermDate] datetime NULL,
    [drvSpouseLifePolicy] varchar(6) NULL,
    [drvSpouseLifePlan] varchar(1) NULL,
    [drvSpouseLifeProduct] varchar(3) NULL,
    [drvSpouseLifeEffectiveDate] datetime NULL,
    [drvSpouseLifeTerminationDate] datetime NULL,
    [drvOthLif1Policy] varchar(6) NULL,
    [drvOthLif1Plan] varchar(1) NULL,
    [drvOthLif1Product] varchar(3) NULL,
    [drvOthLif1EffectiveDate] datetime NULL,
    [drvOthLif1TerminationDate] datetime NULL,
    [drvPolicy1] varchar(6) NULL,
    [drvPlan1] varchar(1) NULL,
    [drvProduct1] varchar(2) NULL,
    [drvAmount1] nvarchar(4000) NULL,
    [drvMultiplier1] varchar(1) NOT NULL,
    [drvBenePct1] varchar(1) NOT NULL,
    [drvType1] varchar(1) NULL,
    [drvUserSpec1] varchar(1) NOT NULL,
    [drvAppDate1] datetime NULL,
    [drvPolicy2] varchar(6) NULL,
    [drvPlan2] varchar(1) NULL,
    [drvProduct2] varchar(3) NULL,
    [drvAmount2] nvarchar(4000) NULL,
    [drvMultiplier2] varchar(1) NOT NULL,
    [drvBenePct2] varchar(1) NOT NULL,
    [drvType2] varchar(1) NULL,
    [drvUserSpec2] varchar(1) NOT NULL,
    [drvAppDate2] datetime NULL
);
IF OBJECT_ID('U_ESTANDLDAM_EEList') IS NULL
CREATE TABLE [dbo].[U_ESTANDLDAM_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESTANDLDAM_File') IS NULL
CREATE TABLE [dbo].[U_ESTANDLDAM_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(max) NULL
);
IF OBJECT_ID('U_ESTANDLDAM_PDedHist') IS NULL
CREATE TABLE [dbo].[U_ESTANDLDAM_PDedHist] (
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
IF OBJECT_ID('U_ESTANDLDAM_PEarHist') IS NULL
CREATE TABLE [dbo].[U_ESTANDLDAM_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESTANDLDAM]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Fire and Life Safety America

Created By: James Bender
Business Analyst: Lea King
Create Date: 12/30/2019
Service Request Number: TekP-2019-11-5-0004

Purpose: The Standard Life, Disability, Absensce Mgmt

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESTANDLDAM';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESTANDLDAM';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESTANDLDAM';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'ESTANDLDAM';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESTANDLDAM' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDLDAM', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDLDAM', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESTANDLDAM', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESTANDLDAM';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESTANDLDAM', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'ESTANDLDAM';

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
    DELETE FROM dbo.U_ESTANDLDAM_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESTANDLDAM_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_ESTANDLDAM_EEList where xEEID IN (
        select distinct eeceeid from empcomp where eecEEType IN('TES')
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'GLIFD,GLIFE,LTDER,STD,STD1,STD2,LIFEC,LIFEE,LIFES';
                   
    IF OBJECT_ID('U_ESTANDLDAM_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_ESTANDLDAM_DedList
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

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_ESTANDLDAM_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_PDedHist;
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
    INTO dbo.U_ESTANDLDAM_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_ESTANDLDAM_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESTANDLDAM_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_PEarHist;
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
    INTO dbo.U_ESTANDLDAM_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE 
    --LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    --AND PehPerControl <= @EndPerControl
    --LEFT(PehPerControl, 8) <= LEFT(@EndPerControl, 8) 
    --AND LEFT(PehPerControl, 8) > FORMAT(DATEADD(year, -1, GETDATE()), 'yyyyMMdd')
    LEFT(PehPerControl, 8) <= LEFT(@EndPerControl, 8)
    AND LEFT(PehPerControl, 8) > FORMAT(DATEADD(year, -1, GETDATE()), 'yyyyMMdd')
    AND PehEarnCode IN ('BEREV','DTDES','DTFLD','DTOFF','XTRAH','XTRAO','FSUP','XLAB','XHOFF','HHALR','HDES','HEST','HFLD','HOFF','HOFCR','HSUP','JURY','OTDES','OTFLD','OTFSP','OTOFF','OTPCW','OTUHF','OTTRN','OTTRO','OTHER','OT','LVFLD','LVOFF','REG','SLAB','SOFF','CARE','UHTRN','UHTRO','UHDES', 'UHFLD', 'VHLAB', 'VHOFF')
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_ESTANDLDAM_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_ESTANDLDAM_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESTANDLDAM_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvOrgIdCode = '10149966'
        ,drvSsn = eepSSN
        ,drvEmpNo = EecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = EepNameLast
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfDeath =    CASE WHEN EecEmplStatus = 'T' AND EecTermREason = '203' THEN EecDateOfTermination
                                WHEN ISNULL(EepDateDeceased, '') <> '' THEN EepDateDeceased
                            END
        ,drvGender = CASE WHEN ISNULL(EepGender, '') <> '' THEN EepGender ELSE 'U' END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvAddressCountry = EepAddressCountry
        ,drvNonWorkPhone = EepPhoneHomeNumber
        ,drvCurrentHireDate = EecDateOfLastHire
        ,drvEmpTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvWorkState = CASE WHEN ISNULL(LocAddressState, '') <> '' THEN LocAddressState ELSE EepAddressState END
        ,drvJobTitle = JbcDesc
        
        --
        ,drvEmployStatus =    CASE WHEN EecEmplStatus = 'A' THEN 'Active'
                                WHEN EecEmplStatus = 'T' THEN 'Terminated'
                                WHEN EecEmplStatus = 'L' THEN 'Leave of Absence'
                            END
                    
        -- (Select top 1 CodDesc from Codes WHERE CODTABLE = 'EMPLOYEESTATUS' AND CodCode = EecEmplStatus)
        ,drvSchedWorkHours = FORMAT(EecScheduledWorkHrs, '#0.00') 
        ,drvSchedWorkHoursFreq = (SELECT TOP 1 CodDesc FROM Codes WHERE CODTABLE = 'PAYFREQ' AND CodCode = PgrPayFrequency)
        ,drvEmployeePayType =    CASE EecSalaryOrHourly
                                    WHEN 'H' THEN 'Hourly'
                                    WHEN 'S' THEN 'Salary'
                                END
        ,drvFullOrPartTime =    CASE EecFullTimeOrPartTime
                                    WHEN 'F' THEN 'Full Time'
                                    WHEN 'P' THEN 'Part Time'
                                END
        ,drvEmploymentType =    CASE EecEEType
                                    WHEN 'TMP' THEN 'Temporary'
                                    WHEN 'SNL' THEN 'Seasonal'
                                    ELSE 'Regular'
                                END
        ,drvWorkEmailAddress = EepAddressEMail
        ,drvEmployerLocationCode = EecOrgLvl2
        ,drvEmployerLocationName = CASE WHEN ISNULL(EecOrgLvl2, '') <> '' THEN (Select top 1 CodDesc from Codes WHERE CODTABLE = 'LOCREPORTCATEGORY' AND CodCode = EecOrgLvl2) END
        ,drvEarningCat1 = 'Scheduled'
        ,drvEarningType1 = 'Base Rate'
        ,drvEarningsAmt1 =    CASE EecSalaryOrHourly
                                WHEN 'S' THEN FORMAT(EecAnnSalary, '#0.00')
                                WHEN 'H' THEN FORMAT(EecHourlyPayRate, '#0.00')
                            END
        ,drvEarningsAmtExp1 =    CASE EecSalaryOrHourly
                                WHEN 'S' THEN 'Annual'
                                WHEN 'H' THEN 'Hourly'
                            END
        ,drvEarningsEffDate1 = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, '01/01/2010',EecDateOfLastHire) 
        ,drvHrsWorkLast12Mon = FORMAT(PehCurHrsYtd, '#.00')
        ,drvHrsWorkLast12MonThruDate = PgrPayDate
        ,drvManagerEmployeeID = CASE WHEN ISNULL(EecEmpNo, '') <> '' THEN EecEmpNo END
        ,drvFutureUser = ''
        ,drvHrContactRecipient = 'HR Support'
        ,drvHrContactEmail = 'hrsupport@flsamerica.com'
        ,drvStd1Policy = CASE WHEN STD_Code = 'STD' OR STD1_Code = 'STD1' OR STD2_Code = 'STD2' THEN '758414' END 
        ,drvStd1Plan = CASE WHEN STD_Code = 'STD' OR STD1_Code = 'STD1' OR STD2_Code = 'STD2' THEN 'C' END
        ,drvStd1Product = CASE WHEN STD_Code = 'STD' OR STD1_Code = 'STD1' OR STD2_Code = 'STD2' THEN 'ST' END
        ,drvStd1EffectiveDate = CASE WHEN STD_Code = 'STD' THEN STD_BenStartDate 
                                    WHEN STD1_Code = 'STD1' THEN STD1_BenStartDate 
                                    WHEN STD2_Code = 'STD2' THEN STD2_BenStartDate -- JCB
                                END
        ,drvStd1TerminationDate =    CASE WHEN STD_Code = 'STD' THEN STD_BenStopDate 
                                        WHEN STD1_Code = 'STD1' THEN STD1_BenStopDate 
                                        WHEN STD2_Code = 'STD2' THEN STD2_BenStopDate 
                                    END
        ,drvLtd1Policy = CASE WHEN LTDER_Code = 'LTDER' THEN '758414' END
        ,drvLtd1Plan = CASE WHEN LTDER_Code = 'LTDER' THEN 'B' END
        ,drvLtd1Product = CASE WHEN LTDER_Code = 'LTDER' THEN 'LT' END
        ,drvLtd1EffectiveDate = CASE WHEN LTDER_Code = 'LTDER' THEN LTDER_BenStartDate END
        ,drvLtd1TerminationDate = CASE WHEN LTDER_Code = 'LTDER' THEN LTDER_BenStopDate END
        ,drvBasicLifePolicy = CASE WHEN GLIFE_Code = 'GLIFE' THEN '758414' END
        ,drvBasicLifePlan = CASE WHEN GLIFE_Code = 'GLIFE' THEN 'A' END
        ,drvBasicLifeProduct = CASE WHEN GLIFE_Code = 'GLIFE' THEN 'BL' END
        ,drvBasicLifeEffectiveDate = CASE WHEN GLIFE_Code = 'GLIFE' THEN GLIFE_BenStartDate END
        ,drvBasicLifeTerminationDate = CASE WHEN GLIFE_Code = 'GLIFE' THEN GLIFE_BenStopDate END
        ,drvAdditionalLifePolicy = CASE WHEN LIFEE_Code = 'LIFEE' THEN '758414' END
        ,drvAdditionalLifePlan = CASE WHEN LIFEE_Code = 'LIFEE' THEN 'A' END
        ,drvAdditionalLifeProduct = CASE WHEN LIFEE_Code = 'LIFEE' THEN 'AL' END
        ,drvAdditionalLifeEffDate = CASE WHEN LIFEE_Code = 'LIFEE' THEN LIFEE_BenStartDate END
        ,drvAdditionalLifeTermDate = CASE WHEN LIFEE_Code = 'LIFEE' THEN LIFEE_BenStopDate END
        ,drvSpouseLifePolicy = CASE WHEN GLIFD_Code = 'GLIFD' THEN '758414' END
        ,drvSpouseLifePlan = CASE WHEN GLIFD_Code = 'GLIFD' THEN 'A' END
        ,drvSpouseLifeProduct = CASE WHEN GLIFD_Code = 'GLIFD' THEN 'XDL' END
        ,drvSpouseLifeEffectiveDate = CASE WHEN GLIFD_Code = 'GLIFD' THEN GLIFD_BenStartDate END
        ,drvSpouseLifeTerminationDate = CASE WHEN GLIFD_Code = 'GLIFD' THEN GLIFD_BenStopDate END        
        ,drvOthLif1Policy = CASE WHEN LIFES_Code = 'LIFES' THEN '758414' END
        ,drvOthLif1Plan = CASE WHEN LIFES_Code = 'LIFES' THEN 'A' END
        ,drvOthLif1Product = CASE WHEN LIFES_Code = 'LIFES' THEN 'ASL' END
        ,drvOthLif1EffectiveDate = CASE WHEN LIFES_Code = 'LIFES' THEN LIFES_BenStartDate END
        ,drvOthLif1TerminationDate = CASE WHEN LIFES_Code = 'LIFES' THEN LIFES_BenStopDate END 
        ,drvPolicy1 = CASE WHEN LIFEE_Code = 'LIFEE' AND LIFEE_EmpDedNeedEoi = 'Y' THEN '758414' END
        ,drvPlan1 = CASE WHEN LIFEE_Code = 'LIFEE' AND LIFEE_EmpDedNeedEoi = 'Y' THEN 'A' END
        ,drvProduct1 = CASE WHEN LIFEE_Code = 'LIFEE' AND LIFEE_EmpDedNeedEoi = 'Y' THEN 'AL' END
        ,drvAmount1 = CASE WHEN LIFEE_Code = 'LIFEE' AND LIFEE_EmpDedNeedEoi = 'Y' THEN 
                            CASE WHEN LIFEE_EmpDedEoiDesiredAmt = 0 THEN FORMAT(LIFEE_EEBenAmt, '#0') 
                                ELSE FORMAT(LIFEE_EmpDedEoiDesiredAmt, '#0')
                            END
                        END
        ,drvMultiplier1 = ''
        ,drvBenePct1 = ''
        ,drvType1 =    CASE WHEN LIFEE_Code = 'LIFEE' AND LIFEE_EmpDedNeedEoi = 'Y' AND LIFEE_EmpDedEoiDesiredAmt = LIFEE_EEBenAmt THEN 'T' 
                        WHEN LIFEE_Code = 'LIFEE' AND LIFEE_EmpDedNeedEoi = 'Y' AND LIFEE_EmpDedEoiDesiredAmt <> LIFEE_EEBenAmt THEN 'P' 
                    END
        ,drvUserSpec1 = ''
        ,drvAppDate1 = CASE WHEN LIFEE_Code = 'LIFEE' AND LIFEE_EmpDedNeedEoi = 'Y' THEN LIFEE_BenStartDate END
        ,drvPolicy2 = CASE WHEN LIFES_Code = 'LIFES' AND LIFES_EmpDedNeedEoi = 'Y' THEN '758414' END 
        ,drvPlan2 = CASE WHEN LIFES_Code = 'LIFES' AND LIFES_EmpDedNeedEoi = 'Y' THEN 'A' END
        ,drvProduct2 = CASE WHEN LIFES_Code = 'LIFES' AND LIFES_EmpDedNeedEoi = 'Y' THEN 'ASL' END

        ,drvAmount2 = CASE WHEN LIFES_Code = 'LIFES' AND LIFES_EmpDedNeedEoi = 'Y' THEN


                            CASE WHEN LIFES_EmpDedEoiDesiredAmt = 0 THEN FORMAT(LIFES_EEBenAmt, '#0')
                                ELSE FORMAT(LIFES_EmpDedEoiDesiredAmt, '#0')
                            END
                        END
        ,drvMultiplier2 = ''
        ,drvBenePct2 = ''
        ,drvType2 = CASE WHEN LIFES_Code = 'LIFES' AND LIFES_EmpDedNeedEoi = 'Y' AND LIFES_EmpDedEoiDesiredAmt = LIFES_EEBenAmt THEN 'T' 
                        WHEN LIFES_Code = 'LIFES' AND LIFES_EmpDedNeedEoi = 'Y' AND LIFES_EmpDedEoiDesiredAmt <> LIFES_EEBenAmt THEN 'P' 
                    END
        ,drvUserSpec2 = ''
        ,drvAppDate2 = CASE WHEN LIFES_Code = 'LIFES' AND LIFES_EmpDedNeedEoi = 'Y' THEN LIFES_BenStartDate END
    INTO dbo.U_ESTANDLDAM_drvTbl
    FROM dbo.U_ESTANDLDAM_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    --JOIN dbo.U_dsi_BDM_ESTANDLDAM WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.PayGroup WITH (NOLOCK)
        ON PgrPayGroup = EecPayGroup
    LEFT JOIN dbo.U_ESTANDLDAM_PEarHist
        ON PehEEID = xEEID
    JOIN (SELECT BdmEEID AS CdmEEID, BdmCOID AS CdmCOID
            ,MAX(CASE WHEN BdmDedCode = 'GLIFD' THEN BdmDedCode END) as GLIFD_Code 
            ,MAX(CASE WHEN BdmDedCode = 'GLIFD' THEN BdmBenStartDate END) AS GLIFD_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIFD' THEN BdmBenStopDate END) AS GLIFD_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmDedCode END) as GLIFE_Code
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStartDate END) AS GLIFE_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'GLIFE' THEN BdmBenStopDate END) AS GLIFE_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LTDER' THEN BdmDedCode END) as LTDER_Code
            ,MAX(CASE WHEN BdmDedCode = 'LTDER' THEN BdmBenStartDate END) AS LTDER_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LTDER' THEN BdmBenStopDate END) AS LTDER_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmDedCode END) as STD_Code 
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStartDate END) AS STD_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'STD' THEN BdmBenStopDate END) AS STD_BenStopDate

            ,MAX(CASE WHEN BdmDedCode = 'STD1' THEN BdmDedCode END) as STD1_Code 
            ,MAX(CASE WHEN BdmDedCode = 'STD1' THEN BdmBenStartDate END) AS STD1_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'STD1' THEN BdmBenStopDate END) AS STD1_BenStopDate

            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmDedCode END) as STD2_Code 
            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmBenStartDate END) AS STD2_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'STD2' THEN BdmBenStopDate END) AS STD2_BenStopDate
            --,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmDedCode END) as LIFEC_Code 
            --,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStartDate END) AS LIFEC_BenStartDate
            --,MAX(CASE WHEN BdmDedCode = 'LIFEC' THEN BdmBenStopDate END) AS LIFEC_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmDedCode END) as LIFEE_Code 
            ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStartDate END) AS LIFEE_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LIFEE' THEN BdmBenStopDate END) AS LIFEE_BenStopDate
            ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmDedCode END) as LIFES_Code 
            ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStartDate END) AS LIFES_BenStartDate
            ,MAX(CASE WHEN BdmDedCode = 'LIFES' THEN BdmBenStopDate END) AS LIFES_BenStopDate
            FROM dbo.U_dsi_BDM_ESTANDLDAM WITH (NOLOCK)
            --WHERE BdmBenSTopDate IS NULL OR BdmBenStopDAte <= GETDATE()
            GROUP BY BdmEEID, BdmCOID) AS Bdm_Consolidated
        ON CdmEEID = xEEID
        AND CdmCoid = xCOID
    JOIN (SELECT EedEEID, EedCOID
            ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN EedDedCode END) AS LIFEE_EmpDedCode
            ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN EedNEEDEoi END) AS LIFEE_EmpDedNeedEoi
            ,MAX(CASE WHEN EedDedCode = 'LIFEE' THEN eedEOIDesiredAmt END) AS LIFEE_EmpDedEoiDesiredAmt
            ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN EedDedCode END) AS LIFES_EmpDedCode
            ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN EedNEEDEoi END) AS LIFES_EmpDedNeedEoi
            ,MAX(CASE WHEN EedDedCode = 'LIFES' THEN eedEOIDesiredAmt END) AS LIFES_EmpDedEoiDesiredAmt
            FROM dbo.EmpDedFull WITH (NOLOCK)
            Group By EedEEID, EedCOID) as EmpDed_Consolidated
        ON EedEEID = xEEID
        AND EedCOID = xCOID
    LEFT JOIN (
        Select EdhEEID AS EdhEEID_LIFEE, EdhCOID AS EdhCOID_LIFEE, EdhEEBenAmt as LIFEE_EEBenAmt from (
            select distinct EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt, row_number() OVER(partition by EdhEEID, EdhCOID, EdhDedCode order by EdhEffDate desc) as rn
            from EmpHDed
            where EdhDedCode IN ('LIFEE')) as T where rn = 1
    ) as EmpHDed_Consolidated_LIFEE
    ON EdhEEID_LIFEE = xEEID
    and EdhCOID_LIFEE = xCOID
    LEFT JOIN (
        Select EdhEEID  AS EdhEEID_LIFES, EdhCOID EdhCOID_LIFES, EdhEEBenAmt as LIFES_EEBenAmt from (
            select distinct EdhEEID, EdhCOID, EdhDedCode, EdhEEBenAmt, row_number() OVER(partition by EdhEEID, EdhCOID, EdhDedCode order by EdhEffDate desc) as rn
            from EmpHDed
            where EdhDedCode IN ('LIFES')) as T where rn = 1
    ) as EmpHDed_Consolidated_LIFES
    ON EdhEEID_LIFES = xEEID
    and EdhCOID_LIFES = xCOID

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
ALTER VIEW dbo.dsi_vwESTANDLDAM_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_ESTANDLDAM_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'ESTANDLDAM%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001101'
       ,expStartPerControl     = '202001101'
       ,expLastEndPerControl   = '202001279'
       ,expEndPerControl       = '202001279'
WHERE expFormatCode = 'ESTANDLDAM';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESTANDLDAM_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_ESTANDLDAM_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort