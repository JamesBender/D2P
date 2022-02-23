SET NOCOUNT ON;
IF OBJECT_ID('U_EUNMDISSU2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNMDISSU2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUNMDISSU2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUNMDISSU2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUNMDISSU2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUNMDISSU2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNMDISSU2_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNMDISSU2_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUNMDISSU2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNMDISSU2];
GO
IF OBJECT_ID('U_EUNMDISSU2_File') IS NOT NULL DROP TABLE [dbo].[U_EUNMDISSU2_File];
GO
IF OBJECT_ID('U_EUNMDISSU2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUNMDISSU2_EEList];
GO
IF OBJECT_ID('U_dsi_EUNMDISSU2_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EUNMDISSU2_trlTbl];
GO
IF OBJECT_ID('U_dsi_EUNMDISSU2_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EUNMDISSU2_hdrTbl];
GO
IF OBJECT_ID('U_dsi_EUNMDISSU2_EarnsDefYTD') IS NOT NULL DROP TABLE [dbo].[U_dsi_EUNMDISSU2_EarnsDefYTD];
GO
IF OBJECT_ID('U_dsi_EUNMDISSU2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EUNMDISSU2_drvTbl];
GO
IF OBJECT_ID('U_dsi_EUNMDISSU2_covTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EUNMDISSU2_covTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUNMDISSU2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUNMDISSU2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUNMDISSU2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUNMDISSU2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUNMDISSU2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EUNMDISSU2','UNUM STD/LTD Claim Submission Elig V2','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','400','S','N','EUNMDISSU2Z0','N','Nov 12 2015  3:34PM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUNMDISSU2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''F'')','EUNMDISSU2Z0','2','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProcessDateTime"','2','(''UA''=''F'')','EUNMDISSU2Z0','26','H','01','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','3','(''UA''=''F'')','EUNMDISSU2Z0','9','H','01','29',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerName"','4','(''UA''=''F'')','EUNMDISSU2Z0','60','H','01','38',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollmentType"','5','(''UA''=''F'')','EUNMDISSU2Z0','1','H','01','98',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','6','(''SS''=''F'')','EUNMDISSU2Z0','302','H','01','99',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''F'')','EUNMDISSU2Z0','2','D','02','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''F'')','EUNMDISSU2Z0','9','D','02','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''F'')','EUNMDISSU2Z0','20','D','02','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeIDType"','4','(''UA''=''F'')','EUNMDISSU2Z0','5','D','02','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','5','(''UA''=''F'')','EUNMDISSU2Z0','15','D','02','37',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','6','(''UA''=''F'')','EUNMDISSU2Z0','15','D','02','52',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','7','(''UA''=''F'')','EUNMDISSU2Z0','25','D','02','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','8','(''UA''=''F'')','EUNMDISSU2Z0','40','D','02','92',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','9','(''UA''=''F'')','EUNMDISSU2Z0','40','D','02','132',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine3"','10','(''UA''=''F'')','EUNMDISSU2Z0','40','D','02','172',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','11','(''UA''=''F'')','EUNMDISSU2Z0','30','D','02','212',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','12','(''UA''=''F'')','EUNMDISSU2Z0','5','D','02','242',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','13','(''UA''=''F'')','EUNMDISSU2Z0','11','D','02','247',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','14','(''UA''=''F'')','EUNMDISSU2Z0','2','D','02','258',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkState"','15','(''UA''=''F'')','EUNMDISSU2Z0','5','D','02','260',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','16','(''UA''=''F'')','EUNMDISSU2Z0','10','D','02','265',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','17','(''UA''=''F'')','EUNMDISSU2Z0','1','D','02','275',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','18','(''UA''=''F'')','EUNMDISSU2Z0','3','D','02','276',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupation"','19','(''UA''=''F'')','EUNMDISSU2Z0','40','D','02','279',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofHire"','20','(''UA''=''F'')','EUNMDISSU2Z0','10','D','02','319',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTerminationDate"','21','(''UA''=''F'')','EUNMDISSU2Z0','10','D','02','329',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmploymentStatus"','22','(''UA''=''F'')','EUNMDISSU2Z0','3','D','02','339',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWklySchedWorkHours"','23','(''UA''=''F'')','EUNMDISSU2Z0','5','D','02','342',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryEffDate"','24','(''UA''=''F'')','EUNMDISSU2Z0','10','D','02','347',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccommodatesRestrictions"','25','(''UA''=''F'')','EUNMDISSU2Z0','1','D','02','357',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSickPayHrs"','26','(''UN00''=''F'')','EUNMDISSU2Z0','6','D','02','358',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpTaxpayerID"','27','(''UA''=''F'')','EUNMDISSU2Z0','9','D','02','364',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrigHireDate"','28','(''UA''=''F'')','EUNMDISSU2Z0','10','D','02','373',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','29','(''SS''=''F'')','EUNMDISSU2Z0','18','D','02','383',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''F'')','EUNMDISSU2Z0','2','D','03','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''F'')','EUNMDISSU2Z0','9','D','03','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''F'')','EUNMDISSU2Z0','20','D','03','12',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvProduct"','4','(''UA''=''F'')','EUNMDISSU2Z0','4','D','03','32',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicy"','5','(''UA''=''F'')','EUNMDISSU2Z0','8','D','03','36',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivision"','6','(''UA''=''F'')','EUNMDISSU2Z0','4','D','03','44',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyEligibility"','7','(''UA''=''F'')','EUNMDISSU2Z0','3','D','03','48',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChoice"','8','(''UA''=''F'')','EUNMDISSU2Z0','2','D','03','51',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEffDateofCovg"','9','(''UA''=''F'')','EUNMDISSU2Z0','10','D','03','53',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovgTerminationDate"','10','(''UA''=''F'')','EUNMDISSU2Z0','10','D','03','63',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarnings"','11','(''UA''=''F'')','EUNMDISSU2Z0','8','D','03','73',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEarningsPeriod"','12','(''UA''=''F'')','EUNMDISSU2Z0','3','D','03','81',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpPostTaxContr"','13','(''UA''=''F'')','EUNMDISSU2Z0','6','D','03','84',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','14','(''SS''=''F'')','EUNMDISSU2Z0','311','D','03','90',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''F'')','EUNMDISSU2Z0','2','D','05','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''F'')','EUNMDISSU2Z0','9','D','05','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''F'')','EUNMDISSU2Z0','20','D','05','12',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHomePhone"','4','(''UA''=''F'')','EUNMDISSU2Z0','10','D','05','32',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkPhone"','5','(''UA''=''F'')','EUNMDISSU2Z0','10','D','05','42',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkExt"','6','(''UA''=''F'')','EUNMDISSU2Z0','5','D','05','52',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpHomeEmail"','7','(''UA''=''F'')','EUNMDISSU2Z0','110','D','05','57',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkEmail"','8','(''UA''=''F'')','EUNMDISSU2Z0','110','D','05','167',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine1"','9','(''UA''=''F'')','EUNMDISSU2Z0','40','D','05','277',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkAddressLine2"','10','(''UA''=''F'')','EUNMDISSU2Z0','40','D','05','317',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','11','(''SS''=''F'')','EUNMDISSU2Z0','44','D','05','357',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''F'')','EUNMDISSU2Z0','2','D','06','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''F'')','EUNMDISSU2Z0','9','D','06','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeID"','3','(''UA''=''F'')','EUNMDISSU2Z0','20','D','06','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkAddressLine3"','4','(''UA''=''F'')','EUNMDISSU2Z0','40','D','06','32',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkAddressCity"','5','(''UA''=''F'')','EUNMDISSU2Z0','30','D','06','72',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpWorkAddressZipCode"','6','(''UA''=''F'')','EUNMDISSU2Z0','11','D','06','102',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMgrNameFirst"','7','(''UA''=''F'')','EUNMDISSU2Z0','15','D','06','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMgrNameMiddle"','8','(''UA''=''F'')','EUNMDISSU2Z0','15','D','06','128',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMgrNameLast"','9','(''UA''=''F'')','EUNMDISSU2Z0','25','D','06','143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMgrAddressEmail"','10','(''UA''=''F'')','EUNMDISSU2Z0','110','D','06','168',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMgrPhone"','11','(''UA''=''F'')','EUNMDISSU2Z0','10','D','06','278',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWorkedinPast12Months"','12','(''UN00''=''F'')','EUNMDISSU2Z0','6','D','06','288',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryorHourly"','13','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','294',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkonSunday"','14','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','295',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkonMonday"','15','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','296',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkonTuesday"','16','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkonWednesday"','17','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','298',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkonThursday"','18','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','299',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkonFriday"','19','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','300',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkonSaturday"','20','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','301',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDoDaysOffChangeDuringLeave"','21','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','302',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpJobTitle"','22','(''UA''=''F'')','EUNMDISSU2Z0','40','D','06','303',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOfficeName"','23','(''UA''=''F'')','EUNMDISSU2Z0','40','D','06','343',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvvReportingGroup"','24','(''UA''=''F'')','EUNMDISSU2Z0','6','D','06','383',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmployee"','25','(''UA''=''F'')','EUNMDISSU2Z0','1','D','06','389',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','26','(''SS''=''F'')','EUNMDISSU2Z0','11','D','06','390',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecType"','1','(''UA''=''F'')','EUNMDISSU2Z0','2','T','99','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustomerNumber"','2','(''UA''=''F'')','EUNMDISSU2Z0','9','T','99','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalIndBasicDataRecords"','3','(''UA''=''F'')','EUNMDISSU2Z0','9','T','99','12',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalCovgRecords"','4','(''UA''=''F'')','EUNMDISSU2Z0','10','T','99','21',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalPaymentDedRecords"','5','(''UA''=''F'')','EUNMDISSU2Z0','9','T','99','31',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalFMLA1DataRecords"','6','(''UA''=''F'')','EUNMDISSU2Z0','9','T','99','40',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotalFMLA2DataRecords"','7','(''UA''=''F'')','EUNMDISSU2Z0','9','T','99','49',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','8','(''SS''=''F'')','EUNMDISSU2Z0','343','T','99','58',NULL,NULL,NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUNMDISSU2_20210215.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','THVLX,RXRA1,RXR08,RXQUC,RXR2J,RXR4M,TLLUS,RXR86,TKZGH,RXQLI,TMUGQ,OBW2M,RXRBK',NULL,NULL,NULL,'EUNMDISSU2 export','202001029','EMPEXPORT','EUNMDISSU2','Dec 18 2015  3:28PM','EUNMDISSU2',NULL,NULL,NULL,'202010309','Jan  1 2016 12:00AM','Dec 30 1899 12:00AM','202010231','2169','','','201910311',dbo.fn_GetTimedKey(),NULL,'usgkdavis01',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'TEST','202102019','EMPEXPORT','TEST','Feb  1 2021 12:00AM','EUNMDISSU2',NULL,NULL,NULL,'202102019','Feb  1 2021 12:00AM','Dec 30 1899 12:00AM','202101221','2148','','','202101221',dbo.fn_GetTimedKey(),NULL,'us3lKiSUN1006',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','ExportDescription','C','UNUM STD/LTD - SUNCO');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','InitialSort','C','drvsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','MaxFileLength','C','400');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','SubSort','C','drvsubsort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','SystemID','V','C6A139D533A2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUNMDISSU2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUNMDISSU2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUNMDISSU2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUNMDISSU2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUNMDISSU2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMDISSU2','H01','dbo.U_dsi_EUNMDISSU2_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMDISSU2','D02','dbo.U_dsi_EUNMDISSU2_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMDISSU2','D03','dbo.U_dsi_EUNMDISSU2_covTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMDISSU2','D05','dbo.U_dsi_EUNMDISSU2_fmla1Tbl','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMDISSU2','D06','dbo.U_dsi_EUNMDISSU2_fmla2Tbl','IGNORE');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUNMDISSU2','T99','dbo.U_dsi_EUNMDISSU2_trlTbl',NULL);
IF OBJECT_ID('U_dsi_EUNMDISSU2_covTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EUNMDISSU2_covTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectypex] varchar(1) NOT NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvsort] varchar(50) NULL,
    [drvsubsort] varchar(2) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvCustomerNumber] varchar(9) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvProduct] varchar(4) NOT NULL,
    [drvPolicy] varchar(8) NOT NULL,
    [drvDivision] varchar(4) NOT NULL,
    [drvPolicyEligibility] varchar(3) NOT NULL,
    [drvChoice] varchar(2) NOT NULL,
    [drvEffDateofCovg] char(10) NULL,
    [drvCovgTerminationDate] char(10) NULL,
    [drvEarnings] varchar(8) NULL,
    [drvEarningsPeriod] varchar(2) NOT NULL,
    [drvEmpPostTaxContr] varchar(6) NOT NULL
);
IF OBJECT_ID('U_dsi_EUNMDISSU2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EUNMDISSU2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectypex] varchar(1) NOT NULL,
    [drvsort] varchar(50) NULL,
    [drvsubsort] varchar(2) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvCustomerNumber] varchar(9) NOT NULL,
    [drvEmployeeID] char(9) NULL,
    [drvEmployeeIDType] varchar(4) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(50) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressLine3] varchar(1) NOT NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCountryCode] varchar(2) NOT NULL,
    [drvWorkState] char(2) NULL,
    [drvDateofBirth] char(10) NULL,
    [drvGender] char(1) NULL,
    [drvMaritalStatus] varchar(3) NOT NULL,
    [drvOccupation] varchar(25) NOT NULL,
    [drvDateofHire] char(10) NULL,
    [drvTerminationDate] char(10) NULL,
    [drvEmploymentStatus] varchar(3) NOT NULL,
    [drvWklySchedWorkHours] varchar(5) NOT NULL,
    [drvSalaryEffDate] char(10) NULL,
    [drvAccommodatesRestrictions] varchar(1) NOT NULL,
    [drvSickPayHrs] varchar(6) NOT NULL,
    [drvEmpTaxpayerID] char(11) NULL,
    [drvOrigHireDate] char(10) NULL
);
IF OBJECT_ID('U_dsi_EUNMDISSU2_EarnsDefYTD') IS NULL
CREATE TABLE [dbo].[U_dsi_EUNMDISSU2_EarnsDefYTD] (
    [Eeeid] char(12) NULL,
    [Ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL
);
IF OBJECT_ID('U_dsi_EUNMDISSU2_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EUNMDISSU2_hdrTbl] (
    [drvsort] varchar(2) NOT NULL,
    [drvsubsort] varchar(2) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvProcessDateTime] varchar(37) NULL,
    [drvCustomerNumber] varchar(9) NOT NULL,
    [drvCustomerName] varchar(20) NOT NULL,
    [drvEnrollmentType] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_EUNMDISSU2_trlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EUNMDISSU2_trlTbl] (
    [drvsort] varchar(2) NOT NULL,
    [drvsubsort] varchar(2) NOT NULL,
    [drvRecType] varchar(2) NOT NULL,
    [drvCustomerNumber] varchar(9) NOT NULL,
    [drvTotalIndBasicDataRecords] varchar(24) NULL,
    [drvTotalCovgRecords] varchar(24) NULL,
    [drvTotalPaymentDedRecords] varchar(9) NOT NULL,
    [drvTotalFMLA1DataRecords] varchar(24) NULL,
    [drvTotalFMLA2DataRecords] varchar(24) NULL
);
IF OBJECT_ID('U_EUNMDISSU2_EEList') IS NULL
CREATE TABLE [dbo].[U_EUNMDISSU2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUNMDISSU2_File') IS NULL
CREATE TABLE [dbo].[U_EUNMDISSU2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(400) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EUNMDISSU2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EUNMDISSU2',getdate(),'P','V1.TD'
*/




CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUNMDISSU2]
 @systemid varchar(12) = ''
AS
Begin


/*************************************************************************************************
DRIVER TABLE SP FOR:  UNUM - LTD & STD Claim Submission Eligibility (no FMLA records)
BUILT FOR: SunCoke Energy, Inc.
ORIGINAL BUILD (V-1.0): 11/13/2015 - TDiMaio  - SF 5979813
*************************************************************************************************/

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
        @ExportFile char(200),
        @ltdplandate DATETIME,
        @stdplandate DATETIME,
        @nydblplanDate DATETIME
        
    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile,
        @ltdplandate = convert(varchar(4), year(@EndDate)) + '0101',
        @stdplandate = convert(varchar(4), year(@EndDate)) + '0101',
        @nydblplanDate = convert(varchar(4), year(@EndDate)) + '0101'
        
    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

        
-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 30    -- set number of days if looking for only showing deds stopped within certain days
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
            delete dbo.u_EUNMDISSU2_EELIST
            from dbo.u_EUNMDISSU2_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end



--BDM
-- replace Esssssssss with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','7LTD1,7LTD2,7STD,7STDH,7STDV') --TD 11/24/15 added 7STDK,7STKS 
IF @ExportCode <> 'Esssssssss' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode = 'Esssssssss' BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'stopdate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'Esssssssss' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')    --'Active')
END


EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode
EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode

update dbo.U_dsi_bdm_EmpDeductions
set eedbenAmt = BcaBenAmtCalc
from dbo.U_dsi_bdm_EmpDeductions
join dbo.u_dsi_bdm_BenCalculationAmounts on eedeeid = bcaeeid and eedcoid = bcacoid
    and eedFormatCode = bcaFormatCode and eeddedcode = bcadedcode
where eedFormatCode = @FormatCode and eedvalidforexport = 'Y'

----When Needed:
----Client allows duplicate Deduction code types for LTD to be elected, this causes duplicates in the Data for the vendor.
----Can only send 1 benefit election record.  If the EE elects Buy Up coverage, then send Buy Up, not CORE/ER coverage.
--update dbo.u_dsi_bdm_EmpDeductions
--set eedValidForExport = 'N',
--    eeddedrowstatus = 'Duplicate Coverage, can only have LTD Core or LTD Buyup'
----select *
--from dbo.u_dsi_bdm_EmpDeductions c
--where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
--    and eeddedcode in ('LTDC')
--    and exists (select distinct eedeeid, eedcoid
--        from dbo.u_dsi_bdm_EmpDeductions bu
--        where c.eedeeid = bu.eedeeid and c.eedcoid = bu.eedcoid
--            and bu.eedFormatCode = @FormatCode and bu.eedValidForExport = 'Y'
--            and bu.eeddedcode in ('LTDBU'))



-- Step20 Clean up eelist if needed to only include employees with deductions
-- remove for FMLA
--TD 12/1/15 no FMLA on this file (exclude EE's with no STD/LTD):
            delete dbo.u_EUNMDISSU2_eelist
            from dbo.u_EUNMDISSU2_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions
                            where a.xeeid = eedeeid
                            and a.xcoid = eedcoid
                            and eedformatcode = @formatcode
                            and eedvalidforexport = 'Y')


-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_EUNMDISSU2_EELIST
            from dbo.u_EUNMDISSU2_EELIST
            join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_EUNMDISSU2_eelist
            from dbo.u_EUNMDISSU2_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_EUNMDISSU2_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

--Clean up Terms from Deductions and EEList
/*
        delete U_dsi_bdm_EmpDeductions
            from U_dsi_bdm_EmpDeductions left join vw_int_EmpComp on eedeeid = eeceeid
        where eedFormatCode = @FormatCode
            and eedValidForExport = 'Y'
            and eecDateofTermination is not null and eecemplstatus <> 'A'
            and @daysstopped + eecDateofTermination < getdate()

        delete dbo.u_EUNMDISSU2_eelist
            from dbo.u_EUNMDISSU2_eelist left join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
        where eecDateofTermination is not null
            and @daysstopped + eecDateofTermination < getdate() and eecemplstatus <> 'A'
*/

----EE Filtering when needed
----exclude Non US employees:
--delete dbo.u_EUNMDISSU2_eelist
--    from dbo.u_EUNMDISSU2_eelist 
--    join emppers on xeeid = eepeeid
--where EepAddressCountry <> 'USA'

----exclude TEST employees:
--delete dbo.u_EUNMDISSU2_eelist
--    from dbo.u_EUNMDISSU2_eelist 
--    join emppers on xeeid = eepeeid
--where eepEEID in ('AHYFCU0010K0','AHYFKC0010K0','AHYFUB0010K0','AHYG190020K0','AHYG820010K0','AF3B270000K0','AHAMZC0060K0')



----For STD Earnings
--if object_id('dbo.U_dsi_EUNMDISSU2_EarnsSTD') is not null
--    drop table dbo.U_dsi_EUNMDISSU2_EarnsSTD

--Select
--    xEEID seeid,
--    xCOID scoid,
--    max(pehpercontrol) PerControl,
--    SUM(ISNULL(pehCurAmt,0.00)) as seamt,
--    SUM(ISNULL(pehCurHrs,0.00)) as sehrs
    
--    Into    dbo.U_dsi_EUNMDISSU2_EarnsSTD 
--FROM    dbo.U_EUNMDISSU2_eeList
--join    vw_int_PEarHist (nolock) on xeeid = peheeid and xcoid = pehcoid
----    and substring(pehpercontrol,1,4) = substring(@EndPerControl,1,4)
----    where pehInclInDefComp = 'Y'
--group by xEEID, xCOID


----For LTD Earnings
--if object_id('dbo.U_dsi_EUNMDISSU2_EarnsLTD') is not null
--    drop table dbo.U_dsi_EUNMDISSU2_EarnsLTD

--Select
--    xEEID leeid,
--    xCOID lcoid,
--    max(pehpercontrol) PerControl,
--    SUM(ISNULL(pehCurAmt,0.00)) as leamt,
--    SUM(ISNULL(pehCurHrs,0.00)) as lehrs
    
--    Into    dbo.U_dsi_EUNMDISSU2_EarnsLTD 
--FROM    dbo.U_EUNMDISSU2_eeList
--join    vw_int_PEarHist (nolock) on xeeid = peheeid and xcoid = pehcoid
--    and pehpercontrol in (select distinct top 2 pehpercontrol from vw_int_PEarHist 
--    where right(RTRIM(pehpercontrol),1) = '1'
--    order by 1 desc)
----    where pehInclInDefComp = 'Y'
--group by xEEID, xCOID


--Hours Worked Last 12 Months
if object_id('dbo.U_dsi_EUNMDISSU2_EarnsDefYTD') is not null
    drop table dbo.U_dsi_EUNMDISSU2_EarnsDefYTD

Select
    xEEID Eeeid,
    xCOID Ecoid,
    SUM(ISNULL(pehCurAmt,0.00)) as eamt,
    SUM(ISNULL(pehCurHrs,0.00)) as ehrs
    
    Into    dbo.U_dsi_EUNMDISSU2_EarnsDefYTD 
FROM    dbo.U_EUNMDISSU2_eeList
join    vw_int_PEarHist (nolock) on xeeid = peheeid and xcoid = pehcoid
where PehPayDate between (@EndDate - 365.242199) and @EndDate
group by xEEID, xCOID


----Sick hours - current
--if object_id('dbo.U_dsi_EUNMDISSU2_EarnsSick') is not null
--    drop table dbo.U_dsi_EUNMDISSU2_EarnsSick

--Select
--    xEEID snyeeid,
--    xCOID snycoid,
--    SUM(ISNULL(pehCurAmt,0.00)) as snyamt,
--    SUM(ISNULL(pehCurHrs,0.00)) as snyhrs
    
--Into dbo.U_dsi_EUNMDISSU2_EarnsSick 
--FROM dbo.U_EUNMDISSU2_eeList
--join vw_int_PEarHist (nolock) on xeeid = peheeid and xcoid = pehcoid
--where PEHPERCONTROL between @StartPerControl and @EndPerControl
--    and PehEarnCode in ('SICK')
--group by xEEID, xCOID


--------------------------------------------------------------------------------------------


-- Populate Source for Employees
--Record 02
if object_id('U_dsi_EUNMDISSU2_drvTbl') is not null
  drop table dbo.U_dsi_EUNMDISSU2_drvTbl

-- EE Detail
  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectypex = 'E',
-- standard fields above and additional driver fields below
    drvsort = case when isnull(eepssn,'') = '' then intl.SSN else eepSSN end,
    drvsubsort = '01',
    drvRecType = '02',
    drvCustomerNumber = '330950215',
    drvEmployeeID = eecempno,    
    drvEmployeeIDType = 'EEID',
    drvNameFirst = upper(eepNameFirst),
    drvNameMiddle = upper(eepNameMiddle),
    drvNameLast = upper(eepNameLast),
    drvAddressLine1 = eepAddressLine1,
    drvAddressLine2 = eepAddressLine2,
    drvAddressLine3 = '',
    drvAddressCity = eepAddressCity,
    drvAddressState = eepAddressState,
    drvAddressZipCode = eepAddressZipCode,
    drvCountryCode = case when EepAddressCountry = 'USA' then 'US'
                          when EepAddressCountry = 'CAN' then 'CA' else '' end,
    drvWorkState = EecWCState,
    drvDateofBirth = convert(char(10),eepDateOfBirth,101),
    drvGender = eepGender,
    drvMaritalStatus = case when eepMaritalStatus = 'M' then 'MAR'
                            when eepMaritalStatus = 'S' then 'SGL'
                            when eepMaritalStatus = 'D' then 'DIV'
                        else 'UNK' end,
    drvOccupation = jbcDesc,
    drvDateofHire = convert(char(10),eecDateofLastHire,101),
    drvTerminationDate = convert(char(10),eecDateofTermination,101),
    drvEmploymentStatus = case when eecemplstatus in ('A','T') then 'ACT'
                                when eecemplstatus = 'L' then 'LOA'
--                                when eecemplstatus = 'T' then 'TRM'--?
                        else '' end,
    --drvWklySchedWorkHours = replicate('0',5-len(dbo.dsi_fnRemoveChars('.,/',(cast(eecscheduledannualhrs/52 as decimal(18,2)) )))) 
    --                            + dbo.dsi_fnRemoveChars('.,/',Upper(cast(eecscheduledannualhrs/52 as decimal(18,2)) )),
    drvWklySchedWorkHours = '03200',--TD 12/1/15 per request
    drvSalaryEffDate = convert(char(10),isnull(jh.jobeffdate,eecDateofLastHire),101),
    drvAccommodatesRestrictions = 'Y',
    drvSickPayHrs = '000000',
    drvEmpTaxpayerID = eepssn,
    drvOrigHireDate = convert(char(10),eecDateofOriginalHire,101)

  into dbo.U_dsi_EUNMDISSU2_drvTbl
  from dbo.u_EUNMDISSU2_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join location with (nolock) on eeclocation = loccode
    join jobcode with (nolock) on jbcjobcode = eecjobcode

    left join (select eineeid eeid, einNationalID SSN from empintl) intl on intl.eeid = xEEID
    
    --left join dbo.U_dsi_EUNMDISSU2_EarnsSick on xEEID = snyeeid and xCOID = snycoid
    left join (select ejheeid, ejhcoid, max(ejhjobeffdate) jobeffdate
        from vw_int_EmpHJob where ejhisratechange = 'Y' 
        group by ejheeid,ejhcoid) jh on jh.ejheeid = xeeid and jh.ejhcoid = xcoid
    where EecEmplStatus <> 'T'
        or (EecEmplStatus = 'T' and EecDateOfTermination + @daysstopped >= @EndDate
        or exists (select 1 from dbo.U_dsi_BDM_EmpDeductions where EedFormatCode = @FormatCode and EedValidForExport = 'Y'
        and EedEEID = xEEID) ) --30 days --keep terms on the file regardless of @DaysStopped if they have a valid benefit / coverage record
        

--Record 03   LTD coverage
if object_id('U_dsi_EUNMDISSU2_covTbl') is not null
  drop table dbo.U_dsi_EUNMDISSU2_covTbl

-- EE Detail
  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectypex = 'E',
    drvdedcode = eeddedcode,
-- standard fields above and additional driver fields below
    drvsort = case when isnull(eepssn,'') = '' then intl.SSN else eepSSN end,
    drvsubsort = '02',
    drvRecType = '03',
    drvCustomerNumber = '330950215',
    drvEmployeeID = eecempno,    
-------------------------------------------------------------------------------------------'7STD','7STDH'
    drvProduct = case when eeddedcode IN ('7STD','7STDH','7STDK','7STKS') then '0469'    --STD
                      when eeddedcode IN ('7LTD1') then '0038'    --LTD
                else '' end,
    drvPolicy = case when eeddedcode IN ('7STD','7STDH','7STDK','7STKS') then '00410773' --STD
                     when eeddedcode IN ('7LTD1') then '00410774'    --LTD
                else '' end,
    drvDivision = case when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('705SAL','705SNE') then '0705'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('705HRY') then '0705'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('713SAL','713SNE') then '0713'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('713HRY') then '0713'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('722SAL', '722SNE', '722HSV' ,'722SSV') then '0722'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('759SAL' , '759SNE') then '0759'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('759HRY') then '0759'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('768SAL', '768SNE' ,'768HRY') then '0768'

                        when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '772SAL' ,'772SNE') then '0772'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('772HRY') then '0772'
                       

                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '775SAL', '775SNE', '775HRY') then '0775'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '779SAL', '701SAL', '701SNE') then '0779'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ( '779HRY', '701HRY') then '0779'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '783SAL') then '0783'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ( '783HRY' ) then '0783'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('784HRY','784SAL' ) then '0784'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('785SAL','785SNE') then '0785'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('785HRY') then '0785'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('787HRY','787HNU','787SAL') then '0787'
                       when eeddedcode  IN ('7LTD1','7LTD2')  then '0001'
                        

                   else '' end,
                   
    drvPolicyEligibility = case when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('705SAL','705SNE') then '001'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('705HRY') then '001'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('713SAL','713SNE') then '001'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('713HRY') then '002'
                        when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('722SAL', '722SNE', '722HSV' ,'722SSV') then '001'

                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('759SAL' , '759SNE') then '001'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('759HRY') then '003'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('768SAL', '768SNE' ,'768HRY') then '001'
                        when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '772SAL' ,'772SNE') then '0001'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('772HRY') then '004'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '775SAL', '775SNE', '775HRY') then '001'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '779SAL', '701SAL', '701SNE') then '001'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ( '779HRY', '701HRY') then '002'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ( '783SAL') then '001'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ( '783HRY' ) then '002'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('784HRY','784SAL' ) then '006'
                       when eeddedcode  IN ('7STD','7STDV') and EecPayGroup in ('785SAL','785SNE') then '001'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('785HRY') then '002'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('787HRY') then '005'
                       when eeddedcode  IN ('7STD') and EecPayGroup in ('787HNU','787SAL') then '007'
                       when eeddedcode  IN ('7LTD1','7LTD2') and EecPayGroup not in ('787HNU', '784HRY' ,'784SAL') then '001'
                       when eeddedcode  IN ('7LTD1','7LTD2') and EecPayGroup  in ('787HNU', '784HRY' ,'784SAL') then '002'


                   else '' end,
                            
    drvChoice = case when EedDedCode in ('7STDV') then '02'
                     else '01' end,

    drvEffDateofCovg = convert(char(10),case when eeddedcode IN ('7STD','7STDH','7STDK','7STKS') and eedBenStartDate < @stdplanDate then @stdplandate
                                            when EedDedCode IN ('7LTD1') and EedBenStartDate < @ltdplandate then @ltdplandate
                                        else eedBenStartDate end,101),
    drvCovgTerminationDate = convert(char(10),eedBenStopDate,101),
    drvEarnings = case 
                       when eeddedcode IN ('7STD','7STDH','7STDK','7STKS') then RIGHT('00000000'+ LTRIM(dbo.dsi_fnRemoveChars('.,/',(convert(varchar(8),cast(eecannsalary/52 as decimal(8,2)))))),8)                    
                else RIGHT('00000000'+ LTRIM(dbo.dsi_fnRemoveChars('.,/',(convert(varchar(14),cast(isnull(eecannsalary/12,0) as decimal(12,2)))))),8) end,
    drvEarningsPeriod = case when eeddedcode IN ('7STD','7STDH','7STDK','7STKS') then 'WK' --STD Code    
                             when eeddedcode IN ('7LTD1') then 'MO'    --LTD                        
                else '' end, --LTD Code
    drvEmpPostTaxContr =  CASE WHEN eeddedcode = '7STDV' THEN '040000'
                            ELSE 
                            case when EedDedCode in ('7STDK','7STKS') and EecPayGroup in ('787HRY','787SNE','787SAL','787HNU') then '100000' else '000000' end --TD 12/9/15
                         END
                         --calc if requested (used for some client files):
                         --case when EedDedCode = '1LTD1' then 
                            --  case when isnull(glife.erAmt,0)+isnull(std.erAmt,0)+isnull(ltdc.erAmt,0)+isnull(lifee.eeAmt,0)+isnull(ltdbu.eeAmt,0) > 0 then
                            --  dbo.fn_padzero( cast(
                            --  ( isnull(glife.erAmt,0)+isnull(std.erAmt,0)+isnull(ltdc.erAmt,0) ) /
                            --  ( isnull(glife.erAmt,0)+isnull(std.erAmt,0)+isnull(ltdc.erAmt,0)+isnull(lifee.eeAmt,0)+isnull(ltdbu.eeAmt,0) ) * 10000 
                            --  as decimal (6,0))*10, 6,0)
                            --  else '000000' end
                         --else '000000' end

  into dbo.U_dsi_EUNMDISSU2_covTbl
  from dbo.u_EUNMDISSU2_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join dbo.u_dsi_bdm_EmpDeductions with (nolock) on xeeid = eedeeid and xcoid = eedcoid
        and eedValidForExport = 'Y' and eedFormatCode = @FormatCode --and EecEmplStatus <> 'T' 

    left join (select eineeid eeid, einNationalID SSN from empintl) intl on intl.eeid = xEEID

    ----TD 4/14/15 added for calculating EmpPostTaxContrib Pct per client request (not needed for this file)
    --left join (select eedeeid eeid, eedcoid coid, isnull(EedERLstAmt,0)*2 erAmt
    --    from empded where EedDedCode IN ('xGLIFE')) glife on glife.eeid = xeeid and glife.coid = xcoid            

    --left join (select edheeid eeid, edhcoid coid, isnull(EdhEEAmt,0)*2 eeAmt
    --    from emphded where EdhDedCode IN ('xLIFEE')) lifee on lifee.eeid = xeeid and lifee.coid = xcoid            

    --left join (select edheeid eeid, edhcoid coid, isnull(EdhEEAmt,0)*2 eeAmt
    --    from emphded where EdhDedCode IN ('xLTDBU')) ltdbu on ltdbu.eeid = xeeid and ltdbu.coid = xcoid            

    --left join (select eedeeid eeid, eedcoid coid, isnull(EedERLstAmt,0)*2 erAmt
    --    from empded where EedDedCode IN ('7STD','7STDH')) std on std.eeid = xeeid and std.coid = xcoid            

    --left join (select eedeeid eeid, eedcoid coid, isnull(EedERLstAmt,0)*2 erAmt
    --    from empded where EedDedCode IN ('1LTD1','7LTD1')) ltdc on ltdc.eeid = xeeid and ltdc.coid = xcoid            



    
--NOT USED -- No FMLA reported on this file:
----Record 05  --FMLA Record 1
--if object_id('U_dsi_EUNMDISSU2_fmla1Tbl') is not null
--  drop table dbo.U_dsi_EUNMDISSU2_fmla1Tbl

---- EE Detail
--  select distinct
--    drvEEID = xEEID, 
--    drvcoid = xcoid,
--    drvdepid = cast(null as varchar),
--    drvrectypex = 'E',
---- standard fields above and additional driver fields below
--    drvsort = case when isnull(eepssn,'') = '' then intl.SSN else eepSSN end,
--    drvsubsort = '02',
--    drvRecType = '05',
--    drvCustomerNumber = '330950215',
--    drvEmployeeID = eecempno,    
--    drvEmpHomePhone = case when rtrim(isnull(EepPhoneHomeNumber,'')) = '' then '9999999999' else EepPhoneHomeNumber end, 
--    drvEmpWorkPhone = case when rtrim(isnull(EecPhoneBusinessNumber,'')) = '' then '9999999999' else EecPhoneBusinessNumber end,
--    drvEmpWorkExt = EecPhoneBusinessExt,
--    drvEmpHomeEmail = '',--'heather.turk@ana.org',--eepAddressEMailAlternate,
--    drvEmpWorkEmail = '',--'theresa.green@ana.org',--eepAddressEMail,
--    drvWorkAddressLine1 = '',--locaddressline1,
--    drvWorkAddressLine2 = ''--locaddressline2

--into dbo.U_dsi_EUNMDISSU2_fmla1Tbl
--  from dbo.u_EUNMDISSU2_eelist with (nolock)
--    join empPers with (nolock) on xEEID = eepEEID
--    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
--    left join location with (nolock) on eeclocation = loccode

--    left join (select eineeid eeid, einNationalID SSN from empintl) intl on intl.eeid = xEEID
    
--    where EecEmplStatus <> 'T'
--        or (EecEmplStatus = 'T' and EecDateOfTermination + @daysstopped >= @EndDate
--        or exists (select 1 from dbo.U_dsi_BDM_EmpDeductions where EedFormatCode = @FormatCode and EedValidForExport = 'Y'
--        and EedEEID = xEEID) ) --30 days --3/26/15 keep terms on the file regardless of @DaysStopped if they have a valid benefit / coverage record



----Record 06  --FMLA Record 2
--if object_id('U_dsi_EUNMDISSU2_fmla2Tbl') is not null
--  drop table dbo.U_dsi_EUNMDISSU2_fmla2Tbl

---- EE Detail
--  select distinct
--    drvEEID = xEEID, 
--    drvcoid = xcoid,
--    drvdepid = cast(null as varchar),
--    drvrectypex = 'E',
---- standard fields above and additional driver fields below
--    drvsort = case when isnull(eepssn,'') = '' then intl.SSN else eepSSN end,
--    drvsubsort = '02',
--    drvRecType = '06',
--    drvCustomerNumber = '330950215',
--    drvEmployeeID = eecempno,
--    drvEmpWorkAddressLine3 = '',
--    drvEmpWorkAddressCity = '',--locaddresscity,
--    drvEmpWorkAddressZipCode = '',--locaddresszipcode,

--    drvMgrNameFirst = '',    --TD 5/28/15 Leave Blank
--    drvMgrNameMiddle = '',    --TD 5/28/15 Leave Blank
--    drvMgrNameLast = '',    --TD 5/28/15 Leave Blank
--    drvMgrAddressEmail = case when EecOrgLvl2 = 'xxx02' then 'mberg@griffinpipe.com' --TD 6/9/15 mapped as requested 
--                              when EecOrgLvl2 = 'xxx01' then 'mberg@griffinpipe.com'
--                              when EecOrgLvl2 = 'xxx05' then 'jsmith@griffinpipe.com'
--                         else '' end,--TD 5/28/15 Leave Blank
--    drvMgrPhone = '',        --TD 5/28/15 Leave Blank

--    drvHrsWorkedinPast12Months = ytd.ehrs * 100,--1250 * 100,--TD hard code for some clients
--    drvSalaryorHourly = EecSalaryOrHourly,
--    --TD 6/3/15 changed default values for Fields 14 through 21
--    drvWorkonSunday = 'N', --Field 14
--    drvWorkonMonday = 'N',
--    drvWorkonTuesday = 'N',
--    drvWorkonWednesday = 'N',
--    drvWorkonThursday = 'N',
--    drvWorkonFriday = 'N',
--    drvWorkonSaturday = 'N',
--    drvDoDaysOffChangeDuringLeave = 'Y', --Field 21

--    drvEmpJobTitle = '',--jbcDesc,
--    drvOfficeName = case when EecOrgLvl2 = 'xxx02' then 'xxx Council Bluffs' --NEED INFO
--                         when EecOrgLvl2 = 'xxx01' then 'xxx Downers Grove'
--                         when EecOrgLvl2 = 'xxx05' then 'xxx Lynchburg'
--                    else '' end,
                                             
--    drvvReportingGroup = case when EecOrgLvl2 = 'xxx02' then '000007'
--                         when EecOrgLvl2 = 'xxx01' then '000008'
--                         when EecOrgLvl2 = 'xxx05' then '000009'
--                    else '' end,
--    drvKeyEmployee = ''    

--into dbo.U_dsi_EUNMDISSU2_fmla2Tbl
--  from dbo.u_EUNMDISSU2_eelist with (nolock)
--    join empPers with (nolock) on xEEID = eepEEID
--    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
--    left join location with (nolock) on eeclocation = loccode

--    left join (select eineeid eeid, einNationalID SSN from empintl) intl on intl.eeid = xEEID
        
--    left join (select eepeeid eeid, eepnamelast LName, eepnamefirst FName, eepnamemiddle MName, eepAddressEmail Email, EecPhoneBusinessNumber BPhone
--        from emppers join vw_int_EmpComp on eepeeid = eeceeid) sup on sup.eeid = EecSupervisorID
--    left join jobcode with (nolock) on jbcjobcode = eecjobcode
--    left join (select Eeeid, Ecoid, ehrs
--        from dbo.U_dsi_EUNMDISSU2_EarnsDefYTD) ytd on ytd.Eeeid = xeeid and ytd.Ecoid = xcoid

--    where EecEmplStatus <> 'T'
--        or (EecEmplStatus = 'T' and EecDateOfTermination + @daysstopped >= @EndDate
--        or exists (select 1 from dbo.U_dsi_BDM_EmpDeductions where EedFormatCode = @FormatCode and EedValidForExport = 'Y'
--        and EedEEID = xEEID) ) --30 days --3/26/15 keep terms on the file regardless of @DaysStopped if they have a valid benefit / coverage record


-- Create Headers
--Record 01
if object_id('U_dsi_EUNMDISSU2_hdrTbl') is not null
  drop table dbo.U_dsi_EUNMDISSU2_hdrTbl

select distinct 
    drvsort = '01',
    drvsubsort = '01',
    drvRecType = '01',
    drvProcessDateTime = substring(convert(varchar(26),getdate(),121),1,10)+'-'+SUBSTRING(replace(convert(varchar(26),getdate(),121),':','.'),12,23)+'000',    --9/22/14 replace added
    drvCustomerNumber = '330950215',
    drvCustomerName = 'SunCoke Energy, Inc.',
    drvEnrollmentType = '1'

into dbo.U_dsi_EUNMDISSU2_hdrTbl


-- Create Trailers
--Record 09
if object_id('U_dsi_EUNMDISSU2_trlTbl') is not null
  drop table dbo.U_dsi_EUNMDISSU2_trlTbl

select distinct 
    drvsort = '99',
    drvsubsort = '99',
    drvRecType = '99',
    drvCustomerNumber = '330950215',
    drvTotalIndBasicDataRecords = dbo.fn_padzero((select count(*) from dbo.U_dsi_EUNMDISSU2_drvTbl),9,0),
    drvTotalCovgRecords = dbo.fn_padzero((select count(*) from dbo.U_dsi_EUNMDISSU2_covTbl),9,0),
    drvTotalPaymentDedRecords = '000000000',
    --drvTotalFMLA1DataRecords = dbo.fn_padzero((select count(*) from dbo.U_dsi_EUNMDISSU2_fmla1Tbl),9,0),
    --drvTotalFMLA2DataRecords = dbo.fn_padzero((select count(*) from dbo.U_dsi_EUNMDISSU2_fmla2Tbl),9,0)
    --No FMLA records on this file:
    drvTotalFMLA1DataRecords = dbo.fn_padzero(0,9,0),
    drvTotalFMLA2DataRecords = dbo.fn_padzero(0,9,0)

into dbo.U_dsi_EUNMDISSU2_trlTbl



-- Set FileName  
if (dbo.dsi_fnVariable('EUNMDISSU2','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'SUNCO_UNUM_FMLA_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'EUNMDISSU2'




-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwEUNMDISSU2_Export as
       select top 2000000 rtrim(left(data,(len(data)))) as data from dbo.U_EUNMDISSU2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
            when substring(Recordset,1,1) = 'T' then 3
            else 2 end,
            initialsort, subsort, substring(Recordset,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'EUNMDISSU2'
*/

--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'EUNMDISSU2','EUNMDISSU2'
--dbo.dsi_sp_TestSwitchbox_v2 'EUNMDISSU2','TEST'

END
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_EUNMDISSU2'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_EUNMDISSU2',getdate(),'P','V1.TD'
*/





 CREATE  View dbo.dsi_vwEUNMDISSU2_Export as
       select top 2000000 rtrim(left(data,(len(data)))) as data from dbo.U_EUNMDISSU2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
            when substring(Recordset,1,1) = 'T' then 3
            else 2 end,
            initialsort, subsort, substring(Recordset,2,2)