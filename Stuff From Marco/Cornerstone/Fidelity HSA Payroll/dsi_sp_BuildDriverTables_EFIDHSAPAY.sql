SET NOCOUNT ON;
IF OBJECT_ID('U_EFIDHSAPAY_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EFIDHSAPAY_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EFIDHSAPAY' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEFIDHSAPAY_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEFIDHSAPAY_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EFIDHSAPAY') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDHSAPAY];
GO
IF OBJECT_ID('U_EFIDHSAPAY_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_PEarHist];
GO
IF OBJECT_ID('U_EFIDHSAPAY_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_PDedHist];
GO
IF OBJECT_ID('U_EFIDHSAPAY_File') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_File];
GO
IF OBJECT_ID('U_EFIDHSAPAY_Employees') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_Employees];
GO
IF OBJECT_ID('U_EFIDHSAPAY_EEList') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_EEList];
GO
IF OBJECT_ID('U_EFIDHSAPAY_drvTbl_RAE') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_drvTbl_RAE];
GO
IF OBJECT_ID('U_EFIDHSAPAY_drvTbl_HSA') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_drvTbl_HSA];
GO
IF OBJECT_ID('U_EFIDHSAPAY_DedList') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_DedList];
GO
IF OBJECT_ID('U_EFIDHSAPAY_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_AuditFields];
GO
IF OBJECT_ID('U_EFIDHSAPAY_Audit') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EFIDHSAPAY') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EFIDHSAPAY];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EFIDHSAPAY';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = 'EFIDHSAPAY';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EFIDHSAPAY';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EFIDHSAPAY';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EFIDHSAPAY';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EFIDHSAPAY';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EFIDHSAPAY','Fidelity FSA HSA Payroll','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','80','S','N','EFIDHSAPAYZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TESTEDT"','1','(''DA''=''F'')','EFIDHSAPAYZ0','7','H','01','1',NULL,'TEST FILE IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','2','(''SS''=''F'')','EFIDHSAPAYZ0','73','H','01','8',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDHSAPAYZ0','5','D','10','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDHSAPAYZ0','4','D','10','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDHSAPAYZ0','3','D','10','10',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDHSAPAYZ0','11','D','10','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDHSAPAYZ0','1','D','10','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EFIDHSAPAYZ0','1','D','10','25',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYear"','7','(''UA''=''F'')','EFIDHSAPAYZ0','4','D','10','26',NULL,'PLAN YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RA"','8','(''DA''=''F'')','EFIDHSAPAYZ0','2','D','10','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"C"','9','(''DA''=''F'')','EFIDHSAPAYZ0','1','D','10','32',NULL,'FIELD TYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvACCOUNTPLANCODE"','10','(''UA''=''F'')','EFIDHSAPAYZ0','6','D','10','33',NULL,'REIMBURSEMENT ACCOUNT PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTaxDeduction"','11','(''UA''=''F'')','EFIDHSAPAYZ0','8','D','10','39',NULL,'PRE-TAX PAYROLL DEDUCTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','12','(''DA''=''F'')','EFIDHSAPAYZ0','8','D','10','47',NULL,'POST-TAX PAYROLL DEDUCTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFIDHSAPAYZ0','8','D','10','55',NULL,'PRE-TAX EMPLOYER CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','14','(''DA''=''F'')','EFIDHSAPAYZ0','8','D','10','70',NULL,'POST-TAX EMPLOYER CONTRIBUTION',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate','15','(''UDMDY''=''F'')','EFIDHSAPAYZ0','8','D','10','71',NULL,'CHECK DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''F'')','EFIDHSAPAYZ0','2','D','10','79',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLANNUMBER"','1','(''UA''=''F'')','EFIDHSAPAYZ0','5','D','20','1',NULL,'PLAN NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBATCHGROUPID"','2','(''UA''=''F'')','EFIDHSAPAYZ0','4','D','20','6',NULL,'BATCH GROUP ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F'')','EFIDHSAPAYZ0','3','D','20','20',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSOCIALSECURITYNUMBER"','4','(''UA''=''F'')','EFIDHSAPAYZ0','11','D','20','13',NULL,'SOCIAL SECURITY NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','EFIDHSAPAYZ0','1','D','20','24',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','EFIDHSAPAYZ0','5','D','20','25',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"19"','7','(''DA''=''F'')','EFIDHSAPAYZ0','2','D','20','30',NULL,'RECORD IDENTIFIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','8','(''DA''=''F'')','EFIDHSAPAYZ0','4','D','20','32',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"220"','9','(''DA''=''F'')','EFIDHSAPAYZ0','3','D','20','36',NULL,'TRANSACTION CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','10','(''DA''=''F'')','EFIDHSAPAYZ0','2','D','20','39',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSource"','11','(''UA''=''F'')','EFIDHSAPAYZ0','2','D','20','41',NULL,'SOURCE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"01"','12','(''DA''=''F'')','EFIDHSAPAYZ0','2','D','20','43',NULL,'ITEM NUMBER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''DA''=''F'')','EFIDHSAPAYZ0','1','D','20','45',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmount"','14','(''UA''=''F'')','EFIDHSAPAYZ0','13','D','20','46',NULL,'AMOUNT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''F'')','EFIDHSAPAYZ0','4','D','20','59',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','16','(''UA''=''F'')','EFIDHSAPAYZ0','4','D','20','63',NULL,'TAX YEAR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''F'')','EFIDHSAPAYZ0','1','D','20','67',NULL,'FILLER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCheckDate"','18','(''UDMDY''=''F'')','EFIDHSAPAYZ0','8','D','20','68',NULL,' CHECK DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''DA''=''F'')','EFIDHSAPAYZ0','5','D','20','76',NULL,'RESERVED',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW12\Downloads\V10\Exports\CHLI\EmployeeHistoryExport\OXFUP_EFIDHSAPAY_20200507a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Open Enrollment Active','202101229','EMPEXPORT','OEACTIVE','Jan 22 2021 12:00AM','EFIDHSAPAY',NULL,NULL,NULL,'202101229','Jan 22 2021 12:00AM','Dec 30 1899 12:00AM','202101221',NULL,'','','202101221',dbo.fn_GetTimedKey(),NULL,'us3mLaCOR1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW12\Downloads\V10\Exports\CHLI\EmployeeHistoryExport\OXFUP_EFIDHSAPAY_20200507b',NULL,'','','',NULL,NULL,NULL,'Open Enrollment Passive','202101229','EMPEXPORT','OEPASSIVE','Jan 22 2021  9:46AM','EFIDHSAPAY',NULL,NULL,NULL,'202101229','Jan 22 2021 12:00AM','Dec 30 1899 12:00AM','202101221','442','','','202101221',dbo.fn_GetTimedKey(),NULL,'us3mLaCOR1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW2\EW23\Downloads\V10\Exports\OXFUP\EmployeeHistoryExport\OXFUP_EFIDHSAPAY_20200319.txt',NULL,'','',NULL,NULL,NULL,NULL,'Fidelity 403B Export','201702019','EMPEXPORT','ONDEMAND','Feb  1 2017 12:00AM','EFIDHSAPAY',NULL,NULL,NULL,'201702019','Feb  1 2017 12:00AM','Dec 30 1899 12:00AM','201702011',NULL,'','','201702011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW2\EW23\Downloads\V10\Exports\OXFUP\EmployeeHistoryExport\OXFUP_EFIDHSAPAY_20200319.txt',NULL,'','','',NULL,NULL,NULL,'Fidelity 403B Export','202003241','EMPEXPORT','SCH_FIDPAY','Mar 24 2020  5:26PM','EFIDHSAPAY',NULL,NULL,NULL,'202003241','Mar 24 2020 12:00AM','Dec 30 1899 12:00AM','201701011','8210','','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\NW1\NW12\Downloads\V10\Exports\CHLI\EmployeeHistoryExport\OXFUP_EFIDHSAPAY_20200507.txt',NULL,'','','EMIS8,0OYNL,EMIOC,EMIU4,EMIW1,EMIZB,EMJ3N,EMJ5K,EMJ7B,HML13,EMIPU,EMJ8Y',NULL,NULL,NULL,'Fidelity 403B Export','202101159','EMPEXPORT','TEST','Jan 26 2021 11:50AM','EFIDHSAPAY',NULL,NULL,NULL,'202101159','Jan 15 2021 12:00AM','Dec 30 1899 12:00AM','202101151','421','','','202101151',dbo.fn_GetTimedKey(),NULL,'us3mLaCOR1029',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSAPAY','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSAPAY','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSAPAY','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSAPAY','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSAPAY','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSAPAY','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EFIDHSAPAY','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_EFIDHSAPAY_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_EFIDHSAPAY_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EFIDHSAPAY_SavePath];
GO
INSERT INTO [dbo].[U_dsi_RecordSetDetails] (FormatCode,ExportCode,RecType,SetNo,SkipSet,SetType) VALUES ('EFIDHSAPAY','ONDEMAND','H','01','Y','C');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDHSAPAY','D10','dbo.U_EFIDHSAPAY_drvTbl_RAE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EFIDHSAPAY','D20','dbo.U_EFIDHSAPAY_drvTbl_HSA',NULL);
IF OBJECT_ID('U_dsi_BDM_EFIDHSAPAY') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EFIDHSAPAY] (
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
IF OBJECT_ID('U_EFIDHSAPAY_Audit') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_Audit] (
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
IF OBJECT_ID('U_EFIDHSAPAY_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EFIDHSAPAY_DedList') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EFIDHSAPAY_drvTbl_HSA') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_drvTbl_HSA] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvSource] varchar(5) NULL,
    [drvAmount] varchar(30) NULL,
    [drvAmountRaw] money NULL,
    [drvTaxYear] varchar(4) NULL,
    [drvCheckDate] varchar(8) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDHSAPAY_drvTbl_RAE') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_drvTbl_RAE] (
    [drvPLANNUMBER] varchar(5) NOT NULL,
    [drvBATCHGROUPID] varchar(1) NOT NULL,
    [drvSOCIALSECURITYNUMBER] varchar(13) NULL,
    [drvACCOUNTPLANCODE] varchar(30) NULL,
    [drvPlanYear] varchar(4) NULL,
    [drvPreTaxDeduction] varchar(30) NULL,
    [drvPreTaxDeductionRaw] money NULL,
    [drvCheckDate] varchar(8) NULL,
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(2) NOT NULL
);
IF OBJECT_ID('U_EFIDHSAPAY_EEList') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EFIDHSAPAY_Employees') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_Employees] (
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
IF OBJECT_ID('U_EFIDHSAPAY_File') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(80) NULL
);
IF OBJECT_ID('U_EFIDHSAPAY_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhSource] varchar(5) NULL,
    [PdhEECurAmt] money NULL,
    [PdhERCurAmt] money NULL
);
IF OBJECT_ID('U_EFIDHSAPAY_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EFIDHSAPAY_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EFIDHSAPAY]
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

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EFIDHSAPAY';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EFIDHSAPAY';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EFIDHSAPAY';
SELECT * FROM dbo.U_dsi_RecordSetDetails WHERE FormatCode = 'EFIDHSAPAY'; -- Skip RecordSets by ExportCode
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EFIDHSAPAY';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EFIDHSAPAY' ORDER BY RunID DESC;


UPDATE U_dsi_Configuration set cfgvalue = null where  FormatCode = 'EFIDHSAPAY' and cfgname = 'ExportPath'
Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDHSAPAY', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EFIDHSAPAY', 'TEST';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EFIDHSAPAY', @AllObjects = 'Y'
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
    WHERE FormatCode = 'EFIDHSAPAY';

    PRINT 'Start Date: ' + CONVERT(VARCHAR(26),@StartDate,100);
    PRINT 'End Date:  ' + CONVERT(VARCHAR(26),@EndDate,100);



    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EFIDHSAPAY_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EFIDHSAPAY_EEList GROUP BY xEEID HAVING COUNT(1) > 1);
    

    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'HSAF ,HSAF1 ,HSAFE ,HSAI ,HSAI1 ,HSAIE ,HSACF ,HSCF1 ,HSCFE ,HSACI ,HSCI1 ,HSCIE,R,U,V,62,72,73';

        IF OBJECT_ID('U_EFIDHSAPAY_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSAPAY_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EFIDHSAPAY_DedList
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


    IF OBJECT_ID('U_EFIDHSAPAY_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSAPAY_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhSource = CASE WHEN PdhDedCode IN ('R','62') THEN 'HCFSA' 
                          WHEN PdhDedCode IN ('U','72') THEN 'DCFSA' 
                          WHEN PdhDedCode IN ('V','73')THEN 'LPFSA' 
                          WHEN PdhDedCode IN ('HSAI', 'HSAI1', 'HSAIE', 'HSAF', 'HSAF1' , 'HSAFE') THEN '01'
                          WHEN PdhDedCode IN ('HSACI', 'HSCI1', 'HSCIE', 'HSACF', 'HSCF1' ,'HSCFE') THEN '02' 
                     END
        ,PdhEECurAmt = SUM(PdhEECurAmt)
        ,PdhERCurAmt = SUM(PdhERCurAmt)
    INTO dbo.U_EFIDHSAPAY_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE PdhPerControl BETWEEN @StartPerControl AND @EndPerControl AND 
    PdhDedCode IN ('HSAI', 'HSAI1', 'HSAIE', 'HSAF', 'HSAF1' , 'HSAFE','HSACI', 'HSCI1', 'HSCIE', 'HSACF', 'HSCF1' ,'HSCFE','V','73','U','72','R','62')
    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('R','62') THEN 'HCFSA' 
                          WHEN PdhDedCode IN ('U','72') THEN 'DCFSA' 
                          WHEN PdhDedCode IN ('V','73')THEN 'LPFSA' 
                          WHEN PdhDedCode IN ('HSAI', 'HSAI1', 'HSAIE', 'HSAF', 'HSAF1' , 'HSAFE') THEN '01'
                          WHEN PdhDedCode IN ('HSACI', 'HSCI1', 'HSCIE', 'HSACF', 'HSCF1' ,'HSCFE') THEN '02' 
                     END
    HAVING (SUM(PdhEECurAmt) <> 0.00 or SUM(PdhERCurAmt) <> 0.00);
    --==========================================
    -- Build Employee Data and the driver tables
    --==========================================
    -- DETAIL RECORD - U_EFIDHSAPAY_drvTbl_RAE
    ---------------------------------
    IF OBJECT_ID('U_EFIDHSAPAY_drvTbl_RAE','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSAPAY_drvTbl_RAE;
    SELECT DISTINCT
        drvPLANNUMBER = '77277'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvACCOUNTPLANCODE = CAST(PdhSource as varchar)
        ,drvPlanYear =  CAST(YEAR(BdmBenStartDate) as varchar(4))
        ,drvPreTaxDeduction = CAST(PdhEECurAmt as varchar)
        ,drvPreTaxDeductionRaw = PdhEECurAmt
        ,drvCheckDate  = PayDate
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN) 
        ,drvSubSort =  '01'
    INTO dbo.U_EFIDHSAPAY_drvTbl_RAE
    FROM dbo.U_EFIDHSAPAY_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EFIDHSAPAY WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN dbo.U_EFIDHSAPAY_PDedHist WITH (NOLOCK)
        ON pdheeid = xEEID
     LEFT JOIN (
        SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as Pay
    on eecpaygroup = pay.PgpPayGroup
    WHERE PdhSource in ('HCFSA','DCFSA','LPFSA')   AND BdmDedCode in ('R','62','U','72','V','73')

    UPDATE U_EFIDHSAPAY_drvTbl_RAE set drvPreTaxDeduction = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvPreTaxDeduction as money)) *100 ,8,0)) 

        Update U_EFIDHSAPAY_drvTbl_RAE set drvPreTaxDeduction  =   CONCAT(LEFT(REPLACE(drvPreTaxDeduction,'.',''),(LEN( REPLACE(drvPreTaxDeduction,'.','')) -1)),CASE WHEN RIGHT(drvPreTaxDeduction,1) = '1' THEN 'A'
         WHEN RIGHT(drvPreTaxDeduction,1) = '2' THEN 'B'
         WHEN RIGHT(drvPreTaxDeduction,1) = '3' THEN 'C'
         WHEN RIGHT(drvPreTaxDeduction,1) = '4' THEN 'D'
         WHEN RIGHT(drvPreTaxDeduction,1) = '5' THEN 'E'
         WHEN RIGHT(drvPreTaxDeduction,1) = '6' THEN 'F'
         WHEN RIGHT(drvPreTaxDeduction,1) = '7' THEN 'G'
         WHEN RIGHT(drvPreTaxDeduction,1) = '8' THEN 'H'
         WHEN RIGHT(drvPreTaxDeduction,1) = '9' THEN 'I'
         WHEN RIGHT(drvPreTaxDeduction,1) = '0' THEN '{'

    END) 


    ---------------------------------
    -- DETAIL RECORD - U_EFIDHSAPAY_drvTbl_02D
    ---------------------------------
    IF OBJECT_ID('U_EFIDHSAPAY_drvTbl_HSA','U') IS NOT NULL
        DROP TABLE dbo.U_EFIDHSAPAY_drvTbl_HSA;
    SELECT DISTINCT
        drvPLANNUMBER = '77277'
        ,drvBATCHGROUPID = ''
        ,drvSOCIALSECURITYNUMBER = STUFF(STUFF(EepSSN,4,0,'-'), 7,0,'-')
        ,drvSource = PdhSource
        ,drvAmount = CAST(PdhEECurAmt as varchar)
        ,drvAmountRaw = PdhEECurAmt 

        ,drvTaxYear = CAST(  YEAR(BdmBenStartDate) as varchar(4))
        ,drvCheckDate = PayDate
    
        ,drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvInitialSort = RTRIM(EepSSN) 
        ,drvSubSort = '02'
    INTO dbo.U_EFIDHSAPAY_drvTbl_HSA
    FROM dbo.U_EFIDHSAPAY_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EFIDHSAPAY WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    JOIN dbo.U_EFIDHSAPAY_PDedHist WITH (NOLOCK)
        ON pdheeid = xEEID
    LEFT JOIN (
        SELECT PgpPayGroup, LEFT(MAX(PgpPeriodControl),8) as PayDate, MAX(PgpPeriodStartDate) PrgPeriodStart, MAX(PgpPeriodEndDate) PrgPeriodEnd 
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
                   GROUP BY PgpPayGroup) as Pay
    on eecpaygroup = pay.PgpPayGroup
    WHERE  PdhSource in ('01','02') and BdmDedCode in ('HSAI', 'HSAI1', 'HSAIE','HSACI', 'HSCI1', 'HSCIE','HSAF', 'HSAF1', 'HSAFE','HSACF', 'HSCF1', 'HSCFE')

        UPDATE U_EFIDHSAPAY_drvTbl_HSA set drvAmount = CONVERT(VARCHAR,dbo.dsi_fnPadZero( (cast (drvAmount as money)) * 100,13,0)) 

      Update U_EFIDHSAPAY_drvTbl_HSA set drvAmount  =   CONCAT(LEFT(REPLACE(drvAmount,'.',''),(LEN( REPLACE(drvAmount,'.','')) -1)),CASE WHEN RIGHT(drvAmount,1) = '1' THEN 'A'
         WHEN RIGHT(drvAmount,1) = '2' THEN 'B'
         WHEN RIGHT(drvAmount,1) = '3' THEN 'C'
         WHEN RIGHT(drvAmount,1) = '4' THEN 'D'
         WHEN RIGHT(drvAmount,1) = '5' THEN 'E'
         WHEN RIGHT(drvAmount,1) = '6' THEN 'F'
         WHEN RIGHT(drvAmount,1) = '7' THEN 'G'
         WHEN RIGHT(drvAmount,1) = '8' THEN 'H'
         WHEN RIGHT(drvAmount,1) = '9' THEN 'I'
         WHEN RIGHT(drvAmount,1) = '0' THEN '{'

    END) 
    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EFIDHSAPAY','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable('EFIDHSAPAY','Testing') = 'Y' THEN 'TEST_CSP_EFIDHSAPAY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'CSP_EFIDHSAPAY_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = 'EFIDHSAPAY';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEFIDHSAPAY_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDHSAPAY_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EFIDHSAPAY%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201702011'
       ,ExpStartPerControl     = '201702011'
       ,ExpLastEndPerControl   = '201702019'
       ,ExpEndPerControl       = '201702019'
WHERE ExpFormatCode = 'EFIDHSAPAY';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEFIDHSAPAY_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EFIDHSAPAY_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;