SET NOCOUNT ON;
IF OBJECT_ID('U_EAPAFHSAXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAPAFHSAXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EAPAFHSAXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EAPAFHSAXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEAPAFHSAXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEAPAFHSAXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EAPAFHSAXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAPAFHSAXP];
GO
IF OBJECT_ID('U_EAPAFHSAXP_File') IS NOT NULL DROP TABLE [dbo].[U_EAPAFHSAXP_File];
GO
IF OBJECT_ID('U_EAPAFHSAXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EAPAFHSAXP_EEList];
GO
IF OBJECT_ID('U_EAPAFHSAXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EAPAFHSAXP_drvTbl];
GO
IF OBJECT_ID('U_EAPAFHSAXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EAPAFHSAXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EAPAFHSAXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EAPAFHSAXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EAPAFHSAXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EAPAFHSAXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EAPAFHSAXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EAPAFHSAXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EAPAFHSAXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EAPAFHSAXP','APA HSA FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EAPAFHSAXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EAPAFHSAXP' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','1','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','1',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Termination Date"','2','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','2',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','3','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','3',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Start Date"','4','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','4',NULL,'Benefit Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN#"','5','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','5',NULL,'SSN#',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','6','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Midlle"','7','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','7',NULL,'Midlle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Fist"','8','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','8',NULL,'Fist',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','9','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','9',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Hire"','10','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','10',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address"','11','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','11',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','12','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','12',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','13','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','13',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','14','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','14',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"home phone (no dashes)"','15','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','15',NULL,'home phone (no dashes)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Email"','16','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','16',NULL,'Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FSA Election Annual Amount"','17','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','17',NULL,'FSA Election Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LFSA Election Annual Amount"','18','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','18',NULL,'LFSA Election Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DCAP Election Annual Amount"','19','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','19',NULL,'DCAP Election Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSA Elelction Annual Amount"','20','(''DA''=''T,'')','EAPAFHSAXPZ0','50','H','01','20',NULL,'HSA Elelction Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Debit Card Access Y/N"','21','(''DA''=''T'')','EAPAFHSAXPZ0','50','H','01','21',NULL,'Debit Card Access Y/N',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','1','(''UD101''=''T,'')','EAPAFHSAXPZ0','50','D','10','1',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','2','(''UD101''=''T,'')','EAPAFHSAXPZ0','50','D','10','2',NULL,'Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','3','(''UD101''=''T,'')','EAPAFHSAXPZ0','50','D','10','3',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitStartDate"','4','(''UD101''=''T,'')','EAPAFHSAXPZ0','50','D','10','4',NULL,'Benefit Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','5',NULL,'SSN#',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','7','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','7',NULL,'Midlle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','8','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','8',NULL,'Fist',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','9','(''UD101''=''T,'')','EAPAFHSAXPZ0','50','D','10','9',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfHire"','10','(''UD101''=''T,'')','EAPAFHSAXPZ0','50','D','10','10',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress"','11','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','11',NULL,'Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','12','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','12',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','13','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','13',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','14','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','14',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','15','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','15',NULL,'home phone (no dashes)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkEmail"','16','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','16',NULL,'Work Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSAelectionAmount"','17','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','17',NULL,'FSA Election Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLFSAElectionAmount"','18','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','18',NULL,'LFSA Election Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDCAPElectionmount"','19','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','19',NULL,'DCAP Election Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHSAElectionAmount"','20','(''UA''=''T,'')','EAPAFHSAXPZ0','50','D','10','20',NULL,'HSA Elelction Annual Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','21','(''DA''=''T'')','EAPAFHSAXPZ0','50','D','10','21',NULL,'Debit Card Access Y/N',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EAPAFHSAXP_20210204.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202102019','EMPEXPORT','OEACTIVE','Feb  1 2021  4:57PM','EAPAFHSAXP',NULL,NULL,NULL,'202102019','Feb  1 2021  4:27PM','Feb  1 2021  4:27PM','202102011','1','','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment Export','202102019','EMPEXPORT','OEPASSIVE','Feb  1 2021  4:58PM','EAPAFHSAXP',NULL,NULL,NULL,'202102019','Feb  1 2021  4:27PM','Feb  1 2021  4:27PM','202102011','224','','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'APA HSA FSA Export','202102019','EMPEXPORT','ONDEM_XOE','Feb  1 2021  4:58PM','EAPAFHSAXP',NULL,NULL,NULL,'202102019','Feb  1 2021  4:27PM','Feb  1 2021  4:27PM','202102011','224','','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'APA HSA FSA Export-Sched','202102019','EMPEXPORT','SCH_EAPAFH','Feb  1 2021  4:58PM','EAPAFHSAXP',NULL,NULL,NULL,'202102019','Feb  1 2021  4:27PM','Feb  1 2021  4:27PM','202102011','224','','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'APA HSA FSA Export-Test','202102021','EMPEXPORT','TEST_XOE','Feb  2 2021  6:36PM','EAPAFHSAXP',NULL,NULL,NULL,'202102021','Feb  2 2021 12:00AM','Dec 30 1899 12:00AM','202101191','233','','','202101191',dbo.fn_GetTimedKey(),NULL,'us3cPeCRO1008',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAPAFHSAXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAPAFHSAXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAPAFHSAXP','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAPAFHSAXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EAPAFHSAXP','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EAPAFHSAXP' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EAPAFHSAXP' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EAPAFHSAXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EAPAFHSAXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAPAFHSAXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EAPAFHSAXP','D10','dbo.U_EAPAFHSAXP_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EAPAFHSAXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EAPAFHSAXP] (
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
IF OBJECT_ID('U_EAPAFHSAXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EAPAFHSAXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EAPAFHSAXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EAPAFHSAXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort] varchar(1) NOT NULL,
    [drvHireDate] datetime NULL,
    [drvTerminationDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvBenefitStartDate] datetime NULL,
    [drvSSN] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvDateOfBirth] datetime NULL,
    [drvDateOfHire] datetime NULL,
    [drvAddress] varchar(8000) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvHomePhone] varchar(50) NULL,
    [drvWorkEmail] varchar(50) NULL,
    [drvFSAelectionAmount] nvarchar(4000) NULL,
    [drvLFSAElectionAmount] nvarchar(4000) NULL,
    [drvDCAPElectionmount] nvarchar(4000) NULL,
    [drvHSAElectionAmount] nvarchar(4000) NULL
);
IF OBJECT_ID('U_EAPAFHSAXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EAPAFHSAXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EAPAFHSAXP_File') IS NULL
CREATE TABLE [dbo].[U_EAPAFHSAXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EAPAFHSAXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Cross Country

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 02/01/2021
Service Request Number: TekP-2020-12-08-003

Purpose: APA HSA FSA Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EAPAFHSAXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EAPAFHSAXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EAPAFHSAXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EAPAFHSAXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EAPAFHSAXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAPAFHSAXP', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAPAFHSAXP', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAPAFHSAXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAPAFHSAXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EAPAFHSAXP', 'SCH_EAPAFH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EAPAFHSAXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EAPAFHSAXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EAPAFHSAXP';

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
    DELETE FROM dbo.U_EAPAFHSAXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EAPAFHSAXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    DELETE FROM dbo.U_EAPAFHSAXP_EEList where xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WHERE EecEEType IN ('TES','Z')
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSAD,FSAL,FSAM,HSFC,HSIC,HSFTF,HSF,HSITF,HSI';

    IF OBJECT_ID('U_EAPAFHSAXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EAPAFHSAXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EAPAFHSAXP_DedList
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
    -- DETAIL RECORD - U_EAPAFHSAXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EAPAFHSAXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EAPAFHSAXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvHireDate = EecDateOfOriginalHire
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvBenefitStartDate = BdmBenStartDate
        ,drvSSN = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameMiddle = EepNameMiddle
        ,drvNameFirst = EepNameFirst
        ,drvDateOfBirth = EepDateOfBirth
        ,drvDateOfHire = EecDateOfOriginalHire
        ,drvAddress = REPLACE(RTRIM(ISNULL(EepAddressLine1, '') + ' ' + ISNULL(EepAddressLine2, '')), ',', '')
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvHomePhone = EepPhoneHomeNumber
        ,drvWorkEmail = EepAddressEMail
        ,drvFSAelectionAmount = FORMAT(CASE WHEN FSAM_DedCode IS NOT NULL THEN FSAM_GoalAmt END, '#0.00')
        ,drvLFSAElectionAmount = FORMAT(CASE WHEN FSAL_DedCode IS NOT NULL THEN FSAL_GoalAmt END, '#0.00')
        ,drvDCAPElectionmount = FORMAT(CASE WHEN FSAD_DedCode IS NOT NULL THEN FSAD_GoalAmt END, '#0.00')
        ,drvHSAElectionAmount = FORMAT(
                                        CASE WHEN HSFC_DedCode IS NOT NULL THEN HSFC_GoalAmt
                                            WHEN HSIC_DedCode IS NOT NULL THEN HSIC_GoalAmt
                                            WHEN HSFTF_DedCode IS NOT NULL THEN HSFTF_GoalAmt
                                            WHEN HSF_DedCode IS NOT NULL THEN HSF_GoalAmt
                                            WHEN HSITF_DedCode IS NOT NULL THEN HSITF_GoalAmt
                                            WHEN HSI_DedCode IS NOT NULL THEN HSI_GoalAmt
                                        END
                                    , '#0.00')
    INTO dbo.U_EAPAFHSAXP_drvTbl
    FROM dbo.U_EAPAFHSAXP_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_EAPAFHSAXP WITH (NOLOCK)
    JOIN (
            SELECT BdmEEID, BdmCOID
    ,MAX(CASE WHEN BdmDedCode = 'FSAM' THEN BdmDedCode END) AS FSAM_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'FSAL' THEN BdmDedCode END) AS FSAL_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'FSAD' THEN BdmDedCode END) AS FSAD_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'HSFC' THEN BdmDedCode END) AS HSFC_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'HSIC' THEN BdmDedCode END) AS HSIC_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'HSFTF' THEN BdmDedCode END) AS HSFTF_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'HSF' THEN BdmDedCode END) AS HSF_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'HSITF' THEN BdmDedCode END) AS HSITF_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'HSI' THEN BdmDedCode END) AS HSI_DedCode
    ,MAX(CASE WHEN BdmDedCode = 'FSAM' THEN BdmEEGoalAmt END) AS FSAM_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'FSAL' THEN BdmEEGoalAmt END) AS FSAL_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'FSAD' THEN BdmEEGoalAmt END) AS FSAD_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'HSFC' THEN BdmEEGoalAmt END) AS HSFC_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'HSIC' THEN BdmEEGoalAmt END) AS HSIC_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'HSFTF' THEN BdmEEGoalAmt END) AS HSFTF_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'HSF' THEN BdmEEGoalAmt END) AS HSF_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'HSITF' THEN BdmEEGoalAmt END) AS HSITF_GoalAmt
    ,MAX(CASE WHEN BdmDedCode = 'HSI' THEN BdmEEGoalAmt END) AS HSI_GoalAmt
    ,MAX(BdmBenStartDate) AS BdmBenStartDate
FROM dbo.U_dsi_BDM_EAPAFHSAXP WITH (NOLOCK)
GROUP BY BdmEEID, BdmCOID) AS Bdm
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
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
ALTER VIEW dbo.dsi_vwEAPAFHSAXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EAPAFHSAXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EAPAFHSAXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101251'
       ,expStartPerControl     = '202101251'
       ,expLastEndPerControl   = '202102019'
       ,expEndPerControl       = '202102019'
WHERE expFormatCode = 'EAPAFHSAXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEAPAFHSAXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EAPAFHSAXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort