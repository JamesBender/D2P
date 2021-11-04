SET NOCOUNT ON;
IF OBJECT_ID('U_ENAT401TES_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ENAT401TES_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ENAT401TES' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwENAT401TES_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENAT401TES_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENAT401TES') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAT401TES];
GO
IF OBJECT_ID('U_ENAT401TES_File') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_File];
GO
IF OBJECT_ID('U_ENAT401TES_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_EEList];
GO
IF OBJECT_ID('U_ENAT401TES_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_AuditFields];
GO
IF OBJECT_ID('U_ENAT401TES_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_Audit];
GO
IF OBJECT_ID('U_dsi_ENAT401TES_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401TES_drvTbl];
GO
IF OBJECT_ID('U_dsi_ENAT401TES_DedHist') IS NOT NULL DROP TABLE [dbo].[U_dsi_ENAT401TES_DedHist];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ENAT401TES';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ENAT401TES';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ENAT401TES';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ENAT401TES';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ENAT401TES';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','ENAT401TES','NationWide 401k Census TEST','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','ENAT401TESZ0','N','Dec  4 2014 10:56AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ENAT401TES' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransType"','1','(''UA''=''T,'')','ENAT401TESZ0','6','D','01','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLineofBusiness"','2','(''UA''=''T,'')','ENAT401TESZ0','1','D','01','7',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNationwideCaseNumber"','3','(''UA''=''T,'')','ENAT401TESZ0','9','D','01','8',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDate"','4','(''UA''=''T,'')','ENAT401TESZ0','8','D','01','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','ENAT401TESZ0','9','D','01','25',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLname"','6','(''UA''=''T,'')','ENAT401TESZ0','20','D','01','34',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFname"','7','(''UA''=''T,'')','ENAT401TESZ0','15','D','01','54',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''T,'')','ENAT401TESZ0','32','D','01','69',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''T,'')','ENAT401TESZ0','32','D','01','101',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','10','(''UA''=''T,'')','ENAT401TESZ0','32','D','01','133',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine4"','11','(''UA''=''T,'')','ENAT401TESZ0','32','D','01','165',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','12','(''UA''=''T,'')','ENAT401TESZ0','32','D','01','197',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','13','(''UA''=''T,'')','ENAT401TESZ0','2','D','01','229',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','14','(''UA''=''T,'')','ENAT401TESZ0','5','D','01','231',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','15','(''UA''=''T,'')','ENAT401TESZ0','4','D','01','236',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','16','(''UA''=''T,'')','ENAT401TESZ0','8','D','01','240',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOT"','17','(''UA''=''T,'')','ENAT401TESZ0','8','D','01','248',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofPlanEntry"','18','(''UA''=''T,'')','ENAT401TESZ0','8','D','01','256',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','19','(''UA''=''T,'')','ENAT401TESZ0','8','D','01','264',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','20','(''UA''=''T,'')','ENAT401TESZ0','1','D','01','272',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','21','(''UA''=''T,'')','ENAT401TESZ0','1','D','01','273',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','22','(''UA''=''T,'')','ENAT401TESZ0','100','D','01','274',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','23','(''UA''=''T,'')','ENAT401TESZ0','12','D','01','374',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDiviisonCode"','24','(''UA''=''T,'')','ENAT401TESZ0','20','D','01','386',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGrossAnnualSalary"','25','(''UA''=''T,'')','ENAT401TESZ0','12','D','01','406',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','26','(''UA''=''T,'')','ENAT401TESZ0','8','D','01','418',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoEnrollmentStatus"','27','(''UA''=''T,'')','ENAT401TESZ0','1','D','01','426',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAutoEnrollmentDate"','28','(''UA''=''T,'')','ENAT401TESZ0','8','D','01','427',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTaxDeferral"','29','(''UA''=''T,'')','ENAT401TESZ0','6','D','01','435',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothDeferralPercentageElection"','30','(''UA''=''T,'')','ENAT401TESZ0','6','D','01','441',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTaxDollarElection"','31','(''UA''=''T,'')','ENAT401TESZ0','10','D','01','447',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRothDollarElection"','32','(''UA''=''T,'')','ENAT401TESZ0','10','D','01','457',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneNumber"','33','(''UA''=''T,'')','ENAT401TESZ0','10','D','01','467',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFaxNumber"','34','(''UA''=''T,'')','ENAT401TESZ0','10','D','01','477',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationshipToOwner"','35','(''UA''=''T,'')','ENAT401TESZ0','2','D','01','487',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelatedOwnerSSN"','36','(''UA''=''T,'')','ENAT401TESZ0','9','D','01','489',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpType"','37','(''UA''=''T,'')','ENAT401TESZ0','1','D','01','498',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDoD"','38','(''UA''=''T'')','ENAT401TESZ0','8','D','01','499',NULL,NULL,NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ENAT401TES_20211104.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'ACTIVE OE','201507159','EMPEXPORT','ACTIVEOE','Jul 17 2015 12:00AM','ENAT401TES',NULL,NULL,NULL,'201507159','Jul 15 2015 12:00AM','Dec 30 1899 12:00AM','201507151',NULL,'','','201507151',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPIINC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','KZ21X',NULL,NULL,NULL,'NATIONWIDE CENSUS','201705249','EMPEXPORT','ENAT401TES','May 24 2017 12:00AM','ENAT401TES',NULL,NULL,NULL,'202110129','May 24 2017 12:00AM','Dec 30 1899 12:00AM','202110051','442','','','201705101',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPIINC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'PASSIVE OE','201505201','EMPEXPORT','PASSIVEOE','May 20 2015 12:00AM','ENAT401TES',NULL,NULL,NULL,'201505201','May 20 2015 12:00AM','Dec 30 1899 12:00AM','201505201',NULL,'','','201505201',dbo.fn_GetTimedKey(),NULL,'ULTI_WPPIINC',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'NATIONWIDE - CENSUS TEST','202110229','EMPEXPORT','TEST','Oct 27 2021  8:22PM','ENAT401TES',NULL,NULL,NULL,'202110229','Oct 22 2021 12:00AM','Dec 30 1899 12:00AM','202110221','594','','','202110221',dbo.fn_GetTimedKey(),NULL,'us3jReLEE1002',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'unlock ENAT401TES','201412049','EMPEXPORT','ZAP',NULL,'ENAT401TES',NULL,NULL,NULL,'201412049',NULL,NULL,'201409051',NULL,NULL,NULL,'201409051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','ExportDescription','C','NATIONWIDE - CENSUS');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','InitialSort','C','drveeid');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','MaxFileLength','C','545');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','SystemID','V','AECRQZ0030K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENAT401TES','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ENAT401TES' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ENAT401TES' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ENAT401TES_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ENAT401TES_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENAT401TES','D01','dbo.U_dsi_ENAT401TES_drvTbl',NULL);
IF OBJECT_ID('U_dsi_ENAT401TES_DedHist') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401TES_DedHist] (
    [heeid] char(12) NULL,
    [hcoid] char(5) NULL,
    [hdedcode] char(5) NOT NULL,
	pdheecalcrateorpct varchar(50) NULL,
    [heecalcrateorpct] decimal NULL,
    [heeamt] money NULL,
    [heramt] money NULL,
    [PdhPayDate] datetime NULL
);
IF OBJECT_ID('U_dsi_ENAT401TES_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ENAT401TES_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvTransType] varchar(6) NOT NULL,
    [drvLineofBusiness] varchar(1) NOT NULL,
    [drvNationwideCaseNumber] varchar(9) NOT NULL,
    [drvEffDate] char(8) NULL,
    [drvSSN] char(11) NULL,
    [drvLname] varchar(8000) NULL,
    [drvFname] varchar(8000) NULL,
    [drvAddressLine1] varchar(6000) NULL,
    [drvAddressLine2] varchar(6000) NULL,
    [drvAddressLine3] varchar(6000) NULL,
    [drvAddressLine4] varchar(6000) NULL,
    [drvCity] varchar(6000) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(5) NULL,
    [drvZipCode] varchar(4) NULL,
    [drvDOH] char(8) NULL,
    [drvDOT] varchar(30) NOT NULL,
    [drvDateofPlanEntry] varchar(1) NOT NULL,
    [drvDOB] char(8) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] char(1) NULL,
    [drvEmail] varchar(50) NULL,
    [drvEmployeeID] char(9) NULL,
    [drvDiviisonCode] varchar(1) NOT NULL,
    [drvGrossAnnualSalary] money NULL,
    [drvRehireDate] varchar(8) NULL,
    [drvAutoEnrollmentStatus] varchar(1) NOT NULL,
    [drvAutoEnrollmentDate] varchar(1) NOT NULL,
    [drvPreTaxDeferral] varchar(30) NULL,
    [drvRothDeferralPercentageElection] varchar(30) NULL,
    [drvPreTaxDollarElection] varchar(1) NOT NULL,
    [drvRothDollarElection] varchar(1) NOT NULL,
    [drvPhoneNumber] varchar(50) NULL,
    [drvFaxNumber] varchar(1) NOT NULL,
    [drvRelationshipToOwner] varchar(1) NOT NULL,
    [drvRelatedOwnerSSN] varchar(1) NOT NULL,
    [drvEmpType] char(1) NULL,
    [drvDoD] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ENAT401TES_Audit') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_Audit] (
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
    [audLastTermDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ENAT401TES_AuditFields') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_ENAT401TES_EEList') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ENAT401TES_File') IS NULL
CREATE TABLE [dbo].[U_ENAT401TES_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENAT401TES]
 @systemid varchar(12) = ''
AS
Begin

/**********************************************************************
Client Name:     Lee Contracting, Inc.
Vendor: Nationwide 401k Census File
Created By: Garret Donovan
Business Analyst: Justin Holy
Create Date: 4/23/2018
Service Request Number: LEE1002-2018-00190100-Interface File

Changes:
07/26/2021      A.Stevens        SF 22322133                 commented out logic for drvPreTaxDollarElection, drvRothDollarElection

10/12/2021 by AP:
        - Test version ENAT401TES
        - Updated logic for Service Termination Date

11/04/2021 by AP:
		- Updated pre-tax and roth deferral amounts.

_dsi_usp_ExportRipout 'ENAT401TES','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'ENAT401TES' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ENAT401TES'
select * from dbo.U_dsi_Parameters where FormatCode = 'ENAT401TES'

select * from AscDefH where AdhFormatCode = 'ENAT401TES'
select * from AscExp where expFormatCode = 'ENAT401TES'
select * from ascdeff where AdfHeaderSystemID = 'ENAT401TESZ0' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'ENAT401TES'
DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'TEST'
DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'ACTIVEOE'
DSI_SP_TESTSWITCHBOX_V2 'ENAT401TES', 'PASSIVEOE'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ENAT401TES' AND CfgName = 'TESTING'

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ENAT401TES', @AllObjects = 'Y', @IsWeb = 'Y'

**************************/

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
        @ExportFile char(200)

    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile

    FROM dbo.U_Dsi_Parameters 
    WHERE formatcode = 'ENAT401TES'

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
            delete dbo.u_ENAT401TES_EELIST
            from dbo.u_ENAT401TES_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end

--Clean Up Prior Year Terms
        delete dbo.u_ENAT401TES_EELIST
            from dbo.u_ENAT401TES_EELIST left join empcomp on xeeid = eeceeid and xcoid = eeccoid
        where eecDateofTermination is not null
            and YEAR(eecDateOfTermination) <> YEAR(getdate())

--BDM
-- replace EROT401NOE with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','401CP,401K,ROTH') 

IF @ExportCode not in ( 'ACTIVEOE' ,'PASSIVEOE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)    --@EndDate - @daysstopped)    
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

IF @ExportCode in ( 'ACTIVEOE' ,'PASSIVEOE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'PASSIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END

IF @ExportCode = 'ACTIVEOE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active')    --'Active')
END

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

--- LAstpaydate

--    left join (select eeceeid eeid, eeccoid coid, pgppaydate lastcheck
--                from empcomp
--                join pgpayper on eecpaygroup = pgppaygroup
--                where eecdateoftermination >= pgpperiodstartdate
--                and eecdateoftermination <= pgpperiodenddate) ppd on eeid = xeeid and coid = xcoid

-- Step20 Clean up eelist if needed to only include employees with deductions
--            delete dbo.u_ENAT401TES_eelist
--            from dbo.u_ENAT401TES_eelist a
--            where not exists(select 1 from U_dsi_bdm_EmpDeductions
--                            where a.xeeid = eedeeid
--                            and a.xcoid = eedcoid
--                            and eedformatcode = @formatcode
--                            and eedvalidforexport = 'Y')

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ENAT401TES_EELIST
            from dbo.u_ENAT401TES_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ENAT401TES_eelist
            from dbo.u_ENAT401TES_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ENAT401TES_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--Remove test employees from file
            delete dbo.u_ENAT401TES_eelist
            from dbo.u_ENAT401TES_eelist 
            join emppers with (nolock) on xeeid = eepeeid
            where left(eepssn,5) = '99999'

--Clean up Terms from Deductions and EEList
--        delete U_dsi_bdm_EmpDeductions
--            from U_dsi_bdm_EmpDeductions left join empcomp on eedeeid = eeceeid
--        where eedFormatCode = @FormatCode
--            and eedValidForExport = 'Y'
--            and eecDateofTermination is not null
--            and @daysstopped + eecDateofTermination < getdate()
--
--        delete dbo.u_ENAT401TES_eelist
--            from dbo.u_ENAT401TES_eelist left join empcomp on xeeid = eeceeid and xcoid = eeccoid
--        where eecDateofTermination is not null
--            and @daysstopped + eecDateofTermination < getdate()

if object_id('U_dsi_ENAT401TES_DedHist') is not null
  drop table U_dsi_ENAT401TES_DedHist

SELECT
    xEEID heeid,
    xCOID hcoid,
    pdhdedcode hdedcode,
	pdheecalcrateorpct,
    SUM(ISNULL(pdhEECalcRateOrPct,0.00)) as heecalcrateorpct,
    SUM(ISNULL(PDHEECURAMT,0.00)) AS heeamt,
    SUM(ISNULL(PDHERCURAMT,0.00)) AS heramt, PdhPayDate

    INTO dbo.U_dsi_ENAT401TES_DedHist
        from dbo.u_ENAT401TES_EELIST 
    JOIN PDEDHIST (nolock) ON xeeid = PdhEEID and xCOID = PdhCOID
        AND (PDHEECURAMT <> 0 or PDHERCURAMT <> 0)
		  AND PDHDEDCODE IN ('401CP','401K','401KR')  
	 --   AND PDHDEDCODE IN ('401CP','401K','ROTH')    
--        AND PDHPERCONTROL BETWEEN '20040901' and '20040924'
        AND substring(PDHPERCONTROL,1,8) BETWEEN substring(@StartPerControl,1,8) and substring(@EndPerControl,1,8)
    GROUP BY xEEID,xCOID,PdhDedCode,pdhEECalcRateOrPct, PdhPayDate

---- AUDIT FOR TERM DATE ----
  --==========================================
    -- Audit Section
    --==========================================
 --   -- Get data from audit fields table. Add fields here if auditing
 --   IF OBJECT_ID('U_ENAT401TES_AuditFields','U') IS NOT NULL
 --       DROP TABLE dbo.U_ENAT401TES_AuditFields;
 --   CREATE TABLE dbo.U_ENAT401TES_AuditFields (aTableName varchar(30),aFieldName varchar(30));
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecAnnSalary');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecDateOfTermination');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecEmplStatus');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpComp','EecTermReason');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpDed','EedBenStartDate');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpDed','EedBenStopDate');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepDateOfBirth');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepGender');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameFirst');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameLast');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameMiddle');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepNameSuffix');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepOldSSN');
 --   INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpPers','EepSSN');
    --INSERT INTO dbo.U_ENAT401TES_AuditFields VALUES ('EmpHJob','EjhDateTimeCreated');


 --   -- Create audit table based on fields defined above
 --   IF OBJECT_ID('U_ENAT401TES_Audit','U') IS NOT NULL
 --       DROP TABLE dbo.U_ENAT401TES_Audit;

    --SELECT *, audLastTermDate = CASE WHEN audTerm = 'Y' AND audTableName = 'EmpHJob' AND audFieldName = 'EjhDateTimeCreated' AND ISNULL(audNewValue , '') <> '' THEN 'Y' ELSE 'N' END
    --INTO dbo.U_ENAT401TES_Audit
    --FROM
    --(
 --   SELECT 
 --       audEEID  = audKey1Value
 --       ,audKey2 = audKey2Value
 --       ,audKey3 = audKey3Value
 --       ,audTableName
 --       ,audFieldName
 --       ,audAction
 --       ,audDateTime
 --       ,audOldValue
 --       ,audNewValue
 --       ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
 --       ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
 --       ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
 --       ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
 --       ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
 --   FROM dbo.U_ENAT401TES_EEList WITH (NOLOCK)
 --   JOIN dbo.vw_AuditData WITH (NOLOCK) 
 --       ON audKey1Value = xEEID
 --   JOIN dbo.U_ENAT401TES_AuditFields WITH (NOLOCK) 
 --       ON audTableName = aTableName
 --       AND audFieldName = aFieldName
 --   WHERE audDateTime BETWEEN @StartDate AND @EndDate
 --   AND audAction <> 'DELETE'
 --   AND ISNULL(audNewValue,'') <> '') a;

--/****Create Table: U_ds_ENAT401TES_EarnsCUR***/

--if object_id('dbo.U_dsi_ENAT401TES_EarnsCUR') is not null
--  drop table dbo.U_dsi_ENAT401TES_EarnsCUR

--SELECT
--    xEEID eeeid,
--    xCOID ecoid,
--    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
--    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs

--INTO dbo.U_dsi_ENAT401TES_EarnsCUR
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST(nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,8) = substring(@EndPerControl,1,8)
--        AND pehInclInDefComp = 'Y'
--    ---    and pehearncode not in ('REGSF' ,'OTSF')
--    GROUP BY xEEID,xCOID

---- YTD Plan compensation
--if object_id('U_dsi_ENAT401TES_DefCompHist') is not null
--  drop table dbo.U_dsi_ENAT401TES_DefCompHist

--SELECT
--    xEEID dceeid,
--    xCOID dccoid,
--    SUM(ISNULL(pehCurAmt,0.00)) AS dcamt
--    --SUM(ISNULL(pehCurHrs,0.00)) AS dchrs

--    INTO dbo.U_dsi_ENAT401TES_DefCompHist
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
--        AND pehInclInDefComp = 'Y'
--        ---and pehearncode not in ('REGSF' ,'OTSF')
--    GROUP BY xEEID,xCOID

---- YTD hours
--if object_id('U_dsi_ENAT401TES_YTDHrs') is not null
--  drop table dbo.U_dsi_ENAT401TES_YTDHrs

--SELECT
--    xEEID yheeid,
--    xCOID yhcoid,
--    SUM(ISNULL(pehCurHrs,0.00)) AS yhhrs

--    INTO dbo.U_dsi_ENAT401TES_YTDHrs
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
--        AND pehInclInDefComp = 'Y'
--    --    and pehearncode not in ('REGSF' ,'OTSF')
--    GROUP BY xEEID,xCOID

-----

---- YTD Plan compensation W2
--if object_id('U_dsi_ENAT401TES_DefCompHistW2') is not null
--  drop table dbo.U_dsi_ENAT401TES_DefCompHistW2

--SELECT
--    xEEID dceeid,
--    xCOID dccoid,
--    SUM(ISNULL(pehCurAmt,0.00)) AS dcamt,
--    SUM(ISNULL(pehCurHrs,0.00)) AS dchrs

--    INTO dbo.U_dsi_ENAT401TES_DefCompHistW2
--        from dbo.u_ENAT401TES_EELIST 
--    JOIN PEARHIST (nolock) ON xeeid = pehEEID and xCOID = PehCOID
--        AND substring(pehPerControl,1,4) = substring(@EndPerControl,1,4)
--        ---AND pehInclInDefComp = 'Y'
--    GROUP BY xEEID,xCOID

-- Populate Source for Employees

if object_id('U_dsi_ENAT401TES_drvTbl') is not null
  drop table dbo.U_dsi_ENAT401TES_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below

            drvTransType = 'CENSUS',
            drvLineofBusiness  = '1', 
            drvNationwideCaseNumber  = '442-80187',
            drvEffDate  = convert(char(8),GETDATE(),112),
            drvSSN  = eepSSN,
            drvLname  = REPLACE(EepNameLast,',',''),
            drvFname  = REPLACE(EepNameFirst,',',''),
            drvAddressLine1  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine1),
            drvAddressLine2  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine2),
            drvAddressLine3  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine3),
            drvAddressLine4  = dbo.dsi_fnRemoveChars('.,/',EepAddressLine4),
            drvCity  = dbo.dsi_fnRemoveChars('.,/',EepAddressCity),
            drvState  = EepAddressState,
            drvZip  = substring(EepAddressZipCode,1,5),
            drvZipCode  = substring(EepAddressZipCode,6,4),
            drvDOH  = convert(char(8),eecdateoforiginalhire,112),
            drvDOT  = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus IN ('R', 'T') THEN EecDateOfTermination 
                            WHEN EecEmplStatus NOT IN ('R', 'T') AND EecDateOfOriginalHire <> EecDateOfLastHire THEN ejh.EjhJobEffDate END), 112), ''),
            --CASE
   --                         WHEN EecEmplStatus = 'T' THEN convert(char(8),eecdateoftermination,112)
   --                 END,
            drvDateofPlanEntry  = '',
            drvDOB  = convert(char(8),eepdateofbirth,112),
            drvGender  = EepGender,
            drvMaritalStatus  = eepmaritalstatus,
            drvEmail  = case when eepAddressEMail not like '%_@__%.__%' then '' else eepaddressemail end,
            drvEmployeeID  = EecEmpNo,
            drvDiviisonCode  = '',
            drvGrossAnnualSalary  = EecAnnSalary,
            drvRehireDate  = case when eecdateoforiginalhire <  eecdateoflasthire then convert(char(8),EecDateOfLastHire,112) else '' end,
            drvAutoEnrollmentStatus  = '',
            drvAutoEnrollmentDate  = '',--convert(char(8),eepdateofbirth,112),
            drvPreTaxDeferral  = CAST(CAST(CASE WHEN k.PdhEECalcRateOrPct > '.9999' THEN '99.99' ELSE k.PdhEECalcrateOrPct * 100 END AS DECIMAL(4,2)) AS VARCHAR),
			--convert(varchar,K.pct),--percentage
            drvRothDeferralPercentageElection  = CAST(CAST(CASE WHEN rf.PdhEECalcRateOrPct > '.9999' THEN '99.99' ELSE rf.PdhEECalcrateOrPct * 100 END AS DECIMAL(4,2)) AS VARCHAR) ,
			--convert(varchar,RF.pct), --percentage
            drvPreTaxDollarElection  = '',--convert(varchar,K.eeamt),-- dollar A.S. 07/26/21
            drvRothDollarElection  = '',--convert(varchar,RF.eeamt),--dollar A.S. 07/26/21
            drvPhoneNumber  = EepPhoneHomeNumber,
            drvFaxNumber  = '',
            drvRelationshipToOwner  = '',
            drvRelatedOwnerSSN  = '',
            drvEmpType  = EecSalaryOrHourly,
            drvDoD  = ''--convert(char(8),eepdateofbirth,112)

  into dbo.U_dsi_ENAT401TES_drvTbl
  from dbo.u_ENAT401TES_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join empcomp with (nolock) on xEEID = eecEEid and xCOID = eecCOID 
    --left join (select eeeid, ecoid, eamt, ehrs from dbo.U_dsi_ENAT401TES_EarnsCUR) earn on earn.eeeid = xEEID and earn.ecoid = xCOID
    --left join dbo.U_dsi_ENAT401TES_DefCompHist D on D.dceeid = xeeid and D.dccoid = xcoid
    --left join dbo.U_dsi_ENAT401TES_EarnsCUR C on C.eeeid = xeeid and C.ecoid = xcoid
    --join dbo.U_dsi_ENAT401TES_DefCompHist W2 on W2.dceeid = xeeid and W2.dccoid = xcoid
    --left join dbo.U_dsi_ENAT401TES_YTDHrs YH on yh.yheeid = xEEID and yh.yhcoid = xCOID
    --left join U_dsi_ENAT401TES_DedHist dh on dh.heeid = xEEID and dh.hcoid = xCOID

--('401CF','401CP','401F','401P','401M','401RF','401RP','40CFR','40CPR' ,'401L','401L2')    

--401K Contribution    
    left join(select heeid eeid, hcoid coid, pdheecalcrateorpct, sum(heeamt) eeamt, sum(heramt) eramt, sum(heecalcrateorpct) pct
        from dbo.U_dsi_ENAT401TES_DedHist
        where hdedcode in ('401K','401CP')
        group by heeid, hcoid, pdheecalcrateorpct) K on K.eeid = xEEID and K.coid = xCOID



--Roth
    left join(select heeid eeid, hcoid coid, PdhEECalcRateOrPct, sum(heeamt) eeamt, sum(heramt) eramt, sum(heecalcrateorpct) pct
        from dbo.U_dsi_ENAT401TES_DedHist
        where hdedcode in ('401KR')
        group by heeid, hcoid, PdhEECalcRateOrPct) RF on RF.eeid = xEEID and RF.coid = xCOID
    left join (select EjhEEID, EjhCOID, MAX(EjhJobEffDate) AS EjhJobEffDate
                from dbo.EmpHJob WITH(NOLOCK)
                where ejhemplstatus = 't'
                GROUP BY EjhEEID, EjhCOID) ejh on ejh.ejheeid = xeeid and ejh.ejhcoid = xcoid
    --LEFT JOIN (SELECT audEEID, audKey2 AS audCOID, MAX(audDateTime) AS audDateTime
    --            FROM dbo.U_ENAT401TES_Audit
    --            WHERE audTerm = 'Y'
    --            GROUP BY audEEID, audKey2) aud ON aud.audEEID = xEEID AND aud.audCOID = xCOID

----Roth catch up
--    left join(select heeid eeid, hcoid coid, sum(heeamt) eeamt, sum(heramt) eramt, sum(heecalcrateorpct) pct
--        from dbo.U_dsi_ENAT401TES_DedHist
--        where hdedcode in ('XXXXX')
--        group by heeid, hcoid) RP on RP.eeid = xEEID and RP.coid = xCOID


 ---Set FileName  
if (dbo.dsi_fnVariable('ENAT401TES','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'ENAT401TES' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'ENAT401TES'

--select distinct eecishighlycomp from empcomp

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwENAT401TES_Export as
       select top 2000000 left(data,(len(data))) as data from dbo.U_ENAT401TES_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 else 2 end,
            initialsort, subsort, substring(Recordset,2,2)
*/

--Used for testing
--dbo.dsi_sp_TestSwitchbox 'ENAT401TES','ENAT401TES'
--dbo.dsi_sp_TestSwitchbox_v2 'ENAT401TES','TEST'
--dbo.dsi_sp_TestSwitchbox 'ENAT401TES','zap'

END

--select * from pdedhist
--select * from empded
GO
Create View dbo.dsi_vwENAT401TES_Export as
                            select top 200000000 Data from dbo.U_ENAT401TES_File with (nolock)
                            order by substring(RecordSet,2,2), InitialSort