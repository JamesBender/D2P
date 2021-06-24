SET NOCOUNT ON;
IF OBJECT_ID('U_EMOODENVIS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMOODENVIS_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMOODENVIS_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMOODENVIS' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMOODENVIS_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMOODENVIS_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMOODENVIS') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOODENVIS];
GO
IF OBJECT_ID('U_EMOODENVIS_File') IS NOT NULL DROP TABLE [dbo].[U_EMOODENVIS_File];
GO
IF OBJECT_ID('U_EMOODENVIS_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMOODENVIS_EEList];
GO
IF OBJECT_ID('U_EMOODENVIS_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMOODENVIS_drvTbl];
GO
IF OBJECT_ID('U_EMOODENVIS_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMOODENVIS_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EMOODENVIS') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMOODENVIS];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMOODENVIS';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMOODENVIS';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMOODENVIS';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMOODENVIS';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMOODENVIS';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMOODENVIS','Mutual of Omaha Den/Vis Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMOODENVISZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMOODENVIS' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransDate"','1','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','1',NULL,'Trans Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"G000BRNC"','2','(''DA''=''F'')','EMOODENVISZ0','8','D','10','9',NULL,'Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipCode"','3','(''UA''=''F'')','EMOODENVISZ0','1','D','10','17',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','4','(''UA''=''F'')','EMOODENVISZ0','9','D','10','18',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','5','(''DA''=''F'')','EMOODENVISZ0','1','D','10','27',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''F'')','EMOODENVISZ0','35','D','10','28',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''F'')','EMOODENVISZ0','15','D','10','63',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','8','(''DA''=''F'')','EMOODENVISZ0','11','D','10','78',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGenderCode"','9','(''UA''=''F'')','EMOODENVISZ0','1','D','10','89',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','10','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','90',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','11','(''DA''=''F'')','EMOODENVISZ0','11','D','10','98',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''F'')','EMOODENVISZ0','30','D','10','109',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','13','(''DA''=''F'')','EMOODENVISZ0','10','D','10','139',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','14','(''UA''=''F'')','EMOODENVISZ0','30','D','10','149',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','15','(''DA''=''F'')','EMOODENVISZ0','50','D','10','179',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','16','(''UA''=''F'')','EMOODENVISZ0','19','D','10','229',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','17','(''UA''=''F'')','EMOODENVISZ0','2','D','10','248',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','18','(''UA''=''F'')','EMOODENVISZ0','11','D','10','250',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','19','(''DA''=''F'')','EMOODENVISZ0','48','D','10','261',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','20','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','309',NULL,'Date of Hire (DOH)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeEffeciveDate"','21','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','317',NULL,'Employee Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','22','(''DA''=''F'')','EMOODENVISZ0','68','D','10','325',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBillGroupEffectiveDate"','23','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','393',NULL,'Bill Group Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','24','(''DA''=''F'')','EMOODENVISZ0','4','D','10','401',NULL,'Bill Group ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','25','(''DA''=''F'')','EMOODENVISZ0','70','D','10','405',NULL,'Filer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalaryEffectiveDate"','26','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','475',NULL,'Basic Salary Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"A"','27','(''DA''=''F'')','EMOODENVISZ0','1','D','10','483',NULL,'Basic Salary Mode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBasicSalaryAmount"','28','(''UA''=''F'')','EMOODENVISZ0','16','D','10','484',NULL,'Basic Salary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','29','(''DA''=''F'')','EMOODENVISZ0','108','D','10','500',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassEffectiveDate"','30','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','608',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClassId"','31','(''UA''=''F'')','EMOODENVISZ0','4','D','10','616',NULL,'Class ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('" "','32','(''DA''=''F'')','EMOODENVISZ0','135','D','10','620',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductCategory1"','33','(''UA''=''F'')','EMOODENVISZ0','1','D','10','755',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffecticeDate1"','34','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','756',NULL,'Effectiive Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityEvent1"','35','(''UA''=''F'')','EMOODENVISZ0','2','D','10','764',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId1"','36','(''UA''=''F'')','EMOODENVISZ0','10','D','10','766',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyCoverageIndicator1"','37','(''UA''=''F'')','EMOODENVISZ0','1','D','10','776',NULL,'Family Coverage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','38','(''DA''=''F'')','EMOODENVISZ0','968','D','10','777',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProductCategory2"','39','(''UA''=''F'')','EMOODENVISZ0','1','D','10','1745',NULL,'Product Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffecticeDate2"','40','(''UD112''=''F'')','EMOODENVISZ0','8','D','10','1746',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityEvent2"','41','(''UA''=''F'')','EMOODENVISZ0','2','D','10','1754',NULL,'Eligibility Event',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanId2"','42','(''UA''=''F'')','EMOODENVISZ0','10','D','10','1756',NULL,'Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFamilyCoverageIndicator2"','43','(''UA''=''F'')','EMOODENVISZ0','1','D','10','1766',NULL,'Family Coverage Indicator',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EMOODENVIS_20201113.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202011019','EMPEXPORT','OEACTIVE',NULL,'EMOODENVIS',NULL,NULL,NULL,'202011019','Nov  1 2020  5:17PM','Nov  1 2020  5:17PM','202011011',NULL,'','','202011011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202011019','EMPEXPORT','OEPASSIVE',NULL,'EMOODENVIS',NULL,NULL,NULL,'202011019','Nov  1 2020  5:17PM','Nov  1 2020  5:17PM','202011011',NULL,'','','202011011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Den/Vis Export','202011019','EMPEXPORT','ONDEM_XOE',NULL,'EMOODENVIS',NULL,NULL,NULL,'202011019','Nov  1 2020  5:17PM','Nov  1 2020  5:17PM','202011011',NULL,'','','202011011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Mutual of Omaha Den/Vis -Sched','202011019','EMPEXPORT','SCH_EMOODE',NULL,'EMOODENVIS',NULL,NULL,NULL,'202011019','Nov  1 2020  5:17PM','Nov  1 2020  5:17PM','202011011',NULL,'','','202011011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Mutual of Omaha Den/Vis -Test','202011121','EMPEXPORT','TEST_XOE','Nov 13 2020 12:39PM','EMOODENVIS',NULL,NULL,NULL,'202011121','Nov 12 2020 12:00AM','Dec 30 1899 12:00AM','202010281','404','','','202010281',dbo.fn_GetTimedKey(),NULL,'us3cPeALI1002',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOODENVIS','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOODENVIS','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOODENVIS','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOODENVIS','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMOODENVIS','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EMOODENVIS' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EMOODENVIS' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EMOODENVIS_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMOODENVIS_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOODENVIS','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMOODENVIS','D10','dbo.U_EMOODENVIS_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EMOODENVIS') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMOODENVIS] (
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
IF OBJECT_ID('U_EMOODENVIS_DedList') IS NULL
CREATE TABLE [dbo].[U_EMOODENVIS_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMOODENVIS_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMOODENVIS_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(14) NULL,
    [drvTransDate] datetime NOT NULL,
    [drvRelationshipCode] varchar(1) NULL,
    [drvEmployeeID] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvGenderCode] char(1) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvDateOfHire] datetime NULL,
    [drvEmployeeEffeciveDate] datetime NULL,
    [drvBillGroupEffectiveDate] datetime NULL,
    [drvBasicSalaryEffectiveDate] datetime NULL,
    [drvBasicSalaryAmount] nvarchar(4000) NULL,
    [drvClassEffectiveDate] datetime NULL,
    [drvClassId] varchar(4) NOT NULL,
    [drvProductCategory1] varchar(1) NULL,
    [drvEffecticeDate1] datetime NULL,
    [drvEligibilityEvent1] varchar(2) NULL,
    [drvPlanId1] varchar(10) NULL,
    [drvFamilyCoverageIndicator1] varchar(1) NULL,
    [drvProductCategory2] varchar(1) NULL,
    [drvEffecticeDate2] datetime NULL,
    [drvEligibilityEvent2] varchar(2) NULL,
    [drvPlanId2] varchar(10) NULL,
    [drvFamilyCoverageIndicator2] varchar(1) NULL
);
IF OBJECT_ID('U_EMOODENVIS_EEList') IS NULL
CREATE TABLE [dbo].[U_EMOODENVIS_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMOODENVIS_File') IS NULL
CREATE TABLE [dbo].[U_EMOODENVIS_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMOODENVIS]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: A-lign

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 11/01/2020
Service Request Number: TekP-2020-09-24-0002

Purpose: Mutual of Omaha Den/Vis Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMOODENVIS';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMOODENVIS';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMOODENVIS';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMOODENVIS';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMOODENVIS' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOODENVIS', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOODENVIS', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOODENVIS', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOODENVIS', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMOODENVIS', 'SCH_EMOODE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMOODENVIS';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMOODENVIS', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMOODENVIS';

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
    DELETE FROM dbo.U_EMOODENVIS_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMOODENVIS_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EMOODENVIS_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID from dbo.EmpComp WITH (NOLOCK) WHERE EecEEType = 'TES'
    );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DENHI,DENLO,VIS';

    IF OBJECT_ID('U_EMOODENVIS_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMOODENVIS_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMOODENVIS_DedList
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
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMOODENVIS_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMOODENVIS_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMOODENVIS_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = xEEID + CASE WHEN BdmRecType = 'EMP' THEN ' 1' ELSE ' 2' END
        -- standard fields above and additional driver fields below
        ,drvTransDate = GETDATE()
        ,drvRelationshipCode =    CASE WHEN BdmRecType = 'DEP' 
                                    THEN 
                                        CASE WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'F' THEN 'W'
                                            WHEN ConRelationship IN ('SPS','DP') AND ConGender = 'M' THEN 'H'
                                            WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'F' THEN 'D'
                                            WHEN ConRelationship IN ('CHL','DPC','STC') AND ConGender = 'M' THEN 'S'
                                            
                                        END 
                                    ELSE 'M'                                                                      
                                END
        ,drvEmployeeID = EepSSN
        ,drvNameLast = CASE WHEN BdmRecType = 'EMP' THEN EepNameLast ELSE ConNameLast END
        ,drvNameFirst = CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst ELSE ConNameFirst END
        ,drvGenderCode = CASE WHEN BdmRecType = 'EMP' THEN  EepGender ELSE ConGender END
        ,drvDateOfBirth = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvEmployeeEffeciveDate = dbo.dsi_fnGetMinMaxDates('MAX', EecDateOfLastHire, '10/1/2020')
        ,drvBillGroupEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX', EecDateOfLastHire, '10/1/2020')
        ,drvBasicSalaryEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX', EecDateOfLastHire, '10/1/2020')
        ,drvBasicSalaryAmount = FORMAT(EecAnnSalary*100, '0000000000000000') 
        ,drvClassEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX', EecDateOfLastHire, '10/1/2020')
        ,drvClassId =    CASE WHEN DENHI_DedCode IS NOT NULL THEN 'A001'
                            WHEN DENLO_DedCode IS NOT NULL THEN 'A002'
                            ELSE 'A003'
                        END
        ,drvProductCategory1 = CASE WHEN DENHI_DedCode IS NOT NULL OR DENLO_DedCode IS NOT NULL THEN 'D' END
        ,drvEffecticeDate1 = CASE WHEN DENHI_DedCode IS NOT NULL OR DENLO_DedCode IS NOT NULL THEN
                                dbo.dsi_fnGetMinMaxDates('MAX', 
                                    CASE WHEN (DENHI_DedCode IS NOT NULL OR DENLO_DedCode IS NOT NULL) AND DEN_BenStatus IN ('T','C') THEN DATEADD(DAY, 1, DEN_BenStopDate) ELSE DEN_BenStartDate END,
                                    '10/1/2020')
                            END
        ,drvEligibilityEvent1 = CASE WHEN DENHI_DedCode IS NOT NULL OR DENLO_DedCode IS NOT NULL THEN
                                    CASE WHEN DEN_BenStatus IN ('T') THEN 'TM' ELSE 'EN' END
                                END
        ,drvPlanId1 =    CASE WHEN DENHI_DedCode IS NOT NULL THEN 'DTP0000300'
                            WHEN DENLO_DedCode IS NOT NULL THEN 'DTP0000400'
                        END
        ,drvFamilyCoverageIndicator1 =    CASE WHEN DENHI_DedCode IS NOT NULL OR DENLO_DedCode IS NOT NULL THEN
                                            CASE WHEN DEN_BenOption IN ('EE') THEN 'C'
                                                WHEN DEN_BenOption IN ('EES','EEDP') THEN 'B'
                                                WHEN DEN_BenOption IN ('EEC') THEN 'D'
                                                WHEN DEN_BenOption IN ('EEF','EEDPF') THEN 'A'
                                            END
                                        END
        ,drvProductCategory2 = CASE WHEN VIS_DedCode IS NOT NULL THEN 'V' END
        ,drvEffecticeDate2 =    CASE WHEN VIS_DedCode IS NOT NULL THEN
                                    dbo.dsi_fnGetMinMaxDates('MAX', 
                                        CASE WHEN VIS_DedCode IS NOT NULL AND VIS_BenStatus IN ('T','C') THEN DATEADD(DAY, 1, VIS_BenStopDate) ELSE VIS_BenStartDate END,
                                        '10/1/2020')
                                END
        ,drvEligibilityEvent2 = CASE WHEN VIS_DedCode IS NOT NULL THEN
                                    CASE WHEN VIS_BenStatus IN ('T') THEN 'TM' ELSE 'EN' END
                                END
        ,drvPlanId2 = CASE WHEN VIS_DedCode IS NOT NULL THEN 'VTV0NCVIS1' END
        ,drvFamilyCoverageIndicator2 = CASE WHEN VIS_DedCode IS NOT NULL THEN
                                            CASE WHEN VIS_BenOption IN ('EE') THEN 'C'
                                                WHEN VIS_BenOption IN ('EES','EEDP') THEN 'B'
                                                WHEN VIS_BenOption IN ('EEC') THEN 'D'
                                                WHEN VIS_BenOption IN ('EEF','EEDPF') THEN 'A'
                                            END
                                        END
    INTO dbo.U_EMOODENVIS_drvTbl
    FROM dbo.U_EMOODENVIS_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EMOODENVIS WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID, BdmDepRecID
                ,MAX(BdmRecType) AS BdmRecType
                ,MAX(BdmRelationship) AS BdmRelationship
                ,MAX(CASE WHEN BdmDedCode = 'DENHI' THEN BdmDedCode END) DENHI_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'DENLO' THEN BdmDedCode END) DENLO_DedCode
                ,MAX(CASE WHEN BdmDedCode = 'VIS' THEN BdmDedCode END) VIS_DedCode

                ,MAX(CASE WHEN BdmDedCode IN ('DENHI','DENLO') THEN BdmBenStatus END) DEN_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('DENHI','DENLO') THEN BdmBenStopDate END) DEN_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('DENHI','DENLO') THEN BdmBenStartDate END) DEN_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('DENHI','DENLO') THEN BdmBenOption END) DEN_BenOption

                ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmBenStatus END) VIS_BenStatus
                ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmBenStopDate END) VIS_BenStopDate
                ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmBenStartDate END) VIS_BenStartDate
                ,MAX(CASE WHEN BdmDedCode IN ('VIS') THEN BdmBenOption END) VIS_BenOption

            FROM dbo.U_dsi_BDM_EMOODENVIS WITH (NOLOCK)
            GROUP BY BdmEEID, BdmCOID, BdmDepRecID) AS BDM
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
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
ALTER VIEW dbo.dsi_vwEMOODENVIS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMOODENVIS_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMOODENVIS%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202010251'
       ,expStartPerControl     = '202010251'
       ,expLastEndPerControl   = '202011019'
       ,expEndPerControl       = '202011019'
WHERE expFormatCode = 'EMOODENVIS';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMOODENVIS_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMOODENVIS_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;