SET NOCOUNT ON;
IF OBJECT_ID('U_EATNA834MD_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EATNA834MD_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EATNA834MD' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEATNA834MD_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEATNA834MD_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EATNA834MD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EATNA834MD];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EATNA834MD') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EATNA834MD];
GO
IF OBJECT_ID('U_EATNA834MD_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_TrlTbl];
GO
IF OBJECT_ID('U_EATNA834MD_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_HdrTbl];
GO
IF OBJECT_ID('U_EATNA834MD_File_Temp') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_File_Temp];
GO
IF OBJECT_ID('U_EATNA834MD_File') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_File];
GO
IF OBJECT_ID('U_EATNA834MD_EEList') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_EEList];
GO
IF OBJECT_ID('U_EATNA834MD_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_DrvTbl_2300];
GO
IF OBJECT_ID('U_EATNA834MD_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_DrvTbl];
GO
IF OBJECT_ID('U_EATNA834MD_DedList') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EATNA834MD') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EATNA834MD];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EATNA834MD';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EATNA834MD';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EATNA834MD';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EATNA834MD';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EATNA834MD';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EATNA834MD','Aetna Med 834 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EATNA834MDZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EATNA834MD' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISA"','1','(''DA''=''F*'')','EATNA834MDZ0','3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''F*'')','EATNA834MDZ0','2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F*'')','EATNA834MDZ0','10','H','01','3',NULL,'Authorization Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','4','(''DA''=''F*'')','EATNA834MDZ0','2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F*'')','EATNA834MDZ0','10','H','01','5',NULL,'Security Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA05_SenderIDQual"','6','(''UA''=''F*'')','EATNA834MDZ0','2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA06_SenderID"','7','(''UA''=''F*'')','EATNA834MDZ0','15','H','01','7',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA07_ReceiverIDQual"','8','(''UA''=''F*'')','EATNA834MDZ0','2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA08_ReceiverID"','9','(''UA''=''F*'')','EATNA834MDZ0','15','H','01','9',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA09_InterchangeDate"','10','(''UD12''=''F*'')','EATNA834MDZ0','6','H','01','10',NULL,'Interchange Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA10_InterchangeTime"','11','(''UA''=''F*'')','EATNA834MDZ0','4','H','01','11',NULL,'Interchange Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"^"','12','(''DA''=''F*'')','EATNA834MDZ0','1','H','01','12',NULL,'Repetition Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00501"','13','(''DA''=''F*'')','EATNA834MDZ0','5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','14','(''DA''=''F*'')','EATNA834MDZ0','9','H','01','14',NULL,'Interchange Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0"','15','(''DA''=''F*'')','EATNA834MDZ0','1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA15_UsageIndicator"','16','(''UA''=''F*'')','EATNA834MDZ0','1','H','01','16',NULL,'Usage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('":"','17','(''DA''=''F*'')','EATNA834MDZ0','1','H','01','17',NULL,'Component Element Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GS"','1','(''DA''=''T*'')','EATNA834MDZ0','2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BE"','2','(''DA''=''T*'')','EATNA834MDZ0','2','H','02','2',NULL,'Functional ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS02_SenderID"','3','(''UA''=''T*'')','EATNA834MDZ0','15','H','02','3',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS03_ReceiverID"','4','(''UA''=''T*'')','EATNA834MDZ0','15','H','02','4',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS04_Date"','5','(''UD112''=''T*'')','EATNA834MDZ0','8','H','02','5',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS05_Time"','6','(''UA''=''T*'')','EATNA834MDZ0','8','H','02','6',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','7','(''DA''=''T*'')','EATNA834MDZ0','9','H','02','7',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"X"','8','(''DA''=''T*'')','EATNA834MDZ0','2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','9','(''DA''=''T*'')','EATNA834MDZ0','12','H','02','9',NULL,'Version/Release  Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ST"','1','(''DA''=''T*'')','EATNA834MDZ0','2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"834"','2','(''DA''=''T*'')','EATNA834MDZ0','3','H','03','2',NULL,'Transaction ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EATNA834MDZ0','9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','4','(''DA''=''T*'')','EATNA834MDZ0','35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BGN"','1','(''DA''=''T*'')','EATNA834MDZ0','3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''T*'')','EATNA834MDZ0','2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EATNA834MDZ0','50','H','04','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN03_Date"','4','(''UD112''=''T*'')','EATNA834MDZ0','8','H','04','4',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN04_Time"','5','(''UA''=''T*'')','EATNA834MDZ0','8','H','04','5',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN05_TimeCode"','6','(''UA''=''T*'')','EATNA834MDZ0','2','H','04','6',NULL,'Time Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN06_RefID"','7','(''UA''=''T*'')','EATNA834MDZ0','50','H','04','7',NULL,'Reference Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN07_TransTypeCode"','8','(''UA''=''T*'')','EATNA834MDZ0','2','H','04','8',NULL,'Transaction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN08_ActionCode"','9','(''UA''=''T*'')','EATNA834MDZ0','2','H','04','9',NULL,'Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EATNA834MDZ0','3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','EATNA834MDZ0','3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual"','3','(''UA''=''T*'')','EATNA834MDZ0','50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DTP"','1','(''DA''=''T*'')','EATNA834MDZ0','3','H','06','1',NULL,'REF Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier1"','2','(''UA''=''T*'')','EATNA834MDZ0','50','H','06','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual1"','3','(''UA''=''T*'')','EATNA834MDZ0','50','H','06','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod1"','4','(''UD112''=''T*'')','EATNA834MDZ0','50','H','06','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EATNA834MDZ0','3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual1"','2','(''UA''=''T*'')','EATNA834MDZ0','2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity1"','3','(''UA''=''T*'')','EATNA834MDZ0','15','H','07','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EATNA834MDZ0','3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual2"','2','(''UA''=''T*'')','EATNA834MDZ0','2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity2"','3','(''UA''=''T*'')','EATNA834MDZ0','15','H','08','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EATNA834MDZ0','3','H','09','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual3"','2','(''UA''=''T*'')','EATNA834MDZ0','2','H','09','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity3"','3','(''UA''=''T*'')','EATNA834MDZ0','15','H','09','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EATNA834MDZ0','2','H','10','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor1"','2','(''UA''=''T*'')','EATNA834MDZ0','3','H','10','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name1"','3','(''UA''=''T*'')','EATNA834MDZ0','60','H','10','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual1"','4','(''UA''=''T*'')','EATNA834MDZ0','2','H','10','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode1"','5','(''UA''=''T*'')','EATNA834MDZ0','80','H','10','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EATNA834MDZ0','2','H','11','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor2"','2','(''UA''=''T*'')','EATNA834MDZ0','3','H','11','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name2"','3','(''UA''=''T*'')','EATNA834MDZ0','60','H','11','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual2"','4','(''UA''=''T*'')','EATNA834MDZ0','2','H','11','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode2"','5','(''UA''=''T*'')','EATNA834MDZ0','80','H','11','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INS"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','12','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS01_YesNoCond"','2','(''UA''=''T*'')','EATNA834MDZ0','1','D','12','2',NULL,'Yes/No Condition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS02_RelationshipCode"','3','(''UA''=''T*'')','EATNA834MDZ0','2','D','12','3',NULL,'Individual Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS03_MaintTypeCode"','4','(''UA''=''T*'')','EATNA834MDZ0','3','D','12','4',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS04_MaintReasonCode"','5','(''UA''=''T*'')','EATNA834MDZ0','3','D','12','5',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS05_BenefitStatusCode"','6','(''UA''=''T*'')','EATNA834MDZ0','1','D','12','6',NULL,'Benefit Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0601_MEDICAREPLANCODE"','7','(''UA''=''T'')','EATNA834MDZ0','1','D','12','7',NULL,'MEDICARE PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0602_EligibilityRsnCode"','8','(''UA''=''T*'')','EATNA834MDZ0','1','D','12','8',NULL,'Eligibility Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS07_COBRAQualEventCode"','9','(''UA''=''T*'')','EATNA834MDZ0','2','D','12','9',NULL,'COBRA Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS08_EmploymentStatusCode"','10','(''UA''=''T*'')','EATNA834MDZ0','2','D','12','10',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS09_StudentStatusCode"','11','(''UA''=''T*'')','EATNA834MDZ0','1','D','12','11',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS10_ResponseCode"','12','(''UA''=''T*'')','EATNA834MDZ0','1','D','12','12',NULL,'Response Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS11_DateTimeFormatQual"','13','(''UA''=''T*'')','EATNA834MDZ0','3','D','12','13',NULL,'Date Time Period Format Qualif',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS12_DateTimePeriod"','14','(''UD112''=''T*'')','EATNA834MDZ0','35','D','12','14',NULL,'Date Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','13','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0F"','2','(''DA''=''T*'')','EATNA834MDZ0','3','D','13','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T*'')','EATNA834MDZ0','50','D','13','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','EATNA834MDZ0','50','D','14','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','15','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','15','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','EATNA834MDZ0','50','D','15','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime1"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','16','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier1"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','16','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual1"','3','(''UA''=''T*'')','EATNA834MDZ0','3','D','16','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod1"','4','(''UD112''=''T*'')','EATNA834MDZ0','35','D','16','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime2"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','17','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier2"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','17','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual2"','3','(''UA''=''T*'')','EATNA834MDZ0','3','D','17','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod2"','4','(''UD112''=''T*'')','EATNA834MDZ0','35','D','17','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NM1"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','20','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IL"','2','(''DA''=''T*'')','EATNA834MDZ0','3','D','20','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','3','(''DA''=''T*'')','EATNA834MDZ0','1','D','20','3',NULL,'Entity Type Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM103_NameLast1"','4','(''UA''=''T*'')','EATNA834MDZ0','60','D','20','4',NULL,'Name Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM104_NameFirst1"','5','(''UA''=''T*'')','EATNA834MDZ0','35','D','20','5',NULL,'Name First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM105_NameMiddleInitial1"','6','(''UA''=''T*'')','EATNA834MDZ0','25','D','20','6',NULL,'Name Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM106_NamePrefix1"','7','(''UA''=''T*'')','EATNA834MDZ0','10','D','20','7',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM107_NameSuffix1"','8','(''UA''=''T*'')','EATNA834MDZ0','10','D','20','8',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM108_IDCodeQualifier1"','9','(''UA''=''T*'')','EATNA834MDZ0','2','D','20','9',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM109_IDCode1"','10','(''UA''=''T*'')','EATNA834MDZ0','80','D','20','10',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','21','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IP"','2','(''DA''=''T*'')','EATNA834MDZ0','2','D','21','2',NULL,'Contact Function Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER02_Name"','3','(''UA''=''T*'')','EATNA834MDZ0','60','D','21','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER03_CommNumberQualifier"','4','(''UA''=''T*'')','EATNA834MDZ0','3','D','21','4',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER04_CommunicationNumber"','5','(''UA''=''T*'')','EATNA834MDZ0','256','D','21','5',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER05_CommNumberQualifier"','6','(''UA''=''T*'')','EATNA834MDZ0','3','D','21','6',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER06_CommunicationNumber"','7','(''UA''=''T*'')','EATNA834MDZ0','256','D','21','7',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER07_CommNumberQualifier"','8','(''UA''=''T*'')','EATNA834MDZ0','3','D','21','8',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER08_CommunicationNumber"','9','(''UA''=''T*'')','EATNA834MDZ0','256','D','21','9',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N3"','1','(''DA''=''T*'')','EATNA834MDZ0','2','D','22','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN301_AddressLine1"','2','(''UA''=''T*'')','EATNA834MDZ0','55','D','22','2',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN302_AddressLine2"','3','(''UA''=''T*'')','EATNA834MDZ0','55','D','22','3',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N4"','1','(''DA''=''T*'')','EATNA834MDZ0','2','D','23','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN401_City"','2','(''UA''=''T*'')','EATNA834MDZ0','30','D','23','2',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN402_State"','3','(''UA''=''T*'')','EATNA834MDZ0','2','D','23','3',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN403_Zip"','4','(''UA''=''T*'')','EATNA834MDZ0','15','D','23','4',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN404_CountryCode"','5','(''UA''=''T*'')','EATNA834MDZ0','3','D','23','5',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMG"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','24','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D8"','2','(''DA''=''T*'')','EATNA834MDZ0','3','D','24','2',NULL,'Date/Time Format Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG02_DateTimePeriod1"','3','(''UD112''=''T*'')','EATNA834MDZ0','35','D','24','3',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG03_GenderCode1"','4','(''UA''=''T*'')','EATNA834MDZ0','1','D','24','4',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG04_MaritalStatusCode1"','5','(''UA''=''T*'')','EATNA834MDZ0','1','D','24','5',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ICM"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','25','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM01_FrequencyCode"','2','(''UA''=''T*'')','EATNA834MDZ0','1','D','25','2',NULL,'Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM02_MonetaryAmount"','3','(''UA''=''T*'')','EATNA834MDZ0','18','D','25','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM03_Quantity"','4','(''UA''=''T*'')','EATNA834MDZ0','15','D','25','4',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM04_LocationID"','5','(''UA''=''T*'')','EATNA834MDZ0','30','D','25','5',NULL,'Location Identifier Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID1"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','26','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','EATNA834MDZ0','18','D','26','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','EATNA834MDZ0','1','D','26','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID2"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','27','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','EATNA834MDZ0','18','D','27','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','EATNA834MDZ0','1','D','27','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH00_SegmentID"','1','(''UA''=''T*'')','EATNA834MDZ0','1','D','28','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH01_HealthRelatedCode"','2','(''UA''=''T*'')','EATNA834MDZ0','8','D','28','2',NULL,'Health-Related Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH02_Height"','3','(''UA''=''T*'')','EATNA834MDZ0','10','D','28','3',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH03_Weight1"','4','(''UA''=''T*'')','EATNA834MDZ0','10','D','28','4',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH04_Weight2"','5','(''UA''=''T*'')','EATNA834MDZ0','10','D','28','5',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH05_Description1"','6','(''UA''=''T*'')','EATNA834MDZ0','10','D','28','6',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH06_CurrentHealthConditionCode"','7','(''UA''=''T*'')','EATNA834MDZ0','10','D','28','7',NULL,'Current Health Condition Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH07_Description2"','8','(''UA''=''T*'')','EATNA834MDZ0','10','D','28','8',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD00_HealthCoverage"','1','(''UA''=''T*'')','EATNA834MDZ0','2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD01_MaintTypeCode"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD02_MaintReasonCode"','3','(''UA''=''T*'')','EATNA834MDZ0','3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD03_InsuranceLineCode"','4','(''UA''=''T*'')','EATNA834MDZ0','3','D','40','4',NULL,'Insurance Line Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD04_PlanCoverageDesc"','5','(''UA''=''T*'')','EATNA834MDZ0','50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD05_CoverageLevelCode"','6','(''UA''=''T*'')','EATNA834MDZ0','3','D','40','6',NULL,'Coverage Level Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_348"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_348"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_348"','3','(''UA''=''T*'')','EATNA834MDZ0','3','D','41','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_348"','4','(''UD112''=''T*'')','EATNA834MDZ0','35','D','41','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_349"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_349"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_349"','3','(''UA''=''T*'')','EATNA834MDZ0','3','D','42','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_349"','4','(''UD112''=''T*'')','EATNA834MDZ0','35','D','42','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_303"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_303"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_303"','3','(''UA''=''T*'')','EATNA834MDZ0','3','D','43','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_303"','4','(''UD112''=''T*'')','EATNA834MDZ0','35','D','43','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual1"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','EATNA834MDZ0','50','D','45','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual2"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','EATNA834MDZ0','50','D','46','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode1"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','EATNA834MDZ0','18','D','50','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode2"','1','(''UA''=''T*'')','EATNA834MDZ0','3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','EATNA834MDZ0','18','D','51','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LS"','1','(''DA''=''T*'')','EATNA834MDZ0','2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLS01_LoopIDCode"','2','(''UA''=''T*'')','EATNA834MDZ0','6','D','80','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LX"','1','(''DA''=''T*'')','EATNA834MDZ0','2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLX01_AssignedNumber"','2','(''UA''=''T*'')','EATNA834MDZ0','6','D','81','2',NULL,'Assigned Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EATNA834MDZ0','2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name"','3','(''UA''=''T*'')','EATNA834MDZ0','60','D','85','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','EATNA834MDZ0','3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberDesc"','3','(''UA''=''T*'')','EATNA834MDZ0','50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LE"','1','(''DA''=''T*'')','EATNA834MDZ0','3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLE01_LoopIDCode"','2','(''UA''=''T*'')','EATNA834MDZ0','6','D','87','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SE"','1','(''DA''=''T*'')','EATNA834MDZ0','2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSE01_SegmentCount"','2','(''UA''=''T*'')','EATNA834MDZ0','10','T','90','2',NULL,'Number of Included Segments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EATNA834MDZ0','9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GE"','1','(''DA''=''T*'')','EATNA834MDZ0','2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','EATNA834MDZ0','6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','3','(''DA''=''T*'')','EATNA834MDZ0','9','T','91','3',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IEA"','1','(''DA''=''T*'')','EATNA834MDZ0','3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','EATNA834MDZ0','5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','3','(''DA''=''T*'')','EATNA834MDZ0','9','T','92','3',NULL,'Interchange Control Number',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EATNA834MD_20211026.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Changes Only File','202010139','EMPEXPORT','CHANGES','Oct 13 2020  4:12PM','EATNA834MD',NULL,NULL,NULL,'202010139','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202009291','7374','','','202009291',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Full File Only','202110151','EMPEXPORT','FULLFILE','Oct 15 2021 11:58AM','EATNA834MD',NULL,NULL,NULL,'202110151','Oct 15 2021 12:00AM','Dec 30 1899 12:00AM','202110151','12453','','','202110151',dbo.fn_GetTimedKey(),NULL,'RVAS',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Active Open Enrollment','202101011','EMPEXPORT','OEACTIVE','Jan  5 2021  5:27PM','EATNA834MD',NULL,NULL,NULL,'202101011','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202012271','17350','','','202012271',dbo.fn_GetTimedKey(),NULL,'us3cPeACS1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Passive Open Enrollment','202012271','EMPEXPORT','OEPASSIVE','Dec 23 2020  3:28PM','EATNA834MD',NULL,NULL,NULL,'202012271','Dec 27 2020 12:00AM','Dec 30 1899 12:00AM','202012271','17716','','','202012271',dbo.fn_GetTimedKey(),NULL,'us3cPeACS1003',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Aetna Med 834 Export','202012309','EMPEXPORT','SCHEDULED','Oct 13 2020  4:13PM','EATNA834MD',NULL,NULL,NULL,'202101159','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202101081','7374','','','202012301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Test File Only','202110151','EMPEXPORT','TESTFILE','Oct 15 2021 12:00AM','EATNA834MD',NULL,NULL,NULL,'202110151','Oct 15 2021 12:00AM','Dec 30 1899 12:00AM','202110011','13403','','','202110011',dbo.fn_GetTimedKey(),NULL,'RVAS',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EATNA834MD','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EATNA834MD' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EATNA834MD' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EATNA834MD_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EATNA834MD_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H01','U_EATNA834MD_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H02','U_EATNA834MD_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H03','U_EATNA834MD_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H04','U_EATNA834MD_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H05','U_EATNA834MD_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H06','U_EATNA834MD_HdrTbl','ISNULL(drvDTP01_DateTimeQualifier1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H07','U_EATNA834MD_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H08','U_EATNA834MD_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H09','U_EATNA834MD_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H10','U_EATNA834MD_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','H11','U_EATNA834MD_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D12','U_EATNA834MD_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D13','U_EATNA834MD_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D14','U_EATNA834MD_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D15','U_EATNA834MD_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D16','U_EATNA834MD_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D17','U_EATNA834MD_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D20','U_EATNA834MD_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D21','U_EATNA834MD_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D22','U_EATNA834MD_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D23','U_EATNA834MD_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D24','U_EATNA834MD_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D25','U_EATNA834MD_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D26','U_EATNA834MD_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D27','U_EATNA834MD_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D28','U_EATNA834MD_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D40','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D41','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D42','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D43','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D45','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D46','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D50','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D51','U_EATNA834MD_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D80','U_EATNA834MD_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D81','U_EATNA834MD_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D85','U_EATNA834MD_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D86','U_EATNA834MD_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','D87','U_EATNA834MD_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','T90','U_EATNA834MD_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','T91','U_EATNA834MD_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EATNA834MD','T92','U_EATNA834MD_TrlTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EATNA834MD') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EATNA834MD] (
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
IF OBJECT_ID('U_EATNA834MD_DedList') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedLongDesc] varchar(40) NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EATNA834MD_DrvTbl') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_DrvTbl] (
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
    [drvINS11_DateTimeFormatQual] varchar(2) NULL,
    [drvINS12_DateTimePeriod] varchar(8) NULL,
    [drvREF01_RefNumberQual1] varchar(2) NOT NULL,
    [drvREF02_RefNumberQual1] varchar(7) NOT NULL,
    [drvREF01_RefNumberQual2] varchar(1) NOT NULL,
    [drvREF02_RefNumberQual2] varchar(1) NOT NULL,
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
IF OBJECT_ID('U_EATNA834MD_DrvTbl_2300') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_DrvTbl_2300] (
    [drvHD00_HealthCoverage] varchar(2) NULL,
    [drvHD01_MaintTypeCode] varchar(3) NOT NULL,
    [drvHD02_MaintReasonCode] varchar(1) NOT NULL,
    [drvHD03_InsuranceLineCode] varchar(3) NULL,
    [drvHD04_PlanCoverageDesc] varchar(274) NOT NULL,
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
    [drvREF00_RefNumberQual1] varchar(3) NULL,
    [drvREF01_RefNumberQual1] varchar(2) NULL,
    [drvREF02_RefNumberQual1] varchar(7) NULL,
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
    [drvSubSort] varchar(24) NULL
);
IF OBJECT_ID('U_EATNA834MD_EEList') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EATNA834MD_File') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EATNA834MD_File_Temp') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_File_Temp] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EATNA834MD_HdrTbl') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_HdrTbl] (
    [drvISA05_SenderIDQual] varchar(2) NOT NULL,
    [drvISA06_SenderID] varchar(9) NOT NULL,
    [drvISA07_ReceiverIDQual] varchar(2) NOT NULL,
    [drvISA08_ReceiverID] varchar(9) NOT NULL,
    [drvISA09_InterchangeDate] varchar(6) NULL,
    [drvISA10_InterchangeTime] varchar(4) NULL,
    [drvISA15_UsageIndicator] varchar(1) NOT NULL,
    [drvGS02_SenderID] varchar(9) NOT NULL,
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
    [drvREF02_RefNumberQual] varchar(7) NOT NULL,
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
    [drvN102_Name1] varchar(10) NOT NULL,
    [drvN103_IDCodeQual1] varchar(2) NOT NULL,
    [drvN104_IDCode1] varchar(9) NOT NULL,
    [drvN101_EntityIDCodeSponsor2] varchar(2) NOT NULL,
    [drvN102_Name2] varchar(5) NOT NULL,
    [drvN103_IDCodeQual2] varchar(2) NOT NULL,
    [drvN104_IDCode2] varchar(9) NOT NULL
);
IF OBJECT_ID('U_EATNA834MD_TrlTbl') IS NULL
CREATE TABLE [dbo].[U_EATNA834MD_TrlTbl] (
    [drvSE01_SegmentCount] varchar(4) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EATNA834MD]
AS
SET NOCOUNT ON;
/************************************************************
Client: Mercy Corp

Created By: Inshan Singh
Create Date: 04/03/2021
ChangePoint Request Number: TekP-2020-11-18-0001

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
    WHILE (SELECT COUNT(*) FROM dbo.U_EATNA834MD_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_EATNA834MD_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_EATNA834MD_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_EATNA834MD_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_EATNA834MD_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';


    -- For some reason I could not figure out, the DEN and VIS segments were getting duplicated somewhere between the main script and here. This removes duplicate records - J Bender
    IF OBJECT_ID('dbo.U_EATNA834MD_File_Temp') IS NOT NULL
        DROP TABLE dbo.U_EATNA834MD_File_Temp;
    SELECT DISTINCT RecordSet, InitialSort, SubSort, SubSort2, SubSort3, Data
    INTO dbo.U_EATNA834MD_File_Temp
    FROM dbo.U_EATNA834MD_File (NOLOCK);

    DELETE dbo.U_EATNA834MD_File;

    INSERT INTO dbo.U_EATNA834MD_File --(RecordSet, InitialSort, SubSort, SubSort2, SubSort3, Data)
    SELECT *
    FROM dbo.U_EATNA834MD_File_Temp WITH (NOLOCK)






    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_EATNA834MD_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_EATNA834MD_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EATNA834MD]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Mercy Corp

Created By: Inshan Singh
Business Analyst: Richard Vars
Create Date: 04/03/2021
Service Request Number: TekP-2020-11-18-0001

Purpose: Aetna Med 834 Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX
001+0170546+011+00001+26300+131
SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EATNA834MD';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EATNA834MD';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EATNA834MD';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EATNA834MD';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EATNA834MD' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EATNA834MD', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EATNA834MD', 'TESTFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EATNA834MD', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EATNA834MD', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EATNA834MD', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EATNA834MD', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EATNA834MD';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EATNA834MD', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = CAST('1/1/' + CAST(DATEPART(YEAR, GETDATE()) AS VARCHAR) AS DATE)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EATNA834MD';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'USHDP, USPPO';

    IF OBJECT_ID('U_EATNA834MD_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EATNA834MD_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EATNA834MD_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EATNA834MD_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EATNA834MD_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    DELETE FROM dbo.U_EATNA834MD_EEList WHERE xEEID IN (
        SELECT DISTINCT EecEEID FROM dbo.EmpComp WITH (NOLOCK) WHERE EecEEType IN ('Z','') OR EecEEType IS NULL
    )

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EATNA834MD_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EATNA834MD_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DCH,DPC,STC');
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

    --DELETE dbo.U_dsi_bdm_EATNA834MD 
    --WHERE BdmEEID = '8YNYLV0010K0'
    --AND BdmDedCode = 'MHSA';

    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_EATNA834MD D
    JOIN dbo.U_dsi_bdm_EATNA834MD E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EATNA834MD
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EATNA834MD
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EATNA834MD
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EATNA834MD
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EATNA834MD
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EATNA834MD
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
    IF OBJECT_ID('U_EATNA834MD_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EATNA834MD_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = '911148123'
        ,drvISA07_ReceiverIDQual = '30' --'ZZ'
        ,drvISA08_ReceiverID = '042064683'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y'  OR  @ExportCode = 'TESTFILE' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = '911148123'
        ,drvGS03_ReceiverID = 'MERCYCORP'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ES'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = '0170546'
        ,drvDTP01_DateTimeQualifier1 = '007'  -- DTP in header
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = GETDATE()
        ,drvQTY01_QuantityQual1 = 'ET'
        ,drvQTY02_Quantity1 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK) WHERE BdmRecType = 'EMP')
        ,drvQTY01_QuantityQual2 = 'DT'
        ,drvQTY02_Quantity2 = (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK) WHERE BdmRecType = 'DEP')
        ,drvQTY01_QuantityQual3 = 'TO'
        ,drvQTY02_Quantity3 = (SELECT COUNT(DISTINCT BdmEEID) FROM dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK) WHERE BdmRecType = 'EMP') + (SELECT COUNT(DISTINCT BdmDepRecId) FROM dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK) WHERE BdmRecType = 'DEP')
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'Mercy Corp'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = '911148123'
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'Aetna'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '953402799'
    INTO dbo.U_EATNA834MD_HdrTbl
    FROM dbo.U_EATNA834MD_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2000 RECORDS - INS, REF, DTP Segments
            -- LOOP 2100A RECORDS - NM1, PER, N3, N4, DMG, ICM Segments
            -- LOOP 2100B RECORDS - NM1, DMG Segments
    ***************************************************************************************************************/

    -- We're not sure where this dependent id is coming from. It doesn't exist in the system at all. 
    -- May be a glitch, or an import error. Richard Vars is checking with client, but for now 
    -- we're just going to delete it from the BDM table
    DELETE dbo.U_dsi_bdm_EATNA834MD WHERE BdmDepRecId = 'DH3XFB00E030';

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_EATNA834MD_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EATNA834MD_DrvTbl;
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
                                                     WHEN ConRelationship IN ('CHL,DCH,DPC,STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                    ELSE 'FT'
                                                     --WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     --WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                END
                                         END
        ,drvINS09_StudentStatusCode = CASE WHEN BdmRecType = 'DEP' THEN
                                                CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
                                      END
        ,drvINS10_ResponseCode = CASE WHEN BdmRecType = 'EMP' AND ConRelationship IN ('DCH') AND ConIsDisabled = 'Y' THEN 'Y' END 
                                /*CASE WHEN BdmRecType = 'EMP' THEN
                                        CASE WHEN EepIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                      WHEN BdmRecType = 'DEP' THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END*/
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = '1L'
        ,drvREF02_RefNumberQual1 = '0170546'
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = 'DTP'
        ,drvDTP01_DateTimeQualifier1 = '336'
        ,drvDTP02_DateTimeFormatQual1 = 'D8'
        ,drvDTP03_DateTimePeriod1 = EecDateOfLastHire
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
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' AND EepNameSuffix <> 'Z' THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' AND ConNameSuffix <> 'Z' THEN ConNameSuffix
                                END
        ,drvNM108_IDCodeQualifier1 =    CASE WHEN BdmRecType = 'EMP' AND NOT (EepSSN IN ('000000000','999999999', '123456789') OR RIGHT(EepSSN, 3) IN ('999','998')) THEN '34'
                                            WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '123456789') OR RIGHT(ConSSN, 3) IN ('999','998')) THEN '34'
                                        END
        
                                    /*CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN '34'
                                     END*/
        ,drvNM109_IDCode1 =    CASE WHEN BdmRecType = 'EMP' AND NOT (EepSSN IN ('000000000','999999999', '123456789') OR RIGHT(EepSSN, 3) IN ('999','998')) THEN EepSSN
                                WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '123456789') OR RIGHT(ConSSN, 3) IN ('999','998')) THEN ConSSN
                            END
                            /*CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END*/
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN 'HP'
                                            WHEN BdmRecType = 'EMP' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM'
                                        END
                                            --CASE WHEN BdmRecType = 'EMP' THEN 'HP' END
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber
                                            WHEN BdmRecType = 'EMP' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail
                                        END
                                            --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EepPhoneHomeNumber,'') END
        ,drvPER05_CommNumberQualifier =    CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM' END
                                            --CASE WHEN BdmRecType = 'EMP' THEN 'WP' END
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail END
                                            --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(EecPhoneBusinessNumber,'') END
        ,drvPER07_CommNumberQualifier = '' --CASE WHEN BdmRecType = 'EMP' THEN 'EM' END
        ,drvPER08_CommunicationNumber = '' --CASE WHEN BdmRecType = 'EMP' THEN ISNULL(eepAddressEMail,'') END
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = EepAddressZipCode
        ,drvN404_CountryCode = CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' AND EepGender IN ('F','M') THEN EepGender
                                     WHEN BdmRecType = 'DEP' AND ConGender IN ('F','M') THEN ConGender
                                     ELSE 'M'
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepMaritalStatus 
                                                    WHEN 'M' THEN 'M' 
                                                    WHEN 'S' THEN 'I' 
                                                    ELSE 'R' 
                                                END
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
    INTO dbo.U_EATNA834MD_DrvTbl
    FROM dbo.U_EATNA834MD_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK)
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
    IF OBJECT_ID('U_EATNA834MD_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EATNA834MD_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                        WHEN BdmDedType IN ('DEN') THEN 'HD'
                                        WHEN BdmDedType IN ('VIS') THEN 'HD'
                                 END
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = '' /*CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END*/
        ,drvHD03_InsuranceLineCode =    CASE WHEN BdmDedCode IN ('USHDP', 'USPPO' ) THEN 'HLT'
                                        END
                                        /*CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END*/
        ,drvHD04_PlanCoverageDesc =    CASE 

                                            WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE') THEN '001+0170546+011+00001+78800+131'
                                            WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EECH','EEFAM','EES') THEN '001+0170546+011+00001+78900+131'
                                            WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1') THEN '001+0170546+010+00001+78100+131'
                                            WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '001+0170546+010+00002+78400+131'
                                            

                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'IN' THEN '001+0170546+011+00001+26600+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'IN' THEN '001+0170546+011+00001+26500+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'IN' THEN '001+0170546+010+00001+12800+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'IN' THEN '001+0170546+010+00002+12900+131'


                                            -- AR values Cheryl got from the client
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'AR' THEN '001+0170546+011+00001+78700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'AR' THEN '001+0170546+011+00001+78600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'AR' THEN '001+0170546+010+00001+78000+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'AR' THEN '001+0170546+010+00002+78300+131'

                                            --Filling in holes with value Lea got from system
                                            WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE') THEN '001+0170546+011+00001+78600+131'
                                            WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EECH','EEFAM','EES') THEN '001+0170546+011+00001+78700+131'
                                            WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1') THEN '001+0170546+010+00001+78000+131'
                                            WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USPPO')    AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '001+0170546+010+00002+78300+131'
                                            



                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'AZ' THEN '001+0170546+010+00001+02400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'AZ' THEN '001+0170546+010+00002+12400+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'AZ' THEN '001+0170546+011+00001+24700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'AZ' THEN '001+0170546+011+00001+24800+131'


                                            -- CA values Cheryl got from the client
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'CA' THEN '001+0170546+010+00001+00200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'CA' THEN '001+0170546+010+00002+10200+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'CA' THEN '001+0170546+011+00001+20300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'CA' THEN '001+0170546+011+00001+20400+131'

                                            --Filling in holes with value Lea got from system
                                            
                                            WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE') THEN '001+0170546+011+00001+20300+131'
                                            WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USHDP') AND BdmBenOption IN ('EECH','EEFAM','EES') THEN '001+0170546+011+00001+20400+131'
                                            WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1') THEN '001+0170546+010+00001+00200+131'
                                            WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '001+0170546+010+00002+10200+131'
                                            


                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'CO' THEN '001+0170546+010+00001+00300+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'CO' THEN '001+0170546+010+00002+10300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'CO' THEN '001+0170546+011+00001+20500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'CO' THEN '001+0170546+011+00001+20600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'DC' THEN '001+0170546+010+00001+00400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'DC' THEN '001+0170546+010+00002+10400+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'DC' THEN '001+0170546+011+00001+20700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'DC' THEN '001+0170546+011+00001+20800+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'DE' THEN '001+0170546+010+00001+02700+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'DE' THEN '001+0170546+010+00002+12700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'DE' THEN '001+0170546+011+00001+25300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'DE' THEN '001+0170546+011+00001+25400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'FL' THEN '001+0170546+010+00001+00500+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'FL' THEN '001+0170546+010+00002+10500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'FL' THEN '001+0170546+011+00001+20900+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'FL' THEN '001+0170546+011+00001+21000+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'GA' THEN '001+0170546+010+00001+00600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'GA' THEN '001+0170546+010+00002+10600+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'GA' THEN '001+0170546+011+00001+21100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'GA' THEN '001+0170546+011+00001+21200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'ID' THEN '001+0170546+010+00001+00700+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'ID' THEN '001+0170546+010+00002+10700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'ID' THEN '001+0170546+011+00001+21300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'ID' THEN '001+0170546+011+00001+21400+131'

                                            
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'LA' THEN '001+0170546+010+00001+00800+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'LA' THEN '001+0170546+010+00002+10800+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'LA' THEN '001+0170546+011+00001+21500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'LA' THEN '001+0170546+011+00001+21600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'MA' THEN '001+0170546+010+00001+01100+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MA' THEN '001+0170546+010+00002+11100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'MA' THEN '001+0170546+011+00001+22100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'MA' THEN '001+0170546+011+00001+22200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'MD' THEN '001+0170546+010+00001+01000+131'
                                            --WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MD' THEN '001+0170546+010+00002+11000+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MD' THEN '001+0170546+010+00002+11000+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'MD' THEN '001+0170546+011+00001+21900+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'MD' THEN '001+0170546+011+00001+22000+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'ME' THEN '001+0170546+010+00001+00900+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'ME' THEN '001+0170546+010+00002+10900+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'ME' THEN '001+0170546+011+00001+21700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'ME' THEN '001+0170546+011+00001+21800+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'MN' THEN '001+0170546+010+00001+02500+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MN' THEN '001+0170546+010+00002+12500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'MN' THEN '001+0170546+011+00001+24900+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'MN' THEN '001+0170546+011+00001+25000+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'MO' THEN '001+0170546+010+00001+26100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'MO' THEN '001+0170546+010+00002+26200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'MO' THEN '001+0170546+011+00001+26300+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MO' THEN '001+0170546+011+00001+26400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'NC' THEN '001+0170546+010+00001+01500+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NC' THEN '001+0170546+010+00002+11500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'NC' THEN '001+0170546+011+00001+22900+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'NC' THEN '001+0170546+011+00001+23000+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'NE' THEN '001+0170546+010+00001+01200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NE' THEN '001+0170546+010+00002+11200+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'NE' THEN '001+0170546+011+00001+22300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'NE' THEN '001+0170546+011+00001+22400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'NJ' THEN '001+0170546+010+00001+01300+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NJ' THEN '001+0170546+010+00002+11300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'NJ' THEN '001+0170546+011+00001+22500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'NJ' THEN '001+0170546+011+00001+22600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'NM' THEN '001+0170546+010+00001+02600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NM' THEN '001+0170546+010+00002+12600+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'NM' THEN '001+0170546+011+00001+25100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'NM' THEN '001+0170546+011+00001+25200+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'NV' THEN '001+0170546+010+00001+25500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'NV' THEN '001+0170546+010+00002+25600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'NV' THEN '001+0170546+011+00001+25700+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NV' THEN '001+0170546+011+00001+25800+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'NY' THEN '001+0170546+010+00001+01400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NY' THEN '001+0170546+010+00002+11400+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'NY' THEN '001+0170546+011+00001+22700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'NY' THEN '001+0170546+011+00001+22800+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'OH' THEN ''  -- Values supplied by AETNA - waiting on client to update logic to use a custom field for the ones that there are no values
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'OH' THEN ''  -- Values supplied by AETNA - waiting on client to update logic to use a custom field for the ones that there are no values
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'OH' THEN ''  -- Values supplied by AETNA - waiting on client to update logic to use a custom field for the ones that there are no values
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'OH' THEN ''  -- Values supplied by AETNA - waiting on client to update logic to use a custom field for the ones that there are no values
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'OR' THEN '001+0170546+010+00001+00100+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'OR' THEN '001+0170546+010+00002+10100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'OR' THEN '001+0170546+011+00001+20100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'OR' THEN '001+0170546+011+00001+20200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'PA' THEN '001+0170546+010+00001+01600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'PA' THEN '001+0170546+010+00002+11600+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'PA' THEN '001+0170546+011+00001+23100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'PA' THEN '001+0170546+011+00001+23200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'RI' THEN '001+0170546+010+00001+01700+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'RI' THEN '001+0170546+010+00002+11700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'RI' THEN '001+0170546+011+00001+23300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'RI' THEN '001+0170546+011+00001+23400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'TN' THEN '001+0170546+010+00001+01800+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'TN' THEN '001+0170546+010+00002+11800+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'TN' THEN '001+0170546+011+00001+23500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'TN' THEN '001+0170546+011+00001+23600+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'TX' THEN '001+0170546+010+00001+01900+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'TX' THEN '001+0170546+010+00002+11900+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'TX' THEN '001+0170546+011+00001+23700+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'TX' THEN '001+0170546+011+00001+23800+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'UT' THEN '001+0170546+010+00001+02000+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'UT' THEN '001+0170546+010+00002+12000+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'UT' THEN '001+0170546+011+00001+23900+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'UT' THEN '001+0170546+011+00001+24000+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'VA' THEN '001+0170546+010+00001+02200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'VA' THEN '001+0170546+010+00002+12200+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'VA' THEN '001+0170546+011+00001+24100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'VA' THEN '001+0170546+011+00001+24200+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'VT' THEN '001+0170546+010+00001+02100+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'VT' THEN '001+0170546+010+00002+12100+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'VT' THEN '001+0170546+011+00001+24300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'VT' THEN '001+0170546+011+00001+24400+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'WA' THEN '001+0170546+010+00001+02300+131'
                                            WHEN bdmDedCode = 'USPPO' AND bdmBenOption IN  ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'WA' THEN '001+0170546+010+00002+12300+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EE') AND EepAddressState = 'WA' THEN '001+0170546+011+00001+24500+131'
                                            WHEN bdmDedCode = 'USHDP' AND bdmBenOption IN  ('EECH','EEFAM','EES') AND EepAddressState = 'WA' THEN '001+0170546+011+00001+24600+131'

                                            WHEN BdmDedCode = 'USPPO' AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1') AND EepAddressState = 'CT' THEN '001+0170546+010+00001+26900+131'
                                            WHEN BdmDedCode = 'USPPO' AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'CT' THEN '001+0170546+010+00002+27000+131'
                                            WHEN BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE') AND EepAddressState = 'CT' THEN '001+0170546+011+00001+27100+131'
                                            WHEN BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EECH','EEFAM','EES') AND EepAddressState = 'CT' THEN '001+0170546+011+00001+27200+131'
                                            ELSE ISNULL(BdmDedCode, 'no') + ' :: ' + ISNULL(BdmBenOption, 'no') + ' :: ' + ISNULL(EepAddressState, 'no')

                                    END
        ,drvHD05_CoverageLevelCode =    CASE WHEN BdmDedCode IN ('USHDP','USPPO') THEN
                                            CASE WHEN BdmBenOption IN ('EE','EE1') THEN 'EMP'
                                                 WHEN bdmBenOption NOT IN ('EE','EE1') THEN 'FAM'
                                            END
                                        END 
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, dbo.dsi_fnGetMinMaxDates('MAX',@FileMinCovDate, '1/1/2021')) END  -- min is 1/1/2021
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') AND BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN BdmBenStopDate END
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = CASE WHEN BdmDedType IN ('MED') THEN '' END
        ,drvDTP01_DateTimeQualifier_303 = CASE WHEN BdmDedType IN ('MED') THEN '303' END
        ,drvDTP02_DateTimeFormatQual_303 = CASE WHEN BdmDedType IN ('MED') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_303 = CASE WHEN BdmDedType IN ('MED') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate) END
        -- If drvREF00_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'REF' END
        ,drvREF01_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '1L' END
        ,drvREF02_RefNumberQual1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '0878955' END
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
                      + CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END + ' 1' 
    INTO dbo.U_EATNA834MD_DrvTbl_2300
    FROM dbo.U_EATNA834MD_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;




    INSERT INTO dbo.U_EATNA834MD_DrvTbl_2300
    SELECT drvHD00_HealthCoverage 
        ,drvHD01_MaintTypeCode 
        ,drvHD02_MaintReasonCode 
        ,drvHD03_InsuranceLineCode = 'DEN'
        ,drvHD04_PlanCoverageDesc =    CASE
                                        WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','ECH','EEFAM') THEN '002+0170546+012+00001+33100+032'
                                        WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '002+0170546+012+00002+43100+032'
                                        WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') THEN '002+0170546+012+00001+30200+032'
                                        WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '002+0170546+012+00002+40200+032'
                                        WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') THEN '002+0170546+012+00001+33200+032'
                                        WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '002+0170546+012+00002+43200+032'
                                            

                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'OR' THEN '002+0170546+012+00001+30100+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'CA' THEN '002+0170546+012+00001+30200+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'CO' THEN '002+0170546+012+00001+30300+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'DC' THEN '002+0170546+012+00001+30400+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'FL' THEN '002+0170546+012+00001+30500+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'GA' THEN '002+0170546+012+00001+30600+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'ID' THEN '002+0170546+012+00001+30700+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'LA' THEN '002+0170546+012+00001+30800+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'ME' THEN '002+0170546+012+00001+30900+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MD' THEN '002+0170546+012+00001+31000+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MA' THEN '002+0170546+012+00001+31100+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NE' THEN '002+0170546+012+00001+31200+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NJ' THEN '002+0170546+012+00001+31300+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NY' THEN '002+0170546+012+00001+31400+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NC' THEN '002+0170546+012+00001+31500+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'PA' THEN '002+0170546+012+00001+31600+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'RI' THEN '002+0170546+012+00001+31700+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'TN' THEN '002+0170546+012+00001+31800+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'TX' THEN '002+0170546+012+00001+31900+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'UT' THEN '002+0170546+012+00001+32000+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'VT' THEN '002+0170546+012+00001+32100+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'VA' THEN '002+0170546+012+00001+32200+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'WA' THEN '002+0170546+012+00001+32300+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'AZ' THEN '002+0170546+012+00001+32400+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'DE' THEN '002+0170546+012+00001+32500+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MN' THEN '002+0170546+012+00001+32600+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NM' THEN '002+0170546+012+00001+32700+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NV' THEN '002+0170546+012+00001+32800+032'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MN' THEN '002+0170546+012+00001+33000+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'OR' THEN '002+0170546+012+00002+40100+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'CA' THEN '002+0170546+012+00002+40200+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'CO' THEN '002+0170546+012+00002+40300+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'DC' THEN '002+0170546+012+00002+40400+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'FL' THEN '002+0170546+012+00002+40500+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'GA' THEN '002+0170546+012+00002+40600+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'ID' THEN '002+0170546+012+00002+40700+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'LA' THEN '002+0170546+012+00002+40800+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'ME' THEN '002+0170546+012+00002+40900+032'
                                        --WHEN BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MD' THEN '002+0170546+012+00002+41000+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MD' THEN '002+0170546+012+00002+41000+032'
                                        --WHEN BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MA' THEN '002+0170546+012+00002+41100+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MA' THEN '002+0170546+012+00002+41100+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NE' THEN '002+0170546+012+00002+41200+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NJ' THEN '002+0170546+012+00002+41300+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NY' THEN '002+0170546+012+00002+41400+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NC' THEN '002+0170546+012+00002+41500+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'PA' THEN '002+0170546+012+00002+41600+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'RI' THEN '002+0170546+012+00002+41700+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'TN' THEN '002+0170546+012+00002+41800+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'TX' THEN '002+0170546+012+00002+41900+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'UT' THEN '002+0170546+012+00002+42000+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'VT' THEN '002+0170546+012+00002+42100+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'VA' THEN '002+0170546+012+00002+42200+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'WA' THEN '002+0170546+012+00002+42300+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'AZ' THEN '002+0170546+012+00002+42400+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'DE' THEN '002+0170546+012+00002+42500+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MN' THEN '002+0170546+012+00002+42600+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NM' THEN '002+0170546+012+00002+42700+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'NV' THEN '002+0170546+012+00002+42800+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'MN' THEN '002+0170546+012+00002+43000+032'


                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'CT' THEN '002+0170546+012+00001+63700+032'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'CT' THEN '002+0170546+012+00002+63800+032'
                                        ELSE ISNULL(BdmDedCode, 'no') + ' :: ' + ISNULL(BdmBenOption, 'no') + ' :: ' + ISNULL(EepAddressState, 'no')
                                        --ELSE BdmDedCode + ' ' + BdmBenOption + ' ' + EepAddressState
                                    END
        ,drvHD05_CoverageLevelCode =    CASE WHEN BdmBenOption IN ('EE1','EE2','EE3','EE4','EE5') THEN 'EMP' ELSE 'FAM' END
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
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                      + CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END + ' 2'
    FROM dbo.U_EATNA834MD_DrvTbl_2300 WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCOID = drvCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
        AND ConSystemID = drvDepRecID -- BdmDepRecID
    WHERE drvHD03_InsuranceLineCode = 'HLT' 

    INSERT INTO dbo.U_EATNA834MD_DrvTbl_2300
    SELECT drvHD00_HealthCoverage 
        ,drvHD01_MaintTypeCode 
        ,drvHD02_MaintReasonCode 
        ,drvHD03_InsuranceLineCode = 'VIS'
        ,drvHD04_PlanCoverageDesc =    CASE
                                        WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') THEN '003+0170546+013+00001+53100+088'
                                        WHEN EepAddressState = 'AR' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '003+0170546+013+00002+63100+088'
                                        WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') THEN '003+0170546+013+00001+50200+088'
                                        WHEN EepAddressState = 'CA' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '003+0170546+013+00002+60200+088'
                                        WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') THEN '003+0170546+013+00001+53200+088'
                                        WHEN EepAddressState = 'KY' AND BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') THEN '003+0170546+013+00002+63200+088'

                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'OR' THEN '003+0170546+013+00001+50100+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'CA' THEN '003+0170546+013+00001+50200+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'CO' THEN '003+0170546+013+00001+50300+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'DC' THEN '003+0170546+013+00001+50400+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'FL' THEN '003+0170546+013+00001+50500+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'GA' THEN '003+0170546+013+00001+50600+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'ID' THEN '003+0170546+013+00001+50700+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'LA' THEN '003+0170546+013+00001+50800+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'ME' THEN '003+0170546+013+00001+50900+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MD' THEN '003+0170546+013+00001+51000+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MA' THEN '003+0170546+013+00001+51100+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NE' THEN '003+0170546+013+00001+51200+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NJ' THEN '003+0170546+013+00001+51300+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NY' THEN '003+0170546+013+00001+51400+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NC' THEN '003+0170546+013+00001+51500+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'PA' THEN '003+0170546+013+00001+51600+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'RI' THEN '003+0170546+013+00001+51700+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'TN' THEN '003+0170546+013+00001+51800+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'TX' THEN '003+0170546+013+00001+51900+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'UT' THEN '003+0170546+013+00001+52000+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'VT' THEN '003+0170546+013+00001+52100+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'VA' THEN '003+0170546+013+00001+52200+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'WA' THEN '003+0170546+013+00001+52300+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'AZ' THEN '003+0170546+013+00001+52400+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'DE' THEN '003+0170546+013+00001+52500+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MN' THEN '003+0170546+013+00001+52600+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NM' THEN '003+0170546+013+00001+52700+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'NV' THEN '003+0170546+013+00001+52800+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'MN' THEN '003+0170546+013+00001+53000+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'OR' THEN '003+0170546+013+00002+60100+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'CA' THEN '003+0170546+013+00002+60200+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'CO' THEN '003+0170546+013+00002+60300+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'DC' THEN '003+0170546+013+00002+60400+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'FL' THEN '003+0170546+013+00002+60500+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'GA' THEN '003+0170546+013+00002+60600+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'ID' THEN '003+0170546+013+00002+60700+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'LA' THEN '003+0170546+013+00002+60800+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'ME' THEN '003+0170546+013+00002+60900+088'
                                        --WHEN BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'MD' THEN '003+0170546+013+00002+61000+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'MD' THEN '003+0170546+013+00002+61000+088'
                                        --WHEN BdmDedCode IN ('USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'MA' THEN '003+0170546+013+00002+61100+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'MA' THEN '003+0170546+013+00002+61100+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'NE' THEN '003+0170546+013+00002+61200+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'NJ' THEN '003+0170546+013+00002+61300+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'NY' THEN '003+0170546+013+00002+61400+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'NC' THEN '003+0170546+013+00002+61500+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'PA' THEN '003+0170546+013+00002+61600+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'RI' THEN '003+0170546+013+00002+61700+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'TN' THEN '003+0170546+013+00002+61800+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'TX' THEN '003+0170546+013+00002+61900+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'UT' THEN '003+0170546+013+00002+62000+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'VT' THEN '003+0170546+013+00002+62100+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'VA' THEN '003+0170546+013+00002+62200+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'WA' THEN '003+0170546+013+00002+62300+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'AZ' THEN '003+0170546+013+00002+62400+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'DE' THEN '003+0170546+013+00002+62500+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'MN' THEN '003+0170546+013+00002+62600+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'NM' THEN '003+0170546+013+00002+62700+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'NV' THEN '003+0170546+013+00002+62800+088'
                                        WHEN BdmDedCode IN ('USPPO') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM','4','EEFAM5') AND EepAddressState = 'MN' THEN '003+0170546+013+00002+63000+088'

                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE1','EECH1','EES1','EEFAM1','EE','EES','EECH','EEFAM') AND EepAddressState = 'CT' THEN '003+0170546+013+00001+63900+088'
                                        WHEN BdmDedCode IN ('USPPO','USHDP','USHDP') AND BdmBenOption IN ('EE2','EE3','EE4','EE5','EECH2','EECH3','EECH4','EECH5','EES2','EES3','EES4','EES5','EEFAM2','EEFAM3','EEFAM4','EEFAM5') AND EepAddressState = 'CT' THEN '003+0170546+013+00002+64000+088'

                                        ELSE ISNULL(BdmDedCode, 'no') + ' :: ' + ISNULL(BdmBenOption, 'no') + ' :: ' + ISNULL(EepAddressState, 'no')
                                    END
        ,drvHD05_CoverageLevelCode = CASE WHEN BdmBenOption IN ('EE1','EE2','EE3','EE4','EE5') THEN 'EMP' ELSE 'FAM' END
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
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                      + CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END + ' 3'
    FROM dbo.U_EATNA834MD_DrvTbl_2300 WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = drvEEID
    JOIN dbo.U_dsi_bdm_EATNA834MD WITH (NOLOCK)
        ON BdmEEID = drvEEID
        AND BdmCOID = drvCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = drvEEID
        AND ConSystemID  = drvDepRecID -- BdmDepRecID
    WHERE drvHD03_InsuranceLineCode = 'HLT' 






    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EATNA834MD_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EATNA834MD_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_EATNA834MD_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EATNA834MD','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'ACSA_EATNA834MD_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EATNA834MD';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEATNA834MD_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EATNA834MD_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDef
WHERE AdfHeaderSystemID LIKE 'EATNA834MD%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202009291'
       ,ExpStartPerControl     = '202009291'
       ,ExpLastEndPerControl   = '202010139'
       ,ExpEndPerControl       = '202010139'
WHERE ExpFormatCode = 'EATNA834MD';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEATNA834MD_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EATNA834MD_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)