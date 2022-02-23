SET NOCOUNT ON;
IF OBJECT_ID('U_EDOENYLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDOENYLEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDOENYLEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDOENYLEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDOENYLEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDOENYLEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDOENYLEXP];
GO
IF OBJECT_ID('U_EDOENYLEXP_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_Trailer];
GO
IF OBJECT_ID('U_EDOENYLEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_PEarHist];
GO
IF OBJECT_ID('U_EDOENYLEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_PDedHist];
GO
IF OBJECT_ID('U_EDOENYLEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_File];
GO
IF OBJECT_ID('U_EDOENYLEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_EEList];
GO
IF OBJECT_ID('U_EDOENYLEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_drvTbl];
GO
IF OBJECT_ID('U_EDOENYLEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDOENYLEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDOENYLEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDOENYLEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDOENYLEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDOENYLEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDOENYLEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDOENYLEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDOENYLEXP','NYLife Health and Welfare Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EDOENYLEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDOENYLEXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee SSN"','1','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee First Name"','2','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','2',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Last Name"','3','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','3',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee Middle Name"','4','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','4',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRMEDPR (Pre Tax Primary Medical)"','5','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','5',NULL,'PRMEDPR (Pre Tax Primary Medical)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRDENPR (Pre Tax Primary Dental)"','6','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','6',NULL,'PRDENPR (Pre Tax Primary Dental)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRVISPR (Pre Tax Primary Vision)"','7','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','7',NULL,'PRVISPR (Pre Tax Primary Vision)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLIFPR (Post Tax Primary Life) EE Vol Life"','8','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','8',NULL,'POLIFPR (Post Tax Primary Life) EE Vol Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLIFDP (Post Tax Dependent Life) SP Vol Life"','9','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','9',NULL,'POLIFDP (Post Tax Dependent Life) SP Vol Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POLIFOT (Post Tax Other Life) CH Vol Life"','10','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','10',NULL,'POLIFOT (Post Tax Other Life) CH Vol Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POADDPR (Post Tax Primary) EE Vol ADD"','11','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','11',NULL,'POADDPR (Post Tax Primary) EE Vol ADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POADDOT (Post Tax Other ) CH Vol ADD"','12','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','12',NULL,'POADDOT (Post Tax Other ) CH Vol ADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"POPAIPR (Post Tax Personal) SP Vol AD"','13','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','113',NULL,'POPAIPR (Post Tax Personal) SP Vol AD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENPRE1 (General Pre Tax) Flexible Spending"','14','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','14',NULL,'GENPRE1 (General Pre Tax) Flexible Spending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GNPOST1 (General Post Tax1) Accidental Injury"','15','(''DA''=''T,'')','EDOENYLEXPZ0','50','H','01','15',NULL,'GNPOST1 (General Post Tax1) Accidental Injury',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GNPOST2 (General Post Tax2) Critical Illness"','16','(''DA''=''T'')','EDOENYLEXPZ0','50','H','01','16',NULL,'GNPOST2 (General Post Tax2) Critical Illness',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','1','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','1',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeFirstName"','2','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','2',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeLastName"','3','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','3',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeMiddleName"','4','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','4',NULL,'Employee Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPRMEDPR"','5','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','5',NULL,'PRMEDPR (Pre Tax Primary Medical)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPRDENPR"','6','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','6',NULL,'PRDENPR (Pre Tax Primary Dental)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPRVISPR"','7','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','7',NULL,'PRVISPR (Pre Tax Primary Vision)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPOLIFPR"','8','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','8',NULL,'POLIFPR (Post Tax Primary Life) EE Vol Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPOLIFDP"','9','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','9',NULL,'POLIFDP (Post Tax Dependent Life) SP Vol Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPOLIFOT"','10','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','10',NULL,'POLIFOT (Post Tax Other Life) CH Vol Life',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPOADDPR"','11','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','11',NULL,'POADDPR (Post Tax Primary) EE Vol ADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPOADDOT"','12','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','12',NULL,'POADDOT (Post Tax Other ) CH Vol ADD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPOPAIPR"','13','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','113',NULL,'POPAIPR (Post Tax Personal) SP Vol AD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGENPRE1"','14','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','14',NULL,'GENPRE1 (General Pre Tax) Flexible Spending',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGNPOST1"','15','(''UA''=''T,'')','EDOENYLEXPZ0','50','D','10','15',NULL,'GNPOST1 (General Post Tax1) Accidental Injury',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGNPOST2"','16','(''UA''=''T'')','EDOENYLEXPZ0','50','D','10','16',NULL,'GNPOST2 (General Post Tax2) Critical Illness',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDOENYLEXP_20210912.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202107289','EMPEXPORT','OEACTIVE',NULL,'EDOENYLEXP',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202107289','EMPEXPORT','OEPASSIVE',NULL,'EDOENYLEXP',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'NYLife FMLA Export','202107289','EMPEXPORT','ONDEM_XOE',NULL,'EDOENYLEXP',NULL,NULL,NULL,'202107289','Jul 28 2021  7:05PM','Jul 28 2021  7:05PM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'NYLife FMLA Export-Sched','202109121','EMPEXPORT','SCH_EDOLHW','Sep 12 2021 12:00AM','EDOENYLEXP',NULL,NULL,NULL,'202109121','Sep 12 2021 12:00AM','Dec 30 1899 12:00AM','202109011',NULL,'','','202109011',dbo.fn_GetTimedKey(),NULL,'us3mLaDOE1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'NYLife FMLA Export-Test','202109081','EMPEXPORT','TEST_XOE','Sep  8 2021  3:33PM','EDOENYLEXP',NULL,NULL,NULL,'202109081','Sep  8 2021 12:00AM','Dec 30 1899 12:00AM','202109011','1216','','','202109011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDOENYLEXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDOENYLEXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDOENYLEXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDOENYLEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDOENYLEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDOENYLEXP','D10','dbo.U_EDOENYLEXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EDOENYLEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDOENYLEXP] (
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
IF OBJECT_ID('U_EDOENYLEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EDOENYLEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDOENYLEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EDOENYLEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEmployeeFirstName] varchar(100) NULL,
    [drvEmployeeLastName] varchar(100) NULL,
    [drvEmployeeMiddleName] varchar(50) NULL,
    [drvPRMEDPR] nvarchar(4000) NULL,
    [drvPRDENPR] nvarchar(4000) NULL,
    [drvPRVISPR] nvarchar(4000) NULL,
    [drvPOLIFPR] nvarchar(4000) NULL,
    [drvPOLIFDP] nvarchar(4000) NULL,
    [drvPOLIFOT] nvarchar(4000) NULL,
    [drvPOADDPR] nvarchar(4000) NULL,
    [drvPOADDOT] nvarchar(4000) NULL,
    [drvPOPAIPR] nvarchar(4000) NULL,
    [drvGENPRE1] nvarchar(4000) NULL,
    [drvGNPOST1] nvarchar(4000) NULL,
    [drvGNPOST2] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EDOENYLEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EDOENYLEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDOENYLEXP_File') IS NULL
CREATE TABLE [dbo].[U_EDOENYLEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EDOENYLEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDOENYLEXP_PDedHist] (
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
IF OBJECT_ID('U_EDOENYLEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDOENYLEXP_PEarHist] (
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
IF OBJECT_ID('U_EDOENYLEXP_Trailer') IS NULL
CREATE TABLE [dbo].[U_EDOENYLEXP_Trailer] (
    [drvFileRecordIdentifier] varchar(2) NOT NULL,
    [drvDUNSNumber] varchar(9) NOT NULL,
    [drvReserved] varchar(1) NOT NULL,
    [drvNumberofRecords] varchar(30) NULL,
    [drvReserved2] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDOENYLEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Doe Run

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 09/12/2021
Service Request Number: TekP-2021-08-10-0003

Purpose: NY Life Health and Welfare

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDOENYLEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDOENYLEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDOENYLEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDOENYLEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDOENYLEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLEXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLEXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDOENYLEXP', 'SCH_EDOENY';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDOENYLEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDOENYLEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9)
            ,@Last52WeekPerControl as VARCHAR(10) ;

    -- Set FormatCode
    SELECT @FormatCode = 'EDOENYLEXP';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;


    SELECT @Last52WeekPerControl =  CONVERT(VARCHAR(12),DATEADD(week,-52, @StartDate),112) + '1'
    PRINT 'Last 52 Weeks ' + @Last52WeekPerControl
    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EDOENYLEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDOENYLEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EDOENYLEXP_EEList
    WHERE  xEEID IN (    Select distinct eeceeid from dbo.EmpComp where eeceetype = 'TES' );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ALFE2,ALFE3,ALFE4,ALFE5,ALFE6,LIFS1,LIFS2,LIFS3,LIFS4,LIFS5,LIFC1,ALIFC,ADDE1,EADD1,EADD2,EADD3,EADD4,EADD5,ADDS1,ADDS2,ADDS3,ADDS4,ADDS5,ADDC1,AHSA,APPO,AEPO,ATRA,DHO,FSA,VSNDR,CRTL1,CRTL2,CRTL3,CRTL4,ACCI ,AFLAC';

    IF OBJECT_ID('U_EDOENYLEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDOENYLEXP_DedList
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

    EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDOENYLEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLEXP_PDedHist;
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
    INTO dbo.U_EDOENYLEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDOENYLEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EDOENYLEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLEXP_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >=  @Last52WeekPerControl and PehPerControl <= @StartPerControl  and pehEarnCode in ('DT', 'HOL', 'HTR', 'JURY', 'MTGS', 'ORIEN', 'OT', 'OTTMP', 'REG', 'SOT', 'TRAIN', 'WKLRN') THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EDOENYLEXP_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE  PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    
    --Audit Table
    IF OBJECT_ID('U_EDOENYLEXPAuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLEXPAuditFields;
    CREATE TABLE dbo.U_EDOENYLEXPAuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EDOENYLEXPAuditFields VALUES ('EmpComp','EecEmplStatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EDOENYLEXPAudit','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLEXPAudit;
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
    INTO dbo.U_EDOENYLEXPAudit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EDOENYLEXPAuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EDOENYLEXPAuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN @StartDate AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EDOENYLEXPAudit ON dbo.U_EDOENYLEXPAudit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EDOENYLEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EDOENYLEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDOENYLEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        -- standard fields above and additional driver fields below
        ,drvInitialSort = eepssn
        ,drvSubSort = ''
        ,drvEmployeeSSN =  eepssn
        ,drvEmployeeFirstName = eepnamefirst
        ,drvEmployeeLastName =  eepNameLast
        ,drvEmployeeMiddleName =  eepnamemiddle
        ,drvPRMEDPR = FORMAT(PRMEDPR,'N2')
        ,drvPRDENPR = FORMAT(PRDENPR,'N2')
        ,drvPRVISPR = FORMAT(PRVISPR,'N2')
        ,drvPOLIFPR = FORMAT(POLIFPR,'N2')
        ,drvPOLIFDP = FORMAT(POLIFDP,'N2')
        ,drvPOLIFOT = FORMAT(POLIFOT,'N2')
        ,drvPOADDPR = FORMAT(POADDPR,'N2')
        ,drvPOADDOT = FORMAT(POADDOT,'N2')
        ,drvPOPAIPR = FORMAT(POPAIPR,'N2')
        ,drvGENPRE1 = FORMAT(GENPRE1,'N2')
        ,drvGNPOST1 = FORMAT(GNPOST1,'N2')
        ,drvGNPOST2 = FORMAT(GNPOST2,'N2')
    INTO dbo.U_EDOENYLEXP_drvTbl
    FROM dbo.U_EDOENYLEXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
         and eecEmplStatus in ('A','L')
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    /*
    LEFT JOIN (Select  bdmEEID,bdmcoid
            ,PRMEDPR = MAX((CASE WHEN bdmDedCode IN('AHSA', 'APPO', 'AEPO','ATRA') then bdmDedCode END))
            ,PRDENPR = MAX((CASE WHEN bdmDedCode IN('DHO')  then bdmDedCode END))
            ,PRVISPR = MAX((CASE WHEN bdmDedCode IN('VSNDR') then bdmDedCode END))
            ,POLIFPR = MAX((CASE WHEN bdmDedCode IN('ALFE2', 'ALFE3', 'ALFE4', 'ALFE5' ,'ALFE6')   then bdmDedCode END))
            ,POLIFDP = MAX((CASE WHEN bdmDedCode IN('LIFS1', 'LIFS2', 'LIFS3', 'LIFS4', 'LIFS5')   then bdmDedCode END))
            ,POLIFOT = MAX((CASE WHEN bdmDedCode IN('ALIFC')   then bdmDedCode END))
            ,POADDPR = MAX((CASE WHEN bdmDedCode IN('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5')   then bdmDedCode END))
            ,POADDOT = MAX((CASE WHEN bdmDedCode IN('ADDC1')   then bdmDedCode END))
            ,POPAIPR = MAX((CASE WHEN bdmDedCode IN('ADDS1', 'ADDS2', 'ADDS3', 'ADDS4', 'ADDS5')   then bdmDedCode END))
            ,GENPRE1 = MAX((CASE WHEN bdmDedCode IN('FSA')   then bdmDedCode END))
            ,GNPOST1 = MAX((CASE WHEN bdmDedCode IN('ACCI', 'AFLAC')   then bdmDedCode END))
            ,GNPOST2 = MAX((CASE WHEN bdmDedCode IN('CRTL1', 'CRTL2', 'CRTL3', 'CRTL4')   then bdmDedCode END))

            from U_dsi_BDM_EDOENYLEXP WITH (NOLOCK) 
            group by bdmEEID,bdmcoid) as BdmConsolidated
        ON xEEID =  bdmEEID 
        AND XCOID = bdmCOID*/
    LEFT JOIN (Select bcaeeid,bcacoid,
             PRMEDPR = MAX((CASE WHEN bcadedcode IN('AHSA', 'APPO', 'AEPO','ATRA') then bcaeeamt  else 0.00 END))
            ,PRDENPR = MAX((CASE WHEN bcadedcode IN('DHO')  then bcaeeamt else 0.00 END))
            ,PRVISPR = MAX((CASE WHEN bcadedcode IN('VSNDR') then bcaeeamt else 0.00  END))
            ,POLIFPR = MAX((CASE WHEN bcadedcode IN('ALFE2', 'ALFE3', 'ALFE4', 'ALFE5' ,'ALFE6')   then bcaeeamt else 0.00 END))
            ,POLIFDP = MAX((CASE WHEN bcadedcode IN('LIFS1', 'LIFS2', 'LIFS3', 'LIFS4', 'LIFS5')   then bcaeeamt else 0.00 END))
            ,POLIFOT = MAX((CASE WHEN bcadedcode IN('ALIFC')   then bcaeeamt else 0.00 END))
            ,POADDPR = MAX((CASE WHEN bcadedcode IN('ADDE1', 'EADD1', 'EADD2', 'EADD3', 'EADD4', 'EADD5')   then bcaeeamt else 0.00  END))
            ,POADDOT = MAX((CASE WHEN bcadedcode IN('ADDC1')   then bcaeeamt else 0.00 END))
            ,POPAIPR = MAX((CASE WHEN bcadedcode IN('ADDS1', 'ADDS2', 'ADDS3', 'ADDS4', 'ADDS5')   then bcaeeamt else 0.00  END))
            ,GENPRE1 = MAX((CASE WHEN bcadedcode IN('FSA')   then bcaeeamt else 0.00  END))
            ,GNPOST1 = MAX((CASE WHEN bcadedcode IN('ACCI', 'AFLAC')   then bcaeeamt else 0.00  END))
            ,GNPOST2 = MAX((CASE WHEN bcadedcode IN('CRTL1', 'CRTL2', 'CRTL3', 'CRTL4')   then bcaeeamt else 0.00  END))
 from [dbo].[U_dsi_bdm_BenCalculationAmounts]

 where bcaformatcode = @FormatCode 
 group by bcaeeid,bcacoid) as bdmAmount
    ON BdmAmount.bcaeeid = xeeid
    and bdmAmount.bcacoid  = xcoid
  

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
ALTER VIEW dbo.dsi_vwEDOENYLEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDOENYLEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDOENYLEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107211'
       ,expStartPerControl     = '202107211'
       ,expLastEndPerControl   = '202107289'
       ,expEndPerControl       = '202107289'
WHERE expFormatCode = 'EDOENYLEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDOENYLEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDOENYLEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort