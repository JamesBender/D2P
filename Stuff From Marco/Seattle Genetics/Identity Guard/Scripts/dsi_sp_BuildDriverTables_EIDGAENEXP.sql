SET NOCOUNT ON;
IF OBJECT_ID('U_EIDGAENEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EIDGAENEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EIDGAENEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEIDGAENEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIDGAENEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIDGAENEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIDGAENEXP];
GO
IF OBJECT_ID('U_EIDGAENEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_PEarHist];
GO
IF OBJECT_ID('U_EIDGAENEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_PDedHist];
GO
IF OBJECT_ID('U_EIDGAENEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_File];
GO
IF OBJECT_ID('U_EIDGAENEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_EEList];
GO
IF OBJECT_ID('U_EIDGAENEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_drvTbl];
GO
IF OBJECT_ID('U_EIDGAENEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_DedList];
GO
IF OBJECT_ID('U_EIDGAENEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_AuditFields];
GO
IF OBJECT_ID('U_EIDGAENEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIDGAENEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIDGAENEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EIDGAENEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EIDGAENEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EIDGAENEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EIDGAENEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EIDGAENEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIDGAENEXP','Identity Guard Auto Enrollment Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EIDGAENEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GroupCode"','1','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','1',NULL,'GroupCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','2','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','2',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleInitial"','3','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','3',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','4','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Suffix"','5','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','5',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1"','6','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','6',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2"','7','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','7',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','8','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','8',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','9','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','9',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZipCode"','10','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','10',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmailAddress"','11','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','11',NULL,'EmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Phone"','12','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','12',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BirthDate"','13','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','13',NULL,'BirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SocialSecurityNumber"','14','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','14',NULL,'SocialSecurityNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ProductPlanCode"','15','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','15',NULL,'ProductPlanCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AuthorizationType"','16','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','16',NULL,'AuthorizationType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AuthorizationDate"','17','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','17',NULL,'AuthorizationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ProductEffectiveDate"','18','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','18',NULL,'ProductEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployeeID"','19','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','19',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Department"','20','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','20',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Type"','21','(''DA''=''T,'')','EIDGAENEXPZ0','50','H','01','21',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TerminationDate"','22','(''DA''=''T'')','EIDGAENEXPZ0','50','H','01','22',NULL,'TerminationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGroupCode"','1','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','1',NULL,'GroupCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','2','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','2',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','3','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','3',NULL,'MiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','4','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','4',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','5','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','5',NULL,'Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','6','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','6',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','7','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','7',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','8','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','8',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','9','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','9',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','10','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','10',NULL,'ZipCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','11','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','11',NULL,'EmailAddress',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','12','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','12',NULL,'Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','13','(''UD101''=''T,'')','EIDGAENEXPZ0','50','D','10','13',NULL,'BirthDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSocialSecurity"','14','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','14',NULL,'SocialSecurityNumber',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductPlanCode"','15','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','15',NULL,'ProductPlanCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAuthorizationType"','16','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','16',NULL,'AuthorizationType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAuthorizationDate"','17','(''UD101''=''T,'')','EIDGAENEXPZ0','50','D','10','17',NULL,'AuthorizationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductEffectiveDate"','18','(''UD101''=''T,'')','EIDGAENEXPZ0','50','D','10','18',NULL,'ProductEffectiveDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','19','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','19',NULL,'EmployeeID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepartment"','20','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','20',NULL,'Department',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvType"','21','(''UA''=''T,'')','EIDGAENEXPZ0','50','D','10','21',NULL,'Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','22','(''UD101''=''T'')','EIDGAENEXPZ0','50','D','10','22',NULL,'TerminationDate',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIDGAENEXP_20200602.txt',NULL,'','','',NULL,NULL,NULL,'OEACTIVE','202002291','EMPEXPORT','OEACTIVE','Feb 11 2020 10:01AM','EIDGAENEXP',NULL,NULL,NULL,'202002291','Feb 29 2020 12:00AM','Dec 30 1899 12:00AM','202002011','1','','','202002011',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIDGAENEXP_20200602.txt',NULL,'','','T2Z78,Y0WM3,Y0XQQ,Y0Z1W,Y0ZZU,Y0RLX,IAGFG,T2ZAN',NULL,NULL,NULL,'OEPASSIVE','202004011','EMPEXPORT','OEPASSIVE','Apr  1 2020  4:12PM','EIDGAENEXP',NULL,NULL,NULL,'202004011','Apr  1 2020 12:00AM','Dec 30 1899 12:00AM','202004011','232','','','202004011',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIDGAENEXP_20200602.txt',NULL,'','','T2Z78,Y0WM3,Y0XQQ,Y0Z1W,Y0ZZU,Y0RLX,IAGFG,T2ZAN',NULL,NULL,NULL,'Scheduled Session','202004031','EMPEXPORT','SCHEDULED','Apr  3 2020  1:33PM','EIDGAENEXP',NULL,NULL,NULL,'202004039','Apr  3 2020 12:00AM','Dec 30 1899 12:00AM','202003271','232','','','202004031',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIDGAENEXP_20200602.txt',NULL,'','','',NULL,NULL,NULL,'Full file Export','202004091','EMPEXPORT','FULLFILE','Apr  9 2020 11:11AM','EIDGAENEXP',NULL,NULL,NULL,'202004091','Apr  9 2020 12:00AM','Dec 30 1899 12:00AM','202002011','232','','','202002011',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIDGAENEXP_20200602.txt',NULL,'Null','N',',T2Z78,Y0WM3,Y0XQQ,Y0Z1W,Y0ZZU,Y0RLX,IAGFG,T2ZAN',NULL,NULL,NULL,'Changes Only','202004211','EMPEXPORT','CHANGES','Apr 21 2020  8:55AM','EIDGAENEXP',NULL,NULL,NULL,'202006019','Apr 21 2020 12:00AM','Dec 30 1899 12:00AM','202005251','4','','','202004071',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIDGAENEXP_20200602.txt',NULL,'','','',NULL,NULL,NULL,'OE CHANGES ONLY','202006021','EMPEXPORT','OECHANGES','Jun  2 2020  9:38AM','EIDGAENEXP',NULL,NULL,NULL,'202006021','Jun  2 2020 12:00AM','Dec 30 1899 12:00AM','202005011','3','','','202005011',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EIDGAENEXP_20200602.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006021','EMPEXPORT','TEST','Jun  2 2020 10:43AM','EIDGAENEXP',NULL,NULL,NULL,'202006021','Jun  2 2020 12:00AM','Dec 30 1899 12:00AM','202005271','75','','','202005271',dbo.fn_GetTimedKey(),NULL,'us3cPeSEA1008',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EIDGAENEXP_20200602.txt' END WHERE expFormatCode = 'EIDGAENEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIDGAENEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIDGAENEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIDGAENEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIDGAENEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIDGAENEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EIDGAENEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EIDGAENEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EIDGAENEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIDGAENEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIDGAENEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIDGAENEXP','D10','dbo.U_EIDGAENEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EIDGAENEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIDGAENEXP] (
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
IF OBJECT_ID('U_EIDGAENEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audBenChange] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EIDGAENEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EIDGAENEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EIDGAENEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] char(11) NULL,
    [drvGroupCode] varchar(10) NOT NULL,
    [drvNameFirst] varchar(6000) NULL,
    [drvNameMiddle] varchar(6000) NULL,
    [drvNameLast] varchar(6000) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(5) NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvPhone] varchar(50) NULL,
    [drvBirthDate] datetime NULL,
    [drvSocialSecurity] char(11) NULL,
    [drvProductPlanCode] varchar(10) NULL,
    [drvAuthorizationType] varchar(17) NOT NULL,
    [drvAuthorizationDate] nvarchar(4000) NULL,
    [drvProductEffectiveDate] datetime NULL,
    [drvEmployeeId] char(9) NULL,
    [drvDepartment] char(6) NULL,
    [drvType] varchar(4) NULL,
    [drvTerminationDate] datetime NULL
);
IF OBJECT_ID('U_EIDGAENEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EIDGAENEXP_File') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EIDGAENEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_PDedHist] (
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
IF OBJECT_ID('U_EIDGAENEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EIDGAENEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIDGAENEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Seattle Genetics, Inc

Created By: Marco Lagrosa
Business Analyst: Dian Turner
Create Date: 01/03/2020
Service Request Number: SR-2019-00252157

Purpose: Identity Guard Auto Enrollment Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIDGAENEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIDGAENEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIDGAENEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EIDGAENEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIDGAENEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIDGAENEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIDGAENEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIDGAENEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIDGAENEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIDGAENEXP', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIDGAENEXP', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIDGAENEXP', 'OECHANGES';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIDGAENEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIDGAENEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EIDGAENEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate = CAST('2/1/2020' as datetime)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EIDGAENEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIDGAENEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'IDGRD';

    IF OBJECT_ID('U_EIDGAENEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIDGAENEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EIDGAENEXP_DedList
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
    IF @ExportCode LIKE '%PASSIVE' or @ExportCode LIKE '%OECHANGES'    
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
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIDGAENEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIDGAENEXP_AuditFields;
    CREATE TABLE dbo.U_EIDGAENEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_EIDGAENEXP_AuditFields VALUES ('EmpPers','EepSSN');
    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIDGAENEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIDGAENEXP_Audit;
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
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
        ,audBenChange = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedBenOption'  THEN 'Y' ELSE 'N' END
    INTO dbo.U_EIDGAENEXP_Audit
    FROM dbo.U_EIDGAENEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EIDGAENEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';
    --=====================================================================================
    -- Retain Most Recent Audit Record by AudKey1, AudKey2, AudKey3 and Audit Field Name
    --=====================================================================================
    DELETE FROM dbo.U_EIDGAENEXP_Audit WHERE audRowNo > 1;
    --==========================================
    -- Clean EE List 
    --=========================================
    -- Changes Only
      IF @ExportCode LIKE '%CHANGES'
     BEGIN

        DELETE FROM dbo.U_EIDGAENEXP_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EIDGAENEXP_Audit WHERE audEEID = xEEID);
     END;
     

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EIDGAENEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIDGAENEXP_PDedHist;
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
    INTO dbo.U_EIDGAENEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EIDGAENEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EIDGAENEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EIDGAENEXP_PEarHist;
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
    INTO dbo.U_EIDGAENEXP_PEarHist
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
    -- DETAIL RECORD - U_EIDGAENEXP_drvTbl
    ---------------------------------

    IF @ExportCode LIKE '%FULLFILE'  or @ExportCode LIKE '%PASSIVE' or @ExportCode LIKE '%ACTIVE' 
    BEGIN
            IF OBJECT_ID('U_EIDGAENEXP_drvTbl','U') IS NOT NULL
                DROP TABLE dbo.U_EIDGAENEXP_drvTbl;
            SELECT DISTINCT
                 drvEEID = xEEID
                ,drvCoID = xCoID
                ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
                ,drvInitialSort = eepSSN
                -- standard fields above and additional driver fields below
                ,drvGroupCode = 'seattlegen'
                ,drvNameFirst = dbo.dsi_fnRemoveChars('.,/-',EepNameFirst) 
                ,drvNameMiddle = dbo.dsi_fnRemoveChars('.,/-',EepNameMiddle) 
                ,drvNameLast = dbo.dsi_fnRemoveChars('.,/-',EepNameLast)
                ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
                ,drvAddressLine1 = EepAddressLine1
                ,drvAddressLine2 = EepAddressLine2
                ,drvCity = EepAddressCity
                ,drvState = EepAddressState
                ,drvZipCode = LEFT(EepAddressZipCode,5)
                ,drvEmailAddress = CASE WHEN ISNULL(EepAddressEMail,'') <> '' THEN eepAddressEMail 
                                        ELSE ISNULL(eepAddressEMailAlternate,'')  
                                    END
                                
                ,drvPhone = CASE WHEN ISNULL(EepPhoneHomeNumber,'') <> '' THEN EepPhoneHomeNumber 
                                 WHEN ISNULL(EecPhoneBusinessNumber,'') <> '' THEN EecPhoneBusinessNumber
                                        ELSE (select top 1 efoPhoneNumber from EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)
                                    END
                ,drvBirthDate = EepDateOfBirth 
                ,drvSocialSecurity = eepSSN
                ,drvProductPlanCode = CASE WHEN bdmbenoption  = 'PMRFAM' THEN 'premierfam'
                                           WHEN bdmbenoption  = 'PMRIND' THEN 'premierind'
                                      END 
                ,drvAuthorizationType = 'Digital Signature'
                ,drvAuthorizationDate = '11/15/2019T10:15:30'
                ,drvProductEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
                ,drvEmployeeId = EecEmpNo
                ,drvDepartment =  EecOrgLvl2
                ,drvType = 'ADD'
                ,drvTerminationDate = ''
            INTO dbo.U_EIDGAENEXP_drvTbl
            FROM dbo.U_EIDGAENEXP_EEList WITH (NOLOCK)
            JOIN dbo.EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
            JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
            JOIN dbo.U_dsi_BDM_EIDGAENEXP WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID
                and BdmRecType = 'EMP'
            ;
    END

    IF @ExportCode LIKE '%CHANGES'  OR  @ExportCode LIKE '%TEST'   OR  @ExportCode LIKE '%OECHANGES'
    BEGIN


            IF OBJECT_ID('U_EIDGAENEXP_drvTbl','U') IS NOT NULL
                DROP TABLE dbo.U_EIDGAENEXP_drvTbl;
             SELECT DISTINCT
                 drvEEID = xEEID
                ,drvCoID = xCoID
                ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
                ,drvInitialSort = eepSSN
                -- standard fields above and additional driver fields below
                ,drvGroupCode = 'seattlegen'
                ,drvNameFirst = dbo.dsi_fnRemoveChars('.,/-',EepNameFirst) 
                ,drvNameMiddle = dbo.dsi_fnRemoveChars('.,/-',EepNameMiddle)
                ,drvNameLast = dbo.dsi_fnRemoveChars('.,/-',EepNameLast)

                ,drvNameSuffix = NULLIF(EepNameSuffix,'Z')
                ,drvAddressLine1 = EepAddressLine1
                ,drvAddressLine2 = EepAddressLine2
                ,drvCity = EepAddressCity
                ,drvState = EepAddressState
                ,drvZipCode = LEFT(EepAddressZipCode,5)
                ,drvEmailAddress = CASE WHEN ISNULL(EepAddressEMail,'') <> '' THEN eepAddressEMail 
                                        ELSE ISNULL(eepAddressEMailAlternate,'')  
                                    END
                                
                ,drvPhone = CASE WHEN ISNULL(EepPhoneHomeNumber,'') <> '' THEN EepPhoneHomeNumber 
                                WHEN ISNULL(EecPhoneBusinessNumber,'') <> '' THEN EecPhoneBusinessNumber
                                        ELSE (select top 1 efoPhoneNumber from EmpMPhon where efoPhoneType = 'CEL' and efoeeid = xeeid)
                                    END
                ,drvBirthDate = EepDateOfBirth 
                ,drvSocialSecurity = eepSSN
                ,drvProductPlanCode = CASE WHEN bdmbenoption  = 'PMRFAM' THEN 'premierfam'
                                           WHEN bdmbenoption  = 'PMRIND' THEN 'premierind'
                                      END  
                ,drvAuthorizationType = 'Digital Signature'
                ,drvAuthorizationDate = FORMAT(EecDateOfOriginalHire,'s')
                ,drvProductEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
                ,drvEmployeeId = EecEmpNo
                ,drvDepartment =  EecOrgLvl2
                ,drvType = CASE WHEN audBenChange = 'Y' THEN 'ADD'
                             WHEN AudTerm = 'Y' THEN 'TERM' 
                             WHEN audNewHire =' T' THEN 'ADD'
                            END
                ,drvTerminationDate = CASE
                             WHEN AudTerm = 'Y' THEN BdmBenStopDate

                            END
            INTO dbo.U_EIDGAENEXP_drvTbl
            FROM dbo.U_EIDGAENEXP_EEList WITH (NOLOCK)
            JOIN dbo.EmpComp WITH (NOLOCK)
                ON EecEEID = xEEID 
                AND EecCoID = xCoID
            JOIN dbo.EmpPers WITH (NOLOCK)
                ON EepEEID = xEEID
            JOIN dbo.U_dsi_BDM_EIDGAENEXP WITH (NOLOCK)
                ON BdmEEID = xEEID 
                AND BdmCoID = xCoID
                and BdmRecType = 'EMP'
            JOIN (       
             SELECT audEEID
            ,audNewHire = MAX(audNewHire)
            ,audTerm = MAX(audTerm)
            ,audBenChange = MAX(audBenChange)
        FROM dbo.U_EIDGAENEXP_Audit
        WHERE (audNewHire = 'Y'

            OR audTerm = 'Y'
            OR audBenChange = 'Y'
        )
        GROUP BY audEEID)
        AuditRecords
        ON audEEID = xEEID
    END



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
ALTER VIEW dbo.dsi_vwEIDGAENEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EIDGAENEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EIDGAENEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912271'
       ,expStartPerControl     = '201912271'
       ,expLastEndPerControl   = '202001039'
       ,expEndPerControl       = '202001039'
WHERE expFormatCode = 'EIDGAENEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIDGAENEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EIDGAENEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort