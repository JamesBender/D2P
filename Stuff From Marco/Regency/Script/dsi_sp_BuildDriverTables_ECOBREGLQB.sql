SET NOCOUNT ON;
IF OBJECT_ID('U_ECOBREGLQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBREGLQB_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECOBREGLQB_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECOBREGLQB' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECOBREGLQB_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECOBREGLQB_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECOBREGLQB') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECOBREGLQB];
GO
IF OBJECT_ID('U_ECOBREGLQB_File') IS NOT NULL DROP TABLE [dbo].[U_ECOBREGLQB_File];
GO
IF OBJECT_ID('U_ECOBREGLQB_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECOBREGLQB_EEList];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_stateInsert') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_stateInsert];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_planInit') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_planInit];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_planFSAInit') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_planFSAInit];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_planFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_planFSA];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_plan') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_plan];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_event') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_event];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_depplanInit') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_depplanInit];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_depplan') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_depplan];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_dep') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_dep];
GO
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECOBREGLQB';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECOBREGLQB';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECOBREGLQB';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECOBREGLQB';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECOBREGLQB';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','ECOBREGLQB','Discovery COBRA QB file','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECOBREGLQBZ0','N','Jan 21 2017  3:26PM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[VERSION]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','20','H','01','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1.0"','2','(''DA''=''T'')','ECOBREGLQBZ0','20','H','01','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QB]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','5','D','02','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','2','(''UA''=''Q,'')','ECOBREGLQBZ0','100','D','02','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientDivisionName"','3','(''UA''=''Q,'')','ECOBREGLQBZ0','100','D','02','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalutation"','4','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','4',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','5','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','5',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','6','(''UA''=''T,'')','ECOBREGLQBZ0','1','D','02','6',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','7','(''UA''=''Q,'')','ECOBREGLQBZ0','50','D','02','7',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','8','(''UA''=''T,'')','ECOBREGLQBZ0','11','D','02','8',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIndividualID"','9','(''UA''=''T,'')','ECOBREGLQBZ0','20','D','02','9',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','10','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','10',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone"','11','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','02','11',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhone2"','12','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','02','12',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','13','(''UA''=''Q,'')','ECOBREGLQBZ0','50','D','02','13',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','14','(''UA''=''Q,'')','ECOBREGLQBZ0','50','D','02','14',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','15','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','15',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateOrProvince"','16','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','16',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostalCode"','17','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','17',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','18','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','18',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddressSameAsPrimary"','19','(''UA''=''T,'')','ECOBREGLQBZ0','1','D','02','19',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress1"','20','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','20',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumAddress2"','21','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','21',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCity"','22','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','22',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumStateOrProvince"','23','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','23',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumPostalCode"','24','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','24',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCountry"','25','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','02','25',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','26','(''UA''=''T,'')','ECOBREGLQBZ0','1','D','02','26',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','27','(''UA''=''T,'')','ECOBREGLQBZ0','12','D','02','27',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTobaccoUse"','28','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','28',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeType"','29','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','29',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeePayrollType"','30','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','30',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYearsOfService"','31','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','02','31',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPremiumCouponType"','32','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','02','32',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUsesHCTC"','33','(''UA''=''T,'')','ECOBREGLQBZ0','1','D','02','33',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActive"','34','(''UA''=''T'')','ECOBREGLQBZ0','1','D','02','34',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBEVENT]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','15','D','03','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventType"','2','(''UA''=''T,'')','ECOBREGLQBZ0','32','D','03','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventDate"','3','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','03','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrossmentDate"','4','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','03','4',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','5','(''UA''=''T,'')','ECOBREGLQBZ0','9','D','03','5',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEName"','6','(''UA''=''T,'')','ECOBREGLQBZ0','100','D','03','6',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSecondEventOriginalFDOC"','7','(''UA''=''T'')','ECOBREGLQBZ0','10','D','03','7',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANINITIAL]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','15','D','05','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','05','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovgLevel"','3','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','05','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumofUnits"','4','(''UA''=''T'')','ECOBREGLQBZ0','15','D','05','4',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLAN]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','15','D','06','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','2','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','06','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDate"','3','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDate"','4','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','4',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCovLvl"','5','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','06','5',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstDayofCobra"','6','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','6',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDayofCobra"','7','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','7',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOBRADurationMonths"','8','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','8',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaystoElect"','9','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','9',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaystoMake1stPmt"','10','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','10',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaystoMakeSubsequentPmts"','11','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','11',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectionPostmarkDate"','12','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','12',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastDateRatesNotified"','13','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','13',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofUnitys"','14','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','06','14',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSendPlanChangeLetterforLegacy"','15','(''UA''=''T,'')','ECOBREGLQBZ0','1','D','06','15',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanBndleName"','16','(''UA''=''T'')','ECOBREGLQBZ0','50','D','06','16',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENT]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','15','D','07','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvssn"','2','(''UA''=''T,'')','ECOBREGLQBZ0','9','D','07','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvrelationship"','3','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','07','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvsalutation"','4','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','07','4',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvnamef"','5','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','07','5',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMI"','6','(''UA''=''T,'')','ECOBREGLQBZ0','1','D','07','6',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameL"','7','(''UA''=''Q,'')','ECOBREGLQBZ0','50','D','07','7',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvemail"','8','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','07','8',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvphone"','9','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','07','9',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvphone2"','10','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','07','10',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressSameasQB"','11','(''UA''=''T,'')','ECOBREGLQBZ0','1','D','07','11',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','12','(''UA''=''Q,'')','ECOBREGLQBZ0','50','D','07','12',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','13','(''UA''=''Q,'')','ECOBREGLQBZ0','50','D','07','13',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','14','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','07','14',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','15','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','07','15',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','16','(''UA''=''T,'')','ECOBREGLQBZ0','35','D','07','16',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','17','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','07','17',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEntrollmentDate"','18','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','07','18',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSex"','19','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','07','19',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','20','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','07','20',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvIsQMSCO"','21','(''UA''=''T'')','ECOBREGLQBZ0','1','D','07','21',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLANINITIAL]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','24','D','08','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPlanName"','2','(''UA''=''T'')','ECOBREGLQBZ0','50','D','08','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBDEPENDENTPLAN]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','50','D','09','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepPlanName"','2','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','09','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepStartDate"','3','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','09','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepEnddate"','4','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','09','4',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepUsesFDOC"','5','(''UA''=''T'')','ECOBREGLQBZ0','5','D','09','5',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBSTATEINSERTS]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','16','D','12','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStateSpecificDocumentName"','2','(''UA''=''T'')','ECOBREGLQBZ0','35','D','12','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATEINITIAL]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','33','D','14','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameFSA"','2','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','14','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','3','(''UA''=''T'')','ECOBREGLQBZ0','10','D','14','3',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"[QBPLANMEMBERSPECIFICRATE]"','1','(''DA''=''T,'')','ECOBREGLQBZ0','50','D','15','1',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanNameFSA"','2','(''UA''=''T,'')','ECOBREGLQBZ0','50','D','15','2',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStartDateFSA"','3','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','15','3',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEndDateFSA"','4','(''UA''=''T,'')','ECOBREGLQBZ0','10','D','15','4',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRate"','5','(''UA''=''T'')','ECOBREGLQBZ0','10','D','15','5',NULL,'',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECOBREGLQB_20200225.txt',NULL,'Null','N','STH8G,QG52B',NULL,NULL,NULL,'Discovery Cobra QB Wkly File','201710039','EMPEXPORT','ECOBREGLQB','Sep 26 2017  5:37PM','ECOBREGLQB',NULL,NULL,NULL,'202002259','Oct  3 2017 12:00AM','Dec 30 1899 12:00AM','202002111','8','','','201709121',dbo.fn_GetTimedKey(),NULL,'ULTI_WPREGLT',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ECOBREGLQB_20200225.txt',NULL,'','',',STH8G,QG52B',NULL,NULL,NULL,'Discovery Cobra QB Test File','201808191','EMPEXPORT','TEST','Aug 19 2018  7:12PM','ECOBREGLQB',NULL,NULL,NULL,'201808191','Aug 19 2018 12:00AM','Dec 30 1899 12:00AM','201807291','84','','','201807291',dbo.fn_GetTimedKey(),NULL,'ULTI_WPREGLT',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ECOBREGLQB_20200225.txt' END WHERE expFormatCode = 'ECOBREGLQB';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','ExportDescription','C','Discovery COBRA QB file');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','FileType','C','csv');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','MaxFileLength','C','1148');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','SystemID','V','BIFPJL0010K0');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECOBREGLQB','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ECOBREGLQB' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECOBREGLQB' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ECOBREGLQB_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECOBREGLQB_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D02','dbo.U_dsi_ECOBREGLQB_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D03','dbo.U_dsi_ECOBREGLQB_drvTbl_event',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D05','dbo.U_dsi_ECOBREGLQB_drvTbl_PlanInit',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D06','dbo.U_dsi_ECOBREGLQB_drvTbl_plan',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D07','dbo.U_dsi_ECOBREGLQB_drvTbl_dep',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D08','dbo.U_dsi_ECOBREGLQB_drvTbl_depplanInit',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D09','dbo.U_dsi_ECOBREGLQB_drvTbl_depplan',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D12','dbo.U_dsi_ECOBREGLQB_drvTbl_stateInsert',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D14','dbo.U_dsi_ECOBREGLQB_drvTbl_planFSAInit',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECOBREGLQB','D15','dbo.U_dsi_ECOBREGLQB_drvTbl_planFSA',NULL);
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvClientName] varchar(26) NULL,
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
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_dep') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_dep] (
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
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_depplan') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_depplan] (
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
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_depplanInit') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_depplanInit] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] char(12) NOT NULL,
    [drvsort] char(11) NULL,
    [drvsort2] char(11) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvDepPlanName] varchar(70) NULL
);
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_event') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_event] (
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
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_plan') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_plan] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvPlanName] varchar(70) NULL,
    [drvStartDate] varchar(10) NULL,
    [drvEndDate] varchar(1) NOT NULL,
    [drvCovLvl] varchar(11) NOT NULL,
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
    [drvPlanBndleName] varchar(50) NULL
);
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_planFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_planFSA] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvPlanNameFSA] varchar(30) NOT NULL,
    [drvStartDateFSA] varchar(10) NULL,
    [drvEndDateFSA] varchar(10) NULL,
    [drvRate] char(8) NULL
);
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_planFSAInit') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_planFSAInit] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvPlanNameFSA] varchar(30) NOT NULL,
    [drvRate] char(8) NULL
);
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_planInit') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_planInit] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvPlanName] varchar(70) NULL,
    [drvCovgLevel] varchar(11) NOT NULL,
    [drvNumofUnits] varchar(1) NOT NULL
);
IF OBJECT_ID('U_dsi_ECOBREGLQB_drvTbl_stateInsert') IS NULL
CREATE TABLE [dbo].[U_dsi_ECOBREGLQB_drvTbl_stateInsert] (
    [drveeid] char(12) NOT NULL,
    [drvcoid] char(5) NOT NULL,
    [drvdepid] varchar(30) NULL,
    [drvsort] char(11) NULL,
    [drvsort2] varchar(9) NULL,
    [drvStateSpecificDocumentName] varchar(1) NOT NULL
);
IF OBJECT_ID('U_ECOBREGLQB_EEList') IS NULL
CREATE TABLE [dbo].[U_ECOBREGLQB_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECOBREGLQB_File') IS NULL
CREATE TABLE [dbo].[U_ECOBREGLQB_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE procedure [dbo].[dsi_sp_BuildDriverTables_ECOBREGLQB]
@systemid char(12)
as

/**********************************************************************
Client Name: Regency Lighting
Vendor: Discovery COBRA QB file
Created By: Joseph Pham
Business Analyst: Brandy Neitzschman
Create Date: 1/23/2017
Service Request Number: SF REG1002-2017-00149816-Integration File Sub Component

Changes:
MM/DD/YYYY    NAME HERE     SF 09999999              Comments Here

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECOBREGLQB', @AllObjects = 'Y', @IsWeb = 'Y'

select * from dbo.U_dsi_Configuration where FormatCode = 'ECOBREGLQB' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'ECOBREGLQB'
select * from dbo.U_dsi_Parameters where FormatCode = 'ECOBREGLQB'

select * from AscDefH where AdhFormatCode = 'ECOBREGLQB'
select * from AscExp where expFormatCode = 'ECOBREGLQB'
select * from ascdeff join ascdefh on adhsystemid = AdfHeaderSystemID where adhFormatCode = 'ECOBREGLQB' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'ECOBREGLQB', 'ECOBREGLQB'
DSI_SP_TESTSWITCHBOX_V2 'ECOBREGLQB', 'TEST'

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
set @D05 = 'N';    -- Y or N  indicates if this export uses the [QBPLANINITIAL] record
set @D06 = 'Y';    -- Y or N  indicates if this export uses the [QBPLAN] record
set @D07 = 'Y';    -- Y or N  indicates if this export uses the [QBDEPENDENT] record
set @D08 = @D05;    -- Y or N  indicates if this export uses the [QBDEPENDENTPLANINITIAL] record
set @D09 = @D06;    -- Y or N  indicates if this export uses the [QBDEPENDENTPLAN] record
set @D12 = 'N';    -- Y or N  indicates if this export uses the [QBSTATEINSERTS] record
set @D14 = @D05;    -- Y or N  indicates if this export uses the [QBPLANMEMBERSPECIFICRATEINITIAL] record
set @D15 = @D06;    -- Y or N  indicates if this export uses the [QBPLANMEMBERSPECIFICRATE] record

/*
[VERSION]                            ECOBREGLQB     H01    NONE
[QB]                                ECOBREGLQB     D02    dbo.U_dsi_ECOBREGLQB_drvTbl
[QBEVENT]                            ECOBREGLQB     D03    dbo.U_dsi_ECOBREGLQB_drvTbl_event
[QBPLANINITIAL]                        ECOBREGLQB     D05    dbo.U_dsi_ECOBREGLQB_drvTbl_PlanInit
[QBPLAN]                            ECOBREGLQB     D06    dbo.U_dsi_ECOBREGLQB_drvTbl_plan
[QBDEPENDENT]                        ECOBREGLQB     D07    dbo.U_dsi_ECOBREGLQB_drvTbl_dep
[QBPLANINITIAL]                        ECOBREGLQB     D08    dbo.U_dsi_ECOBREGLQB_drvTbl_DepPlanInit
[QBDEPENDENTPLAN]                    ECOBREGLQB     D09    dbo.U_dsi_ECOBREGLQB_drvTbl_depplan
[QBSTATEINSERTS]                    ECOBREGLQB     D12    dbo.U_dsi_ECOBREGLQB_drvTbl_stateInsert
[QBPLANMEMBERSPECIFICRATEINITIAL]    ECOBREGLQB     D14    dbo.U_dsi_ECOBREGLQB_drvTbl_planFSAInit
[QBPLANMEMBERSPECIFICRATE]            ECOBREGLQB     D15    dbo.U_dsi_ECOBREGLQB_drvTbl_planFSA
*/

--BDM COBRA
DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;
--DELETE FROM dbo.u_dsi_bdm_EElist where xFormatCode = @Formatcode                --1/23/13 drn

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','MED,DEN')
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedTypes', 'MED,DEN,VIS,FSA,OTH,HSA')
--select deddedcode, dedlongdesc, deddedtype from dedcode where dediscobracovered = 'Y'
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate); --@EndDate - @daysstopped)
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');--'ActiveOnly') --'stopdate') 

--'AuditDate')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'UseCobraCoveredDeds', 'Y');
-- Y - use only dedcodes with DedIsCobraCovered = Y. This is the default for Cobra runs.
-- N - use only dedcodes with DedIsCobraCovered <> Y.
-- A - use specified dedcodes for Cobra runs regardless of value in DedIsCobraCovered
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'ExcludeDedCodes', 'FSADC') 
--select * from codes where codtable = 'relation'
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsSpouse', 'SPS');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsChild', 'CHL,STC,DAU,SON,DDP');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDomPartner', 'DP');
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'RelationshipsDPChild', 'DPC');

--COBRA BDM QE Inserts:
--*********************
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraType', '3');
-- 1> Pull reasons from EepCobraReason and ConCobraReason
-- 2> Pull reasons from EmpHDed and ConCobraReason
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraDate', '2');
-- 1> Pull Cobra dates from EepDateofCobraEvent and ConDateofCobraEvent
-- 2> Pull Cobra dates from benefit stop dates
--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraIncludeEmps', 'Y')

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;


--Bundled EAP for COBRA: --Commented out 6/5/2018
--INSERT INTO dbo.U_dsi_bdm_EmpDeductions (eedformatcode, eedcoid, eedeeid, eedbenoption, eedCobraReason, eedDateofCobraEvent, eedbenstartdate, eedbenstopdate, eeddedcode, eedvalidforexport, deddedcode, deddedtype)
--      (select eedformatcode, eedcoid, eedeeid, max(eedbenoption), max(eedCobraReason), max(eedDateofCobraEvent), min(eedbenstartdate), max(eedbenstopdate), REPLACE(eeddedcode,'MED','EAP'), 'Y', REPLACE(eeddedcode,'MED','EAP'), 'EAP'
--FROM dbo.U_dsi_bdm_EmpDeductions
--WHERE eedformatcode = @FormatCode and eedValidForExport = 'Y' and deddedtype = 'MED'
--group by eedFormatCode, eedCoid, eedEEID, eeddedcode)

--INSERT INTO dbo.U_dsi_bdm_DepDeductions (dbnformatcode, dbncoid, dbneeid, dbndeprecid, dbnisPQB, dbnbenoption, dbnCobraReason, dbnDateofCobraEvent, dbnbenstartdate, dbnbenstopdate, dbndedcode, dbnvalidforexport, deddedcode, deddedtype)
--      (select dbnformatcode, dbncoid, dbneeid, dbnDepRecID, dbnisPQB, max(dbnbenoption), max(dbnCobraReason), max(dbnDateofCobraEvent), min(dbnbenstartdate), max(dbnbenstopdate), REPLACE(dbndedcode,'MED','EAP'), 'Y', REPLACE(dbndedcode,'MED','EAP'), 'EAP'
--FROM dbo.U_dsi_bdm_DepDeductions
--WHERE dbnformatcode = @FormatCode and dbnvalidforexport = 'Y' and deddedtype = 'MED'
--group by dbnFormatCode, dbnCoid, dbnEEID, dbnDepRecID, dbnisPQB, dbndedcode)


--Fix BDM for Employee Deaths, Valid Dependents, Invalid EE's:
DECLARE @CobraPQBType              VARCHAR(1);
DECLARE @RelationshipsSpouse       VARCHAR(256);
DECLARE @RelationshipsDomPartner    VARCHAR(256);
DECLARE @RelationshipsChild        VARCHAR(256);
DECLARE @RelationshipsDPChild        VARCHAR(256);
SELECT @CobraPQBType = CONVERT(VARCHAR(1), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'CobraPQBType';
SELECT @RelationshipsSpouse = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsSpouse';
SELECT @RelationshipsDomPartner = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsDomPartner';
SELECT @RelationshipsChild = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsChild';
SELECT @RelationshipsDPChild = CONVERT(VARCHAR(256), ParmValue) FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode AND ParmName = 'RelationshipsDPChild';
SET @CobraPQBType            = dbo.dsi_bdm_fn_Trim(@CobraPQBType);
SET @RelationshipsSpouse     = dbo.dsi_bdm_fn_Trim(@RelationshipsSpouse);
SET @RelationshipsDomPartner = dbo.dsi_bdm_fn_Trim(@RelationshipsDomPartner);
SET @RelationshipsChild      = dbo.dsi_bdm_fn_Trim(@RelationshipsChild);
SET @RelationshipsDPChild     = dbo.dsi_bdm_fn_Trim(@RelationshipsDPChild);

--select * from dbo.dsi_bdm_fn_ListToTable(@RelationshipsChild)

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
--select *
FROM U_dsi_bdm_DepDeductions
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsSpouse) ON item = DbnRelationship
WHERE DbnFormatCode = @FormatCode
   AND DbnValidForExport = 'Y'
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = DbnEEID);

--Domestic Partners
UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'      
--select * 
FROM U_dsi_bdm_DepDeductions
  JOIN dbo.dsi_bdm_fn_ListToTable(@RelationshipsDomPartner) ON item = DbnRelationship
WHERE DbnFormatCode = @FormatCode
   AND DbnValidForExport = 'Y'
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_EmpDeductions
                    WHERE EedFormatCode = @FormatCode
                      AND EedValidForExport = 'Y'
                      AND EedEEID = DbnEEID)
   AND NOT EXISTS (SELECT 1 FROM U_dsi_bdm_DepDeductions q
                    WHERE dbnFormatCode = @FormatCode
                      AND dbnValidForExport = 'Y' and dbnisPQB = 'Y'
                      AND q.dbnEEID = DbnEEID and q.dbndeprecid <> dbndeprecid);

-- Children & Domestic Partner Children
UPDATE U_dsi_bdm_DepDeductions
   SET DbnIsPQB = 'Y'
  FROM U_dsi_bdm_DepDeductions a
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
                      AND b.DbnEEID = a.DbnEEID)
   AND EXISTS (select 1 FROM U_dsi_bdm_DepDeductions d
                    WHERE d.DbnFormatCode = @FormatCode
                      AND d.DbnValidForExport = 'Y'
                      AND d.DbnEEID = a.DbnEEID
                      and (dbnRelationship in (select * from dbo.dsi_bdm_fn_ListToTable(@RelationshipsChild))
                            or dbnRelationship in (select * from dbo.dsi_bdm_fn_ListToTable(@RelationshipsDPChild))));

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
-- [QB]                        ECOBREGLQB     D02    dbo.U_dsi_ECOBREGLQB_drvTbl

if object_id('U_dsi_ECOBREGLQB_drvTbl') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl;

SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvClientName = CASE WHEN EecCoID = 'QG52B' THEN 'Regency Lighting 25307'
                            WHEN EecCoID = 'STH8G' THEN 'Allsale Electric Inc 27623'
                        END
    ,drvClientDivisionName = CASE WHEN EecCoID = 'QG52B' THEN cast('Regency Lighting' as varchar(50))
                                    WHEN EecCoID = 'STH8G' THEN cast('Allsale Electric Inc' as varchar(50))
                                END
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

INTO dbo.U_dsi_ECOBREGLQB_drvTbl
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
join (select distinct eedeeid eeid, eedcoid coid
    from dbo.u_dsi_bdm_EmpDeductions
    where eedFormatCode = @FormatCode and eedValidForExport = 'Y') ee on ee.eeid = xeeid and ee.coid = xcoid
where xFormatCode = @FormatCode
    and @D02 = 'Y';

--select * from dbo.U_dsi_ECOBREGLQB_drvTbl

--Dependent is PQB
insert INTO dbo.U_dsi_ECOBREGLQB_drvTbl
SELECT    distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvClientName = CASE WHEN EecCoID = 'QG52B' THEN 'Regency Lighting 25307'
                            WHEN EecCoID = 'STH8G' THEN 'Allsale Electric Inc 27623'
                        END
    ,drvClientDivisionName = CASE WHEN EecCoID = 'QG52B' THEN cast('Regency Lighting' as varchar(50))
                                    WHEN EecCoID = 'STH8G' THEN cast('Allsale Electric Inc' as varchar(50))
                                END
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
-- [QBEVENT]                    ECOBREGLQB     D03    dbo.U_dsi_ECOBREGLQB_drvTbl_event
if object_id('U_dsi_ECOBREGLQB_drvTbl_event') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_event;

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

INTO dbo.U_dsi_ECOBREGLQB_drvTbl_event
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

--select * from dbo.U_dsi_ECOBREGLQB_drvTbl_event

--Dependent is PQB
insert INTO dbo.U_dsi_ECOBREGLQB_drvTbl_event
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
--[QBPLANINITAL]    ECOBREGLQB     D05    dbo.U_dsi_ECOBREGLQB_drvTbl_planInit

if object_id('U_dsi_ECOBREGLQB_drvTbl_planInit') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_planInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = deddedcode
    ,drvPlanName = cast(case when deddedcode IN ('DEN','DEN1','DEN2','DEN3','DEN4') then 'CIGNA Dental DHMO'
                            when deddedcode IN ('DEN5','DEN6','DEN7','DEN8','DEN9') then 'CIGNA Dental PPO'
                            when deddedtype = 'FSA' then 'Discovery Benefits Medical FSA'
                            when deddedcode IN ('VIS','VIS1','VIS2') then 'EyeMed Vision'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') then 'Fortress Medical EPO with H S A option Plan'
                            when deddedcode like 'EAP%' THEN 'Symetra EAP'
                        else '' end as varchar(70))
    ,drvCovgLevel = case when deddedtype = 'FSA' then 'EE'
                        when eedbenoption in ('EE') THEN 'EE'
                        when eedbenoption in ('EE1') THEN 'EE+1'
                        when eedbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when eedbenoption in ('EES','EEDP') THEN 'EE+SPOUSE'
                        when eedbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                    else '' end
    ,drvNumofUnits = ''

into dbo.U_dsi_ECOBREGLQB_drvTbl_planInit
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
where xFormatCode = @FormatCode --and deddedtype in ('DEN','VIS','FSA')
    and @D05 = 'Y';

--Dependent is PQB
Insert into dbo.U_dsi_ECOBREGLQB_drvTbl_planInit
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = deddedcode
    ,drvPlanName = cast(case when deddedcode IN ('DEN','DEN1','DEN2','DEN3','DEN4') then 'CIGNA Dental DHMO'
                            when deddedcode IN ('DEN5','DEN6','DEN7','DEN8','DEN9') then 'CIGNA Dental PPO'
                            when deddedtype = 'FSA' then 'Discovery Benefits Medical FSA'
                            when deddedcode IN ('VIS','VIS1','VIS2') then 'EyeMed Vision'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') then 'Fortress Medical EPO with H S A option Plan'
                            when deddedcode like 'EAP%' THEN 'Symetra EAP'
                        else '' end as varchar(70))
    ,drvCovgLevel = case when deddedtype = 'FSA' then 'EE'
                        when dbnbenoption in ('EE') THEN 'EE'
                        when dbnbenoption in ('EE1') THEN 'EE+1'
                        when dbnbenoption in ('EEC') THEN 'EE+CHILDREN'
                        when dbnbenoption in ('EES','EEDP') THEN 'EE+SPOUSE'
                        when dbnbenoption in ('EEF','EEDPF') THEN 'EE+FAMILY'
                        when ConRelationship in ('SPS','DP') and dep.cnt > 1 then 'SPOUSE+CHILDREN'
                        when ConRelationship in ('SPS','DP') and dep.cnt = 1 then 'SPOUSE+CHILD'
                        when ConRelationship in ('SPS','DP') and dep.cnt < 1 then 'SPOUSEONLY'
                        when ConRelationship in ('CHL','STC','DPC','SON','DAU') and dep.cnt >= 1 then 'CHILDRENONLY'
                        when ConRelationship in ('CHL','STC','DPC','SON','DAU') and dep.cnt < 1 then 'CHILDONLY'
                    else '' end
    ,drvNumofUnits = ''

from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
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
where xFormatCode = @FormatCode --and deddedtype in ('DEN','VIS','FSA')
    and @D05 = 'Y';

-----
--coverage record ee
-----
--[QBPLAN]                    ECOBREGLQB     D06    dbo.U_dsi_ECOBREGLQB_drvTbl_plan
if object_id('U_dsi_ECOBREGLQB_drvTbl_plan') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_plan;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = eeddedcode
    ,drvPlanName = cast(case when deddedcode IN ('DEN','DEN1','DEN2','DEN3','DEN4') then 'CIGNA Dental DHMO'
                            when deddedcode IN ('DEN5','DEN6','DEN7','DEN8','DEN9') then 'CIGNA Dental PPO'
                            when deddedtype = 'FSA' then 'Discovery Benefits Medical FSA'
                            when deddedcode IN ('VIS','VIS1','VIS2') then 'EyeMed Vision'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') and eeccoid = 'QG52B' then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') and eeccoid = 'QG52B' then 'Fortress Medical EPO with H S A option Plan'
                            when deddedcode IN ('EAP7','EAP8','EAP9','EAP10','EAP11') and eeccoid = 'QG52B' THEN 'Symetra EAP EPO'
                            when deddedcode IN ('EAP','EAP1','EAP2','EAP3','EAP4','EAP5','EAP6') and eeccoid = 'QG52B' THEN 'Symetra EAP PPO'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') and eeccoid = 'STH8G' then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') and eeccoid = 'STH8G' then 'Fortress Medical EPO Plan'
                            when deddedcode like 'EAP%' and eeccoid = 'STH8G' THEN 'Symetra EAP'
                        else '' end as varchar(70))
    ,drvStartDate = case when deddedtype = 'FSA' THEN convert(varchar(10),dateadd(day,1,CobraDate),101)
                    when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                    else convert(varchar(10),CobraDate+1,101) end
    ,drvEndDate = ''
    ,drvCovLvl = case when deddedtype = 'FSA' then 'EE'
                        when eedbenoption in ('EE','EE2YR','EE413') THEN 'EE'
                        when eedbenoption in ('EE1') THEN 'EE+1'
                        when eedbenoption in ('EEC','EECH2Y') THEN 'EE+CHILDREN'
                        when eedbenoption in ('EES','EEDP') THEN 'EE+SPOUSE'
                        when eedbenoption in ('EEF','EEDPF','EEF2YR','EEDF2Y') THEN 'EE+FAMILY'
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
    ,drvPlanBndleName = case when eeddedcode in ('MED','MED1','MED2','MED3','MED4','MED5','MED6','EAP','EAP1','EAP2','EAP3','EAP4','EAP5','EAP6') and eeccoid = 'QG52B' then cast('Fortress Medical PPO/Symetra EAP' as varchar(50))
                        when eeddedcode in ('MED7','MED8','MED9','MED10','MED11','EAP7','EAP8','EAP9','EAP10','EAP11') and eeccoid = 'QG52B' then cast('Fortress Medical EPO w/HSA/Symetra EAP' as varchar(50))
                        when eeddedcode in ('MED','MED1','MED2','MED3','MED4','MED5','MED6','EAP','EAP1','EAP2','EAP3','EAP4','EAP5','EAP6') and eeccoid = 'STH8G' then cast('Fortress Medical PPO/Symetra EAP' as varchar(50))
                        when eeddedcode in ('MED7','MED8','MED9','MED10','MED11','EAP7','EAP8','EAP9','EAP10','EAP11') and eeccoid = 'STH8G' then cast('Fortress Medical EPO/Symetra EAP' as varchar(50))
                    end

into dbo.U_dsi_ECOBREGLQB_drvTbl_plan
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
where xFormatCode = @FormatCode --and deddedtype not in ('DEN','VIS','FSA')
    and @D06 = 'Y';

/*
--Insert Bundled Plan - HRA
insert into dbo.U_dsi_ECOBREGLQB_drvTbl_plan
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
--select * from dbo.U_dsi_ECOBREGLQB_drvTbl_plan


insert into dbo.U_dsi_ECOBREGLQB_drvTbl_plan
select distinct
    drveeid = drveeid,
    drvcoid = drvcoid,
    drvdepid = cast('' as varchar),
    drvsort = drvsort
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode=drvdedcode
    ,drvPlanName = 'SymetraEAP'
    ,drvStartDate = drvStartDate
    ,drvEndDate = ''
    ,drvCovLvl = drvCovLvl
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
    ,drvPlanBndleName = drvPlanBndleName
from U_dsi_ECOBREGLQB_drvTbl_plan where drvPlanName = 'Fortress Medical PPO Plan'



--Dependent is PQB
insert into dbo.U_dsi_ECOBREGLQB_drvTbl_plan
select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = conssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvdedcode = dbndedcode
    ,drvPlanName = cast(case when deddedcode IN ('DEN','DEN1','DEN2','DEN3','DEN4') then 'CIGNA Dental DHMO'
                            when deddedcode IN ('DEN5','DEN6','DEN7','DEN8','DEN9') then 'CIGNA Dental PPO'
                            when deddedtype = 'FSA' then 'Discovery Benefits Medical FSA'
                            when deddedcode IN ('VIS','VIS1','VIS2') then 'EyeMed Vision'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') and eeccoid = 'QG52B' then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') and eeccoid = 'QG52B' then 'Fortress Medical EPO with H S A option Plan'
                            when deddedcode IN ('EAP7','EAP8','EAP9','EAP10','EAP11') and eeccoid = 'QG52B' THEN 'Symetra EAP EPO'
                            when deddedcode IN ('EAP','EAP1','EAP2','EAP3','EAP4','EAP5','EAP6') and eeccoid = 'QG52B' THEN 'Symetra EAP PPO'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') and eeccoid = 'STH8G' then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') and eeccoid = 'STH8G' then 'Fortress Medical EPO Plan'
                            when deddedcode like 'EAP%' and eeccoid = 'STH8G' THEN 'Symetra EAP'
                        else '' end as varchar(70))
    ,drvStartDate = case when deddedtype = 'FSA' THEN convert(varchar(10),dateadd(day,1,CobraDate),101)
                    when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                    else convert(varchar(10),CobraDate+1,101) end
    ,drvEndDate = ''
    ,drvCovLvl = case when deddedtype = 'FSA' then 'EE'
                        when dbnbenoption in ('EE','EE2YR','EE413') THEN 'EE'
                        when dbnbenoption in ('EE1') THEN 'EE+1'
                        when dbnbenoption in ('EEC','EECH2Y') THEN 'EE+CHILDREN'
                        when dbnbenoption in ('EES','EEDP') THEN 'EE+SPOUSE'
                        when dbnbenoption in ('EEF','EEDPF','EEF2YR','EEDF2Y') THEN 'EE+FAMILY'
                        when ConRelationship in ('SPS','DP') and dep.cnt > 1 then 'SPOUSE+CHILDREN'
                        when ConRelationship in ('SPS','DP') and dep.cnt = 1 then 'SPOUSE+CHILD'
                        when ConRelationship in ('SPS','DP') and dep.cnt < 1 then 'SPOUSEONLY'
                        when ConRelationship in ('CHL','STC','DPC','SON','DAU') and dep.cnt >= 1 then 'CHILDRENONLY'
                        when ConRelationship in ('CHL','STC','DPC','SON','DAU') and dep.cnt < 1 then 'CHILDONLY'
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
    ,drvPlanBndleName = case when deddedcode in ('MED','MED1','MED2','MED3','MED4','MED5','MED6','EAP','EAP1','EAP2','EAP3','EAP4','EAP5','EAP6') and eeccoid = 'QG52B' then cast('Fortress Medical PPO/Symetra EAP' as varchar(50))
                        when deddedcode in ('MED7','MED8','MED9','MED10','MED11','EAP7','EAP8','EAP9','EAP10','EAP11') and eeccoid = 'QG52B' then cast('Fortress Medical EPO w/HSA/Symetra EAP' as varchar(50))
                        when deddedcode in ('MED','MED1','MED2','MED3','MED4','MED5','MED6','EAP','EAP1','EAP2','EAP3','EAP4','EAP5','EAP6') and eeccoid = 'STH8G' then cast('Fortress Medical PPO/Symetra EAP' as varchar(50))
                        when deddedcode in ('MED7','MED8','MED9','MED10','MED11','EAP7','EAP8','EAP9','EAP10','EAP11') and eeccoid = 'STH8G' then cast('Fortress Medical EPO/Symetra EAP' as varchar(50))
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
join contacts on dbndeprecid = consystemid
left join (select distinct dbneeid eeid, dbncoid coid, dbndedcode dedcode, count(dbnDepReciD) cnt
        from dbo.u_dsi_bdm_DepDeductions
        where dbnFormatCode = @FormatCode and dbnValidForExport = 'Y' and dbnispqb <> 'Y'
        group by dbneeid, dbncoid, dbndedcode) dep on dep.eeid = xeeid and dep.coid = xcoid and dep.dedcode = DbnDedCode
where xFormatCode = @FormatCode --and deddedtype not in ('DEN','VIS','FSA')
    and @D06 = 'Y';

/*
--Dependent Event - Insert HRA Bundled Plan
insert into dbo.U_dsi_ECOBREGLQB_drvTbl_plan
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
--[QBDEPENDENT]                ECOBREGLQB     D07    dbo.U_dsi_ECOBREGLQB_drvTbl_dep
if object_id('U_dsi_ECOBREGLQB_drvTbl_dep') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_dep;

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

INTO dbo.U_dsi_ECOBREGLQB_drvTbl_dep
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

--select * from dbo.U_dsi_ECOBREGLQB_drvTbl_dep order by drvsort, drvsort2

-----
--coverage record Dep - Non bundled plans
-----
--[QBDEPENDENTPLANINITIAL]            ECOBREGLQB     D08    dbo.U_dsi_ECOBREGLQB_drvTbl_depplanInit

if object_id('U_dsi_ECOBREGLQB_drvTbl_depplanInit') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_depplanInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvdedcode = dbndedcode
    ,drvDepPlanName = cast(case when deddedcode IN ('DEN','DEN1','DEN2','DEN3','DEN4') then 'CIGNA Dental DHMO'
                            when deddedcode IN ('DEN5','DEN6','DEN7','DEN8','DEN9') then 'CIGNA Dental PPO'
                            when deddedtype = 'FSA' then 'Discovery Benefits Medical FSA'
                            when deddedcode IN ('VIS','VIS1','VIS2') then 'EyeMed Vision'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') then 'Fortress Medical EPO with H S A option Plan'
                            when deddedcode like 'EAP%' THEN 'Symetra EAP'
                        else '' end as varchar(70))

into dbo.U_dsi_ECOBREGLQB_drvTbl_depplanInit
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
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
where xFormatCode = @FormatCode --and deddedtype in ('DEN','VIS','FSA')
    and @D08 = 'Y';

-----
--coverage record Dep
-----
--[QBDEPENDENTPLAN]            ECOBREGLQB     D09    dbo.U_dsi_ECOBREGLQB_drvTbl_depplan

if object_id('U_dsi_ECOBREGLQB_drvTbl_depplan') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_depplan;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = dbndeprecid,
    drvsort = isnull(pqb.ssn,eepssn)
    ,drvsort2 = conssn
    ,drvdedcode = dbndedcode
    ,drvDepPlanName = cast(case when deddedcode IN ('DEN','DEN1','DEN2','DEN3','DEN4') then 'CIGNA Dental DHMO'
                            when deddedcode IN ('DEN5','DEN6','DEN7','DEN8','DEN9') then 'CIGNA Dental PPO'
                            when deddedtype = 'FSA' then 'Discovery Benefits Medical FSA'
                            when deddedcode IN ('VIS','VIS1','VIS2') then 'EyeMed Vision'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') and eeccoid = 'QG52B' then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') and eeccoid = 'QG52B' then 'Fortress Medical EPO with H S A option Plan'
                            when deddedcode IN ('EAP7','EAP8','EAP9','EAP10','EAP11') and eeccoid = 'QG52B' THEN 'Symetra EAP EPO'
                            when deddedcode IN ('EAP','EAP1','EAP2','EAP3','EAP4','EAP5','EAP6') and eeccoid = 'QG52B' THEN 'Symetra EAP PPO'
                            when deddedcode IN ('MED','MED1','MED2','MED3','MED4','MED5','MED6') and eeccoid = 'STH8G' then 'Fortress Medical PPO Plan'
                            when deddedcode IN ('MED7','MED8','MED9','MED10','MED11') and eeccoid = 'STH8G' then 'Fortress Medical EPO Plan'
                            when deddedcode like 'EAP%' and eeccoid = 'STH8G' THEN 'Symetra EAP'
                        else '' end as varchar(70))

    ,drvDepStartDate = case when deddedtype = 'FSA' THEN convert(varchar(10),dateadd(day,1,CobraDate),101)
                        when datepart(dd,CobraDate+1) > 1 then convert(varchar(10),convert(datetime,convert(varchar(2),datepart(mm,dateadd(mm,1,CobraDate)))+'/01/'+convert(varchar(4),datepart(yyyy,dateadd(mm,1,CobraDate)))),101)
                        else convert(varchar(10),CobraDate+1,101) end
    ,drvDepEnddate = ''
    ,drvDepUsesFDOC = 'TRUE'
into dbo.U_dsi_ECOBREGLQB_drvTbl_depplan
from dbo.u_dsi_bdm_EEList
join empcomp on xeeid = eeceeid and xcoid = eeccoid
    and (eecemplstatus in ('A','L') OR (eecemplstatus= 'T' and eectermreason <>'TRO'))
join emppers on eepeeid = xeeid
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
where xFormatCode = @FormatCode --and deddedtype not in ('DEN','VIS','FSA')
    and @D09 = 'Y';

/*
--Dependent Plan - HRA Bundle
INSERT into dbo.U_dsi_ECOBREGLQB_drvTbl_depplan
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
Insert Into U_dsi_ECOBREGLQB_drvTbl_depplan
select distinct
    drveeid = drveeid,
    drvcoid = drvcoid,
    drvdepid = drvdepid,
    drvsort = drvsort
    ,drvsort2 = drvsort2
    ,drvdedcode = drvdedcode
    ,drvDepPlanName = 'SymetraEAP'
    ,drvDepStartDate = drvDepStartDate
    ,drvDepEnddate = ''
    ,drvDepUsesFDOC = 'TRUE'
FROM dbo.U_dsi_ECOBREGLQB_drvTbl_depplan where drvDepPlanName = 'Fortress Medical PPO Plan'


-- [QBSTATEINSERTS]                    ECOBREGLQB     D12    dbo.U_dsi_ECOBREGLQB_drvTbl_stateInserts

if object_id('U_dsi_ECOBREGLQB_drvTbl_stateInsert') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_stateInsert;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvStateSpecificDocumentName = ''

into dbo.U_dsi_ECOBREGLQB_drvTbl_stateInsert
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
INSERT into dbo.U_dsi_ECOBREGLQB_drvTbl_stateInsert
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
--[QBPLANMEMBERSPECIFICRATEINITIAL]    ECOBREGLQB     D14    dbo.U_dsi_ECOBREGLQB_drvTbl_planFSAInit

if object_id('U_dsi_ECOBREGLQB_drvTbl_planFSAInit') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_planFSAInit;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanNameFSA = 'Discovery Benefits Medical FSA'
    ,drvRate = convert(char(8),convert(numeric(12,2),eedeegoalamt/12))

into dbo.U_dsi_ECOBREGLQB_drvTbl_planFSAInit
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
join dbo.U_dsi_ECOBREGLQB_drvTbl_planInit on drveeid = eedeeid and drvcoid = eedcoid and drvdedcode = eeddedcode
where xFormatCode = @FormatCode
    and @D14 = 'Y';

-----
--coverage record ee - FSA
-----
--[QBPLANMEMBERSPECIFICRATE]    ECOBREGLQB     D15    dbo.U_dsi_ECOBREGLQB_drvTbl_planFSA

if object_id('U_dsi_ECOBREGLQB_drvTbl_planFSA') is not null
    drop table dbo.U_dsi_ECOBREGLQB_drvTbl_planFSA;

select distinct
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
    drvsort = eepssn
    ,drvsort2 = cast('' as varchar(9))
    ,drvPlanNameFSA = 'Discovery Benefits Medical FSA'
    ,drvStartDateFSA = convert(varchar(10),CobraDate+1,101)
    ,drvEndDateFSA = convert(varchar(10),dateadd(ms,-3,DATEADD(yy, DATEDIFF(yy,0,@EndDate )+1, 0)) ,101)--TD 03/12/12 (last day of year)
    ,drvRate = convert(char(8),convert(numeric(12,2),eedeegoalamt/12))

into dbo.U_dsi_ECOBREGLQB_drvTbl_planFSA
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
join dbo.U_dsi_ECOBREGLQB_drvTbl_plan on drveeid = eedeeid and drvcoid = eedcoid and drvdedcode = eeddedcode
where xFormatCode = @FormatCode
    and @D15 = 'Y';

--select * from dbo.U_dsi_ECOBREGLQB_drvTbl_planFSA

--Discovery/COBRApoint files:
/*
    drveeid = xeeid,
    drvcoid = xcoid,
    drvdepid = cast('' as varchar),
*/

--Dependents not linked to PQB
declare @Loop1 int, @Loop2 int;

set @Loop1 = 0;
set @Loop2 = (select count(*) from dbo.U_dsi_ECOBREGLQB_drvTbl_dep
    where drvsort not in (select drvsort from dbo.U_dsi_ECOBREGLQB_drvTbl));

WHILE @Loop1 < @Loop2
BEGIN
declare @DepID char(12), @DepEEID char(12), @PQBssn char(9);
set @DepID = (select top 1 drvdepid from dbo.U_dsi_ECOBREGLQB_drvTbl_dep
    where drvsort not in (select drvsort from dbo.U_dsi_ECOBREGLQB_drvTbl));

set @DepEEID = (select distinct drveeid from dbo.U_dsi_ECOBREGLQB_drvTbl_dep where drvdepid = @DepID);
set @PQBssn = (select distinct drvsort from dbo.U_dsi_ECOBREGLQB_drvTbl where drveeid = @DepEEID);

update dbo.U_dsi_ECOBREGLQB_drvTbl_dep
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

update dbo.U_dsi_ECOBREGLQB_drvTbl_depplanInit
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

update dbo.U_dsi_ECOBREGLQB_drvTbl_depplan
set drvsort = @PQBssn
where drvdepid = @DepID and drveeid = @DepEEID;

set @Loop1 = @Loop1 + 1;

END;

-- Set FileName
if (dbo.dsi_fnVariable('ECOBREGLQB','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile = 'FROST_COBRA_QB_' + replace(convert(char(10), GetDate(), 1), '/',SPACE(0)) + '.csv'
    where FormatCode = 'ECOBREGLQB';

/*
--Alter the View
ALTER  View dbo.dsi_vwECOBREGLQB_Export as
        select top 2000000
        left(data,(len(data))) as data
        from dbo.U_ECOBREGLQB_File with (nolock)
         order by case when substring(RecordSet,1,1) = 'H' then 1 else 2 end,InitialSort, Subsort, substring(RecordSet,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'ECOBREGLQB'
*/

--dbo.dsi_sp_testSwitchbox_v2 'ECOBREGLQB','ECOBREGLQB'
--dbo.dsi_sp_testSwitchbox_v2 'ECOBREGLQB','TEST'        --non UDES file
--dbo.dsi_sp_testSwitchbox_v2 'ECOBREGLQB','ZAP'
GO
CREATE  View dbo.dsi_vwECOBREGLQB_Export as
        select top 2000000
        left(data,(len(data))) as data
        from dbo.U_ECOBREGLQB_File with (nolock)
         order by case when substring(RecordSet,1,1) = 'H' then 1 else 2 end,InitialSort, Subsort, substring(RecordSet,2,2)