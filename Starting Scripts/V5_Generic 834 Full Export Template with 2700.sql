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
@CustomFormatCode - Replace with Format Code (i.e., ESUNLIF834)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., Sunlife 834 Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Imports\Accrual\Reports\)

-- Data parameters
@CompanyCode - Replace with Company Code for Customer
@DedCodeList - Replace with Deduction Code List in CSV format (i.e., DED1,DED2,DED3)

NOTE: SEARCH FOR THE BELOW PARAMETERS TO SKIP TO THE RECORD IN THE TABLE INSTEAD OF FIND/REPLACE, TO ENSURE ',' FORMAT IS CORRECT
@SpousesCSV - Replace with SPS relationship codes in CSV format (i.e., SPS)
@ChildrenCSV - Replace with CHL relationship codes in CSV format (i.e., CHL,STC)
@DomPartnerCSV - Replace with DP relationship codes in CSV format (i.e., DP)
@EEBenOpts - Replace with EE only benefit options for drvCoverageLevel (i.e., EE)
@ECHBenOpts - Replace with EE+CHILDREN benefit options for drvCoverageLevel (i.e., EES)
@ESPBenOpts - Replace with EE+SPOUSE benefit options for drvCoverageLevel (i.e., EEC)
@EDPBenOpts - Replace with EE+DOMESTICPARTNER benefit options for drvCoverageLevel (i.e., EEDP)
@EEFAMBenOpts - Replace with EE+FAMILY benefit options for drvCoverageLevel (i.e., FAM)
@CollapsePerSegmentAll - Replace with Y/N to collapse the values in 2100A loop for emp records only 
							When CollapsePerSegmentValues is Y populated fields shift to the left if the fields to the left are blank
@CollapsePerSegmentEmp - Replace with Y/N to collapse the values in 2100A loop for emp records only 

*/
IF OBJECT_ID('dsi_fn_@CustomFormatCode_2100ALoop_Value') IS NOT NULL DROP FUNCTION [dbo].[dsi_fn_@CustomFormatCode_2100ALoop_Value];
GO
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_TrlTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_HdrTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl_2300];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl_2700') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl_2700];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl];
GO
IF OBJECT_ID('U_@CustomFormatCode_DedList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = '@CustomFormatCode');
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50), @SchedExportCode VARCHAR(10);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);
SET @SchedExportCode = CONCAT('SCH_',LEFT('@CustomFormatCode',6));

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','@CustomFormatCode',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL,'"ISA"','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'10','H','01','3',NULL,'Authorization Info',NULL,NULL,'""','(''SS''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'10','H','01','5',NULL,'Security Info',NULL,NULL,'""','(''SS''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL,'"drvISA05_SenderIDQual"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'15','H','01','7',NULL,'Sender ID',NULL,NULL,'"drvISA06_SenderID"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL,'"drvISA07_ReceiverIDQual"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'15','H','01','9',NULL,'Receiver ID',NULL,NULL,'"drvISA08_ReceiverID"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'6','H','01','10',NULL,'Interchange Date',NULL,NULL,'"drvISA09_InterchangeDate"','(''UD12''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'4','H','01','11',NULL,'Interchange Time',NULL,NULL,'"drvISA10_InterchangeTime"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'1','H','01','12',NULL,'Repetition Separator',NULL,NULL,'"^"','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL,'"00501"','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'9','H','01','14',NULL,'Interchange Control #',NULL,NULL,'"drvSegISA13"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '15',@AdhSystemID,'1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL,'"1"','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '16',@AdhSystemID,'1','H','01','16',NULL,'Usage Indicator',NULL,NULL,'"drvISA15_UsageIndicator"','(''UA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '17',@AdhSystemID,'1','H','01','17',NULL,'Component Element Separator',NULL,NULL,'">"','(''DA''=''F*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL,'"GS"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','02','2',NULL,'Functional ID Code',NULL,NULL,'"BE"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','02','3',NULL,'Sender ID',NULL,NULL,'"drvGS02_SenderID"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'15','H','02','4',NULL,'Receiver ID',NULL,NULL,'"drvGS03_ReceiverID"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'8','H','02','5',NULL,'Date',NULL,NULL,'"drvGS04_Date"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'8','H','02','6',NULL,'Time',NULL,NULL,'"drvGS05_Time"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'9','H','02','7',NULL,'Group Control Number',NULL,NULL,'"0001"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL,'"X"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'12','H','02','9',NULL,'Version/Release  Code',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL,'"ST"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','03','2',NULL,'Transaction ID Code',NULL,NULL,'"834"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL,'"0001"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL,'"BGN"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL,'"00"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','04','3',NULL,'Reference Number',NULL,NULL,'"0001"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','H','04','4',NULL,'Date',NULL,NULL,'"drvBGN03_Date"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'8','H','04','5',NULL,'Time',NULL,NULL,'"drvBGN04_Time"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'2','H','04','6',NULL,'Time Code',NULL,NULL,'"drvBGN05_TimeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'50','H','04','7',NULL,'Reference Identification',NULL,NULL,'"drvBGN06_RefID"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','H','04','8',NULL,'Transaction Type Code',NULL,NULL,'"drvBGN07_TransTypeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','H','04','9',NULL,'Action Code',NULL,NULL,'"drvBGN08_ActionCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF02_RefNumberQual"','(''UA''=''T*'')';

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','06','1',NULL,'DTP Segment ID (Header)',NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','06','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','H','06','3',NULL,'Date/Time Format',NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','H','06','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod1"','(''UD112''=''T*'')';

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','07','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','07','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','07','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','08','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','08','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','H','08','3',NULL,'Name',NULL,NULL,'"drvN102_Name1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','08','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'80','H','08','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','09','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','09','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','H','09','3',NULL,'Name',NULL,NULL,'"drvN102_Name2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','09','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'80','H','09','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode2"','(''UA''=''T*'')';

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','10','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL,'"INS"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'1','D','10','2',NULL,'Yes/No Condition',NULL,NULL,'"drvINS01_YesNoCond"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','10','3',NULL,'Individual Relationship Code',NULL,NULL,'"drvINS02_RelationshipCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','10','4',NULL,'Maintenance Type Code',NULL,NULL,'"drvINS03_MaintTypeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'3','D','10','5',NULL,'Maintenance Reason Code',NULL,NULL,'"drvINS04_MaintReasonCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'1','D','10','6',NULL,'Benefit Status Code',NULL,NULL,'"drvINS05_BenefitStatusCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'1','D','10','7',NULL,'MEDICARE PLAN CODE',NULL,NULL,'"drvINS0601_MEDICAREPLANCODE"','(''UA''=''T'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'1','D','10','8',NULL,'Eligibility Reason Code',NULL,NULL,'"drvINS0602_EligibilityRsnCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','10','9',NULL,'COBRA Qualifying Event Code',NULL,NULL,'"drvINS07_COBRAQualEventCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'2','D','10','10',NULL,'Employment Status Code',NULL,NULL,'"drvINS08_EmploymentStatusCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'1','D','10','11',NULL,'Student Status Code',NULL,NULL,'"drvINS09_StudentStatusCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'1','D','10','12',NULL,'Response Code',NULL,NULL,'"drvINS10_ResponseCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'3','D','10','13',NULL,'Date Time Period Format Qualif',NULL,NULL,'"drvINS11_DateTimeFormatQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'35','D','10','14',NULL,'Date Time Period',NULL,NULL,'"drvINS12_DateTimePeriod"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','12','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','12','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','12','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual"','(''UA''=''T*'')';

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','15','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"DTP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','15','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','15','3',NULL,'Date/Time Format',NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','15','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod"','(''UD112''=''T*'')';

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','18','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL,'"NM1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','18','2',NULL,'Entity Identifier Code',NULL,NULL,'"IL"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','18','3',NULL,'Entity Type Qualifier',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'60','D','18','4',NULL,'Name Last',NULL,NULL,'"drvNM103_NameLast1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'35','D','18','5',NULL,'Name First',NULL,NULL,'"drvNM104_NameFirst1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'25','D','18','6',NULL,'Name Middle Initial',NULL,NULL,'"drvNM105_NameMiddleInitial1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'10','D','18','7',NULL,'Name Prefix',NULL,NULL,'"drvNM106_NamePrefix1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'10','D','18','8',NULL,'Name Suffix',NULL,NULL,'"drvNM107_NameSuffix1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','18','9',NULL,'Identification Code Qualifier',NULL,NULL,'"drvNM108_IDCodeQualifier1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'80','D','18','10',NULL,'Identification Code',NULL,NULL,'"drvNM109_IDCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','20','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL,'"PER"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','D','20','2',NULL,'Contact Function Code',NULL,NULL,'"IP"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','D','20','3',NULL,'Name',NULL,NULL,'"drvPER02_Name"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','20','4',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER03_CommNumberQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'256','D','20','5',NULL,'Communication Number',NULL,NULL,'"drvPER04_CommunicationNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'3','D','20','6',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER05_CommNumberQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'256','D','20','7',NULL,'Communication Number',NULL,NULL,'"drvPER06_CommunicationNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'3','D','20','8',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER07_CommNumberQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'256','D','20','9',NULL,'Communication Number',NULL,NULL,'"drvPER08_CommunicationNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','23','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL,'"N3"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'55','D','23','2',NULL,'Address Line 1',NULL,NULL,'"drvN301_AddressLine1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'55','D','23','3',NULL,'Address Line 2',NULL,NULL,'"drvN302_AddressLine2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','30','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL,'"N4"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'30','D','30','2',NULL,'City',NULL,NULL,'"drvN401_City"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','30','3',NULL,'State',NULL,NULL,'"drvN402_State"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'15','D','30','4',NULL,'Zip',NULL,NULL,'"drvN403_Zip"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'3','D','30','5',NULL,'Country Code',NULL,NULL,'"drvN404_CountryCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','33','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL,'"DMG"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','33','2',NULL,'Date/Time Format Qualifier',NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'35','D','33','3',NULL,'Date/Time Period',NULL,NULL,'"drvDMG02_DateTimePeriod1"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'1','D','33','4',NULL,'Gender Code',NULL,NULL,'"drvDMG03_GenderCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'1','D','33','5',NULL,'Marital Status Code',NULL,NULL,'"drvDMG04_MaritalStatusCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','37','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL,'"ICM"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'1','D','37','2',NULL,'Frequency Code',NULL,NULL,'"drvICM01_FrequencyCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'18','D','37','3',NULL,'Monetary Amount',NULL,NULL,'"drvICM02_MonetaryAmount"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'15','D','37','4',NULL,'Quantity',NULL,NULL,'"drvICM03_Quantity"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'30','D','37','5',NULL,'Location Identifier Description',NULL,NULL,'"drvICM04_LocationID"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','40','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'18','D','40','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','40','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','44','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'18','D','44','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','44','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'10','D','47','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL,'"drvHLH00_SegmentID"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'8','D','47','2',NULL,'Health-Related Code',NULL,NULL,'"drvHLH01_HealthRelatedCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'10','D','47','3',NULL,'Height',NULL,NULL,'"drvHLH02_Height"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'10','D','47','4',NULL,'Weight',NULL,NULL,'"drvHLH03_Weight1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'10','D','47','5',NULL,'Weight',NULL,NULL,'"drvHLH04_Weight2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'10','D','47','6',NULL,'Description',NULL,NULL,'"drvHLH05_Description1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'10','D','47','7',NULL,'Current Health Condition Code',NULL,NULL,'"drvHLH06_CurrentHealthConditionCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'10','D','47','8',NULL,'Description',NULL,NULL,'"drvHLH07_Description2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','50','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvHD00_HealthCoverage"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','50','2',NULL,'Maintenance Type Code',NULL,NULL,'"drvHD01_MaintTypeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','50','3',NULL,'Maintenance Reason Code',NULL,NULL,'"drvHD02_MaintReasonCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','50','4',NULL,'Insurance Line Code',NULL,NULL,'"drvHD03_InsuranceLineCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'50','D','50','5',NULL,'Plan Coverage Description',NULL,NULL,'"drvHD04_PlanCoverageDesc"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'3','D','50','6',NULL,'Coverage Level Code',NULL,NULL,'"drvHD05_CoverageLevelCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','54','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','54','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','54','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','54','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','58','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL,'"drvREF00_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','58','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','58','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','60','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','60','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'18','D','60','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','62','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','62','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'18','D','62','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','65','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL,'"LS"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','D','65','2',NULL,'Loop ID Code',NULL,NULL,'"drvLS01_LoopIDCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','71','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL,'"LX"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','D','71','2',NULL,'Assigned Number',NULL,NULL,'"drvLX01_AssignedNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','75','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','75','2',NULL,'Entity Identifier Code',NULL,NULL,'"drvN101_EntityIDCodeSponsor"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','D','75','3',NULL,'Name',NULL,NULL,'"drvN102_Name"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','78','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','78','2',NULL,'Reference Identification Quali',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','78','3',NULL,'Reference Identification Descr',NULL,NULL,'"drvREF02_RefNumberDesc"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','82','1',NULL,'DTP Segment ID (Loop 2750) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_007"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','82','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_007"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','82','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_007"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','82','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_007"','(''UD112''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','88','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL,'"LE"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','D','88','2',NULL,'Loop ID Code',NULL,NULL,'"drvLE01_LoopIDCode"','(''UA''=''T*'')';

INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL,'"SE"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'10','T','90','2',NULL,'Number of Included Segments',NULL,NULL,'"drvSE01_SegmentCount"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL,'"drvSegSE02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','T','93','1',NULL,'GE Segment ID (Trailer)',NULL,NULL,'"GE"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','T','93','2',NULL,'Number of Transaction Sets Inc',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','93','3',NULL,'Group Control Number',NULL,NULL,'"drvSegGE02"','(''UA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','T','97','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL,'"IEA"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'5','T','97','2',NULL,'Number of Functional Groups In',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[AscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','97','3',NULL,'Interchange Control Number',NULL,NULL,'"drvSegIEA02"','(''UA''=''T*'')';

INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Testing Purposes Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST_XOE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName2,CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ONDEM_XOE',NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT',@SchedExportCode,NULL,'@CustomFormatCode',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9',NULL,'Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;

INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','FileNumber','V','000000000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TEMPLATE','V','Generic 834 Full Export - v1.04');

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','U_@CustomFormatCode_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H02','U_@CustomFormatCode_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H03','U_@CustomFormatCode_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H04','U_@CustomFormatCode_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H05','U_@CustomFormatCode_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H06','U_@CustomFormatCode_HdrTbl','ISNULL(drvDTP03_DateTimePeriod1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H07','U_@CustomFormatCode_HdrQTYLoopTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H08','U_@CustomFormatCode_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H09','U_@CustomFormatCode_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D10','U_@CustomFormatCode_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D12','U_@CustomFormatCode_DrvREFTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D15','U_@CustomFormatCode_DrvDTPTbl','ISNULL(drvDTP03_DateTimePeriod,'''') <> ''''');

INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D18','U_@CustomFormatCode_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','U_@CustomFormatCode_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D23','U_@CustomFormatCode_DrvTbl','ISNULL(drvN301_AddressLine1,'''') <> '''' OR ISNULL(drvN302_AddressLine2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D30','U_@CustomFormatCode_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D33','U_@CustomFormatCode_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D37','U_@CustomFormatCode_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D40','U_@CustomFormatCode_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D44','U_@CustomFormatCode_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D47','U_@CustomFormatCode_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','U_@CustomFormatCode_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D54','U_@CustomFormatCode_DrvDTPTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D58','U_@CustomFormatCode_DrvREFTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D60','U_@CustomFormatCode_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D62','U_@CustomFormatCode_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D65','U_@CustomFormatCode_DrvTbl_2700','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D71','U_@CustomFormatCode_DrvTbl_2700','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D75','U_@CustomFormatCode_DrvTbl_2700','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D78','U_@CustomFormatCode_DrvTbl_2700','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D82','U_@CustomFormatCode_DrvTbl_2700','ISNULL(drvLS01_LoopIDCode,'''') <> '''' AND ISNULL(drvDTP00_DateTime_007,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D88','U_@CustomFormatCode_DrvTbl_2700','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T90','U_@CustomFormatCode_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T93','U_@CustomFormatCode_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','T97','U_@CustomFormatCode_TrlTbl',NULL); 

GO
IF ('@IsWebFlag' = 'Y')
BEGIN
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = '@CustomFormatCode' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */

/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = '@CustomFormatCode.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
UPDATE dbo.AscExp SET expAscFileName = @FILEPATH + @FILENAME WHERE expFormatCode = '@CustomFormatCode';

/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'ExportPath' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
/*03*/ DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode' AND CfgName = 'TestPath'; /* Remove Test Path for Web Exports */

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
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_@CustomFormatCode]
AS
SET NOCOUNT ON;
/************************************************************
Client: @CustomerName

Created By: @DeveloperName
Create Date: @CreateDate
ChangePoint Request Number: @SRNumber

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
    WHILE (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_@CustomFormatCode_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_@CustomFormatCode_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_@CustomFormatCode_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_@CustomFormatCode_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_@CustomFormatCode_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_@CustomFormatCode_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: @CustomerName

Created By: @DeveloperName
Business Analyst: @IntegrationAnalystName
Create Date: @CreateDate
Service Request Number: @SRNumber

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = '@CustomFormatCode';
SELECT * FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'SCH_ESUN83;--First 6 Characters of @CustomFormatCode

EXEC dbo.dsi_BDM_sp_ErrorCheck '@CustomFormatCode';

EXEC dbo._dsi_usp_ExportRipOut_v7_4 @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = '@IsWebFlag'
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
			,@FileNum         VARCHAR(32)
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
    WHERE FormatCode = '@CustomFormatCode';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = '@DedCodeList';

    IF OBJECT_ID('U_@CustomFormatCode_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_@CustomFormatCode_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    -- now set values for benefit module
    DELETE FROM dbo.U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

    -- Required parms
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'TermSelectionOption', 'AuditDate');

    -- Non-required parms
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'IncludeOEDrops','N');
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'OERemoveTermEmps','N');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'GetChangeReason','Y');
	INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStartDateDays','30');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'FutureDatedStopDateDays','30');  
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','@SpousesCSV');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','@ChildrenCSV');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','@DomPartnerCSV');

    --Set if OE
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
         INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'ACTIVE');
    END;

    EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable_v2 @FormatCode;
	
	EXEC dbo.dsi_bdm_sp_BuildConsolidatedTable @FormatCode, 'Standard'
    --=========================================
    -- Update BdmChangeReason For Dependents
    --=========================================
    UPDATE D
        SET D.BdmChangeReason = E.BdmChangeReason
    FROM dbo.U_dsi_bdm_@CustomFormatCode D
    JOIN dbo.U_dsi_bdm_@CustomFormatCode E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

		
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
    IF OBJECT_ID('U_@CustomFormatCode_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = ''
        ,drvISA06_SenderID = ''
        ,drvISA07_ReceiverIDQual = ''
        ,drvISA08_ReceiverID = ''
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
		,drvSegISA13              = @FileNum
        ,drvISA15_UsageIndicator = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' OR @ExportCode LIKE '%TEST%' THEN 'T' ELSE 'P' END
        ,drvGS02_SenderID = ''
        ,drvGS03_ReceiverID = ''
        ,drvGS04_Date = @RunDate
        ,drvGS05_Time = @RunTime
        ,drvBGN03_Date = @RunDate
        ,drvBGN04_Time = @RunTime
        ,drvBGN05_TimeCode = ''
        ,drvBGN06_RefID = ''
        ,drvBGN07_TransTypeCode = ''
        ,drvBGN08_ActionCode = '4'
        ,drvREF01_RefNumberQual = ''
        ,drvREF02_RefNumberQual = ''
		,drvDTP01_DateTimeQualifier1 = ''
        ,drvDTP03_DateTimePeriod1 = ''
        ,drvQTY01_QuantityQual_1 = ''
        ,drvQTY02_Quantity_1 = ''
        ,drvQTY01_QuantityQual_2 = ''
        ,drvQTY02_Quantity_2 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = ''
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = ''
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = ''
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = ''
    INTO dbo.U_@CustomFormatCode_HdrTbl
    FROM dbo.U_@CustomFormatCode_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID;
		
	-- This section consolidates QTY segments. Manual change not needed.	
    IF OBJECT_ID('U_@CustomFormatCode_HdrQTYLoopTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_HdrQTYLoopTbl;
	
	SELECT drvQTY01_QuantityQual_1 as drvQTY01_QuantityQual1, drvQTY02_Quantity_1 drvQTY02_Quantity1, '1' drvsubsort2
	INTO dbo.U_@CustomFormatCode_HdrQTYLoopTbl
	FROM dbo.U_@CustomFormatCode_HdrTbl 
	UNION ALL 
	SELECT drvQTY01_QuantityQual_2, drvQTY02_Quantity_2, '2' drvsubsort2 
	FROM dbo.U_@CustomFormatCode_HdrTbl ; 
		

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2000 RECORDS - INS, REF, DTP Segments
            -- LOOP 2100A RECORDS - NM1, PER, N3, N4, DMG, ICM Segments
            -- LOOP 2100B RECORDS - NM1, DMG Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_@CustomFormatCode_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvTbl;
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
												CASE WHEN ConRelationship IN ('@SpousesCSV') THEN '01'
                                                     WHEN ConRelationship IN ('@DomPartnerCSV') THEN '53'
                                                     WHEN ConRelationship IN ('@ChildrenCSV') THEN '19'
                                                     ELSE '99'
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
                                                     WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                     WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
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
        -- If drvREF01_RefNumberQual_1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual_1 = '0F'
        ,drvREF02_RefNumberQual_1 = EepSSN
        -- If drvREF01_RefNumberQual_2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual_2 = ''
        ,drvREF02_RefNumberQual_2 = ''
		-- If drvREF01_RefNumberQual_3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual_3 = ''
        ,drvREF02_RefNumberQual_3 = ''
		-- If drvREF01_RefNumberQual_4 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual_4 = ''
        ,drvREF02_RefNumberQual_4 = ''
		-- If drvREF01_RefNumberQual_5 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual_5 = ''
        ,drvREF02_RefNumberQual_5 = ''
	    -- If drvDTP03_DateTimePeriod1 is Populated, then send DTP Segment
        ,drvDTP01_DateTimeQualifier_1 = ''
        ,drvDTP03_DateTimePeriod_1 = ''
        -- If drvDTP03_DateTimePeriod2 is Populated, then send DTP Segment
        ,drvDTP01_DateTimeQualifier_2 = ''
        ,drvDTP03_DateTimePeriod_2 = ''
		-- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP01_DateTimeQualifier_3 = ''
        ,drvDTP03_DateTimePeriod_3 = ''
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
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' THEN NULLIF(EepNameSuffix, 'Z')
                                     WHEN BdmRecType = 'DEP' THEN NULLIF(ConNameSuffix, 'Z')
                                END
        ,drvNM108_IDCodeQualifier1 = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnlib_FilterSSN(EepSSN, '34', '')
                                          WHEN BdmRecType = 'DEP' THEN dbo.dsi_fnlib_FilterSSN(ConSSN, '34', '')
                                     END
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' THEN dbo.dsi_fnlib_FilterSSN(EepSSN, EepSSN, '')
                                 WHEN BdmRecType = 'DEP' THEN dbo.dsi_fnlib_FilterSSN(ConSSN, ConSSN, '')
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
        ,drvICM03_Quantity = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecScheduledAnnualHrs/52) END
        ,drvICM04_LocationID = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),dbo.dsi_fnlib_GetAnnSalary_EffDate(EecEEID, EecCOID, EecDateOfLastHire) ,112)
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
		,drvsubsort2 = ''
    INTO dbo.U_@CustomFormatCode_DrvTbl
    FROM dbo.U_@CustomFormatCode_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    LEFT JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;
		
	-- This section consolidates REF segments. Manual change not needed.	
    IF OBJECT_ID('U_@CustomFormatCode_DrvREFTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvREFTbl;
	
	SELECT drvREF01_RefNumberQual_1 as drvREF01_RefNumberQual, drvREF02_RefNumberQual_1 drvREF02_RefNumberQual, drvInitialSort, drvSubSort, '1' drvsubsort2
	INTO dbo.U_@CustomFormatCode_DrvREFTbl
	FROM dbo.U_@CustomFormatCode_DrvTbl 
	UNION ALL 
	SELECT drvREF01_RefNumberQual_2 as drvREF01_RefNumberQual, drvREF02_RefNumberQual_2 drvREF02_RefNumberQual, drvInitialSort, drvSubSort,  '2' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl  
	UNION ALL 
	SELECT drvREF01_RefNumberQual_3 as drvREF01_RefNumberQual, drvREF02_RefNumberQual_3 drvREF02_RefNumberQual, drvInitialSort, drvSubSort,  '3' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl  
	UNION ALL 
	SELECT drvREF01_RefNumberQual_4 as drvREF01_RefNumberQual, drvREF02_RefNumberQual_4 drvREF02_RefNumberQual, drvInitialSort, drvSubSort,  '4' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl
	UNION ALL 
	SELECT drvREF01_RefNumberQual_5 as drvREF01_RefNumberQual, drvREF02_RefNumberQual_5 drvREF02_RefNumberQual, drvInitialSort, drvSubSort,  '5' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl ;
	
	-- This section consolidates DTP segments. Manual change not needed.
    IF OBJECT_ID('U_@CustomFormatCode_DrvDTPTbl','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvDTPTbl;
	
	SELECT drvDTP01_DateTimeQualifier_1 as drvDTP01_DateTimeQualifier, drvDTP03_DateTimePeriod_1 drvDTP03_DateTimePeriod, drvInitialSort, drvSubSort,  '1' drvsubsort2
	INTO dbo.U_@CustomFormatCode_DrvDTPTbl
	FROM dbo.U_@CustomFormatCode_DrvTbl 
	UNION ALL 
	SELECT drvDTP01_DateTimeQualifier_2 as drvDTP01_DateTimeQualifier, drvDTP03_DateTimePeriod_2 drvDTP03_DateTimePeriod, drvInitialSort, drvSubSort,  '2' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl  
	UNION ALL 
	SELECT drvDTP01_DateTimeQualifier_3 as drvDTP01_DateTimeQualifier, drvDTP03_DateTimePeriod_3 drvDTP03_DateTimePeriod, drvInitialSort, drvSubSort,  '3' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl;	
		
	/**************************************************************************************************************
	834s require home number, work number and email address in the 2100A loop. 
	Some vendors, however, require that the populated fields shift to the left if the fields to the left are blank. 
	For example, if the work number is populated but the home number isn't, the work number needs to shift into the home number's position and so on.
	***************************************************************************************************************/	
	IF (ISNULL('@CollapsePerSegmentAll','Y') <> 'N')
			UPDATE dbo.U_@CustomFormatCode_DrvTbl
			SET 
				 drvPER03_CommNumberQualifier = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(1,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
				,drvPER04_CommunicationNumber = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(2,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
				,drvPER05_CommNumberQualifier = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(3,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
				,drvPER06_CommunicationNumber = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(4,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
				,drvPER07_CommNumberQualifier = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(5,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
				,drvPER08_CommunicationNumber = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(6,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
			; 
	ELSE 
		BEGIN 
			IF (ISNULL('@CollapsePerSegmentEmp','Y') <> 'N') 
				UPDATE dbo.U_@CustomFormatCode_DrvTbl
				SET 
					 drvPER03_CommNumberQualifier = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(1,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
					,drvPER04_CommunicationNumber = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(2,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
					,drvPER05_CommNumberQualifier = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(3,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
					,drvPER06_CommunicationNumber = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(4,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
					,drvPER07_CommNumberQualifier = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(5,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
					,drvPER08_CommunicationNumber = dbo.dsi_fn_@CustomFormatCode_2100ALoop_Value(6,
					drvPER03_CommNumberQualifier ,drvPER04_CommunicationNumber ,
					drvPER05_CommNumberQualifier ,drvPER06_CommunicationNumber ,
					drvPER07_CommNumberQualifier ,drvPER08_CommunicationNumber
				 )
				WHERE 
					drvINS01_YesNoCond = 'Y' 
				; 		
		END ; 

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2300 RECORDS - HD, DTP, AMT Segments
            -- Loop 2700 RECORDS - LX Segments
            -- Loop 2750 RECORDS - N1, REF Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_@CustomFormatCode_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvTbl_2300;
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
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                     END
        ,drvHD04_PlanCoverageDesc = CASE WHEN BdmDedType IN ('MED') THEN ''
                                           WHEN BdmDedType IN ('DEN') THEN ''
                                           WHEN BdmDedType IN ('VIS') THEN ''
                                     END
        ,drvHD05_CoverageLevelCode = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN
                                                CASE WHEN BdmBenOption IN ('@EEBenOpts') THEN 'EMP'
                                                     WHEN BdmBenOption IN ('@ESPBenOpts') THEN 'ESP'
                                                     WHEN BdmBenOption IN ('@ECHBenOpts') THEN 'ECH'
                                                     WHEN BdmBenOption IN ('@EEFAMBenOpts') THEN 'FAM'
                                                END
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
        -- If drvREF00_RefNumberQual_1 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual_1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual_1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual_1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvREF01_RefNumberQual_2 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual_2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual_2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual_2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
		-- If drvREF01_RefNumberQual_3 is Populated, then send REF Segment
        ,drvREF00_RefNumberQual_3 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF01_RefNumberQual_3 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvREF02_RefNumberQual_3 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode1 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount1 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        -- If drvAMT00_AmountQualifierCode2 is Populated, then Send AMT Segment
        ,drvAMT00_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT01_AmountQualifierCode2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
        ,drvAMT02_MonetaryAmount2 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '' END
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
		,drvsubsort2 = ''
    INTO dbo.U_@CustomFormatCode_DrvTbl_2300
    FROM dbo.U_@CustomFormatCode_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;

	-- This section consolidates REF segments. Manual change not needed.
	
    IF OBJECT_ID('U_@CustomFormatCode_DrvREFTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvREFTbl_2300;
	
	SELECT drvREF00_RefNumberQual_1 as drvREF00_RefNumberQual, drvREF01_RefNumberQual_1 drvREF01_RefNumberQual, drvREF02_RefNumberQual_1 drvREF02_RefNumberQual, drvHD00_HealthCoverage, drvInitialSort, drvSubSort,  '1' drvsubsort2
	INTO dbo.U_@CustomFormatCode_DrvREFTbl_2300
	FROM dbo.U_@CustomFormatCode_DrvTbl_2300
	UNION ALL 
	SELECT drvREF00_RefNumberQual_2 as drvREF00_RefNumberQual, drvREF01_RefNumberQual_2 drvREF01_RefNumberQual, drvREF02_RefNumberQual_2 drvREF02_RefNumberQual, drvHD00_HealthCoverage, drvInitialSort, drvSubSort,  '2' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl_2300
	UNION ALL 
	SELECT drvREF00_RefNumberQual_3 as drvREF00_RefNumberQual, drvREF01_RefNumberQual_3 drvREF01_RefNumberQual, drvREF02_RefNumberQual_3 drvREF02_RefNumberQual, drvHD00_HealthCoverage, drvInitialSort, drvSubSort,  '3' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl_2300
	; 

	-- This section consolidates DTP segments. Manual change not needed.
    IF OBJECT_ID('U_@CustomFormatCode_DrvDTPTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvDTPTbl_2300;
	
	SELECT drvDTP00_DateTime_348 as drvDTP00_DateTime, drvDTP01_DateTimeQualifier_348 drvDTP01_DateTimeQualifier, drvDTP02_DateTimeFormatQual_348 drvDTP02_DateTimeFormatQual, drvDTP03_DateTimePeriod_348 drvDTP03_DateTimePeriod, drvHD00_HealthCoverage, drvInitialSort, drvSubSort,  '1' drvsubsort2
	INTO dbo.U_@CustomFormatCode_DrvDTPTbl_2300
	FROM dbo.U_@CustomFormatCode_DrvTbl_2300
	UNION ALL
	SELECT drvDTP00_DateTime_349 as drvDTP00_DateTime, drvDTP01_DateTimeQualifier_349 drvDTP01_DateTimeQualifier, drvDTP02_DateTimeFormatQual_349 drvDTP02_DateTimeFormatQual, drvDTP03_DateTimePeriod_349 drvDTP03_DateTimePeriod, drvHD00_HealthCoverage, drvInitialSort, drvSubSort,  '2' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl_2300
	UNION ALL
	SELECT drvDTP00_DateTime_303 as drvDTP00_DateTime, drvDTP01_DateTimeQualifier_303 drvDTP01_DateTimeQualifier, drvDTP02_DateTimeFormatQual_303 drvDTP02_DateTimeFormatQual, drvDTP03_DateTimePeriod_303 drvDTP03_DateTimePeriod, drvHD00_HealthCoverage, drvInitialSort, drvSubSort,  '3' drvsubsort2
	FROM dbo.U_@CustomFormatCode_DrvTbl_2300	
	; 


    -------------------
    -- DETAIL RECORD 
    -------------------
    --=====================    
    -- Loop 2700 RECORDS
    --=====================
    IF OBJECT_ID('U_@CustomFormatCode_DrvTbl_2700','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_DrvTbl_2700;
    SELECT DISTINCT
        -- If drvLS01_LoopIDCode is Populated, then send LS Segment
        drvLS01_LoopIDCode = ''	--'2700'
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
        ,drvREF02_RefNumberDesc = ''
		
		,drvDTP00_DateTime_007 =     CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_007 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN '007' END
        ,drvDTP02_DateTimeFormatQual_007 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN 'D8' END
        ,drvDTP03_DateTimePeriod_007 = CASE WHEN BdmDedType IN ('MED','DEN','VIS') THEN dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) END
		
        -- If drvLE01_LoopIDCode is Populated, then send LE Segment
        ,drvLE01_LoopIDCode = ''	--'2700'
		---------------------------------
        ,drvEEID = xEEID
        ,drvCOID = xCOID
        ,drvDepRecID = ConSystemID
        ,drvSSN = EepSSN
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = CONVERT(CHAR(9),RTRIM(EepSSN)) + CONVERT(CHAR(12),ISNULL(ConSystemID,''))
                      + '99'
		,drvsubsort2 = ''
    INTO dbo.U_@CustomFormatCode_DrvTbl_2700
    FROM dbo.U_@CustomFormatCode_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_@CustomFormatCode WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;
    /**************************************************************************************************
        TRAILER RECORDS
            - SE, GE, IEA Segments
    **************************************************************************************************/
    ---------------------
    -- TRAILER RECORD
    --------------------
    IF OBJECT_ID('U_@CustomFormatCode_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_TrlTbl;
    SELECT DISTINCT 
	drvSE01_SegmentCount = '9999'
	,drvSegSE02  = '0001'
    ,drvSegGE02  = '0001'
    ,drvSegIEA02 = @FileNum
	
    INTO dbo.U_@CustomFormatCode_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('@CustomFormatCode','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 
			CASE 
			WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_@CompanyCode_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
			WHEN @ExportCode LIKE '%TEST%' THEN 'TEST_@CompanyCode_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
			ELSE '@CompanyCode_@CustomFormatCode_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
			END 
        WHERE FormatCode = '@CustomFormatCode';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '202004011'
       ,ExpStartPerControl     = '202004011'
       ,ExpLastEndPerControl   = '202004019'
       ,ExpEndPerControl       = '202004019'
WHERE ExpFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2), SubSort2 -- loop order 
GO
CREATE FUNCTION [dbo].[dsi_fn_@CustomFormatCode_2100ALoop_Value] (
    @FieldNum        INT,
	@PER03_CommNumberQualifier VARCHAR(100),
	@PER04_CommunicationNumber VARCHAR(100),
	@PER05_CommNumberQualifier VARCHAR(100),
	@PER06_CommunicationNumber VARCHAR(100),
	@PER07_CommNumberQualifier VARCHAR(100),
	@PER08_CommunicationNumber VARCHAR(100) 	
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
JOIN dbo.vw_int_EmpComp WITH (NOLOCK) ON EecEEID = EepEEID AND EecCOID = dbo.dsi_fn_GetCurrentCOID(EepEEID) 

************************************************************/
BEGIN

    -----------
    -- Build table variable
    -----------

    DECLARE @tvValues TABLE (
    tvRowNum      INT IDENTITY(1, 1),
	tvValue     VARCHAR(400)
    );

    -----------
    -- Insert values
    -----------

    IF ISNULL(@PER03_CommNumberQualifier, '') <> '' AND ISNULL(@PER04_CommunicationNumber, '') <> '' 
	BEGIN

       INSERT INTO @tvValues VALUES(@PER03_CommNumberQualifier);
       INSERT INTO @tvValues VALUES(@PER04_CommunicationNumber);

    END

    IF ISNULL(@PER05_CommNumberQualifier, '') <> '' AND ISNULL(@PER06_CommunicationNumber, '') <> ''
	BEGIN

       INSERT INTO @tvValues VALUES(@PER05_CommNumberQualifier);
       INSERT INTO @tvValues VALUES(@PER06_CommunicationNumber);

    END

    IF ISNULL(@PER07_CommNumberQualifier, '') <> '' AND ISNULL(@PER08_CommunicationNumber, '') <> '' 
	BEGIN

       INSERT INTO @tvValues VALUES(@PER07_CommNumberQualifier);
       INSERT INTO @tvValues VALUES(@PER08_CommunicationNumber);

    END

    -----------
    -- Return value
    -----------

    RETURN (SELECT COALESCE(tvValue, '') FROM @tvValues WHERE tvRowNum = @FieldNum); 

END
GO
/****** Object:  UserDefinedFunction [dbo].[dsi_fnlib_FilterSSN]    Script Date: 4/16/2020 10:43:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[dsi_fnlib_FilterSSN]
(
@SSN        VARCHAR(32),
@GoodReturn VARCHAR(32),
@BadReturn  VARCHAR(32)
)
RETURNS VARCHAR(32)
AS

/************************************************************

Created By: John Transier
Create Date: 07/21/2017

Revision History
----------------
Update By            Date            Desc
Lynn Manning                   04/16/2020                         Slight tweak

Purpose: Replaces SSNs with user-defined values for both good and bad SSNs. Useful for hand-coded 834 exports.

Per IRS website:
identify invalid SSNs with:
•The first three digits (former area number) as "000," "666,” or in the 900 series.
•The second group of two digits (former group number) as "00."
•The third group of four digits (former serial number) as "0000."


Commands
--------
SELECT ConSSN, dbo.dsi_fnlib_FilterSSN(ConSSN, ConSSN, '') FROM Contacts
SELECT ConSSN, dbo.dsi_fnlib_FilterSSN(ConSSN, '34', '') FROM Contacts

************************************************************/

BEGIN

SET @SSN = LTRIM(RTRIM(COALESCE(@SSN, '')))
SET @SSN = REPLACE(@SSN, '-', '')

RETURN CASE
          WHEN LEN(@SSN) <> 9                 THEN @BadReturn
          WHEN ISNUMERIC(@SSN) <> 1           THEN @BadReturn
          WHEN @SSN = '123456789'             THEN @BadReturn
          WHEN LEFT(@SSN, 1) = '9'            THEN @BadReturn
          WHEN LEFT(@SSN, 3) IN ('000','666') THEN @BadReturn
          WHEN SUBSTRING(@SSN, 4, 2) = '00'   THEN @BadReturn
          WHEN SUBSTRING(@SSN, 6, 4) = '0000' THEN @BadReturn
          ELSE @GoodReturn
       END

END


