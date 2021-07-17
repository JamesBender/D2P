SET NOCOUNT ON;
IF OBJECT_ID('U_EUHCINS834_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCINS834_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EUHCINS834_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EUHCINS834' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEUHCINS834_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEUHCINS834_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EUHCINS834') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCINS834];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_EUHCINS834') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_EUHCINS834];
GO
IF OBJECT_ID('U_EUHCINS834_File') IS NOT NULL DROP TABLE [dbo].[U_EUHCINS834_File];
GO
IF OBJECT_ID('U_EUHCINS834_EEList') IS NOT NULL DROP TABLE [dbo].[U_EUHCINS834_EEList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EUHCINS834';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EUHCINS834';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EUHCINS834';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EUHCINS834';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EUHCINS834';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EUHCINS834','UHC Medical 834','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EUHCINS834Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EUHCINS834' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ISA"','1','(''DA''=''F*'')','EUHCINS834Z0','3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''F*'')','EUHCINS834Z0','2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','3','(''SS''=''F*'')','EUHCINS834Z0','10','H','01','3',NULL,'Authorization Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','4','(''DA''=''F*'')','EUHCINS834Z0','2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F*'')','EUHCINS834Z0','10','H','01','5',NULL,'Security Info',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA05_SenderIDQual"','6','(''UA''=''F*'')','EUHCINS834Z0','2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA06_SenderID"','7','(''UA''=''F*'')','EUHCINS834Z0','15','H','01','7',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA07_ReceiverIDQual"','8','(''UA''=''F*'')','EUHCINS834Z0','2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA08_ReceiverID"','9','(''UA''=''F*'')','EUHCINS834Z0','15','H','01','9',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA09_InterchangeDate"','10','(''UD12''=''F*'')','EUHCINS834Z0','6','H','01','10',NULL,'Interchange Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA10_InterchangeTime"','11','(''UA''=''F*'')','EUHCINS834Z0','4','H','01','11',NULL,'Interchange Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"^"','12','(''DA''=''F*'')','EUHCINS834Z0','1','H','01','12',NULL,'Repetition Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00501"','13','(''DA''=''F*'')','EUHCINS834Z0','5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','14','(''DA''=''F*'')','EUHCINS834Z0','9','H','01','14',NULL,'Interchange Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','15','(''DA''=''F*'')','EUHCINS834Z0','1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvISA15_UsageIndicator"','16','(''UA''=''F*'')','EUHCINS834Z0','1','H','01','16',NULL,'Usage Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('":"','17','(''DA''=''F*'')','EUHCINS834Z0','1','H','01','17',NULL,'Component Element Separator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GS"','1','(''DA''=''T*'')','EUHCINS834Z0','2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BE"','2','(''DA''=''T*'')','EUHCINS834Z0','2','H','02','2',NULL,'Functional ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS02_SenderID"','3','(''UA''=''T*'')','EUHCINS834Z0','15','H','02','3',NULL,'Sender ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS03_ReceiverID"','4','(''UA''=''T*'')','EUHCINS834Z0','15','H','02','4',NULL,'Receiver ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS04_Date"','5','(''UD112''=''T*'')','EUHCINS834Z0','8','H','02','5',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGS05_Time"','6','(''UA''=''T*'')','EUHCINS834Z0','8','H','02','6',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','7','(''DA''=''T*'')','EUHCINS834Z0','9','H','02','7',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"X"','8','(''DA''=''T*'')','EUHCINS834Z0','2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','9','(''DA''=''T*'')','EUHCINS834Z0','12','H','02','9',NULL,'Version/Release  Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ST"','1','(''DA''=''T*'')','EUHCINS834Z0','2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"834"','2','(''DA''=''T*'')','EUHCINS834Z0','3','H','03','2',NULL,'Transaction ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EUHCINS834Z0','9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"005010X220A1"','4','(''DA''=''T*'')','EUHCINS834Z0','35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BGN"','1','(''DA''=''T*'')','EUHCINS834Z0','3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"00"','2','(''DA''=''T*'')','EUHCINS834Z0','2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EUHCINS834Z0','50','H','04','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN03_Date"','4','(''UD112''=''T*'')','EUHCINS834Z0','8','H','04','4',NULL,'Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN04_Time"','5','(''UA''=''T*'')','EUHCINS834Z0','8','H','04','5',NULL,'Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN05_TimeCode"','6','(''UA''=''T*'')','EUHCINS834Z0','2','H','04','6',NULL,'Time Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN06_RefID"','7','(''UA''=''T*'')','EUHCINS834Z0','50','H','04','7',NULL,'Reference Identification',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN07_TransTypeCode"','8','(''UA''=''T*'')','EUHCINS834Z0','2','H','04','8',NULL,'Transaction Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBGN08_ActionCode"','9','(''UA''=''T*'')','EUHCINS834Z0','2','H','04','9',NULL,'Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EUHCINS834Z0','3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','EUHCINS834Z0','3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual"','3','(''UA''=''T*'')','EUHCINS834Z0','50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EUHCINS834Z0','3','H','06','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual1"','2','(''UA''=''T*'')','EUHCINS834Z0','2','H','06','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity1"','3','(''UA''=''T*'')','EUHCINS834Z0','15','H','06','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EUHCINS834Z0','3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual2"','2','(''UA''=''T*'')','EUHCINS834Z0','2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity2"','3','(''UA''=''T*'')','EUHCINS834Z0','15','H','07','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"QTY"','1','(''DA''=''T*'')','EUHCINS834Z0','3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY01_QuantityQual3"','2','(''UA''=''T*'')','EUHCINS834Z0','2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQTY02_Quantity3"','3','(''UA''=''T*'')','EUHCINS834Z0','15','H','08','3',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EUHCINS834Z0','2','H','09','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor1"','2','(''UA''=''T*'')','EUHCINS834Z0','3','H','09','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name1"','3','(''UA''=''T*'')','EUHCINS834Z0','60','H','09','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual1"','4','(''UA''=''T*'')','EUHCINS834Z0','2','H','09','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode1"','5','(''UA''=''T*'')','EUHCINS834Z0','80','H','09','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EUHCINS834Z0','2','H','10','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor2"','2','(''UA''=''T*'')','EUHCINS834Z0','3','H','10','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name2"','3','(''UA''=''T*'')','EUHCINS834Z0','60','H','10','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN103_IDCodeQual2"','4','(''UA''=''T*'')','EUHCINS834Z0','2','H','10','4',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN104_IDCode2"','5','(''UA''=''T*'')','EUHCINS834Z0','80','H','10','5',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INS"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','11','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS01_YesNoCond"','2','(''UA''=''T*'')','EUHCINS834Z0','1','D','11','2',NULL,'Yes/No Condition',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS02_RelationshipCode"','3','(''UA''=''T*'')','EUHCINS834Z0','2','D','11','3',NULL,'Individual Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS03_MaintTypeCode"','4','(''UA''=''T*'')','EUHCINS834Z0','3','D','11','4',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS04_MaintReasonCode"','5','(''UA''=''T*'')','EUHCINS834Z0','3','D','11','5',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS05_BenefitStatusCode"','6','(''UA''=''T*'')','EUHCINS834Z0','1','D','11','6',NULL,'Benefit Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0601_MEDICAREPLANCODE"','7','(''UA''=''T'')','EUHCINS834Z0','1','D','11','7',NULL,'MEDICARE PLAN CODE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS0602_EligibilityRsnCode"','8','(''UA''=''T*'')','EUHCINS834Z0','1','D','11','8',NULL,'Eligibility Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS07_COBRAQualEventCode"','9','(''UA''=''T*'')','EUHCINS834Z0','2','D','11','9',NULL,'COBRA Qualifying Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS08_EmploymentStatusCode"','10','(''UA''=''T*'')','EUHCINS834Z0','2','D','11','10',NULL,'Employment Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS09_StudentStatusCode"','11','(''UA''=''T*'')','EUHCINS834Z0','1','D','11','11',NULL,'Student Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS10_ResponseCode"','12','(''UA''=''T*'')','EUHCINS834Z0','1','D','11','12',NULL,'Response Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS11_DateTimeFormatQual"','13','(''UA''=''T*'')','EUHCINS834Z0','3','D','11','13',NULL,'Date Time Period Format Qualif',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINS12_DateTimePeriod"','14','(''UD112''=''T*'')','EUHCINS834Z0','35','D','11','14',NULL,'Date Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','12','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0F"','2','(''DA''=''T*'')','EUHCINS834Z0','3','D','12','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','3','(''UA''=''T*'')','EUHCINS834Z0','50','D','12','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','13','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','13','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','EUHCINS834Z0','50','D','13','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','EUHCINS834Z0','50','D','14','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime1"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','15','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier1"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','15','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual1"','3','(''UA''=''T*'')','EUHCINS834Z0','3','D','15','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod1"','4','(''UD112''=''T*'')','EUHCINS834Z0','35','D','15','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime2"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','16','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier2"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','16','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual2"','3','(''UA''=''T*'')','EUHCINS834Z0','3','D','16','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod2"','4','(''UD112''=''T*'')','EUHCINS834Z0','35','D','16','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NM1"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','20','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IL"','2','(''DA''=''T*'')','EUHCINS834Z0','3','D','20','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','3','(''DA''=''T*'')','EUHCINS834Z0','1','D','20','3',NULL,'Entity Type Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM103_NameLast1"','4','(''UA''=''T*'')','EUHCINS834Z0','60','D','20','4',NULL,'Name Last',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM104_NameFirst1"','5','(''UA''=''T*'')','EUHCINS834Z0','35','D','20','5',NULL,'Name First',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM105_NameMiddleInitial1"','6','(''UA''=''T*'')','EUHCINS834Z0','25','D','20','6',NULL,'Name Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM106_NamePrefix1"','7','(''UA''=''T*'')','EUHCINS834Z0','10','D','20','7',NULL,'Name Prefix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM107_NameSuffix1"','8','(''UA''=''T*'')','EUHCINS834Z0','10','D','20','8',NULL,'Name Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM108_IDCodeQualifier1"','9','(''UA''=''T*'')','EUHCINS834Z0','2','D','20','9',NULL,'Identification Code Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNM109_IDCode1"','10','(''UA''=''T*'')','EUHCINS834Z0','80','D','20','10',NULL,'Identification Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PER"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','21','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IP"','2','(''DA''=''T*'')','EUHCINS834Z0','2','D','21','2',NULL,'Contact Function Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER02_Name"','3','(''UA''=''T*'')','EUHCINS834Z0','60','D','21','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER03_CommNumberQualifier"','4','(''UA''=''T*'')','EUHCINS834Z0','3','D','21','4',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER04_CommunicationNumber"','5','(''UA''=''T*'')','EUHCINS834Z0','256','D','21','5',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER05_CommNumberQualifier"','6','(''UA''=''T*'')','EUHCINS834Z0','3','D','21','6',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER06_CommunicationNumber"','7','(''UA''=''T*'')','EUHCINS834Z0','256','D','21','7',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER07_CommNumberQualifier"','8','(''UA''=''T*'')','EUHCINS834Z0','3','D','21','8',NULL,'Communication Number Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPER08_CommunicationNumber"','9','(''UA''=''T*'')','EUHCINS834Z0','256','D','21','9',NULL,'Communication Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N3"','1','(''DA''=''T*'')','EUHCINS834Z0','2','D','22','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN301_AddressLine1"','2','(''UA''=''T*'')','EUHCINS834Z0','55','D','22','2',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN302_AddressLine2"','3','(''UA''=''T*'')','EUHCINS834Z0','55','D','22','3',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N4"','1','(''DA''=''T*'')','EUHCINS834Z0','2','D','23','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN401_City"','2','(''UA''=''T*'')','EUHCINS834Z0','30','D','23','2',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN402_State"','3','(''UA''=''T*'')','EUHCINS834Z0','2','D','23','3',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN403_Zip"','4','(''UA''=''T*'')','EUHCINS834Z0','15','D','23','4',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN404_CountryCode"','5','(''UA''=''T*'')','EUHCINS834Z0','3','D','23','5',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DMG"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','24','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"D8"','2','(''DA''=''T*'')','EUHCINS834Z0','3','D','24','2',NULL,'Date/Time Format Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG02_DateTimePeriod1"','3','(''UD112''=''T*'')','EUHCINS834Z0','35','D','24','3',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG03_GenderCode1"','4','(''UA''=''T*'')','EUHCINS834Z0','1','D','24','4',NULL,'Gender Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDMG04_MaritalStatusCode1"','5','(''UA''=''T*'')','EUHCINS834Z0','1','D','24','5',NULL,'Marital Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ICM"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','25','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM01_FrequencyCode"','2','(''UA''=''T*'')','EUHCINS834Z0','1','D','25','2',NULL,'Frequency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM02_MonetaryAmount"','3','(''UA''=''T*'')','EUHCINS834Z0','18','D','25','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM03_Quantity"','4','(''UA''=''T*'')','EUHCINS834Z0','15','D','25','4',NULL,'Quantity',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvICM04_LocationID"','5','(''UA''=''T*'')','EUHCINS834Z0','30','D','25','5',NULL,'Location Identifier Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID1"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','26','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','EUHCINS834Z0','18','D','26','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','EUHCINS834Z0','1','D','26','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_SegmentID2"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','27','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','EUHCINS834Z0','18','D','27','2',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','EUHCINS834Z0','1','D','27','3',NULL,'Credit/Debit Flag Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH00_SegmentID"','1','(''UA''=''T*'')','EUHCINS834Z0','1','D','28','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH01_HealthRelatedCode"','2','(''UA''=''T*'')','EUHCINS834Z0','8','D','28','2',NULL,'Health-Related Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH02_Height"','3','(''UA''=''T*'')','EUHCINS834Z0','10','D','28','3',NULL,'Height',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH03_Weight1"','4','(''UA''=''T*'')','EUHCINS834Z0','10','D','28','4',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH04_Weight2"','5','(''UA''=''T*'')','EUHCINS834Z0','10','D','28','5',NULL,'Weight',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH05_Description1"','6','(''UA''=''T*'')','EUHCINS834Z0','10','D','28','6',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH06_CurrentHealthConditionCode"','7','(''UA''=''T*'')','EUHCINS834Z0','10','D','28','7',NULL,'Current Health Condition Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHLH07_Description2"','8','(''UA''=''T*'')','EUHCINS834Z0','10','D','28','8',NULL,'Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD00_HealthCoverage"','1','(''UA''=''T*'')','EUHCINS834Z0','2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD01_MaintTypeCode"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD02_MaintReasonCode"','3','(''UA''=''T*'')','EUHCINS834Z0','3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD03_InsuranceLineCode"','4','(''UA''=''T*'')','EUHCINS834Z0','3','D','40','4',NULL,'Insurance Line Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD04_PlanCoverageDesc"','5','(''UA''=''T*'')','EUHCINS834Z0','50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHD05_CoverageLevelCode"','6','(''UA''=''T*'')','EUHCINS834Z0','3','D','40','6',NULL,'Coverage Level Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_348"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_348"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_348"','3','(''UA''=''T*'')','EUHCINS834Z0','3','D','41','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_348"','4','(''UD112''=''T*'')','EUHCINS834Z0','35','D','41','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_349"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_349"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_349"','3','(''UA''=''T*'')','EUHCINS834Z0','3','D','42','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_349"','4','(''UD112''=''T*'')','EUHCINS834Z0','35','D','42','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP00_DateTime_303"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP01_DateTimeQualifier_303"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP02_DateTimeFormatQual_303"','3','(''UA''=''T*'')','EUHCINS834Z0','3','D','43','3',NULL,'Date/Time Format',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDTP03_DateTimePeriod_303"','4','(''UD112''=''T*'')','EUHCINS834Z0','35','D','43','4',NULL,'Date/Time Period',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual1"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual1"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual1"','3','(''UA''=''T*'')','EUHCINS834Z0','50','D','45','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF00_RefNumberQual2"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual2"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberQual2"','3','(''UA''=''T*'')','EUHCINS834Z0','50','D','46','3',NULL,'Reference Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode1"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode1"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount1"','3','(''UA''=''T*'')','EUHCINS834Z0','18','D','50','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT00_AmountQualifierCode2"','1','(''UA''=''T*'')','EUHCINS834Z0','3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT01_AmountQualifierCode2"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAMT02_MonetaryAmount2"','3','(''UA''=''T*'')','EUHCINS834Z0','18','D','51','3',NULL,'Monetary Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LS"','1','(''DA''=''T*'')','EUHCINS834Z0','2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLS01_LoopIDCode"','2','(''UA''=''T*'')','EUHCINS834Z0','6','D','80','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LX"','1','(''DA''=''T*'')','EUHCINS834Z0','2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLX01_AssignedNumber"','2','(''UA''=''T*'')','EUHCINS834Z0','6','D','81','2',NULL,'Assigned Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N1"','1','(''DA''=''T*'')','EUHCINS834Z0','2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN101_EntityIDCodeSponsor"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvN102_Name"','3','(''UA''=''T*'')','EUHCINS834Z0','60','D','85','3',NULL,'Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REF"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF01_RefNumberQual"','2','(''UA''=''T*'')','EUHCINS834Z0','3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREF02_RefNumberDesc"','3','(''UA''=''T*'')','EUHCINS834Z0','50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LE"','1','(''DA''=''T*'')','EUHCINS834Z0','3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLE01_LoopIDCode"','2','(''UA''=''T*'')','EUHCINS834Z0','6','D','87','2',NULL,'Loop ID Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SE"','1','(''DA''=''T*'')','EUHCINS834Z0','2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSE01_SegmentCount"','2','(''UA''=''T*'')','EUHCINS834Z0','10','T','90','2',NULL,'Number of Included Segments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EUHCINS834Z0','9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GE"','1','(''DA''=''T*'')','EUHCINS834Z0','2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','EUHCINS834Z0','6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"0001"','3','(''DA''=''T*'')','EUHCINS834Z0','9','T','91','3',NULL,'Group Control Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IEA"','1','(''DA''=''T*'')','EUHCINS834Z0','3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"1"','2','(''DA''=''T*'')','EUHCINS834Z0','5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"000000001"','3','(''DA''=''T*'')','EUHCINS834Z0','9','T','92','3',NULL,'Interchange Control Number',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EUHCINS834_20210716.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Changes Only File','202107029','EMPEXPORT','CHANGES','Oct  1 2018 12:00AM','EUHCINS834',NULL,NULL,NULL,'202107029','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202107021',NULL,'','','202107021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Full File Only','202107029','EMPEXPORT','FULLFILE','Oct  1 2018 12:00AM','EUHCINS834',NULL,NULL,NULL,'202107029','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202107021',NULL,'','','202107021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment','202107029','EMPEXPORT','OEACTIVE','Oct  1 2018 12:00AM','EUHCINS834',NULL,NULL,NULL,'202107029','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202107021',NULL,'','','202107021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment','202107029','EMPEXPORT','OEPASSIVE','Oct  1 2018 12:00AM','EUHCINS834',NULL,NULL,NULL,'202107029','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202107021',NULL,'','','202107021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'UHC Medical 834','202107029','EMPEXPORT','SCH_UHC834','Oct  1 2018 12:00AM','EUHCINS834',NULL,NULL,NULL,'202107029','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM','202107021',NULL,'','','202107021',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EUHCINS834','UseFileName','V','N');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EUHCINS834' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EUHCINS834' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EUHCINS834_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EUHCINS834_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H01','U_EUHCINS834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H02','U_EUHCINS834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H03','U_EUHCINS834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H04','U_EUHCINS834_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H05','U_EUHCINS834_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H06','U_EUHCINS834_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H07','U_EUHCINS834_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H08','U_EUHCINS834_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H09','U_EUHCINS834_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','H10','U_EUHCINS834_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D11','U_EUHCINS834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D12','U_EUHCINS834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D13','U_EUHCINS834_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D14','U_EUHCINS834_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D15','U_EUHCINS834_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D16','U_EUHCINS834_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D20','U_EUHCINS834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D21','U_EUHCINS834_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D22','U_EUHCINS834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D23','U_EUHCINS834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D24','U_EUHCINS834_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D25','U_EUHCINS834_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D26','U_EUHCINS834_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D27','U_EUHCINS834_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D28','U_EUHCINS834_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D40','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D41','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D42','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D43','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D45','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D46','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D50','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D51','U_EUHCINS834_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D80','U_EUHCINS834_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D81','U_EUHCINS834_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D85','U_EUHCINS834_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D86','U_EUHCINS834_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','D87','U_EUHCINS834_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','T90','U_EUHCINS834_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','T91','U_EUHCINS834_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EUHCINS834','T92','U_EUHCINS834_TrlTbl',NULL);
IF OBJECT_ID('U_EUHCINS834_EEList') IS NULL
CREATE TABLE [dbo].[U_EUHCINS834_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EUHCINS834_File') IS NULL
CREATE TABLE [dbo].[U_EUHCINS834_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_EUHCINS834]
AS
SET NOCOUNT ON;
/************************************************************
Client: Inspire Communities

Created By: Andy Pineda
Create Date: 07/02/2021
ChangePoint Request Number: TekP-2021-04-02-0004

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
    WHILE (SELECT COUNT(*) FROM dbo.U_EUHCINS834_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_EUHCINS834_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_EUHCINS834_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_EUHCINS834_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_EUHCINS834_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_EUHCINS834_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_EUHCINS834_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EUHCINS834]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: Inspire Communities

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 07/02/2021
Service Request Number: TekP-2021-04-02-0004

Purpose: UHC Medical 834

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EUHCINS834';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EUHCINS834';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EUHCINS834';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'EUHCINS834';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EUHCINS834' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'FULLFILE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'CHANGES';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EUHCINS834', 'SCH_UHC834';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EUHCINS834';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EUHCINS834', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = CAST('03/01/2021' as DATETIME)
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'EUHCINS834';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'UHHSA,UHPPO';

    IF OBJECT_ID('U_EUHCINS834_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_EUHCINS834_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_EUHCINS834_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EUHCINS834_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EUHCINS834_EEList
    WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_EUHCINS834_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL, DPC, STC');
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
    FROM dbo.U_dsi_bdm_EUHCINS834 D
    JOIN dbo.U_dsi_bdm_EUHCINS834 E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_EUHCINS834
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_EUHCINS834
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_EUHCINS834
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_EUHCINS834
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_EUHCINS834
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_EUHCINS834
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
    IF OBJECT_ID('U_EUHCINS834_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '411289245'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE dbo.dsi_fnVariable(@FormatCode,'Testing') WHEN 'Y' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvGS03_ReceiverID = 'CES'
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = 'ET'
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = '38'
        ,drvREF02_RefNumberQual = 'INSPIREF'
        ,drvQTY01_QuantityQual1 = ''
        ,drvQTY02_Quantity1 = ''
        ,drvQTY01_QuantityQual2 = ''
        ,drvQTY02_Quantity2 = ''
        ,drvQTY01_QuantityQual3 = ''
        ,drvQTY02_Quantity3 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'INSPIRE COMMUNITIES'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = (SELECT CmmFedTaxId FROM dbo.CompMast WITH(NOLOCK))
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'UNITEDHEALTH GROUP'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '411289245'
    INTO dbo.U_EUHCINS834_HdrTbl
    FROM dbo.U_EUHCINS834_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_EUHCINS834 WITH (NOLOCK)
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
    IF OBJECT_ID('U_EUHCINS834_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_DrvTbl;
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
                                                CASE WHEN ConRelationship IN ('SPS'/*,'DP'*/) THEN '01'
                                                     WHEN ConRelationship = 'DP' THEN '53'
                                                     WHEN ConRelationship IN ('CHL', 'DPC', 'STC') THEN '19'
                                                     ELSE '19'
                                                END
                                     END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = '' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = 'FT'
        -- CASE WHEN BdmRecType = 'EMP' THEN
        --                                         CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
        --                                              WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
        --                                              WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
        --                                         END
        --                                  END
        ,drvINS09_StudentStatusCode = ''
        -- CASE WHEN BdmRecType = 'DEP' THEN
        --                                         CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
        --                               END
        ,drvINS10_ResponseCode = CASE WHEN ConRelationship IN ('CHL', 'DPC', 'STC') AND ConIsDisabled = 'Y' THEN 'Y' ELSE 'N' END
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
        ,drvREF02_RefNumberQual1 = '0921184'
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier1 = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN '286' END
        ,drvDTP02_DateTimeFormatQual1 = CASE WHEN EecEmplStatus = 'T' AND EecTermReason = '202' THEN 'D8' END
        ,drvDTP03_DateTimePeriod1 = ISNULL(CONVERT(VARCHAR, (CASE WHEN EecEmplStatus = 'T' AND EecTermReason ='202' THEN EecDateOfTermination END), 112), '')
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = 'DTP'
        ,drvDTP01_DateTimeQualifier2 = '336'
        ,drvDTP02_DateTimeFormatQual2 = 'D8'
        ,drvDTP03_DateTimePeriod2 = EecDateOfLastHire
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
                                    ELSE ''
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                          WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN '34'
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') = '' THEN 'HP'
                                             WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') = '' and ISNULL(eepAddressEMail,'') <> '' THEN 'EM'
                                              WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') <> '' THEN 'HP'
                                             END

        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') = '' THEN ISNULL(EepPhoneHomeNumber,'') 
                                              WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') = '' and ISNULL(eepAddressEMail,'') <> '' THEN ISNULL(eepAddressEMail,'')
                                              WHEN BdmRecType = 'EMP' and ISNULL(EepPhoneHomeNumber,'') <> '' and ISNULL(eepAddressEMail,'') <> '' THEN  ISNULL(EepPhoneHomeNumber,'') 

                                             END

        ,drvPER05_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' and ISNULL(eepAddressEMail,'') <> '' and   ISNULL(EepPhoneHomeNumber,'') <> '' THEN 'EM' END

        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' and ISNULL(eepAddressEMail,'') <> '' and   ISNULL(EepPhoneHomeNumber,'') <> '' THEN ISNULL(eepAddressEMail,'') END

        ,drvPER07_CommNumberQualifier = ''
        ,drvPER08_CommunicationNumber = ''
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
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN EepMaritalStatus = 'S' THEN 'I'
                                            WHEN EepMaritalStatus = '' OR EepMaritalStatus = 'Z' THEN 'U'
                                            ELSE EepMaritalStatus END
        /*CASE WHEN BdmRecType = 'EMP' THEN
                                                CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END
                                       END*/
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
    INTO dbo.U_EUHCINS834_DrvTbl
    FROM dbo.U_EUHCINS834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_EUHCINS834 WITH (NOLOCK)
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

    -- HLT Load
    IF OBJECT_ID('U_EUHCINS834_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = CASE WHEN BdmDedType IN ('MED') THEN 'HD'
                                        WHEN BdmDedType IN ('DEN') THEN 'HD'
                                        WHEN BdmDedType IN ('VIS') THEN 'HD'
                                 END
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD03_InsuranceLineCode = 'HLT'
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aadmiral' THEN '00150015TT'
											WHEN BdmDedCode = 'UHHSA' AND LocCode = 'BLUEGR' THEN '00190019TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acandlel' THEN '00230023TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acandlew' THEN '00270027TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acardrid' THEN '00310031TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acascade' THEN '00350035TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acimgran' THEN '00430043TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acimhts' THEN '00390039TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acontine' THEN '00470047TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acountrd' THEN '00510051TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acoweta' THEN '00590059TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'acvwgran' THEN '00550055TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aelsolgr' THEN '00670067TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'asolhome' THEN '00670067TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'afishhav' THEN '05010501TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ageorget' THEN '05050505TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'agoasis' THEN '00710071TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahermita' THEN '00750075TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahibiscu' THEN '05090509TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahrivern' THEN '00790079TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ahrivers' THEN '00830083TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aindepen' THEN '00870087TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ainspinc' THEN '00070007TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ainspllc' THEN '00030003TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'ajamesto' THEN '00910091TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aknollt' THEN '00950095TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alakebob' THEN '05130513TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alakewod' THEN '00990099TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alamplit' THEN '01030103TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'alucerne' THEN '05170517TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'anormand' THEN '01110111TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aoakcres' THEN '01150115TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aoakgran' THEN '01190119TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aoceanwy' THEN '01230123TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aongreen' THEN '01270127TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aparvill' THEN '01350135TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'apinemea' THEN '01390139TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'apinesha' THEN '01430143TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aquail' THEN '01470147TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aramblew' THEN '01510151TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'arobbinw' THEN '01550155TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'arolmead' THEN '01590159TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aroselak' THEN '05210521TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'asilver' THEN '01630163TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'aspringb' THEN '01670167TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'asunnypi' THEN '05250525TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'atallpin' THEN '05290529TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'atelaval' THEN '01710171TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'avictori' THEN '01750175TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awelling' THEN '01830183TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awestgat' THEN '01870187TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awhcreek' THEN '01910191TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awillowp' THEN '01950195TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'awindsor' THEN '01990199TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'palpinev' THEN '00110011TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rarbormo' THEN '02030203TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'razaleag' THEN '02070207TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbaronmo' THEN '02110211TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbeachvi' THEN '02150215TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rblackoa' THEN '02190219TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbluespr' THEN '02230223TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbramble' THEN '02270227TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbrookfi' THEN '02310231TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rbrookva' THEN '02350235TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcarsonv' THEN '02390239TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcedarpa' THEN '02430243TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcherryh' THEN '02470247TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcindere' THEN '02510251TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcirclel' THEN '02550255TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcloverl' THEN '02590259TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcountrc' THEN '02630263TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcountrm' THEN '02670267TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcrestvi' THEN '02710271TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rcrestwo' THEN '02750275TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rdelawar' THEN '02790279TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'relmgrov' THEN '02830283TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rfarming' THEN '02870287TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rfernwoo' THEN '02910291TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rflaming' THEN '02950295TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rforestl' THEN '02990299TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rfreedom' THEN '03030303TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rgasligh' THEN '03070307TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rglenlea' THEN '03110311TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rgoldenp' THEN '03150315TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhawthor' THEN '03190319TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhiddenv' THEN '03230323TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhillcou' THEN '03270327TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rhumming' THEN '03310331TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rjackson' THEN '03350335TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rkiljord' THEN '03390339TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rkingpar' THEN '03430343TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlacasit' THEN '03470347TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlakevie' THEN '03510351TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rleisure' THEN '03550355TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlilyoft' THEN '03590359TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rlondons' THEN '03630363TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmiamimo' THEN '03670367TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmission' THEN '03710371TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmobilee' THEN '03750375TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rmountai' THEN '03790379TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'roldhick' THEN '03830383TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rozarkhi' THEN '03870387TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rparkvie' THEN '03910391TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rparkway' THEN '03950395TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rpinegro' THEN '03990399TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rplantat' THEN '04030403TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rpueblos' THEN '04070407TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rranchwo' THEN '04110411TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rredceda' THEN '04150415TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rredmapl' THEN '04190419TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rredwood' THEN '04230423TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rshadowm' THEN '04270427TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rshenand' THEN '04310431TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsilverl' THEN '04350435TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsilverm' THEN '04390439TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsouthla' THEN '04430443TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rstonega' THEN '04470447TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rswancre' THEN '04510451TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rsweetgu' THEN '04550455TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rthemead' THEN '04590459TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rthepine' THEN '04630463TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rvalleyo' THEN '04670467TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rvalleyv' THEN '04710471TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rvillage' THEN '04750475TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwesters' THEN '04790479TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwesterv' THEN '04830483TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwhiteoa' THEN '04870487TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwhitepi' THEN '04910491TT'
											WHEN BdmDedCode = 'UHHSA' AND OrgGLSegment = 'rwhittie' THEN '04950495TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aadmiral' THEN '00130013TT'
											--WHEN BdmDedCode = 'UHPPO' AND LocCode = 'BLUEGR' THEN '00190019TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acandlel' THEN '00210021TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acandlew' THEN '00250025TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acardrid' THEN '00290029TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acascade' THEN '00330033TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acimgran' THEN '00410041TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acimhts' THEN '00370037TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acontine' THEN '00450045TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acountrd' THEN '00490049TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acoweta' THEN '00570057TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'acvwgran' THEN '00530053TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aelsolgr' THEN '00650065TT'
											--WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'asolhome' THEN '00670067TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'afishhav' THEN '05010501TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ageorget' THEN '05030503TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'agoasis' THEN '00690069TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahermita' THEN '00730073TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahibiscu' THEN '05070507TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahrivern' THEN '00770077TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ahrivers' THEN '00810081TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aindepen' THEN '00850085TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ainspinc' THEN '00050005TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ainspllc' THEN '00010001TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'ajamesto' THEN '00890089TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aknollt' THEN '00930093TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alakebob' THEN '05110511TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alakewod' THEN '00970097TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alamplit' THEN '01010101TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'alucerne' THEN '05150515TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'anormand' THEN '01090109TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aoakcres' THEN '01130113TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aoakgran' THEN '01170117TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aoceanwy' THEN '01210121TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aongreen' THEN '01250125TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aparvill' THEN '01330133TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'apinemea' THEN '01370137TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'apinesha' THEN '01410141TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aquail' THEN '01450145TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aramblew' THEN '01490149TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'arobbinw' THEN '01530153TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'arolmead' THEN '01570157TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aroselak' THEN '05190519TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'asilver' THEN '01610161TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'aspringb' THEN '01650165TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'asunnypi' THEN '05230523TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'atallpin' THEN '05270527TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'atelaval' THEN '01690169TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'avictori' THEN '01730173TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awelling' THEN '01810181TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awestgat' THEN '01850185TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awhcreek' THEN '01890189TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awillowp' THEN '01930193TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'awindsor' THEN '01970197TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'palpinev' THEN '00090009TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rarbormo' THEN '02040204TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'razaleag' THEN '02080208TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbaronmo' THEN '02120212TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbeachvi' THEN '02160216TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rblackoa' THEN '02200220TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbluespr' THEN '02240224TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbramble' THEN '02280228TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbrookfi' THEN '02320232TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rbrookva' THEN '02360236TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcarsonv' THEN '02400240TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcedarpa' THEN '02440244TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcherryh' THEN '02480248TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcindere' THEN '02520252TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcirclel' THEN '02560256TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcloverl' THEN '02600260TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcountrc' THEN '02640264TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcountrm' THEN '02680268TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcrestvi' THEN '02720272TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rcrestwo' THEN '02760276TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rdelawar' THEN '02800280TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'relmgrov' THEN '02840284TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rfarming' THEN '02880288TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rfernwoo' THEN '02920292TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rflaming' THEN '02960296TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rforestl' THEN '03000300TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rfreedom' THEN '03040304TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rgasligh' THEN '03080308TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rglenlea' THEN '03120312TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rgoldenp' THEN '03160316TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhawthor' THEN '03200320TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhiddenv' THEN '03240324TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhillcou' THEN '03280328TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rhumming' THEN '03320332TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rjackson' THEN '03360336TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rkiljord' THEN '03400340TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rkingpar' THEN '03440344TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlacasit' THEN '03480348TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlakevie' THEN '03520352TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rleisure' THEN '03560356TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlilyoft' THEN '03600360TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rlondons' THEN '03640364TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmiamimo' THEN '03680368TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmission' THEN '03720372TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmobilee' THEN '03760376TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rmountai' THEN '03800380TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'roldhick' THEN '03840384TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rozarkhi' THEN '03880388TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rparkvie' THEN '03920392TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rparkway' THEN '03960396TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rpinegro' THEN '04000400TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rplantat' THEN '04040404TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rpueblos' THEN '04080408TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rranchwo' THEN '04120412TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rredceda' THEN '04160416TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rredmapl' THEN '04200420TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rredwood' THEN '04240424TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rshadowm' THEN '04280428TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rshenand' THEN '04320432TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsilverl' THEN '04360436TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsilverm' THEN '04400440TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsouthla' THEN '04440444TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rstonega' THEN '04480448TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rswancre' THEN '04520452TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rsweetgu' THEN '04560456TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rthemead' THEN '04600460TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rthepine' THEN '04640464TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rvalleyo' THEN '04680468TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rvalleyv' THEN '04720472TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rvillage' THEN '04760476TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwesters' THEN '04800480TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwesterv' THEN '04840484TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwhiteoa' THEN '04880488TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwhitepi' THEN '04920492TT'
											WHEN BdmDedCode = 'UHPPO' AND OrgGLSegment = 'rwhittie' THEN '04960496TT'
										END


        ,drvHD05_CoverageLevelCode = CASE WHEN BdmBenOption IN ('EE') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('EES', 'EEDP') THEN 'ESP'
                                                     WHEN BdmBenOption IN ('EEC') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('EEF', 'EEDPF') THEN 'FAM'
                                                END
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '348' END
        ,drvDTP02_DateTimeFormatQual_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_348 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END
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
                      + CASE BdmDedType
                             WHEN 'MED' THEN '1'
                             WHEN 'DEN' THEN '2'
                             WHEN 'VIS' THEN '3'
                             ELSE '9'
                      END
    INTO dbo.U_EUHCINS834_DrvTbl_2300
    FROM dbo.U_EUHCINS834_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EUHCINS834 WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
	JOIN dbo.Location WITH(NOLOCK)
		ON LocCode = EecLocation
	JOIN dbo.OrgLevel WITH(NOLOCK) 
		ON COALESCE(eecorglvl1, eecorglvl2, eecorglvl3) = orgcode
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

    -- PDG Load
      INSERT INTO U_EUHCINS834_DrvTbl_2300
    SELECT DISTINCT 
     drvHD00_HealthCoverage 
        ,drvHD01_MaintTypeCode 
        ,drvHD02_MaintReasonCode 
        ,drvHD03_InsuranceLineCode = 'PDG'
        ,drvHD04_PlanCoverageDesc 
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
        ,drvREF00_RefNumberQual1 = ''
        ,drvREF01_RefNumberQual1 = ''
        ,drvREF02_RefNumberQual1 = ''
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual2 = ''
        ,drvREF01_RefNumberQual2 = ''
        ,drvREF02_RefNumberQual2 = ''
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = ''
        ,drvAMT01_AmountQualifierCode1 = ''
        ,drvAMT02_MonetaryAmount1 = ''
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = ''
        ,drvAMT01_AmountQualifierCode2 = ''
        ,drvAMT02_MonetaryAmount2 = ''
        --=====================
        -- Loop 2700 RECORDS
        --=====================
        ,drvLS01_LoopIDCode  = ''
        ,drvLX01_AssignedNumber  = ''
        --=====================
        -- Loop 2750 RECORDS
        --=====================
        ,drvN101_EntityIDCodeSponsor  = ''
        ,drvN102_Name  = ''
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberDesc = ''
        ,drvLE01_LoopIDCode  = ''
        ---------------------------------
        ,drvEEID 
        ,drvCOID 
        ,drvDepRecID 
        ,drvSSN 
        ,drvInitialSort
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(drvSSN)) + CONVERT(CHAR(12),ISNULL(drvDepRecID,''))
                      + '2'
        FROM dbo. U_EUHCINS834_DrvTbl_2300
        ;

    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_EUHCINS834_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_EUHCINS834_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_EUHCINS834_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('EUHCINS834','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'INSPR_EUHCINS834_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'EUHCINS834';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEUHCINS834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EUHCINS834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefFEEOnlyBenOpti
WHERE AdfHeaderSystemID LIKE 'EUHCINS834%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'EUHCINS834';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEUHCINS834_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_EUHCINS834_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)