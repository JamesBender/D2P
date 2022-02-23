SET NOCOUNT ON;
IF OBJECT_ID('U_ECOBTOAMQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBTOAMQB_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECOBTOAMQB_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECOBTOAMQB' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECOBTOAMQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOBTOAMQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOBTOAMQB_G10_BKP_2020_PROD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBTOAMQB_G10_BKP_2020_PROD];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOBTOAMQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBTOAMQB];
GO
IF OBJECT_ID('U_ECOBTOAMQB_File') IS NOT NULL DROP TABLE [dbo].[U_ECOBTOAMQB_File];
GO
IF OBJECT_ID('U_ECOBTOAMQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOBTOAMQB_EEList];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_stateInsert') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_stateInsert];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_planInit') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_planInit];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_planFSAInit') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_planFSAInit];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_planFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_planFSA];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_plan') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_plan];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_event') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_event];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_depplanInit') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_depplanInit];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_depplan') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_depplan];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_dep') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_dep];
GO
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECOBTOAMQB';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECOBTOAMQB';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECOBTOAMQB';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECOBTOAMQB';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECOBTOAMQB';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','ECOBTOAMQB','Discovery COBRA - QB File','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','BN26IC0000K0','N','Apr 21 2017  1:54PM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''T,'')','BN26IC0000K0','20','H','01','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.0"','2','(''DA''=''T'')','BN26IC0000K0','20','H','01','21',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','BN26IC0000K0','5','D','02','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''T,'')','BN26IC0000K0','100','D','02','6',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','3','(''UA''=''T,'')','BN26IC0000K0','50','D','02','106',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','4','(''UA''=''T,'')','BN26IC0000K0','35','D','02','156',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''T,'')','BN26IC0000K0','50','D','02','191',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','6','(''UA''=''T,'')','BN26IC0000K0','1','D','02','241',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''Q,'')','BN26IC0000K0','50','D','02','242',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','BN26IC0000K0','11','D','02','292',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualID"','9','(''UA''=''T,'')','BN26IC0000K0','20','D','02','303',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''T,'')','BN26IC0000K0','35','D','02','323',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''T,'')','BN26IC0000K0','10','D','02','358',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','12','(''UA''=''T,'')','BN26IC0000K0','10','D','02','368',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','13','(''UA''=''Q,'')','BN26IC0000K0','50','D','02','378',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','14','(''UA''=''Q,'')','BN26IC0000K0','50','D','02','428',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','15','(''UA''=''T,'')','BN26IC0000K0','50','D','02','478',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvince"','16','(''UA''=''T,'')','BN26IC0000K0','50','D','02','528',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','17','(''UA''=''T,'')','BN26IC0000K0','35','D','02','578',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','18','(''UA''=''T,'')','BN26IC0000K0','50','D','02','613',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddressSameAsPrimary"','19','(''UA''=''T,'')','BN26IC0000K0','1','D','02','663',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress1"','20','(''UA''=''T,'')','BN26IC0000K0','50','D','02','664',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress2"','21','(''UA''=''T,'')','BN26IC0000K0','50','D','02','714',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCity"','22','(''UA''=''T,'')','BN26IC0000K0','50','D','02','764',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumStateOrProvince"','23','(''UA''=''T,'')','BN26IC0000K0','50','D','02','814',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumPostalCode"','24','(''UA''=''T,'')','BN26IC0000K0','35','D','02','864',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCountry"','25','(''UA''=''T,'')','BN26IC0000K0','50','D','02','899',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','26','(''UA''=''T,'')','BN26IC0000K0','1','D','02','949',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','27','(''UA''=''T,'')','BN26IC0000K0','12','D','02','950',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','28','(''UA''=''T,'')','BN26IC0000K0','35','D','02','962',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','29','(''UA''=''T,'')','BN26IC0000K0','35','D','02','997',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollType"','30','(''UA''=''T,'')','BN26IC0000K0','35','D','02','1032',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfService"','31','(''UA''=''T,'')','BN26IC0000K0','10','D','02','1067',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCouponType"','32','(''UA''=''T,'')','BN26IC0000K0','35','D','02','1077',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsesHCTC"','33','(''UA''=''T,'')','BN26IC0000K0','1','D','02','1112',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActive"','34','(''UA''=''T'')','BN26IC0000K0','1','D','02','1113',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','BN26IC0000K0','15','D','03','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','BN26IC0000K0','32','D','03','33',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UA''=''T,'')','BN26IC0000K0','10','D','03','43',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrossmentDate"','4','(''UA''=''T,'')','BN26IC0000K0','10','D','03','53',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','5','(''UA''=''T,'')','BN26IC0000K0','9','D','03','62',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEName"','6','(''UA''=''T,'')','BN26IC0000K0','100','D','03','162',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondEventOriginalFDOC"','7','(''UA''=''T'')','BN26IC0000K0','10','D','03','172',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''T,'')','BN26IC0000K0','15','D','05','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','BN26IC0000K0','50','D','05','16',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovgLevel"','3','(''UA''=''T,'')','BN26IC0000K0','35','D','05','66',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumofUnits"','4','(''UA''=''T'')','BN26IC0000K0','15','D','05','101',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLAN]"','1','(''DA''=''T,'')','BN26IC0000K0','15','D','06','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','BN26IC0000K0','50','D','06','16',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UA''=''T,'')','BN26IC0000K0','10','D','06','66',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDate"','4','(''UA''=''T,'')','BN26IC0000K0','10','D','06','76',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovLvl"','5','(''UA''=''T,'')','BN26IC0000K0','35','D','06','86',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstDayofCobra"','6','(''UA''=''T,'')','BN26IC0000K0','10','D','06','121',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDayofCobra"','7','(''UA''=''T,'')','BN26IC0000K0','10','D','06','131',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOBRADurationMonths"','8','(''UA''=''T,'')','BN26IC0000K0','10','D','06','141',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaystoElect"','9','(''UA''=''T,'')','BN26IC0000K0','10','D','06','151',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaystoMake1stPmt"','10','(''UA''=''T,'')','BN26IC0000K0','10','D','06','161',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaystoMakeSubsequentPmts"','11','(''UA''=''T,'')','BN26IC0000K0','10','D','06','171',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionPostmarkDate"','12','(''UA''=''T,'')','BN26IC0000K0','10','D','06','181',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDateRatesNotified"','13','(''UA''=''T,'')','BN26IC0000K0','10','D','06','191',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofUnitys"','14','(''UA''=''T,'')','BN26IC0000K0','10','D','06','201',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSendPlanChangeLetterforLegacy"','15','(''UA''=''T,'')','BN26IC0000K0','1','D','06','211',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanBndleName"','16','(''UA''=''T'')','BN26IC0000K0','50','D','06','212',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','BN26IC0000K0','15','D','07','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvssn"','2','(''UA''=''T,'')','BN26IC0000K0','9','D','07','16',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvrelationship"','3','(''UA''=''T,'')','BN26IC0000K0','35','D','07','25',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvsalutation"','4','(''UA''=''T,'')','BN26IC0000K0','35','D','07','60',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvnamef"','5','(''UA''=''T,'')','BN26IC0000K0','50','D','07','95',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMI"','6','(''UA''=''T,'')','BN26IC0000K0','1','D','07','145',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameL"','7','(''UA''=''Q,'')','BN26IC0000K0','50','D','07','146',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvemail"','8','(''UA''=''T,'')','BN26IC0000K0','50','D','07','196',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvphone"','9','(''UA''=''T,'')','BN26IC0000K0','10','D','07','246',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvphone2"','10','(''UA''=''T,'')','BN26IC0000K0','10','D','07','256',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameasQB"','11','(''UA''=''T,'')','BN26IC0000K0','1','D','07','266',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','12','(''UA''=''Q,'')','BN26IC0000K0','50','D','07','267',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','13','(''UA''=''Q,'')','BN26IC0000K0','50','D','07','317',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','14','(''UA''=''T,'')','BN26IC0000K0','50','D','07','367',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','15','(''UA''=''T,'')','BN26IC0000K0','50','D','07','417',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','16','(''UA''=''T,'')','BN26IC0000K0','35','D','07','467',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','17','(''UA''=''T,'')','BN26IC0000K0','50','D','07','502',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntrollmentDate"','18','(''UA''=''T,'')','BN26IC0000K0','10','D','07','552',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','BN26IC0000K0','10','D','07','562',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','20','(''UA''=''T,'')','BN26IC0000K0','10','D','07','572',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsQMSCO"','21','(''UA''=''T'')','BN26IC0000K0','1','D','07','582',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''T,'')','BN26IC0000K0','24','D','08','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPlanName"','2','(''UA''=''T'')','BN26IC0000K0','50','D','08','25',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLAN]"','1','(''DA''=''T,'')','BN26IC0000K0','50','D','09','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPlanName"','2','(''UA''=''T,'')','BN26IC0000K0','50','D','09','51',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStartDate"','3','(''UA''=''T,'')','BN26IC0000K0','10','D','09','101',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEnddate"','4','(''UA''=''T,'')','BN26IC0000K0','10','D','09','111',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepUsesFDOC"','5','(''UA''=''T'')','BN26IC0000K0','5','D','09','121',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBSTATEINSERTS]"','1','(''DA''=''T,'')','BN26IC0000K0','16','D','12','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateSpecificDocumentName"','2','(''UA''=''T'')','BN26IC0000K0','35','D','12','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''T,'')','BN26IC0000K0','33','D','14','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameFSA"','2','(''UA''=''T,'')','BN26IC0000K0','50','D','14','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''T'')','BN26IC0000K0','10','D','14','84',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATE]"','1','(''DA''=''T,'')','BN26IC0000K0','50','D','15','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameFSA"','2','(''UA''=''T,'')','BN26IC0000K0','50','D','15','51',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDateFSA"','3','(''UA''=''T,'')','BN26IC0000K0','10','D','15','101',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDateFSA"','4','(''UA''=''T,'')','BN26IC0000K0','10','D','15','111',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','5','(''UA''=''T'')','BN26IC0000K0','10','D','15','121',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW42\Downloads\V10\Exports\TOAM\EmployeeHistoryExport\ECOBTOAMQB_20200102.txt',NULL,'Null','N',',IHG16,WCR7A,IHFYK',NULL,NULL,NULL,'Discovery QB Wkly Wed@9:30','202002289','EMPEXPORT','ECOBTOAMQB','Jan  2 2020 12:00AM','ECOBTOAMQB',NULL,NULL,NULL,'202102039','Jan  1 2020 12:00AM','Dec 30 1899 12:00AM','202101201',NULL,'eecPaygroup','TAIUS,AISUS,LGAUS,AESUS,ESHUS,ESNUS','201902011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPTOAM',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (NULL,NULL,NULL,NULL,',IHG16,WCR7A,IHG2Y,Q7OPC,IHG4E,IHFYK,IHG95',NULL,NULL,NULL,'Discovery COBRA QB Weekly','202003269','EMPEXPORT','ECOBTOAMQB',NULL,'ECOBTOAMQB',NULL,NULL,NULL,'202102039',NULL,NULL,'202101201',NULL,NULL,'','202003261',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\EW4\EW42\Downloads\V10\Exports\TOAM\EmployeeHistoryExport\TEST_ECOBTOAMQB_20201201.txt',NULL,'','','IHG16,WCR7A,IHG2Y,Q7OPC,IHG4E,IHFYK,IHG95',NULL,NULL,NULL,'TEST Discovery Cobra - QB','202101191','EMPEXPORT','TEST','Jan 19 2021  9:27PM','ECOBTOAMQB',NULL,NULL,NULL,'202101191','Jan 19 2021 12:00AM','Dec 30 1899 12:00AM','202012011','61','','','202012011',dbo.fn_GetTimedKey(),NULL,'us3cPeTOS1003',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','ExportDescription','C','Discovery COBRA - QB File');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','FileType','C','txt');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','MaxFileLength','C','1148');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','SystemID','V','BN26IE0010K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBTOAMQB','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = svCfgValue FROM dbo.U_ECOBTOAMQB_SavePath WHERE CfgName = svCfgName AND FormatCode = svFormatCode AND svCfgValue IS NOT NULL;
IF OBJECT_ID('U_ECOBTOAMQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBTOAMQB_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D02','dbo.U_dsi_ECOBTOAMQB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D03','dbo.U_dsi_ECOBTOAMQB_drvTbl_event',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D05','dbo.U_dsi_ECOBTOAMQB_drvTbl_PlanInit',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D06','dbo.U_dsi_ECOBTOAMQB_drvTbl_plan',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D07','dbo.U_dsi_ECOBTOAMQB_drvTbl_dep',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D08','dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D09','dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D12','dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D14','dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBTOAMQB','D15','dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA',NULL);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvClientName] varchar(25) NOT NULL,
    [drvClientDivisionName] varchar(50) NULL,
    [drvSalutation] varchar(1) NOT NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NOT NULL,
    [drvLastName] varchar(100) NULL,
    [drvSSN] char(11) NULL,
    [drvIndividualID] char(9) NULL,
    [drvEmail] varchar(1) NOT NULL,
    [drvPhone] varchar(1) NOT NULL,
    [drvPhone2] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvStateOrProvince] varchar(255) NULL,
    [drvPostalCode] varchar(50) NULL,
    [drvCountry] varchar(3) NULL,
    [drvPremiumAddressSameAsPrimary] varchar(1) NOT NULL,
    [drvPremiumAddress1] varchar(1) NOT NULL,
    [drvPremiumAddress2] varchar(1) NOT NULL,
    [drvPremiumCity] varchar(1) NOT NULL,
    [drvPremiumStateOrProvince] varchar(1) NOT NULL,
    [drvPremiumPostalCode] varchar(1) NOT NULL,
    [drvPremiumCountry] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvTobaccoUse] varchar(7) NOT NULL,
    [drvEmployeeType] varchar(7) NOT NULL,
    [drvEmployeePayrollType] varchar(9) NOT NULL,
    [drvYearsOfService] varchar(1) NOT NULL,
    [drvPremiumCouponType] varchar(10) NOT NULL,
    [drvUsesHCTC] varchar(2) NOT NULL,
    [drvActive] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_dep') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_dep] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] char(12) NOT NULL,
    [drvsort] char(11) NULL,
    [drvsort2] char(11) NULL,
    [drvssn] char(11) NULL,
    [drvrelationship] varchar(15) NOT NULL,
    [drvsalutation] varchar(1) NOT NULL,
    [drvnamef] varchar(100) NULL,
    [drvMI] varchar(1) NULL,
    [drvNameL] varchar(100) NULL,
    [drvemail] varchar(1) NOT NULL,
    [drvphone] varchar(1) NOT NULL,
    [drvphone2] varchar(1) NOT NULL,
    [drvAddressSameasQB] varchar(1) NOT NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountry] varchar(1) NOT NULL,
    [drvEntrollmentDate] varchar(1) NOT NULL,
    [drvSex] char(1) NULL,
    [drvDOB] varchar(10) NULL,
    [drvIsQMSCO] varchar(5) NOT NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_depplan') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_depplan] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] char(12) NOT NULL,
    [drvsort] char(11) NULL,
    [drvsort2] char(11) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvDepPlanName] varchar(70) NULL,
    [drvDepStartDate] varchar(10) NULL,
    [drvDepEnddate] varchar(1) NOT NULL,
    [drvDepUsesFDOC] varchar(4) NOT NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_depplanInit') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_depplanInit] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] char(12) NOT NULL,
    [drvsort] char(11) NULL,
    [drvsort2] char(11) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvDepPlanName] varchar(70) NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_event') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_event] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvSSN] char(11) NULL,
    [drvEventType] varchar(29) NULL,
    [drvEventDate] varchar(10) NULL,
    [drvEnrossmentDate] varchar(10) NULL,
    [drvEmployeeSSN] char(11) NULL,
    [drvEEName] varchar(203) NULL,
    [drvSecondEventOriginalFDOC] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_plan') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_plan] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvPlanName] varchar(70) NULL,
    [drvStartDate] varchar(10) NULL,
    [drvEndDate] varchar(1) NOT NULL,
    [drvCovLvl] varchar(18) NOT NULL,
    [drvFirstDayofCobra] varchar(1) NOT NULL,
    [drvLastDayofCobra] varchar(1) NOT NULL,
    [drvCOBRADurationMonths] varchar(1) NOT NULL,
    [drvDaystoElect] varchar(1) NOT NULL,
    [drvDaystoMake1stPmt] varchar(1) NOT NULL,
    [drvDaystoMakeSubsequentPmts] varchar(1) NOT NULL,
    [drvElectionPostmarkDate] varchar(1) NOT NULL,
    [drvLastDateRatesNotified] varchar(1) NOT NULL,
    [drvNumberofUnitys] varchar(1) NOT NULL,
    [drvSendPlanChangeLetterforLegacy] varchar(5) NOT NULL,
    [drvPlanBndleName] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_planFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_planFSA] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvPlanNameFSA] varchar(15) NULL,
    [drvStartDateFSA] varchar(10) NULL,
    [drvEndDateFSA] varchar(10) NULL,
    [drvRate] char(8) NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_planFSAInit') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_planFSAInit] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvPlanNameFSA] varchar(15) NULL,
    [drvRate] char(8) NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_planInit') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_planInit] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvPlanName] varchar(70) NULL,
    [drvCovgLevel] varchar(18) NOT NULL,
    [drvNumofUnits] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ECOBTOAMQB_drvTbl_stateInsert') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBTOAMQB_drvTbl_stateInsert] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvStateSpecificDocumentName] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOBTOAMQB_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOBTOAMQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECOBTOAMQB_File') IS NULL
CREATE TABLE [dbo].[U_ECOBTOAMQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE procedure [dbo].[dsi_sp_BuildDriverTables_ECOBTOAMQB]
@systemid char(12)
as

/**********************************************************************
Client Name: Toshiba America, Inc. 
Vendor: Discovery - CSV
Created By: Hyma Akkiraju
Template Base: JIMS DB ECOBMISSIQB
Business Analyst: Ritchie Rossi
Create Date: 04/21/2017
Service Request Number: TOS1003-2017-00149983-Integration File Sub Component - No Charge - Discvry Cobra

Changes:
04/25/2018   B'Nai Jackson    PR-263187            Update LPFSA
01/02/2020    Katrina Prather        PR-331832        Update the client division name field to reflect company code only| 1/29/20 complimentary add of plans for TAES.

_dsi_usp_ExportRipout 'ECOBTOAMQB','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'ECOBTOAMQB' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ECOBTOAMQB'
select * from dbo.U_dsi_Parameters where FormatCode = 'ECOBTOAMQB'

select * from AscDefH where AdhFormatCode = 'ECOBTOAMQB'
select * from AscExp where expFormatCode = 'ECOBTOAMQB'
select * from ascdeff where AdfHeaderSystemID = 'ECOBTOAMQBZ0' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'ECOBTOAMQB', 'ECOBTOAMQB'
DSI_SP_TESTSWITCHBOX_V2 'ECOBTOAMQB', 'TEST'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ECOBTOAMQB' AND CfgName = 'TESTING'

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
        @ExportFile char(200);
        
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
    WHERE SystemID = @SystemID;

-- change variables below as needed
declare @D02 char(1)--[QB]
    ,@D03 char(1)--[QBEVENT]
    ,@D05 char(1)--[QBPLANINITIAL]
    ,@D06 char(1)--[QBPLAN]
    ,@D07 char(1)--[QBDEPENDENT]
    ,@D08 char(1)--[QBDEPENDENTPLANINITIAL]
    ,@D09 char(1)--[QBDEPENDENTPLAN]
    ,@D12 char(1)--[QBSTATEINERTS]
    ,@D14 char(1)--[QBPLANMEMBERSPECIFICRATEINITIAL]
    ,@D15 char(1);--[QBPLANMEMBERSPECIFICRATE]

set @D02 = 'Y';    -- Y or N  indicates if this export uses the [QB] record
set @D03 = 'Y';    -- Y or N  indicates if this export uses the [QBEVENT] record
set @D05 = 'Y';    -- Y or N  indicates if this export uses the [QBPLANINITIAL] record
set @D06 = 'N';    -- Y or N  indicates if this export uses the [QBPLAN] record
set @D07 = 'Y';    -- Y or N  indicates if this export uses the [QBDEPENDENT] record
set @D08 = 'Y';    -- Y or N  indicates if this export uses the [QBDEPENDENTPLANINITIAL] record
set @D09 = 'N';    -- Y or N  indicates if this export uses the [QBDEPENDENTPLAN] record
set @D12 = 'N';    -- Y or N  indicates if this export uses the [QBSTATEINSERTS] record
set @D14 = 'Y';    -- Y or N  indicates if this export uses the [QBPLANMEMBERSPECIFICRATEINITIAL] record
set @D15 = 'N';    -- Y or N  indicates if this export uses the [QBPLANMEMBERSPECIFICRATE] record

/*
[VERSION]                            ECOBTOAMQB     H01    NONE
[QB]                                ECOBTOAMQB     D02    dbo.U_dsi_ECOBTOAMQB_drvTbl
[QBEVENT]                            ECOBTOAMQB     D03    dbo.U_dsi_ECOBTOAMQB_drvTbl_event
[QBPLANINITIAL]                        ECOBTOAMQB     D05    dbo.U_dsi_ECOBTOAMQB_drvTbl_PlanInit
[QBPLAN]                            ECOBTOAMQB     D06    dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
[QBDEPENDENT]                        ECOBTOAMQB     D07    dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
[QBPLANINITIAL]                        ECOBTOAMQB     D08    dbo.U_dsi_ECOBTOAMQB_drvTbl_DepPlanInit
[QBDEPENDENTPLAN]                    ECOBTOAMQB     D09    dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
[QBSTATEINSERTS]                    ECOBTOAMQB     D12    dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert
[QBPLANMEMBERSPECIFICRATEINITIAL]    ECOBTOAMQB     D14    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit
[QBPLANMEMBERSPECIFICRATE]            ECOBTOAMQB     D15    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA
*/

--BDM COBRA
DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;
--DELETE FROM dbo.u_dsi_bdm_EElist where xFormatCode = @Formatcode                

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','MED,DEN,VIS')

---INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedTypes', 'MED')--,DEN,VIS,FSA')--,OTH,HSA')---- Vinny said the cobra covered dedcodes flag below overrides this setting
--select deddedcode, dedlongdesc, deddedtype from dedcode where dediscobracovered = 'Y'
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate); --@EndDate - @daysstopped)
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');--'ActiveOnly') --'stopdate') 

--'AuditDate')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'UseCobraCoveredDeds', 'Y');
-- Y - use only dedcodes with DedIsCobraCovered = Y. This is the default for Cobra runs.
-- N - use only dedcodes with DedIsCobraCovered <> Y.
-- A - use specified dedcodes for Cobra runs regardless of value in DedIsCobraCovered
--select * from codes where codtable = 'relation'
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC,DAU,SON,CHD');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDomPartner', 'DP');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDPChild', 'DPC');

--COBRA BDM QE Inserts:
--*********************
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraType', '1');
-- 1> Pull reasons from EepCobraReason and ConCobraReason
-- 2> Pull reasons from EmpHDed and ConCobraReason
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraDate', '1');
-- 1> Pull Cobra dates from EepDateofCobraEvent and ConDateofCobraEvent
-- 2> Pull Cobra dates from benefit stop dates
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraIncludeEmps', 'Y')

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

--Fix BDM for Employee Deaths, Valid Dependents, Invalid EE's:
DECLARE @CobraPQBType              VARCHAR(1);
DECLARE @RelationshipsSpouse       VARCHAR(256);
DECLARE @RelationshipsChild        VARCHAR(256);
SELECT @CobraPQBType = CONVERT(VARCHAR(1), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraPQBType';
SELECT @RelationshipsSpouse = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsSpouse';
SELECT @RelationshipsChild = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsChild';
SET @CobraPQBType            = dbo.dsi_bdm_fn_Trim(@CobraPQBType);
SET @RelationshipsSpouse     = dbo.dsi_bdm_fn_Trim(@RelationshipsSpouse);
SET @RelationshipsChild      = dbo.dsi_bdm_fn_Trim(@RelationshipsChild);

UPDATE U_dsi_bdm_EmpDeductions
   SET EedValidForExport = 'N',
       EedDedRowStatus   = 'Benefit change reason not valid for Cobra'
  FROM U_dsi_bdm_EmpDeductions
  LEFT JOIN U_dsi_bdm_ChangeReasons WITH (NOLOCK) ON ChgFormatCode = @FormatCode AND EedCobraReason = ChgChangeReason AND ChgTarget = 'EMP'
WHERE EedFormatCode = @FormatCode
   AND EedValidForExport = 'Y'
   AND eedCobraReason in ('210','205');

-----------------------
-- Set the PQB flags
-----------------------

-- Spouses
UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = DbnRelationship
WHERE DbnFormatCode = @FormatCode
   AND DbnValidForExport = 'Y'
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = DbnEEID);

-- Children

UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions a
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsChild) ON item = a.DbnRelationship
WHERE a.DbnFormatCode = @FormatCode
   AND a.DbnValidForExport = 'Y'
   AND a.DbnIsChildOldest = CASE
                               WHEN @CobraPQBType = '1' THEN a.DbnIsChildOldest -- ALL children are PQB
                               ELSE 'Y'
                            END
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = a.DbnEEID)
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_DepDeductions b
                     JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = b.DbnRelationship
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.DbnEEID = a.DbnEEID);

--*******************END BDM FIX SECTION*********************************

--Update Benefit Option for Dependent PQB record:
--send EE as benefit option when coverage was EE + Child or EE + Spouse, and Dependent lost coverage.
UPDATE U_dsi_bdm_DepDeductions
    set dbnbenoption = 'EE'
from U_dsi_bdm_DepDeductions a
WHERE DbnFormatCode = @FormatCode
    AND DbnValidForExport = 'Y'
    AND dbnispqb = 'Y'
    and dbnbenoption in ('EEC','EEF','EES','EEDP','EEDPF')
    AND NOT EXISTS(SELECT 1 FROM U_dsi_bdm_DepDeductions b
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.dbnispqb <> 'Y'
                      AND b.DbnEEID = a.DbnEEID);
/*
--Valid Benefit Options
select distinct corbenoption, bnoDescription
from OptRate join benopt on bnocode = CorBenOption
join DedCode on deddedcode = CorDedCode
where DedIsCobraCovered = 'Y'
*/

--Fix the PQB Record Benefit Option on deduction codes, where the PQB has dependents, and shouldn't be EE coverage offering
declare @PQBLoop1 int, @PQBLoop2 int;

set @PQBLoop1 = 0;
set @PQBLoop2 = (select count(*) from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

--select @PQBLoop1, @PQBLoop2

while @PQBLoop1 < @PQBLoop2
BEGIN

declare @dbndeprecid char(12), @dbneeid char(12);
set @dbndeprecid = (select top 1 dbndeprecid from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

set @dbneeid = (select distinct dbneeid from dbo.u_dsi_bdm_DepDeductions where dbndeprecid = @dbndeprecid);

update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions
where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnisPQB = 'Y'
    and dbnBenOption = 'EE' and dbndepRecid = @dbndeprecid;

set @PQBLoop1 = @PQBLoop1 + 1;
END;

--Update the Non-PQB records to have correct coverage:
update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb <> 'Y'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb = 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid
            and b.dbnbenoption <> d.dbnbenoption
            and dbnbenoption <> 'EE');

-----
-- Build Employee Data
-----
-- [QB]                        ECOBTOAMQB     D02    dbo.U_dsi_ECOBTOAMQB_drvTbl

if object_id('U_dsi_ECOBTOAMQB_drvTbl') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl;

SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvClientName = 'Toshiba America Inc 29924'
    ,drvClientDivisionName =  cast(cmpcompanycode  as varchar(50))  --kp 1/2/20
                        /* orig logic
                        case when cmpcompanycode  = 'TAI' then                                
                                    case when eecorglvl4  in ('3200000', '3210000', '3220000', '3221000', '3224000', '3230000', '3310000', '3320000', '3330000', '3340000', '3370000', '3400000', '3420000', '3427000', '3430000', '3450000')
                                              then 'NASSC'
                                         when eecorglvl4  in ('14001', '14002') then 'P&E' else 'TAI' end
                                        else  cast(cmpcompanycode  as varchar(50)) end
                        */
    ,drvSalutation = ''
    ,drvFirstName = rtrim(eepnamefirst)
    ,drvMiddleInitial = isnull(upper(substring(eepnamemiddle,1,1)),'')
    ,drvLastName = eepnamelast
    ,drvSSN = eepssn
    ,drvIndividualID = eecempno
    ,drvEmail = ''
    ,drvPhone = ''
    ,drvPhone2 = ''
    ,drvAddress1 = eepaddressline1
    ,drvAddress2 = eepaddressline2
    ,drvCity = eepaddresscity
    ,drvStateOrProvince = eepaddressstate
    ,drvPostalCode = eepaddresszipcode
    ,drvCountry = case when eepaddresscountry = 'usa' then '' else eepaddresscountry end
    ,drvPremiumAddressSameAsPrimary = 'Y'
    ,drvPremiumAddress1 = ''
    ,drvPremiumAddress2 = ''
    ,drvPremiumCity = ''
    ,drvPremiumStateOrProvince = ''
    ,drvPremiumPostalCode = ''
    ,drvPremiumCountry = ''
    ,drvSex = eepgender
    ,drvDOB = convert(varchar(10),eepdateofbirth,101)
    ,drvTobaccoUse = case when EepIsSmoker='y' then 'YES' when EepIsSmoker='n' then 'NO' else 'UNKNOWN' end
    ,drvEmployeeType = 'UNKNOWN'
    ,drvEmployeePayrollType = case when EecSalaryOrHourly = 'h' THEN 'NONEXEMPT' when EecSalaryOrHourly = 's' then 'EXEMPT' else 'UNKNOWN' END
    ,drvYearsOfService = ''
    ,drvPremiumCouponType = 'COUPONBOOK'
    ,drvUsesHCTC = 'NO'
    ,drvActive = 'Y'

INTO dbo.U_dsi_ECOBTOAMQB_drvTbl
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on xcoid = cmpcoid

join (select distinct eedeeid eeid, eedcoid coid
    from dbo.u_dsi_bdm_EmpDeductions
    where eedFormatCode = @FormatCode and eedValidForExport = 'Y') ee on ee.eeid = xeeid and ee.coid = xcoid
where xFormatCode = @FormatCode
    and @D02 = 'Y';

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl

--Dependent is PQB
insert INTO dbo.U_dsi_ECOBTOAMQB_drvTbl
SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvClientName = 'Toshiba America Inc 29924'
    ,drvClientDivisionName = cast(cmpcompanycode  as varchar(50))  --kp 1/2/20
                        /*
                            case when cmpcompanycode  = 'TAI' then                                
                                    case when eecorglvl4 in ('3200000', '3210000', '3220000', '3221000', '3224000', '3230000', '3310000', '3320000', '3330000', '3340000', '3370000', '3400000', '3420000', '3427000', '3430000', '3450000')
                                        then 'NASSC'
                                         when eecorglvl4  in ('14001', '14002') then 'P&E' else 'TAI' end
                                        else  cast(cmpcompanycode  as varchar(50)) end
                        */
    ,drvSalutation = ''
    ,drvFirstName = rtrim(connamefirst)
    ,drvMiddleInitial = isnull(upper(substring(connamemiddle,1,1)),'')
    ,drvLastName = connamelast
    ,drvSSN = conssn
    ,drvIndividualID = eecempno
    ,drvEmail = ''
    ,drvPhone = ''
    ,drvPhone2 = ''
    ,drvAddress1 = conaddressline1
    ,drvAddress2 = conaddressline2
    ,drvCity = conaddresscity
    ,drvStateOrProvince = conaddressstate
    ,drvPostalCode = conaddresszipcode
    ,drvCountry = case when conaddresscountry = 'usa' then '' else conaddresscountry end
    ,drvPremiumAddressSameAsPrimary = 'Y'
    ,drvPremiumAddress1 = ''
    ,drvPremiumAddress2 = ''
    ,drvPremiumCity = ''
    ,drvPremiumStateOrProvince = ''
    ,drvPremiumPostalCode = ''
    ,drvPremiumCountry = ''
    ,drvSex = congender
    ,drvDOB = convert(varchar(10),condateofbirth,101)
    ,drvTobaccoUse = case when conIsSmoker='y' then 'YES' when conIsSmoker='n' then 'NO' else 'UNKNOWN' end
    ,drvEmployeeType = 'UNKNOWN'
    ,drvEmployeePayrollType = case when EecSalaryOrHourly = 'h' THEN 'NONEXEMPT' when EecSalaryOrHourly = 's' then 'EXEMPT' else 'UNKNOWN' END
    ,drvYearsOfService = ''
    ,drvPremiumCouponType = 'COUPONBOOK'
    ,drvUsesHCTC = 'NO'
    ,drvActive = 'Y'

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = xcoid
join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid
    from dbo.u_dsi_bdm_DepDeductions
    where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y'
        and dbnispqb = 'Y') dp on dp.eeid = xeeid and dp.coid = xcoid
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D02 = 'Y'
order by 1;

-------
--employees QB record
------
-- [QBEVENT]                    ECOBTOAMQB     D03    dbo.U_dsi_ECOBTOAMQB_drvTbl_event
if object_id('U_dsi_ECOBTOAMQB_drvTbl_event') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_event;

SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvSSN = eepssn
    ,drvEventType = case
            when EecTermType = 'I' and eedCobraReason = '200' then 'INVOLUNTARYTERMINATION'
            when eedCobraReason = '204' then 'DIVORCELEGALSEPARATION'
            when eedCobraReason = '210' then 'DEATH'
            when eedCobraReason = '201' then 'INELIGIBLEDEPENDENT'
            when eedCobraReason = '205' then 'MEDICARE'
            when eedCobraReason = '200' then 'TERMINATION'
            when eedCobraReason = '208' then 'RETIREMENT'
            when eedCobraReason = '203' then 'REDUCTIONINHOURS-STATUSCHANGE'
            when eedCobraReason = '202' then 'LOSSOFELIGIBILITY'
            when eedCobraReason = '206' then 'REDUCTIONINHOURS-ENDOFLEAVE'
            end
    ,drvEventDate = convert(varchar(10),CobraDate,101)
    ,drvEnrossmentDate = convert(varchar(10),startdt,101)   --enroll of med plan
    ,drvEmployeeSSN = eepssn
    ,drvEEName = '"'+eepnamelast+','+eepnamefirst+'"'
    ,drvSecondEventOriginalFDOC = ''

INTO dbo.U_dsi_ECOBTOAMQB_drvTbl_event
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct eedeeid eeid, eedcoid coid, eedCobraReason, min(eedbenstartdate) startdt, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid, eedCobraReason) ee on ee.eeid = xeeid and ee.coid = xcoid
where xFormatCode = @FormatCode
    and @D03 = 'Y';

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_event

--Dependent is PQB
insert INTO dbo.U_dsi_ECOBTOAMQB_drvTbl_event
SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvSSN = conssn
    ,drvEventType = case
            when EecTermType = 'I' and dbnCobraReason = '200' then 'INVOLUNTARYTERMINATION'
            when dbnCobraReason = '204' then 'DIVORCELEGALSEPARATION'
            when dbnCobraReason = '210' then 'DEATH'
            when dbnCobraReason = '201' then 'INELIGIBLEDEPENDENT'
            when dbnCobraReason = '205' then 'MEDICARE'
            when dbnCobraReason = '200' then 'TERMINATION'
            when dbnCobraReason = '208' then 'RETIREMENT'
            when dbnCobraReason = '203' then 'REDUCTIONINHOURS-STATUSCHANGE'
            when dbnCobraReason = '202' then 'LOSSOFELIGIBILITY'
            when dbnCobraReason = '206' then 'REDUCTIONINHOURS-ENDOFLEAVE'
            end
    ,drvEventDate = convert(varchar(10),CobraDate,101)
    ,drvEnrossmentDate = convert(varchar(10),startdt,101)   --enroll of med plan
    ,drvEmployeeSSN = eepssn
    ,drvEEName = '"'+eepnamelast+','+eepnamefirst+'"'
    ,drvSecondEventOriginalFDOC = ''

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid, dbnCobraReason, min(dbnbenstartdate) startdt, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid, dbnCobraReason) dp on dp.eeid = xeeid and dp.coid = xcoid
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D03 = 'Y';

-----
--coverage record ee - Non Bundled Plans
-----
--[QBPLANINITAL]    ECOBTOAMQB     D05    dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit

if object_id('U_dsi_ECOBTOAMQB_drvTbl_planInit') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))

    ,drvPlanName = cast(case 
                            when eeddedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when eeddedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when eeddedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when eeddedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when eeddedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when eeddedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when eeddedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when eeddedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when eeddedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when eeddedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when eeddedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when eeddedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when eeddedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when eeddedcode  =  'AISED'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =  'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when eeddedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when eeddedcode  =    'AFDN1'                                    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'                                    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when eeddedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when eeddedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when eeddedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when eeddedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when eeddedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'

                            when eeddedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA
                            
                            else eeddedcode end as varchar(70))

    ,drvCovgLevel = case --when deddedtype = 'FSA' then 'EE'
                        when eedbenoption in ('EE') THEN 'EE'
                        when eedbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when eedbenoption in ('EES') THEN 'EE+SPOUSE'
                        when eedbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when eedbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                        when  eeddedcode in ('HCFSA','LPFSA')then 'EE' --04/25/18 Add LPFSA
                    else '' end
    ,drvNumofUnits = ''

into dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
        join company on cmpcoid = eeccoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
where xFormatCode = @FormatCode
    and @D05 = 'Y';

--Dependent is PQB
Insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))

    ,drvPlanName = cast(case  
                            when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when dbndedcode  =    'AFDN1'                                    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'                                    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                            else '' end as varchar(70))

    ,drvCovgLevel = case --when deddedtype = 'FSA' then 'EE'
                        when dbnbenoption in ('EE') THEN 'EE'
                        when dbnbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when dbnbenoption in ('EES') THEN 'EE+SPOUSE'
                        when dbnbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when dbnbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                    else '' end
    ,drvNumofUnits = ''

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = eeccoid
left join (select distinct dbneeid eeid, dbncoid coid,dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, dbndedcode dedcode, count(dbnDepReciD) cnt
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndedcode) dep on dep.eeid = xeeid and dep.coid = xcoid and dep.dedcode = DbnDedCode
where xFormatCode = @FormatCode
    and @D05 = 'Y';

-----
--coverage record ee
-----
--[QBPLAN]                    ECOBTOAMQB     D06    dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
if object_id('U_dsi_ECOBTOAMQB_drvTbl_plan') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_plan;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = eeddedcode
    ,drvPlanName = cast(case 
                            when eeddedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when eeddedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when eeddedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when eeddedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when eeddedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when eeddedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when eeddedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when eeddedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when eeddedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when eeddedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when eeddedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when eeddedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when eeddedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when eeddedcode  =  'AISED'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when eeddedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when eeddedcode  =    'AFDN1'                                    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'                                    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when eeddedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when eeddedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when eeddedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when eeddedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when eeddedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                            else '' end as varchar(70))
    ,drvStartDate = case when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                    else convert(varchar(10),CobraDate+1,101) end
    ,drvEndDate = ''
    ,drvCovLvl = case --when deddedtype = 'FSA' then 'EE'
                        when eedbenoption in ('EE') THEN 'EE'
                        when eedbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when eedbenoption in ('EES') THEN 'EE+SPOUSE'
                        when eedbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when eedbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                        when  eeddedcode in ('HCFSA','LPFSA')then 'EE' --04/25/18 Add LPFSA
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = ''

into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on eeccoid = cmpcoid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
where xFormatCode = @FormatCode
    and @D06 = 'Y';

/*
--Insert Bundled Plan - HRA
insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanName = 'Health Reimbursement Account'
    ,drvStartDate = convert(varchar(10),CobraDate+1,101)
    ,drvEndDate = ''
    ,drvCovLvl = case when eedbenoption in ('EE','EE50') THEN 'EE'
                    when eedbenoption = 'EEC' THEN 'EE+CHILDREN'
                    when eedbenoption = 'EES' THEN 'EE+SPOUSE'
                    when eedbenoption like 'EE1%' THEN 'EE+1'
                    when eedbenoption like 'EEF%' THEN 'EE+FAMILY'
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = case when eeddedcode in ('TFPOS','TPOS1','TPOS5') then cast('Tufts POS Basic bundled w/HRA' as varchar(50))
                        when eeddedcode in ('TFHMO','THMO1','THMO5') then cast('Tufts HMO Basic bundled w/HRA' as varchar(50))
                    end

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
    and deddedtype <> 'FSA' and eeddedcode in ('TFPOS','TPOS1','TPOS5','TFHMO','THMO1','THMO5')
where xFormatCode = @FormatCode
    and @D06 = 'Y'
*/
--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_plan

--Dependent is PQB
insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = dbndedcode
    ,drvPlanName = case 
                    when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                    when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                    when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                    when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                    when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                    when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                    when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                    when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                    when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                    when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                    when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                    when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                    when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                    when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                    when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                    when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                    when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                    when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                    when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                    when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                    when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                    when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                    when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                    when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                    when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                    when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                    when dbndedcode  =    'AFDN1'      then    'Delta Dental HMO'
                    when dbndedcode  =    'AFDN2'      then    'Delta Dental PPO'
                    when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                    when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                    when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                    when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                    when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                    when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                    when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                    when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                    when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                    when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                    when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                    when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                    when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                    when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                    when dbndedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA
                     else '' end
    ,drvStartDate = case when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                    else convert(varchar(10),CobraDate+1,101) end
    ,drvEndDate = ''
    ,drvCovLvl = case --when deddedtype = 'FSA' then 'EE'
                        when dbnbenoption in ('EE') THEN 'EE'
                        when dbnbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when dbnbenoption in ('EES') THEN 'EE+SPOUSE'
                        when dbnbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when dbnbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                        when  dbndedcode in ('HCFSA','LPFSA')then 'EE' --04/25/18 Add LPFSA
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = ''

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = eeccoid
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid) dp on dp.eeid = xeeid and dp.coid = xcoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, dbndedcode dedcode, count(dbnDepReciD) cnt
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndedcode) dep on dep.eeid = xeeid and dep.coid = xcoid and dep.dedcode = DbnDedCode
where xFormatCode = @FormatCode
    and @D06 = 'Y';

/*
--Dependent Event - Insert HRA Bundled Plan
insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanName = 'Health Reimbursement Account - Dep Event'
    ,drvStartDate = convert(varchar(10),CobraDate+1,101)
    ,drvEndDate = ''
    ,drvCovLvl = case when dbnbenoption in ('EE','EE50') THEN 'EE'
                    when dbnbenoption = 'EEC' THEN 'EE+CHILDREN'
                    when dbnbenoption = 'EES' THEN 'EE+SPOUSE'
                    when dbnbenoption like 'EE1%' THEN 'EE+1'
                    when dbnbenoption like 'EEF%' THEN 'EE+FAMILY'
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = case when dbndedcode in ('TFPOS','TPOS1','TPOS5') then 'Tufts POS Basic bdl w/HRA - Dep Event'
                        when dbndedcode in ('TFHMO','THMO1','THMO5') then 'Tufts HMO Basic bdl w/HRA - Dep Event'
                    end

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid) dp on dp.eeid = xeeid and dp.coid = xcoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
    and deddedtype <> 'FSA' and dbndedcode in ('TFPOS','TPOS1','TPOS5','TFHMO','THMO1','THMO5')
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D06 = 'Y'
*/

--dependents QB record
--[QBDEPENDENT]                ECOBTOAMQB     D07    dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
if object_id('U_dsi_ECOBTOAMQB_drvTbl_dep') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_dep;

SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvssn = conssn
    ,drvrelationship = case conrelationship
                            when 'sps' then 'SPOUSE'
                            when 'CLS' then 'SPOUSE'
                            when 'chl' then 'CHILD'
                            when 'CHD' then 'CHILD'
                            when 'stc' then 'CHILD'
                            when 'dau' then 'CHILD'
                            when 'Son' then 'CHILD'
                            when 'DPC' then 'CHILD'
                            when 'DCH' then 'CHILD'
                            when 'dp' then 'DOMESTICPARTNER'
                            else '' end
--select * from codes where codtable = 'relation'
    ,drvsalutation = ''
    ,drvnamef = connamefirst
    ,drvMI = left(connamemiddle,1)
    ,drvNameL = connamelast
    ,drvemail = ''
    ,drvphone = ''
    ,drvphone2 = ''
    ,drvAddressSameasQB = case when eepaddressline1 = conaddressline1 then 'Y' else 'N' end
    ,drvAddress1 = case when eepaddressline1 <> conaddressline1 then conaddressline1 else '' end
    ,drvAddress2 = case when eepaddressline1 <> conaddressline1 then conaddressline2 else '' end
    ,drvCity = case when eepaddressline1 <> conaddressline1 then conaddresscity else '' end
    ,drvState = case when eepaddressline1 <> conaddressline1 then conaddressstate else '' end
    ,drvZip = case when eepaddressline1 <> conaddressline1 then conaddresszipcode else '' end
    ,drvCountry = ''
    ,drvEntrollmentDate = ''--convert(varchar(10),dbnbenstartdate,101)
    ,drvSex = congender
    ,drvDOB = convert(varchar(10),condateofbirth,101)
    ,drvIsQMSCO = 'FALSE'--''

INTO dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct dbneeid, dbncoid, dbndeprecid, min(dbnbenstartdate) startdt
    from dbo.u_dsi_bdm_DepDeductions
    where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
    group by dbneeid, dbncoid, dbndeprecid) dp on xeeid = dbneeid and xcoid = dbncoid
join contacts on consystemid = dbndeprecid
left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
where xFormatCode = @FormatCode
    and @D07 = 'Y';

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep order by drvsort, drvsort2

-----
--coverage record Dep - Non bundled plans
-----
--[QBDEPENDENTPLANINITIAL]            ECOBTOAMQB     D08    dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit

if object_id('U_dsi_ECOBTOAMQB_drvTbl_depplanInit') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvdedcode = dbndedcode
    ,drvDepPlanName = cast(case 
                            when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when dbndedcode  =    'AFDN1'        then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'         then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'    
                            when dbndedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA                    
                        else '' end as varchar(70))
                into dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit
                from dbo.u_dsi_bdm_EEList
                join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
                    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
                join emppers on eepeeid = xeeid
                join company on cmpcoid = eeccoid
                join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
                    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
                left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
                        from dbo.u_dsi_bdm_DepDeductions
                        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
                        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
                join contacts on dbndeprecid = consystemid
                left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
                        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
                        where dbnFormatCode = @FormatCode
                            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
                where xFormatCode = @FormatCode
                    and @D08 = 'Y';

-----
--coverage record Dep
-----
--[QBDEPENDENTPLAN]            ECOBTOAMQB     D09    dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan

if object_id('U_dsi_ECOBTOAMQB_drvTbl_depplan') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvdedcode = dbndedcode

    ,drvDepPlanName = cast(case 
                            when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when dbndedcode  =    'AFDN1'        then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'         then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                            when dbndedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA    
                            else '' end as varchar(70))
    ,drvDepStartDate = case when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                        else convert(varchar(10),CobraDate+1,101) end
    ,drvDepEnddate = ''
    ,drvDepUsesFDOC = 'TRUE'
into dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = eeccoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
where xFormatCode = @FormatCode
    and @D09 = 'Y';

/*
--Dependent Plan - HRA Bundle
INSERT into dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = eepssn
    ,drvsort2 = conssn
    ,drvDepPlanName = 'Health Reimbursement Account'
    ,drvDepStartDate = convert(varchar(10),CobraDate+1,101)
    ,drvDepEnddate = ''
    ,drvDepUsesFDOC = 'TRUE'

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
    and deddedtype <> 'FSA' and dbndedcode in ('TFPOS','TPOS1','TPOS5','TFHMO','THMO1','THMO5')
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
where xFormatCode = @FormatCode
    and @D09 = 'Y'
*/

-- [QBSTATEINSERTS]                    ECOBTOAMQB     D12    dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInserts

if object_id('U_dsi_ECOBTOAMQB_drvTbl_stateInsert') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvStateSpecificDocumentName = ''

into dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct eedeeid eeid, eedcoid coid
    from dbo.u_dsi_bdm_EmpDeductions
    where eedFormatCode = @FormatCode and eedValidForExport = 'Y') ee on ee.eeid = xeeid and ee.coid = xcoid
where xFormatCode = @FormatCode
    and @D12 = 'Y';

--Dependent is PQB
INSERT into dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = eepssn
    ,drvsort2 = conssn
    ,drvStateSpecificDocumentName = ''

from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid
    from dbo.u_dsi_bdm_DepDeductions
    where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y'
        and dbnispqb = 'Y') dp on dp.eeid = xeeid and dp.coid = xcoid
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D12 = 'Y';

-----
--coverage record ee - FSA
-----
--[QBPLANMEMBERSPECIFICRATEINITIAL]    ECOBTOAMQB     D14    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit

if object_id('U_dsi_ECOBTOAMQB_drvTbl_planFSAInit') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanNameFSA =    case eeddedcode
                            when  'LPFSA' then 'DBI Medical FSA'--'Limited purpose FSA'--04/25/18 BJ
                            when  'HCFSA' then 'DBI Medical FSA' end
    ,drvRate = convert(char(8),convert(numeric(12,2),eedeegoalamt/12))

into dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
    and deddedtype = 'FSA'
where xFormatCode = @FormatCode
    and @D14 = 'Y'; --NO FSA!
    

-----
--coverage record ee - FSA
-----
--[QBPLANMEMBERSPECIFICRATE]    ECOBTOAMQB     D15    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA

if object_id('U_dsi_ECOBTOAMQB_drvTbl_planFSA') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanNameFSA = case eeddedcode 
                            when  'LPFSA' then 'DBI Medical FSA'--'Limited purpose FSA'--04/25/18 BJ
                            when   'HCFSA' then 'DBI Medical FSA' end
    ,drvStartDateFSA = convert(varchar(10),CobraDate+1,101)
    ,drvEndDateFSA = convert(varchar(10),dateadd(ms,-3,DATEADD(yy, DATEDIFF(yy,0,@EndDate )+1, 0)) ,101)
    ,drvRate = convert(char(8),convert(numeric(12,2),eedeegoalamt/12))

into dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA
from dbo.u_dsi_bdm_EEList
join vw_int_EmpComp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
    and deddedtype = 'FSA'
where xFormatCode = @FormatCode
    and @D15 = 'Y'; --NO FSA

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA

--Discovery/COBRApoint files:
/*
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
*/

--Dependents not linked to PQB
declare @Loop1 int, @Loop2 int;

set @Loop1 = 0;
set @Loop2 = (select count(*) from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
    where drvsort not in (select drvsort from dbo.U_dsi_ECOBTOAMQB_drvTbl));

WHILE @Loop1 < @Loop2
BEGIN
declare @DepID char(12), @DepEEID char(12), @PQBssn char(9);
set @DepID = (select top 1 drvdepid from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
    where drvsort not in (select drvsort from dbo.U_dsi_ECOBTOAMQB_drvTbl));

set @DepEEID = (select distinct drveeid from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep where drvdepid = @DepID);
set @PQBssn = (select distinct drvsort from dbo.U_dsi_ECOBTOAMQB_drvTbl where drveeid = @DepEEID);

update dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

update dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

update dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

set @Loop1 = @Loop1 + 1;

END;

-- Set FileName
if (dbo.dsi_fnVariable('ECOBTOAMQB','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile = 'TOAM_COBRA_QB_' + replace(convert(char(10), GetDate(), 1), '/',SPACE(0)) + '.csv'
    where FormatCode = 'ECOBTOAMQB';

/*
--Alter the View
ALTER  View dbo.dsi_vwECOBTOAMQB_Export as
        select top 2000000
        left(data,(len(data))) as data
        from dbo.U_ECOBTOAMQB_File with (nolock)
         order by case when substring(RecordSet,1,1) = 'H' then 1 else 2 end,InitialSort, Subsort, substring(RecordSet,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'ECOBTOAMQB'
*/

--dbo.dsi_sp_testSwitchbox_v2 'ECOBTOAMQB','ECOBTOAMQB'
--dbo.dsi_sp_testSwitchbox_v2 'ECOBTOAMQB','TEST'        --non UDES file
GO
CREATE procedure [dbo].[dsi_sp_BuildDriverTables_ECOBTOAMQB]
@systemid char(12)
as

/**********************************************************************
Client Name: Toshiba America, Inc. 
Vendor: Discovery - CSV
Created By: Hyma Akkiraju
Template Base: JIMS DB ECOBMISSIQB
Business Analyst: Ritchie Rossi
Create Date: 04/21/2017
Service Request Number: TOS1003-2017-00149983-Integration File Sub Component - No Charge - Discvry Cobra

Changes:
04/25/2018   B'Nai Jackson    PR-263187            Update LPFSA
01/02/2020    Katrina Prather        PR-331832        Update the client division name field to reflect company code only| 1/29/20 complimentary add of plans for TAES.

_dsi_usp_ExportRipout 'ECOBTOAMQB','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'ECOBTOAMQB' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ECOBTOAMQB'
select * from dbo.U_dsi_Parameters where FormatCode = 'ECOBTOAMQB'

select * from AscDefH where AdhFormatCode = 'ECOBTOAMQB'
select * from AscExp where expFormatCode = 'ECOBTOAMQB'
select * from ascdeff where AdfHeaderSystemID = 'ECOBTOAMQBZ0' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'ECOBTOAMQB', 'ECOBTOAMQB'
DSI_SP_TESTSWITCHBOX_V2 'ECOBTOAMQB', 'TEST'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'ECOBTOAMQB' AND CfgName = 'TESTING'

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
        @ExportFile char(200);
        
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
    WHERE SystemID = @SystemID;

-- change variables below as needed
declare @D02 char(1)--[QB]
    ,@D03 char(1)--[QBEVENT]
    ,@D05 char(1)--[QBPLANINITIAL]
    ,@D06 char(1)--[QBPLAN]
    ,@D07 char(1)--[QBDEPENDENT]
    ,@D08 char(1)--[QBDEPENDENTPLANINITIAL]
    ,@D09 char(1)--[QBDEPENDENTPLAN]
    ,@D12 char(1)--[QBSTATEINERTS]
    ,@D14 char(1)--[QBPLANMEMBERSPECIFICRATEINITIAL]
    ,@D15 char(1);--[QBPLANMEMBERSPECIFICRATE]

set @D02 = 'Y';    -- Y or N  indicates if this export uses the [QB] record
set @D03 = 'Y';    -- Y or N  indicates if this export uses the [QBEVENT] record
set @D05 = 'Y';    -- Y or N  indicates if this export uses the [QBPLANINITIAL] record
set @D06 = 'N';    -- Y or N  indicates if this export uses the [QBPLAN] record
set @D07 = 'Y';    -- Y or N  indicates if this export uses the [QBDEPENDENT] record
set @D08 = 'Y';    -- Y or N  indicates if this export uses the [QBDEPENDENTPLANINITIAL] record
set @D09 = 'N';    -- Y or N  indicates if this export uses the [QBDEPENDENTPLAN] record
set @D12 = 'N';    -- Y or N  indicates if this export uses the [QBSTATEINSERTS] record
set @D14 = 'Y';    -- Y or N  indicates if this export uses the [QBPLANMEMBERSPECIFICRATEINITIAL] record
set @D15 = 'N';    -- Y or N  indicates if this export uses the [QBPLANMEMBERSPECIFICRATE] record

/*
[VERSION]                            ECOBTOAMQB     H01    NONE
[QB]                                ECOBTOAMQB     D02    dbo.U_dsi_ECOBTOAMQB_drvTbl
[QBEVENT]                            ECOBTOAMQB     D03    dbo.U_dsi_ECOBTOAMQB_drvTbl_event
[QBPLANINITIAL]                        ECOBTOAMQB     D05    dbo.U_dsi_ECOBTOAMQB_drvTbl_PlanInit
[QBPLAN]                            ECOBTOAMQB     D06    dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
[QBDEPENDENT]                        ECOBTOAMQB     D07    dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
[QBPLANINITIAL]                        ECOBTOAMQB     D08    dbo.U_dsi_ECOBTOAMQB_drvTbl_DepPlanInit
[QBDEPENDENTPLAN]                    ECOBTOAMQB     D09    dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
[QBSTATEINSERTS]                    ECOBTOAMQB     D12    dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert
[QBPLANMEMBERSPECIFICRATEINITIAL]    ECOBTOAMQB     D14    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit
[QBPLANMEMBERSPECIFICRATE]            ECOBTOAMQB     D15    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA
*/

--BDM COBRA
DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;
--DELETE FROM dbo.u_dsi_bdm_EElist where xFormatCode = @Formatcode                

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','MED,DEN,VIS')

---INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedTypes', 'MED')--,DEN,VIS,FSA')--,OTH,HSA')---- Vinny said the cobra covered dedcodes flag below overrides this setting
--select deddedcode, dedlongdesc, deddedtype from dedcode where dediscobracovered = 'Y'
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate); --@EndDate - @daysstopped)
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');--'ActiveOnly') --'stopdate') 

--'AuditDate')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'UseCobraCoveredDeds', 'Y');
-- Y - use only dedcodes with DedIsCobraCovered = Y. This is the default for Cobra runs.
-- N - use only dedcodes with DedIsCobraCovered <> Y.
-- A - use specified dedcodes for Cobra runs regardless of value in DedIsCobraCovered
--select * from codes where codtable = 'relation'
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC,DAU,SON,CHD');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDomPartner', 'DP');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDPChild', 'DPC');

--COBRA BDM QE Inserts:
--*********************
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraType', '1');
-- 1> Pull reasons from EepCobraReason and ConCobraReason
-- 2> Pull reasons from EmpHDed and ConCobraReason
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraDate', '1');
-- 1> Pull Cobra dates from EepDateofCobraEvent and ConDateofCobraEvent
-- 2> Pull Cobra dates from benefit stop dates
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraIncludeEmps', 'Y')

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

--Fix BDM for Employee Deaths, Valid Dependents, Invalid EE's:
DECLARE @CobraPQBType              VARCHAR(1);
DECLARE @RelationshipsSpouse       VARCHAR(256);
DECLARE @RelationshipsChild        VARCHAR(256);
SELECT @CobraPQBType = CONVERT(VARCHAR(1), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraPQBType';
SELECT @RelationshipsSpouse = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsSpouse';
SELECT @RelationshipsChild = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsChild';
SET @CobraPQBType            = dbo.dsi_bdm_fn_Trim(@CobraPQBType);
SET @RelationshipsSpouse     = dbo.dsi_bdm_fn_Trim(@RelationshipsSpouse);
SET @RelationshipsChild      = dbo.dsi_bdm_fn_Trim(@RelationshipsChild);

UPDATE U_dsi_bdm_EmpDeductions
   SET EedValidForExport = 'N',
       EedDedRowStatus   = 'Benefit change reason not valid for Cobra'
  FROM U_dsi_bdm_EmpDeductions
  LEFT JOIN U_dsi_bdm_ChangeReasons WITH (NOLOCK) ON ChgFormatCode = @FormatCode AND EedCobraReason = ChgChangeReason AND ChgTarget = 'EMP'
WHERE EedFormatCode = @FormatCode
   AND EedValidForExport = 'Y'
   AND eedCobraReason in ('210','205');

-----------------------
-- Set the PQB flags
-----------------------

-- Spouses
UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = DbnRelationship
WHERE DbnFormatCode = @FormatCode
   AND DbnValidForExport = 'Y'
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = DbnEEID);

-- Children

UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions a
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsChild) ON item = a.DbnRelationship
WHERE a.DbnFormatCode = @FormatCode
   AND a.DbnValidForExport = 'Y'
   AND a.DbnIsChildOldest = CASE
                               WHEN @CobraPQBType = '1' THEN a.DbnIsChildOldest -- ALL children are PQB
                               ELSE 'Y'
                            END
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = a.DbnEEID)
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_DepDeductions b
                     JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = b.DbnRelationship
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.DbnEEID = a.DbnEEID);

--*******************END BDM FIX SECTION*********************************

--Update Benefit Option for Dependent PQB record:
--send EE as benefit option when coverage was EE + Child or EE + Spouse, and Dependent lost coverage.
UPDATE U_dsi_bdm_DepDeductions
    set dbnbenoption = 'EE'
from U_dsi_bdm_DepDeductions a
WHERE DbnFormatCode = @FormatCode
    AND DbnValidForExport = 'Y'
    AND dbnispqb = 'Y'
    and dbnbenoption in ('EEC','EEF','EES','EEDP','EEDPF')
    AND NOT EXISTS(SELECT 1 FROM U_dsi_bdm_DepDeductions b
                    WHERE b.DbnFormatCode = @FormatCode
                      AND b.DbnValidForExport = 'Y'
                      AND b.dbnispqb <> 'Y'
                      AND b.DbnEEID = a.DbnEEID);
/*
--Valid Benefit Options
select distinct corbenoption, bnoDescription
from OptRate join benopt on bnocode = CorBenOption
join DedCode on deddedcode = CorDedCode
where DedIsCobraCovered = 'Y'
*/

--Fix the PQB Record Benefit Option on deduction codes, where the PQB has dependents, and shouldn't be EE coverage offering
declare @PQBLoop1 int, @PQBLoop2 int;

set @PQBLoop1 = 0;
set @PQBLoop2 = (select count(*) from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

--select @PQBLoop1, @PQBLoop2

while @PQBLoop1 < @PQBLoop2
BEGIN

declare @dbndeprecid char(12), @dbneeid char(12);
set @dbndeprecid = (select top 1 dbndeprecid from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb = 'Y' and dbnbenoption = 'EE'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb <> 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid));

set @dbneeid = (select distinct dbneeid from dbo.u_dsi_bdm_DepDeductions where dbndeprecid = @dbndeprecid);

update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions
where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnisPQB = 'Y'
    and dbnBenOption = 'EE' and dbndepRecid = @dbndeprecid;

set @PQBLoop1 = @PQBLoop1 + 1;
END;

--Update the Non-PQB records to have correct coverage:
update dbo.u_dsi_bdm_DepDeductions
    set dbnBenOption = 'EEF'
from dbo.u_dsi_bdm_DepDeductions d join contacts on dbndeprecid = consystemid
        where dbnFormatCode = @FormatCode and dbnvalidforexport = 'Y'
        and dbnispqb <> 'Y'
        and exists (select 1 from dbo.u_dsi_bdm_DepDeductions b where b.dbnFormatCode = @FormatCode
            and b.dbnvalidforexport = 'Y' and b.dbnispqb = 'Y' and b.dbndedcode = d.dbndedcode
            and b.dbneeid = d.dbneeid
            and b.dbncoid = d.dbncoid
            and b.dbnbenoption <> d.dbnbenoption
            and dbnbenoption <> 'EE');

-----
-- Build Employee Data
-----
-- [QB]                        ECOBTOAMQB     D02    dbo.U_dsi_ECOBTOAMQB_drvTbl

if object_id('U_dsi_ECOBTOAMQB_drvTbl') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl;

SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvClientName = 'Toshiba America Inc 29924'
    ,drvClientDivisionName =  cast(cmpcompanycode  as varchar(50))  --kp 1/2/20
                        /* orig logic
                        case when cmpcompanycode  = 'TAI' then                                
                                    case when eecorglvl4  in ('3200000', '3210000', '3220000', '3221000', '3224000', '3230000', '3310000', '3320000', '3330000', '3340000', '3370000', '3400000', '3420000', '3427000', '3430000', '3450000')
                                              then 'NASSC'
                                         when eecorglvl4  in ('14001', '14002') then 'P&E' else 'TAI' end
                                        else  cast(cmpcompanycode  as varchar(50)) end
                        */
    ,drvSalutation = ''
    ,drvFirstName = rtrim(eepnamefirst)
    ,drvMiddleInitial = isnull(upper(substring(eepnamemiddle,1,1)),'')
    ,drvLastName = eepnamelast
    ,drvSSN = eepssn
    ,drvIndividualID = eecempno
    ,drvEmail = ''
    ,drvPhone = ''
    ,drvPhone2 = ''
    ,drvAddress1 = eepaddressline1
    ,drvAddress2 = eepaddressline2
    ,drvCity = eepaddresscity
    ,drvStateOrProvince = eepaddressstate
    ,drvPostalCode = eepaddresszipcode
    ,drvCountry = case when eepaddresscountry = 'usa' then '' else eepaddresscountry end
    ,drvPremiumAddressSameAsPrimary = 'Y'
    ,drvPremiumAddress1 = ''
    ,drvPremiumAddress2 = ''
    ,drvPremiumCity = ''
    ,drvPremiumStateOrProvince = ''
    ,drvPremiumPostalCode = ''
    ,drvPremiumCountry = ''
    ,drvSex = eepgender
    ,drvDOB = convert(varchar(10),eepdateofbirth,101)
    ,drvTobaccoUse = case when EepIsSmoker='y' then 'YES' when EepIsSmoker='n' then 'NO' else 'UNKNOWN' end
    ,drvEmployeeType = 'UNKNOWN'
    ,drvEmployeePayrollType = case when EecSalaryOrHourly = 'h' THEN 'NONEXEMPT' when EecSalaryOrHourly = 's' then 'EXEMPT' else 'UNKNOWN' END
    ,drvYearsOfService = ''
    ,drvPremiumCouponType = 'COUPONBOOK'
    ,drvUsesHCTC = 'NO'
    ,drvActive = 'Y'

INTO dbo.U_dsi_ECOBTOAMQB_drvTbl
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on xcoid = cmpcoid

join (select distinct eedeeid eeid, eedcoid coid
    from dbo.u_dsi_bdm_EmpDeductions
    where eedFormatCode = @FormatCode and eedValidForExport = 'Y') ee on ee.eeid = xeeid and ee.coid = xcoid
where xFormatCode = @FormatCode
    and @D02 = 'Y';

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl

--Dependent is PQB
insert INTO dbo.U_dsi_ECOBTOAMQB_drvTbl
SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvClientName = 'Toshiba America Inc 29924'
    ,drvClientDivisionName = cast(cmpcompanycode  as varchar(50))  --kp 1/2/20
                        /*
                            case when cmpcompanycode  = 'TAI' then                                
                                    case when eecorglvl4 in ('3200000', '3210000', '3220000', '3221000', '3224000', '3230000', '3310000', '3320000', '3330000', '3340000', '3370000', '3400000', '3420000', '3427000', '3430000', '3450000')
                                        then 'NASSC'
                                         when eecorglvl4  in ('14001', '14002') then 'P&E' else 'TAI' end
                                        else  cast(cmpcompanycode  as varchar(50)) end
                        */
    ,drvSalutation = ''
    ,drvFirstName = rtrim(connamefirst)
    ,drvMiddleInitial = isnull(upper(substring(connamemiddle,1,1)),'')
    ,drvLastName = connamelast
    ,drvSSN = conssn
    ,drvIndividualID = eecempno
    ,drvEmail = ''
    ,drvPhone = ''
    ,drvPhone2 = ''
    ,drvAddress1 = conaddressline1
    ,drvAddress2 = conaddressline2
    ,drvCity = conaddresscity
    ,drvStateOrProvince = conaddressstate
    ,drvPostalCode = conaddresszipcode
    ,drvCountry = case when conaddresscountry = 'usa' then '' else conaddresscountry end
    ,drvPremiumAddressSameAsPrimary = 'Y'
    ,drvPremiumAddress1 = ''
    ,drvPremiumAddress2 = ''
    ,drvPremiumCity = ''
    ,drvPremiumStateOrProvince = ''
    ,drvPremiumPostalCode = ''
    ,drvPremiumCountry = ''
    ,drvSex = congender
    ,drvDOB = convert(varchar(10),condateofbirth,101)
    ,drvTobaccoUse = case when conIsSmoker='y' then 'YES' when conIsSmoker='n' then 'NO' else 'UNKNOWN' end
    ,drvEmployeeType = 'UNKNOWN'
    ,drvEmployeePayrollType = case when EecSalaryOrHourly = 'h' THEN 'NONEXEMPT' when EecSalaryOrHourly = 's' then 'EXEMPT' else 'UNKNOWN' END
    ,drvYearsOfService = ''
    ,drvPremiumCouponType = 'COUPONBOOK'
    ,drvUsesHCTC = 'NO'
    ,drvActive = 'Y'

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = xcoid
join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid
    from dbo.u_dsi_bdm_DepDeductions
    where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y'
        and dbnispqb = 'Y') dp on dp.eeid = xeeid and dp.coid = xcoid
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D02 = 'Y'
order by 1;

-------
--employees QB record
------
-- [QBEVENT]                    ECOBTOAMQB     D03    dbo.U_dsi_ECOBTOAMQB_drvTbl_event
if object_id('U_dsi_ECOBTOAMQB_drvTbl_event') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_event;

SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvSSN = eepssn
    ,drvEventType = case
            when EecTermType = 'I' and eedCobraReason = '200' then 'INVOLUNTARYTERMINATION'
            when eedCobraReason = '204' then 'DIVORCELEGALSEPARATION'
            when eedCobraReason = '210' then 'DEATH'
            when eedCobraReason = '201' then 'INELIGIBLEDEPENDENT'
            when eedCobraReason = '205' then 'MEDICARE'
            when eedCobraReason = '200' then 'TERMINATION'
            when eedCobraReason = '208' then 'RETIREMENT'
            when eedCobraReason = '203' then 'REDUCTIONINHOURS-STATUSCHANGE'
            when eedCobraReason = '202' then 'LOSSOFELIGIBILITY'
            when eedCobraReason = '206' then 'REDUCTIONINHOURS-ENDOFLEAVE'
            end
    ,drvEventDate = convert(varchar(10),CobraDate,101)
    ,drvEnrossmentDate = convert(varchar(10),startdt,101)   --enroll of med plan
    ,drvEmployeeSSN = eepssn
    ,drvEEName = '"'+eepnamelast+','+eepnamefirst+'"'
    ,drvSecondEventOriginalFDOC = ''

INTO dbo.U_dsi_ECOBTOAMQB_drvTbl_event
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct eedeeid eeid, eedcoid coid, eedCobraReason, min(eedbenstartdate) startdt, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid, eedCobraReason) ee on ee.eeid = xeeid and ee.coid = xcoid
where xFormatCode = @FormatCode
    and @D03 = 'Y';

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_event

--Dependent is PQB
insert INTO dbo.U_dsi_ECOBTOAMQB_drvTbl_event
SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvSSN = conssn
    ,drvEventType = case
            when EecTermType = 'I' and dbnCobraReason = '200' then 'INVOLUNTARYTERMINATION'
            when dbnCobraReason = '204' then 'DIVORCELEGALSEPARATION'
            when dbnCobraReason = '210' then 'DEATH'
            when dbnCobraReason = '201' then 'INELIGIBLEDEPENDENT'
            when dbnCobraReason = '205' then 'MEDICARE'
            when dbnCobraReason = '200' then 'TERMINATION'
            when dbnCobraReason = '208' then 'RETIREMENT'
            when dbnCobraReason = '203' then 'REDUCTIONINHOURS-STATUSCHANGE'
            when dbnCobraReason = '202' then 'LOSSOFELIGIBILITY'
            when dbnCobraReason = '206' then 'REDUCTIONINHOURS-ENDOFLEAVE'
            end
    ,drvEventDate = convert(varchar(10),CobraDate,101)
    ,drvEnrossmentDate = convert(varchar(10),startdt,101)   --enroll of med plan
    ,drvEmployeeSSN = eepssn
    ,drvEEName = '"'+eepnamelast+','+eepnamefirst+'"'
    ,drvSecondEventOriginalFDOC = ''

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid, dbnCobraReason, min(dbnbenstartdate) startdt, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid, dbnCobraReason) dp on dp.eeid = xeeid and dp.coid = xcoid
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D03 = 'Y';

-----
--coverage record ee - Non Bundled Plans
-----
--[QBPLANINITAL]    ECOBTOAMQB     D05    dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit

if object_id('U_dsi_ECOBTOAMQB_drvTbl_planInit') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))

    ,drvPlanName = cast(case 
                            when eeddedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when eeddedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when eeddedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when eeddedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when eeddedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when eeddedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when eeddedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when eeddedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when eeddedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when eeddedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when eeddedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when eeddedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when eeddedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when eeddedcode  =  'AISED'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =  'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when eeddedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when eeddedcode  =    'AFDN1'                                    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'                                    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when eeddedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when eeddedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when eeddedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when eeddedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when eeddedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'

                            when eeddedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA
                            
                            else eeddedcode end as varchar(70))

    ,drvCovgLevel = case --when deddedtype = 'FSA' then 'EE'
                        when eedbenoption in ('EE') THEN 'EE'
                        when eedbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when eedbenoption in ('EES') THEN 'EE+SPOUSE'
                        when eedbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when eedbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                        when  eeddedcode in ('HCFSA','LPFSA')then 'EE' --04/25/18 Add LPFSA
                    else '' end
    ,drvNumofUnits = ''

into dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
        join company on cmpcoid = eeccoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
where xFormatCode = @FormatCode
    and @D05 = 'Y';

--Dependent is PQB
Insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_planInit
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))

    ,drvPlanName = cast(case  
                            when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when dbndedcode  =    'AFDN1'                                    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'                                    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                            else '' end as varchar(70))

    ,drvCovgLevel = case --when deddedtype = 'FSA' then 'EE'
                        when dbnbenoption in ('EE') THEN 'EE'
                        when dbnbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when dbnbenoption in ('EES') THEN 'EE+SPOUSE'
                        when dbnbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when dbnbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                    else '' end
    ,drvNumofUnits = ''

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = eeccoid
left join (select distinct dbneeid eeid, dbncoid coid,dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, dbndedcode dedcode, count(dbnDepReciD) cnt
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndedcode) dep on dep.eeid = xeeid and dep.coid = xcoid and dep.dedcode = DbnDedCode
where xFormatCode = @FormatCode
    and @D05 = 'Y';

-----
--coverage record ee
-----
--[QBPLAN]                    ECOBTOAMQB     D06    dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
if object_id('U_dsi_ECOBTOAMQB_drvTbl_plan') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_plan;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = eeddedcode
    ,drvPlanName = cast(case 
                            when eeddedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when eeddedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when eeddedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when eeddedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when eeddedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when eeddedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when eeddedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when eeddedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when eeddedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when eeddedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when eeddedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when eeddedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when eeddedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when eeddedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when eeddedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when eeddedcode  =  'AISED'    then    'Delta Dental PPO'
                            when eeddedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when eeddedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when eeddedcode  =    'AFDN1'                                    then    'Delta Dental HMO'
                            when eeddedcode  =    'AFDN2'                                    then    'Delta Dental PPO'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when eeddedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when eeddedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when eeddedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when eeddedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when eeddedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when eeddedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when eeddedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when eeddedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when eeddedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                            else '' end as varchar(70))
    ,drvStartDate = case when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                    else convert(varchar(10),CobraDate+1,101) end
    ,drvEndDate = ''
    ,drvCovLvl = case --when deddedtype = 'FSA' then 'EE'
                        when eedbenoption in ('EE') THEN 'EE'
                        when eedbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when eedbenoption in ('EES') THEN 'EE+SPOUSE'
                        when eedbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when eedbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                        when  eeddedcode in ('HCFSA','LPFSA')then 'EE' --04/25/18 Add LPFSA
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = ''

into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on eeccoid = cmpcoid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
where xFormatCode = @FormatCode
    and @D06 = 'Y';

/*
--Insert Bundled Plan - HRA
insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanName = 'Health Reimbursement Account'
    ,drvStartDate = convert(varchar(10),CobraDate+1,101)
    ,drvEndDate = ''
    ,drvCovLvl = case when eedbenoption in ('EE','EE50') THEN 'EE'
                    when eedbenoption = 'EEC' THEN 'EE+CHILDREN'
                    when eedbenoption = 'EES' THEN 'EE+SPOUSE'
                    when eedbenoption like 'EE1%' THEN 'EE+1'
                    when eedbenoption like 'EEF%' THEN 'EE+FAMILY'
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = case when eeddedcode in ('TFPOS','TPOS1','TPOS5') then cast('Tufts POS Basic bundled w/HRA' as varchar(50))
                        when eeddedcode in ('TFHMO','THMO1','THMO5') then cast('Tufts HMO Basic bundled w/HRA' as varchar(50))
                    end

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
    and deddedtype <> 'FSA' and eeddedcode in ('TFPOS','TPOS1','TPOS5','TFHMO','THMO1','THMO5')
where xFormatCode = @FormatCode
    and @D06 = 'Y'
*/
--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_plan

--Dependent is PQB
insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = dbndedcode
    ,drvPlanName = case 
                    when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                    when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                    when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                    when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                    when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                    when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                    when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                    when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                    when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                    when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                    when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                    when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                    when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                    when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                    when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                    when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                    when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                    when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                    when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                    when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                    when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                    when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                    when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                    when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                    when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                    when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                    when dbndedcode  =    'AFDN1'      then    'Delta Dental HMO'
                    when dbndedcode  =    'AFDN2'      then    'Delta Dental PPO'
                    when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                    when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                    when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                    when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                    when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                    when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                    when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                    when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                    when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                    when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                    when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                    when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                    when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                    when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                    when dbndedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA
                     else '' end
    ,drvStartDate = case when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                    else convert(varchar(10),CobraDate+1,101) end
    ,drvEndDate = ''
    ,drvCovLvl = case --when deddedtype = 'FSA' then 'EE'
                        when dbnbenoption in ('EE') THEN 'EE'
                        when dbnbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when dbnbenoption in ('EES') THEN 'EE+SPOUSE'
                        when dbnbenoption in ('EEDP') THEN 'EE+DOMESTICPARTNER'
                        when dbnbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                        when  dbndedcode in ('HCFSA','LPFSA')then 'EE' --04/25/18 Add LPFSA
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = ''

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = eeccoid
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid) dp on dp.eeid = xeeid and dp.coid = xcoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, dbndedcode dedcode, count(dbnDepReciD) cnt
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndedcode) dep on dep.eeid = xeeid and dep.coid = xcoid and dep.dedcode = DbnDedCode
where xFormatCode = @FormatCode
    and @D06 = 'Y';

/*
--Dependent Event - Insert HRA Bundled Plan
insert into dbo.U_dsi_ECOBTOAMQB_drvTbl_plan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanName = 'Health Reimbursement Account - Dep Event'
    ,drvStartDate = convert(varchar(10),CobraDate+1,101)
    ,drvEndDate = ''
    ,drvCovLvl = case when dbnbenoption in ('EE','EE50') THEN 'EE'
                    when dbnbenoption = 'EEC' THEN 'EE+CHILDREN'
                    when dbnbenoption = 'EES' THEN 'EE+SPOUSE'
                    when dbnbenoption like 'EE1%' THEN 'EE+1'
                    when dbnbenoption like 'EEF%' THEN 'EE+FAMILY'
                    else '' end
    ,drvFirstDayofCobra = ''
    ,drvLastDayofCobra = ''
    ,drvCOBRADurationMonths = ''
    ,drvDaystoElect = ''
    ,drvDaystoMake1stPmt = ''
    ,drvDaystoMakeSubsequentPmts = ''
    ,drvElectionPostmarkDate = ''
    ,drvLastDateRatesNotified = ''
    ,drvNumberofUnitys = ''
    ,drvSendPlanChangeLetterforLegacy = 'FALSE'
    ,drvPlanBndleName = case when dbndedcode in ('TFPOS','TPOS1','TPOS5') then 'Tufts POS Basic bdl w/HRA - Dep Event'
                        when dbndedcode in ('TFHMO','THMO1','THMO5') then 'Tufts HMO Basic bdl w/HRA - Dep Event'
                    end

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
        group by dbneeid, dbncoid, dbndeprecid) dp on dp.eeid = xeeid and dp.coid = xcoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb = 'Y'
    and deddedtype <> 'FSA' and dbndedcode in ('TFPOS','TPOS1','TPOS5','TFHMO','THMO1','THMO5')
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D06 = 'Y'
*/

--dependents QB record
--[QBDEPENDENT]                ECOBTOAMQB     D07    dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
if object_id('U_dsi_ECOBTOAMQB_drvTbl_dep') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_dep;

SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvssn = conssn
    ,drvrelationship = case conrelationship
                            when 'sps' then 'SPOUSE'
                            when 'CLS' then 'SPOUSE'
                            when 'chl' then 'CHILD'
                            when 'CHD' then 'CHILD'
                            when 'stc' then 'CHILD'
                            when 'dau' then 'CHILD'
                            when 'Son' then 'CHILD'
                            when 'DPC' then 'CHILD'
                            when 'DCH' then 'CHILD'
                            when 'dp' then 'DOMESTICPARTNER'
                            else '' end
--select * from codes where codtable = 'relation'
    ,drvsalutation = ''
    ,drvnamef = connamefirst
    ,drvMI = left(connamemiddle,1)
    ,drvNameL = connamelast
    ,drvemail = ''
    ,drvphone = ''
    ,drvphone2 = ''
    ,drvAddressSameasQB = case when eepaddressline1 = conaddressline1 then 'Y' else 'N' end
    ,drvAddress1 = case when eepaddressline1 <> conaddressline1 then conaddressline1 else '' end
    ,drvAddress2 = case when eepaddressline1 <> conaddressline1 then conaddressline2 else '' end
    ,drvCity = case when eepaddressline1 <> conaddressline1 then conaddresscity else '' end
    ,drvState = case when eepaddressline1 <> conaddressline1 then conaddressstate else '' end
    ,drvZip = case when eepaddressline1 <> conaddressline1 then conaddresszipcode else '' end
    ,drvCountry = ''
    ,drvEntrollmentDate = ''--convert(varchar(10),dbnbenstartdate,101)
    ,drvSex = congender
    ,drvDOB = convert(varchar(10),condateofbirth,101)
    ,drvIsQMSCO = 'FALSE'--''

INTO dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct dbneeid, dbncoid, dbndeprecid, min(dbnbenstartdate) startdt
    from dbo.u_dsi_bdm_DepDeductions
    where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
    group by dbneeid, dbncoid, dbndeprecid) dp on xeeid = dbneeid and xcoid = dbncoid
join contacts on consystemid = dbndeprecid
left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
where xFormatCode = @FormatCode
    and @D07 = 'Y';

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep order by drvsort, drvsort2

-----
--coverage record Dep - Non bundled plans
-----
--[QBDEPENDENTPLANINITIAL]            ECOBTOAMQB     D08    dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit

if object_id('U_dsi_ECOBTOAMQB_drvTbl_depplanInit') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvdedcode = dbndedcode
    ,drvDepPlanName = cast(case 
                            when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when dbndedcode  =    'AFDN1'        then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'         then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'    
                            when dbndedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA                    
                        else '' end as varchar(70))
                into dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit
                from dbo.u_dsi_bdm_EEList
                join empcomp on xeeid = eeceeid and xcoid = eeccoid
                    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
                join emppers on eepeeid = xeeid
                join company on cmpcoid = eeccoid
                join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
                    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
                left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
                        from dbo.u_dsi_bdm_DepDeductions
                        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
                        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
                join contacts on dbndeprecid = consystemid
                left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
                        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
                        where dbnFormatCode = @FormatCode
                            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
                where xFormatCode = @FormatCode
                    and @D08 = 'Y';

-----
--coverage record Dep
-----
--[QBDEPENDENTPLAN]            ECOBTOAMQB     D09    dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan

if object_id('U_dsi_ECOBTOAMQB_drvTbl_depplan') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvdedcode = dbndedcode

    ,drvDepPlanName = cast(case 
                            when dbndedcode  =    'EAPER'    then    'Anthem CA EAP'
                            when dbndedcode  =    'AFMD2'    and cmpcompanycode  = 'TAF' then    'Anthem CA Medical CDHP HRA TAF'
                            when dbndedcode  =    'AFMD3'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical CDHP HSA TAF'
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAF' then 'Anthem CA Medical EPO TAF'
                            when dbndedcode  =    'AFDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'    and cmpcompanycode  = 'TAF' then 'MetLife Vision TAF'
                            when dbndedcode  =    'AIMD2'    and cmpcompanycode  = 'TAI' then 'Anthem CA Medical CDHP HRA TAI'
                            when dbndedcode  =    'AIMD3'    and cmpcompanycode  = 'TAI' then    'Anthem CA Medical CDHP HSA TAI'
                            when dbndedcode  =    'AIMD1' and cmpcompanycode  = 'TAI'    then    'Anthem CA Medical EPO TAI'
                            when dbndedcode  =    'AIDN1'    then    'Delta Dental HMO'
                            when dbndedcode  =    'AIDN2'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AIVIS'    and cmpcompanycode  = 'TAI' then    'MetLife Vision TAI 0019'
                            when dbndedcode  =    'AISM4'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HRA TAIS'
                            when dbndedcode  =    'AISM3'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical CDHP HSA TAIS'
                            when dbndedcode  =    'AISM1'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical EPO TAIS'
                            when dbndedcode  =    'AISM2' and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =  'AISEM'    and cmpcompanycode  = 'TAIS' then    'Anthem CA Medical PPO TAIS'
                            when dbndedcode  =    'AISD1'       then    'Delta Dental HMO'
                            when dbndedcode  =    'AISD2'    then    'Delta Dental HMO'
                            when dbndedcode  =  'AISED'    then    'Delta Dental PPO'
                            when dbndedcode  =    'AISVS'   and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =   'AISEV'  and cmpcompanycode  = 'TAIS'  then    'MetLife Vision TAIS'
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HRA TARI'
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical CDHP HSA TARI'
                            when dbndedcode  =    'AFMD1'      and cmpcompanycode  = 'TARI'   then    'Anthem CA Medical EPO TARI'
                            when dbndedcode  =    'AFDN1'        then    'Delta Dental HMO'
                            when dbndedcode  =    'AFDN2'         then    'Delta Dental PPO'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TARI'     then       'MetLife Vision TARI'
                            when dbndedcode  =    'AFVIS'          and cmpcompanycode  = 'TAES'     then       'MetLife Vision TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate = 'CA' then 'Anthem CA Medical EPO TAES'  --kp 1/29/20
                            when dbndedcode  =    'AFMD1'    and cmpcompanycode  = 'TAES'  and eepaddressstate <> 'CA' then 'Anthem CA Medical EPO TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD2'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate = 'CA'  then    'Anthem CA Medical HRA TAES' --kp 1/29/20
                            when dbndedcode  =    'AFMD3'      and cmpcompanycode  = 'TAES' and eepaddressstate <> 'CA'  then    'Anthem CA Medical HRA TAES OOS' --kp 1/29/20
                            when dbndedcode  =    'LGM2'          and cmpcompanycode  = 'TLGA'     then       'Anthem CA Medical CDHP HRA TLGA'
                            when dbndedcode  =    'LGAM3'       and cmpcompanycode  = 'TLGA'     then    'Anthem CA Medical CDHP HSA TLGA'
                            when dbndedcode  =    'LGAM1'          and cmpcompanycode  = 'TLGA'  then    'Anthem CA Medical EPO TLGA'
                            when dbndedcode  =    'LGAD1'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental HMO'
                            when dbndedcode  =    'LGAD2'          and cmpcompanycode  = 'TLGA'  then    'Delta Dental PPO'
                            when dbndedcode  =    'LGAVS'          and cmpcompanycode  = 'TLGA'  then    'MetLife Vision TLGA'
                            when dbndedcode in ('HCFSA','LPFSA') then 'DBI Medical FSA'--04/25/18 BJ Add LPFSA    
                            else '' end as varchar(70))
    ,drvDepStartDate = case when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                        else convert(varchar(10),CobraDate+1,101) end
    ,drvDepEnddate = ''
    ,drvDepUsesFDOC = 'TRUE'
into dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join company on cmpcoid = eeccoid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
where xFormatCode = @FormatCode
    and @D09 = 'Y';

/*
--Dependent Plan - HRA Bundle
INSERT into dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = eepssn
    ,drvsort2 = conssn
    ,drvDepPlanName = 'Health Reimbursement Account'
    ,drvDepStartDate = convert(varchar(10),CobraDate+1,101)
    ,drvDepEnddate = ''
    ,drvDepUsesFDOC = 'TRUE'

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join dbo.u_dsi_bdm_DepDeductions on xeeid = dbneeid and xcoid = dbncoid
    and dbnFormatCode = xFormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
    and deddedtype <> 'FSA' and dbndedcode in ('TFPOS','TPOS1','TPOS5','TFHMO','THMO1','THMO5')
left join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid depid, max(dbnDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndeprecid) ee on ee.eeid = xeeid and ee.coid = xcoid
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, conssn ssn
        from dbo.U_dsi_bdm_DepDeductions join contacts on consystemid = dbndeprecid
        where dbnFormatCode = @FormatCode
            and dbnvalidforexport = 'Y' and dbnispqb = 'Y') pqb on pqb.eeid = dbneeid and pqb.coid = dbncoid
where xFormatCode = @FormatCode
    and @D09 = 'Y'
*/

-- [QBSTATEINSERTS]                    ECOBTOAMQB     D12    dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInserts

if object_id('U_dsi_ECOBTOAMQB_drvTbl_stateInsert') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvStateSpecificDocumentName = ''

into dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct eedeeid eeid, eedcoid coid
    from dbo.u_dsi_bdm_EmpDeductions
    where eedFormatCode = @FormatCode and eedValidForExport = 'Y') ee on ee.eeid = xeeid and ee.coid = xcoid
where xFormatCode = @FormatCode
    and @D12 = 'Y';

--Dependent is PQB
INSERT into dbo.U_dsi_ECOBTOAMQB_drvTbl_stateInsert
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = eepssn
    ,drvsort2 = conssn
    ,drvStateSpecificDocumentName = ''

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct dbneeid eeid, dbncoid coid, dbndeprecid
    from dbo.u_dsi_bdm_DepDeductions
    where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y'
        and dbnispqb = 'Y') dp on dp.eeid = xeeid and dp.coid = xcoid
join contacts on dbndeprecid = consystemid
where xFormatCode = @FormatCode
    and @D12 = 'Y';

-----
--coverage record ee - FSA
-----
--[QBPLANMEMBERSPECIFICRATEINITIAL]    ECOBTOAMQB     D14    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit

if object_id('U_dsi_ECOBTOAMQB_drvTbl_planFSAInit') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanNameFSA =    case eeddedcode
                            when  'LPFSA' then 'DBI Medical FSA'--'Limited purpose FSA'--04/25/18 BJ
                            when  'HCFSA' then 'DBI Medical FSA' end
    ,drvRate = convert(char(8),convert(numeric(12,2),eedeegoalamt/12))

into dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSAInit
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
    and deddedtype = 'FSA'
where xFormatCode = @FormatCode
    and @D14 = 'Y'; --NO FSA!
    

-----
--coverage record ee - FSA
-----
--[QBPLANMEMBERSPECIFICRATE]    ECOBTOAMQB     D15    dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA

if object_id('U_dsi_ECOBTOAMQB_drvTbl_planFSA') is not null
    drop table dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanNameFSA = case eeddedcode 
                            when  'LPFSA' then 'DBI Medical FSA'--'Limited purpose FSA'--04/25/18 BJ
                            when   'HCFSA' then 'DBI Medical FSA' end
    ,drvStartDateFSA = convert(varchar(10),CobraDate+1,101)
    ,drvEndDateFSA = convert(varchar(10),dateadd(ms,-3,DATEADD(yy, DATEDIFF(yy,0,@EndDate )+1, 0)) ,101)
    ,drvRate = convert(char(8),convert(numeric(12,2),eedeegoalamt/12))

into dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
left join (select distinct eedeeid eeid, eedcoid coid, max(eedDateofCobraEvent) CobraDate
        from dbo.u_dsi_bdm_EmpDeductions
        where eedFormatCode = @FormatCode and eedValidForExport = 'Y'
        group by eedeeid, eedcoid) ee on ee.eeid = xeeid and ee.coid = xcoid
join dbo.u_dsi_bdm_EmpDeductions on xeeid = eedeeid and xcoid = eedcoid
    and eedFormatCode = xFormatCode and eedValidForExport = 'Y'
    and deddedtype = 'FSA'
where xFormatCode = @FormatCode
    and @D15 = 'Y'; --NO FSA

--select * from dbo.U_dsi_ECOBTOAMQB_drvTbl_planFSA

--Discovery/COBRApoint files:
/*
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
*/

--Dependents not linked to PQB
declare @Loop1 int, @Loop2 int;

set @Loop1 = 0;
set @Loop2 = (select count(*) from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
    where drvsort not in (select drvsort from dbo.U_dsi_ECOBTOAMQB_drvTbl));

WHILE @Loop1 < @Loop2
BEGIN
declare @DepID char(12), @DepEEID char(12), @PQBssn char(9);
set @DepID = (select top 1 drvdepid from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
    where drvsort not in (select drvsort from dbo.U_dsi_ECOBTOAMQB_drvTbl));

set @DepEEID = (select distinct drveeid from dbo.U_dsi_ECOBTOAMQB_drvTbl_dep where drvdepid = @DepID);
set @PQBssn = (select distinct drvsort from dbo.U_dsi_ECOBTOAMQB_drvTbl where drveeid = @DepEEID);

update dbo.U_dsi_ECOBTOAMQB_drvTbl_dep
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

update dbo.U_dsi_ECOBTOAMQB_drvTbl_depplanInit
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

update dbo.U_dsi_ECOBTOAMQB_drvTbl_depplan
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

set @Loop1 = @Loop1 + 1;

END;

-- Set FileName
if (dbo.dsi_fnVariable('ECOBTOAMQB','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile = 'TOAM_COBRA_QB_' + replace(convert(char(10), GetDate(), 1), '/',SPACE(0)) + '.csv'
    where FormatCode = 'ECOBTOAMQB';

/*
--Alter the View
ALTER  View dbo.dsi_vwECOBTOAMQB_Export as
        select top 2000000
        left(data,(len(data))) as data
        from dbo.U_ECOBTOAMQB_File with (nolock)
         order by case when substring(RecordSet,1,1) = 'H' then 1 else 2 end,InitialSort, Subsort, substring(RecordSet,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'ECOBTOAMQB'
*/

--dbo.dsi_sp_testSwitchbox_v2 'ECOBTOAMQB','ECOBTOAMQB'
--dbo.dsi_sp_testSwitchbox_v2 'ECOBTOAMQB','TEST'        --non UDES file
GO
CREATE  View dbo.dsi_vwECOBTOAMQB_Export as
        select top 2000000
        left(data,(len(data))) as data
        from dbo.U_ECOBTOAMQB_File with (nolock)
         order by case when substring(RecordSet,1,1) = 'H' then 1 else 2 end,InitialSort, Subsort, substring(RecordSet,2,2)