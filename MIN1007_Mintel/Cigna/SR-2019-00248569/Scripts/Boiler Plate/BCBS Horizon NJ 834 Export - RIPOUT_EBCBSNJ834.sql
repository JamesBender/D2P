/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "@DeveloperName" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
@CustomerName - Replace with customer name
@DeveloperName - Replace with TC name
@IntegrationAnalystName - Replace with BA/IC name
@CreateDate - Replace with date of creation
@SRNumber - Replace with SR number
@CustomFormatCode - Replace with Format Code (i.e., EBCBSNJ834)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., BCBS Horizon NJ 834 Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@TestFilePath - Replace with the Test Path where the file generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@UDESFilePath - Replace with the UDES Path where the file generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)
@FileNamePrefix - Replace with the ISA06 Sender ID Value for File Transmission (i.e., FTT0000customer)

-- File Header parameters
@ISA06SenderID - Replace with the ISA06 Sender ID Value for File Transmission (i.e., FTT0000)
@ISA08ReceiverID - Replace with the ISA06 Sender ID Value for File Transmission (i.e., HBCBSNJGATEWAY)
@GS02SenderID - Replace with the ISA06 Sender ID Value for File Transmission (i.e., FTT0000)
@GS03ReceiverID - Replace with the ISA06 Sender ID Value for File Transmission (i.e., HBCBSNJGATEWAY)
@HeaderREF38 - Replace with the ISA06 Sender ID Value for File Transmission (i.e., SEEI000)
@Loop1000AN104SenderID - Replace with the ISA06 Sender ID Value for File Transmission (i.e., Usually Company FEIN# 000000000)
@Loop1000BN104ReceiverID - Replace with the ISA06 Sender ID Value for File Transmission (i.e., 220999690)

-- Data parameters
@DedCodeListMED - Replace with Deduction Code List in CSV format (i.e., DED1,DED2,DED3)
@DedCodeListPDG - Replace with Deduction Code List in CSV format (i.e., DED1,DED2,DED3)
@DedCodeListVIS - Replace with Deduction Code List in CSV format (i.e., DED1,DED2,DED3)

NOTE: SEARCH FOR THE BELOW PARAMETERS TO SKIP TO THE RECORD IN THE TABLE INSTEAD OF FIND/REPLACE, TO ENSURE ',' FORMAT IS CORRECT
@EEBenOpts - Replace with EE only benefit options for drvCoverageLevel (i.e., EE)
@ECHBenOpts - Replace with EE+CHILDREN benefit options for drvCoverageLevel (i.e., EES)
@ESPBenOpts - Replace with EE+SPOUSE benefit options for drvCoverageLevel (i.e., EEC)
@EDPBenOpts - Replace with EE+DOMESTICPARTNER benefit options for drvCoverageLevel (i.e., EEDP)
@EEFAMBenOpts - Replace with EE+FAMILY benefit options for drvCoverageLevel (i.e., FAM)
*/
IF OBJECT_ID('dsi_fn_@CustomFormatCode_GetRef1L') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_@CustomFormatCode_GetRef1L];
GO
IF OBJECT_ID('dsi_fn_@CustomFormatCode_2100ALoop_Value') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_@CustomFormatCode_2100ALoop_Value];
GO
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Audit];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_Trailers') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_Trailers];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_Headers') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_Headers];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_2300Loops') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_2300Loops];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_2100ALoops') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_2100ALoops];
GO
IF OBJECT_ID('U_dsi_@CustomFormatCode_2000Loops') IS NOT NULL DROP TABLE [dbo].[U_dsi_@CustomFormatCode_2000Loops];
GO
IF OBJECT_ID('U_Dsi_DrvTbl_@CustomFormatCode_Audit') IS NOT NULL DROP TABLE [dbo].[U_Dsi_DrvTbl_@CustomFormatCode_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','CDE','@CustomFormatCode','BCBS Horizon NJ 834 Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','747','S','N',@AdhSystemID,'N',NULL,'C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','01','1',NULL,NULL,NULL,NULL,'"ISA"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','01','2',NULL,NULL,NULL,NULL,'"00"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'10','H','01','3',NULL,NULL,NULL,NULL,'""','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','01','4',NULL,NULL,NULL,NULL,'"00"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'10','H','01','5',NULL,NULL,NULL,NULL,'"DrvSegISA04"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'2','H','01','6',NULL,NULL,NULL,NULL,'"DrvSegISA05Option"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'15','H','01','7',NULL,NULL,NULL,NULL,'"DrvSegISA06"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','H','01','8',NULL,NULL,NULL,NULL,'"DrvSegISA07Option"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'15','H','01','9',NULL,NULL,NULL,NULL,'"DrvSegISA08"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'6','H','01','10',NULL,NULL,NULL,NULL,'"GetDate()"','(''UD012''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'4','H','01','11',NULL,NULL,NULL,NULL,'"GetDate()"','(''UDHMS''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'1','H','01','12',NULL,NULL,NULL,NULL,'"DrvRepetitionSeparator"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'5','H','01','13',NULL,NULL,NULL,NULL,'"DrvInterchangeControlNum"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'9','H','01','14',NULL,NULL,NULL,NULL,'"DrvSegISA13"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '15',@AdhSystemID,'1','H','01','15',NULL,NULL,NULL,NULL,'"0"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '16',@AdhSystemID,'1','H','01','16',NULL,NULL,NULL,NULL,'"DrvUsageIndicator"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '17',@AdhSystemID,'1','H','01','17',NULL,NULL,NULL,NULL,'"DrvCompElemSeparator"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','02','1',NULL,NULL,NULL,NULL,'"GS"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','02','2',NULL,NULL,NULL,NULL,'"BE"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','02','3',NULL,NULL,NULL,NULL,'"DrvSegIGS02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'15','H','02','4',NULL,NULL,NULL,NULL,'"DrvSegIGS03"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'8','H','02','5',NULL,NULL,NULL,NULL,'"GetDate()"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'4','H','02','6',NULL,NULL,NULL,NULL,'"GetDate()"','(''UDHMS''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'9','H','02','7',NULL,NULL,NULL,NULL,'"DrvSegIGS06"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'1','H','02','8',NULL,NULL,NULL,NULL,'"X"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'12','H','02','9',NULL,NULL,NULL,NULL,'"DrvVersionCode"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','03','1',NULL,NULL,NULL,NULL,'"ST"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','03','2',NULL,NULL,NULL,NULL,'"834"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'10','H','03','3',NULL,NULL,NULL,NULL,'"DrvST02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'32','H','03','4',NULL,NULL,NULL,NULL,'"DrvImplConventionRef"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','04','1',NULL,NULL,NULL,NULL,'"BGN"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','04','2',NULL,NULL,NULL,NULL,'"00"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'30','H','04','3',NULL,NULL,NULL,NULL,'"DrvSegBGN02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','H','04','4',NULL,NULL,NULL,NULL,'"GetDate()"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'4','H','04','5',NULL,NULL,NULL,NULL,'"GetDate()"','(''UDHMS''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'2','H','04','6',NULL,NULL,NULL,NULL,'"ET"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'1','H','04','7',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'1','H','04','8',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','H','04','9',NULL,NULL,NULL,NULL,'"DrvActionCode"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','05','1',NULL,NULL,NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','05','2',NULL,NULL,NULL,NULL,'"DrvSegRef01"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'30','H','05','3',NULL,NULL,NULL,NULL,'"DrvSegRef02"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','06','1',NULL,NULL,NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','06','2',NULL,NULL,NULL,NULL,'"DrvSegDTP01"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','H','06','3',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'8','H','06','5',NULL,NULL,NULL,NULL,'"DrvSegDTP03"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','07','1',NULL,NULL,NULL,NULL,'"QTY"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','07','2',NULL,NULL,NULL,NULL,'"ET"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','07','3',NULL,NULL,NULL,NULL,'"DrvSegQTY02ET"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','08','1',NULL,NULL,NULL,NULL,'"QTY"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','08','2',NULL,NULL,NULL,NULL,'"DT"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','08','3',NULL,NULL,NULL,NULL,'"DrvSegQTY02DT"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','09','1',NULL,NULL,NULL,NULL,'"QTY"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','09','2',NULL,NULL,NULL,NULL,'"TO"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','09','3',NULL,NULL,NULL,NULL,'"DrvSegQTY02TO"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','10','1',NULL,NULL,NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','10','2',NULL,NULL,NULL,NULL,'"P5"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'64','H','10','3',NULL,NULL,NULL,NULL,'"DrvLoop1000ASegn102"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','10','4',NULL,NULL,NULL,NULL,'"DrvLoop1000ASegn103Option"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'10','H','10','5',NULL,NULL,NULL,NULL,'"DrvLoop1000ASegn104"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','11','1',NULL,NULL,NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','11','2',NULL,NULL,NULL,NULL,'"IN"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'64','H','11','3',NULL,NULL,NULL,NULL,'"DrvLoop1000BSegn102"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','11','4',NULL,NULL,NULL,NULL,'"DrvLoop1000BSegn103Option"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'20','H','11','5',NULL,NULL,NULL,NULL,'"DrvLoop1000BSegn104"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','15','1',NULL,NULL,NULL,NULL,'"INS"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'1','D','15','2',NULL,NULL,NULL,NULL,'"DrvLoop2000INS01RecType"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','15','3',NULL,NULL,NULL,NULL,'"DrvLoop2000INS02RelationshipCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','15','4',NULL,NULL,NULL,NULL,'"DrvLoop2000INS03MaintTypeTerm"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'2','D','15','5',NULL,NULL,NULL,NULL,'"DrvLoop2000INS04MaintRsnCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'1','D','15','6',NULL,NULL,NULL,NULL,'"DrvLoop2000INS05BenStatusCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'1','D','15','7',NULL,NULL,NULL,NULL,'"DrvLoop2000INS06Medicare"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'1','D','15','8',NULL,NULL,NULL,NULL,'"DrvLoop2000INS07Cobra"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','15','9',NULL,NULL,NULL,NULL,'"DrvLoop2000INS08Status"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'1','D','15','10',NULL,NULL,NULL,NULL,'"DrvLoop2000INS09Student"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'1','D','15','11',NULL,NULL,NULL,NULL,'"DrvLoop2000INS10Disabled"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'2','D','15','12',NULL,NULL,NULL,NULL,'"DrvLoop2000INS11"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'8','D','15','13',NULL,NULL,NULL,NULL,'"DrvLoop2000INS12"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','16','1',NULL,NULL,NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','D','16','2',NULL,NULL,NULL,NULL,'"0F"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','D','16','3',NULL,NULL,NULL,NULL,'"DrvEmpSSN"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','17','1',NULL,NULL,NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'256','D','17','2',NULL,NULL,NULL,NULL,'"DrvLoop2000REF01A"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','17','3',NULL,NULL,NULL,NULL,'"DrvLoop2000REF02A"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','18','1',NULL,NULL,NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'256','D','18','2',NULL,NULL,NULL,NULL,'"DrvLoop2000REF01B"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','18','3',NULL,NULL,NULL,NULL,'"DrvLoop2000REF02B"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','19','1',NULL,NULL,NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'256','D','19','2',NULL,NULL,NULL,NULL,'"DrvLoop2000REF01C"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','19','3',NULL,NULL,NULL,NULL,'"DrvLoop2000REF02C"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','20','1',NULL,NULL,NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'256','D','20','2',NULL,NULL,NULL,NULL,'"DrvLoop2000REF01D"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','20','3',NULL,NULL,NULL,NULL,'"DrvLoop2000REF02D"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','21','1',NULL,NULL,NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','21','2',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP01A"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','21','3',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','D','21','4',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP03A"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','22','1',NULL,NULL,NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','22','2',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP01B"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','22','3',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','D','22','4',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP03B"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','23','1',NULL,NULL,NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','23','2',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP01C"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','23','3',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','D','23','4',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP03C"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','24','1',NULL,NULL,NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','24','2',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP01D"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','24','3',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','D','24','4',NULL,NULL,NULL,NULL,'"DrvLoop2000DTP03D"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','28','1',NULL,NULL,NULL,NULL,'"NM1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','D','28','2',NULL,NULL,NULL,NULL,'"IL"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','28','3',NULL,NULL,NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'60','D','28','4',NULL,NULL,NULL,NULL,'"DrvNameLast"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'35','D','28','5',NULL,NULL,NULL,NULL,'"DrvNameFirst"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'1','D','28','6',NULL,NULL,NULL,NULL,'"DrvNameMiddle"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'4','D','28','7',NULL,NULL,NULL,NULL,'"DrvNamePrefix"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'5','D','28','8',NULL,NULL,NULL,NULL,'"DrvNameSuffix"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','28','9',NULL,NULL,NULL,NULL,'"DrvIDCodeQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'9','D','28','10',NULL,NULL,NULL,NULL,'"DrvMemberSSN"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','29','1',NULL,NULL,NULL,NULL,'"PER"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','D','29','2',NULL,NULL,NULL,NULL,'"IP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','29','3',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','D','29','4',NULL,NULL,NULL,NULL,'"DrvLoop2100APER04"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'10','D','29','5',NULL,NULL,NULL,NULL,'"DrvLoop2100APER05"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'2','D','29','6',NULL,NULL,NULL,NULL,'"DrvLoop2100APER06"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'10','D','29','7',NULL,NULL,NULL,NULL,'"DrvLoop2100APER07"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','D','29','8',NULL,NULL,NULL,NULL,'"DrvLoop2100APER08"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'50','D','29','9',NULL,NULL,NULL,NULL,'"DrvLoop2100APER09"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','30','1',NULL,NULL,NULL,NULL,'"N3"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'30','D','30','2',NULL,NULL,NULL,NULL,'"DrvAddressLine1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'30','D','30','3',NULL,NULL,NULL,NULL,'"DrvAddressLine2"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','31','1',NULL,NULL,NULL,NULL,'"N4"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'20','D','31','2',NULL,NULL,NULL,NULL,'"DrvAddressCity"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','31','3',NULL,NULL,NULL,NULL,'"DrvAddressState"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'10','D','31','4',NULL,NULL,NULL,NULL,'"DrvAddressZipCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'3','D','31','5',NULL,NULL,NULL,NULL,'"DrvLoop2100AN404"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'32','D','31','6',NULL,NULL,NULL,NULL,'""','(''SS''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'32','D','31','7',NULL,NULL,NULL,NULL,'"DrvLoop2100AN406"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'3','D','31','8',NULL,NULL,NULL,NULL,'"DrvLoop2100AN407"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','32','1',NULL,NULL,NULL,NULL,'"DMG"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','D','32','2',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'8','D','32','3',NULL,NULL,NULL,NULL,'"DrvDateOfBirth"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'1','D','32','4',NULL,NULL,NULL,NULL,'"DrvGender"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'32','D','32','5',NULL,NULL,NULL,NULL,'"DrvLoop2100ADMG04"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'32','D','32','6',NULL,NULL,NULL,NULL,'"DrvLoop2100ADMG05"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'1','D','32','7',NULL,NULL,NULL,NULL,'"DrvLoop2100ADMG06"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','33','1',NULL,NULL,NULL,NULL,'"ICM"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'32','D','33','2',NULL,NULL,NULL,NULL,'"DrvLoop2100AICM01"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'32','D','33','3',NULL,NULL,NULL,NULL,'"DrvLoop2100AICM02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'32','D','33','4',NULL,NULL,NULL,NULL,'"DrvLoop2100AICM03"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'32','D','33','5',NULL,NULL,NULL,NULL,'"DrvLoop2100AICM04"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'32','D','33','6',NULL,NULL,NULL,NULL,'"DrvLoop2100AICM05"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','34','1',NULL,NULL,NULL,NULL,'"AMT"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'32','D','34','2',NULL,NULL,NULL,NULL,'"DrvLoop2100AAMT01"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'32','D','34','3',NULL,NULL,NULL,NULL,'"DrvLoop2100AAMT02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'32','D','34','4',NULL,NULL,NULL,NULL,'"DrvLoop2100AAMT03"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','35','1',NULL,NULL,NULL,NULL,'"HLH"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'32','D','35','2',NULL,NULL,NULL,NULL,'"DrvLoop2100AHLH01"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'32','D','35','3',NULL,NULL,NULL,NULL,'"DrvLoop2100AHLH02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'32','D','35','4',NULL,NULL,NULL,NULL,'"DrvLoop2100AHLH03"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','36','1',NULL,NULL,NULL,NULL,'"HLH"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'32','D','36','2',NULL,NULL,NULL,NULL,'"DrvLoop2100ALUI01"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'32','D','36','3',NULL,NULL,NULL,NULL,'"DrvLoop2100ALUI02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'32','D','36','4',NULL,NULL,NULL,NULL,'"DrvLoop2100ALUI03"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'32','D','36','5',NULL,NULL,NULL,NULL,'"DrvLoop2100ALUI04"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','50','1',NULL,NULL,NULL,NULL,'"HD"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','50','2',NULL,NULL,NULL,NULL,'"DrvHD01"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','50','3',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','50','4',NULL,NULL,NULL,NULL,'"DrvHD03"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'64','D','50','5',NULL,NULL,NULL,NULL,'"DrvHD04"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'3','D','50','6',NULL,NULL,NULL,NULL,'"DrvHD05"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','51','1',NULL,NULL,NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','51','2',NULL,NULL,NULL,NULL,'"348"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','51','3',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','D','51','4',NULL,NULL,NULL,NULL,'"DrvDTP03A"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','52','1',NULL,NULL,NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','52','2',NULL,NULL,NULL,NULL,'"349"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','52','3',NULL,NULL,NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','D','52','4',NULL,NULL,NULL,NULL,'"DrvDTP03B"','(''UD112''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','57','1',NULL,NULL,NULL,NULL,'"LX"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'32','D','57','2',NULL,NULL,NULL,NULL,'"Drv2310LX01"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','58','1',NULL,NULL,NULL,NULL,'"NM1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'32','D','58','2',NULL,NULL,NULL,NULL,'"Drv2310NM101"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','58','3',NULL,NULL,NULL,NULL,'"DrvNM102"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'32','D','58','4',NULL,NULL,NULL,NULL,'"Drv2310NM103"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'1','D','58','5',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'1','D','58','6',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'1','D','58','7',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'1','D','58','8',NULL,NULL,NULL,NULL,'""','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','58','9',NULL,NULL,NULL,NULL,'"Drv2310NM108"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'32','D','58','10',NULL,NULL,NULL,NULL,'"Drv2310NM109"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'2','D','58','11',NULL,NULL,NULL,NULL,'"72"','(''DA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','59','1',NULL,NULL,NULL,NULL,'"COB"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'32','D','59','2',NULL,NULL,NULL,NULL,'"Drv2320COB03"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','T','97','1',NULL,NULL,NULL,NULL,'"SE"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'10','T','97','2',NULL,NULL,NULL,NULL,'"RECCNT"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'10','T','97','3',NULL,NULL,NULL,NULL,'"DrvSegSE02"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','T','98','1',NULL,NULL,NULL,NULL,'"GE"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'1','T','98','2',NULL,NULL,NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','98','3',NULL,NULL,NULL,NULL,'"DrvSegGE02"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','T','99','1',NULL,NULL,NULL,NULL,'"IEA"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'1','T','99','2',NULL,NULL,NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','99','3',NULL,NULL,NULL,NULL,'"DrvSegIEA02"','(''UA''=''T'')';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'On demand run',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','ONDEMAND','Jan  1 2019  9:33AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Jan  1 2019  7:06PM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '9',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled run',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','SCHEDULED','Jan  1 2019  9:41AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '9',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Test run',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','TEST','Jan  1 2019  9:46AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '9',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Open enrollment - passive',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','OEPASSIVE','Jan  1 2019 11:42AM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '9',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Open enrollment - active',CONVERT(CHAR(8),GETDATE(),112) + '1','EMPEXPORT','OEACTIVE','Jan  1 2019  5:19PM','@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '1','Jan  1 2019 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '9',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','FileNumber','V','000000000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@UDESFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Upper','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','dbo.U_dsi_@CustomFormatCode_Headers','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H02','dbo.U_dsi_@CustomFormatCode_Headers','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H03','dbo.U_dsi_@CustomFormatCode_Headers','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H04','dbo.U_dsi_@CustomFormatCode_Headers','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H05','dbo.U_dsi_@CustomFormatCode_Headers','RTRIM(ISNULL(DrvSegRef01,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H06','dbo.U_dsi_@CustomFormatCode_Headers','RTRIM(ISNULL(DrvSegDTP01,'''')) <> '''' AND DrvSegDTP03 IS NOT NULL');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H07','dbo.U_dsi_@CustomFormatCode_Headers','RTRIM(ISNULL(ISNULL(DrvSegQTY02ET,''''),'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H08','dbo.U_dsi_@CustomFormatCode_Headers','RTRIM(ISNULL(ISNULL(DrvSegQTY02DT,''''),'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H09','dbo.U_dsi_@CustomFormatCode_Headers','RTRIM(ISNULL(ISNULL(DrvSegQTY02TO,''''),'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H10','dbo.U_dsi_@CustomFormatCode_Headers','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H11','dbo.U_dsi_@CustomFormatCode_Headers','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D15','dbo.U_dsi_@CustomFormatCode_2000Loops','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D16','dbo.U_dsi_@CustomFormatCode_2000Loops','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D17','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000REF01A,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D18','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000REF01B,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D19','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000REF01C,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000REF01D,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D21','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000DTP01A,'''')) <> '''' AND DrvLoop2000DTP03A IS NOT NULL');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D22','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000DTP01B,'''')) <> '''' AND DrvLoop2000DTP03B IS NOT NULL');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D23','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000DTP01C,'''')) <> '''' AND DrvLoop2000DTP03C IS NOT NULL');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D24','dbo.U_dsi_@CustomFormatCode_2000Loops','RTRIM(ISNULL(DrvLoop2000DTP01D,'''')) <> '''' AND DrvLoop2000DTP03D IS NOT NULL');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D28','dbo.U_dsi_@CustomFormatCode_2100ALoops','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D29','dbo.U_dsi_@CustomFormatCode_2100ALoops','(RTRIM(ISNULL(DrvLoop2100APER04,'''')) <> '''' OR RTRIM(ISNULL(DrvLoop2100APER06,'''')) <> '''' OR RTRIM(ISNULL(DrvLoop2100APER08,'''')) <> '''')');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','dbo.U_dsi_@CustomFormatCode_2100ALoops','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D31','dbo.U_dsi_@CustomFormatCode_2100ALoops','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D32','dbo.U_dsi_@CustomFormatCode_2100ALoops','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D33','dbo.U_dsi_@CustomFormatCode_2100ALoops','RTRIM(ISNULL(DrvLoop2100AICM01,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D34','dbo.U_dsi_@CustomFormatCode_2100ALoops','RTRIM(ISNULL(DrvLoop2100AAMT01,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D35','dbo.U_dsi_@CustomFormatCode_2100ALoops','RTRIM(ISNULL(DrvLoop2100AHLH01,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D36','dbo.U_dsi_@CustomFormatCode_2100ALoops','RTRIM(ISNULL(DrvLoop2100ALUI01,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_dsi_@CustomFormatCode_2300Loops','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D51','dbo.U_dsi_@CustomFormatCode_2300Loops','DrvDTP03A IS NOT NULL');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D52','dbo.U_dsi_@CustomFormatCode_2300Loops','DrvDTP03B IS NOT NULL');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D57','dbo.U_dsi_@CustomFormatCode_2300Loops','RTRIM(ISNULL(Drv2310LX01,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D58','dbo.U_dsi_@CustomFormatCode_2300Loops','RTRIM(ISNULL(Drv2310NM101,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D59','dbo.U_dsi_@CustomFormatCode_2300Loops','RTRIM(ISNULL(Drv2320COB03,'''')) <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T97','dbo.U_dsi_@CustomFormatCode_Trailers',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T98','dbo.U_dsi_@CustomFormatCode_Trailers','');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T99','dbo.U_dsi_@CustomFormatCode_Trailers','');
GO
DECLARE @ISWEB CHAR(1) = '@IsWebFlag';
DECLARE @Cnt CHAR(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
DECLARE @TestServer VARCHAR(5) = (SELECT CASE WHEN @@SERVERNAME LIKE '%Z%' THEN LEFT(@@SERVERNAME,3) + '\' ELSE '' END);
DECLARE @UDENV VARCHAR(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END); 
DECLARE @UDARNUM VARCHAR(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
DECLARE @UDSERVER VARCHAR(10) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM ELSE @TestServer + RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE VARCHAR(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
DECLARE @FileName VARCHAR(1000) = @FormatCode + '_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt';
DECLARE @FilePath VARCHAR(1000) = '\\' + @Cnt + '.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\';
SET @FilePath = REPLACE(REPLACE(REPLACE(@FilePath,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE);
IF (@ISWEB = 'Y')
BEGIN
    UPDATE dbo.U_Dsi_Configuration SET CfgValue = 'N' WHERE FormatCode = @FormatCode AND CfgName IN ('Testing','UseFileName');
    UPDATE dbo.U_Dsi_Configuration SET CfgValue = NULL WHERE FormatCode = @FormatCode AND CfgName = 'ExportPath';

    DELETE FROM dbo.AscExp WHERE expFormatCode = @FormatCode AND expExportCode = 'ZAP';
    UPDATE dbo.AscExp SET expAscFileName = @FilePath + @FileName WHERE expFormatCode = '@CustomFormatCode';

    DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName IN ('TestPath','UDESPath');
END
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_@CustomFormatCode_File') IS NULL
CREATE TABLE [dbo].[U_@CustomFormatCode_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(747) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID VARCHAR(12) = ''
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: BCBS Horizon NJ 834 Export

-------------------
NOTE TO SUPPORT:
-------------------
BCBS Horizon NJ doesn't term by omission, meaning if an employee changes from one Ref 1L to another REF 1L value,
then the vendor requires a FULL record of the old plan with a 349 (Stop) date as well as a full record the new plan
with 348 (Start) Date.  UCN is unable to support this, thus is must be a Custom SQL Export file.

Revision History
----------------
Update By            Date            Request Num                Desc        
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY DateTimeCompleted DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE'
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE'
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND'
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCHEDULED'
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST'

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'N'
**********************************************************************************/
BEGIN

    -----------
    -- Collect date parameters
    -----------
    DECLARE

        @StartDateTime   DATETIME,
        @EndDateTime     DATETIME,
        @StartPerControl CHAR(9),
        @EndPerControl   CHAR(9),
        @FormatCode      CHAR(10),
        @ExportCode      CHAR(10),
        @ExportFile      CHAR(200),
        @FileNum         VARCHAR(32),
        @RunDateTime     DATETIME,
        @MaxOEDateTime   DATETIME,
        @FileMinCovDate  DATETIME;

    SELECT

        @StartDateTime   = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDateTime     = DATEADD(SS, -1, DATEADD(DD, 1, LEFT(EndPerControl, 8))), -- 11:59 PM
        @StartPerControl = StartPerControl,
        @EndPerControl   = EndPerControl,
        @FormatCode      = RTRIM(FormatCode),
        @ExportCode      = ExportCode,
        @Exportfile      = ExportFile,
        @RunDateTime     = GETDATE(),
        @FileMinCovDate  = '01/01/'+ LEFT(EndPerControl,4)

    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = '@CustomFormatCode';

    -----------
    -- Drop tables
    -----------

    IF OBJECT_ID('dbo.U_dsi_@CustomFormatCode_2000Loops')        IS NOT NULL  DROP TABLE dbo.U_dsi_@CustomFormatCode_2000Loops;
    IF OBJECT_ID('dbo.U_dsi_@CustomFormatCode_2100ALoops')       IS NOT NULL  DROP TABLE dbo.U_dsi_@CustomFormatCode_2100ALoops;
    IF OBJECT_ID('dbo.U_dsi_@CustomFormatCode_2300Loops')        IS NOT NULL  DROP TABLE dbo.U_dsi_@CustomFormatCode_2300Loops;
    IF OBJECT_ID('dbo.U_dsi_@CustomFormatCode_Headers')          IS NOT NULL  DROP TABLE dbo.U_dsi_@CustomFormatCode_Headers;
    IF OBJECT_ID('dbo.U_dsi_@CustomFormatCode_Trailers')         IS NOT NULL  DROP TABLE dbo.U_dsi_@CustomFormatCode_Trailers;

    -----------
    -- Remove test employees
    -----------

    --DELETE FROM dbo.U_@CustomFormatCode_EEList WHERE xCOID = 'TC0O9'
    --DELETE FROM dbo.U_@CustomFormatCode_EEList WHERE xEEID NOT IN ('446N6A0000K0');

    -----------
    -- Audit Code - Get Old 'DedGroupCode' Value
    -----------
    IF OBJECT_ID('U_@CustomFormatCode_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Audit;
    SELECT audEEID = audKey1Value 
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
    INTO dbo.U_@CustomFormatCode_Audit
    FROM dbo.vw_AuditData WITH (NOLOCK)
    WHERE audDateTime BETWEEN @StartDateTime AND @EndDateTime
    AND audTableName = 'EmpComp'
    AND audFieldName = 'EecDedGroupCode';

    -----------
    -- Populate BDM for actives - Loop# 1 - VIS
    -----------
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'Loop1');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','@DedCodeListVIS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays','30');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays','30');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '2');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OverrideBenStartDate', 'Y');

    -- Force Deduction type 'VIS' by Deduction Code
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedCodeType', 'EYE,VIS');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedCodeType', 'VIS,VIS');

    IF @ExportCode = 'OEPASSIVE' BEGIN
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode = 'OEACTIVE' BEGIN
        INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

    -----------
    -- Populate BDM for actives - Loop# 2 - MED
    -----------
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'Loop2');
	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','@DedCodeListMED');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays','30');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays','30');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '2');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OverrideBenStartDate', 'Y');

    -- Force Deduction type 'MED' by Deduction Code
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedCodeType', 'HMO,MED');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedCodeType', 'PPO,MED');

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -----------
    -- Populate BDM for actives - Loop# 3 - PDG
    -----------
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'Loop3');
	INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','@DedCodeListPDG');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDateTime);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays','30');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays','30');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CalcBenOptionDate', '2');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OverrideBenStartDate', 'Y');

    -- Force Deduction type 'PDG' by Deduction Code
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedCodeType', 'HMO,PDG');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'UpdDedCodeType', 'PPO,PDG');

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

    -----------
    -- Update Dependent's COID if NULL to Match Employee's COID
    -----------
    UPDATE DEP
    SET DEP.DbnCOID = EMP.EedCoID
    FROM dbo.U_dsi_bdm_DepDeductions DEP
    JOIN dbo.U_dsi_bdm_EmpDeductions EMP
        ON EMP.EedEEID = DEP.DbnEEID
        AND EMP.EedDedCode = DEP.DbnDedCode
    WHERE ISNULL(DEP.DbnCOID,'') = '';

    -----------
    -- Manually Create Audit Records in BDM for OE Terminations
    -----------
    IF (@ExportCode LIKE 'OE%')
    BEGIN
        -- Load Employee Benefit Terminations
        INSERT INTO [dbo].[U_dsi_BDM_Audit] (AudFormatCode, AudKey1Value, AudKey2Value, AudKey3Value, AudTableName, AudFieldName, AudOldValue, AudNewValue, AudDateTime, AudProcessedDateTime, AudEffectiveDate)
        SELECT DISTINCT
             AudFormatCode = @FormatCode
            ,AudKey1Value = EedEEID
            ,AudKey2Value = EedCOID
            ,AudKey3Value = EedDedCode
            ,AudTableName = 'EmpDed'
            ,AudFieldName = 'EedBenStopDate'
            ,AudOldValue = NULL
            ,AudNewValue = EedBenStopDate
            ,AudDateTime = EedTVStartDate
            ,AudProcessedDateTime = EedTVStartDate
            ,AudEffectiveDate = EedTVStartDate
        FROM dbo.EmpDedFull
        WHERE EedDedCode IN ('@DedCodeListMED','@DedCodeListPDG','@DedCodeListVIS')
        AND CONVERT(CHAR(8),EedTVStartDate,112) = CONVERT(CHAR(8),@EndDateTime,112)
        AND EedBenStatus IN ('C','T')
        AND EedBenStopDate IS NOT NULL;

        -- Load Dependent Benefit Terminations
        INSERT INTO [dbo].[U_dsi_BDM_Audit] (AudFormatCode, AudKey1Value, AudKey2Value, AudKey3Value, AudTableName, AudFieldName, AudOldValue, AudNewValue, AudDateTime, AudProcessedDateTime, AudEffectiveDate)
        SELECT DISTINCT
             AudFormatCode = @FormatCode
            ,AudKey1Value = DbnEEID
            ,AudKey2Value = DbnDedCode
            ,AudKey3Value = DbnSystemID
            ,AudTableName = 'DepBPlan'
            ,AudFieldName = 'DbnBenStopDate'
            ,AudOldValue = NULL
            ,AudNewValue = DbnBenStopDate
            ,AudDateTime = DbnTVStartDate
            ,AudProcessedDateTime = DbnTVStartDate
            ,AudEffectiveDate = DbnTVStartDate
        FROM dbo.DepBPlanFull
        WHERE EedDedCode IN ('@DedCodeListMED','@DedCodeListPDG','@DedCodeListVIS')
        AND CONVERT(CHAR(8),DbnTVStartDate,112) = CONVERT(CHAR(8),@EndDateTime,112)
        AND DbnBenStatus IN ('C','T')
        AND DbnBenStopDate IS NOT NULL;
    END;

    -----------
    -- Update BDM User-Defined Field to store REF_1L Value
    -----------

    -- Update Employee Deductions for REF*1L Value
    UPDATE EMP
    SET EMP.EedUSGField1 = CASE WHEN BDM.audFieldName = 'EedBenStopDate' THEN dbo.dsi_fn_@CustomFormatCode_GetRef1L(EedDedCode, COALESCE(DedGroupCode.audOldValue,EecDedgroupCode), DedDedType)
                                ELSE dbo.dsi_fn_@CustomFormatCode_GetRef1L(EedDedCode, EecDedgroupCode, DedDedType)
                           END
    FROM dbo.U_dsi_bdm_EmpDeductions EMP
    JOIN dbo.EmpComp ON EecEEID = EedEEID AND EecCOID = EedCOID
    LEFT JOIN dbo.U_@CustomFormatCode_Audit DedGroupCode ON DedGroupCode.audEEID = EedEEID AND DedGroupCode.audKey2 = EedCOID AND audRowNo = 1
    LEFT JOIN [dbo].[U_dsi_BDM_Audit] BDM ON BDM.audFormatCode = EedFormatCode AND BDM.audKey1Value = EedEEID AND BDM.audKey2Value = EedCOID AND BDM.audKey3Value = EedDedCode AND BDM.audFieldName = 'EedBenStopDate'
    WHERE EedFormatCode = @FormatCode;

    -- Update Dependent Deductions for REF*1L Value
    UPDATE DEP
    SET DEP.DbnUSGField1 = CASE WHEN BDM.audFieldName = 'DbnBenStopDate' THEN dbo.dsi_fn_@CustomFormatCode_GetRef1L(DbnDedCode, COALESCE(DedGroupCode.audOldValue,EecDedgroupCode), DedDedType)
                                ELSE dbo.dsi_fn_@CustomFormatCode_GetRef1L(DbnDedCode, EecDedgroupCode, DedDedType)
                           END
    FROM dbo.U_dsi_bdm_DepDeductions DEP
    JOIN dbo.EmpComp ON EecEEID = DbnEEID AND EecCOID = DbnCOID
    LEFT JOIN dbo.U_@CustomFormatCode_Audit DedGroupCode ON DedGroupCode.audEEID = DbnEEID AND DedGroupCode.audKey2 = DbnCOID AND audRowNo = 1
    LEFT JOIN [dbo].[U_dsi_BDM_Audit] BDM ON BDM.audFormatCode = DbnFormatCode AND BDM.audKey1Value = dbnEEID AND BDM.audKey2Value = dbnDedCode AND BDM.audKey3Value = dbnSystemID AND BDM.audFieldName = 'DbnBenStopDate'
    WHERE DbnFormatCode = @FormatCode;

    -----------
    -- Manually Validate BDM Records
    -----------
    
    -- Manually Re-Validate Recently Terminated Medical and PDG Plans for Employees when REF*1L Values Change
    UPDATE E1
    SET EedValidForExport = 'Y'
       ,EedDedRowStatus = ISNULL(RTRIM(EedDedRowStatus),'') + '; Manually Re-Validated for Vision for Recent Terms'
    FROM dbo.U_dsi_bdm_EmpDeductions E1
    WHERE EedFormatCode = @FormatCode AND EedValidForExport = 'N'
    AND EXISTS (SELECT 1 FROM [dbo].[U_dsi_BDM_Audit] WHERE audFormatCode = EedFormatCode AND audKey1Value = EedEEID AND audKey2Value = EedCOID AND audKey3Value = EedDedCode AND audFieldName = 'EedBenStopDate')
    AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_EmpDeductions E2 WHERE E2.EedFormatCode = E1.EedFormatCode AND E2.EedRunId = E1.EedRunID AND E2.EedEEID = E1.EedEEID AND E2.EedCOID = E1.EedCOID AND E2.EedUSGField1 <> E1.EedUSGField1);

    --Manually Re-Validate Recently Terminated Medical and PDG Plans for Dependents when REF*1L Values Change
    UPDATE D1
    SET dbnValidForExport = 'Y'
       ,dbnDedRowStatus = ISNULL(RTRIM(dbnDedRowStatus),'') + '; Manually Re-Validated for Vision for Recent Terms'
    FROM dbo.U_dsi_bdm_depDeductions D1
    WHERE dbnFormatCode = @FormatCode AND DbnValidForExport = 'N'
    AND EXISTS (SELECT 1 FROM [dbo].[U_dsi_BDM_Audit] WHERE audFormatCode = dbnFormatCode AND audKey1Value = dbnEEID AND audKey2Value = dbnDedCode AND audKey3Value = dbnSystemID AND audFieldName = 'DbnBenStopDate')
    AND EXISTS (SELECT 1 FROM dbo.U_dsi_bdm_depDeductions D2 WHERE D2.DbnFormatCode = D1.DbnFormatCode AND D2.DbnRunId = D1.DbnRunID AND D2.DbnEEID = D1.DbnEEID AND D2.DbnCOID = D1.DbnCOID AND D2.DbnUSGField1 <> D1.DbnUSGField1);

    -----------
    -- Run Consolidate Table
    -----------
    EXEC  [dbo].[dsi_BDM_sp_BuildConsolidatedTable] @FormatCode ,'Standard'
 
    -----------
    -- Update dependent record IDs for employees (for sorting)
    -----------

    UPDATE dbo.U_dsi_bdm_@CustomFormatCode
    SET BdmDepRecID = '000000000000'
    WHERE BdmRecType = 'EMP'

    -----------
    -- Reduce EEList to employees with benefits 
    -----------

    DELETE FROM dbo.U_@CustomFormatCode_EEList

    INSERT INTO dbo.U_@CustomFormatCode_EEList
    SELECT DISTINCT BdmCOID, BdmEEID FROM dbo.U_dsi_bdm_@CustomFormatCode

    -----------
    -- Build  dbo.U_dsi_@CustomFormatCode_2300Loops
    -----------

    SELECT DISTINCT

    DrvCOID        = bdm.BdmCOID,
    DrvEEID        = bdm.BdmEEID,
    DrvSSN         = EepSSN,
    DrvDepRecID    = ISNULL(BdmDepRecID, ''),
    DrvRecType     = bdm.BdmRecType,
    DrvRef1L       = BdmUSGField1,
    DrvBdmRunID    = bdm.BdmRunID,
    DrvSort        = RTRIM(EepSSN)+ bdm.BdmDepRecID + BdmUSGField1
                    + CASE WHEN bdm.BdmBenStopDate IS NOT NULL THEN '01' ELSE '02' END,
    drvSubSort     = '2300' + bdm.BdmDedType,
    DrvHD01        = '030',
    DrvHD03        = CASE WHEN bdm.BdmDedType LIKE 'VIS%' THEN 'VIS' 
                          WHEN bdm.BdmDedType LIKE 'PDG%' THEN 'PDG'
                          WHEN bdm.BdmDedType LIKE  'MED%'  THEN 'HLT'
                          END,
    DrvHD04        = '', 
    DrvHD05        = CASE WHEN bdm.BdmRecType = 'DEP' THEN ''
                          WHEN bdm.BdmBenOption IN ('@EEBenOpts')  THEN 'EMP'
                          WHEN bdm.BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                          WHEN bdm.BdmBenOption IN ('@ESPBenOpts','@EDPBenOpts') THEN 'ESP'
                          WHEN bdm.BdmBenOption IN ('@EEFAMBenOpts') THEN 'FAM'
                          ELSE 'TBD'
                     END,
    DrvDTP03A      = CASE WHEN bdm.BdmBenStopDate IS NOT NULL THEN bdm.BdmBenStartDate
                          ELSE dbo.dsi_fnGetMinMaxDates('MAX',bdm.BdmBenStartDate, @FileMinCovDate)
                     END,
    DrvDTP03B      = CASE WHEN bdm.BdmBenStopDate IS NOT NULL THEN bdm.BdmBenStopDate + 1
                     END,
    Drv2310LX01    = '',
    Drv2310NM101   = '',
    Drv2310NM102   = '',
    Drv2310NM103   = '',
    Drv2310NM108   = '',
    Drv2310NM109   = '',
    Drv2320COB03   = ''

    INTO dbo.U_dsi_@CustomFormatCode_2300Loops
    FROM dbo.U_dsi_bdm_@CustomFormatCode bdm
    JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = bdm.BdmEEID
    JOIN (SELECT
 
          e.BdmEEID          EEID,
          e.BdmBenStartDate  BenStartDate
 
          FROM dbo.U_dsi_bdm_@CustomFormatCode e
           WHERE e.BdmEEID = BdmEEID
             AND e.BdmRecType = 'EMP') emp ON emp.EEID = bdm.BdmEEID
    WHERE bdm.bdmBenStartDate IS NOT NULL;


    -----------
    -- Build select * from dbo.U_dsi_@CustomFormatCode_2000Loops for employees
    -----------

    SELECT DISTINCT

    DrvCOID = dbo.dsi_fn_GetCurrentCOID(xEEID),
    DrvEEID,
    DrvSSN,
    DrvDepRecID,
    DrvRecType,
    DrvSort                          = DrvSort,
    drvSubSort                       = '2000',
    DrvLoop2000INS01RecType          = 'Y',
    DrvRelationship                  = 'EMP',
    DrvLoop2000INS02RelationshipCode = '18',
    DrvLoop2000INS03MaintTypeTerm    = '030',
    DrvLoop2000INS04MaintRsnCode     = 'XN',
    DrvLoop2000INS05BenStatusCode    = 'A',
    DrvLoop2000INS06Medicare         = '',
    DrvLoop2000INS07Cobra            = '',
    DrvLoop2000INS08Status           = 'FT',
    DrvLoop2000INS09Student          = '',
    DrvLoop2000INS10Disabled         = '', 
    DrvLoop2000INS11                 = CASE WHEN ISNULL(EepDateDeceased,'') <> '' THEN 'D8' END,
    DrvLoop2000INS12                 = CASE WHEN ISNULL(EepDateDeceased,'') <> '' THEN EepDateDeceased END,
    DrvEmpSSN                        = EepSSN,

    DrvLoop2000REF01A                = '1L',
    DrvLoop2000REF02A                = DrvRef1l,

    DrvLoop2000REF01B                = '',
    DrvLoop2000REF02B                = '',
    DrvLoop2000REF01C                = '',
    DrvLoop2000REF02C                = '',

    DrvLoop2000REF01D                = '',
    DrvLoop2000REF02D                = '',

    DrvLoop2000DTP01A                = '336',
    DrvLoop2000DTP03A                = EecDateOfOriginalHire,

    DrvLoop2000DTP01B                = '',
    DrvLoop2000DTP03B                = '',

    DrvLoop2000DTP01C                = '',           
    DrvLoop2000DTP03C                = '',

    DrvLoop2000DTP01D                = '',
    DrvLoop2000DTP03D                = ''

    INTO dbo.U_dsi_@CustomFormatCode_2000Loops
    FROM dbo.U_@CustomFormatCode_EEList 

    JOIN (SELECT bdmEEID,bdmCoID FROM dbo.U_dsi_bdm_@CustomFormatCode) bdmEERun ON bdmEERun.bdmEEID = xEEID AND bdmEERun.bdmCoID = xCoID
    JOIN dbo.U_dsi_@CustomFormatCode_2300Loops  WITH (NOLOCK) ON DrvRecType = 'EMP' AND DrvEEID = xEEID
    JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK) ON EecCOID = dbo.dsi_fn_GetCurrentCOID(xEEID) AND EecEEID = xEEID;


    -----------
    -- Build dbo.U_dsi_@CustomFormatCode_2000Loops for dependents
    -----------

    INSERT INTO dbo.U_dsi_@CustomFormatCode_2000Loops
    SELECT DISTINCT

    DrvCOID,
    DrvEEID,
    DrvSSN,
    DrvDepRecID,
    DrvRecType,
    DrvSort                          = DrvSort,
    drvSubSort                       = '2000',
    DrvLoop2000INS01RecType          = 'N',
    DrvRelationship                  = ConRelationship,
    DrvLoop2000INS02RelationshipCode = CASE
                                          WHEN ConRelationship = 'SPS' THEN '01'  
                                          WHEN ConRelationship IN ('CHL', 'STC', 'SON', 'DAU') THEN '19'  
                                          WHEN ConRelationship = 'CUP' THEN '53'  
                                          ELSE '19'  
                                       END,
    DrvLoop2000INS03MaintTypeTerm    = '030',
    DrvLoop2000INS04MaintRsnCode     = 'XN',
    DrvLoop2000INS05BenStatusCode    = 'A',
    DrvLoop2000INS06Medicare         = '',
    DrvLoop2000INS07Cobra            = '',
    DrvLoop2000INS08Status           = '',
    DrvLoop2000INS09Student          = '',
    DrvLoop2000INS10Disabled         = '',
    DrvLoop2000INS11                 = '',
    DrvLoop2000INS12                 = NULL,
    DrvEmpSSN                        = EepSSN,

    DrvLoop2000REF01A                = '1L',
    DrvLoop2000REF02A                = DrvRef1l,

    DrvLoop2000REF01B                = '',
    DrvLoop2000REF02B                = '',
    DrvLoop2000REF01C                = '',
    DrvLoop2000REF02C                = '',

    DrvLoop2000REF01D                = '',
    DrvLoop2000REF02D                = '',

    DrvLoop2000DTP01A                = '336',
    DrvLoop2000DTP03A                = EecDateOfOriginalHire,

    DrvLoop2000DTP01B                = '',
    DrvLoop2000DTP03B                = '',

    DrvLoop2000DTP01C                = '',           
    DrvLoop2000DTP03C                = '',

    DrvLoop2000DTP01D                = '',
    DrvLoop2000DTP03D                = ''

    FROM dbo.U_@CustomFormatCode_EEList 


    JOIN (SELECT bdmEEID,bdmCoID FROM dbo.U_dsi_bdm_@CustomFormatCode) bdmEERun ON bdmEEID = xEEID AND bdmCoID = xCoID
    JOIN dbo.U_dsi_@CustomFormatCode_2300Loops WITH (NOLOCK) ON DrvRecType = 'DEP' AND DrvEEID = xEEID
    JOIN EmpPers WITH (NOLOCK) ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK) ON eecEEID = xEEID AND eecCoID= xCoID
    JOIN dbo.Contacts WITH (NOLOCK) ON ConEEID = DrvEEID AND ConSystemID = DrvDepRecID;


    -----------
    -- Build dbo.U_dsi_@CustomFormatCode_2100ALoops for employees and dependents
    -----------

    SELECT DISTINCT

    DrvCOID,
    DrvEEID,
    DrvSSN,
    DrvDepRecID,
    DrvRecType,
    DrvSort                = DrvSort,
    drvSubSort             = '2100A',
    DrvNameLast            = CASE 
                                WHEN DrvRecType = 'EMP' THEN EepNameLast 
                                WHEN DrvRecType = 'DEP' THEN ConNameLast 
                             END,
    DrvNameFirst           = CASE 
                                WHEN DrvRecType = 'EMP' THEN EepNameFirst 
                                WHEN DrvRecType = 'DEP' THEN ConNameFirst 
                             END,
    DrvNameMiddle          = CASE 
                                WHEN DrvRecType = 'EMP' THEN EepNameMiddle
                                WHEN DrvRecType = 'DEP' THEN ConNameMiddle
                             END,
    DrvNamePrefix          = CASE 
                                WHEN DrvRecType = 'EMP' THEN CASE WHEN EepNamePrefix = 'Z' THEN '' ELSE EepNamePrefix END
                                ELSE ''
                             END,
    DrvNameSuffix          = CASE 
                                WHEN DrvRecType = 'EMP' THEN CASE WHEN EepNameSuffix = 'Z' THEN '' ELSE EepNameSuffix END
                                WHEN DrvRecType = 'DEP' THEN CASE WHEN ConNameSuffix = 'Z' THEN '' ELSE ConNameSuffix END
                             END,  

    DrvIDCodeQualifier     = CASE WHEN DrvRecType = 'DEP' AND COALESCE(ConSSN, '') = '' THEN '' ELSE '34' END,
    DrvMemberSSN           = CASE WHEN DrvRecType = 'EMP' THEN EepSSN WHEN DrvRecType = 'DEP' AND COALESCE(ConSSN,'') <> '' THEN ConSSN END,

    DrvLoop2100APER04      = CASE WHEN DrvRecType = 'EMP' THEN dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(EepEEID, 1) ELSE '' END,
    DrvLoop2100APER05      = CASE WHEN DrvRecType = 'EMP' THEN dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(EepEEID, 2) ELSE '' END,
    DrvLoop2100APER06      = CASE WHEN DrvRecType = 'EMP' THEN dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(EepEEID, 3) ELSE '' END,
    DrvLoop2100APER07      = CASE WHEN DrvRecType = 'EMP' THEN dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(EepEEID, 4) ELSE '' END,
    DrvLoop2100APER08      = CASE WHEN DrvRecType = 'EMP' AND ISNULL(eepAddressEmail,'') <> '' THEN 'EM' ELSE '' END , 
    DrvLoop2100APER09      =  CASE WHEN DrvRecType = 'EMP' THEN ISNULL(eepAddressEmail,'') ELSE '' END ,

    DrvAddressLine1        = EepAddressLine1,
    DrvAddressLine2        = EepAddressLine2,
    DrvAddressCity         = EepAddressCity,
    DrvAddressState        = EepAddressState,
    DrvAddressZipCode      = SUBSTRING(EepAddressZipCode,1,5),
    DrvLoop2100AN404       = '',
    DrvLoop2100AN406       = '',
    DrvLoop2100AN407       = '',

    DrvDateOfBirth         = CASE DrvRecType WHEN 'EMP' THEN EepDateOfBirth WHEN 'DEP' THEN ConDateOfBirth END,
    DrvGender              = CASE DrvRecType WHEN 'EMP' THEN EepGender ELSE ConGender END,
    DrvLoop2100ADMG04      = CASE 
                                WHEN DrvRecType = 'EMP' THEN CASE EepMaritalStatus WHEN 'M' THEN 'M' ELSE 'I' END 
                                WHEN DrvRecType = 'DEP' THEN 'I' 
                             END,
    DrvLoop2100ADMG05      = '',
    DrvLoop2100ADMG06      = '',

    DrvLoop2100AICM01      = '', 
    DrvLoop2100AICM02      = '', 
    DrvLoop2100AICM03      = '', 
    DrvLoop2100AICM04      = '',
    DrvLoop2100AICM05      = '',

    DrvLoop2100AAMT01      = '',
    DrvLoop2100AAMT02      = '',
    DrvLoop2100AAMT03      = '',
    DrvLoop2100AHLH01      = '',
    DrvLoop2100AHLH02      = '',
    DrvLoop2100AHLH03      = '',
    DrvLoop2100ALUI01      = '',
    DrvLoop2100ALUI02      = '',
    DrvLoop2100ALUI03      = '',
    DrvLoop2100ALUI04      = ''

    INTO dbo.U_dsi_@CustomFormatCode_2100ALoops
    FROM dbo.U_@CustomFormatCode_EEList 
    JOIN dbo.U_dsi_@CustomFormatCode_2300Loops WITH (NOLOCK) ON DrvEEID = xEEID 
    JOIN dbo.EmpPers WITH (NOLOCK) ON EepEEID = xEEID
    LEFT JOIN dbo.Contacts WITH (NOLOCK) ON ConEEID = DrvEEID AND ConSystemID = DrvDepRecID
    JOIN (SELECT bdmRunID,bdmEEID,bdmCoID FROM dbo.U_dsi_bdm_@CustomFormatCode) bdmEERun ON bdmEEID = xEEID AND bdmCoID = xCoID

    -----------
    -- Remove spaces and punctuation from names and addresses
    -----------
 
     UPDATE dbo.U_dsi_@CustomFormatCode_2100ALoops
       SET DrvNameLast       = dbo.dsi_fnlib_RemovePunctuation(DrvNameLast, '', ''),
           DrvNameFirst      = dbo.dsi_fnlib_RemovePunctuation(DrvNameFirst, '', ''),
           DrvNameMiddle     = dbo.dsi_fnlib_RemovePunctuation(DrvNameMiddle, '', ''),
           DrvNamePrefix     = dbo.dsi_fnlib_RemovePunctuation(DrvNamePrefix, '', ''),
           DrvNameSuffix     = dbo.dsi_fnlib_RemovePunctuation(DrvNameSuffix, '', ''),
           DrvAddressLine1   = dbo.dsi_fnlib_RemovePunctuation(DrvAddressLine1, '', ''),
           DrvAddressLine2   = dbo.dsi_fnlib_RemovePunctuation(DrvAddressLine2, '', ''),
           DrvAddressCity    = dbo.dsi_fnlib_RemovePunctuation(DrvAddressCity, '', ''),
           DrvAddressState   = dbo.dsi_fnlib_RemovePunctuation(DrvAddressState, '', ''),
           DrvAddressZipCode = dbo.dsi_fnlib_RemovePunctuation(DrvAddressZipCode, '', '')

     UPDATE dbo.U_dsi_@CustomFormatCode_2100ALoops
       SET DrvNameLast   = REPLACE(DrvNameLast,   ' ', ''),
           DrvNameFirst  = REPLACE(DrvNameFirst,  ' ', ''),
           DrvNameMiddle = REPLACE(DrvNameMiddle, ' ', ''),
           DrvNamePrefix = REPLACE(DrvNamePrefix, ' ', ''),
           DrvNameSuffix = REPLACE(DrvNameSuffix, ' ', '')

    -----------
    -- Get file number
    -----------
 
    SET @FileNum = dbo.dsi_fnVariable(@FormatCode, 'FileNumber');
 
    IF RTRIM(COALESCE(@FileNum, '')) = '' BEGIN
       SET @FileNum = '000000001'
    END ELSE BEGIN
       SET @FileNum = dbo.dsi_fnPadZero((CONVERT(INT, @FileNum) + 1), 9, 0)
    END
 
    EXEC dbo.dsi_sp_UpdateConfig @FormatCode, 'FileNumber', 'V', @FileNum


    -----------
    -- Build dbo.U_dsi_@CustomFormatCode_Headers
    -----------

    SELECT

    -- ISA

    DrvSegISA04               = '',
    DrvSegISA05Option         = 'ZZ',
    DrvSegISA06               = '@ISA06SenderID', -- Sender ID
    DrvSegISA07Option         = 'ZZ',
    DrvSegISA08               = '@ISA08ReceiverID', -- Receiver ID
    DrvRepetitionSeparator    = '{',
    DrvInterchangeControlNum  = '00501',
    DrvSegISA13               = @FileNum,
    DrvUsageIndicator         = 'T', --Change to P when PROD
    DrvCompElemSeparator      = ':',

    -- GS

    DrvSegIGS02               = '@GS02SenderID', -- Sender ID
    DrvSegIGS03               = '@GS03ReceiverID', -- Receiver ID
    DrvSegIGS06               = '1',
    DrvVersionCode            = '005010X220A1',

    -- ST

    DrvST02                   = '0001',
    DrvImplConventionRef      = '005010X220A1',

    -- BGN

    DrvSegBGN02               = '1',
    DrvActionCode             = '2',

    -- Ref 38

    DrvSegRef01               = '38',
    DrvSegRef02               = '@REF38',

    DrvSegDTP01               = '007', --WAS 303
    DrvSegDTP03               = GETDATE(),

    DrvSegQTY02ET             = '',
    DrvSegQTY02DT             = '',
    DrvSegQTY02TO             = '',

    DrvLoop1000ASegn102       = (SELECT CmmCompanyName FROM CompMast),
    DrvLoop1000ASegn103Option = 'FI',
    DrvLoop1000ASegn104       = '@Loop1000AN104SenderID', -- sender ID

    DrvLoop1000BSegn102       = 'HORIZON BCBSNJ',
    DrvLoop1000BSegn103Option = 'FI',
    DrvLoop1000BSegn104       = '@Loop1000BN104ReceiverID' -- receiver ID

    INTO dbo.U_dsi_@CustomFormatCode_Headers


    -----------
    -- Build dbo.U_dsi_@CustomFormatCode_Trailers
    -----------

    SELECT

    DrvSegSE02  = '0001',
    DrvSegGE02  = '1',
    DrvSegIEA02 = @FileNum

    INTO dbo.U_dsi_@CustomFormatCode_Trailers

    ----------
    -- Set filename
    -----------
    IF (dbo.dsi_fnVariable(@FormatCode, 'UseFileName') = 'N') BEGIN
       UPDATE dbo.U_dsi_Parameters
          SET ExportFile =  '@FileNamePrefix' + REPLACE(convert(varchar,getdate(),1),'/','') +'.txt'
        WHERE FormatCode = @FormatCode
    END

END
GO
CREATE View [dbo].[dsi_vw@CustomFormatCode_Export] AS
    SELECT TOP 2000000 Data FROM dbo.U_@CustomFormatCode_File WITH (NOLOCK)
    ORDER BY CASE LEFT(RecordSet,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END
        ,InitialSort
        ,SubSort
        ,RIGHT(RecordSet,2)
GO
CREATE FUNCTION [dbo].[dsi_fn_@CustomFormatCode_2100ALoop_Value] (
	@EEID            VARCHAR(12),
	@FieldNum        INT
)
RETURNS VARCHAR(128)
WITH EXECUTE AS CALLER
AS
/************************************************************

Client Name: @CustomerName

Created By: @DeveloperName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: Pulls phone numbers and email addresses for a SQL 834 2100A loop where the data must be "collapsed."

Description
-----------
834s require home number, work number and email address in the 2100A loop. Some vendors, however, require that
the populated fields shift to the left if the fields to the left are blank. For example, if the work number is populated
but the home number isn't, the work number needs to shift into the home number's position and so on.

Revision History
----------------
Update By            Date            Request Num                Desc        
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

Commands 
--------
SELECT EepEEID, EepPhoneHomeNumber, EecPhoneBusinessNumber, EepAddressEmail,

dbo.dsi_fnlib_Get834_2100Loop_Value(EepEEID, 1),
dbo.dsi_fnlib_Get834_2100Loop_Value(EepEEID, 2),
dbo.dsi_fnlib_Get834_2100Loop_Value(EepEEID, 3),
dbo.dsi_fnlib_Get834_2100Loop_Value(EepEEID, 4),
dbo.dsi_fnlib_Get834_2100Loop_Value(EepEEID, 5),
dbo.dsi_fnlib_Get834_2100Loop_Value(EepEEID, 6)

FROM dbo.EmpPers 
JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = EepEEID AND EecCOID = dbo.dsi_fn_GetCurrentCOID(EepEEID) 

************************************************************/
BEGIN

	DECLARE @PhoneHomeNumber     VARCHAR(50);
	DECLARE @PhoneBusinessNumber VARCHAR(50);
	DECLARE @AddressEmail        VARCHAR(50);

	-----------
	-- Build table variable
	-----------

	DECLARE @tvValues TABLE (
	tvRowNum      INT IDENTITY(1, 1),
	tvValue       VARCHAR(128)
	);

	-----------
	-- Get data
	-----------

	SELECT 

	@PhoneHomeNumber     = LTRIM(RTRIM(COALESCE(EepPhoneHomeNumber, ''))),
	@PhoneBusinessNumber = LTRIM(RTRIM(COALESCE(EecPhoneBusinessNumber, ''))),
	@AddressEmail        = '' -- vendor doesn't want e-mails

	FROM dbo.EmpPers
	JOIN dbo.EmpComp WITH (NOLOCK) ON EecEEID = EepEEID AND EecCOID = dbo.dsi_fn_GetCurrentCOID(EepEEID) 
	WHERE EepEEID = @EEID;


	-----------
	-- Insert values
	-----------

	IF @PhoneHomeNumber <> '' BEGIN

	   INSERT INTO @tvValues VALUES('HP');
	   INSERT INTO @tvValues VALUES(@PhoneHomeNumber);

	END

	IF @PhoneBusinessNumber <> '' BEGIN

	   INSERT INTO @tvValues VALUES('WP');
	   INSERT INTO @tvValues VALUES(@PhoneBusinessNumber);

	END

	IF @AddressEmail <> '' BEGIN

	   INSERT INTO @tvValues VALUES('EM');
	   INSERT INTO @tvValues VALUES(@AddressEmail);

	END

	-----------
	-- Return value
	-----------

	RETURN (SELECT COALESCE(tvValue, '') FROM @tvValues WHERE tvRowNum = @FieldNum);

END
GO
CREATE FUNCTION [dbo].[dsi_fn_@CustomFormatCode_GetRef1L] (
	@DedCode  VARCHAR(6),
	@DedGroupCode VARCHAR(32),
	@DedType  VARCHAR(32)
)
RETURNS CHAR(9)
WITH EXECUTE AS CALLER
AS
/************************************************************

Client Name: @CustomerName

Created By: @DeveloperName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: Gets the Ref-1L for a BCBS-NJ export

Revision History
----------------
Update By            Date            Request Num                Desc        
XXXX                 XX/XX/XX        SR-20XX-000XXXXX           Added 1234

************************************************************/
BEGIN

	DECLARE @Ref1L CHAR(9);

	SET @DedCode  = LTRIM(RTRIM(COALESCE(@DedCode, '')));
	SET @DedGroupCode = LTRIM(RTRIM(COALESCE(@DedGroupCode, '')));
	SET @DedType  = LTRIM(RTRIM(COALESCE(@DedType, '')));

	SET @Ref1L =

	CASE WHEN @DedType IN ('MED')   THEN CASE WHEN @DedCode IN ('@DedCodeListMED') AND @DedGroupCode IN ('ADMFT','ADMPT','ADMF2') THEN '000000000'  
											WHEN @DedCode IN ('@DedCodeListMED') AND @DedGroupCode IN ('FACFT','FACPT','FACF2') THEN '000000001'  
											WHEN @DedCode IN ('@DedCodeListMED') AND @DedGroupCode IN ('OPEIU','POL','SUPOL','OPEI2','POL2','SUPO2') THEN '000000002'  
										END
		 WHEN @DedType IN ('PDG')  THEN CASE WHEN @DedCode IN ('@DedCodeListPDG')  AND @DedGroupCode IN ('ADMFT','ADMPT','ADMF2') THEN '000000000'  
											WHEN @DedCode IN ('@DedCodeListPDG') AND @DedGroupCode IN ('FACFT','FACPT','FACF2') THEN '000000001'  
											WHEN @DedCode IN ('@DedCodeListPDG') AND @DedGroupCode IN ('OPEIU','POL','SUPOL','OPEI2','POL2','SUPO2') THEN '000000002'  
										END

		WHEN @DedType IN ('VIS')  THEN CASE WHEN @DedCode IN ('@DedCodeListVIS') AND @DedGroupCode IN ('ADMFT','ADMPT','ADMF2') THEN '000000010'  
											 WHEN @DedCode IN ('@DedCodeListVIS') AND @DedGroupCode IN ('FACFT','FACPT','FACF2') THEN '000000011'  
											 WHEN @DedCode IN ('@DedCodeListVIS') AND @DedGroupCode IN ('OPEIU','POL','SUPOL','OPEI2','POL2','SUPO2') THEN '000000012'  
										END

	  END;

	RETURN @Ref1L;

END
GO