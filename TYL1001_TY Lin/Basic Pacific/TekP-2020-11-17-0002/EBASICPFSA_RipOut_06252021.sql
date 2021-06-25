SET NOCOUNT ON;
IF OBJECT_ID('U_EBASICPFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EBASICPFSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EBASICPFSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEBASICPFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEBASICPFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EBASICPFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBASICPFSA];
GO
IF OBJECT_ID('U_EBASICPFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_File];
GO
IF OBJECT_ID('U_EBASICPFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_EEList];
GO
IF OBJECT_ID('U_EBASICPFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_DedList];
GO
IF OBJECT_ID('U_EBASICPFSA_AuditFields_Final') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_AuditFields_Final];
GO
IF OBJECT_ID('U_EBASICPFSA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_AuditFields];
GO
IF OBJECT_ID('U_EBASICPFSA_Audit') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EBASICPFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EBASICPFSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EBASICPFSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EBASICPFSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EBASICPFSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EBASICPFSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EBASICPFSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EBASICPFSA','Basic Pacific FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EBASICPFSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EBASICPFSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer ID"','1','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','1',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual ID"','2','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','2',NULL,'Individual ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','3','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual SSN"','4','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','4',NULL,'Individual SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','6','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Plan ID"','7','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','7',NULL,'Benefit Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Effective Date"','8','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','8',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Election Change Date"','9','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','9',NULL,'Election Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Eligibility End Date"','10','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','10',NULL,'Eligibility End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Individual Election Amount"','11','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','11',NULL,'Individual Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Client Election Amount"','12','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','12',NULL,'Client Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Disbursable Date"','13','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','13',NULL,'Disbursable Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Takeover Override"','14','(''DA''=''T,'')','EBASICPFSAZ0','50','H','01','14',NULL,'Takeover Override',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Coverage Tier"','15','(''DA''=''T'')','EBASICPFSAZ0','50','H','01','15',NULL,'Coverage Tier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployerID"','1','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','1',NULL,'Employer ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualID"','2','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','2',NULL,'Individual ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','3',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualSSN"','4','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','4',NULL,'Individual SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','5','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','5',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','6','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','6',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenefitPlanID"','7','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','7',NULL,'Benefit Plan ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','8','(''UD101''=''T,'')','EBASICPFSAZ0','50','D','10','8',NULL,'Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionChangeDate"','9','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','9',NULL,'Election Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligibilityEndDate"','10','(''UD101''=''T,'')','EBASICPFSAZ0','50','D','10','10',NULL,'Eligibility End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualElectionAmount"','11','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','11',NULL,'Individual Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientElectionAmount"','12','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','12',NULL,'Client Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisbursableDate"','13','(''UD101''=''T,'')','EBASICPFSAZ0','50','D','10','13',NULL,'Disbursable Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTakeoverOverride"','14','(''UA''=''T,'')','EBASICPFSAZ0','50','D','10','14',NULL,'Takeover Override',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoverageTier"','15','(''UA''=''T'')','EBASICPFSAZ0','50','D','10','15',NULL,'Coverage Tier',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EBASICPFSA_20210624.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202102019','EMPEXPORT','OEACTIVE',NULL,'EBASICPFSA',NULL,NULL,NULL,'202102019','Feb  1 2021  1:19PM','Feb  1 2021  1:19PM','202102011',NULL,'','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202102019','EMPEXPORT','OEPASSIVE',NULL,'EBASICPFSA',NULL,NULL,NULL,'202102019','Feb  1 2021  1:19PM','Feb  1 2021  1:19PM','202102011',NULL,'','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Basic Pacific FSA Export','202102019','EMPEXPORT','ONDEM_XOE',NULL,'EBASICPFSA',NULL,NULL,NULL,'202102019','Feb  1 2021  1:19PM','Feb  1 2021  1:19PM','202102011',NULL,'','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Basic Pacific FSA Export-Sched','202102019','EMPEXPORT','SCH_EBASIC',NULL,'EBASICPFSA',NULL,NULL,NULL,'202102019','Feb  1 2021  1:19PM','Feb  1 2021  1:19PM','202102011',NULL,'','','202102011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Basic Pacific FSA Export-Test','202104221','EMPEXPORT','TEST_XOE','Jun 24 2021 12:00AM','EBASICPFSA',NULL,NULL,NULL,'202104221','Apr 22 2021 12:00AM','Dec 30 1899 12:00AM','202104181','163','','','202104181',dbo.fn_GetTimedKey(),NULL,'us3cPeTYL1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASICPFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASICPFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASICPFSA','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASICPFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EBASICPFSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EBASICPFSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EBASICPFSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EBASICPFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EBASICPFSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBASICPFSA','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EBASICPFSA','D10','dbo.U_EBASICPFSA_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EBASICPFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EBASICPFSA] (
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
IF OBJECT_ID('U_EBASICPFSA_Audit') IS NULL
CREATE TABLE [dbo].[U_EBASICPFSA_Audit] (
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
    [audNewGoalAmt] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EBASICPFSA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EBASICPFSA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EBASICPFSA_Audit_Final') IS NULL
CREATE TABLE [dbo].[U_EBASICPFSA_Audit_Final] (
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
    [audNewGoalAmt] varchar(1) NOT NULL,
    [audNewStart] varchar(2000) NULL
);
IF OBJECT_ID('U_EBASICPFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EBASICPFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EBASICPFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EBASICPFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EBASICPFSA_File') IS NULL
CREATE TABLE [dbo].[U_EBASICPFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EBASICPFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: TY Lin

Created By: Inshan Singh
Business Analyst: Cheryl Petitti
Create Date: 02/01/2021
Service Request Number: TekP-2020-11-17-0002

Purpose: Basic Pacific FSA Export

Revision History
----------------
06/07/2021 by AP:
        - UPDATE statement for EffectiveDate for values < 01/01/2021.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EBASICPFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EBASICPFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EBASICPFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EBASICPFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EBASICPFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EBASICPFSA', 'SCH_EBASIC';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EBASICPFSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EBASICPFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@FileMinCovDate    DATETIME;

    -- Set FormatCode
    SELECT @FormatCode = 'EBASICPFSA';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
        ,@FileMinCovDate  = CONCAT(YEAR(GETDATE()), '0101')
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EBASICPFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EBASICPFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EBASICPFSA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_AuditFields;
    CREATE TABLE dbo.U_EBASICPFSA_AuditFields (aTableName varchar(30),aFieldName varchar(30));

    INSERT INTO dbo.U_EBASICPFSA_AuditFields VALUES ('EmpDed','EedEEGoalAmt');
    INSERT INTO dbo.U_EBASICPFSA_AuditFields VALUES ('EmpDed','EedBenStartDate');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EBASICPFSA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_Audit;
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
        ,audNewGoalAmt = CASE WHEN audTableName = 'EmpDed' AND audFieldName = 'EedEEGoalAmt' AND CONVERT(MONEY,isnULL(audNewValue, 0.00)) <> CONVERT(MONEY,isNULL(audOldValue,0.00)) AND audOldValue IS NOT NULL THEN 'Y' ELSE 'N' END
    INTO dbo.U_EBASICPFSA_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EBASICPFSA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE';

    IF OBJECT_ID('U_EBASICPFSA_Audit_Final','U') IS NOT NULL
       DROP TABLE dbo.U_EBASICPFSA_Audit_Final;

    select distinct a.*, c.audnewvalue as audNewStart
	into dbo.U_EBASICPFSA_Audit_Final
	from U_EBASICPFSA_Audit a outer apply (select top 1 audnewvalue from dbo.U_EBASICPFSA_Audit b where a.audeeid = b.audeeid and a.audkey2 = b.audkey2 and audkey3 = b.audkey3 and b.audfieldname = 'eedbenstartdate' order by auddatetime desc) c --left join U_EBASICPFSA_Audit b
	--on a.audeeid = b.audeeid and a.audkey2 = b.audkey2 and a.audkey3 = b.audkey3 and b.audfieldname = 'eedbenstartdate' 
	where --a.audeeid = '7WCM4Z0010K0'
	a.audfieldname = 'eedeegoalamt'
	--and a.audfieldname = 'eedeegoalamt'
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EBASICPFSA_Audit_Final ON dbo.U_EBASICPFSA_Audit_Final (audEEID,audKey2);

    --================
    -- Changes Only
    --================
    --DELETE FROM dbo.U_EBASICPFSA_EEList
    --WHERE NOT EXISTS (SELECT 1 FROM dbo.U_EBASICPFSA_Audit WHERE audEEID = xEEID AND audRowNo = 1);


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA19,DCA19,LPF19,LPT19' ;

    IF OBJECT_ID('U_EBASICPFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EBASICPFSA_DedList
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
    -- DETAIL RECORD - U_EBASICPFSA_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EBASICPFSA_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EBASICPFSA_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort = ''
        -- standard fields above and additional driver fields below
        ,drvEmployerID = '4119-8043-7263'
        ,drvIndividualID = '' --eepSSN -- leave blank
        ,drvEmployeeID = EecEmpNo
        ,drvIndividualSSN = eepSSN
        ,drvLastName = EepNameLast
        ,drvFirstName = EepNameFirst
        ,drvBenefitPlanID = CASE
                                WHEN EedDedCode = 'FSA19' THEN  '1000135099'
                                WHEN EedDedCode = 'DCA19' THEN  '1000135098'
                                WHEN EedDedCode IN ('LPF19', 'LPT19') THEN '1000135100'                                
                                -- change from below based on feedback
                                --WHEN EedDedCode = 'FSA19' THEN  'MRA'
                                --WHEN EedDedCode = 'DCA19' THEN  'DCA'
                                --WHEN EedDedCode IN ('LPF19', 'LPT19') THEN 'MLP'
                            END
        --,drvEffectiveDate = CASE WHEN EedDedCode in ('FSA19', 'DCA19', 'LPF19', 'LPT19') THEN dbo.dsi_fnGetMinMaxDates('MAX',EedBenStartDate, @FileMinCovDate)  END
        
        /*The file should send an effective date that starts on the 1st of each month following the EEs eligibility*/
        ,drvEffectiveDate = CASE WHEN EedDedCode IN ('FSA19', 'DCA19', 'LPF19', 'LPT19') THEN EedBenStartDate END --dbo.dsi_fnGetMinMaxDates('MAX', EedBenStartDate, @FileMinCovDate) END
         --CASE WHEN EedDedCode in ('FSA19', 'DCA19', 'LPF19', 'LPT19') THEN dbo.dsi_fnGetMinMaxDates('MAX'
                                                                                                                      --  ,case when DATEFROMPARTS(YEAR(EedBenStartDate),MONTH(EedBenStartDate),1) = CONVERT(DATE,EedBenStartDate,101) THEN EedBenStartDate else  DATEFROMPARTS(YEAR(EedBenStartDate),MONTH(DATEADD(M,1,EedBenStartDate)),1) end 
                                                                                                                      --  ,@FileMinCovDate)  END
        ,drvElectionChangeDate =  ISNULL(CONVERT(VARCHAR, (CASE WHEN EecDateOfOriginalHire BETWEEN @StartDate AND @EndDate THEN NULL
                                            WHEN audKey3 in ('FSA19', 'DCA19', 'LPF19','LPT19') AND audNewGoalAmt = 'Y' AND audDateTime BETWEEN @StartDate AND @EndDate
                                                 THEN audNewStart 
                                           
                                            END), 101), '')
        --CASE WHEN audKey3 in ('FSA19', 'DCA19', 'LPF19','LPT19') AND audNewGoalAmt = 'Y' THEN EedBenStartDate END
        ,drvEligibilityEndDate = CASE WHEN EedDedCode IN ('FSA19', 'DCA19', 'LPF19','LPT19') THEN EedBenStopDate END 
        ,drvIndividualElectionAmount = CASE WHEN EedDedCode IN ('FSA19', 'DCA19', 'LPF19','LPT19')THEN CONVERT(VARCHAR, CONVERT(MONEY,EedEEGoalAmt)) END 
        ,drvClientElectionAmount = '' -- leave blank
        ,drvDisbursableDate = '' -- leave blank
        ,drvTakeoverOverride = '' -- leave blank
        ,drvCoverageTier = '' -- leave blank
    INTO dbo.U_EBASICPFSA_drvTbl
    FROM dbo.U_EBASICPFSA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EBASICPFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = EedDedCode
        AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'
    LEFT JOIN dbo.U_EBASICPFSA_Audit_Final WITH (NOLOCK)
        ON AudEEID = xEEID and audKey2 = xCOID and eeddedcode = audKey3
    --WHERE CAST(EedBenStartDate as date) >= cast(year(getdate()) as varchar) + '-01-01'
        
        ;
    ;

    -- No records should show values prior to current year 01-01
    UPDATE dbo.U_EBASICPFSA_drvTbl
    SET drvEffectiveDate = cast(year(getdate()) as varchar) + '-01-01'
    WHERE CAST(drvEffectiveDate AS DATE) < cast(year(getdate()) as varchar) + '-01-01';

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
ALTER VIEW dbo.dsi_vwEBASICPFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EBASICPFSA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EBASICPFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101251'
       ,expStartPerControl     = '202101251'
       ,expLastEndPerControl   = '202102019'
       ,expEndPerControl       = '202102019'
WHERE expFormatCode = 'EBASICPFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEBASICPFSA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EBASICPFSA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort