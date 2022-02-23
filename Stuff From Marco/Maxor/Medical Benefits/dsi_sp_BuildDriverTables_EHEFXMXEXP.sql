SET NOCOUNT ON;
IF OBJECT_ID('U_EHEFXMXEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHEFXMXEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHEFXMXEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHEFXMXEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHEFXMXEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHEFXMXEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHEFXMXEXP];
GO
IF OBJECT_ID('U_EHEFXMXEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_PEarHist];
GO
IF OBJECT_ID('U_EHEFXMXEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_PDedHist];
GO
IF OBJECT_ID('U_EHEFXMXEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_File];
GO
IF OBJECT_ID('U_EHEFXMXEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_EEList];
GO
IF OBJECT_ID('U_EHEFXMXEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_drvTbl];
GO
IF OBJECT_ID('U_EHEFXMXEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_DedList];
GO
IF OBJECT_ID('U_EHEFXMXEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_AuditFields];
GO
IF OBJECT_ID('U_EHEFXMXEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EHEFXMXEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EHEFXMXEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHEFXMXEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHEFXMXEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHEFXMXEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHEFXMXEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHEFXMXEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHEFXMXEXP','Health EFX Benefit Dependent Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EHEFXMXEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHEFXMXEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEPENDENT_SSN"','2','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RELATIONSHIP"','3','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OPTOUT"','4','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','4',NULL,'OPTOUT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OFFER_DATE"','5','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','5',NULL,'OFFER_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_NAME"','6','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','6',NULL,'PLAN_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_TIER"','7','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','7',NULL,'PLAN_TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PROVIDER"','8','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','8',NULL,'PROVIDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYER_PREMIUM"','9','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','9',NULL,'EMPLOYER_PREMIUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYEE_PREMIUM"','10','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','10',NULL,'EMPLOYEE_PREMIUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_EFFECTIVE_DATE"','11','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','11',NULL,'PLAN_EFFECTIVE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_EXIT_DATE"','12','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','12',NULL,'PLAN_EXIT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP_FIRST_NAME"','13','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','13',NULL,'DEP_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP_LAST_NAME"','14','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','14',NULL,'DEP_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP_DOB"','15','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','15',NULL,'DEP_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP_EFFECTIVE_DATE"','16','(''DA''=''T|'')','EHEFXMXEXPZ0','50','H','01','16',NULL,'DEP_EFFECTIVE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DEP_EXIT_DATE"','17','(''DA''=''T'')','EHEFXMXEXPZ0','50','H','01','17',NULL,'DEP_EXIT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepSSN"','2','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepRelationship"','3','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOptOut"','4','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','4',NULL,'OPTOUT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfferDate"','5','(''UD112''=''T|'')','EHEFXMXEXPZ0','50','D','10','5',NULL,'OFFER_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','6','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','6',NULL,'PLAN_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanTier"','7','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','7',NULL,'PLAN_TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProvider"','8','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','8',NULL,'PROVIDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERPremium"','9','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','9',NULL,'EMPLOYER_PREMIUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPremium"','10','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','10',NULL,'EMPLOYEE_PREMIUM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEffDate"','11','(''UD112''=''T|'')','EHEFXMXEXPZ0','50','D','10','11',NULL,'PLAN_EFFECTIVE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanExitDate"','12','(''UD112''=''T|'')','EHEFXMXEXPZ0','50','D','10','12',NULL,'PLAN_EXIT_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepFirstName"','13','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','13',NULL,'DEP_FIRST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepLastName"','14','(''UA''=''T|'')','EHEFXMXEXPZ0','50','D','10','14',NULL,'DEP_LAST_NAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepDob"','15','(''UD112''=''T|'')','EHEFXMXEXPZ0','50','D','10','15',NULL,'DEP_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDefEffDate"','16','(''UD112''=''T|'')','EHEFXMXEXPZ0','50','D','10','16',NULL,'DEP_EFFECTIVE_DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepExitDate"','17','(''UD112''=''T'')','EHEFXMXEXPZ0','50','D','10','17',NULL,'DEP_EXIT_DATE',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EHEFXMXEXP_20210204.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202005049','EMPEXPORT','OEACTIVE',NULL,'EHEFXMXEXP',NULL,NULL,NULL,'202005049','May  4 2020 11:26AM','May  4 2020 11:26AM','202005041',NULL,'','','202005041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202005049','EMPEXPORT','OEPASSIVE',NULL,'EHEFXMXEXP',NULL,NULL,NULL,'202005049','May  4 2020 11:26AM','May  4 2020 11:26AM','202005041',NULL,'','','202005041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Health EFX Benefit Dependent E','202005049','EMPEXPORT','ONDEMAND',NULL,'EHEFXMXEXP',NULL,NULL,NULL,'202005049','May  4 2020 11:26AM','May  4 2020 11:26AM','202005041',NULL,'','','202005041',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,',Y23F4,1KHF6,1KHLK,1KHQV,FB4R0',NULL,NULL,NULL,'HealthEFX Medical -6th of mnth','202010311','EMPEXPORT','SCH_MXEFXB','Jan 14 2021 12:00AM','EHEFXMXEXP',NULL,NULL,NULL,'202010311','Oct 31 2020 12:00AM','Dec 30 1899 12:00AM','202010011',NULL,'','','202010011',dbo.fn_GetTimedKey(),NULL,'us3mLaMAX1005',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','Y23F4,1KHF6,1KHLK,1KHQV,FB4R0',NULL,NULL,NULL,'Test Purposes Only','202012311','EMPEXPORT','TEST','Feb  4 2021 11:43AM','EHEFXMXEXP',NULL,NULL,NULL,'202012311','Dec 31 2020 12:00AM','Dec 30 1899 12:00AM','202012011','1523','','','202012011',dbo.fn_GetTimedKey(),NULL,'us3mLaMAX1005',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEFXMXEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEFXMXEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEFXMXEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHEFXMXEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EHEFXMXEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EHEFXMXEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EHEFXMXEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHEFXMXEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHEFXMXEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHEFXMXEXP','D10','dbo.U_EHEFXMXEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EHEFXMXEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EHEFXMXEXP] (
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
IF OBJECT_ID('U_EHEFXMXEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_Audit] (
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
    [audTerm] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EHEFXMXEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EHEFXMXEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL,
    [DedDesc] varchar(40) NULL
);
IF OBJECT_ID('U_EHEFXMXEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDedCode] char(5) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvDepSSN] char(11) NULL,
    [drvDepRelationship] char(3) NULL,
    [drvBenStatus] char(1) NULL,
    [drvOptOut] varchar(1) NOT NULL,
    [drvOfferDate] datetime NULL,
    [drvPlanName] varchar(40) NULL,
    [drvPlanTier] varchar(25) NULL,
    [drvProvider] varchar(6) NULL,
    [drvERPremium] varchar(12) NULL,
    [drvEEPremium] varchar(12) NULL,
    [drvPlanEffDate] datetime NULL,
    [drvPlanExitDate] datetime NULL,
    [drvDepFirstName] varchar(100) NULL,
    [drvDepLastName] varchar(100) NULL,
    [drvDepDob] datetime NULL,
    [drvDefEffDate] datetime NULL,
    [drvDepExitDate] datetime NULL,
    [drvbenoption] char(6) NULL,
    [Bdmdedcode] char(5) NOT NULL
);
IF OBJECT_ID('U_EHEFXMXEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHEFXMXEXP_File') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EHEFXMXEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_PDedHist] (
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
IF OBJECT_ID('U_EHEFXMXEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHEFXMXEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHEFXMXEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Maxor National Pharmacy

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 05/04/2020
Service Request Number: TekP-2020-03-26-0002

Purpose: Health EFX Benefit Dependent Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHEFXMXEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHEFXMXEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHEFXMXEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHEFXMXEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHEFXMXEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEFXMXEXP', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEFXMXEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHEFXMXEXP', 'OEACTIVE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHEFXMXEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHEFXMXEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHEFXMXEXP';

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
    DELETE FROM dbo.U_EHEFXMXEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHEFXMXEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'MEDBC,I5';

    IF OBJECT_ID('U_EHEFXMXEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHEFXMXEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
        ,DedDesc  = dedlongdesc 
    INTO dbo.U_EHEFXMXEXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExclFutureDatedStopDates', 'Y')
    
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');

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
    IF OBJECT_ID('U_EHEFXMXEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHEFXMXEXP_PDedHist;
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
    INTO dbo.U_EHEFXMXEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EHEFXMXEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EHEFXMXEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHEFXMXEXP_PEarHist;
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
    INTO dbo.U_EHEFXMXEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EHEFXMXEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EHEFXMXEXP_AuditFields;
    CREATE TABLE dbo.U_EHEFXMXEXP_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_EHEFXMXEXP_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_EHEFXMXEXP_AuditFields VALUES ('EmpDed','EedBenOption');
    INSERT INTO dbo.U_EHEFXMXEXP_AuditFields VALUES ('EmpComp','EecCoid');



    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EHEFXMXEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EHEFXMXEXP_Audit;
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
    INTO dbo.U_EHEFXMXEXP_Audit
    FROM dbo.U_EHEFXMXEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_EHEFXMXEXP_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';
    
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EHEFXMXEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHEFXMXEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHEFXMXEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDedCode = bdmdedcode
        ,drvDepRecID = CONVERT(varchar(12),BdmDepRecID) --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDepSSN = conssn
        ,drvDepRelationship = conrelationship
        ,drvBenStatus =  (    Select top 1 edhbenstatus from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate order by  edheffdate desc ,edhDateTimeCreated desc)
        ,drvOptOut = CASE WHEN ( (    Select top 1 edhbenstatus from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate order by  edheffdate desc ,edhDateTimeCreated desc) ) = 'W' THEN 'Y' ELSE 'N' END
        ,drvOfferDate = CASE WHEN audNewHire = 'Y' then BdmBenStartDate ELSE CONVERT(DATETIME, (concat(CAST((Month(DateAdd(month,1,EecDateOfBenefitSeniority))) AS VARCHAR(2)),'/01/',CASt((Year(DateAdd(month,1,EecDateOfBenefitSeniority))) AS VARCHAR(4)))) ) END 
        ,drvPlanName = CASE WHEN ( (    Select top 1 edhbenstatus from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate order by edheffdate) ) <> 'W' THEN RTRIM(LTRIM(DedDesc)) END
        ,drvPlanTier = RTRIM(LTRIM((Select top 1 bnoDescription from benOpt where bnocode = (    Select top 1 edhbenoption from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate order by edheffdate desc,edhDateTimeCreated desc))))
        ,drvProvider = CASE When Bdmdedcode = 'MEDBC' THEN 'BCBS' 
                            When Bdmdedcode = 'I5' THEN 'Kaiser' 
                       END 
        ,drvERPremium = CAST( (( (Select top 1 CorERrate from dbo.OptRate WITH (NOLOCK) where CorDedCode =  bdmdedcode and  Coreffdate <= @StartDate and  CorBenOption = (Select top 1 edhbenoption from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate order by edheffdate desc,edhDateTimeCreated desc)) * 26) /12) as varchar(12))
        ,drvEEPremium =CAST( (( (Select top 1 CorEErate from dbo.OptRate WITH (NOLOCK) where CorDedCode =  bdmdedcode and Coreffdate <= @StartDate and  CorBenOption = (Select top 1 edhbenoption from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate order by edheffdate desc,edhDateTimeCreated desc)) * 26) /12) as varchar(12))
        ,drvPlanEffDate = bdmbenstartdate
        ,drvPlanExitDate = case when 
                (Select top 1 edhbenstatus from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate order by  edheffdate desc ,edhDateTimeCreated desc) <> 'A' THEN  ISNULL(bdmbenstopdate,(Select top 1 edhbenstopdate from emphded where edheeid = xeeid and edhdedcode = bdmdedcode and edheffdate <=  @EndDate and edhbenstopdate is not null order by  edheffdate desc ,edhDateTimeCreated desc)) END
        ,drvDepFirstName = connamefirst
        ,drvDepLastName = connamelast
        ,drvDepDob = condateofbirth
        ,drvDefEffDate = case when bdmrectype = 'DEP' THEN bdmbenstartdate END
        ,drvDepExitDate = case  when bdmrectype = 'DEP'  THEN bdmbenstopdate END
        ,drvbenoption = bdmbenoption
        ,Bdmdedcode
    INTO dbo.U_EHEFXMXEXP_drvTbl
    FROM dbo.U_EHEFXMXEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EECEEID = XEEID
        and EECCOID  = XCOID
    JOIN (select eedeeid as bdmeeid,eedcoid as bdmcoid, eeddedcode as bdmdedcode,eedbenstartdate as bdmbenstartdate,eedbenstopdate as bdmbenstopdate,eedbenstatus as bdmbenstatus,eedbenoption as bdmbenoption,null as bdmDeprecid,'EMP' as bdmrectype from U_dsi_BDM_EmpDeductions where   eedformatcode = @FormatCode
UNION
select dbneeid as bdmeeid,dbncoid as bdmcoid,dbndedcode as bdmdedcode,dbnbenstartdate as bdmbenstartdate,dbnbenstopdate as bdmbenstopdate,dbnbenstatus as bdmbenstatus,dbnbenoption as bdmbenoption,dbndeprecid as bdmdeprecid,'DEP' as bdmrectype from U_dsi_BDM_DepDeductions where dbnformatcode = @FormatCode) as BdmConsilidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        --and (BdmbenStopDate is not null and BdmBenStatus  = 'T') and bdmbenstatus is not null
     LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
     LEFT JOIN (
        -- Get NewHire, ReHire, Terms from Audit
        SELECT audEEID
            ,audNewHire = MAX(audNewHire)
        FROM dbo.U_EHEFXMXEXP_Audit
        WHERE (audNewHire = 'Y'
        )
        GROUP BY audEEID
    ) AuditRecords
        ON audEEID = xEEID
    JOIN dbo.U_EHEFXMXEXP_DedList A WITH (NOLOCK)
        on Dedcode = bdmdedcode;
    
    --Update dbo.U_EHEFXMXEXP_drvTbl set drvDefEffDate = null , drvDepExitDate = null where drvDepDob is null;
    
    
    
    UPDATE dbo.U_EHEFXMXEXP_drvTbl set drvPlanName = '',drvPlanTier = '', drvProvider= '', drvEEPremium = '',drvERPremium = '', drvPlanEffDate = null , drvPlanExitDate = null ,drvDefEffDate = null , drvDepExitDate = null  where drvOptOut = 'Y'
    Delete from U_EHEFXMXEXP_drvTbl where drvPlanEffDate > @EndDate and drvPlanEffDate is not null --drveeid  = 'BY482V0000K0'
    Update dbo.U_EHEFXMXEXP_drvTbl set drvOfferDate =  CAST('01/01/' + CAST(Year(GetDate()) as varchar(04)) as datetime)  where drvOfferDate < CAST('01/01/' + CAST(Year(GetDate()) as varchar(04)) as datetime)
    Update dbo.U_EHEFXMXEXP_drvTbl set drvPlanEffDate =  CAST('01/01/' + CAST(Year(GetDate()) as varchar(04)) as datetime), drvDefEffDate =  CAST('01/01/' + CAST(Year(GetDate()) as varchar(04)) as datetime)  where drvPlanEffDate < CAST('01/01/' + CAST(Year(GetDate()) as varchar(04)) as datetime)
    --Update drvDefEffDate for Depedent only
    Update  dbo.U_EHEFXMXEXP_drvTbl set drvDefEffDate = null where drvdeprecid is null
    Delete from dbo.U_EHEFXMXEXP_drvTbl  where drvPlanExitDate > @EndDate --and  drvOptOut = 'Y'
    Delete from dbo.U_EHEFXMXEXP_drvTbl  where drvPlanExitDate < @StartDate --and  drvOptOut = 'Y'
    
    
    
    
    
    Update  U_EHEFXMXEXP_drvTbl set drvPlanExitDate =  NULL 
    where drvPlanExitDate   < CAST('01/01/' + CONVERT(VARCHAR(4),YEAR(@EndDate)) as datetime)
    
    
    Delete  from  dbo.U_EHEFXMXEXP_drvTbl where drveeid not in (
    Select drveeid from dbo.U_EHEFXMXEXP_drvTbl where  drvPlanExitDate between @StartDate and @EndDate) and drvPlanExitDate is not null and  drvOptOut = 'Y'
    
    Delete from dbo.U_EHEFXMXEXP_drvTbl where drveeid in(
        Select eeceeid from dbo.empcomp where eecdateoftermination  <  CAST('01/01/' + CAST(Year(@EndDate) as varchar(04)) as datetime)  and eecemplstatus = 'T' and eeccoid = dbo.dsi_BDM_fn_GetCurrentCOID(eeceeid)
    )
    

    Delete from U_EHEFXMXEXP_drvTbl where drvDepRecId  is not null and drvOptout  = 'Y'
    
    --Delete records that have multiple Waived deductions
    Delete from dbo.U_EHEFXMXEXP_drvTbl   where drveeid in (
    Select distinct drveeid from U_EHEFXMXEXP_drvTbl  where  drvBenStatus = 'W' group by drveeid having count(*) > 1
    )
    and bdmdedcode in (
    select  top 1 eeddedcode from dbo.U_dsi_BDM_EmpDeductions  where   eedformatcode = @FormatCode and eedeeid = drveeid order by eedbenstartdate asc 
    
    )

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
ALTER VIEW dbo.dsi_vwEHEFXMXEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHEFXMXEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHEFXMXEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202004271'
       ,expStartPerControl     = '202004271'
       ,expLastEndPerControl   = '202005049'
       ,expEndPerControl       = '202005049'
WHERE expFormatCode = 'EHEFXMXEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHEFXMXEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHEFXMXEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort