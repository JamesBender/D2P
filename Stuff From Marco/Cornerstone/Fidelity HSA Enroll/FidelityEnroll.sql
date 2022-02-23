SET NOCOUNT ON;
IF OBJECT_ID('U_EFIDELHSEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFIDELHSEX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFIDELHSEX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFIDELHSEX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDELHSEX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDELHSEX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDELHSEX];
GO
IF OBJECT_ID('U_EFIDELHSEX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_PEarHist];
GO
IF OBJECT_ID('U_EFIDELHSEX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_PDedHist];
GO
IF OBJECT_ID('U_EFIDELHSEX_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_File];
GO
IF OBJECT_ID('U_EFIDELHSEX_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_Employees];
GO
IF OBJECT_ID('U_EFIDELHSEX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_EEList];
GO
IF OBJECT_ID('U_EFIDELHSEX_drvTbl_RAE') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_drvTbl_RAE];
GO
IF OBJECT_ID('U_EFIDELHSEX_drvTbl_HSA') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_drvTbl_HSA];
GO
IF OBJECT_ID('U_EFIDELHSEX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_DedList];
GO
IF OBJECT_ID('U_EFIDELHSEX_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_AuditFields];
GO
IF OBJECT_ID('U_EFIDELHSEX_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFIDELHSEX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFIDELHSEX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFIDELHSEX';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EFIDELHSEX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFIDELHSEX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFIDELHSEX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFIDELHSEX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFIDELHSEX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFIDELHSEX','Fidelity FSA HSA Enrollment','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFIDELHSEXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TESTEDT"','1','(''DA''=''F'')','EFIDELHSEXZ0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EFIDELHSEXZ0','73','H','01','8',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDELHSEXZ0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDELHSEXZ0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDELHSEXZ0','3','D','10','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDELHSEXZ0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDELHSEXZ0','6','D','10','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RA"','6','(''DA''=''F'')','EFIDELHSEXZ0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"E"','7','(''DA''=''F'')','EFIDELHSEXZ0','1','D','10','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvACCOUNTPLANCODE"','8','(''UA''=''F'')','EFIDELHSEXZ0','6','D','10','33',NULL,'REIMBURSEMENT ACCOUNT PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYear"','9','(''UA''=''F'')','EFIDELHSEXZ0','4','D','10','39',NULL,'PLAN YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFIDELHSEXZ0','3','D','10','43',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAnnualElection"','11','(''UA''=''F'')','EFIDELHSEXZ0','8','D','10','46',NULL,'ANNUAL ELECTION AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','12','(''UDMDY''=''F'')','EFIDELHSEXZ0','8','D','10','54',NULL,'COVERAGE EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStopDate"','13','(''UDMDY''=''F'')','EFIDELHSEXZ0','8','D','10','62',NULL,'COVERAGE END DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"','14','(''DA''=''F'')','EFIDELHSEXZ0','3','D','10','70',NULL,'HRA COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFIDELHSEXZ0','8','D','10','73',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDELHSEXZ0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDELHSEXZ0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDELHSEXZ0','3','D','20','20',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDELHSEXZ0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDELHSEXZ0','6','D','20','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HS"','6','(''DA''=''F'')','EFIDELHSEXZ0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYear"','7','(''UA''=''F'')','EFIDELHSEXZ0','4','D','20','32',NULL,'PLAN YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovTier"','8','(''UA''=''F'')','EFIDELHSEXZ0','2','D','20','36',NULL,'COVERAGE TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""HDHP1','9','(''DA''=''F'')','EFIDELHSEXZ0','5','D','20','38',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffectiveDate"','10','(''UDMDY''=''F'')','EFIDELHSEXZ0','8','D','20','43',NULL,'ENROLLMENT EFFECTIVE DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentStatus"','11','(''UA''=''F'')','EFIDELHSEXZ0','1','D','20','51',NULL,'ENROLLMENT STATUS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientBillingFlag','12','(''UA''=''F'')','EFIDELHSEXZ0','1','D','20','52',NULL,'HRA COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFIDELHSEXZ0','1','D','20','53',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"','14','(''DA''=''F'')','EFIDELHSEXZ0','8','D','20','54',NULL,'HRA COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"','15','(''DA''=''F'')','EFIDELHSEXZ0','10','D','20','62',NULL,'HRA COVERAGE',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW12\Downloads\V10\Exports\CHLI\EmployeeHistoryExport\OXFUP_EFIDELHSEX_20200507a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Open Enrollment Active','202101229','EMPEXPORT','OEACTIVE','Jan 22 2021 12:00AM','EFIDELHSEX',NULL,NULL,NULL,'202101229','Jan 22 2021 12:00AM','Dec 30 1899 12:00AM','202101221',NULL,'','','202101221',dbo.fn_GetTimedKey(),NULL,'us3mLaCOR1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW12\Downloads\V10\Exports\CHLI\EmployeeHistoryExport\OXFUP_EFIDELHSEX_20200507b',NULL,'','','',NULL,NULL,NULL,'Open Enrollment Passive','202101229','EMPEXPORT','OEPASSIVE','Jan 22 2021  9:46AM','EFIDELHSEX',NULL,NULL,NULL,'202101229','Jan 22 2021 12:00AM','Dec 30 1899 12:00AM','202101221','442','','','202101221',dbo.fn_GetTimedKey(),NULL,'us3mLaCOR1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW2\EW23\Downloads\V10\Exports\OXFUP\EmployeeHistoryExport\OXFUP_EFIDELHSEX_20200319.txt',NULL,'','',NULL,NULL,NULL,NULL,'Fidelity 403B Export','201702019','EMPEXPORT','ONDEMAND','Feb  1 2017 12:00AM','EFIDELHSEX',NULL,NULL,NULL,'201702019','Feb  1 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW2\EW23\Downloads\V10\Exports\OXFUP\EmployeeHistoryExport\OXFUP_EFIDELHSEX_20200319.txt',NULL,'','','',NULL,NULL,NULL,'Fidelity 403B Export','202003241','EMPEXPORT','SCH_FIDEXP','Mar 24 2020  5:26PM','EFIDELHSEX',NULL,NULL,NULL,'202003241','Mar 24 2020 12:00AM','Dec 30 1899 12:00AM','201701011','8210','','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW12\Downloads\V10\Exports\CHLI\EmployeeHistoryExport\CHLI_EFIDELHSEX_20210129.txt',NULL,'','','EMIS8,0OYNL,EMIOC,EMIU4,EMIW1,EMIZB,EMJ3N,EMJ5K,EMJ7B,HML13,EMIPU,EMJ8Y',NULL,NULL,NULL,'Fidelity 403B Export','202101299','EMPEXPORT','TEST','Jan 29 2021  8:54AM','EFIDELHSEX',NULL,NULL,NULL,'202101299','Jan 29 2021 12:00AM','Dec 30 1899 12:00AM','202101011','446','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3lKiCOR1029',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDELHSEX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDELHSEX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDELHSEX','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDELHSEX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDELHSEX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDELHSEX','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDELHSEX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EFIDELHSEX_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_EFIDELHSEX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDELHSEX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDELHSEX','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDELHSEX','D10','dbo.U_EFIDELHSEX_drvTbl_RAE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDELHSEX','D20','dbo.U_EFIDELHSEX_drvTbl_HSA',NULL);
IF OBJECT_ID('U_dsi_BDM_EFIDELHSEX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFIDELHSEX] (
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
IF OBJECT_ID('U_EFIDELHSEX_Audit') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EFIDELHSEX_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EFIDELHSEX_DedList') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFIDELHSEX_drvTbl_HSA') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_drvTbl_HSA] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvPlanYear] varchar(4) NULL,
    [drvCovTier] varchar(2) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvEnrollmentStatus] varchar(1) NOT NULL,
    [drvClientBillingFlag] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] varchar(11) NULL
);
IF OBJECT_ID('U_EFIDELHSEX_drvTbl_RAE') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_drvTbl_RAE] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvACCOUNTPLANCODE] varchar(5) NULL,
    [drvPlanYear] varchar(4) NULL,
    [drvAnnualElectionRaw] money NULL,
    [drvAnnualElection] varchar(30) NULL,
    [drvEffectiveDate] datetime NULL,
    [drvStopDate] datetime NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(2) NOT NULL,
    [drvSubSort] varchar(11) NULL
);
IF OBJECT_ID('U_EFIDELHSEX_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFIDELHSEX_Employees') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_Employees] (
    [xEEID] char(12) NULL,
    [xCOID] char(5) NULL,
    [EepSSN] char(11) NULL,
    [EepNameFirst] varchar(100) NULL,
    [EepNameMiddle] varchar(50) NULL,
    [EepNameLast] varchar(100) NULL,
    [EepGender] char(1) NULL,
    [EepDateOfBirth] datetime NULL,
    [EepMaritalStatus] char(1) NULL,
    [EepAddressLine1] varchar(255) NULL,
    [EepAddressLine2] varchar(255) NULL,
    [EepAddressLine3] varchar(255) NULL,
    [EepAddressCity] varchar(255) NULL,
    [EepAddressState] varchar(255) NULL,
    [EepAddressZipCode] varchar(50) NULL,
    [EepAddressCountry] char(3) NULL,
    [EecEmpNo] char(9) NULL,
    [EecEmplStatus] char(1) NULL,
    [EecDateOfOriginalHire] datetime NULL,
    [EecDateOfLastHire] datetime NULL,
    [EecDateOfTermination] datetime NULL,
    [EecDateOfRetirement] datetime NULL,
    [EecLocation] char(6) NULL,
    [EecFullTimeOrPartTime] char(1) NULL,
    [EecPayPeriod] char(1) NULL,
    [EecUnionLocal] char(12) NULL,
    [EecOrgLvl1] char(6) NULL,
    [EecOrgLvl2] char(6) NULL,
    [OrgLvl2Desc] varchar(25) NULL,
    [Record01Change] varchar(1) NULL,
    [Record02DChange] varchar(1) NULL,
    [Record02EChange] varchar(1) NULL,
    [Record03Change] varchar(1) NULL,
    [Record04Change] varchar(1) NULL,
    [Record05Change] varchar(1) NULL,
    [Record06Change] varchar(1) NULL,
    [Record11Change] varchar(1) NULL,
    [Record36Change] varchar(1) NULL,
    [Record60Change] varchar(1) NULL,
    [Record61Change] varchar(1) NULL,
    [audNewHire] varchar(1) NULL,
    [audReHire] varchar(1) NULL,
    [audTerm] varchar(1) NULL,
    [audSalaryChange] varchar(1) NULL,
    [EecDateOfSeniority] datetime NULL,
    [EecAnnSalary] money NULL,
    [EecTermReason] char(6) NULL,
    [EecEmplStatusStartDate] datetime NULL,
    [emailAddress] varchar(1) NULL,
    [eepAddressEMail] varchar(50) NULL
);
IF OBJECT_ID('U_EFIDELHSEX_File') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFIDELHSEX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(9) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL,
    [PlanNo] varchar(5) NULL
);
IF OBJECT_ID('U_EFIDELHSEX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFIDELHSEX_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PrgPeriodStartDate] datetime NULL,
    [PrgPeriodEndDate] datetime NULL,
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDELHSEX]
    @SystemID char(12)
AS
/**********************************************************************************
Client Name: Oxfor University Press

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/20/2020
Service Request Number: TekP-2020-02-17-0003

Purpose: Fidelity FSA HSA Enrollment

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFIDELHSEX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFIDELHSEX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFIDELHSEX';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFIDELHSEX'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFIDELHSEX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFIDELHSEX' ORDER BY RunID DESC;


UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFIDELHSEX' and cfgname = 'ExportPath'
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDELHSEX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDELHSEX', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDELHSEX', @AllObjects = 'Y'
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

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EFIDELHSEX';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);



    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFIDELHSEX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFIDELHSEX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    

    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'HSAF ,HSAF1 ,HSAFE ,HSAI ,HSAI1 ,HSAIE ,HSACF ,HSCF1 ,HSCFE ,HSACI ,HSCI1 ,HSCIE,R,U,V,62,72,73';

        IF OBJECT_ID('U_EFIDELHSEX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDELHSEX_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFIDELHSEX_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

        --==========================================
    -- BDM Section
    --==========================================
    -- now set values for benefit module
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');

    -- Non-required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS,STC');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');



        --Set if OE
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;
    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================
    -- DETAIL RECORD - U_EFIDELHSEX_drvTbl_RAE
    ---------------------------------
    IF OBJECT_ID('U_EFIDELHSEX_drvTbl_RAE','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDELHSEX_drvTbl_RAE;
    SELECT DISTINCT
        drvPLANNUMBER = '77277'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvACCOUNTPLANCODE = CASE WHEN BdmDedCode IN ('R','62') THEN 'HCFSA'
                                   WHEN BdmDedCode IN ('U','72') THEN 'DCFSA'
                                   WHEN BdmDedCode IN ('V','73') THEN 'LPFSA'
                              END
        ,drvPlanYear =  CAST(  YEAR(BdmBenStartDate) as varchar(4))
        ,drvAnnualElectionRaw = BdmEEGoalAmt
        ,drvAnnualElection = CONVERT(VARCHAR,dbo.dsi_fnPadZero(BdmEEGoalAmt*100,8,0))
        ,drvEffectiveDate  =  BdmBenStartDate
        ,drvStopDate =  BdmBenStopDate
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '01'
        ,drvSubSort =  RTRIM(EepSSN)
    INTO dbo.U_EFIDELHSEX_drvTbl_RAE
    FROM dbo.U_EFIDELHSEX_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EFIDELHSEX WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    WHERE BdmDedCode in ('R','62','U','72','V','73')


    ---------------------------------
    -- DETAIL RECORD - U_EFIDELHSEX_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EFIDELHSEX_drvTbl_HSA','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDELHSEX_drvTbl_HSA;
    SELECT DISTINCT
        drvPLANNUMBER = '77277'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvPlanYear = CAST(  YEAR(@StartDate) as varchar(4))
        ,drvCovTier = CASE WHEN BdmDedCode IN ('HSAI', 'HSAI1', 'HSAIE') THEN '05'
                                   WHEN BdmDedCode IN ('HSACI', 'HSCI1', 'HSCIE') THEN '07'
                                   WHEN BdmDedCode IN ('HSAF', 'HSAF1', 'HSAFE') THEN '13'
                                   WHEN BdmDedCode IN ('HSACF', 'HSCF1', 'HSCFE') THEN '19'
                              END
        ,drvEffectiveDate =  BdmBenStartDate
        ,drvEnrollmentStatus = CASE WHEN DateDiff(day,EecDateOfTermination, @StartDate) > 30 then 'I' ELSE 'A' END
        ,drvClientBillingFlag = CASE WHEN eecemplstatus = 'T' THEN 'N' ELSE 'Y' END
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = '02'
        ,drvSubSort = RTRIM(EepSSN)
    INTO dbo.U_EFIDELHSEX_drvTbl_HSA
    FROM dbo.U_EFIDELHSEX_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EFIDELHSEX WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    WHERE BdmDedCode in ('HSAI', 'HSAI1', 'HSAIE','HSACI', 'HSCI1', 'HSCIE','HSAF', 'HSAF1', 'HSAFE','HSACF', 'HSCF1', 'HSCFE')


    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFIDELHSEX','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFIDELHSEX','Testing') = 'Y' THEN 'TEST_CSP_EFIDELHSEX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_EFIDELHSEX_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFIDELHSEX';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFIDELHSEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDELHSEX_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDELHSEX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = 'EFIDELHSEX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFIDELHSEX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDELHSEX_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;