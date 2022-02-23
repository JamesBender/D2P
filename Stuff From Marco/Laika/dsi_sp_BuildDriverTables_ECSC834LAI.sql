SET NOCOUNT ON;
IF OBJECT_ID('U_ECSC834LAI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ECSC834LAI_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ECSC834LAI' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwECSC834LAI_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwECSC834LAI_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ECSC834LAI') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSC834LAI];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_ECSC834LAI') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_ECSC834LAI];
GO
IF OBJECT_ID('U_ECSC834LAI_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_TrlTbl];
GO
IF OBJECT_ID('U_ECSC834LAI_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_HdrTbl];
GO
IF OBJECT_ID('U_ECSC834LAI_File') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_File];
GO
IF OBJECT_ID('U_ECSC834LAI_EEList') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_EEList];
GO
IF OBJECT_ID('U_ECSC834LAI_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_DrvTbl_2300];
GO
IF OBJECT_ID('U_ECSC834LAI_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_DrvTbl];
GO
IF OBJECT_ID('U_ECSC834LAI_DedList') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ECSC834LAI') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ECSC834LAI];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ECSC834LAI';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ECSC834LAI';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ECSC834LAI';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ECSC834LAI';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ECSC834LAI';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ECSC834LAI','CoreSource 834 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ECSC834LAIZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ECSC834LAI' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISA"','1','(''DA''=''F*'')','ECSC834LAIZ0','3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''F*'')','ECSC834LAIZ0','2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F*'')','ECSC834LAIZ0','10','H','01','3',NULL,'Authorization Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','4','(''DA''=''F*'')','ECSC834LAIZ0','2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F*'')','ECSC834LAIZ0','10','H','01','5',NULL,'Security Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA05_SenderIDQual"','6','(''UA''=''F*'')','ECSC834LAIZ0','2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA06_SenderID"','7','(''UA''=''F*'')','ECSC834LAIZ0','15','H','01','7',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA07_ReceiverIDQual"','8','(''UA''=''F*'')','ECSC834LAIZ0','2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA08_ReceiverID"','9','(''UA''=''F*'')','ECSC834LAIZ0','15','H','01','9',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA09_InterchangeDate"','10','(''UD12''=''F*'')','ECSC834LAIZ0','6','H','01','10',NULL,'Interchange Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA10_InterchangeTime"','11','(''UA''=''F*'')','ECSC834LAIZ0','4','H','01','11',NULL,'Interchange Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"^"','12','(''DA''=''F*'')','ECSC834LAIZ0','1','H','01','12',NULL,'Repetition Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00501"','13','(''DA''=''F*'')','ECSC834LAIZ0','5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','14','(''DA''=''F*'')','ECSC834LAIZ0','9','H','01','14',NULL,'Interchange Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','15','(''DA''=''F*'')','ECSC834LAIZ0','1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA15_UsageIndicator"','16','(''UA''=''F*'')','ECSC834LAIZ0','1','H','01','16',NULL,'Usage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('">"','17','(''DA''=''F*'')','ECSC834LAIZ0','1','H','01','17',NULL,'Component Element Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GS"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BE"','2','(''DA''=''T*'')','ECSC834LAIZ0','2','H','02','2',NULL,'Functional ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS02_SenderID"','3','(''UA''=''T*'')','ECSC834LAIZ0','15','H','02','3',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS03_ReceiverID"','4','(''UA''=''T*'')','ECSC834LAIZ0','15','H','02','4',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS04_Date"','5','(''UD112''=''T*'')','ECSC834LAIZ0','8','H','02','5',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS05_Time"','6','(''UA''=''T*'')','ECSC834LAIZ0','8','H','02','6',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','7','(''DA''=''T*'')','ECSC834LAIZ0','9','H','02','7',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"X"','8','(''DA''=''T*'')','ECSC834LAIZ0','2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','9','(''DA''=''T*'')','ECSC834LAIZ0','12','H','02','9',NULL,'Version/Release  Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ST"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"834"','2','(''DA''=''T*'')','ECSC834LAIZ0','3','H','03','2',NULL,'Transaction ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ECSC834LAIZ0','9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','4','(''DA''=''T*'')','ECSC834LAIZ0','35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BGN"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''T*'')','ECSC834LAIZ0','2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ECSC834LAIZ0','50','H','04','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN03_Date"','4','(''UD112''=''T*'')','ECSC834LAIZ0','8','H','04','4',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN04_Time"','5','(''UA''=''T*'')','ECSC834LAIZ0','8','H','04','5',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN05_TimeCode"','6','(''UA''=''T*'')','ECSC834LAIZ0','2','H','04','6',NULL,'Time Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN06_RefID"','7','(''UA''=''T*'')','ECSC834LAIZ0','50','H','04','7',NULL,'Reference Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN07_TransTypeCode"','8','(''UA''=''T*'')','ECSC834LAIZ0','2','H','04','8',NULL,'Transaction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN08_ActionCode"','9','(''UA''=''T*'')','ECSC834LAIZ0','2','H','04','9',NULL,'Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual"','3','(''UA''=''T*'')','ECSC834LAIZ0','50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','H','06','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual1"','2','(''UA''=''T*'')','ECSC834LAIZ0','2','H','06','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity1"','3','(''UA''=''T*'')','ECSC834LAIZ0','15','H','06','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual2"','2','(''UA''=''T*'')','ECSC834LAIZ0','2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity2"','3','(''UA''=''T*'')','ECSC834LAIZ0','15','H','07','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual3"','2','(''UA''=''T*'')','ECSC834LAIZ0','2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity3"','3','(''UA''=''T*'')','ECSC834LAIZ0','15','H','08','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','H','09','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor1"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','H','09','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name1"','3','(''UA''=''T*'')','ECSC834LAIZ0','60','H','09','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual1"','4','(''UA''=''T*'')','ECSC834LAIZ0','2','H','09','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode1"','5','(''UA''=''T*'')','ECSC834LAIZ0','80','H','09','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','H','10','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor2"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','H','10','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name2"','3','(''UA''=''T*'')','ECSC834LAIZ0','60','H','10','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual2"','4','(''UA''=''T*'')','ECSC834LAIZ0','2','H','10','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode2"','5','(''UA''=''T*'')','ECSC834LAIZ0','80','H','10','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INS"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','11','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS01_YesNoCond"','2','(''UA''=''T*'')','ECSC834LAIZ0','1','D','11','2',NULL,'Yes/No Condition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS02_RelationshipCode"','3','(''UA''=''T*'')','ECSC834LAIZ0','2','D','11','3',NULL,'Individual Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS03_MaintTypeCode"','4','(''UA''=''T*'')','ECSC834LAIZ0','3','D','11','4',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS04_MaintReasonCode"','5','(''UA''=''T*'')','ECSC834LAIZ0','3','D','11','5',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS05_BenefitStatusCode"','6','(''UA''=''T*'')','ECSC834LAIZ0','1','D','11','6',NULL,'Benefit Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0601_MEDICAREPLANCODE"','7','(''UA''=''T'')','ECSC834LAIZ0','1','D','11','7',NULL,'MEDICARE PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0602_EligibilityRsnCode"','8','(''UA''=''T*'')','ECSC834LAIZ0','1','D','11','8',NULL,'Eligibility Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS07_COBRAQualEventCode"','9','(''UA''=''T*'')','ECSC834LAIZ0','2','D','11','9',NULL,'COBRA Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS08_EmploymentStatusCode"','10','(''UA''=''T*'')','ECSC834LAIZ0','2','D','11','10',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS09_StudentStatusCode"','11','(''UA''=''T*'')','ECSC834LAIZ0','1','D','11','11',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS10_ResponseCode"','12','(''UA''=''T*'')','ECSC834LAIZ0','1','D','11','12',NULL,'Response Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS11_DateTimeFormatQual"','13','(''UA''=''T*'')','ECSC834LAIZ0','3','D','11','13',NULL,'Date Time Period Format Qualif',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS12_DateTimePeriod"','14','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','11','14',NULL,'Date Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','12','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0F"','2','(''DA''=''T*'')','ECSC834LAIZ0','3','D','12','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T*'')','ECSC834LAIZ0','50','D','12','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','13','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','13','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','ECSC834LAIZ0','50','D','13','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','ECSC834LAIZ0','50','D','14','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime1"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','15','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier1"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','15','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual1"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','15','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod1"','4','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','15','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime2"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','16','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier2"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','16','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual2"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','16','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod2"','4','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','16','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NM1"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','20','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IL"','2','(''DA''=''T*'')','ECSC834LAIZ0','3','D','20','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','3','(''DA''=''T*'')','ECSC834LAIZ0','1','D','20','3',NULL,'Entity Type Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM103_NameLast1"','4','(''UA''=''T*'')','ECSC834LAIZ0','60','D','20','4',NULL,'Name Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM104_NameFirst1"','5','(''UA''=''T*'')','ECSC834LAIZ0','35','D','20','5',NULL,'Name First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM105_NameMiddleInitial1"','6','(''UA''=''T*'')','ECSC834LAIZ0','25','D','20','6',NULL,'Name Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM106_NamePrefix1"','7','(''UA''=''T*'')','ECSC834LAIZ0','10','D','20','7',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM107_NameSuffix1"','8','(''UA''=''T*'')','ECSC834LAIZ0','10','D','20','8',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM108_IDCodeQualifier1"','9','(''UA''=''T*'')','ECSC834LAIZ0','2','D','20','9',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM109_IDCode1"','10','(''UA''=''T*'')','ECSC834LAIZ0','80','D','20','10',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','21','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IP"','2','(''DA''=''T*'')','ECSC834LAIZ0','2','D','21','2',NULL,'Contact Function Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER02_Name"','3','(''UA''=''T*'')','ECSC834LAIZ0','60','D','21','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER03_CommNumberQualifier"','4','(''UA''=''T*'')','ECSC834LAIZ0','3','D','21','4',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER04_CommunicationNumber"','5','(''UA''=''T*'')','ECSC834LAIZ0','256','D','21','5',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER05_CommNumberQualifier"','6','(''UA''=''T*'')','ECSC834LAIZ0','3','D','21','6',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER06_CommunicationNumber"','7','(''UA''=''T*'')','ECSC834LAIZ0','256','D','21','7',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER07_CommNumberQualifier"','8','(''UA''=''T*'')','ECSC834LAIZ0','3','D','21','8',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER08_CommunicationNumber"','9','(''UA''=''T*'')','ECSC834LAIZ0','256','D','21','9',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N3"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','D','22','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN301_AddressLine1"','2','(''UA''=''T*'')','ECSC834LAIZ0','55','D','22','2',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN302_AddressLine2"','3','(''UA''=''T*'')','ECSC834LAIZ0','55','D','22','3',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N4"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','D','23','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN401_City"','2','(''UA''=''T*'')','ECSC834LAIZ0','30','D','23','2',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN402_State"','3','(''UA''=''T*'')','ECSC834LAIZ0','2','D','23','3',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN403_Zip"','4','(''UA''=''T*'')','ECSC834LAIZ0','15','D','23','4',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN404_CountryCode"','5','(''UA''=''T*'')','ECSC834LAIZ0','3','D','23','5',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMG"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','24','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D8"','2','(''DA''=''T*'')','ECSC834LAIZ0','3','D','24','2',NULL,'Date/Time Format Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG02_DateTimePeriod1"','3','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','24','3',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG03_GenderCode1"','4','(''UA''=''T*'')','ECSC834LAIZ0','1','D','24','4',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG04_MaritalStatusCode1"','5','(''UA''=''T*'')','ECSC834LAIZ0','1','D','24','5',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ICM"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','25','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM01_FrequencyCode"','2','(''UA''=''T*'')','ECSC834LAIZ0','1','D','25','2',NULL,'Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM02_MonetaryAmount"','3','(''UA''=''T*'')','ECSC834LAIZ0','18','D','25','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM03_Quantity"','4','(''UA''=''T*'')','ECSC834LAIZ0','15','D','25','4',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM04_LocationID"','5','(''UA''=''T*'')','ECSC834LAIZ0','30','D','25','5',NULL,'Location Identifier Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID1"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','26','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','ECSC834LAIZ0','18','D','26','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','ECSC834LAIZ0','1','D','26','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID2"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','27','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','ECSC834LAIZ0','18','D','27','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','ECSC834LAIZ0','1','D','27','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH00_SegmentID"','1','(''UA''=''T*'')','ECSC834LAIZ0','1','D','28','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH01_HealthRelatedCode"','2','(''UA''=''T*'')','ECSC834LAIZ0','8','D','28','2',NULL,'Health-Related Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH02_Height"','3','(''UA''=''T*'')','ECSC834LAIZ0','10','D','28','3',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH03_Weight1"','4','(''UA''=''T*'')','ECSC834LAIZ0','10','D','28','4',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH04_Weight2"','5','(''UA''=''T*'')','ECSC834LAIZ0','10','D','28','5',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH05_Description1"','6','(''UA''=''T*'')','ECSC834LAIZ0','10','D','28','6',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH06_CurrentHealthConditionCode"','7','(''UA''=''T*'')','ECSC834LAIZ0','10','D','28','7',NULL,'Current Health Condition Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH07_Description2"','8','(''UA''=''T*'')','ECSC834LAIZ0','10','D','28','8',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD00_HealthCoverage"','1','(''UA''=''T*'')','ECSC834LAIZ0','2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD01_MaintTypeCode"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD02_MaintReasonCode"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD03_InsuranceLineCode"','4','(''UA''=''T*'')','ECSC834LAIZ0','3','D','40','4',NULL,'Insurance Line Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD04_PlanCoverageDesc"','5','(''UA''=''T*'')','ECSC834LAIZ0','50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD05_CoverageLevelCode"','6','(''UA''=''T*'')','ECSC834LAIZ0','3','D','40','6',NULL,'Coverage Level Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_348"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_348"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_348"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','41','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_348"','4','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','41','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_349"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_349"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_349"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','42','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_349"','4','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','42','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_303"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_303"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_303"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','43','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_303"','4','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','43','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual1"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','ECSC834LAIZ0','50','D','45','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual2"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','ECSC834LAIZ0','50','D','46','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode1"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','ECSC834LAIZ0','18','D','50','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode2"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','ECSC834LAIZ0','18','D','51','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_Coverage"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','52','1',NULL,'HD Segment ID (Loop 2500) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_MaintTypeCode"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','52','2',NULL,'Maintenance Type Code (2500)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_FSA_SelectionCode"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','52','3',NULL,'Flexible Spending Account Selection',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_ReasonCode"','4','(''UA''=''T*'')','ECSC834LAIZ0','3','D','52','4',NULL,'Reason Code (2500)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_AccountNumber"','5','(''UA''=''T*'')','ECSC834LAIZ0','3','D','52','5',NULL,'Account Number (2500)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_FrequencyCode"','6','(''UA''=''T*'')','ECSC834LAIZ0','1','D','52','6',NULL,'Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_PlanCoverageDesc"','7','(''UA''=''T*'')','ECSC834LAIZ0','50','D','52','7',NULL,'Plan Coverage Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_ProductOptionCode"','8','(''UA''=''T*'')','ECSC834LAIZ0','1','D','52','8',NULL,'Production Option Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFSA00_AmountQualifierCode1"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','53','1',NULL,'AMT Segment ID (Loop 2500) - FSA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMTFSA01_AmountQualifierCode1"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','53','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMTFSA02_MonetaryAmount1"','3','(''UA''=''T*'')','ECSC834LAIZ0','18','D','53','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00FSA_DateTime_348"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','54','1',NULL,'DTP Segment ID (Loop 2500) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01FSA_DateTimeQualifier_348"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','54','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02FSA_DateTimeFormatQual_348"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','54','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03FSA_DateTimePeriod_348"','4','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','54','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00FSA_DateTime_349"','1','(''UA''=''T*'')','ECSC834LAIZ0','3','D','55','1',NULL,'DTP Segment ID (Loop 2500) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01FSA_DateTimeQualifier_349"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','55','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02FSA_DateTimeFormatQual_349"','3','(''UA''=''T*'')','ECSC834LAIZ0','3','D','55','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03FSA_DateTimePeriod_349"','4','(''UD112''=''T*'')','ECSC834LAIZ0','35','D','55','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LS"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLS01_LoopIDCode"','2','(''UA''=''T*'')','ECSC834LAIZ0','6','D','80','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LX"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLX01_AssignedNumber"','2','(''UA''=''T*'')','ECSC834LAIZ0','6','D','81','2',NULL,'Assigned Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name"','3','(''UA''=''T*'')','ECSC834LAIZ0','60','D','85','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','ECSC834LAIZ0','3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberDesc"','3','(''UA''=''T*'')','ECSC834LAIZ0','50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LE"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLE01_LoopIDCode"','2','(''UA''=''T*'')','ECSC834LAIZ0','6','D','87','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SE"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSE01_SegmentCount"','2','(''UA''=''T*'')','ECSC834LAIZ0','10','T','90','2',NULL,'Number of Included Segments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ECSC834LAIZ0','9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GE"','1','(''DA''=''T*'')','ECSC834LAIZ0','2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','ECSC834LAIZ0','6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ECSC834LAIZ0','9','T','91','3',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IEA"','1','(''DA''=''T*'')','ECSC834LAIZ0','3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','ECSC834LAIZ0','5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','3','(''DA''=''T*'')','ECSC834LAIZ0','9','T','92','3',NULL,'Interchange Control Number',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ECSC834LAI_20201013.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Changes Only File','201909139','EMPEXPORT','CHANGES','Nov  6 2019 11:55AM','ECSC834LAI',NULL,NULL,NULL,'201909139','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','201909131','6392','','','201909131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Full File Only','201911149','EMPEXPORT','FULLFILE','Nov 14 2019  2:23PM','ECSC834LAI',NULL,NULL,NULL,'201911149','Nov 14 2019 12:00AM','Dec 30 1899 12:00AM','201911011','5762','','','201911011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment','201910019','EMPEXPORT','OEACTIVE','Sep 18 2019  3:40PM','ECSC834LAI',NULL,NULL,NULL,'201910019','Oct  1 2019 12:00AM','Dec 30 1899 12:00AM','201910011','2108','','','201910011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment','201909139','EMPEXPORT','OEPASSIVE','Oct  1 2018 12:00AM','ECSC834LAI',NULL,NULL,NULL,'201909139','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','201909131',NULL,'','','201909131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'CoreSource 834 Export','201909139','EMPEXPORT','SCH_CORLA','Nov 14 2019  2:27PM','ECSC834LAI',NULL,NULL,NULL,'201909139','Sep 13 2019 12:00AM','Dec 30 1899 12:00AM','201909131','6233','','','201909131',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ECSC834LAI','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ECSC834LAI' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ECSC834LAI' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ECSC834LAI_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ECSC834LAI_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H01','U_ECSC834LAI_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H02','U_ECSC834LAI_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H03','U_ECSC834LAI_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H04','U_ECSC834LAI_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H05','U_ECSC834LAI_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H06','U_ECSC834LAI_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H07','U_ECSC834LAI_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H08','U_ECSC834LAI_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H09','U_ECSC834LAI_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','H10','U_ECSC834LAI_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D11','U_ECSC834LAI_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D12','U_ECSC834LAI_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D13','U_ECSC834LAI_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D14','U_ECSC834LAI_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D15','U_ECSC834LAI_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D16','U_ECSC834LAI_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D20','U_ECSC834LAI_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D21','U_ECSC834LAI_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D22','U_ECSC834LAI_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D23','U_ECSC834LAI_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D24','U_ECSC834LAI_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D25','U_ECSC834LAI_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D26','U_ECSC834LAI_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D27','U_ECSC834LAI_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D28','U_ECSC834LAI_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D40','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D41','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D42','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D43','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D45','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D46','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D50','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D51','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D52','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvFSA00_Coverage,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D53','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvFSA00_Coverage,'''') <> '''' AND ISNULL(drvFSA00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D54','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvFSA00_Coverage,'''') <> '''' AND ISNULL(drvDTP00FSA_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D55','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvFSA00_Coverage,'''') <> '''' AND ISNULL(drvDTP00FSA_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D80','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D81','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D85','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D86','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','D87','U_ECSC834LAI_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','T90','U_ECSC834LAI_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','T91','U_ECSC834LAI_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ECSC834LAI','T92','U_ECSC834LAI_TrlTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ECSC834LAI') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ECSC834LAI] (
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
IF OBJECT_ID('U_ECSC834LAI_DedList') IS NULL
CREATE TABLE [dbo].[U_ECSC834LAI_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ECSC834LAI_DrvTbl') IS NULL
CREATE TABLE [dbo].[U_ECSC834LAI_DrvTbl] (
    [drvINS01_YesNoCond] varchar(1) NOT NULL,
    [drvINS02_RelationshipCode] varchar(2) NOT NULL,
    [drvINS03_MaintTypeCode] varchar(3) NOT NULL,
    [drvINS04_MaintReasonCode] varchar(2) NULL,
    [drvINS05_BenefitStatusCode] varchar(1) NOT NULL,
    [drvINS0601_MEDICAREPLANCODE] varchar(1) NOT NULL,
    [drvINS0602_EligibilityRsnCode] varchar(1) NOT NULL,
    [drvINS07_COBRAQualEventCode] varchar(1) NOT NULL,
    [drvINS08_EmploymentStatusCode] varchar(2) NULL,
    [drvINS09_StudentStatusCode] varchar(1) NULL,
    [drvINS10_ResponseCode] varchar(1) NULL,
    [drvINS11_DateTimeFormatQual] varchar(2) NULL,
    [drvINS12_DateTimePeriod] varchar(8) NULL,
    [drvREF01_RefNumberQual1] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual1] varchar(32) NOT NULL,
    [drvREF01_RefNumberQual2] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual2] char(11) NULL,
    [drvDTP00_DateTime1] varchar(3) NOT NULL,
    [drvDTP01_DateTimeQualifier1] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual1] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod1] datetime NULL,
    [drvDTP00_DateTime2] varchar(1) NOT NULL,
    [drvDTP01_DateTimeQualifier2] varchar(1) NOT NULL,
    [drvDTP02_DateTimeFormatQual2] varchar(1) NOT NULL,
    [drvDTP03_DateTimePeriod2] varchar(1) NOT NULL,
    [drvNM103_NameLast1] varchar(6000) NULL,
    [drvNM104_NameFirst1] varchar(6000) NULL,
    [drvNM105_NameMiddleInitial1] varchar(6000) NULL,
    [drvNM106_NamePrefix1] varchar(30) NULL,
    [drvNM107_NameSuffix1] varchar(30) NULL,
    [drvNM108_IDCodeQualifier1] varchar(2) NULL,
    [drvNM109_IDCode1] char(11) NULL,
    [drvPER02_Name] varchar(1) NOT NULL,
    [drvPER03_CommNumberQualifier] varchar(2) NULL,
    [drvPER04_CommunicationNumber] varchar(50) NULL,
    [drvPER05_CommNumberQualifier] varchar(2) NULL,
    [drvPER06_CommunicationNumber] varchar(50) NULL,
    [drvPER07_CommNumberQualifier] varchar(2) NULL,
    [drvPER08_CommunicationNumber] varchar(50) NULL,
    [drvN301_AddressLine1] varchar(6000) NULL,
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
IF OBJECT_ID('U_ECSC834LAI_DrvTbl_2300') IS NULL
CREATE TABLE [dbo].[U_ECSC834LAI_DrvTbl_2300] (
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
    [drvAMT00_AmountQualifierCode1] varchar(3) NULL,
    [drvAMT01_AmountQualifierCode1] varchar(2) NULL,
    [drvAMT02_MonetaryAmount1] money NULL,
    [drvAMT00_AmountQualifierCode2] varchar(1) NULL,
    [drvAMT01_AmountQualifierCode2] varchar(1) NULL,
    [drvAMT02_MonetaryAmount2] varchar(1) NULL,
    [drvFSA00_Coverage] varchar(3) NULL,
    [drvFSA00_MaintTypeCode] varchar(3) NULL,
    [drvFSA00_ReasonCode] varchar(1) NOT NULL,
    [drvFSA00_AccountNumber] varchar(1) NOT NULL,
    [drvFSA00_FSA_SelectionCode] varchar(1) NULL,
    [drvFSA00_FrequencyCode] varchar(1) NOT NULL,
    [drvFSA00_PlanCoverageDesc] varchar(3) NULL,
    [drvFSA00_ProductOptionCode] varchar(1) NOT NULL,
    [drvFSA00_AmountQualifierCode1] varchar(3) NULL,
    [drvAMTFSA01_AmountQualifierCode1] varchar(2) NULL,
    [drvAMTFSA02_MonetaryAmount1] money NULL,
    [drvDTP00FSA_DateTime_348] varchar(3) NULL,
    [drvDTP01FSA_DateTimeQualifier_348] varchar(3) NULL,
    [drvDTP02FSA_DateTimeFormatQual_348] varchar(2) NULL,
    [drvDTP03FSA_DateTimePeriod_348] datetime NULL,
    [drvDTP00FSA_DateTime_349] varchar(3) NULL,
    [drvDTP01FSA_DateTimeQualifier_349] varchar(3) NULL,
    [drvDTP02FSA_DateTimeFormatQual_349] varchar(2) NULL,
    [drvDTP03FSA_DateTimePeriod_349] datetime NULL,
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
    [drvSubSort] varchar(23) NULL
);
IF OBJECT_ID('U_ECSC834LAI_EEList') IS NULL
CREATE TABLE [dbo].[U_ECSC834LAI_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ECSC834LAI_File') IS NULL
CREATE TABLE [dbo].[U_ECSC834LAI_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ECSC834LAI_HdrTbl') IS NULL
CREATE TABLE [dbo].[U_ECSC834LAI_HdrTbl] (
    [drvISA05_SenderIDQual] varchar(2) NOT NULL,
    [drvISA06_SenderID] varchar(9) NOT NULL,
    [drvISA07_ReceiverIDQual] varchar(2) NOT NULL,
    [drvISA08_ReceiverID] varchar(11) NOT NULL,
    [drvISA09_InterchangeDate] varchar(6) NULL,
    [drvISA10_InterchangeTime] varchar(4) NULL,
    [drvISA15_UsageIndicator] varchar(1) NOT NULL,
    [drvGS02_SenderID] varchar(9) NOT NULL,
    [drvGS03_ReceiverID] varchar(11) NOT NULL,
    [drvGS04_Date] varchar(8) NULL,
    [drvGS05_Time] varchar(4) NULL,
    [drvBGN03_Date] varchar(8) NULL,
    [drvBGN04_Time] varchar(4) NULL,
    [drvBGN05_TimeCode] varchar(1) NOT NULL,
    [drvBGN06_RefID] varchar(1) NOT NULL,
    [drvBGN07_TransTypeCode] varchar(1) NOT NULL,
    [drvBGN08_ActionCode] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual] varchar(4) NOT NULL,
    [drvQTY01_QuantityQual1] varchar(1) NOT NULL,
    [drvQTY02_Quantity1] varchar(1) NOT NULL,
    [drvQTY01_QuantityQual2] varchar(1) NOT NULL,
    [drvQTY02_Quantity2] varchar(1) NOT NULL,
    [drvQTY01_QuantityQual3] varchar(1) NOT NULL,
    [drvQTY02_Quantity3] varchar(1) NOT NULL,
    [drvN101_EntityIDCodeSponsor1] varchar(2) NOT NULL,
    [drvN102_Name1] varchar(5) NOT NULL,
    [drvN103_IDCodeQual1] varchar(2) NOT NULL,
    [drvN104_IDCode1] varchar(9) NOT NULL,
    [drvN101_EntityIDCodeSponsor2] varchar(2) NOT NULL,
    [drvN102_Name2] varchar(11) NOT NULL,
    [drvN103_IDCodeQual2] varchar(2) NOT NULL,
    [drvN104_IDCode2] varchar(9) NOT NULL
);
IF OBJECT_ID('U_ECSC834LAI_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_ECSC834LAI_TrlTbl] (
    [drvSE01_SegmentCount] varchar(4) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_ECSC834LAI]  
AS  
SET NOCOUNT ON;  
/************************************************************  
Client: Laika 
  
Created By: Marco Lagrosa  
Create Date: @CreateDate  
ChangePoint Request Number: TekP-2020-09-17-0001  
  
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
    WHILE (SELECT COUNT(*) FROM dbo.U_ECSC834LAI_File WHERE RIGHT(DATA,2) = '*~') > 0  
    BEGIN  
        UPDATE dbo.U_ECSC834LAI_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';  
    END;  
  
    --========================================  
    -- Remove Extra Records from PER Segment  
    --========================================  
    UPDATE dbo.U_ECSC834LAI_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';  
    UPDATE dbo.U_ECSC834LAI_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';  
    UPDATE dbo.U_ECSC834LAI_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';  
  
    --====================================  
    -- Update Record Count in SE Segment  
    --====================================  
    DECLARE @RecordCount INT;  
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_ECSC834LAI_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));  
  
    UPDATE dbo.U_ECSC834LAI_File  
    SET Data = REPLACE(Data,'9999',@RecordCount)  
    WHERE LEFT(Data,2) = 'SE';  
  
END  
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ECSC834LAI] 
 
    @systemid CHAR(12) 
 
AS 
 
SET NOCOUNT ON; 
 
/********************************************************************************** 
 
Client: Laika
 
 
 
Created By: Marco Lagrosa 
 
Business Analyst: Lea King 
 
Create Date: 10/12/2020
 
Service Request Number: TekP-2020-09-17-0001 
 
 
 
Purpose: CoreSource 834 Export 
 
 
 
Revision History 
 
---------------- 
 
Update By           Date           Request Num        Desc 
 
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX 
 
 
 
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ECSC834LAI'; 
 
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ECSC834LAI'; 
 
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ECSC834LAI'; 
 
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ECSC834LAI'; 
 
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ECSC834LAI' ORDER BY RunID DESC; 
 
 
 
Execute Export 
 
-------------- 
 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSC834LAI', 'FULLFILE'; 
 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSC834LAI', 'CHANGES'; 
 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSC834LAI', 'OEPASSIVE'; 
 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSC834LAI', 'OEACTIVE'; 
 
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ECSC834LAI', 'SCHEDULED'; 
 
 
 
EXEC dbo.dsi_BDM_sp_ErrorCheck 'ECSC834LAI'; 
 
 
 
EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ECSC834LAI', @AllObjects = 'Y', @IsWeb = 'Y'; 
 
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
 
        ,@FileMinCovDate  = CAST('01/01/2021' as datetime)
 
    FROM dbo.U_dsi_Parameters WITH (NOLOCK) 
 
    WHERE FormatCode = 'ECSC834LAI'; 
 
 
 
    --========================================== 
 
    -- Deduction Code List 
 
    --========================================== 
 
    DECLARE @DedList VARCHAR(MAX); 
 
    SET @DedList = 'DNHMO,DNPPO,DCFSA,HCFSA,MDHDP,MDPPO'; 
 
 
 
    IF OBJECT_ID('U_ECSC834LAI_DedList','U') IS NOT NULL 
 
        DROP TABLE dbo.U_ECSC834LAI_DedList; 
 
    SELECT DedCode = DedDedCode 
 
        ,DedLongDesc 
 
        ,DedType = DedDedType 
 
    INTO dbo.U_ECSC834LAI_DedList 
 
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList) 
 
    JOIN dbo.DedCode WITH (NOLOCK) 
 
        ON DedDedCode = Item; 
 
 
 
    --========================================== 
 
    -- Clean EE List 
 
    --========================================== 
 
 
 
    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company 
 
    DELETE FROM dbo.U_ECSC834LAI_EEList 
 
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID) 
 
    AND xEEID IN (SELECT xEEID FROM dbo.U_ECSC834LAI_EEList GROUP BY xEEID HAVING COUNT(1) > 1); 
 
 
 
    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List 
 
    DELETE FROM dbo.U_ECSC834LAI_EEList 
 
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_ECSC834LAI_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID); 

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
 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS,DP,HUS,WIF'); 
 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, STD, DPC, DCH'); 
 
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV'); 
 
 
 
    --Set if OE 
 
    IF @ExportCode LIKE '%PASSIVE' 
 
    BEGIN 
 
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE'); 
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','N'); 
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','Y'); 
 
    END; 
 
 
 
    IF @ExportCode LIKE '%ACTIVE' 
 
    BEGIN 
 
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE'); 
 
    END; 
 
 
 
    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode; 
 
 
 
    --========================================= 
 
    -- Update BdmChangeReason For Dependents 
 
    --========================================= 
 
    UPDATE D 
 
        SET D.BdmChangeReason = E.BdmChangeReason 
 
    FROM dbo.U_dsi_bdm_ECSC834LAI D 
 
    JOIN dbo.U_dsi_bdm_ECSC834LAI E 
 
        ON E.BdmEEID = D.BdmEEID 
 
        AND E.BdmCOID = D.BdmCOID 
 
        AND E.BdmDedCode = D.BdmDedCode 
 
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP'; 
 
 
 
    --===================================================== 
 
    -- Update BdmUSGField2 with EmpDedTVID for Employees 
 
    --===================================================== 
 
    UPDATE dbo.U_dsi_bdm_ECSC834LAI 
 
        SET BdmUSGField2 = EedEmpDedTVID 
 
    FROM dbo.U_dsi_bdm_ECSC834LAI 
 
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK) 
 
        ON EedEEID = BdmEEID 
 
        AND EedCOID = BdmCOID 
 
        AND EedDedCode = BdmDedCode 
 
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y'; 
 
 
 
    --======================================================= 
 
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents 
 
    --======================================================= 
 
    UPDATE dbo.U_dsi_bdm_ECSC834LAI 
 
        SET BdmUSGField2 = DbnDepBPlanTVID 
 
    FROM dbo.U_dsi_bdm_ECSC834LAI 
 
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK) 
 
        ON DbnEEID = BdmEEID 
 
        AND DbnCOID = BdmCOID 
 
        AND DbnDedCode = BdmDedCode 
 
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y'; 
 
 
 
    --====================================================== 
 
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt) 
 
    --====================================================== 
 
    UPDATE dbo.U_dsi_bdm_ECSC834LAI 
 
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt) 
 
    FROM dbo.U_dsi_bdm_ECSC834LAI 
 
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
 
 
 
    ------------------- 
 
    -- HEADER RECORD  
 
    ------------------- 
 
    IF OBJECT_ID('U_ECSC834LAI_HdrTbl','U') IS NOT NULL 
 
        DROP TABLE dbo.U_ECSC834LAI_HdrTbl; 
 
    SELECT DISTINCT drvISA05_SenderIDQual = 'ZZ' 
 
        ,drvISA06_SenderID = '222586619' 
 
        ,drvISA07_ReceiverIDQual = '30' 
 
        ,drvISA08_ReceiverID = 'TRUSTMARKHB' 
 
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6) 
 
        ,drvISA10_InterchangeTime = @RunTime 
 
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END 
 
        ,drvGS02_SenderID = '222586619' 
 
        ,drvGS03_ReceiverID = 'TRUSTMARKHB' 
 
        ,drvGS04_Date = @RunDate 
 
        ,drvGS05_Time = @RunTime 
 
        ,drvBGN03_Date = @RunDate 
 
        ,drvBGN04_Time = @RunTime 
 
        ,drvBGN05_TimeCode = '' 
 
        ,drvBGN06_RefID = '' 
 
        ,drvBGN07_TransTypeCode = '' 
 
        ,drvBGN08_ActionCode = '4' 
 
        ,drvREF01_RefNumberQual = '38' 
 
        ,drvREF02_RefNumberQual = '1389' 
 
        ,drvQTY01_QuantityQual1 = '' 
 
        ,drvQTY02_Quantity1 = '' 
 
        ,drvQTY01_QuantityQual2 = '' 
 
        ,drvQTY02_Quantity2 = '' 
 
        ,drvQTY01_QuantityQual3 = '' 
 
        ,drvQTY02_Quantity3 = '' 
 
        ,drvN101_EntityIDCodeSponsor1 = 'P5' 
 
        ,drvN102_Name1 = 'LAIKA' 
 
        ,drvN103_IDCodeQual1 = 'FI' 
 
        ,drvN104_IDCode1 = '930851504' 
 
        ,drvN101_EntityIDCodeSponsor2 = 'IN' 
 
        ,drvN102_Name2 = 'TRUSTMARKHB' 
 
        ,drvN103_IDCodeQual2 = 'FI' 
 
        ,drvN104_IDCode2 = '222586619' 
 
    INTO dbo.U_ECSC834LAI_HdrTbl 
 
    FROM dbo.U_ECSC834LAI_EELIST WITH (NOLOCK) 
 
    JOIN dbo.U_dsi_bdm_ECSC834LAI WITH (NOLOCK) 
 
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
 
    IF OBJECT_ID('U_ECSC834LAI_DrvTbl','U') IS NOT NULL 
 
        DROP TABLE dbo.U_ECSC834LAI_DrvTbl; 
 
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
 
                                               CASE WHEN ConRelationship IN ('SP') THEN '01' 
                                                     WHEN ConRelationship IN ('CH', 'CD', 'DC', 'DD' ) THEN '19' 
                                                     WHEN ConRelationship IN ('QO') THEN '38' 
                                                     ELSE '19' 
                                                END  
 
                                     END 
 
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare 
 
        ,drvINS04_MaintReasonCode = CASE WHEN BdmRecType = 'EMP' THEN  
 
                                            CASE WHEN EecTermReason IN ('203') THEN '03' 
                                                 WHEN EecTermReason IN ('202') THEN '04' 
                                                 WHEN EecTermReason IN ('210') THEN '06' 
                                                 WHEN EecTermType IN ('V') and eectermreason not in ('202') THEN '16'
                                                 WHEN EecTermType IN ('I') and eectermreason not in ('203' ,'210') THEN '17'
                                                 WHEN (Select top 1 BdmChangeReason  from U_dsi_bdm_ECSC834LAI where bdmeeid = xeeid )  IN ('203') THEN '20' 
                                                 WHEN (Select top 1 BdmChangeReason  from U_dsi_bdm_ECSC834LAI where bdmeeid = xeeid )  IN ('OE') THEN '26' 
                                                 WHEN (Select top 1 BdmChangeReason  from U_dsi_bdm_ECSC834LAI where bdmeeid = xeeid )  IN ('207') THEN '33' 

 
                                                 ELSE '16' 
 
                                            END 
 
                                     WHEN BdmRecType = 'DEP' THEN 
 
                                            CASE WHEN (Select top 1 BdmChangeReason  from U_dsi_bdm_ECSC834LAI where bdmeeid = xeeid )  IN ('204','LEVNT4') THEN '01' 
 
                                                 WHEN (Select top 1 BdmChangeReason  from U_dsi_bdm_ECSC834LAI where bdmeeid = xeeid )  IN ('210','300') THEN '03' 
 
                                                 WHEN (Select top 1 BdmChangeReason  from U_dsi_bdm_ECSC834LAI where bdmeeid = xeeid )  IN ('201') THEN '07' 
 
                                                 --WHEN BdmChangeReason IN ('210') THEN '11' 
 
                                                 WHEN (Select top 1 BdmChangeReason  from U_dsi_bdm_ECSC834LAI where bdmeeid = xeeid )  IN ('OE') THEN '26' 
 
                                            END 
 
                                     END 
 
        ,drvINS05_BenefitStatusCode = 'A' 
 
        ,drvINS0601_MEDICAREPLANCODE = '' 
 
        ,drvINS0602_EligibilityRsnCode = '' 
 
        ,drvINS07_COBRAQualEventCode = '' 
 
        ,drvINS08_EmploymentStatusCode = CASE WHEN BdmRecType = 'EMP' THEN 
                                                CASE WHEN EecEmplStatus = 'T' THEN --Termination 
                                                       CASE WHEN EecTermReason IN ('202') THEN 'RT' 
                                                            ELSE 'TE' 
                                                        END 
                                                WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee 
                                                ELSE  'FT' 
                                                END 
                                         END 
 
        ,drvINS09_StudentStatusCode = CASE WHEN BdmRecType = 'DEP' THEN 
 
                                                CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time 
 
                                      END 
 
        ,drvINS10_ResponseCode = CASE WHEN BdmRecType = 'EMP' THEN 
 
                                        CASE WHEN EepIsDisabled = 'Y' THEN 'Y' 
 
                                             ELSE 'N' 
 
                                        END 
 
                                      WHEN BdmRecType = 'DEP' THEN  
 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y' 
 
                                             ELSE 'N' 
 
                                        END 
 
                                END 
 
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END 
 
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END 
 
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment 
 
        ,drvREF01_RefNumberQual1 = '1L' 
 
        ,drvREF02_RefNumberQual1 = CONCAT(RTRIM(EecOrgLvl2) , ' ', (Select top 1  RTRIM(OrgDesc) from  dbo.OrgLevel where ORgCode = EecOrgLvl2) )
 
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment 
 
        ,drvREF01_RefNumberQual2 = 'F6' 
 
        ,drvREF02_RefNumberQual2 = EepSSN 
 
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment 
 
        ,drvDTP00_DateTime1 = 'DTP' 
 
        ,drvDTP01_DateTimeQualifier1 = '336' 
 
        ,drvDTP02_DateTimeFormatQual1 = 'D8' 
 
        ,drvDTP03_DateTimePeriod1 = EecDateOfOriginalHire 
 
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment 
 
        ,drvDTP00_DateTime2 = '' 
 
        ,drvDTP01_DateTimeQualifier2 = '' 
 
        ,drvDTP02_DateTimeFormatQual2 = '' 
 
        ,drvDTP03_DateTimePeriod2 = '' 
 
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
 
        ,drvNM106_NamePrefix1 = CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END 
 
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' THEN EepNameSuffix 
 
                                     WHEN BdmRecType = 'DEP' THEN ConNameSuffix 
 
                                END 
 
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34' 
 
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN '34' 
 
                                     END 
 
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN 
 
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN 
 
                            END 
 
        ,drvPER02_Name = '' 
 
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN 'HP' END 
 
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END 
 
        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN 'WP' END 
 
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EecPhoneBusinessNumber,'') END 
 
        ,drvPER07_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN 'EM' END 
 
        ,drvPER08_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END 
 
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1) 
 
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
 
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END 
 
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
 
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,'') 
        
         + CASE WHEN BdmDedType = 'MED' THEN '1' 
                             WHEN BdmDedType = 'DEN' THEN '2' 
                             WHEN BdmDedType = 'VIS' THEN '3' 
                             WHEN BdmDedType = 'OPT' THEN '4' 
                             WHEN BdmDedType =  'OPC' THEN '5' 
                             WHEN BdmDedType = 'STD' THEN '6' 
                             WHEN BdmDedType = 'FSA' and bdmDedCode = 'HCFSA'THEN '9' 
                             WHEN BdmDedType = 'FSA' and bdmDedCode = 'DCFSA'THEN '10' 
                             WHEN BdmDedType = 'OPS' THEN '8' 
                             WHEN BdmDedType = 'LTD' THEN '7' 
                             ELSE '11' 
 
                      END  ) 
 
    INTO dbo.U_ECSC834LAI_DrvTbl 
 
    FROM dbo.U_ECSC834LAI_EELIST WITH (NOLOCK) 
 
    JOIN dbo.EmpPers WITH (NOLOCK) 
 
        ON EepEEID = xEEID 
 
    JOIN dbo.EmpComp WITH (NOLOCK) 
 
        ON EecEEID = xEEID 
 
        AND EecCOID = xCOID 
 
    JOIN dbo.Location WITH (NOLOCK) 
 
        ON LocCode = EecLocation 
 
    JOIN dbo.U_dsi_bdm_ECSC834LAI WITH (NOLOCK) 
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
 
    IF OBJECT_ID('U_ECSC834LAI_DrvTbl_2300','U') IS NOT NULL 
 
        DROP TABLE dbo.U_ECSC834LAI_DrvTbl_2300; 
 
    SELECT DISTINCT 
 
        -- If drvHD00_HealthCoverage Populated, then send HD Segment 
 
        drvHD00_HealthCoverage = CASE WHEN BdmDedCode IN ('MDPPO' ,'MDHDP') THEN 'HD' 
                                           WHEN BdmDedCode IN ('DNPPO' ,'DNHMO') THEN 'HD' 
                                           --WHEN BdmDedCode IN ('DCFSA' , 'HCFSA') THEN 'FSA' 
                                     END 
 
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare 
 
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN '' 
 
                                           WHEN BdmDedType IN ('DEN') THEN '' 
 
                                           WHEN BdmDedType IN ('VIS') THEN '' 
 
                                     END 
 
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedCode IN ('MDPPO' ,'MDHDP') THEN 'HLT' 
                                           WHEN BdmDedCode IN ('DNPPO' ,'DNHMO') THEN 'DEN' 
                                           WHEN BdmDedCode IN ('DCFSA' , 'HCFSA') THEN 'FSA' 
                                     END 
 
        ,drvHD04_PlanCoverageDesc =  CASE WHEN BdmDedCode IN ('MDPPO') THEN 'PPO' 
                                         WHEN BdmDedCode IN ('MDHDP') THEN 'HDHP' 
                                         WHEN BdmDedCode IN ('DNPPO') THEN 'DXN' 
                                         WHEN BdmDedCode IN ('DNHMO ') THEN 'DX2'
                                     END 
 
        ,drvHD05_CoverageLevelCode =  CASE WHEN BdmDedCode IN ('MDPPO', 'MDHDP', 'DNPPO' ,'DNHMO') THEN 
 
                                                CASE WHEN BdmBenOption IN ('EE') THEN 'EMP' 
 
                                                     WHEN BdmBenOption IN ('EES','EEDP') THEN 'ESP' 
 
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH' 
 
                                                     WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'FAM' 
 
                                                END 
 
                                     END 
 
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment 
 
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','MDHDP','MDPPO')THEN 'DTP' END 
 
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','MDHDP','MDPPO')THEN '348' END 
 
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','MDHDP','MDPPO')THEN 'D8' END 
 
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','MDHDP','MDPPO')THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END 
 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment 
 
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','DCFSA','HCFSA','MDHDP','MDPPO')AND BdmBenStopDate IS NOT NULL THEN 'DTP' END 
 
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','DCFSA','HCFSA','MDHDP','MDPPO')AND BdmBenStopDate IS NOT NULL THEN '349' END 
 
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','DCFSA','HCFSA','MDHDP','MDPPO')AND BdmBenStopDate IS NOT NULL THEN 'D8' END 
 
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedCode IN ('DNHMO','DNPPO','DCFSA','HCFSA','MDHDP','MDPPO')THEN BdmBenStopDate END 
 
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
 
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedCode IN ('LIFEE', 'STD', 'LTD') THEN 'AMT' 
                                              WHEN BdmDedCode in ('LIFES', 'LIFEC') and BdmRecType = 'EMP' THEN 'AMT'
                                              END 
 
        ,drvAMT01_AmountQualifierCode1 = CASE WHEN BdmDedCode IN ('LIFEE', 'LIFES', 'LIFEC', 'STD', 'LTD') THEN 'FK' END 
 
        ,drvAMT02_MonetaryAmount1 = CASE WHEN BdmDedCode IN ('LIFEE', 'LIFES', 'LIFEC' , 'STD') THEN BdmUSGField1 
 
                                         WHEN BdmDedcode IN ('LTD') THEN EecAnnSalary 
 
                                        END 
 
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment 
 
        ,drvAMT00_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END 
 
        ,drvAMT01_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END 
 
        ,drvAMT02_MonetaryAmount2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END 
        ,drvFSA00_Coverage = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN 'FSA' END 
        ,drvFSA00_MaintTypeCode = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN '030' END 
        ,drvFSA00_ReasonCode = ''
        ,drvFSA00_AccountNumber = ''
        ,drvFSA00_FSA_SelectionCode  = CASE WHEN BdmDedcode IN ('HCFSA') THEN 'H' 
                                            WHEN BdmDedcode IN ('DCFSA') THEN 'D'  
                                        END 
        ,drvFSA00_FrequencyCode = '2' 
        ,drvFSA00_PlanCoverageDesc = CASE WHEN BdmDedcode IN ('HCFSA') THEN 'FLX' 
                                            WHEN BdmDedcode IN ('DCFSA') THEN 'FLD'  
                                        END 
        ,drvFSA00_ProductOptionCode = 'Y' 
        ,drvFSA00_AmountQualifierCode1 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN 'AMT' END 
 
        ,drvAMTFSA01_AmountQualifierCode1 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN 'E2' END 
 
        ,drvAMTFSA02_MonetaryAmount1 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA')  THEN BdmEEGoalAmt END 
 
 
 
        ,drvDTP00FSA_DateTime_348 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN 'DTP' END 
 
        ,drvDTP01FSA_DateTimeQualifier_348 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN  '348' END  
 
        ,drvDTP02FSA_DateTimeFormatQual_348 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN  'D8' END 
 
        ,drvDTP03FSA_DateTimePeriod_348  = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END 
 
 
 
        ,drvDTP00FSA_DateTime_349 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA')  AND BdmBenStopDate IS NOT NULL THEN 'DTP' END 
 
        ,drvDTP01FSA_DateTimeQualifier_349 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA')  AND BdmBenStopDate IS NOT NULL THEN  '349' END 
 
        ,drvDTP02FSA_DateTimeFormatQual_349 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA')  AND BdmBenStopDate IS NOT NULL  THEN  'D8' END 
 
        ,drvDTP03FSA_DateTimePeriod_349 = CASE WHEN BdmDedcode IN ('HCFSA','DCFSA')  AND BdmBenStopDate IS NOT NULL THEN BdmBenStopDate END 
 
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
 
                      + CASE WHEN BdmDedType = 'MED' THEN '1' 
                             WHEN BdmDedType = 'DEN' THEN '2' 
                             WHEN BdmDedType = 'VIS' THEN '3' 
                             WHEN BdmDedType = 'OPT' THEN '4' 
                             WHEN BdmDedType =  'OPC' THEN '5' 
                             WHEN BdmDedType = 'STD' THEN '6' 
                             WHEN BdmDedType = 'FSA' and bdmDedCode = 'HCFSA'THEN '9' 
                             WHEN BdmDedType = 'FSA' and bdmDedCode = 'DCFSA'THEN '10' 
                             WHEN BdmDedType = 'OPS' THEN '8' 
                             WHEN BdmDedType = 'LTD' THEN '7' 
                             ELSE '11' 
 
                      END 
 
    INTO dbo.U_ECSC834LAI_DrvTbl_2300 
 
    FROM dbo.U_ECSC834LAI_EELIST WITH (NOLOCK) 
 
    JOIN dbo.EmpPers WITH (NOLOCK) 
 
        ON EepEEID = xEEID 
 
    JOIN dbo.EmpComp WITH (NOLOCK) 
 
        ON EecEEID = xEEID 
 
        AND EecCOID = xCOID 
 
    JOIN dbo.U_dsi_bdm_ECSC834LAI WITH (NOLOCK) 
 
        ON BdmEEID = xEEID 
 
        AND BdmCOID = xCOID 
 
    LEFT JOIN dbo.Contacts WITH (NOLOCK) 
 
        ON ConEEID = xEEID 
 
        AND ConSystemID = BdmDepRecID; 
 

  -- Delete depedent where there is no HD line
  --Delete from U_ECSC834LAI_DrvTbl where drvSSN  in (select  drvSSN from U_ECSC834LAI_DrvTbl_2300 where drvFSA00_Coverage IS NULL and drvHD00_HealthCoverage IS NULL) and drvINS01_YesNoCond = 'N'
    Delete from U_ECSC834LAI_DrvTbl where drvIns01_YesNoCond  = 'N' and drveeid not in (
    select bdmeeid from U_dsi_bdm_ECSC834LAI where bdmRecType = 'DEP' and bdmdedcode in ('DNHMO','DNPPO','DCFSA','HCFSA','MDHDP','MDPPO'))

    --Delete where EedNeedEOI or benefit amount = '0.01'

    Delete from U_ECSC834LAI_DrvTbl_2300 where  drvAMT02_MonetaryAmount1 = '0.01'

    --Delete from dbo.U_ECSC834LAI_DrvTbl_2300 where drvHD03_InsuranceLineCode  = 'FSA'
 
 
    /************************************************************************************************** 
 
        TRAILER RECORDS 
 
            - SE, GE, IEA Segments 
 
    **************************************************************************************************/ 
 
    --------------------- 
 
    -- TRAILER RECORD 
 
    -------------------- 
 
    IF OBJECT_ID('U_ECSC834LAI_TrlTbl') IS NOT NULL 
 
        DROP TABLE dbo.U_ECSC834LAI_TrlTbl; 
 
    SELECT DISTINCT drvSE01_SegmentCount = '9999' 
 
    INTO dbo.U_ECSC834LAI_TrlTbl; 
 
 
 
    --========================================== 
 
    -- Set FileName 
 
    --========================================== 
 
    IF (dbo.dsi_fnVariable('ECSC834LAI','UseFileName') = 'N') 
 
    BEGIN 
 
        UPDATE dbo.U_dsi_Parameters 
 
            SET ExportFile = 'CCG_ECSC834LAI_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt' 
 
        WHERE FormatCode = 'ECSC834LAI'; 
 
    END; 
 
 
 
END; 
 
/********************************************************************************** 
 
 
 
--Alter the View 
 
ALTER VIEW dbo.dsi_vwECSC834LAI_Export AS 
 
    SELECT TOP 20000000 DATA FROM dbo.U_ECSC834LAI_File (NOLOCK) 
 
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2) 
 
GO 
 
 
 
--Check out AscDefF 
 
SELECT * FROM dbo.AscDefFEEOnlyBenOpti 
 
WHERE AdfHeaderSystemID LIKE 'ECSC834LAI%' 
 
ORDER BY AdfSetNumber, AdfFieldNumber; 
 
 
 
--Update Dates 
 
UPDATE dbo.AscExp 
 
    SET ExpLastStartPerControl = '202010011' 
 
       ,ExpStartPerControl     = '202010011' 
 
       ,ExpLastEndPerControl   = '202010019' 
 
       ,ExpEndPerControl       = '202010019' 
 
WHERE ExpFormatCode = 'ECSC834LAI'; 
 
 
 
**********************************************************************************/ 
GO
CREATE VIEW dbo.dsi_vwECSC834LAI_Export AS  
    SELECT TOP 20000000 DATA FROM dbo.U_ECSC834LAI_File (NOLOCK)  
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2) 