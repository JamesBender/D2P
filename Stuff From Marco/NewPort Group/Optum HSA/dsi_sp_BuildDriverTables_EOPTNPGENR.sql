SET NOCOUNT ON;
IF OBJECT_ID('U_EOPTNPGENR_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EOPTNPGENR_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EOPTNPGENR' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEOPTNPGENR_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEOPTNPGENR_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EOPTNPGENR') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTNPGENR];
GO
IF OBJECT_ID('U_EOPTNPGENR_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_Trailer];
GO
IF OBJECT_ID('U_EOPTNPGENR_File') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_File];
GO
IF OBJECT_ID('U_EOPTNPGENR_EEList') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_EEList];
GO
IF OBJECT_ID('U_EOPTNPGENR_drvHeader') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_drvHeader];
GO
IF OBJECT_ID('U_EOPTNPGENR_drvDetails') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_drvDetails];
GO
IF OBJECT_ID('U_EOPTNPGENR_DedList') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_DedList];
GO
IF OBJECT_ID('U_EOPTNPGENR_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_AuditFields];
GO
IF OBJECT_ID('U_EOPTNPGENR_Audit') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EOPTNPGENR') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EOPTNPGENR];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EOPTNPGENR';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EOPTNPGENR';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EOPTNPGENR';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EOPTNPGENR';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EOPTNPGENR';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EOPTNPGENR','Optum HSA Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EOPTNPGENRZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderRecordType"','1','(''UA''=''F'')','EOPTNPGENRZ0','1','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderPayerName"','2','(''UA''=''F'')','EOPTNPGENRZ0','40','H','01','2',NULL,'Payer Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderEmployerGroupName"','3','(''UA''=''F'')','EOPTNPGENRZ0','40','H','01','3',NULL,'Employer Group Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderPostingDate"','4','(''UD112''=''F'')','EOPTNPGENRZ0','8','H','01','4',NULL,'Posting Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderFiller"','5','(''UA''=''F'')','EOPTNPGENRZ0','511','H','01','5',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetRecordType"','1','(''UA''=''F'')','EOPTNPGENRZ0','1','D','10','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetEmployerNumberGrpNumber"','2','(''UA''=''F'')','EOPTNPGENRZ0','9','D','10','2',NULL,'EmployerNumber/GroupNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetStatusField"','3','(''UA''=''F'')','EOPTNPGENRZ0','1','D','10','3',NULL,'StatusField',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetSocialSecurityNumber"','4','(''UA''=''F'')','EOPTNPGENRZ0','9','D','10','4',NULL,'SocialSecurityNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetEmployeeFirstName"','5','(''UA''=''F'')','EOPTNPGENRZ0','18','D','10','5',NULL,'EmployeeFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetEmployeeMiddleInitial"','6','(''UA''=''F'')','EOPTNPGENRZ0','1','D','10','6',NULL,'EmployeeMiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetEmployeeLastName"','7','(''UA''=''F'')','EOPTNPGENRZ0','18','D','10','7',NULL,'EmployeeLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetStreetAddress1"','8','(''UA''=''F'')','EOPTNPGENRZ0','30','D','10','8',NULL,'StreetAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetStreetAddress2"','9','(''UA''=''F'')','EOPTNPGENRZ0','20','D','10','9',NULL,'StreetAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetCity"','10','(''UA''=''F'')','EOPTNPGENRZ0','22','D','10','10',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetState"','11','(''UA''=''F'')','EOPTNPGENRZ0','2','D','10','11',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetZipCodeFour"','12','(''UA''=''F'')','EOPTNPGENRZ0','9','D','10','12',NULL,'ZipCodeFour',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetDateofBirth"','13','(''UD112''=''F'')','EOPTNPGENRZ0','8','D','10','13',NULL,'DateofBirth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetPersonalPhoneNumber"','14','(''UA''=''F'')','EOPTNPGENRZ0','10','D','10','14',NULL,'PersonalPhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetBusinessPhoneNumber"','15','(''UA''=''F'')','EOPTNPGENRZ0','10','D','10','15',NULL,'BusinessPhoneNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeteMailAddress"','16','(''UA''=''F'')','EOPTNPGENRZ0','60','D','10','16',NULL,'e-MailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetEmployeeID"','17','(''UA''=''F'')','EOPTNPGENRZ0','11','D','10','17',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetFiller"','18','(''UA''=''F'')','EOPTNPGENRZ0','6','D','10','18',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetCoverageType"','19','(''UA''=''F'')','EOPTNPGENRZ0','1','D','10','19',NULL,'CoverageType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetHDHPStartDate"','20','(''UD112''=''F'')','EOPTNPGENRZ0','8','D','10','20',NULL,'HDHPStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetTerminationDate"','21','(''UD112''=''F'')','EOPTNPGENRZ0','8','D','10','21',NULL,'TerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetHSAAffirmation"','22','(''UA''=''F'')','EOPTNPGENRZ0','1','D','10','22',NULL,'HSAAffirmation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetMailingAddress1"','23','(''UA''=''F'')','EOPTNPGENRZ0','30','D','10','23',NULL,'MailingAddress1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetMailingAddress2"','24','(''UA''=''F'')','EOPTNPGENRZ0','20','D','10','24',NULL,'MailingAddress2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetMailingCity"','25','(''UA''=''F'')','EOPTNPGENRZ0','22','D','10','25',NULL,'MailingCity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetMailingState"','26','(''UA''=''F'')','EOPTNPGENRZ0','2','D','10','26',NULL,'MailingState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetMailingZipCode"','27','(''UA''=''F'')','EOPTNPGENRZ0','9','D','10','27',NULL,'MailingZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetFiller2"','28','(''UA''=''F'')','EOPTNPGENRZ0','209','D','10','28',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetWetSignatureInd"','29','(''UA''=''F'')','EOPTNPGENRZ0','1','D','10','29',NULL,'WetSignatureInd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetESignatureInd"','30','(''UA''=''F'')','EOPTNPGENRZ0','1','D','10','30',NULL,'ESignatureInd',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetVerificationID"','31','(''UA''=''F'')','EOPTNPGENRZ0','10','D','10','31',NULL,'VerificationID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetDivisionCode"','32','(''UA''=''F'')','EOPTNPGENRZ0','9','D','10','32',NULL,'DivisionCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetFiller3"','33','(''UA''=''F'')','EOPTNPGENRZ0','17','D','10','33',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetFiller4"','34','(''UA''=''F'')','EOPTNPGENRZ0','7','D','10','34',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecordType"','1','(''UA''=''F'')','EOPTNPGENRZ0','1','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerNumberofAccounts"','2','(''UA''=''F'')','EOPTNPGENRZ0','7','T','90','2',NULL,'Number of Accounts',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerFiller"','3','(''UA''=''F'')','EOPTNPGENRZ0','592','T','90','3',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOPTNPGENR_20200514.txt',NULL,'','','',NULL,NULL,NULL,'Optum HSA Eligibility Export','202005149','EMPEXPORT','CHANGES','May 14 2020  2:44PM','EOPTNPGENR',NULL,NULL,NULL,'202005149','May 14 2020 11:09AM','May 14 2020 11:09AM','202005141','3','','','202005141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOPTNPGENR_20200514.txt',NULL,'','','',NULL,NULL,NULL,'Optum HSA Eligibility Export','202005149','EMPEXPORT','FULLFILE','May 14 2020  2:58PM','EOPTNPGENR',NULL,NULL,NULL,'202005149','May 14 2020 11:09AM','May 14 2020 11:09AM','202005141','594','','','202005141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOPTNPGENR_20200514.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','202005149','EMPEXPORT','TEST',NULL,'EOPTNPGENR',NULL,NULL,NULL,'202005149','May 14 2020 11:09AM','May 14 2020 11:09AM','202005141',NULL,'','','202005141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EOPTNPGENR_20200514.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202005149','EMPEXPORT','SCH_OPTNR','May 14 2020  2:36PM','EOPTNPGENR',NULL,NULL,NULL,'202005149','May 14 2020 11:09AM','May 14 2020 11:09AM','202005141','3','','','202005141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EOPTNPGENR_20200514.txt' END WHERE expFormatCode = 'EOPTNPGENR';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTNPGENR','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTNPGENR','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTNPGENR','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTNPGENR','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTNPGENR','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EOPTNPGENR','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EOPTNPGENR' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EOPTNPGENR' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EOPTNPGENR_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EOPTNPGENR_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTNPGENR','H01','dbo.U_EOPTNPGENR_drvHeader',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTNPGENR','D10','dbo.U_EOPTNPGENR_drvDetails',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EOPTNPGENR','T90','dbo.U_EOPTNPGENR_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EOPTNPGENR') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EOPTNPGENR] (
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
IF OBJECT_ID('U_EOPTNPGENR_Audit') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_Audit] (
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
IF OBJECT_ID('U_EOPTNPGENR_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EOPTNPGENR_DedList') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EOPTNPGENR_drvDetails') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_drvDetails] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvDetRecordType] varchar(1) NOT NULL,
    [drvDetEmployerNumberGrpNumber] varchar(8) NOT NULL,
    [drvDetStatusField] varchar(1) NOT NULL,
    [drvDetSocialSecurityNumber] char(11) NULL,
    [drvDetEmployeeFirstName] varchar(100) NULL,
    [drvDetEmployeeMiddleInitial] varchar(1) NULL,
    [drvDetEmployeeLastName] varchar(100) NULL,
    [drvDetStreetAddress1] varchar(255) NULL,
    [drvDetStreetAddress2] varchar(255) NULL,
    [drvDetCity] varchar(255) NULL,
    [drvDetState] varchar(255) NULL,
    [drvDetZipCodeFour] varchar(14) NULL,
    [drvDetDateofBirth] datetime NULL,
    [drvDetPersonalPhoneNumber] varchar(50) NULL,
    [drvDetBusinessPhoneNumber] varchar(50) NULL,
    [drvDeteMailAddress] varchar(50) NULL,
    [drvDetEmployeeID] char(9) NULL,
    [drvDetFiller] varchar(1) NOT NULL,
    [drvDetCoverageType] varchar(1) NULL,
    [drvDetHDHPStartDate] varchar(1) NOT NULL,
    [drvDetTerminationDate] datetime NULL,
    [drvDetHSAAffirmation] varchar(1) NOT NULL,
    [drvDetMailingAddress1] varchar(1) NOT NULL,
    [drvDetMailingAddress2] varchar(1) NOT NULL,
    [drvDetMailingCity] varchar(1) NOT NULL,
    [drvDetMailingState] varchar(1) NOT NULL,
    [drvDetMailingZipCode] varchar(1) NOT NULL,
    [drvDetFiller2] varchar(1) NOT NULL,
    [drvDetWetSignatureInd] varchar(1) NOT NULL,
    [drvDetESignatureInd] varchar(1) NOT NULL,
    [drvDetVerificationID] varchar(1) NOT NULL,
    [drvDetDivisionCode] varchar(1) NOT NULL,
    [drvDetFiller3] varchar(1) NOT NULL,
    [drvDetFiller4] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EOPTNPGENR_drvHeader') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_drvHeader] (
    [drvHeaderRecordType] varchar(1) NOT NULL,
    [drvHeaderPayerName] varchar(11) NOT NULL,
    [drvHeaderEmployerGroupName] varchar(13) NOT NULL,
    [drvHeaderPostingDate] datetime NOT NULL,
    [drvHeaderFiller] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EOPTNPGENR_EEList') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EOPTNPGENR_File') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EOPTNPGENR_Trailer') IS NULL
CREATE TABLE [dbo].[U_EOPTNPGENR_Trailer] (
    [drvTrailerRecordType] varchar(1) NOT NULL,
    [drvTrailerNumberofAccounts] varchar(24) NULL,
    [drvTrailerFiller] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EOPTNPGENR]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Newport Group, Inc.

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 05/14/2020
Service Request Number: TekP-2020-03-12-0001

Purpose: Optum HSA Eligibility Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EOPTNPGENR';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EOPTNPGENR';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EOPTNPGENR';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EOPTNPGENR';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EOPTNPGENR' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTNPGENR', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EOPTNPGENR', 'FULLFILE';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EOPTNPGENR';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EOPTNPGENR', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EOPTNPGENR';

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
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSACC,HSACE,HSACS,HSAEC,HSAEE,HSAES,HSAF,HSAFM';


    IF OBJECT_ID('U_EOPTNPGENR_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTNPGENR_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EOPTNPGENR_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EOPTNPGENR_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EOPTNPGENR_EEList GROUP BY xEEID HAVING COUNT(1) > 1);



    -- Audit Code
    --==========================================

    -- Get data from audit fields table.  Add fields here if auditing
    IF OBJECT_ID('U_EOPTNPGENR_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTNPGENR_AuditFields;
    CREATE TABLE dbo.U_EOPTNPGENR_AuditFields (aTableName VARCHAR(30),aFieldName VARCHAR(30));
    -- Employee Information
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepNamePrefix');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepAddressLine1');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepAddressLine2');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepAddressCity');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepAddressState');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepAddressZipCode');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepAddressCountry');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepIsDisabled');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepMaritalStatus');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpPers','EepPhoneHomeHumber');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    -- Dependent Information
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConSSN');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConNameFirst');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConNameLast');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConNameMiddle');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConNameSuffix');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConDateOfBirth');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConIsDisabled');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConRelationship');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConAddressLine1');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConAddressLine2');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConAddressCity');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConAddressState');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConAddressZipCode');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('Contacts','ConAddressCountry');
    -- Employee Deduction/Benefit Information
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpDed','EedDedCode');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpDed','EedBenStatus');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('EmpDed','EedBenStopDate');
    -- Dependent Deduction/Benefit Information
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('DepBPlan','DbnDedCode');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('DepBPlan','DbnBenStatus');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('DepBPlan','DbnBenStartDate');
    INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('DepBPlan','DbnBenStopDate');
    -- Deduction/Benefit Information
    --INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('DedCode','DedBenAmt');
    --INSERT INTO dbo.U_EOPTNPGENR_AuditFields VALUES ('DedCode','DedBenAmtRateOrPct');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EOPTNPGENR_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTNPGENR_Audit;
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
    INTO dbo.U_EOPTNPGENR_Audit
    FROM dbo.U_EOPTNPGENR_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK)
        ON xEEID = audKey1Value
    JOIN dbo.U_EOPTNPGENR_AuditFields WITH (NOLOCK)
        ON aTableName = audTableName
        AND aFieldName = audFieldName
    LEFT JOIN dbo.DepBPlan WITH (NOLOCK)
        ON DbnEEID = xEEID
        AND DbnDedCode = audKey2Value
        AND DbnSystemID = audKey3Value
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND ISNULL(audNewValue, '') <> ''
    AND ((audTableName NOT IN ('EmpDed','DepBPlan'))
        OR (audTableName = 'EmpDed' AND audKey3Value IN (SELECT DedCode FROM dbo.U_EOPTNPGENR_DedList))
        OR (audTableName = 'DepBPlan' AND audKey2Value IN (SELECT DedCode FROM dbo.U_EOPTNPGENR_DedList))
    );

    --================
    -- Changes Only
    --================
    IF (@Exportcode NOT IN ('FULLFILE','OEACTIVE','OEPASSIVE'))
    BEGIN
        -- Remove Employees with No Changes in Audit
        DELETE FROM dbo.U_EOPTNPGENR_EELIST
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EOPTNPGENR_Audit WHERE audEEID = xEEID AND audRowNo = 1);
    END;




    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate -30 );
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EOPTNPGENR_drvDetails
    ---------------------------------
    IF OBJECT_ID('U_EOPTNPGENR_drvDetails','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTNPGENR_drvDetails;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = EepSSN
        ,drvSubSort = ''
        -- standard fields above and additional driver fields below
        ,drvDetRecordType = 'B'
        ,drvDetEmployerNumberGrpNumber = '76414255'
        ,drvDetStatusField = CASE WHEN eecemplstatus = 'T' THEN '3' else  '1' END
        ,drvDetSocialSecurityNumber = EepSSN
        ,drvDetEmployeeFirstName = EepNameFirst
        ,drvDetEmployeeMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvDetEmployeeLastName = EepNameLast
        ,drvDetStreetAddress1 = EepAddressLine1
        ,drvDetStreetAddress2 = EepAddressLine2
        ,drvDetCity = EepAddressCity
        ,drvDetState = EepAddressState
        ,drvDetZipCodeFour = Substring(EepAddressZipCode,1,5) + CASE WHEN Substring(EepAddressZipCode,6,9) = '' or Substring(EepAddressZipCode,6,9) = null then  '0000' ELSE Substring(EepAddressZipCode,6,9) END
        ,drvDetDateofBirth = EepDateOfBirth
        ,drvDetPersonalPhoneNumber = eepphonehomenumber
        ,drvDetBusinessPhoneNumber = EecPhoneBusinessNumber
        ,drvDeteMailAddress = EepAddressEMail
        ,drvDetEmployeeID = EecEmpNo
        ,drvDetFiller = ''
        ,drvDetCoverageType =     CASE WHEN bdmDedcode IN('HSACC', 'HSACS', 'HSAEC', 'HSAES', 'HSAF', 'HSAFM') THEN 'F'
                                     WHEN bdmDedcode IN('HSACE','HSAEE') THEN 'I' 
                                END

        ,drvDetHDHPStartDate = ''
        ,drvDetTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDetHSAAffirmation = 'Y'
        ,drvDetMailingAddress1 = ''
        ,drvDetMailingAddress2 = ''
        ,drvDetMailingCity = ''
        ,drvDetMailingState = ''
        ,drvDetMailingZipCode = ''
        ,drvDetFiller2 = ''
        ,drvDetWetSignatureInd = 'Y'
        ,drvDetESignatureInd = 'Y'
        ,drvDetVerificationID = ''
        ,drvDetDivisionCode = ''
        ,drvDetFiller3 = ''
        ,drvDetFiller4 = ''
    INTO dbo.U_EOPTNPGENR_drvDetails
    FROM dbo.U_EOPTNPGENR_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EOPTNPGENR WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTNPGENR_drvHeader','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTNPGENR_drvHeader;
    SELECT DISTINCT
         drvHeaderRecordType = 'A'
        ,drvHeaderPayerName = 'TekPartners'
        ,drvHeaderEmployerGroupName = 'Newport Group'
        ,drvHeaderPostingDate = GETDATE()
        ,drvHeaderFiller = ''
    INTO dbo.U_EOPTNPGENR_drvHeader
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EOPTNPGENR_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EOPTNPGENR_Trailer;
    SELECT DISTINCT
         drvTrailerRecordType = 'Z'
        ,drvTrailerNumberofAccounts = dbo.dsi_fnpadzero((ISNULL((Select count(*) from dbo.U_EOPTNPGENR_drvDetails),0)),7,0) 
        ,drvTrailerFiller = ''
    INTO dbo.U_EOPTNPGENR_Trailer
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
ALTER VIEW dbo.dsi_vwEOPTNPGENR_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EOPTNPGENR_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EOPTNPGENR%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202005071'
       ,expStartPerControl     = '202005071'
       ,expLastEndPerControl   = '202005149'
       ,expEndPerControl       = '202005149'
WHERE expFormatCode = 'EOPTNPGENR';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEOPTNPGENR_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EOPTNPGENR_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort