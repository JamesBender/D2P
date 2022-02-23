SET NOCOUNT ON;
IF OBJECT_ID('U_ESARELIF2L_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESARELIF2L_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESARELIF2L_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESARELIF2L' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESARELIF2L_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESARELIF2L_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESARELIF2L') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESARELIF2L];
GO
IF OBJECT_ID('U_ESARELIF2L_File') IS NOT NULL DROP TABLE [dbo].[U_ESARELIF2L_File];
GO
IF OBJECT_ID('U_ESARELIF2L_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESARELIF2L_EEList];
GO
IF OBJECT_ID('U_ESARELIF2L_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ESARELIF2L_AuditFields];
GO
IF OBJECT_ID('U_ESARELIF2L_Audit') IS NOT NULL DROP TABLE [dbo].[U_ESARELIF2L_Audit];
GO
IF OBJECT_ID('U_dsi_ESARELIF2L_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESARELIF2L_drvTbl];
GO
IF OBJECT_ID('U_dsi_ESARELIF2L_DefComp12mo') IS NOT NULL DROP TABLE [dbo].[U_dsi_ESARELIF2L_DefComp12mo];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESARELIF2L';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESARELIF2L';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESARELIF2L';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESARELIF2L';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESARELIF2L';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ESARELIF2L','FMLA SOURCE ELIGIBILITY V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','ESARELIF2LZ0','N','Sep  8 2015  9:24AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AccountNumber"','1','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AccountName"','2','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','36',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeNumber"','3','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','71',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeSocialSecurityNumber"','4','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','106',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','5','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','141',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleInitial"','6','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','176',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','7','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','211',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomeAddress1"','8','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','246',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomeAddress2"','9','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','281',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomeCity"','10','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','316',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomeStateorProvince"','11','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','351',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomeZiporPostalCode"','12','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','386',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomeCountry"','13','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','421',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomePhoneNumber"','14','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','456',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','15','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','491',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateofBirth"','16','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','526',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PrimaryLanguage"','17','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','561',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkAddressID"','18','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','596',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkAddress1"','19','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','631',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkAddress2"','20','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','666',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkCity"','21','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','701',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkStateProvince"','22','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','736',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkZipPostalCode"','23','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','771',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkCountry"','24','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','806',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkPhoneNumber"','25','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','841',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkPhoneExtension"','26','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','876',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BusinessUnit"','27','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','911',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Organization"','28','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','946',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup1"','29','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','981',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup2"','30','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1016',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup3"','31','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1051',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup4"','32','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1086',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup5"','33','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1121',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup6"','34','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1156',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup7"','35','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1191',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeGroup8"','36','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1226',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FullTimePartTimeStatus"','37','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1261',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HireDate"','38','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1296',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AdjustedEmploymentDate"','39','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1331',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AnniversaryDate"','40','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1366',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TerminationDate"','41','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1401',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HoursWorkedPrevious12Months"','42','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1436',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"KeyEmployee"','43','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1471',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"JobTitle"','44','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1506',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkEmailAddress"','45','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1541',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ScheduledHourperWeek"','46','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1576',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ScheduledNumberofDaysperWeek"','47','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1611',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AdditionalLetterRecipientEmailAddresses"','48','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1646',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SpouseEmployedattheEmployeesAccount"','49','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1681',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SpouseEmployeeNumber"','50','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1716',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PrimaryContactEmployeeNumber"','51','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1751',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WeeklySTDEarnings"','52','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1786',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"STDEligibilityDate"','53','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1821',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LTDEligibilityDate"','54','(''DA''=''T,'')','ESARELIF2LZ0','35','H','01','1856',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccNum"','1','(''UA''=''T,'')','ESARELIF2LZ0','7','D','02','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccName"','2','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpno"','3','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','58',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvssn"','4','(''UA''=''T,'')','ESARELIF2LZ0','11','D','02','108',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamefirst"','5','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','119',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamemi"','6','(''UA''=''T,'')','ESARELIF2LZ0','1','D','02','169',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNamelast"','7','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','170',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvaddressline1"','8','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','220',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvaddressline2"','9','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','270',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvcity"','10','(''UA''=''T,'')','ESARELIF2LZ0','65','D','02','320',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''T,'')','ESARELIF2LZ0','2','D','02','385',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvzip"','12','(''UA''=''T,'')','ESARELIF2LZ0','20','D','02','387',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','13','(''UA''=''T,'')','ESARELIF2LZ0','3','D','02','407',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','14','(''UA''=''T,'')','ESARELIF2LZ0','12','D','02','410',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','15','(''UA''=''T,'')','ESARELIF2LZ0','1','D','02','422',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','16','(''UA''=''T,'')','ESARELIF2LZ0','10','D','02','423',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryLang"','17','(''UA''=''T,'')','ESARELIF2LZ0','7','D','02','433',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddID"','18','(''UA''=''T,'')','ESARELIF2LZ0','9','D','02','440',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddress1"','19','(''UA''=''T,'')','ESARELIF2LZ0','150','D','02','449',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddress2"','20','(''UA''=''T,'')','ESARELIF2LZ0','65','D','02','599',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCity"','21','(''UA''=''T,'')','ESARELIF2LZ0','65','D','02','664',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','22','(''UA''=''T,'')','ESARELIF2LZ0','2','D','02','729',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkZip"','23','(''UA''=''T,'')','ESARELIF2LZ0','20','D','02','731',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkCountry"','24','(''UA''=''T,'')','ESARELIF2LZ0','3','D','02','751',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','25','(''UA''=''T,'')','ESARELIF2LZ0','12','D','02','754',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhoneExt"','26','(''UA''=''T,'')','ESARELIF2LZ0','20','D','02','766',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBU"','27','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','786',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrg"','28','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','886',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG1"','29','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','986',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG2"','30','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','1086',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG3"','31','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','1186',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG4"','32','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','1286',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG5"','33','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','1386',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG6"','34','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','1486',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG7"','35','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','1586',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpG8"','36','(''UA''=''T,'')','ESARELIF2LZ0','100','D','02','1686',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFullTime"','37','(''UA''=''T,'')','ESARELIF2LZ0','1','D','02','1786',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','38','(''UA''=''T,'')','ESARELIF2LZ0','10','D','02','1787',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdjustedEmpDate"','39','(''UA''=''T,'')','ESARELIF2LZ0','10','D','02','1797',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnDate"','40','(''UA''=''T,'')','ESARELIF2LZ0','10','D','02','1807',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermDate"','41','(''UA''=''T,'')','ESARELIF2LZ0','10','D','02','1817',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursWorked"','42','(''UA''=''T,'')','ESARELIF2LZ0','6','D','02','1827',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmp"','43','(''UA''=''T,'')','ESARELIF2LZ0','1','D','02','1833',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','44','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','1834',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmail"','45','(''UA''=''T,'')','ESARELIF2LZ0','80','D','02','1884',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledHoursWeek"','46','(''UA''=''T,'')','ESARELIF2LZ0','6','D','02','1964',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvScheduledDaysWeek"','47','(''UA''=''T,'')','ESARELIF2LZ0','1','D','02','1970',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAdd"','48','(''UA''=''T,'')','ESARELIF2LZ0','200','D','02','1971',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEmp"','49','(''UA''=''T,'')','ESARELIF2LZ0','3','D','02','2171',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseEmpNo"','50','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','2174',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimContact"','51','(''UA''=''T,'')','ESARELIF2LZ0','50','D','02','2224',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWeekEarn"','52','(''UA''=''T,'')','ESARELIF2LZ0','8','D','02','2274',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSTDEligDate"','53','(''UA''=''T,'')','ESARELIF2LZ0','10','D','02','2282',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLTDELigDate"','54','(''UA''=''T,'')','ESARELIF2LZ0','10','D','02','2292',NULL,NULL,NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESARELIF2L_20200210.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'unlock ESARELIF2L','201509089','EMPEXPORT','ZAP',NULL,'ESARELIF2L',NULL,NULL,NULL,'201509089',NULL,NULL,'201506101',NULL,NULL,NULL,'201506101',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESARELIF2L_20200210.txt',NULL,NULL,NULL,',QTP9V,QTPGX,QTPD0,QI4C3,QTPF4',NULL,NULL,NULL,'FMLA ACTIVE OE','201912299','EMPEXPORT','ACTIVEOE','Sep  8 2015 12:00AM','ESARELIF2L',NULL,NULL,NULL,'201912299','Sep  8 2015 12:00AM','Dec 30 1899 12:00AM','201912291',NULL,'','','201912291',dbo.fn_GetTimedKey(),NULL,'ULTI_WPLBFC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESARELIF2L_20200210.txt',NULL,NULL,NULL,',W9HDU,B45YL,4J876,Z25AG,L3GAC,7XNAZ,7XMXU,AG4M8,B4608,LGIUF,GK024',NULL,NULL,NULL,'FMLA PASSIVEOE','201509089','EMPEXPORT','PASSIVEOE','Sep  8 2015 12:00AM','ESARELIF2L',NULL,NULL,NULL,'201509089','Sep  8 2015 12:00AM','Dec 30 1899 12:00AM','201509081',NULL,'','','201509081',dbo.fn_GetTimedKey(),NULL,'ULTI_WPLBFC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESARELIF2L_20200210.txt',NULL,'Null','N','QTP9V,QTPGX,QTPD0,QI4C3,QTPF4',NULL,NULL,NULL,'FMLA SOURCE ELIGIBILITY','201802219','EMPEXPORT','ESARELIF2L','Feb 21 2018  2:47AM','ESARELIF2L',NULL,NULL,NULL,'202001109','Feb 21 2018 12:00AM','Dec 30 1899 12:00AM','201912271','602','','','201802071',dbo.fn_GetTimedKey(),NULL,'ULTI_WPSARN',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ESARELIF2L_20200210.txt',NULL,'','','',NULL,NULL,NULL,'TEST','202001249','EMPEXPORT','TEST','Jan 27 2020  9:04AM','ESARELIF2L',NULL,NULL,NULL,'202001249','Jan 24 2020 12:00AM','Dec 30 1899 12:00AM','202001101','713','','','202001101',dbo.fn_GetTimedKey(),NULL,'us3lKiSAR1006',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ESARELIF2L_20200210.txt' END WHERE expFormatCode = 'ESARELIF2L';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','ExportDescription','C','FMLA SOURCE ELIGIBILITY');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','MaxFileLength','C','2345');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','SystemID','V','ASNE0H0030K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESARELIF2L','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ESARELIF2L' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESARELIF2L' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ESARELIF2L_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESARELIF2L_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESARELIF2L','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESARELIF2L','D02','dbo.U_dsi_ESARELIF2L_drvTbl',NULL);
IF OBJECT_ID('U_dsi_ESARELIF2L_DefComp12mo') IS NULL
CREATE TABLE [dbo].[U_dsi_ESARELIF2L_DefComp12mo] (
    [tmeeid] char(12) NULL,
    [tmcoid] char(5) NULL,
    [tmamt] money NULL,
    [tmhrs] decimal NULL
);
IF OBJECT_ID('U_dsi_ESARELIF2L_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ESARELIF2L_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvAccNum] varchar(6) NOT NULL,
    [drvAccName] varchar(11) NOT NULL,
    [drvEmpno] char(9) NULL,
    [drvssn] varchar(11) NULL,
    [drvNamefirst] varchar(100) NULL,
    [drvNamemi] varchar(1) NULL,
    [drvNamelast] varchar(100) NULL,
    [drvaddressline1] varchar(6000) NULL,
    [drvaddressline2] varchar(6000) NULL,
    [drvcity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvzip] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvPrimaryLang] char(2) NOT NULL,
    [drvWorkAddID] varchar(1) NOT NULL,
    [drvWorkAddress1] varchar(1) NOT NULL,
    [drvWorkAddress2] varchar(1) NOT NULL,
    [drvWorkCity] varchar(1) NOT NULL,
    [drvWorkState] char(2) NULL,
    [drvWorkZip] varchar(1) NOT NULL,
    [drvWorkCountry] varchar(3) NOT NULL,
    [drvWorkPhone] char(10) NULL,
    [drvWorkPhoneExt] char(5) NULL,
    [drvBU] char(6) NULL,
    [drvOrg] char(6) NULL,
    [drvEmpG1] varchar(10) NOT NULL,
    [drvEmpG2] varchar(6) NOT NULL,
    [drvEmpG3] varchar(9) NOT NULL,
    [drvEmpG4] char(6) NULL,
    [drvEmpG5] char(6) NULL,
    [drvEmpG6] varchar(1) NOT NULL,
    [drvEmpG7] varchar(1) NOT NULL,
    [drvEmpG8] char(6) NULL,
    [drvFullTime] char(1) NULL,
    [drvHireDate] varchar(10) NULL,
    [drvAdjustedEmpDate] varchar(10) NULL,
    [drvAnnDate] varchar(1) NOT NULL,
    [drvTermDate] varchar(10) NULL,
    [drvHoursWorked] varchar(30) NULL,
    [drvKeyEmp] char(1) NULL,
    [drvJobTitle] varchar(25) NULL,
    [drvWorkEmail] varchar(1) NOT NULL,
    [drvScheduledHoursWeek] varchar(30) NULL,
    [drvScheduledDaysWeek] varchar(1) NOT NULL,
    [drvEmailAdd] varchar(1) NOT NULL,
    [drvSpouseEmp] varchar(1) NOT NULL,
    [drvSpouseEmpNo] varchar(1) NOT NULL,
    [drvPrimContact] varchar(1) NOT NULL,
    [drvWeekEarn] varchar(12) NULL,
    [drvSTDEligDate] varchar(10) NULL,
    [drvLTDELigDate] varchar(10) NULL
);
IF OBJECT_ID('U_ESARELIF2L_Audit') IS NULL
CREATE TABLE [dbo].[U_ESARELIF2L_Audit] (
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
IF OBJECT_ID('U_ESARELIF2L_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ESARELIF2L_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_ESARELIF2L_EEList') IS NULL
CREATE TABLE [dbo].[U_ESARELIF2L_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESARELIF2L_File') IS NULL
CREATE TABLE [dbo].[U_ESARELIF2L_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_ESARELIF2L'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_ESARELIF2L','12/18/2012','P','V1.HA'
*/

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESARELIF2L]
 @systemid varchar(12) = ''
AS
Begin

/*************************************************************************************************
DRIVER TABLE SP FOR:  FMLA Source
BUILT FOR: Sarnova Inc.
ORIGINAL BUILD (V-1.0): 12/19/2017 - Hyma Akkiraju 
SAR1006-2017-00176298-Interface File

Modify:

Nkowalchuk            03/18/2019     13840975                As a one time courtesy correct logic to send exempt to salary employees and non exempt to Hourly
*************************************************************************************************/

-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9), 
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200),
        @PayDate datetime

    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

     select @PayDate = Max(pdhPayDate) from pdedhist where pdhpercontrol between @StartPerControl and @EndPerControl 

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile,
        @PayDate =  @PayDate

    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 14    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe

-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ESARELIF2L_EELIST
            from dbo.u_ESARELIF2L_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end

--BDM
-- replace EFCHFSAUOE with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

--DedList STDBC, STDBU, STD, STDC, LTD, LTDC
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','STDBC,STDBU,STD,STDC,LTD,LTDC')

IF @ExportCode NOT LIKE '%OE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)    --@EndDate - @daysstopped)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

IF @ExportCode LIKE '%OE' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'ACTIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active')    --'Active')
END

IF @ExportCode = 'PASSIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

--Adding Audit Table

IF OBJECT_ID('U_ESARELIF2L_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_ESARELIF2L_AuditFields;
    CREATE TABLE dbo.U_ESARELIF2L_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_ESARELIF2L_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_ESARELIF2L_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_ESARELIF2L_Audit;
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
    INTO dbo.U_ESARELIF2L_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_ESARELIF2L_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_ESARELIF2L_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @EndDate - 180 AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_ESARELIF2L_Audit ON dbo.U_ESARELIF2L_Audit (audKey1Value, audKey2Value);

---- Build deduction history

--if object_id('U_dsi_ESARELIF2L_DedHist') is not null
--  drop table dbo.U_dsi_ESARELIF2L_DedHist

--SELECT
--    xEEID heeid,
--    xCOID hcoid,
--    pdhdedcode hdedcode,
--    SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
--    SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt 

--    INTO dbo.U_dsi_ESARELIF2L_DedHist
--        from dbo.u_ESARELIF2L_EELIST 
--    JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
--        AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
--        AND PDHDEDCODE IN ('STD')
------        AND PDHPERCONTROL BETWEEN '20040901' and '20040924'
--        AND PDHPERCONTROL BETWEEN @StartPerControl and @EndPerControl
--    GROUP BY xEEID,xCOID,PdhDedCode

---- Build deduction history

--if object_id('U_dsi_ESARELIF2L_DedHist_YTD') is not null
--  drop table dbo.U_dsi_ESARELIF2L_DedHist_YTD

--SELECT
--    xEEID heeid,
--    xCOID hcoid,
--    pdhdedcode hdedcode,
--    SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
--    SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt 

--    INTO dbo.U_dsi_ESARELIF2L_DedHist_YTD
--        from dbo.u_ESARELIF2L_EELIST 
--    JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
--        AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
--        AND PDHDEDCODE IN ('STD','LTD','LTD2','SHLTD')
------        AND PDHPERCONTROL BETWEEN '20040901' and '20040924'
--        AND PDHPERCONTROL BETWEEN substring(@StartPerControl,1,4) and substring(@EndPerControl,1,4)
--    GROUP BY xEEID,xCOID,PdhDedCode

---- Step20 Clean up eelist if needed to only include employees with deductions
--            delete dbo.u_ESARELIF2L_eelist
--            from dbo.u_ESARELIF2L_eelist a
--            where not exists(select 1 from U_dsi_bdm_EmpDeductions
--                            where a.xeeid = eedeeid
--                            and a.xcoid = eedcoid
--                            and eedformatcode = @formatcode
--                            and eedvalidforexport = 'Y')

---- Clean up eelist if only one record per employee
--if @onerecperemp = 'Y'
--begin
--            delete dbo.u_ESARELIF2L_EELIST
--            from dbo.u_ESARELIF2L_EELIST
--            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
--            where t.eecemplstatus = 'T'
--            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
--                and a.eecemplstatus <> 'T')

--            delete dbo.u_ESARELIF2L_eelist
--            from dbo.u_ESARELIF2L_eelist a
--            join emppers with (nolock) on xeeid = eepeeid
--            where eephomecoid <> xcoid
--            and exists(select 1 from dbo.u_ESARELIF2L_eelist b where a.xeeid = b.xeeid
--            having count(*) > 1)
--end

--Clean up Terms from Deductions and EEList
        --delete U_dsi_bdm_EmpDeductions
        --    from U_dsi_bdm_EmpDeductions left join empcomp on eedeeid = eeceeid
        --where eedFormatCode = @FormatCode
        --    and eedValidForExport = 'Y'
        --    and eecDateofTermination is not null
        --    and @daysstopped + eecDateofTermination < getdate()

        --delete dbo.u_ESARELIF2L_eelist
        --    from dbo.u_ESARELIF2L_eelist left join empcomp on xeeid = eeceeid and xcoid = eeccoid
        --where eecDateofTermination is not null
        --    and @daysstopped + eecDateofTermination < getdate()

-- Compensation last 12 months - 2/2/15
if object_id('U_dsi_ESARELIF2L_DefComp12mo') is not null
  drop table dbo.U_dsi_ESARELIF2L_DefComp12mo

SELECT
    xEEID tmeeid,
    xCOID tmcoid,
    SUM(ISNULL(pehCurAmt,0.00)) AS tmamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS tmhrs

    INTO dbo.U_dsi_ESARELIF2L_DefComp12mo
        from dbo.u_ESARELIF2L_EELIST 
    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
        and PehPayDate >= @EndDate - 365
    ---    and PehEarnCode in ('REG','OT')
    GROUP BY xEEID,xCOID

-- Populate Source for Employees

if object_id('U_dsi_ESARELIF2L_drvTbl') is not null
  drop table dbo.U_dsi_ESARELIF2L_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below

--select * from empcomp

        drvAccNum = '152750',                                                            --2/13/18                                          
        drvAccName = 'Sarnova Inc',
        drvEmpno = eecempno,
        drvssn = substring(eepssn,1,3)+'-'+substring(eepssn,4,2)+'-'+substring(eepssn,7,4),        
        drvNamefirst = eepnamefirst,
        drvNamemi = substring(eepnamemiddle,1,1),
        drvNamelast = eepnamelast,
        drvaddressline1 = dbo.dsi_fnRemoveChars('.,',eepaddressline1),
        drvaddressline2 = dbo.dsi_fnRemoveChars('.,',eepaddressline2),
        drvcity = dbo.dsi_fnRemoveChars('.,',eepaddresscity),
        drvState = eepaddressstate,
        drvzip = eepaddresszipcode,
        drvCountry = eepaddresscountry,
        drvHomePhone = '',
        drvGender = eepgender,
        drvDOB = convert(varchar(10),eepdateofbirth,101),
        drvPrimaryLang = eeclanguagecode,
        drvWorkAddID = '',
        drvWorkAddress1 = '',
        drvWorkAddress2 = '',
        drvWorkCity = '',
        drvWorkState = EecWCState,--substring(isnull(EecSITResidentStateCode,''),1,2),
        drvWorkZip = '',
        drvWorkCountry = 'USA',
        drvWorkPhone = eecphonebusinessnumber,---substring(eecphonebusinessnumber,1,3)+'-'+substring(eecphonebusinessnumber,4,6)+'-'+substring(eecphonebusinessnumber,7,9),
        drvWorkPhoneExt =eecphonebusinessext,
        drvBU = eecorglvl2,
        drvOrg = eecorglvl1,
        drvEmpG1 = case EecSalaryorHourly when 'S' then 'Exempt' else 'Non Exempt' end,--Nk 03/18/2019    SF 13840975    'Non Exempt' else 'Exempt' end,
        drvEmpG2 = case EecSalaryorHourly when 'S' then 'Salary' else 'Hourly' end,
        drvEmpG3 = case when EecUnionLocal is not null then 'Union' else 'Non Union' end,
        drvEmpG4 = eecpaygroup,
        drvEmpG5 = eecorglvl1,
        drvEmpG6 = '',
        drvEmpG7 = '',
        drvEmpG8 = EecLocation,--moved from R per vendor 1/23
        drvFullTime = eecfulltimeorparttime,
        drvHireDate = convert(varchar(10),eecdateoforiginalhire,101),
        drvAdjustedEmpDate = convert(varchar(10),eecdateoflasthire,101),
        drvAnnDate = '',
        drvTermDate = convert(varchar(10),eecdateoftermination,101), --LEA : Ask for Logic : 1
        drvHoursWorked =   cast(m.tmhrs  as varchar), --cast(eecscheduledworkhrs/2 as varchar),
        drvKeyEmp = eeciskeyemployee,
        drvJobTitle = (select top 1 JbcDesc from dbo.JobCode WITH (NOLOCK) where JbcJobCode = EecJobCode), --Changes this from the JobCode Table : LEA : 2 
        drvWorkEmail = '',
        drvScheduledHoursWeek = cast(round(eecscheduledAnnualHrs/52,2) as varchar),
        drvScheduledDaysWeek = '5',
        drvEmailAdd = '',
        drvSpouseEmp = '',
        drvSpouseEmpNo = '',
        drvPrimContact = '',
        drvWeekEarn = CASE WHEN ISNULL(EECUDFIELD09 ,'')  <> '' THEN CAST(CONVERT(DECIMAL(10,2),EECUDFIELD09) as VARCHAR(12)) ELSE CAST(CONVERT(DECIMAL(10,2),eecannsalary) as varchar(12)) END , --if EECUDFIELD09  <> blank or 0 send EECUDFIELD09  else send eecannsalary : LEA : 3 
        --drvWeekStdEarn = '',
        drvSTDEligDate = CASE WHEN STDBC is not null or STDBU is not null then 
                                CASE WHEN STDBC is not null then convert(varchar(10),STDBC_BenStartDate,101) 
                                     WHEN STDBU is not null then convert(varchar(10),STDBU_BenStartDate,101) 
                                END
                             WHEN STD is not null or STDC is not null THEN
                                CASE WHEN STD is not null then convert(varchar(10),STD_BenStartDate,101) 
                                     WHEN STDC is not null then convert(varchar(10),STDC_BenStartDate,101) 
                                END
                        END,
        
        --convert(varchar(10),s.effdate,101), -- if eeddedcode = STDBC or STDBU send eedbenstartdate else if eeddedcode = STD or STDC send eedbenstartdate : LEA : 4
        drvLTDELigDate = CASE WHEN LTD IS NOT NULL OR LTDC IS NOT NULL THEN
                                CASE WHEN LTD is not null then convert(varchar(10),LTD_BenStartDate,101) 
                                     WHEN LTDC is not null then convert(varchar(10),LTDC_BenStartDate,101) 
                                END
                            END --if eeddedcode = LTD or LTDC send eedbenstartdate - 5

  into dbo.U_dsi_ESARELIF2L_drvTbl
  from dbo.u_ESARELIF2L_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID and EepAddressCountry in ('USA')
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_ESARELIF2L_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))


    left join(SELECT prgtothours as hrs, PrgEEID, PrgCoID
FROM PayReg where PrgPayDate = @EndDate
) p  on p.prgeeid = xEEID and p.prgcoid = xcoid

join dbo.U_dsi_ESARELIF2L_DefComp12mo m on m.tmcoid = xCOID and m.tmeeid = xEEID

    ----left join contacts on xeeid = coneeid 
     left join (select eedeeid eeid, eedcoid coid,  
 LTD = MAX((CASE WHEN eeddedcode = 'LTD' then eeddedcode END)),
STD = MAX((CASE WHEN eeddedcode = 'STD' then eeddedcode END)),
STDBC = MAX((CASE WHEN eeddedcode = 'STDBC' then eeddedcode END)),
STDC = MAX((CASE WHEN eeddedcode = 'STDC' then eeddedcode END)),
STDBU = MAX((CASE WHEN eeddedcode = 'STDBU' then eeddedcode END)),
LTDC = MAX((CASE WHEN eeddedcode = 'LTDC' then eeddedcode END)),
 LTD_BenStartDate = MAX((CASE WHEN eeddedcode = 'LTD' then eedBenStartDate END)),
STD_BenStartDate = MAX((CASE WHEN eeddedcode = 'STD' then eedBenStartDate END)),
STDBC_BenStartDate = MAX((CASE WHEN eeddedcode = 'STDBC' then eedBenStartDate END)),
STDC_BenStartDate = MAX((CASE WHEN eeddedcode = 'STDC' then eedBenStartDate END)),
STDBU_BenStartDate = MAX((CASE WHEN eeddedcode = 'STDBU' then eedBenStartDate END)),
LTDC_BenStartDate = MAX((CASE WHEN eeddedcode = 'LTDC' then eedBenStartDate END))
                from U_dsi_bdm_EmpDeductions where eeddedcode IN ('STDBC','STDBU','STD','STDC','LTD','LTDC')
                and eedFormatCode = 'ESARELIF2L'/*@FormatCode */and eedValidForExport = 'Y'
                group by eedeeid,eedcoid)
/*
    left join (select eedeeid eeid, eedcoid coid, eeddedcode dcode, eedBenStartDate effdate 
                from U_dsi_bdm_EmpDeductions where eeddedcode IN ('STD')
                and eedFormatCode = 'ESARELIF2L'/*@FormatCode */and eedValidForExport = 'Y') 
*/
                s on s.eeid = xeeid and s.coid = xcoid

--select * from dbo.U_dsi_ESARELIF2L_drvTbl

--
---- Create Headers
--if object_id('dbo.U_dsi_ESARELIF2L_hdrTbl') is not null
--  drop table dbo.U_dsi_ESARELIF2L_hdrTbl
--
-- 
--select 
--    Filler = '0000000000000000000',
--    HeaderMasterLayout = '6',
--    SystemName = 'FSA',
--    SystemNumber = '5426',
--    ClientCode = '', --'HALIFA01',
--    VersionNumber = '001',
--    VersionDate = convert(varchar(8),@EndDate,112),---
--    CustomerSpecificID = '744084111', --'743764111',
--    CustomerName = 'National Response Corporation',
--    Cycle = 'B01-B26',
--    PolicyNumber = '0744084',
--    TypeofFeed = 'PROD',
--    MulCoverageDataIndicator = 'A',
--    Filler19 = ''
--
--into dbo.U_dsi_ESARELIF2L_hdrTbl
--
----select * from dbo.U_dsi_ESARELIF2L_hdrTbl
--
--
---- Create Trailers
--if object_id('dbo.U_dsi_ESARELIF2L_trlTbl') is not null
--  drop table dbo.U_dsi_ESARELIF2L_trlTbl
--
--select distinct
--    Filler17 = replicate('9',20),
--    RecordCount = tot.dtlcount,
--    TotalHCCAmtSign = '', 
--    THCCAmt = s1.total,
--    TDCCAmtSign = '', 
--    TDCCAmt =  s2.total,
--    THCCElecAmt = s3.total,
--    TDCCElecAmt = s4.total,
--    Filler18 = ''
--
--into dbo.U_dsi_ESARELIF2L_trlTbl
--from dbo.U_dsi_ESARELIF2L_drvTbl
--left join (select sum(case when drvConAmt1 = '' then 0.00 else convert(numeric(10,0),drvConAmt1) end) total from dbo.U_dsi_ESARELIF2L_drvTbl where drvConType1 = 'MED') s1 on 1 = 1
--left join (select sum(case when drvConAmt2= '' then 0.00 else drvConAmt2 end) total from dbo.U_dsi_ESARELIF2L_drvTbl where drvConType1 = 'DEP') s2 on 1 = 1
--left join (select sum(case when drvHCFSAElecAmt = '' then 0.00 else convert(numeric(10,0),drvHCFSAELECAmt) end) total from dbo.U_dsi_ESARELIF2L_drvTbl where drvConType1 = 'MED') s3 on 1 = 1
--left join (select sum(case when drvDCFSAElecAmt = '' then 0.00 else convert(numeric(10,0),drvDCFSAElecAmt) end) total from dbo.U_dsi_ESARELIF2L_drvTbl where drvConType1 = 'DEP') s4 on 1 = 1
--left join (select count(*) dtlcount from dbo.U_dsi_ESARELIF2L_drvTbl) tot on 1 = 1

--select * from dbo.U_dsi_ESARELIF2L_trlTbl

-- Set FileName  
if (dbo.dsi_fnVariable('ESARELIF2L','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'ESARELIF2L' + convert(char(8),getdate(),112) + '.csv'
    where FormatCode = 'ESARELIF2L'

--select sum(convert(numeric(10,0),drvHCFSAELECAmt))as total from dbo.U_dsi_ESARELIF2L_drvTbl where drvConType1 = 'MED'

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwESARELIF2L_Export as
       --select top 2000000 left(data,(len(data))) as data from dbo.U_ESARELIF2L_File with (nolock)
       --  order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
       --     initialsort, subsort, substring(Recordset,2,2)

select top 2000000 left(data,(len(data))) as data from dbo.U_ESARELIF2L_File with (nolock) 
  order by case when substring(Recordset,1,1) = 'H' then 1 
                                when substring(Recordset,1,1) = 'T' then 3 
                                else 2 end, 
                        case when substring(Recordset,1,1) = 'D' then 
                                substring(data,charindex(',',data,1)+1,9) 
                                end, 
                        initialsort, subsort, substring(Recordset,2,2)

*/

--Used for testing
--dbo.dsi_sp_TestSwitchbox 'ESARELIF2L','ESARELIF2L'
--dbo.dsi_sp_TestSwitchbox_v2 'ESARELIF2L','TEST'
--dbo.dsi_sp_TestSwitchbox 'ESARELIF2L','zap'

END
GO
 CREATE  View dbo.dsi_vwESARELIF2L_Export as
       --select top 2000000 left(data,(len(data))) as data from dbo.U_ESARELIF2L_File with (nolock)
       --  order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
       --     initialsort, subsort, substring(Recordset,2,2)

select top 2000000 left(data,(len(data))) as data from dbo.U_ESARELIF2L_File with (nolock) 
  order by case when substring(Recordset,1,1) = 'H' then 1 
                                when substring(Recordset,1,1) = 'T' then 3 
                                else 2 end, 
                        case when substring(Recordset,1,1) = 'D' then 
                                substring(data,charindex(',',data,1)+1,9) 
                                end, 
                        initialsort, subsort, substring(Recordset,2,2)