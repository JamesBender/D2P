SET NOCOUNT ON;
IF OBJECT_ID('U_ESUNLNC834_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ESUNLNC834_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ESUNLNC834' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwESUNLNC834_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwESUNLNC834_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ESUNLNC834') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLNC834];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_ESUNLNC834') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_ESUNLNC834];
GO
IF OBJECT_ID('U_ESUNLNC834_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_TrlTbl];
GO
IF OBJECT_ID('U_ESUNLNC834_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_HdrTbl];
GO
IF OBJECT_ID('U_ESUNLNC834_File') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_File];
GO
IF OBJECT_ID('U_ESUNLNC834_EEList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_EEList];
GO
IF OBJECT_ID('U_ESUNLNC834_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_DrvTbl_2300];
GO
IF OBJECT_ID('U_ESUNLNC834_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_DrvTbl];
GO
IF OBJECT_ID('U_ESUNLNC834_DedList') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_ESUNLNC834') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ESUNLNC834];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ESUNLNC834';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ESUNLNC834';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ESUNLNC834';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ESUNLNC834';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ESUNLNC834';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ESUNLNC834','SunLIfe Non-Cancer 834 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','ESUNLNC834Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ESUNLNC834' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISA"','1','(''DA''=''F*'')','ESUNLNC834Z0','3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''F*'')','ESUNLNC834Z0','2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F*'')','ESUNLNC834Z0','10','H','01','3',NULL,'Authorization Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','4','(''DA''=''F*'')','ESUNLNC834Z0','2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F*'')','ESUNLNC834Z0','10','H','01','5',NULL,'Security Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA05_SenderIDQual"','6','(''UA''=''F*'')','ESUNLNC834Z0','2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA06_SenderID"','7','(''UA''=''F*'')','ESUNLNC834Z0','15','H','01','7',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA07_ReceiverIDQual"','8','(''UA''=''F*'')','ESUNLNC834Z0','2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA08_ReceiverID"','9','(''UA''=''F*'')','ESUNLNC834Z0','15','H','01','9',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA09_InterchangeDate"','10','(''UD12''=''F*'')','ESUNLNC834Z0','6','H','01','10',NULL,'Interchange Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA10_InterchangeTime"','11','(''UA''=''F*'')','ESUNLNC834Z0','4','H','01','11',NULL,'Interchange Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"^"','12','(''DA''=''F*'')','ESUNLNC834Z0','1','H','01','12',NULL,'Repetition Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00501"','13','(''DA''=''F*'')','ESUNLNC834Z0','5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','14','(''DA''=''F*'')','ESUNLNC834Z0','9','H','01','14',NULL,'Interchange Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','15','(''DA''=''F*'')','ESUNLNC834Z0','1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA15_UsageIndicator"','16','(''UA''=''F*'')','ESUNLNC834Z0','1','H','01','16',NULL,'Usage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('":"','17','(''DA''=''F*'')','ESUNLNC834Z0','1','H','01','17',NULL,'Component Element Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GS"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BE"','2','(''DA''=''T*'')','ESUNLNC834Z0','2','H','02','2',NULL,'Functional ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS02_SenderID"','3','(''UA''=''T*'')','ESUNLNC834Z0','15','H','02','3',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS03_ReceiverID"','4','(''UA''=''T*'')','ESUNLNC834Z0','15','H','02','4',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS04_Date"','5','(''UD112''=''T*'')','ESUNLNC834Z0','8','H','02','5',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS05_Time"','6','(''UA''=''T*'')','ESUNLNC834Z0','8','H','02','6',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','7','(''DA''=''T*'')','ESUNLNC834Z0','9','H','02','7',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"X"','8','(''DA''=''T*'')','ESUNLNC834Z0','2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','9','(''DA''=''T*'')','ESUNLNC834Z0','12','H','02','9',NULL,'Version/Release  Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ST"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"834"','2','(''DA''=''T*'')','ESUNLNC834Z0','3','H','03','2',NULL,'Transaction ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ESUNLNC834Z0','9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','4','(''DA''=''T*'')','ESUNLNC834Z0','35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BGN"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''T*'')','ESUNLNC834Z0','2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ESUNLNC834Z0','50','H','04','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN03_Date"','4','(''UD112''=''T*'')','ESUNLNC834Z0','8','H','04','4',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN04_Time"','5','(''UA''=''T*'')','ESUNLNC834Z0','8','H','04','5',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN05_TimeCode"','6','(''UA''=''T*'')','ESUNLNC834Z0','2','H','04','6',NULL,'Time Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN06_RefID"','7','(''UA''=''T*'')','ESUNLNC834Z0','50','H','04','7',NULL,'Reference Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN07_TransTypeCode"','8','(''UA''=''T*'')','ESUNLNC834Z0','2','H','04','8',NULL,'Transaction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN08_ActionCode"','9','(''UA''=''T*'')','ESUNLNC834Z0','2','H','04','9',NULL,'Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DTP"','1','(''DA''=''T*'')','ESUNLNC834Z0','50','H','06','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier1"','2','(''UA''=''T*'')','ESUNLNC834Z0','50','H','06','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual1"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','H','06','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod1"','4','(''UD112''=''T*'')','ESUNLNC834Z0','50','H','06','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual1"','2','(''UA''=''T*'')','ESUNLNC834Z0','2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity1"','3','(''UA''=''T*'')','ESUNLNC834Z0','15','H','07','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual2"','2','(''UA''=''T*'')','ESUNLNC834Z0','2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity2"','3','(''UA''=''T*'')','ESUNLNC834Z0','15','H','08','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','H','09','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual3"','2','(''UA''=''T*'')','ESUNLNC834Z0','2','H','09','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity3"','3','(''UA''=''T*'')','ESUNLNC834Z0','15','H','09','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','H','10','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor1"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','H','10','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name1"','3','(''UA''=''T*'')','ESUNLNC834Z0','60','H','10','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual1"','4','(''UA''=''T*'')','ESUNLNC834Z0','2','H','10','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode1"','5','(''UA''=''T*'')','ESUNLNC834Z0','80','H','10','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','H','11','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor2"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','H','11','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name2"','3','(''UA''=''T*'')','ESUNLNC834Z0','60','H','11','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual2"','4','(''UA''=''T*'')','ESUNLNC834Z0','2','H','11','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode2"','5','(''UA''=''T*'')','ESUNLNC834Z0','80','H','11','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INS"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','12','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS01_YesNoCond"','2','(''UA''=''T*'')','ESUNLNC834Z0','1','D','12','2',NULL,'Yes/No Condition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS02_RelationshipCode"','3','(''UA''=''T*'')','ESUNLNC834Z0','2','D','12','3',NULL,'Individual Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS03_MaintTypeCode"','4','(''UA''=''T*'')','ESUNLNC834Z0','3','D','12','4',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS04_MaintReasonCode"','5','(''UA''=''T*'')','ESUNLNC834Z0','3','D','12','5',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS05_BenefitStatusCode"','6','(''UA''=''T*'')','ESUNLNC834Z0','1','D','12','6',NULL,'Benefit Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0601_MEDICAREPLANCODE"','7','(''UA''=''T'')','ESUNLNC834Z0','1','D','12','7',NULL,'MEDICARE PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0602_EligibilityRsnCode"','8','(''UA''=''T*'')','ESUNLNC834Z0','1','D','12','8',NULL,'Eligibility Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS07_COBRAQualEventCode"','9','(''UA''=''T*'')','ESUNLNC834Z0','2','D','12','9',NULL,'COBRA Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS08_EmploymentStatusCode"','10','(''UA''=''T*'')','ESUNLNC834Z0','2','D','12','10',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS09_StudentStatusCode"','11','(''UA''=''T*'')','ESUNLNC834Z0','1','D','12','11',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS10_ResponseCode"','12','(''UA''=''T*'')','ESUNLNC834Z0','1','D','12','12',NULL,'Response Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS11_DateTimeFormatQual"','13','(''UA''=''T*'')','ESUNLNC834Z0','3','D','12','13',NULL,'Date Time Period Format Qualif',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS12_DateTimePeriod"','14','(''UD112''=''T*'')','ESUNLNC834Z0','35','D','12','14',NULL,'Date Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','15','(''DA''=''T*'')','ESUNLNC834Z0','35','D','12','15',NULL,'Confidentiality Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T*'')','ESUNLNC834Z0','35','D','12','16',NULL,'Not Used',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T*'')','ESUNLNC834Z0','35','D','12','17',NULL,'Not Used',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','18','(''DA''=''T*'')','ESUNLNC834Z0','35','D','12','18',NULL,'Not Used',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS17_BirthSequenceNumber"','19','(''UA''=''T*'')','ESUNLNC834Z0','35','D','12','19',NULL,'Birth Sequence Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','13','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0F"','2','(''DA''=''T*'')','ESUNLNC834Z0','3','D','13','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','D','13','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','D','14','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','15','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','15','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','D','15','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime1"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','16','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier1"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','16','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual1"','3','(''UA''=''T*'')','ESUNLNC834Z0','3','D','16','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod1"','4','(''UD112''=''T*'')','ESUNLNC834Z0','35','D','16','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime2"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','17','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier2"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','17','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual2"','3','(''UA''=''T*'')','ESUNLNC834Z0','3','D','17','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod2"','4','(''UD112''=''T*'')','ESUNLNC834Z0','35','D','17','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NM1"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','20','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IL"','2','(''DA''=''T*'')','ESUNLNC834Z0','3','D','20','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','3','(''DA''=''T*'')','ESUNLNC834Z0','1','D','20','3',NULL,'Entity Type Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM103_NameLast1"','4','(''UA''=''T*'')','ESUNLNC834Z0','60','D','20','4',NULL,'Name Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM104_NameFirst1"','5','(''UA''=''T*'')','ESUNLNC834Z0','35','D','20','5',NULL,'Name First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM105_NameMiddleInitial1"','6','(''UA''=''T*'')','ESUNLNC834Z0','25','D','20','6',NULL,'Name Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM106_NamePrefix1"','7','(''UA''=''T*'')','ESUNLNC834Z0','10','D','20','7',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM107_NameSuffix1"','8','(''UA''=''T*'')','ESUNLNC834Z0','10','D','20','8',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM108_IDCodeQualifier1"','9','(''UA''=''T*'')','ESUNLNC834Z0','2','D','20','9',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM109_IDCode1"','10','(''UA''=''T*'')','ESUNLNC834Z0','80','D','20','10',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','21','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IP"','2','(''DA''=''T*'')','ESUNLNC834Z0','2','D','21','2',NULL,'Contact Function Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER02_Name"','3','(''UA''=''T*'')','ESUNLNC834Z0','60','D','21','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER03_CommNumberQualifier"','4','(''UA''=''T*'')','ESUNLNC834Z0','3','D','21','4',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER04_CommunicationNumber"','5','(''UA''=''T*'')','ESUNLNC834Z0','256','D','21','5',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER05_CommNumberQualifier"','6','(''UA''=''T*'')','ESUNLNC834Z0','3','D','21','6',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER06_CommunicationNumber"','7','(''UA''=''T*'')','ESUNLNC834Z0','256','D','21','7',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER07_CommNumberQualifier"','8','(''UA''=''T*'')','ESUNLNC834Z0','3','D','21','8',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER08_CommunicationNumber"','9','(''UA''=''T*'')','ESUNLNC834Z0','256','D','21','9',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N3"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','D','22','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN301_AddressLine1"','2','(''UA''=''T*'')','ESUNLNC834Z0','55','D','22','2',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN302_AddressLine2"','3','(''UA''=''T*'')','ESUNLNC834Z0','55','D','22','3',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N4"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','D','23','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN401_City"','2','(''UA''=''T*'')','ESUNLNC834Z0','30','D','23','2',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN402_State"','3','(''UA''=''T*'')','ESUNLNC834Z0','2','D','23','3',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN403_Zip"','4','(''UA''=''T*'')','ESUNLNC834Z0','15','D','23','4',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN404_CountryCode"','5','(''UA''=''T*'')','ESUNLNC834Z0','3','D','23','5',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMG"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','24','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D8"','2','(''DA''=''T*'')','ESUNLNC834Z0','3','D','24','2',NULL,'Date/Time Format Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG02_DateTimePeriod1"','3','(''UD112''=''T*'')','ESUNLNC834Z0','35','D','24','3',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG03_GenderCode1"','4','(''UA''=''T*'')','ESUNLNC834Z0','1','D','24','4',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG04_MaritalStatusCode1"','5','(''UA''=''T*'')','ESUNLNC834Z0','1','D','24','5',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ICM"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','25','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM01_FrequencyCode"','2','(''UA''=''T*'')','ESUNLNC834Z0','1','D','25','2',NULL,'Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM02_MonetaryAmount"','3','(''UA''=''T*'')','ESUNLNC834Z0','18','D','25','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM03_Quantity"','4','(''UA''=''T*'')','ESUNLNC834Z0','15','D','25','4',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM04_LocationID"','5','(''UA''=''T*'')','ESUNLNC834Z0','30','D','25','5',NULL,'Location Identifier Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID1"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','26','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','ESUNLNC834Z0','18','D','26','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','ESUNLNC834Z0','1','D','26','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID2"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','27','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','ESUNLNC834Z0','18','D','27','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','ESUNLNC834Z0','1','D','27','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH00_SegmentID"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','28','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH01_HealthRelatedCode"','2','(''UA''=''T*'')','ESUNLNC834Z0','8','D','28','2',NULL,'Health-Related Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH02_Height"','3','(''UA''=''T*'')','ESUNLNC834Z0','10','D','28','3',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH03_Weight1"','4','(''UA''=''T*'')','ESUNLNC834Z0','10','D','28','4',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH04_Weight2"','5','(''UA''=''T*'')','ESUNLNC834Z0','10','D','28','5',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH05_Description1"','6','(''UA''=''T*'')','ESUNLNC834Z0','10','D','28','6',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH06_CurrentHealthConditionCode"','7','(''UA''=''T*'')','ESUNLNC834Z0','10','D','28','7',NULL,'Current Health Condition Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH07_Description2"','8','(''UA''=''T*'')','ESUNLNC834Z0','10','D','28','8',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD00_HealthCoverage"','1','(''UA''=''T*'')','ESUNLNC834Z0','2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD01_MaintTypeCode"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD02_MaintReasonCode"','3','(''UA''=''T*'')','ESUNLNC834Z0','3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD03_InsuranceLineCode"','4','(''UA''=''T*'')','ESUNLNC834Z0','3','D','40','4',NULL,'Insurance Line Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD04_PlanCoverageDesc"','5','(''UA''=''T*'')','ESUNLNC834Z0','50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD05_CoverageLevelCode"','6','(''UA''=''T*'')','ESUNLNC834Z0','3','D','40','6',NULL,'Coverage Level Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_348"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_348"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_348"','3','(''UA''=''T*'')','ESUNLNC834Z0','3','D','41','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_348"','4','(''UD112''=''T*'')','ESUNLNC834Z0','35','D','41','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_349"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_349"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_349"','3','(''UA''=''T*'')','ESUNLNC834Z0','3','D','42','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_349"','4','(''UD112''=''T*'')','ESUNLNC834Z0','35','D','42','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_303"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_303"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_303"','3','(''UA''=''T*'')','ESUNLNC834Z0','3','D','43','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_303"','4','(''UD112''=''T*'')','ESUNLNC834Z0','35','D','43','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual1"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','D','45','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual2"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','D','46','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode1"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','ESUNLNC834Z0','18','D','50','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode2"','1','(''UA''=''T*'')','ESUNLNC834Z0','3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','ESUNLNC834Z0','18','D','51','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LS"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLS01_LoopIDCode"','2','(''UA''=''T*'')','ESUNLNC834Z0','6','D','80','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LX"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLX01_AssignedNumber"','2','(''UA''=''T*'')','ESUNLNC834Z0','6','D','81','2',NULL,'Assigned Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name"','3','(''UA''=''T*'')','ESUNLNC834Z0','60','D','85','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','ESUNLNC834Z0','3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberDesc"','3','(''UA''=''T*'')','ESUNLNC834Z0','50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LE"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLE01_LoopIDCode"','2','(''UA''=''T*'')','ESUNLNC834Z0','6','D','87','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SE"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSE01_SegmentCount"','2','(''UA''=''T*'')','ESUNLNC834Z0','10','T','90','2',NULL,'Number of Included Segments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ESUNLNC834Z0','9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GE"','1','(''DA''=''T*'')','ESUNLNC834Z0','2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','ESUNLNC834Z0','6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','ESUNLNC834Z0','9','T','91','3',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IEA"','1','(''DA''=''T*'')','ESUNLNC834Z0','3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','ESUNLNC834Z0','5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','3','(''DA''=''T*'')','ESUNLNC834Z0','9','T','92','3',NULL,'Interchange Control Number',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'ESUNLNC834_20210628.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Changes Only File','202103249','EMPEXPORT','CHANGES','Dec  1 2020  6:15PM','ESUNLNC834',NULL,NULL,NULL,'202103249','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202101011','23361','','','202101011',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'Full File Only','202105311','EMPEXPORT','FULLFILE','Jun  3 2021  5:07PM','ESUNLNC834',NULL,NULL,NULL,'202105311','May 31 2021 12:00AM','Dec 30 1899 12:00AM','202105251','30245','','','202105251',dbo.fn_GetTimedKey(),NULL,'us3cPePRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'Active Open Enrollment','202103249','EMPEXPORT','OEACTIVE','Dec 26 2020  4:44PM','ESUNLNC834',NULL,NULL,NULL,'202103249','Jan  1 2021 12:00AM','Dec 26 2020 12:00AM','202101011','21675','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3cPePRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','XRAEE,XRS43',NULL,NULL,NULL,'Passive Open Enrollment','202103249','EMPEXPORT','OEPASSIVE','Dec 26 2020  4:23PM','ESUNLNC834',NULL,NULL,NULL,'202103249','Jan  1 2021 12:00AM','Dec 26 2020 12:00AM','202101011','26924','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3cPePRI1029',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',',XRAEE,XRS43',NULL,NULL,NULL,'SunLIfe Non-Cancer 834 Export','202105149','EMPEXPORT','SCHEDULED','Dec  1 2020  6:19PM','ESUNLNC834',NULL,NULL,NULL,'202106289','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202106211','23361','','','202105141',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ESUNLNC834','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'ESUNLNC834' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'ESUNLNC834' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_ESUNLNC834_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ESUNLNC834_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H01','U_ESUNLNC834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H02','U_ESUNLNC834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H03','U_ESUNLNC834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H04','U_ESUNLNC834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H05','U_ESUNLNC834_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H06','U_ESUNLNC834_HdrTbl','ISNULL(drvDTP01_DateTimeQualifier1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H07','U_ESUNLNC834_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H08','U_ESUNLNC834_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H09','U_ESUNLNC834_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H10','U_ESUNLNC834_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','H11','U_ESUNLNC834_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D12','U_ESUNLNC834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D13','U_ESUNLNC834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D14','U_ESUNLNC834_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D15','U_ESUNLNC834_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D16','U_ESUNLNC834_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D17','U_ESUNLNC834_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D20','U_ESUNLNC834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D21','U_ESUNLNC834_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D22','U_ESUNLNC834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D23','U_ESUNLNC834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D24','U_ESUNLNC834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D25','U_ESUNLNC834_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D26','U_ESUNLNC834_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D27','U_ESUNLNC834_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D28','U_ESUNLNC834_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D40','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D41','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D42','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D43','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D45','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D46','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D50','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D51','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D80','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D81','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D85','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D86','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','D87','U_ESUNLNC834_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','T90','U_ESUNLNC834_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','T91','U_ESUNLNC834_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ESUNLNC834','T92','U_ESUNLNC834_TrlTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_ESUNLNC834') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_ESUNLNC834] (
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
IF OBJECT_ID('U_ESUNLNC834_DedList') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC834_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_ESUNLNC834_DrvTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC834_DrvTbl] (
    [drvINS01_YesNoCond] varchar(1) NOT NULL,
    [drvINS02_RelationshipCode] varchar(2) NOT NULL,
    [drvINS03_MaintTypeCode] varchar(3) NOT NULL,
    [drvINS04_MaintReasonCode] varchar(2) NOT NULL,
    [drvINS05_BenefitStatusCode] varchar(1) NOT NULL,
    [drvINS0601_MEDICAREPLANCODE] varchar(1) NOT NULL,
    [drvINS0602_EligibilityRsnCode] varchar(1) NOT NULL,
    [drvINS07_COBRAQualEventCode] varchar(1) NOT NULL,
    [drvINS08_EmploymentStatusCode] varchar(2) NULL,
    [drvINS09_StudentStatusCode] varchar(1) NULL,
    [drvINS10_ResponseCode] varchar(1) NULL,
    [drvINS11_DateTimeFormatQual] varchar(1) NOT NULL,
    [drvINS12_DateTimePeriod] varchar(1) NOT NULL,
    [drvINS17_BirthSequenceNumber] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual1] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual1] varchar(7) NOT NULL,
    [drvREF01_RefNumberQual2] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual2] varchar(7) NOT NULL,
    [drvDTP00_DateTime1] varchar(3) NOT NULL,
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
    [drvNM106_NamePrefix1] varchar(30) NULL,
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
    [drvN301_AddressLine1] varchar(6000) NULL,
    [drvN302_AddressLine2] varchar(6000) NULL,
    [drvN401_City] varchar(6000) NULL,
    [drvN402_State] varchar(255) NULL,
    [drvN403_Zip] varchar(50) NULL,
    [drvN404_CountryCode] char(3) NULL,
    [drvDMG02_DateTimePeriod1] varchar(8) NULL,
    [drvDMG03_GenderCode1] varchar(1) NULL,
    [drvDMG04_MaritalStatusCode1] varchar(1) NOT NULL,
    [drvICM01_FrequencyCode] varchar(1) NULL,
    [drvICM02_MonetaryAmount] money NULL,
    [drvICM03_Quantity] nvarchar(4000) NULL,
    [drvICM04_LocationID] varchar(8) NULL,
    [drvAMT00_SegmentID1] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode1] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount1] varchar(1) NOT NULL,
    [drvAMT00_SegmentID2] varchar(1) NOT NULL,
    [drvAMT01_AmountQualifierCode2] varchar(1) NOT NULL,
    [drvAMT02_MonetaryAmount2] varchar(1) NOT NULL,
    [drvHLH00_SegmentID] varchar(3) NOT NULL,
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
    [drvSubSort] varchar(23) NULL
);
IF OBJECT_ID('U_ESUNLNC834_DrvTbl_2300') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC834_DrvTbl_2300] (
    [drvHD00_HealthCoverage] varchar(2) NOT NULL,
    [drvHD01_MaintTypeCode] varchar(3) NOT NULL,
    [drvHD02_MaintReasonCode] varchar(1) NOT NULL,
    [drvHD03_InsuranceLineCode] varchar(3) NULL,
    [drvHD04_PlanCoverageDesc] varchar(5) NULL,
    [drvHD05_CoverageLevelCode] varchar(3) NULL,
    [drvDTP00_DateTime_348] varchar(3) NOT NULL,
    [drvDTP01_DateTimeQualifier_348] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual_348] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod_348] datetime NULL,
    [drvDTP00_DateTime_349] varchar(3) NULL,
    [drvDTP01_DateTimeQualifier_349] varchar(3) NULL,
    [drvDTP02_DateTimeFormatQual_349] varchar(2) NULL,
    [drvDTP03_DateTimePeriod_349] datetime NULL,
    [drvDTP00_DateTime_303] varchar(3) NOT NULL,
    [drvDTP01_DateTimeQualifier_303] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual_303] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod_303] datetime NULL,
    [drvREF00_RefNumberQual1] varchar(1) NULL,
    [drvREF01_RefNumberQual1] varchar(1) NULL,
    [drvREF02_RefNumberQual1] varchar(1) NULL,
    [drvREF00_RefNumberQual2] varchar(1) NULL,
    [drvREF01_RefNumberQual2] varchar(1) NULL,
    [drvREF02_RefNumberQual2] varchar(1) NULL,
    [drvAMT00_AmountQualifierCode1] varchar(3) NULL,
    [drvAMT01_AmountQualifierCode1] varchar(2) NOT NULL,
    [drvAMT02_MonetaryAmount1] money NULL,
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
IF OBJECT_ID('U_ESUNLNC834_EEList') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC834_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ESUNLNC834_File') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC834_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_ESUNLNC834_HdrTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC834_HdrTbl] (
    [drvISA05_SenderIDQual] varchar(2) NOT NULL,
    [drvISA06_SenderID] varchar(9) NOT NULL,
    [drvISA07_ReceiverIDQual] varchar(2) NOT NULL,
    [drvISA08_ReceiverID] varchar(9) NOT NULL,
    [drvISA09_InterchangeDate] varchar(6) NULL,
    [drvISA10_InterchangeTime] varchar(4) NULL,
    [drvISA15_UsageIndicator] varchar(1) NOT NULL,
    [drvGS02_SenderID] varchar(27) NOT NULL,
    [drvGS03_ReceiverID] varchar(9) NOT NULL,
    [drvGS04_Date] varchar(8) NULL,
    [drvGS05_Time] varchar(4) NULL,
    [drvBGN03_Date] varchar(8) NULL,
    [drvBGN04_Time] varchar(4) NULL,
    [drvBGN05_TimeCode] varchar(2) NOT NULL,
    [drvBGN06_RefID] varchar(1) NOT NULL,
    [drvBGN07_TransTypeCode] varchar(1) NOT NULL,
    [drvBGN08_ActionCode] varchar(1) NOT NULL,
    [drvREF01_RefNumberQual] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual] varchar(6) NOT NULL,
    [drvDTP01_DateTimeQualifier1] varchar(3) NOT NULL,
    [drvDTP02_DateTimeFormatQual1] varchar(2) NOT NULL,
    [drvDTP03_DateTimePeriod1] datetime NOT NULL,
    [drvQTY01_QuantityQual1] varchar(2) NOT NULL,
    [drvQTY02_Quantity1] int NULL,
    [drvQTY01_QuantityQual2] varchar(2) NOT NULL,
    [drvQTY02_Quantity2] int NULL,
    [drvQTY01_QuantityQual3] varchar(2) NOT NULL,
    [drvQTY02_Quantity3] int NULL,
    [drvN101_EntityIDCodeSponsor1] varchar(2) NOT NULL,
    [drvN102_Name1] varchar(27) NOT NULL,
    [drvN103_IDCodeQual1] varchar(2) NOT NULL,
    [drvN104_IDCode1] varchar(9) NOT NULL,
    [drvN101_EntityIDCodeSponsor2] varchar(2) NOT NULL,
    [drvN102_Name2] varchar(18) NOT NULL,
    [drvN103_IDCodeQual2] varchar(2) NOT NULL,
    [drvN104_IDCode2] varchar(9) NOT NULL
);
IF OBJECT_ID('U_ESUNLNC834_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_ESUNLNC834_TrlTbl] (
    [drvSE01_SegmentCount] varchar(4) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_ESUNLNC834]
AS
SET NOCOUNT ON;
/************************************************************
Client: Priority Wire

Created By: James Bender
Create Date: 11/30/2020
ChangePoint Request Number: TekP-2020-09-02-0003

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
    WHILE (SELECT COUNT(*) FROM dbo.U_ESUNLNC834_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_ESUNLNC834_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_ESUNLNC834_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_ESUNLNC834_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_ESUNLNC834_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    DELETE dbo.U_ESUNLNC834_File WHERE SubSort LIKE '%3' AND DATA NOT LIKE 'REF*3H%'

    UPDATE dbo.U_ESUNLNC834_File
    SET SubSort = LEFT(SubSort, LEN(SubSort)-2) + ' 1'
    WHERE SubSort LIKE '%3' AND DATA LIKE 'REF*3H%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_ESUNLNC834_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_ESUNLNC834_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ESUNLNC834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Priority Wire

Created By: James Bender
Business Analyst: Cheryl Petitti
Create Date: 11/30/2020
Service Request Number: TekP-2020-09-02-0003

Purpose: SunLIfe Non-Cancer 834 Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ESUNLNC834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ESUNLNC834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ESUNLNC834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ESUNLNC834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ESUNLNC834' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC834', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC834', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ESUNLNC834', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ESUNLNC834';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'ESUNLNC834', @AllObjects = 'Y', @IsWeb = 'Y';
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
    WHERE FormatCode = 'ESUNLNC834';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'LTDH,LTD,LIF,LIFS,LIFC,SHO,ACC,CRI,CRIES,CRICH,CANP1,VIS';

    IF OBJECT_ID('U_ESUNLNC834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_ESUNLNC834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ESUNLNC834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ESUNLNC834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_ESUNLNC834_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_ESUNLNC834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

    DELETE FROM dbo.U_ESUNLNC834_EEList WHERE xEEID IN 
        (SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('TES'));

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DIS,DPC,STC');
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

    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_ESUNLNC834 D
    JOIN dbo.U_dsi_bdm_ESUNLNC834 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ESUNLNC834
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ESUNLNC834
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ESUNLNC834
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ESUNLNC834
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ESUNLNC834
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ESUNLNC834
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
    IF OBJECT_ID('U_ESUNLNC834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = '710732557'
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '060893662'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = 'Priority Wire & Cable, Inc.'
        ,drvGS03_ReceiverID = '060893662'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ET'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = '941752'
        ,drvDTP01_DateTimeQualifier1 = '007'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = GETDATE()
        ,drvQTY01_QuantityQual1 = 'ET'
        ,drvQTY02_Quantity1 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK) WHERE BdmRecType = 'EMP')
        ,drvQTY01_QuantityQual2 = 'DT'
        ,drvQTY02_Quantity2 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK) WHERE BdmRecType = 'DEP')
        ,drvQTY01_QuantityQual3 = 'TO'
        ,drvQTY02_Quantity3 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK))
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'Priority Wire & Cable, Inc.'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '710732557'
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Sun Life Financial'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '060893662'
    INTO dbo.U_ESUNLNC834_HdrTbl
    FROM dbo.U_ESUNLNC834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK)
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
    IF OBJECT_ID('U_ESUNLNC834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC834_DrvTbl;
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
                                                     WHEN ConRelationship IN ('CHL,DIS,DPC,STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = CASE WHEN EecEmplStatus = 'T' THEN '024' ELSE '030' END --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                     --WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     --WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                     ELSE 'AC'
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
        ,drvINS11_DateTimeFormatQual = '' -- CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = '' --CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        ,drvINS17_BirthSequenceNumber = ''
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = '17'
        ,drvREF02_RefNumberQual1 =    CASE WHEN EecSalaryOrHourly = 'H' THEN '2524264'
                                        WHEN EecSalaryOrHourly = 'S' THEN '2524265'
                                        ELSE ''
                                    END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = 'DX'
        ,drvREF02_RefNumberQual2 = '2242992'
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = 'DTP'
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = EecDateOfLastHire
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = CASE WHEN EecEmplStatus = 'T' THEN 'DTP' END
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
        ,drvNM106_NamePrefix1 = CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' THEN CASE WHEN EepNameSuffix NOT IN ('Z') THEN EepNameSuffix END
                                     WHEN BdmRecType = 'DEP' THEN CASE WHEN ConNameSuffix NOT IN ('Z') THEN ConNameSuffix END
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(ConSSN, 3) NOT IN ('999','998') THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' AND ConSSN NOT IN ('000000000', '999999999', '888888888', '123456789') AND LEFT(ConSSN, 3) NOT IN ('999','998') THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' THEN --CASE WHEN BdmRecType = 'EMP' THEN 'HP' END
                                            CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN 'HP' 
                                                 ELSE CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' and ISNULL(EepAddressEMail, '') <> '' THEN 'EM' END
                                            END
                                        END 
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' THEN --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END
                                            CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber
                                                 ELSE CASE WHEN ISNULL(EepPhoneHomeNumber, '') <> '' and ISNULL(EepAddressEMail, '') <> '' THEN EepAddressEMail END
                                            END
                                        END 
        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(EepAddressEMail, '') <> '' THEN 'EM' END
        ,drvPER06_CommunicationNumber = EepAddressEMail --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EecPhoneBusinessNumber,'') END
        ,drvPER07_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' THEN 'EM' END  -- TODO check if blank to be sent or field completely removed based on above sending email or primary phonw.
        ,drvPER08_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-:;',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = EepAddressZipCode
        ,drvN404_CountryCode = CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' AND EepGender IN ('M','F') THEN EepGender
                                     WHEN BdmRecType = 'DEP' AND EepGender IN ('M','F') THEN ConGender
                                     ELSE 'M'
                                END
        ,drvDMG04_MaritalStatusCode1 = '' /*CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END
                                       END*/
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = CASE WHEN BdmRecType = 'EMP' THEN '7' END --'7'
        ,drvICM02_MonetaryAmount = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity =    FORMAT(CASE WHEN BdmRecType = 'EMP' THEN 
                                    CASE WHEN EecPayPeriod = 'W' THEN EecScheduledWorkHrs
                                        WHEN EecPayPeriod = 'B' THEN (EecScheduledWorkHrs/2)
                                        WHEN EecPayPeriod = 'S' THEN (EecScheduledWorkHrs*24)/52
                                        WHEN EecPayPeriod = 'M' THEN (EecScheduledWorkHrs*12)/52
                                    END
                                END, '#.00')
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
        ,drvHLH00_SegmentID = 'HLH'
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
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,'')) + ' 1'
    INTO dbo.U_ESUNLNC834_DrvTbl
    FROM dbo.U_ESUNLNC834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    INSERT INTO dbo.U_ESUNLNC834_DrvTbl
    SELECT DISTINCT
        drvINS01_YesNoCond = 'X'
        ,drvINS02_RelationshipCode
        ,drvINS03_MaintTypeCode
        ,drvINS04_MaintReasonCode
        ,drvINS05_BenefitStatusCode
        ,drvINS0601_MEDICAREPLANCODE
        ,drvINS0602_EligibilityRsnCode
        ,drvINS07_COBRAQualEventCode
        ,drvINS08_EmploymentStatusCode
        ,drvINS09_StudentStatusCode
        ,drvINS10_ResponseCode
        ,drvINS11_DateTimeFormatQual
        ,drvINS12_DateTimePeriod
        ,drvINS17_BirthSequenceNumber
        ,drvREF01_RefNumberQual1 = '3H'
        ,drvREF02_RefNumberQual1 =    CASE WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '300' THEN '329302'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '200' THEN '329303'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '000' THEN '329304'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '150' THEN '329305'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '110' THEN '329306'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '120' THEN '329307'
                                        WHEN EecOrgLvl1 = '00' AND EecOrgLvl2 = '100' THEN '329308'
                                        WHEN EecOrgLvl1 = '23' AND EecOrgLvl2 = '000' THEN '329309'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0051' THEN '329310'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0037' THEN '329311'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0000' THEN '329312'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0025' THEN '329313'
                                        WHEN EecOrgLvl1 = '0094' AND EecOrgLvl2 = '0045' THEN '329314'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0000' THEN '329315'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0028' THEN '329316'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0034' THEN '329317'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0098' THEN '329318'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0099' THEN '329319'
                                        WHEN EecOrgLvl1 = '0090' AND EecOrgLvl2 = '0032' THEN '329320'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0051' THEN '329321'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0016' THEN '329322'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0037' THEN '329323'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0061' THEN '329324'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0052' THEN '329325'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0054' THEN '329326'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0007' THEN '329327'
                                        WHEN EecOrgLvl1 = '0095' AND EecOrgLvl2 = '0007' THEN '329328'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0025' THEN '329329'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0001' THEN '329330'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0045' THEN '329331'
                                        WHEN EecOrgLvl1 = '0092' AND EecOrgLvl2 = '0065' THEN '329332'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0016' THEN '329333'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0034' THEN '329334'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0025' THEN '329335'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0029' THEN '329336'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0030' THEN '329337'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0033' THEN '329338'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0031' THEN '329339'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0035' THEN '329340'
                                        WHEN EecOrgLvl1 = '0093' AND EecOrgLvl2 = '0032' THEN '329341'
                                        
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0001' THEN '329353'

                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0045' THEN '329355'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0065' THEN '329356'

                                        WHEN EecOrgLvl1 = '12' AND EecOrgLvl2 = '000' THEN '329361'


                                        WHEN EecOrgLvl1 = '25' AND EecOrgLvl2 = '000' THEN '329375'
                                        WHEN EecOrgLvl1 = '03' AND EecOrgLvl2 = '000' THEN '329376'
                                        WHEN EecOrgLvl1 = '40' AND EecOrgLvl2 = '000' THEN '329378'
                                        WHEN EecOrgLvl1 = '52' AND EecOrgLvl2 = '000' THEN '329380'
                                        WHEN EecOrgLvl1 = '06' AND EecOrgLvl2 = '000' THEN '329381'
                                        WHEN EecOrgLvl1 = '08' AND EecOrgLvl2 = '000' THEN '329383'
                                        WHEN EecOrgLvl1 = '51' AND EecOrgLvl2 = '000' THEN '329386'


                                        WHEN EecOrgLvl1 = '17' AND EecOrgLvl2 = '000' THEN '329367'

                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0051' THEN '329342'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0016' THEN '329343'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0049' THEN '329344'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0062' THEN '329345'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0037' THEN '329346'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0061' THEN '329347'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0052' THEN '329348'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0054' THEN '329349'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0007' THEN '329350'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0068' THEN '329351'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0025' THEN '329352'
                                        WHEN EecOrgLvl1 = '0091' AND EecOrgLvl2 = '0064' THEN '329354'
                                        WHEN EecOrgLvl1 = '01' AND EecOrgLvl2 = '000' THEN '329357'
                                        WHEN EecOrgLvl1 = '10' AND EecOrgLvl2 = '000' THEN '329359'
                                        WHEN EecOrgLvl1 = '11' AND EecOrgLvl2 = '000' THEN '329360'
                                        WHEN EecOrgLvl1 = '13' AND EecOrgLvl2 = '000' THEN '329363'
                                        WHEN EecOrgLvl1 = '14' AND EecOrgLvl2 = '000' THEN '329364'
                                        WHEN EecOrgLvl1 = '15' AND EecOrgLvl2 = '000' THEN '329365'
                                        WHEN EecOrgLvl1 = '16' AND EecOrgLvl2 = '000' THEN '329366'
                                        WHEN EecOrgLvl1 = '18' AND EecOrgLvl2 = '000' THEN '329368'
                                        WHEN EecOrgLvl1 = '19' AND EecOrgLvl2 = '000' THEN '329369'
                                        WHEN EecOrgLvl1 = '02' AND EecOrgLvl2 = '000' THEN '329370'
                                        WHEN EecOrgLvl1 = '20' AND EecOrgLvl2 = '000' THEN '329371'
                                        WHEN EecOrgLvl1 = '21' AND EecOrgLvl2 = '000' THEN '329372'
                                        WHEN EecOrgLvl1 = '22' AND EecOrgLvl2 = '000' THEN '329373'
                                        WHEN EecOrgLvl1 = '24' AND EecOrgLvl2 = '000' THEN '329374'
                                        WHEN EecOrgLvl1 = '04' AND EecOrgLvl2 = '000' THEN '329377'
                                        WHEN EecOrgLvl1 = '05' AND EecOrgLvl2 = '000' THEN '329379'
                                        WHEN EecOrgLvl1 = '07' AND EecOrgLvl2 = '000' THEN '329382'
                                        WHEN EecOrgLvl1 = '09' AND EecOrgLvl2 = '000' THEN '329384'
                                        WHEN EecOrgLvl1 = '50' AND EecOrgLvl2 = '000' THEN '329385'

                                        WHEN EecOrgLvl1 = '26' AND EecOrgLvl2 = '000' THEN '332140'
                                        --WHEN EecOrgLvl1 = '27' AND EecOrgLvl2 = '000' THEN '332141'







                                        WHEN EecOrgLvl1 = '27' AND EecOrgLvl2 = '000' THEN '334295'
                                        WHEN EecOrgLvl1 = '28' AND EecOrgLvl2 = '000' THEN '334235'
                                        WHEN EecOrgLvl1 = '29' AND EecOrgLvl2 = '000' THEN '334236'
                                        WHEN EecOrgLvl1 = '30' AND EecOrgLvl2 = '000' THEN '334296'
                                        WHEN EecOrgLvl1 = '31' AND EecOrgLvl2 = '000' THEN '334297'
                                        WHEN EecOrgLvl1 = '32' AND EecOrgLvl2 = '000' THEN '334298'
                                        WHEN EecOrgLvl1 = '33' AND EecOrgLvl2 = '000' THEN '334299'
                                        WHEN EecOrgLvl1 = '34' AND EecOrgLvl2 = '000' THEN '334300'
                                        WHEN EecOrgLvl1 = '35' AND EecOrgLvl2 = '000' THEN '334301'
                                        WHEN EecOrgLvl1 = '36' AND EecOrgLvl2 = '000' THEN '334302'
                                        WHEN EecOrgLvl1 = '37' AND EecOrgLvl2 = '000' THEN '334303'
                                        WHEN EecOrgLvl1 = '38' AND EecOrgLvl2 = '000' THEN '334304'
                                        WHEN EecOrgLvl1 = '39' AND EecOrgLvl2 = '000' THEN '334305'
                                        WHEN EecOrgLvl1 = '40' AND EecOrgLvl2 = '000' THEN '334306'
                                        WHEN EecOrgLvl1 = '41' AND EecOrgLvl2 = '000' THEN '334307'
                                        WHEN EecOrgLvl1 = '42' AND EecOrgLvl2 = '000' THEN '334308'
                                        WHEN EecOrgLvl1 = '43' AND EecOrgLvl2 = '000' THEN '334309'
                                        WHEN EecOrgLvl1 = '44' AND EecOrgLvl2 = '000' THEN '334310'
                                        WHEN EecOrgLvl1 = '45' AND EecOrgLvl2 = '000' THEN '334311'
                                        WHEN EecOrgLvl1 = '46' AND EecOrgLvl2 = '000' THEN '334312'
                                        WHEN EecOrgLvl1 = '47' AND EecOrgLvl2 = '000' THEN '334313'
                                        WHEN EecOrgLvl1 = '48' AND EecOrgLvl2 = '000' THEN '334314'
                                        WHEN EecOrgLvl1 = '49' AND EecOrgLvl2 = '000' THEN '334315'
                                        WHEN EecOrgLvl1 = '50' AND EecOrgLvl2 = '000' THEN '334316'
                                        WHEN EecOrgLvl1 = '51' AND EecOrgLvl2 = '000' THEN '334317'
                                        WHEN EecOrgLvl1 = '52' AND EecOrgLvl2 = '000' THEN '334318'
                                        WHEN EecOrgLvl1 = '53' AND EecOrgLvl2 = '000' THEN '334319'
                                        WHEN EecOrgLvl1 = '54' AND EecOrgLvl2 = '000' THEN '334320'
                                        WHEN EecOrgLvl1 = '55' AND EecOrgLvl2 = '000' THEN '334321'
                                        WHEN EecOrgLvl1 = '56' AND EecOrgLvl2 = '000' THEN '334322'
                                        WHEN EecOrgLvl1 = '57' AND EecOrgLvl2 = '000' THEN '334323'
                                        WHEN EecOrgLvl1 = '58' AND EecOrgLvl2 = '000' THEN '334324'
                                        WHEN EecOrgLvl1 = '59' AND EecOrgLvl2 = '000' THEN '334325'
                                        WHEN EecOrgLvl1 = '60' AND EecOrgLvl2 = '000' THEN '334326'
                                        WHEN EecOrgLvl1 = '61' AND EecOrgLvl2 = '000' THEN '334327'
                                        WHEN EecOrgLvl1 = '62' AND EecOrgLvl2 = '000' THEN '334328'
                                        WHEN EecOrgLvl1 = '63' AND EecOrgLvl2 = '000' THEN '334329'
                                        WHEN EecOrgLvl1 = '64' AND EecOrgLvl2 = '000' THEN '334330'
                                        WHEN EecOrgLvl1 = '65' AND EecOrgLvl2 = '000' THEN '334331'
                                        WHEN EecOrgLvl1 = '66' AND EecOrgLvl2 = '000' THEN '334332'
                                        WHEN EecOrgLvl1 = '67' AND EecOrgLvl2 = '000' THEN '334333'
                                        WHEN EecOrgLvl1 = '68' AND EecOrgLvl2 = '000' THEN '334334'
                                        WHEN EecOrgLvl1 = '69' AND EecOrgLvl2 = '000' THEN '334335'
                                        WHEN EecOrgLvl1 = '70' AND EecOrgLvl2 = '000' THEN '334336'
                                        WHEN EecOrgLvl1 = '71' AND EecOrgLvl2 = '000' THEN '334337'
                                        WHEN EecOrgLvl1 = '72' AND EecOrgLvl2 = '000' THEN '334338'
                                        WHEN EecOrgLvl1 = '73' AND EecOrgLvl2 = '000' THEN '334339'
                                        WHEN EecOrgLvl1 = '74' AND EecOrgLvl2 = '000' THEN '334340'
                                        WHEN EecOrgLvl1 = '75' AND EecOrgLvl2 = '000' THEN '334341'
                                        WHEN EecOrgLvl1 = '76' AND EecOrgLvl2 = '000' THEN '334342'
                                        WHEN EecOrgLvl1 = '77' AND EecOrgLvl2 = '000' THEN '334343'
                                        WHEN EecOrgLvl1 = '78' AND EecOrgLvl2 = '000' THEN '334344'
                                        WHEN EecOrgLvl1 = '79' AND EecOrgLvl2 = '000' THEN '334345'
                                        WHEN EecOrgLvl1 = '80' AND EecOrgLvl2 = '000' THEN '334346'
                                        WHEN EecOrgLvl1 = '81' AND EecOrgLvl2 = '000' THEN '334347'
                                        WHEN EecOrgLvl1 = '82' AND EecOrgLvl2 = '000' THEN '334348'
                                        WHEN EecOrgLvl1 = '83' AND EecOrgLvl2 = '000' THEN '334349'
                                        WHEN EecOrgLvl1 = '84' AND EecOrgLvl2 = '000' THEN '334350'
                                        WHEN EecOrgLvl1 = '85' AND EecOrgLvl2 = '000' THEN '334351'
                                        WHEN EecOrgLvl1 = '86' AND EecOrgLvl2 = '000' THEN '334352'
                                        WHEN EecOrgLvl1 = '87' AND EecOrgLvl2 = '000' THEN '334353'
                                        WHEN EecOrgLvl1 = '88' AND EecOrgLvl2 = '000' THEN '334354'
                                        WHEN EecOrgLvl1 = '89' AND EecOrgLvl2 = '000' THEN '334355'
                                        WHEN EecOrgLvl1 = '90' AND EecOrgLvl2 = '000' THEN '334356'
                                        WHEN EecOrgLvl1 = '91' AND EecOrgLvl2 = '000' THEN '334357'
                                        WHEN EecOrgLvl1 = '92' AND EecOrgLvl2 = '000' THEN '334358'
                                        WHEN EecOrgLvl1 = '93' AND EecOrgLvl2 = '000' THEN '334359'
                                        WHEN EecOrgLvl1 = '94' AND EecOrgLvl2 = '000' THEN '334360'
                                        WHEN EecOrgLvl1 = '95' AND EecOrgLvl2 = '000' THEN '334361'
                                        WHEN EecOrgLvl1 = '96' AND EecOrgLvl2 = '000' THEN '334362'
                                        WHEN EecOrgLvl1 = '97' AND EecOrgLvl2 = '000' THEN '334363'
                                        WHEN EecOrgLvl1 = '98' AND EecOrgLvl2 = '000' THEN '334364'
                                        WHEN EecOrgLvl1 = '99' AND EecOrgLvl2 = '000' THEN '334365'
                                        WHEN EecOrgLvl1 = '100' AND EecOrgLvl2 = '000' THEN '334366'

                                        WHEN EecOrgLvl1 = '90' AND EecOrgLvl2 = '900' THEN '335875'



                                        WHEN ISNULL(EecUDField03, '') <> '' THEN EecUDField03
                                        ELSE '329387'
                                    END
                                    /*CASE EecOrgLvl1
                                        WHEN '00' THEN '327053'
                                        WHEN '0092' THEN '327055'
                                        WHEN '0095' THEN '327056'
                                        WHEN '0093' THEN '327057'
                                        WHEN '0094' THEN '327058'
                                        WHEN '0090' THEN '327059'
                                        WHEN '0091' THEN '327060'
                                        WHEN '21' THEN '327061'
                                        WHEN '01' THEN '327062'
                                        WHEN '10' THEN '327063'
                                        WHEN '11' THEN '327064'
                                        WHEN '12' THEN '327065'
                                        WHEN '13' THEN '327066'
                                        WHEN '14' THEN '327067'
                                        WHEN '15' THEN '327068'
                                        WHEN '16' THEN '327069'
                                        WHEN '17' THEN '327070'
                                        WHEN '18' THEN '327071'
                                        WHEN '19' THEN '327072'
                                        WHEN '02' THEN '327073'
                                        WHEN '20' THEN '327074'
                                        WHEN '22' THEN '327075'
                                        WHEN '24' THEN '327076'
                                        WHEN '25' THEN '327077'
                                        WHEN '03' THEN '327078'
                                        WHEN '04' THEN '327079'
                                        WHEN '40' THEN '327080'
                                        WHEN '05' THEN '327081'
                                        WHEN '50' THEN '327082'
                                        WHEN '51' THEN '327083'
                                        WHEN '52' THEN '327084'
                                        WHEN '06' THEN '327085'
                                        WHEN '07' THEN '327086'
                                        WHEN '08' THEN '327087'
                                        WHEN '09' THEN '327088'
                                        WHEN '23' THEN '327054'
                                        ELSE '!' -- + EecOrgLvl1
                                    END*/
        ,drvREF01_RefNumberQual2 
        ,drvREF02_RefNumberQual2     
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1
        ,drvDTP01_DateTimeQualifier1 
        ,drvDTP02_DateTimeFormatQual1
        ,drvDTP03_DateTimePeriod1
        ,drvDTP00_DateTime2 
        ,drvDTP01_DateTimeQualifier2 
        ,drvDTP02_DateTimeFormatQual2
        ,drvDTP03_DateTimePeriod2 
        --=====================
        -- LOOP 2100A RECORDS
        --=====================
        ,drvNM103_NameLast1 
        ,drvNM104_NameFirst1
        ,drvNM105_NameMiddleInitial1
        ,drvNM106_NamePrefix1
        ,drvNM107_NameSuffix1
        ,drvNM108_IDCodeQualifier1
        ,drvNM109_IDCode1 
        ,drvPER02_Name 
        ,drvPER03_CommNumberQualifier
        ,drvPER04_CommunicationNumber
        ,drvPER05_CommNumberQualifier
        ,drvPER06_CommunicationNumber
        ,drvPER07_CommNumberQualifier
        ,drvPER08_CommunicationNumber
        ,drvN301_AddressLine1
        ,drvN302_AddressLine2
        ,drvN401_City
        ,drvN402_State
        ,drvN403_Zip
        ,drvN404_CountryCode
        ,drvDMG02_DateTimePeriod1
        ,drvDMG03_GenderCode1 
        ,drvDMG04_MaritalStatusCode1 
        ,drvICM01_FrequencyCode 
        ,drvICM02_MonetaryAmount 
        ,drvICM03_Quantity 
        ,drvICM04_LocationID
        ,drvAMT00_SegmentID1
        ,drvAMT01_AmountQualifierCode1 
        ,drvAMT02_MonetaryAmount1 
        ,drvAMT00_SegmentID2 
        ,drvAMT01_AmountQualifierCode2 
        ,drvAMT02_MonetaryAmount2 
        ,drvHLH00_SegmentID 
        ,drvHLH01_HealthRelatedCode
        ,drvHLH02_Height 
        ,drvHLH03_Weight1
        ,drvHLH04_Weight2
        ,drvHLH05_Description1 
        ,drvHLH06_CurrentHealthConditionCode 
        ,drvHLH07_Description2 
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID 
        ,drvSSN 
        ,drvInitialSort 
        ,drvSubSort = LEFT(drvSubSort, LEN(drvSubSort)-2) + ' 3'
    FROM dbo.U_ESUNLNC834_DrvTbl
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = drvEEID
        AND EecCOID = drvCOID
    ;

    DECLARE @EmpCount INT
        ,@DedCount INT
    ;

    SELECT @EmpCount = (SELECT COUNT(*) FROM dbo.U_ESUNLNC834_DrvTbl WITH (NOLOCK) WHERE drvINS01_YesNoCond = 'Y');
    SELECT @DedCount = (SELECT COUNT(*) FROM dbo.U_ESUNLNC834_DrvTbl WITH (NOLOCK) WHERE drvINS01_YesNoCond = 'N');

    UPDATE dbo.U_ESUNLNC834_HdrTbl
        SET drvQTY02_Quantity1 = @EmpCount
            ,drvQTY02_Quantity2 = @DedCount
            ,drvQTY02_Quantity3 = @EmpCount + @DedCount
    ;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/

    Update dbo.U_ESUNLNC834_DrvTbl set drvINS17_BirthSequenceNumber = counts
        FROM dbo.U_ESUNLNC834_DrvTbl
        JOIN (
            select drvEEID as eeid,drvCOID as coid,drvDepRecID  as recid,drvDMG02_dateTimePeriod1,count(drvDMG02_dateTimePeriod1) as counts 
            from dbo.U_ESUNLNC834_DrvTbl 
            where drvIns01_YesNoCond  = 'N' 
            group by   drvEEID,drvCOID,drvDepRecID,drvDMG02_dateTimePeriod1 
            having count(drvDMG02_dateTimePeriod1) > 1 
        ) as  Updates
        ON eeid =  drvEEID AND coid =  drvCOID and recid =  drvDepRecID
        and drvINS01_YesNoCond = 'N';

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_ESUNLNC834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC834_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = 'HD'             
        ,drvHD01_MaintTypeCode = CASE WHEN EecEmplStatus = 'T' THEN '024' ELSE '030' END --Audit or Compare
        ,drvHD02_MaintReasonCode = ''
        ,drvHD03_InsuranceLineCode =    CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN BdmDedCode IN ('LTDH','LTD') THEN 'LTD'
                                                    WHEN BdmDedCode IN ('LIF') THEN 'AF'
                                                    WHEN BdmDedCode IN ('SHO') THEN 'STD'
                                                    WHEN BdmDedCode IN ('ACC','CANP1','CRI') THEN 'ZZZ'
                                                    WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                                END
                                            WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP')THEN
                                                CASE WHEN BdmDedCode IN ('LIFS') THEN 'AF'
                                                    WHEN BdmDedCode IN ('ACC','CANP1','CRIES') THEN 'ZZZ'
                                                    WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                                END                                            
                                            WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC')THEN
                                                CASE WHEN BdmDedCode IN ('LIFC') THEN 'AF'
                                                    WHEN BdmDedCode IN ('ACC','CANP1','CRICH') THEN 'ZZZ'
                                                    WHEN BdmDedCode IN ('VIS') THEN 'VIS'
                                                END    
                                        END
        ,drvHD04_PlanCoverageDesc =    CASE WHEN BdmRecType = 'EMP' THEN
                                            CASE WHEN BdmDedCode IN ('LTDH','LTD') THEN 'N'
                                                WHEN BdmDedCode IN ('LIF') THEN 'V'
                                                WHEN BdmDedCode IN ('SHO') THEN 'V/STD'
                                                WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                                WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                                WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                                WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP') THEN
                                            CASE WHEN BdmDedCode IN ('LIFS') THEN 'V'
                                                WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                                WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                                WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                                WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC') THEN
                                            CASE WHEN BdmDedCode IN ('LIFC') THEN 'V'
                                                WHEN BdmDedCode IN ('ACC') THEN 'V/ACC'
                                                WHEN BdmDedCode IN ('CANP1') THEN 'V/CAN'
                                                WHEN BdmDedCode IN ('CRI','CRIES','CRICH') THEN 'V/CIB'
                                                WHEN BdmDedCode IN ('VIS') THEN 'V/EYE'
                                            END
                                    END
        ,drvHD05_CoverageLevelCode = CASE WHEN BdmDedCode IN ('ACC','CANP1','VIS') THEN 
                                            CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                WHEN BdmBenOption IN ('EES','EEDP') THEN 'ESP'
                                                WHEN BdmBenOption IN ('EEC','EECH') THEN 'ECH'
                                                WHEN BdmBenOption IN ('EEF','EEDPF') THEN 'FAM'
                                            END
                                        WHEN BdmRecType = 'EMP' THEN
                                            CASE WHEN BdmDedCode IN ('LTDH','LTD','SHO','CRI') THEN 'EMP'
                                                WHEN BdmDedCode IN ('LIF') THEN 'EMP'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('SPS','DP') THEN
                                            CASE WHEN BdmDedCode IN ('LIFS','CRIES') THEN 'SPO'
                                            END
                                        WHEN BdmRecType = 'DEP' AND ConRelationship IN ('CHL','DIS','DPC','STC') THEN
                                            CASE WHEN BdmDedCode IN ('LIFC','CRICH') THEN 'CHD'
                                            END
                                        END
                -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = 'DTP' 
        ,drvDTP01_DateTimeQualifier_348 = '348' 
        ,drvDTP02_DateTimeFormatQual_348 = 'D8' 
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '10/1/2020') 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN /*BdmDedType IN ('MED','DEN','VIS') AND*/ BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = BdmBenStopDate -- CASE WHEN /*BdmDedType IN ('MED','DEN','VIS')*/ THEN BdmBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = 'DTP' 
        ,drvDTP01_DateTimeQualifier_303 = '300' 
        ,drvDTP02_DateTimeFormatQual_303 = 'D8' 
        ,drvDTP03_DateTimePeriod_303 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, '10/1/2020') 
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedCode IN ('LIF','LIFS','LIFC','CRI','CRIES','CRICH') THEN 'AMT' END 
        ,drvAMT01_AmountQualifierCode1 = 'B9' 
        ,drvAMT02_MonetaryAmount1 =    CASE WHEN BdmDedCode IN ('LTDH','LIF','CRI') THEN BdmUSGField1 
                                        WHEN BdmDedCode IN ('CRIES') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'CRIES')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'CRIES')
                                            END
                                        WHEN BdmDedCode IN ('CRICH') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'CRICH')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'CRICH')
                                            END
                                        WHEN BdmDedCode IN ('LIFS') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'LIFS')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'LIFS')
                                            END
                                        WHEN BdmDedCode IN ('LIFC') THEN 
                                            CASE WHEN BdmRecType = 'EMP' THEN BdmUSGField1 
                                            ELSE  (SELECT TOP 1 EedBenAmt from dbo.EmpDed WITH (NOLOCK) WHERE EedEEID = xEEID AND EedDedCode = 'LIFC')
                                                --(SELECT TOP 1 BdmUSGField1 FROM dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmRecType = 'EMP' AND BdmDedCode = 'LIFC')
                                            END
                                        WHEN BdmDedCode IN ('SHO') THEN FORMAT(EecWeeklyPayRate*.6, '#0.00')
                                        WHEN BdmDedCode IN ('LTD') THEN FORMAT((EecWeeklyPayRate*2)*.6, '#0.00')
                                    END
        --CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
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
                      + ' ' + BdmDedCode + ' 1'
    INTO dbo.U_ESUNLNC834_DrvTbl_2300
    FROM dbo.U_ESUNLNC834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_ESUNLNC834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    INSERT INTO dbo.U_ESUNLNC834_DrvTbl_2300 
    SELECT DISTINCT
        drvHD00_HealthCoverage 
        ,drvHD01_MaintTypeCode 
        ,drvHD02_MaintReasonCode
        ,drvHD03_InsuranceLineCode = 'ADD'
        ,drvHD04_PlanCoverageDesc =    'V' 
        ,drvHD05_CoverageLevelCode 
                -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348
        ,drvDTP01_DateTimeQualifier_348 
        ,drvDTP02_DateTimeFormatQual_348 
        ,drvDTP03_DateTimePeriod_348 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 
        ,drvDTP01_DateTimeQualifier_349 
        ,drvDTP02_DateTimeFormatQual_349 
        ,drvDTP03_DateTimePeriod_349 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 
        ,drvDTP01_DateTimeQualifier_303 
        ,drvDTP02_DateTimeFormatQual_303 
        ,drvDTP03_DateTimePeriod_303 
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 
        ,drvREF01_RefNumberQual1 
        ,drvREF02_RefNumberQual1 
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 
        ,drvREF01_RefNumberQual2 
        ,drvREF02_RefNumberQual2 
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 
        ,drvAMT01_AmountQualifierCode1 
        ,drvAMT02_MonetaryAmount1 
        --CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 
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
        ,drvN101_EntityIDCodeSponsor 
        ,drvN102_Name 
        -- If drvREF01_RefNumberQual is Populated, then send REF Segment
        ,drvREF01_RefNumberQual 
        ,drvREF02_RefNumberDesc 
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID 
        ,drvSSN 
        ,drvInitialSort 
        ,drvSubSort = LEFT(drvSubSort, LEN(drvSubSort) - 1) + '2'        
    FROM dbo.U_ESUNLNC834_DrvTbl_2300 WITH (NOLOCK)
    WHERE drvHD03_InsuranceLineCode = 'AF'
    ;
    
    DELETE dbo.U_ESUNLNC834_DrvTbl_2300 WHERE drvHD03_InsuranceLineCode IS NULL;



    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_ESUNLNC834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_ESUNLNC834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_ESUNLNC834_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('ESUNLNC834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'PWC_ESUNLNC834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'ESUNLNC834';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwESUNLNC834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_ESUNLNC834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDef
WHERE AdfHeaderSystemID LIKE 'ESUNLNC834%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202101011'
       ,ExpStartPerControl     = '202101011'
       ,ExpLastEndPerControl   = '202103249'
       ,ExpEndPerControl       = '202103249'
WHERE ExpFormatCode = 'ESUNLNC834';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwESUNLNC834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_ESUNLNC834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)