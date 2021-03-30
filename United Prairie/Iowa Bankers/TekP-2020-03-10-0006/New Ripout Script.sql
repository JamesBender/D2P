SET NOCOUNT ON;
IF OBJECT_ID('U_EIWABNKMED_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EIWABNKMED_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EIWABNKMED' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEIWABNKMED_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEIWABNKMED_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EIWABNKMED') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIWABNKMED];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EIWABNKMED') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EIWABNKMED];
GO
IF OBJECT_ID('U_EIWABNKMED_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_TrlTbl];
GO
IF OBJECT_ID('U_EIWABNKMED_OldBenOptions') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_OldBenOptions];
GO
IF OBJECT_ID('U_EIWABNKMED_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_HdrTbl];
GO
IF OBJECT_ID('U_EIWABNKMED_File') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_File];
GO
IF OBJECT_ID('U_EIWABNKMED_EEList') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_EEList];
GO
IF OBJECT_ID('U_EIWABNKMED_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_DrvTbl_2300];
GO
IF OBJECT_ID('U_EIWABNKMED_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_DrvTbl];
GO
IF OBJECT_ID('U_EIWABNKMED_DedList') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_DedList];
GO
IF OBJECT_ID('U_EIWABNKMED_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_AuditFields];
GO
IF OBJECT_ID('U_EIWABNKMED_Audit') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EIWABNKMED') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EIWABNKMED];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EIWABNKMED';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EIWABNKMED';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EIWABNKMED';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EIWABNKMED';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EIWABNKMED';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EIWABNKMED','Iowa Bankers Med 834 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EIWABNKMEDZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EIWABNKMED' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISA"','1','(''DA''=''F*'')','EIWABNKMEDZ0','3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''F*'')','EIWABNKMEDZ0','2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F*'')','EIWABNKMEDZ0','10','H','01','3',NULL,'Authorization Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','4','(''DA''=''F*'')','EIWABNKMEDZ0','2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F*'')','EIWABNKMEDZ0','10','H','01','5',NULL,'Security Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA05_SenderIDQual"','6','(''UA''=''F*'')','EIWABNKMEDZ0','2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA06_SenderID"','7','(''UA''=''F*'')','EIWABNKMEDZ0','15','H','01','7',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA07_ReceiverIDQual"','8','(''UA''=''F*'')','EIWABNKMEDZ0','2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA08_ReceiverID"','9','(''UA''=''F*'')','EIWABNKMEDZ0','15','H','01','9',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA09_InterchangeDate"','10','(''UD12''=''F*'')','EIWABNKMEDZ0','6','H','01','10',NULL,'Interchange Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA10_InterchangeTime"','11','(''UA''=''F*'')','EIWABNKMEDZ0','4','H','01','11',NULL,'Interchange Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"^"','12','(''DA''=''F*'')','EIWABNKMEDZ0','1','H','01','12',NULL,'Repetition Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00501"','13','(''DA''=''F*'')','EIWABNKMEDZ0','5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','14','(''DA''=''F*'')','EIWABNKMEDZ0','9','H','01','14',NULL,'Interchange Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','15','(''DA''=''F*'')','EIWABNKMEDZ0','1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA15_UsageIndicator"','16','(''UA''=''F*'')','EIWABNKMEDZ0','1','H','01','16',NULL,'Usage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('":"','17','(''DA''=''F*'')','EIWABNKMEDZ0','1','H','01','17',NULL,'Component Element Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GS"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BE"','2','(''DA''=''T*'')','EIWABNKMEDZ0','2','H','02','2',NULL,'Functional ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS02_SenderID"','3','(''UA''=''T*'')','EIWABNKMEDZ0','15','H','02','3',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS03_ReceiverID"','4','(''UA''=''T*'')','EIWABNKMEDZ0','15','H','02','4',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS04_Date"','5','(''UD112''=''T*'')','EIWABNKMEDZ0','8','H','02','5',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS05_Time"','6','(''UA''=''T*'')','EIWABNKMEDZ0','8','H','02','6',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','7','(''DA''=''T*'')','EIWABNKMEDZ0','9','H','02','7',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"X"','8','(''DA''=''T*'')','EIWABNKMEDZ0','2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','9','(''DA''=''T*'')','EIWABNKMEDZ0','12','H','02','9',NULL,'Version/Release  Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ST"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"834"','2','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','03','2',NULL,'Transaction ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EIWABNKMEDZ0','9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','4','(''DA''=''T*'')','EIWABNKMEDZ0','35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BGN"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''T*'')','EIWABNKMEDZ0','2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EIWABNKMEDZ0','50','H','04','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN03_Date"','4','(''UD112''=''T*'')','EIWABNKMEDZ0','8','H','04','4',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN04_Time"','5','(''UA''=''T*'')','EIWABNKMEDZ0','8','H','04','5',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN05_TimeCode"','6','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','04','6',NULL,'Time Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN06_RefID"','7','(''UA''=''T*'')','EIWABNKMEDZ0','50','H','04','7',NULL,'Reference Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN07_TransTypeCode"','8','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','04','8',NULL,'Transaction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN08_ActionCode"','9','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','04','9',NULL,'Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual"','3','(''UA''=''T*'')','EIWABNKMEDZ0','50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DTP"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','06','1',NULL,'DTP Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"007"','2','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','06','2',NULL,'Date Qulifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D8"','3','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','06','3',NULL,'Date Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod"','4','(''UD112''=''T*'')','EIWABNKMEDZ0','8','H','06','4',NULL,'Date Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity1"','3','(''UA''=''T*'')','EIWABNKMEDZ0','15','H','07','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual2"','2','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','15','H','08','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','H','09','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual3"','2','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','09','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity3"','3','(''UA''=''T*'')','EIWABNKMEDZ0','15','H','09','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','H','10','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','H','10','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name1"','3','(''UA''=''T*'')','EIWABNKMEDZ0','60','H','10','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual1"','4','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','10','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode1"','5','(''UA''=''T*'')','EIWABNKMEDZ0','80','H','10','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','H','11','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor2"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','H','11','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','60','H','11','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual2"','4','(''UA''=''T*'')','EIWABNKMEDZ0','2','H','11','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode2"','5','(''UA''=''T*'')','EIWABNKMEDZ0','80','H','11','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INS"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','12','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS01_YesNoCond"','2','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','12','2',NULL,'Yes/No Condition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS02_RelationshipCode"','3','(''UA''=''T*'')','EIWABNKMEDZ0','2','D','12','3',NULL,'Individual Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS03_MaintTypeCode"','4','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','12','4',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS04_MaintReasonCode"','5','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','12','5',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS05_BenefitStatusCode"','6','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','12','6',NULL,'Benefit Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0601_MEDICAREPLANCODE"','7','(''UA''=''T'')','EIWABNKMEDZ0','1','D','12','7',NULL,'MEDICARE PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0602_EligibilityRsnCode"','8','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','12','8',NULL,'Eligibility Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS07_COBRAQualEventCode"','9','(''UA''=''T*'')','EIWABNKMEDZ0','2','D','12','9',NULL,'COBRA Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS08_EmploymentStatusCode"','10','(''UA''=''T*'')','EIWABNKMEDZ0','2','D','12','10',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS09_StudentStatusCode"','11','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','12','11',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS10_ResponseCode"','12','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','12','12',NULL,'Response Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS11_DateTimeFormatQual"','13','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','12','13',NULL,'Date Time Period Format Qualif',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS12_DateTimePeriod"','14','(''UD112''=''T*'')','EIWABNKMEDZ0','35','D','12','14',NULL,'Date Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','13','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0F"','2','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','13','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T*'')','EIWABNKMEDZ0','50','D','13','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','EIWABNKMEDZ0','50','D','14','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','15','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','15','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','50','D','15','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime1"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','16','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','16','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual1"','3','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','16','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod1"','4','(''UD112''=''T*'')','EIWABNKMEDZ0','35','D','16','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime2"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','17','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier2"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','17','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','17','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod2"','4','(''UD112''=''T*'')','EIWABNKMEDZ0','35','D','17','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NM1"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','20','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IL"','2','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','20','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','3','(''DA''=''T*'')','EIWABNKMEDZ0','1','D','20','3',NULL,'Entity Type Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM103_NameLast1"','4','(''UA''=''T*'')','EIWABNKMEDZ0','60','D','20','4',NULL,'Name Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM104_NameFirst1"','5','(''UA''=''T*'')','EIWABNKMEDZ0','35','D','20','5',NULL,'Name First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM105_NameMiddleInitial1"','6','(''UA''=''T*'')','EIWABNKMEDZ0','25','D','20','6',NULL,'Name Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM106_NamePrefix1"','7','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','20','7',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM107_NameSuffix1"','8','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','20','8',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM108_IDCodeQualifier1"','9','(''UA''=''T*'')','EIWABNKMEDZ0','2','D','20','9',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM109_IDCode1"','10','(''UA''=''T*'')','EIWABNKMEDZ0','80','D','20','10',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','21','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IP"','2','(''DA''=''T*'')','EIWABNKMEDZ0','2','D','21','2',NULL,'Contact Function Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER02_Name"','3','(''UA''=''T*'')','EIWABNKMEDZ0','60','D','21','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER03_CommNumberQualifier"','4','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','21','4',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER04_CommunicationNumber"','5','(''UA''=''T*'')','EIWABNKMEDZ0','256','D','21','5',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER05_CommNumberQualifier"','6','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','21','6',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER06_CommunicationNumber"','7','(''UA''=''T*'')','EIWABNKMEDZ0','256','D','21','7',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER07_CommNumberQualifier"','8','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','21','8',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER08_CommunicationNumber"','9','(''UA''=''T*'')','EIWABNKMEDZ0','256','D','21','9',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N3"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','D','22','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN301_AddressLine1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','55','D','22','2',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN302_AddressLine2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','55','D','22','3',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N4"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','D','23','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN401_City"','2','(''UA''=''T*'')','EIWABNKMEDZ0','30','D','23','2',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN402_State"','3','(''UA''=''T*'')','EIWABNKMEDZ0','2','D','23','3',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN403_Zip"','4','(''UA''=''T*'')','EIWABNKMEDZ0','15','D','23','4',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN404_CountryCode"','5','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','23','5',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMG"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','24','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D8"','2','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','24','2',NULL,'Date/Time Format Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG02_DateTimePeriod1"','3','(''UD112''=''T*'')','EIWABNKMEDZ0','35','D','24','3',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG03_GenderCode1"','4','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','24','4',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG04_MaritalStatusCode1"','5','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','24','5',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ICM"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','25','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM01_FrequencyCode"','2','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','25','2',NULL,'Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM02_MonetaryAmount"','3','(''UA''=''T*'')','EIWABNKMEDZ0','18','D','25','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM03_Quantity"','4','(''UA''=''T*'')','EIWABNKMEDZ0','15','D','25','4',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM04_LocationID"','5','(''UA''=''T*'')','EIWABNKMEDZ0','30','D','25','5',NULL,'Location Identifier Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID1"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','26','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','18','D','26','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','26','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID2"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','27','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','EIWABNKMEDZ0','18','D','27','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','27','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH00_SegmentID"','1','(''UA''=''T*'')','EIWABNKMEDZ0','1','D','28','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH01_HealthRelatedCode"','2','(''UA''=''T*'')','EIWABNKMEDZ0','8','D','28','2',NULL,'Health-Related Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH02_Height"','3','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','28','3',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH03_Weight1"','4','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','28','4',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH04_Weight2"','5','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','28','5',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH05_Description1"','6','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','28','6',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH06_CurrentHealthConditionCode"','7','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','28','7',NULL,'Current Health Condition Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH07_Description2"','8','(''UA''=''T*'')','EIWABNKMEDZ0','10','D','28','8',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD00_HealthCoverage"','1','(''UA''=''T*'')','EIWABNKMEDZ0','2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD01_MaintTypeCode"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD02_MaintReasonCode"','3','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD03_InsuranceLineCode"','4','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','40','4',NULL,'Insurance Line Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD04_PlanCoverageDesc"','5','(''UA''=''T*'')','EIWABNKMEDZ0','50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD05_CoverageLevelCode"','6','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','40','6',NULL,'Coverage Level Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_348"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_348"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_348"','3','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','41','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_348"','4','(''UD112''=''T*'')','EIWABNKMEDZ0','35','D','41','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_349"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_349"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_349"','3','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','42','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_349"','4','(''UD112''=''T*'')','EIWABNKMEDZ0','35','D','42','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_303"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_303"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_303"','3','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','43','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_303"','4','(''UD112''=''T*'')','EIWABNKMEDZ0','35','D','43','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual1"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','EIWABNKMEDZ0','50','D','45','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual2"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','50','D','46','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode1"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','EIWABNKMEDZ0','18','D','50','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode2"','1','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','EIWABNKMEDZ0','18','D','51','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LS"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLS01_LoopIDCode"','2','(''UA''=''T*'')','EIWABNKMEDZ0','6','D','80','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LX"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLX01_AssignedNumber"','2','(''UA''=''T*'')','EIWABNKMEDZ0','6','D','81','2',NULL,'Assigned Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name"','3','(''UA''=''T*'')','EIWABNKMEDZ0','60','D','85','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','EIWABNKMEDZ0','3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberDesc"','3','(''UA''=''T*'')','EIWABNKMEDZ0','50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LE"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLE01_LoopIDCode"','2','(''UA''=''T*'')','EIWABNKMEDZ0','6','D','87','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SE"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSE01_SegmentCount"','2','(''UA''=''T*'')','EIWABNKMEDZ0','10','T','90','2',NULL,'Number of Included Segments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EIWABNKMEDZ0','9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GE"','1','(''DA''=''T*'')','EIWABNKMEDZ0','2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','EIWABNKMEDZ0','6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EIWABNKMEDZ0','9','T','91','3',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IEA"','1','(''DA''=''T*'')','EIWABNKMEDZ0','3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','EIWABNKMEDZ0','5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','3','(''DA''=''T*'')','EIWABNKMEDZ0','9','T','92','3',NULL,'Interchange Control Number',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EIWABNKMED_20201230.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Changes Only File','202010319','EMPEXPORT','CHANGES','Jun  4 2020  6:18AM','EIWABNKMED',NULL,NULL,NULL,'202010319','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202010011','2727','','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Full File Only','202010319','EMPEXPORT','FULLFILE','Nov 17 2020  8:32AM','EIWABNKMED',NULL,NULL,NULL,'202010319','Nov 17 2020 12:00AM','Dec 30 1899 12:00AM','202010011','2103','','','202010011',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment','202010319','EMPEXPORT','OEACTIVE','Nov 17 2020  8:31AM','EIWABNKMED',NULL,NULL,NULL,'202010319','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202010011','2169','','','202010011',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment','202010319','EMPEXPORT','OEPASSIVE','Dec 29 2020  5:36PM','EIWABNKMED',NULL,NULL,NULL,'202010319','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202010011','2340','','','202010011',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','MURQ3',NULL,NULL,NULL,'Iowa Bankers Med - Fri 7pm','202010319','EMPEXPORT','SCHEDULED','Jun  4 2020  6:19AM','EIWABNKMED',NULL,NULL,NULL,'202010319','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202010011','2727','','','202010011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Testing Only','202010319','EMPEXPORT','TESTING','Dec 29 2020  5:43PM','EIWABNKMED',NULL,NULL,NULL,'202010319','Dec 29 2020 12:00AM','Dec 30 1899 12:00AM','202010011','2146','','','202010011',dbo.fn_GetTimedKey(),NULL,'us3lKiUNI1088',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EIWABNKMED','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EIWABNKMED' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EIWABNKMED' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EIWABNKMED_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EIWABNKMED_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H01','U_EIWABNKMED_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H02','U_EIWABNKMED_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H03','U_EIWABNKMED_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H04','U_EIWABNKMED_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H05','U_EIWABNKMED_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H06','U_EIWABNKMED_HdrTbl','ISNULL(drvDTP03_DateTimePeriod,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H07','U_EIWABNKMED_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H08','U_EIWABNKMED_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H09','U_EIWABNKMED_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H10','U_EIWABNKMED_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','H11','U_EIWABNKMED_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D12','U_EIWABNKMED_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D13','U_EIWABNKMED_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D14','U_EIWABNKMED_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D15','U_EIWABNKMED_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D16','U_EIWABNKMED_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D17','U_EIWABNKMED_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D20','U_EIWABNKMED_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D21','U_EIWABNKMED_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D22','U_EIWABNKMED_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D23','U_EIWABNKMED_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D24','U_EIWABNKMED_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D25','U_EIWABNKMED_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D26','U_EIWABNKMED_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D27','U_EIWABNKMED_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D28','U_EIWABNKMED_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D40','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D41','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D42','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D43','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D45','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D46','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D50','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D51','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D80','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D81','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D85','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D86','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','D87','U_EIWABNKMED_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','T90','U_EIWABNKMED_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','T91','U_EIWABNKMED_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EIWABNKMED','T92','U_EIWABNKMED_TrlTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EIWABNKMED') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EIWABNKMED] (
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
IF OBJECT_ID('U_EIWABNKMED_Audit') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_Audit] (
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
IF OBJECT_ID('U_EIWABNKMED_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EIWABNKMED_DedList') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EIWABNKMED_DrvTbl') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_DrvTbl] (
    [drvINS01_YesNoCond] varchar(1) NOT NULL,
    [drvINS02_RelationshipCode] varchar(2) NOT NULL,
    [drvINS03_MaintTypeCode] varchar(3) NOT NULL,
    [drvINS04_MaintReasonCode] varchar(1) NOT NULL,
    [drvINS05_BenefitStatusCode] varchar(1) NOT NULL,
    [drvINS0601_MEDICAREPLANCODE] varchar(1) NOT NULL,
    [drvINS0602_EligibilityRsnCode] varchar(1) NOT NULL,
    [drvINS07_COBRAQualEventCode] varchar(1) NOT NULL,
    [drvINS08_EmploymentStatusCode] varchar(2) NOT NULL,
    [drvINS09_StudentStatusCode] varchar(1) NOT NULL,
    [drvINS10_ResponseCode] varchar(1) NULL,
    [drvINS11_DateTimeFormatQual] varchar(2) NULL,
    [drvINS12_DateTimePeriod] varchar(8) NULL,
    [drvREF01_RefNumberQual1] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual1] varchar(24) NULL,
    [drvREF01_RefNumberQual2] varchar(1) NOT NULL,
    [drvREF02_RefNumberQual2] varchar(1) NOT NULL,
    [drvDTP00_DateTime1] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier1] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual1] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod1] datetime NULL,
    [drvDTP00_DateTime2] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier2] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual2] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod2] datetime NULL,
    [drvNM103_NameLast1] varchar(6000) NULL,
    [drvNM104_NameFirst1] varchar(6000) NULL,
    [drvNM105_NameMiddleInitial1] varchar(6000) NULL,
    [drvNM106_NamePrefix1] varchar(1) NOT NULL,
    [drvNM107_NameSuffix1] varchar(30) NULL,
    [drvNM108_IDCodeQualifier1] varchar(2) NULL,
    [drvNM109_IDCode1] char(11) NULL,
    [drvPER02_Name] varchar(1) NOT NULL,
    [drvPER03_CommNumberQualifier] varchar(2) NULL,
    [drvPER04_CommunicationNumber] varchar(50) NULL,
    [drvPER05_CommNumberQualifier] varchar(2) NULL,
    [drvPER06_CommunicationNumber] varchar(50) NULL,
    [drvPER07_CommNumberQualifier] varchar(1) NOT NULL,
    [drvPER08_CommunicationNumber] varchar(1) NOT NULL,
    [drvN301_AddressLine1] nvarchar(4000) NULL,
    [drvN302_AddressLine2] varchar(6000) NULL,
    [drvN401_City] varchar(6000) NULL,
    [drvN402_State] varchar(255) NULL,
    [drvN403_Zip] varchar(50) NULL,
    [drvN404_CountryCode] char(3) NULL,
    [drvDMG02_DateTimePeriod1] varchar(8) NULL,
    [drvDMG03_GenderCode1] char(1) NULL,
    [drvDMG04_MaritalStatusCode1] varchar(1) NULL,
    [drvICM01_FrequencyCode] varchar(1) NULL,
    [drvICM02_MonetaryAmount] money NULL,
    [drvICM03_Quantity] money NULL,
    [drvICM04_LocationID] varchar(8) NULL,
    [drvAMT00_SegmentID1] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode1] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount1] varchar(1) NOT NULL,
    [drvAMT00_SegmentID2] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode2] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount2] varchar(1) NOT NULL,
    [drvHLH00_SegmentID] varchar(1) NOT NULL,
    [drvHLH01_HealthRelatedCode] varchar(1) NULL,
    [drvHLH02_Height] varchar(1) NOT NULL,
    [drvHLH03_Weight1] varchar(1) NOT NULL,
    [drvHLH04_Weight2] varchar(1) NOT NULL,
    [drvHLH05_Description1] varchar(1) NOT NULL,
    [drvHLH06_CurrentHealthConditionCode] varchar(1) NOT NULL,
    [drvHLH07_Description2] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCOID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] char(21) NULL
);
IF OBJECT_ID('U_EIWABNKMED_DrvTbl_2300') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_DrvTbl_2300] (
    [drvHD00_HealthCoverage] varchar(2) NULL,
    [drvHD01_MaintTypeCode] varchar(3) NOT NULL,
    [drvHD02_MaintReasonCode] varchar(1) NULL,
    [drvHD03_InsuranceLineCode] varchar(3) NULL,
    [drvHD04_PlanCoverageDesc] varchar(4) NULL,
    [drvHD05_CoverageLevelCode] varchar(3) NULL,
    [drvDTP00_DateTime_348] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier_348] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_348] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_348] datetime NULL,
    [drvDTP00_DateTime_349] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier_349] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_349] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_349] datetime NULL,
    [drvDTP00_DateTime_303] varchar(1) NULL,
    [drvDTP01_DateTimeQualifier_303] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_303] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_303] datetime NULL,
    [drvREF00_RefNumberQual1] varchar(1) NULL,
    [drvREF01_RefNumberQual1] varchar(1) NULL,
    [drvREF02_RefNumberQual1] varchar(1) NULL,
    [drvREF00_RefNumberQual2] varchar(1) NULL,
    [drvREF01_RefNumberQual2] varchar(1) NULL,
    [drvREF02_RefNumberQual2] varchar(1) NULL,
    [drvAMT00_AmountQualifierCode1] varchar(1) NULL,
    [drvAMT01_AmountQualifierCode1] varchar(1) NULL,
    [drvAMT02_MonetaryAmount1] varchar(1) NULL,
    [drvAMT00_AmountQualifierCode2] varchar(1) NULL,
    [drvAMT01_AmountQualifierCode2] varchar(1) NULL,
    [drvAMT02_MonetaryAmount2] varchar(1) NULL,
    [drvLS01_LoopIDCode] varchar(1) NOT NULL,
    [drvLX01_AssignedNumber] varchar(1) NOT NULL,
    [drvN101_EntityIDCodeSponsor] varchar(1) NOT NULL,
    [drvN102_Name] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual] varchar(1) NOT NULL,
    [drvREF02_RefNumberDesc] varchar(1) NULL,
    [drvLE01_LoopIDCode] varchar(1) NOT NULL,
    [drvEEID] char(12) NULL,
    [drvCOID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NULL,
    [drvInitialSort] varchar(11) NULL,
    [drvSubSort] varchar(29) NULL
);
IF OBJECT_ID('U_EIWABNKMED_EEList') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EIWABNKMED_File') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EIWABNKMED_HdrTbl') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_HdrTbl] (
    [drvISA05_SenderIDQual] varchar(2) NOT NULL,
    [drvISA06_SenderID] varchar(9) NOT NULL,
    [drvISA07_ReceiverIDQual] varchar(2) NOT NULL,
    [drvISA08_ReceiverID] varchar(4) NOT NULL,
    [drvISA09_InterchangeDate] varchar(6) NULL,
    [drvISA10_InterchangeTime] varchar(4) NULL,
    [drvISA15_UsageIndicator] varchar(1) NOT NULL,
    [drvGS02_SenderID] varchar(9) NOT NULL,
    [drvGS03_ReceiverID] varchar(4) NOT NULL,
    [drvGS04_Date] varchar(8) NULL,
    [drvGS05_Time] varchar(4) NULL,
    [drvBGN03_Date] varchar(8) NULL,
    [drvBGN04_Time] varchar(4) NULL,
    [drvBGN05_TimeCode] varchar(2) NOT NULL,
    [drvBGN06_RefID] varchar(1) NOT NULL,
    [drvBGN07_TransTypeCode] varchar(1) NOT NULL,
    [drvBGN08_ActionCode] varchar(2) NOT NULL,
    [drvREF01_RefNumberQual] varchar(1) NOT NULL,
    [drvREF02_RefNumberQual] varchar(1) NOT NULL,
    [drvDTP03_DateTimePeriod] datetime NOT NULL,
    [drvQTY01_QuantityQual1] varchar(2) NOT NULL,
    [drvQTY02_Quantity1] nvarchar(4000) NULL,
    [drvQTY01_QuantityQual2] varchar(2) NOT NULL,
    [drvQTY02_Quantity2] nvarchar(4000) NULL,
    [drvQTY01_QuantityQual3] varchar(2) NOT NULL,
    [drvQTY02_Quantity3] nvarchar(4000) NULL,
    [drvN101_EntityIDCodeSponsor1] varchar(2) NOT NULL,
    [drvN102_Name1] varchar(19) NOT NULL,
    [drvN103_IDCodeQual1] varchar(2) NOT NULL,
    [drvN104_IDCode1] varchar(9) NOT NULL,
    [drvN101_EntityIDCodeSponsor2] varchar(2) NOT NULL,
    [drvN102_Name2] varchar(31) NOT NULL,
    [drvN103_IDCodeQual2] varchar(2) NOT NULL,
    [drvN104_IDCode2] varchar(4) NOT NULL
);
IF OBJECT_ID('U_EIWABNKMED_OldBenOptions') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_OldBenOptions] (
    [ObEEID] varchar(255) NOT NULL,
    [ObCOID] varchar(255) NOT NULL,
    [ObDedCode] varchar(255) NOT NULL,
    [ObOldBenOption] varchar(2000) NULL,
    [ObNewBenOption] varchar(2000) NULL,
    [OBSource] varchar(5) NOT NULL
);
IF OBJECT_ID('U_EIWABNKMED_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_EIWABNKMED_TrlTbl] (
    [drvSE01_SegmentCount] varchar(4) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EIWABNKMED]
AS
SET NOCOUNT ON;
/************************************************************
Client: United Prairie

Created By: James Bender
Create Date: 6/2/2020
ChangePoint Request Number: TekP-2020-03-10-0006

Purpose: Remove "bad" elements where record ends with Asterisk and Tilde (*~)

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

************************************************************/
BEGIN

    --==================================================
    -- Remove Blank Elements Where Row Ends With '*~'
    --==================================================
    WHILE (SELECT COUNT(*) FROM dbo.U_EIWABNKMED_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_EIWABNKMED_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_EIWABNKMED_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_EIWABNKMED_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_EIWABNKMED_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_EIWABNKMED_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_EIWABNKMED_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EIWABNKMED]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: United Prairie

Created By: James Bender
Business Analyst: Lea King
Create Date: 6/2/2020
Service Request Number: TekP-2020-03-10-0006

Purpose: Iowa Bankers Med 834 Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EIWABNKMED';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EIWABNKMED';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EIWABNKMED';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EIWABNKMED';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EIWABNKMED' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'TESTING';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EIWABNKMED', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EIWABNKMED';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EIWABNKMED', @AllObjects = 'Y', @IsWeb = 'Y';
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
            ,@RunDate           VARCHAR(8)
            ,@RunTime           VARCHAR(4)
            ,@FileMinCovDate    DATETIME;

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl  = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = CAST(LEFT(StartPerControl,8) AS DATETIME)
        ,@EndDate         = DATEADD(SS,-1,DATEADD(DD,1,LEFT(EndPerControl,8)))
        ,@FormatCode      = FormatCode
        ,@ExportCode      = ExportCode
        ,@RunDate         = CONVERT(VARCHAR(8),GETDATE(),112)
        ,@RunTime         = REPLACE(CONVERT(VARCHAR(5), GETDATE(), 108),':',SPACE(0))
        ,@FileMinCovDate  = ''
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EIWABNKMED';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '426,427,428,429,430,431';

    IF OBJECT_ID('U_EIWABNKMED_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EIWABNKMED_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EIWABNKMED_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EIWABNKMED_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EIWABNKMED_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EIWABNKMED_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);



    --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_EIWABNKMED_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_AuditFields;
    CREATE TABLE dbo.U_EIWABNKMED_AuditFields (aTableName varchar(30),aFieldName varchar(30));


    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedBenOption');

    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDed','EedDedCode');



    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenStopDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenStartDate');
    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedBenOption');

    INSERT INTO dbo.U_EIWABNKMED_AuditFields VALUES ('EmpDedFull','EedDedCode');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_EIWABNKMED_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_Audit;
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
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audTableName, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_EIWABNKMED_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK) 
    JOIN dbo.U_EIWABNKMED_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE --audDateTime BETWEEN @StartDate AND @EndDate
    --AND 
    audAction <> 'DELETE'
    AND AudNewValue NOT IN ('Z')
    ;

    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EIWABNKMED_Audit ON dbo.U_EIWABNKMED_Audit (audEEID,audKey2);






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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');

    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV');

    --Set if OE
    IF @ExportCode LIKE '%PASSIVE' --OR @ExportCode = 'TESTING'
    BEGIN
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AllowMultiDedType', 'Y')
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE' 
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;




    IF OBJECT_ID('U_EIWABNKMED_OldBenOptions','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_OldBenOptions;
    SELECT AudEEID AS ObEEID, AudKey2 AS ObCOID, AudKey3 AS ObDedCode, AudOldValue AS ObOldBenOption, AudNewValue AS ObNewBenOption, 'Audit' AS OBSource --, AudNewValue AS NewBenOption, audDateTime
    INTO dbo.U_EIWABNKMED_OldBenOptions
    FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK)
    WHERE audTableName = 'EmpDed'
        AND audFieldName = 'EedBenOption'
        AND audAction = 'Update'
        AND AudRowNo = 1
        AND  AudKey3 IN ('426','427','428','429','430','431') 
        AND AudOldValue <> 'Z'
        AND audDateTime BETWEEN @StartDate AND @EndDate
            

    IF @ExportCode LIKE '%PASSIVE' OR @ExportCode LIKE '%ACTIVE' --OR @ExportCode = 'TESTING'
    BEGIN
        INSERT INTO dbo.U_EIWABNKMED_OldBenOptions (ObEEID, ObCOID, ObDedCode, ObOldBenOption, ObNewBenOption, ObSource)
        SELECT EdhEEID, EdhCOID, EdhDedCode, EdhBenOption, BdmBenOption, 'HDed' --, EdhEffDate, RN
        FROM (
                SELECT EdhEEID, EdhCOID, EdhEffDate, EdhDedCode, EdhBenOption, BdmBenOption, ROW_NUMBER() OVER (PARTITION BY EdhEEID, EdhCOID, EdhDedCode ORDER BY EdhEffDate DESC) AS RN
                FROM dbo.EmpHDed WITH (NOLOCK)
                JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) 
                    ON EdhEEID = BdmEEID
                    AND EdhCOID = BdmCOID
                    AND EdhDedCode = BdmDedCode
                    AND EdhBenOption <> BdmBenOption
                    AND EdhBenOption <> 'Z'
                WHERE EdhDedCode IN ('426','427','428','429','430','431') 
                    AND EdhChangeReason = 'OE'        
                    AND EdhEffDate< '1/1/2021'
                    AND EdhEEID NOT IN (SELECT DISTINCT ObEEID FROM dbo.U_EIWABNKMED_OldBenOptions)
                    --AND EdhEEID = 'COCIET043030' 
                ) AS OldOEOpt
        WHERE RN = 1
        --AND EdhEEID = 'COCIET043030'    
    END


    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EIWABNKMED D
    JOIN dbo.U_dsi_bdm_EIWABNKMED E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EIWABNKMED
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EIWABNKMED
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EIWABNKMED
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EIWABNKMED
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EIWABNKMED
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EIWABNKMED
    JOIN dbo.EmpDedFull WITH (NOLOCK)
        ON EedEmpDedTVID = BdmUSGField2;

    --==========================================
    -- Build Driver Tables
    --==========================================

    /**************************************************************************************************************
        HEADER RECORDS
            - ISA, GS, ST, BGN, REF, QTY Segments
            - LOOP 1000A/1000B RECORDS - N1 Segments
    ***************************************************************************************************************/

    DECLARE @CmmFedTaxId VARCHAR(9);
    DECLARE @EmpCount INT;
    DECLARE @DepCount INT;

    SELECT @CmmFedTaxId = CmmFedTaxId from dbo.CompMast WITH (NOLOCK);
    SELECT DISTINCT @EmpCount = COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmRecType = 'EMP';
    SELECT DISTINCT @DepCount = COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmRecType = 'DEP';

    -------------------
    -- HEADER RECORD 
    -------------------
    IF OBJECT_ID('U_EIWABNKMED_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = 'ZZ'
        ,drvISA06_SenderID = '410250740'
        ,drvISA07_ReceiverIDQual = 'ZZ'
        ,drvISA08_ReceiverID = 'IBIS'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = '410250740' -- @CmmFedTaxId
        ,drvGS03_ReceiverID = 'IBIS'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'CT'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = 'RX'
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberQual = ''
        ,drvDTP03_DateTimePeriod = GETDATE()
        ,drvQTY01_QuantityQual1 = 'ET'
        ,drvQTY02_Quantity1 = FORMAT(@EmpCount, '#')
        ,drvQTY01_QuantityQual2 = 'DT'
        ,drvQTY02_Quantity2 = FORMAT(@DepCount, '#')
        ,drvQTY01_QuantityQual3 = 'TO'
        ,drvQTY02_Quantity3 = FORMAT(@EmpCount + @DepCount, '#')
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'United Prairie Bank'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '410250740' --@CmmFedTaxId
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Iowa Bankers Insurance Services'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = 'IBIS'
    INTO dbo.U_EIWABNKMED_HdrTbl
    FROM dbo.U_EIWABNKMED_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2000 RECORDS - INS, REF, DTP Segments
            -- LOOP 2100A RECORDS - NM1, PER, N3, N4, DMG, ICM Segments
            -- LOOP 2100B RECORDS - NM1, DMG Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_EIWABNKMED_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_DrvTbl;
    SELECT DISTINCT
        --=====================
        --LOOP 2000 RECORDS
        --=====================
        drvINS01_YesNoCond = CASE BdmRecType
                                 WHEN 'EMP' THEN 'Y'
                                 ELSE 'N'
                             END
        ,drvINS02_RelationshipCode = CASE WHEN BdmRecType = 'EMP' THEN '18'
                                          ELSE
                                                CASE WHEN ConRelationship IN ('SPS') THEN '01'
                                                    WHEN ConRelationship IN ('DP') THEN '53'
                                                     WHEN ConRelationship IN ('CHL','DCH','DPC','STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode =    /*CASE WHEN @ExportCode LIKE 'OE%' THEN

                                    ELSE
                                        CASE WHEN BdmBenStatus IN ('T','C') THEN '024' ELSE '030' END
                                    END*/
        
        CASE WHEN BdmRecType = 'EMP' THEN '030'
                                        ELSE 
                                            CASE WHEN (SELECT COUNT(DISTINCT BdmBenOption) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmCOID = xCOID AND BdmEEID = xEEID AND BdmRecType = 'DEP') > 1 AND
                                                (SELECT COUNT(BdmBenStatus) FROM dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK) WHERE BdmCOID = xCOID AND BdmEEID = xEEID AND BdmRecType = 'DEP' AND BdmBenStatus <> 'A') > 0 THEN '024' ELSE '030'
                                            END
                                            
                                            --BdmBenStatus IN ('T','C')  THEN '024' ELSE '030' END --Audit or Compare

                                        -- is there a benefit option chagne AAND status goes to T,C (dependent, not employ) then 024,   030
                                    END
                                    -- Hughes*Cynthia
                                    -- CoreSource - loop 2500.
        ,drvINS04_MaintReasonCode = '' --'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = 'FT' /*CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                     WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                END
                                         END*/
        ,drvINS09_StudentStatusCode = '' /*CASE WHEN BdmRecType = 'DEP' THEN
                                                CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
                                      END*/
        ,drvINS10_ResponseCode = CASE /*WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EepIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END*/
                                      WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = 'DX'
        ,drvREF02_RefNumberQual1 =    CASE REPLACE(EecLocation, ' ', '')
                                        WHEN '01' THEN '01-Mt Lake'
                                        WHEN '05' THEN '05-Worthington'
                                        WHEN '08' THEN '08-Jackson'
                                        WHEN '09' THEN '09-Spicer'
                                        WHEN '10' THEN '10-Madison'
                                        WHEN '11' THEN '11-New Ulm'
                                        WHEN '12' THEN '12-Owatonna' 
                                        WHEN '13' THEN '13-Waseca'
                                        WHEN '14' THEN '14-Mankato HT'
                                        WHEN '50' THEN '50-UPIA Springfield'
                                        WHEN '51' THEN '51-UPIA Mt Lake'
                                        WHEN '52' THEN '52-UPIA Lakefield' 
                                        WHEN '53' THEN '53-UPIA Slayton'
                                        WHEN '55' THEN '55-UPIA Worthington'
                                        WHEN '56' THEN '56-UPIA Wilmont'
                                        WHEN '58' THEN '58-UPIA Jackson'
                                        WHEN '59' THEN '59-UPIA Spicer'
                                        WHEN '60' THEN '60-UPIA Madison'
                                        WHEN '61' THEN '61-UPIA New Ulm'
                                        WHEN '62' THEN '62-UPIA Owatonna' 
                                        WHEN '64' THEN '64-UPIA Mkto HT'
                                        WHEN '65' THEN '65-UPIA Admin'
                                        WHEN '66' THEN '66-UPIA Benefits'
                                        WHEN '71' THEN '71-Finance/Ops/IT' 
                                        WHEN '72' THEN '72-HR/Training'
                                        WHEN '73' THEN '73-Loan Admin/Compliance'
                                        WHEN '74' THEN '74-Marketing'
                                        WHEN '83' THEN '83-Executive'
                                        WHEN '84' THEN '84-UPFN'
                                    END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = CASE WHEN BdmRecType = 'EMP' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = EecDateOfLastHire
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN ISNULL(EecDateOfTermination, '') <> '' AND BdmRecType = 'EMP' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier2 = '337'
        ,drvDTP02_DateTimeFormatQual2 = 'D8'
        ,drvDTP03_DateTimePeriod2 = EecDateOfTermination
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END)
        ,drvNM104_NameFirst1 = dbo.dsi_fnRemoveChars('.,/-',
                               CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                    WHEN BdmRecType = 'DEP' THEN ConNameFirst
                               END)
        ,drvNM105_NameMiddleInitial1 = dbo.dsi_fnRemoveChars('.,/-',
                                       CASE WHEN BdmRecType = 'EMP' THEN LEFT(EepNameMiddle,1)
                                            WHEN BdmRecType = 'DEP' THEN LEFT(ConNameMiddle,1)
                                       END)
        ,drvNM106_NamePrefix1 = '' --CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' THEN 
                                        CASE WHEN EepNameSuffix = 'Z' THEN '' ELSE EepNameSuffix END
                                     WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConNameSuffix = 'Z' THEN '' ELSE ConNameSuffix END
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND (ISNULL(EepSSN, '') <> '' OR LEFT(EepSSN, 3) NOT IN ('000', '999')) THEN '34'
                                          WHEN BdmRecType = 'DEP' AND (ISNULL(ConSSN, '') <> '' OR LEFT(ConSSN, 3) NOT IN ('000', '999')) THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepAddressEMail,'') <> '' THEN 'EM' END
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepAddressEMail,'') END
        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber,'') <> '' THEN 'HP' END
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END
        ,drvPER07_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' THEN 'EM' END
        ,drvPER08_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END
        ,drvN301_AddressLine1 = REPLACE(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)  COLLATE Latin1_General_100_BIN2, N'½', N'1 Half')
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = EepAddressZipCode
        ,drvN404_CountryCode = CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                     WHEN BdmRecType = 'DEP' THEN ConGender
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EepMaritalStatus = 'S' THEN 'I' 
                                                    WHEN ISNULL(EepMaritalStatus, '') = '' OR EepMaritalStatus = 'Z' THEN 'U' 
                                                    ELSE EepMaritalStatus END
                                       END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '' END --'7'
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecScheduledWorkHrs) END
        ,drvICM04_LocationID = CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112)
                                            ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
                                        END
                               END
        -- If drvAMT00_AmountQualifierCode1 = 'AMT' is Populated, then Send AMT Segment
        ,drvAMT00_SegmentID1 = ''
        ,drvAMT01_AmountQualifierCode1 = ''
        ,drvAMT02_MonetaryAmount1 = ''
        -- If drvAMT00_AmountQualifierCode2 = 'AMT' is Populated, then Send AMT Segment
        ,drvAMT00_SegmentID2 = ''
        ,drvAMT01_AmountQualifierCode2 = ''
        ,drvAMT02_MonetaryAmount2 = ''
        -- If drvHLH00_SegmentID = 'HLH' is Populated, then Send HLH Segment
        ,drvHLH00_SegmentID = ''
        ,drvHLH01_HealthRelatedCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                           WHEN BdmRecType = 'DEP' THEN
                                                CASE ConIsSmoker
                                                     WHEN 'Y' THEN 'T' --Tobacco Use
                                                     ELSE 'N' --None
                                                END
                                      END
        ,drvHLH02_Height = ''
        ,drvHLH03_Weight1 = ''
        ,drvHLH04_Weight2 = ''
        ,drvHLH05_Description1 = ''
        ,drvHLH06_CurrentHealthConditionCode = ''
        ,drvHLH07_Description2 = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
    INTO dbo.U_EIWABNKMED_DrvTbl
    FROM dbo.U_EIWABNKMED_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_EIWABNKMED_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage =    --CASE WHEN NOT (BdmRecType = 'DEP' AND ConRelationship IN ('SPS', 'DP') AND OldBenOption IS NOT NULL) THEN
                                    --CASE WHEN NOT ( OldBenOption IS NOT NULL) THEN
                                        CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                            WHEN BdmDedType IN ('DEN') THEN 'HD'
                                            WHEN BdmDedType IN ('VIS') THEN 'HD'
                                        END
                                    --END
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN BdmDedCode IN ('427', '430') THEN 'HD20'
                                        WHEN BdmDedCode IN ('428', '431') THEN 'HD35'
                                        WHEN BdmDedCode IN ('426', '429') THEN 'HD55'
                                    END
                                                                    
        ,drvHD05_CoverageLevelCode = CASE WHEN ObOldBenOption IS NOT NULL AND BdmStopDate IS NULL THEN --'!!!!' -- take the vlaue from the audit table -- JCB
                                            CASE WHEN ObOldBenOption IN ('EE') THEN 'EMP'
                                                WHEN ObOldBenOption IN ('EEC') THEN 'ECH'
                                                WHEN ObOldBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                            END
                                        ELSE
                                            CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN
                                                CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                    -- WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                                END
                                            END
                                        END
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 =    CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 
                                            CASE WHEN ObOldBenOption IS NOT NULL AND ObSource = 'Audit' THEN (SELECT TOP 1 audOldValue FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK) WHERE audTableName = 'EmpDed' AND audFieldName = 'EedBenStartDate' AND audAction = 'Update' AND AudRowNo = 1 AND AudOldValue NOT IN ('Z') AND AudNewValue NOT IN ('Z') AND AudEEID = xEEID)
                                            WHEN ObOldBenOption IS NOT NULL AND ObSource = 'HDed' THEN BdmBenStartDate --- '1/1/1900'
                                            ELSE dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
                                            END
                                        END
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL OR ObOldBenOption IS NOT NULL) THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL OR ObOldBenOption IS NOT NULL) THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL OR ObOldBenOption IS NOT NULL) THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 
                                            CASE WHEN BdmBenStopDate IS NOT NULL THEN BdmBenStopDAte
                                                WHEN ObOldBenOption IS NOT NULL AND ObSource = 'Audit' THEN DATEADd(DAY, -1, BdmBenStartDate) 
                                                WHEN ObOldBenOption IS NOT NULL AND ObSource = 'HDed' THEN  '12/31/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) --   '1/1/1900'
                                                ELSE BdmBenStartDate 
                                            END
                                           /* CASE WHEN BdmBenStopDate IS NOT NULL AND OldBenOption IS NULL THEN   BdmBenStopDate 
                                                WHEN OldBenOption IS NOT NULL THEN BdmBenStopDate --  DATEADD(DAY, -1, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)) -- (SELECT TOP 1 audOldValue FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK) WHERE audTableName = 'EmpDed' AND audFieldName = 'EedBenStartDate' AND audAction = 'Update' AND AudRowNo = 1 AND AudOldValue NOT IN ('Z') AND AudNewValue NOT IN ('Z') AND AudEEID = xEEID)
                                            END*/
                                        END 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = CASE WHEN BdmDedType IN ('MED') THEN '' END
        ,drvDTP01_DateTimeQualifier_303 = CASE WHEN BdmDedType IN ('MED') THEN '303' END
        ,drvDTP02_DateTimeFormatQual_303 = CASE WHEN BdmDedType IN ('MED') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_303 = CASE WHEN BdmDedType IN ('MED') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate) END
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        ,drvLS01_LoopIDCode = '' 
        -- If drvLX01_AssignedNumber is Populated, then send LX Segment
        ,drvLX01_AssignedNumber = ''
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment
        ,drvN101_EntityIDCodeSponsor = ''
        ,drvN102_Name = ''
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc = CASE BdmDedType
                                       WHEN 'MED' THEN ''
                                       WHEN 'DEN' THEN ''
                                       WHEN 'VIS' THEN ''
                                  END
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''
        ---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                      + ' ' + BdmDedCode
                      /*CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END */
                      + ' 1' 
                      --+ ' : ' + IsNull(OldBenOption, 'nope') + ' :: ' + IsNull(BdmBenStopDate, 'nope')
    INTO dbo.U_EIWABNKMED_DrvTbl_2300
    FROM dbo.U_EIWABNKMED_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    /*LEFT JOIN (
                SELECT AudEEID, AudKey2 AS AudCOID, AudKey3 AS AudDedCode, AudOldValue AS OldBenOption, AudNewValue AS NewBenOption
                FROM dbo.U_EIWABNKMED_Audit
                WHERE audTableName = 'EmpDed'
                    AND audFieldName = 'EedBenOption'
                    AND audAction = 'Update'
                    AND AudRowNo = 1
                    --AND AudOldValue NOT IN ('Z')
                    --AND AudNewValue NOT IN ('Z')
            ) AS Old_Ben_Option
        ON AudEEID = xEEID
        AND AudCOID = xCOID
        AND AudDedCode = BdmDedCode*/
    LEFT JOIN dbo.U_EIWABNKMED_OldBenOptions WITH (NOLOCK)
        ON ObEEID = xEEID
        AND ObCOID = xCOID
        AND ObDedCode = BdmDedCode
    ;




    INSERT INTO dbo.U_EIWABNKMED_DrvTbl_2300
    SELECT DISTINCT
        drvHD00_HealthCoverage =   --CASE WHEN NOT (BdmRecType = 'DEP' AND ConRelationship IN ('SPS', 'DP') AND ObOldBenOption IS NOT NULL) THEN
                                    CASE WHEN ObOldBenOption IS NOT NULL THEN 
                                    --CASE WHEN NOT ( OldBenOption IS NOT NULL) THEN
                                        CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                            WHEN BdmDedType IN ('DEN') THEN 'HD'
                                            WHEN BdmDedType IN ('VIS') THEN 'HD'
                                        END
                            END
        /*CASE WHEN OldBenOption IS NOT NULL THEN
                                        CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                                WHEN BdmDedType IN ('DEN') THEN 'HD'
                                                WHEN BdmDedType IN ('VIS') THEN 'HD'
                                         END
                                    END*/
        ,drvHD01_MaintTypeCode = '030'
        ,drvHD02_MaintReasonCode =  CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN ObOldBenOption IS NOT NULL THEN
                                        CASE WHEN BdmDedCode IN ('427', '430') THEN 'HD20'
                                            WHEN BdmDedCode IN ('428', '431') THEN 'HD35'
                                            WHEN BdmDedCode IN ('426', '429') THEN 'HD55'
                                        END
                                    END
                                    /*CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END*/
        ,drvHD05_CoverageLevelCode = /*CASE WHEN OldBenOption IS NOT NULL THEN --'!!!!' -- take the vlaue from the audit table -- JCB
                                            CASE WHEN OldBenOption IN ('EE') THEN 'EMP'
                                                WHEN OldBenOption IN ('EEC') THEN 'ECH'
                                                WHEN OldBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                            END
                                        ELSE*/
                                            CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN
                                                CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                    -- WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                                END
                                            END
                                        --END
        
        /*CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN --jcb
                                                CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                    -- WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EES', 'EEDP', 'EEF', 'EEDPF') THEN 'FAM'
                                                END
                                        ELSE '$$$$'
                                     END */
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN ObOldBenOption IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 
        ,drvDTP02_DateTimeFormatQual_348 
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND (BdmBenStopDate IS NOT NULL /*OR OldBenOption IS NOT NULL*/) THEN 'DTP' END -- JCB
        ,drvDTP01_DateTimeQualifier_349
        ,drvDTP02_DateTimeFormatQual_349 
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 
                                            CASE WHEN BdmBenStopDate IS NOT NULL AND ObOldBenOption IS NULL THEN BdmBenStopDate
                                                WHEN ObOldBenOption IS NOT NULL THEN DATEADD(DAY, -1, dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate)) -- (SELECT TOP 1 audOldValue FROM dbo.U_EIWABNKMED_Audit WITH (NOLOCK) WHERE audTableName = 'EmpDed' AND audFieldName = 'EedBenStartDate' AND audAction = 'Update' AND AudRowNo = 1 AND AudOldValue NOT IN ('Z') AND AudNewValue NOT IN ('Z') AND AudEEID = xEEID)
                                            END
                                        END 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303
        ,drvDTP01_DateTimeQualifier_303 
        ,drvDTP02_DateTimeFormatQual_303 
        ,drvDTP03_DateTimePeriod_303 = ''
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = ''
        ,drvREF01_RefNumberQual1 
        ,drvREF02_RefNumberQual1 
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = ''
        ,drvREF01_RefNumberQual2 
        ,drvREF02_RefNumberQual2 
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = ''
        ,drvAMT01_AmountQualifierCode1
        ,drvAMT02_MonetaryAmount1 
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = ''
        ,drvAMT01_AmountQualifierCode2 
        ,drvAMT02_MonetaryAmount2 
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        ,drvLS01_LoopIDCode  
        -- If drvLX01_AssignedNumber is Populated, then send LX Segment
        ,drvLX01_AssignedNumber 
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        -- If drvN101_EntityIDCodeSponsor is Populated, then send N1 Segment
        ,drvN101_EntityIDCodeSponsor = ''
        ,drvN102_Name 
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc 
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode 
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID = ConSystemID
        ,drvSSN 
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                        + ' ' + BdmDedCode
                      /*+ CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END*/
                       + ' 2'
    FROM  dbo.U_EIWABNKMED_DrvTbl_2300
    JOIN dbo.U_dsi_bdm_EIWABNKMED WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCOID = drvCOID
        AND BdmBenStatus = 'A'
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON drvEEID = EepEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
        AND ConSystemID = BdmDepRecID
   /* LEFT*/ /*JOIN (
                SELECT AudEEID, AudKey2 AS AudCOID, AudKey3 AS AudDedCode, AudOldValue AS OldBenOption, AudNewValue AS NewBenOption
                FROM dbo.U_EIWABNKMED_Audit
                WHERE audTableName = 'EmpDed'
                    AND audFieldName = 'EedBenOption'
                    AND audAction = 'Update'
                    AND AudRowNo = 1
                    --AND AudOldValue NOT IN ('Z')
                    --AND AudNewValue NOT IN ('Z')
            ) AS Old_Ben_Option
        ON AudEEID = drvEEID
        AND AudCOID = drvCOID
        AND AudDedCode = BdmDedCode*/
    JOIN dbo.U_EIWABNKMED_OldBenOptions WITH (NOLOCK)
        ON ObEEID = drvEEID
        AND ObCOID = drvCOID
        AND ObDedCode = BdmDedCode
    ;
        

        









    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EIWABNKMED_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EIWABNKMED_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_EIWABNKMED_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EIWABNKMED','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'UPB_EIWABNKMED_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EIWABNKMED';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEIWABNKMED_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EIWABNKMED_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDef
WHERE AdfHeaderSystemID LIKE 'EIWABNKMED%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202010011'
       ,ExpStartPerControl     = '202010011'
       ,ExpLastEndPerControl   = '202010319'
       ,ExpEndPerControl       = '202010319'
WHERE ExpFormatCode = 'EIWABNKMED';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEIWABNKMED_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EIWABNKMED_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)