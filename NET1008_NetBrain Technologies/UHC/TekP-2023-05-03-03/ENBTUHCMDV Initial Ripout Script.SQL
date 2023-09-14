/*
Directions:
1) Find and replace each of the text below with the applicable information.
       E.g. Replace the text "Marie Waters" (excluding quotes) with "John Doe"
2) Deploy this to client environment!

-- Integration parameters
NetBrain Technologies, Inc. - Replace with customer name
Marie Waters - Replace with TC name
Dawn Ross - Replace with BA/IC name
09/13/2013 - Replace with date of creation
TekP-2023-05-03-03 - Replace with SR number
ENBTUHCMDV - Replace with Format Code (i.e., ESUNLIF834)
ENBTUH = Replace with SCH_ and left 6 characherts of Format Code (ex: SCH_ESUNLI) 
UnitedHealthcare 834 Export- Replace with Name of Interface (AdfFormatName) (i.e., Sunlife 834 Export)
NET1008 - Replace with Company Code (i.e., GOOG)
Y - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Imports\Accrual\Reports\)

-- Data parameters
NET1008 - Replace with Company Code for Customer
PPO, PPOS,DEN,VIS - Replace with Deduction Code List in CSV format (i.e., DED1,DED2,DED3)

NOTE: SEARCH FOR THE BELOW PARAMETERS TO SKIP TO THE RECORD IN THE TABLE INSTEAD OF FIND/REPLACE, TO ENSURE ',' FORMAT IS CORRECT
SPS - Replace with SPS relationship codes in CSV format (i.e., SPS)
CHL,DPC,LGN,STC - Replace with CHL relationship codes in CSV format (i.e., CHL,STC)
DP - Replace with DP relationship codes in CSV format (i.e., DP)
EE - Replace with EE only benefit options for drvCoverageLevel (i.e., EE)
EEC - Replace with EE+SPOUSE benefit options for drvCoverageLevel (i.e., EEC)
EES - Replace with EE+CHILDREN benefit options for drvCoverageLevel (i.e., EES)
EEDP - Replace with EE+DOMESTICPARTNER benefit options for drvCoverageLevel (i.e., EEDP)
EEF,EEDPF - Replace with EE+FAMILY benefit options for drvCoverageLevel (i.e., FAM)
*/
IF OBJECT_ID('dsi_vwENBTUHCMDV_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwENBTUHCMDV_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ENBTUHCMDV') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENBTUHCMDV];
GO
IF OBJECT_ID('dsi_sp_AfterCollect_ENBTUHCMDV') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_AfterCollect_ENBTUHCMDV];
GO
IF OBJECT_ID('U_ENBTUHCMDV_TrlTbl') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_TrlTbl];
GO
IF OBJECT_ID('U_ENBTUHCMDV_HdrTbl') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_HdrTbl];
GO
IF OBJECT_ID('U_ENBTUHCMDV_File') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_File];
GO
IF OBJECT_ID('U_ENBTUHCMDV_EEList') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_EEList];
GO
IF OBJECT_ID('U_ENBTUHCMDV_DrvTbl_2300') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_DrvTbl_2300];
GO
IF OBJECT_ID('U_ENBTUHCMDV_DrvTbl') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_DrvTbl];
GO
IF OBJECT_ID('U_ENBTUHCMDV_DedList') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_DedList];
GO
IF OBJECT_ID('U_ENBTUHCMDV_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_AuditFields];
GO
IF OBJECT_ID('U_ENBTUHCMDV_Audit') IS NOT NULL DROP TABLE [dbo].[U_ENBTUHCMDV_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_ENBTUHCMDV') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_ENBTUHCMDV];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ENBTUHCMDV';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ENBTUHCMDV';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ENBTUHCMDV';
--DELETE [dbo].[iAscDefF] FROM [dbo].[iAscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ENBTUHCMDV';
DELETE [dbo].[AscDefF] WHERE EXISTS (SELECT 1 FROM dbo.AscDefH WHERE AdfHeaderSystemID = AdhSystemID AND AdhFormatCode = 'ENBTUHCMDV');
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ENBTUHCMDV';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName1 VARCHAR(50), @FixedFormatName2 VARCHAR(50);
SET @AdhSystemID = LEFT('ENBTUHCMDV' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName1 = LEFT('@CustomFormatName',50);
SET @FixedFormatName2 = LEFT('@CustomFormatName',30);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhPreProcessSQL,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) SELECT 'N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','ENBTUHCMDV',@FixedFormatName1,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','2000','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','dbo.dsi_sp_Switchbox_v2','N',NULL,'N';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','01','1',NULL,'ISA  Segment ID (Header)',NULL,NULL,'"ISA"','(''DA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','01','2',NULL,'Authorization Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'10','H','01','3',NULL,'Authorization Info',NULL,NULL,'""','(''SS''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','01','4',NULL,'Security Info Qualifier',NULL,NULL,'"00"','(''DA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'10','H','01','5',NULL,'Security Info',NULL,NULL,'""','(''SS''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'2','H','01','6',NULL,'Sender ID Qualifier',NULL,NULL,'"drvISA05_SenderIDQual"','(''UA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'15','H','01','7',NULL,'Sender ID',NULL,NULL,'"drvISA06_SenderID"','(''UA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','H','01','8',NULL,'Receiver ID Qualifier',NULL,NULL,'"drvISA07_ReceiverIDQual"','(''UA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'15','H','01','9',NULL,'Receiver ID',NULL,NULL,'"drvISA08_ReceiverID"','(''UA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'6','H','01','10',NULL,'Interchange Date',NULL,NULL,'"drvISA09_InterchangeDate"','(''UD12''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'4','H','01','11',NULL,'Interchange Time',NULL,NULL,'"drvISA10_InterchangeTime"','(''UA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'1','H','01','12',NULL,'Repetition Separator',NULL,NULL,'"^"','(''DA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'5','H','01','13',NULL,'Interchange Control Ver #',NULL,NULL,'"00501"','(''DA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'9','H','01','14',NULL,'Interchange Control #',NULL,NULL,'"1"','(''DA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '15',@AdhSystemID,'1','H','01','15',NULL,'Acknowledgement Requested',NULL,NULL,'"1"','(''DA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '16',@AdhSystemID,'1','H','01','16',NULL,'Usage Indicator',NULL,NULL,'"drvISA15_UsageIndicator"','(''UA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '17',@AdhSystemID,'1','H','01','17',NULL,'Component Element Separator',NULL,NULL,'"drvISA16_ComponentSeprator"','(''UA''=''F*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','02','1',NULL,'GS Segment ID (Header)',NULL,NULL,'"GS"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','02','2',NULL,'Functional ID Code',NULL,NULL,'"BE"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','02','3',NULL,'Sender ID',NULL,NULL,'"drvGS02_SenderID"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'15','H','02','4',NULL,'Receiver ID',NULL,NULL,'"drvGS03_ReceiverID"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'8','H','02','5',NULL,'Date',NULL,NULL,'"drvGS04_Date"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'8','H','02','6',NULL,'Time',NULL,NULL,'"drvGS05_Time"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'9','H','02','7',NULL,'Group Control Number',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','H','02','8',NULL,'Responsible Agency Code',NULL,NULL,'"X"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'12','H','02','9',NULL,'Version/Release  Code',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','03','1',NULL,'ST Segment ID (Header)',NULL,NULL,'"ST"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','03','2',NULL,'Transaction ID Code',NULL,NULL,'"834"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','H','03','3',NULL,'Transaction Set Control #',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','H','03','4',NULL,'Implementation Convention Refe',NULL,NULL,'"005010X220A1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','04','1',NULL,'BGN Segment ID (Header)',NULL,NULL,'"BGN"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','04','2',NULL,'Transaction Set Purpose',NULL,NULL,'"00"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','04','3',NULL,'Reference Number',NULL,NULL,'"NetBrain Technologies"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'8','H','04','4',NULL,'Date',NULL,NULL,'"drvBGN03_Date"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'8','H','04','5',NULL,'Time',NULL,NULL,'"drvBGN04_Time"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'2','H','04','6',NULL,'Time Code',NULL,NULL,'"drvBGN05_TimeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'50','H','04','7',NULL,'Reference Identification',NULL,NULL,'"drvBGN06_RefID"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'2','H','04','8',NULL,'Transaction Type Code',NULL,NULL,'"drvBGN07_TransTypeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','H','04','9',NULL,'Action Code',NULL,NULL,'"drvBGN08_ActionCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','05','1',NULL,'REF Segment ID (Header)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','05','2',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','05','3',NULL,'Reference Number Qualifier',NULL,NULL,'"drvREF02_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'50','H','06','3',NULL,'DTP Header',NULL,NULL,'"drvDTP00_DateTime0"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'50','H','06','3',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier0"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','06','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual0"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'50','H','06','3',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod0"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'50','H','07','3',NULL,'DTP Header',NULL,NULL,'"drvDTP00_DateTime1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'50','H','07','3',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','H','07','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'50','H','07','3',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod1"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','08','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','08','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','08','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','09','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','09','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','09','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','H','10','1',NULL,'QTY Segment ID (Header)',NULL,NULL,'"QTY"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','H','10','2',NULL,'Quantity Qualifier',NULL,NULL,'"drvQTY01_QuantityQual3"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'15','H','10','3',NULL,'Quantity',NULL,NULL,'"drvQTY02_Quantity3"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','11','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','11','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','H','11','3',NULL,'Name',NULL,NULL,'"drvN102_Name1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','11','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'80','H','11','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','H','12','1',NULL,'N1 Segment ID (Loop1000A/B)',NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','H','12','2',NULL,'Entity Identifier Code/Sponsor',NULL,NULL,'"drvN101_EntityIDCodeSponsor2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','H','12','3',NULL,'Name',NULL,NULL,'"drvN102_Name2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'2','H','12','4',NULL,'Identification Code Qualifier',NULL,NULL,'"drvN103_IDCodeQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'80','H','12','5',NULL,'Identification Code',NULL,NULL,'"drvN104_IDCode2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','13','1',NULL,'INS Segment ID (Loop 2000)',NULL,NULL,'"INS"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'1','D','13','2',NULL,'Yes/No Condition',NULL,NULL,'"drvINS01_YesNoCond"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','13','3',NULL,'Individual Relationship Code',NULL,NULL,'"drvINS02_RelationshipCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','13','4',NULL,'Maintenance Type Code',NULL,NULL,'"drvINS03_MaintTypeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'3','D','13','5',NULL,'Maintenance Reason Code',NULL,NULL,'"drvINS04_MaintReasonCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'1','D','13','6',NULL,'Benefit Status Code',NULL,NULL,'"drvINS05_BenefitStatusCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'1','D','13','7',NULL,'MEDICARE PLAN CODE',NULL,NULL,'"drvINS0601_MEDICAREPLANCODE"','(''UA''=''T'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'1','D','13','8',NULL,'Eligibility Reason Code',NULL,NULL,'"drvINS0602_EligibilityRsnCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','13','9',NULL,'COBRA Qualifying Event Code',NULL,NULL,'"drvINS07_COBRAQualEventCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'2','D','13','10',NULL,'Employment Status Code',NULL,NULL,'"drvINS08_EmploymentStatusCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '11',@AdhSystemID,'1','D','13','11',NULL,'Student Status Code',NULL,NULL,'"drvINS09_StudentStatusCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '12',@AdhSystemID,'1','D','13','12',NULL,'Response Code',NULL,NULL,'"drvINS10_ResponseCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '13',@AdhSystemID,'3','D','13','13',NULL,'Date Time Period Format Qualif',NULL,NULL,'"drvINS11_DateTimeFormatQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '14',@AdhSystemID,'35','D','13','14',NULL,'Date Time Period',NULL,NULL,'"drvINS12_DateTimePeriod"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','14','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','14','2',NULL,'Reference Number Identificatio',NULL,NULL,'"0F"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','14','3',NULL,'Reference Number',NULL,NULL,'"drvSSN"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','15','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','15','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','15','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','16','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','16','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','16','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','17','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','17','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual3"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','17','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual3"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','18','1',NULL,'REF Segment ID (Loop 2000)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','18','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual4"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','18','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual4"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','19','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"drvDTP00_DateTime1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','19','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','19','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','19','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod1"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','20','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"drvDTP00_DateTime2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','20','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','20','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','20','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod2"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','21','1',NULL,'DTP Segment ID (Loop 2000)',NULL,NULL,'"drvDTP00_DateTime3"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','21','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier3"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','21','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual3"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','21','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod3"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','22','1',NULL,'NM1 Segment ID (Loop 2100A)',NULL,NULL,'"NM1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','22','2',NULL,'Entity Identifier Code',NULL,NULL,'"IL"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','22','3',NULL,'Entity Type Qualifier',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'60','D','22','4',NULL,'Name Last',NULL,NULL,'"drvNM103_NameLast1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'35','D','22','5',NULL,'Name First',NULL,NULL,'"drvNM104_NameFirst1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'25','D','22','6',NULL,'Name Middle Initial',NULL,NULL,'"drvNM105_NameMiddleInitial1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'10','D','22','7',NULL,'Name Prefix',NULL,NULL,'"drvNM106_NamePrefix1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'10','D','22','8',NULL,'Name Suffix',NULL,NULL,'"drvNM107_NameSuffix1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'2','D','22','9',NULL,'Identification Code Qualifier',NULL,NULL,'"drvNM108_IDCodeQualifier1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '10',@AdhSystemID,'80','D','22','10',NULL,'Identification Code',NULL,NULL,'"drvNM109_IDCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','23','1',NULL,'PER Segment ID (Loop 2100A)',NULL,NULL,'"PER"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'2','D','23','2',NULL,'Contact Function Code',NULL,NULL,'"IP"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','D','23','3',NULL,'Name',NULL,NULL,'"drvPER02_Name"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','23','4',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER03_CommNumberQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'256','D','23','5',NULL,'Communication Number',NULL,NULL,'"drvPER04_CommunicationNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'3','D','23','6',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER05_CommNumberQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'256','D','23','7',NULL,'Communication Number',NULL,NULL,'"drvPER06_CommunicationNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'3','D','23','8',NULL,'Communication Number Qualifier',NULL,NULL,'"drvPER07_CommNumberQualifier"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '9',@AdhSystemID,'256','D','23','9',NULL,'Communication Number',NULL,NULL,'"drvPER08_CommunicationNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','24','1',NULL,'N3 Segment ID (Loop 2100A)',NULL,NULL,'"N3"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'55','D','24','2',NULL,'Address Line 1',NULL,NULL,'"drvN301_AddressLine1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'55','D','24','3',NULL,'Address Line 2',NULL,NULL,'"drvN302_AddressLine2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','25','1',NULL,'N4 Segment ID (Loop 2100A)',NULL,NULL,'"N4"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'30','D','25','2',NULL,'City',NULL,NULL,'"drvN401_City"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'2','D','25','3',NULL,'State',NULL,NULL,'"drvN402_State"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'15','D','25','4',NULL,'Zip',NULL,NULL,'"drvN403_Zip"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'3','D','25','5',NULL,'Country Code',NULL,NULL,'"drvN404_CountryCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','26','1',NULL,'DMG Segment ID (Loop 2100A)',NULL,NULL,'"DMG"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','26','2',NULL,'Date/Time Format Qualifier',NULL,NULL,'"D8"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'35','D','26','3',NULL,'Date/Time Period',NULL,NULL,'"drvDMG02_DateTimePeriod1"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'1','D','26','4',NULL,'Gender Code',NULL,NULL,'"drvDMG03_GenderCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'1','D','26','5',NULL,'Marital Status Code',NULL,NULL,'"drvDMG04_MaritalStatusCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','27','1',NULL,'ICM Segment ID (Loop1000A)',NULL,NULL,'"ICM"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'1','D','27','2',NULL,'Frequency Code',NULL,NULL,'"drvICM01_FrequencyCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'18','D','27','3',NULL,'Monetary Amount',NULL,NULL,'"drvICM02_MonetaryAmount"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'15','D','27','4',NULL,'Quantity',NULL,NULL,'"drvICM03_Quantity"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'30','D','27','5',NULL,'Location Identifier Description',NULL,NULL,'"drvICM04_LocationID"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','28','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'18','D','28','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','28','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','29','1',NULL,'ACM Segment ID (Loop1000A)',NULL,NULL,'"drvAMT00_SegmentID2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'18','D','29','2',NULL,'Monetary Amount',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'1','D','29','3',NULL,'Credit/Debit Flag Code',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'1','D','30','1',NULL,'HLH Segment ID (Loop1000A)',NULL,NULL,'"drvHLH00_SegmentID"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'8','D','30','2',NULL,'Health-Related Code',NULL,NULL,'"drvHLH01_HealthRelatedCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'10','D','30','3',NULL,'Height',NULL,NULL,'"drvHLH02_Height"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'10','D','30','4',NULL,'Weight',NULL,NULL,'"drvHLH03_Weight1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'10','D','30','5',NULL,'Weight',NULL,NULL,'"drvHLH04_Weight2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'10','D','30','6',NULL,'Description',NULL,NULL,'"drvHLH05_Description1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '7',@AdhSystemID,'10','D','30','7',NULL,'Current Health Condition Code',NULL,NULL,'"drvHLH06_CurrentHealthConditionCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '8',@AdhSystemID,'10','D','30','8',NULL,'Description',NULL,NULL,'"drvHLH07_Description2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','40','1',NULL,'HD Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvHD00_HealthCoverage"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','40','2',NULL,'Maintenance Type Code',NULL,NULL,'"drvHD01_MaintTypeCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','40','3',NULL,'Maintenance Reason Code',NULL,NULL,'"drvHD02_MaintReasonCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'3','D','40','4',NULL,'Insurance Line Code',NULL,NULL,'"drvHD03_InsuranceLineCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '5',@AdhSystemID,'50','D','40','5',NULL,'Plan Coverage Description',NULL,NULL,'"drvHD04_PlanCoverageDesc"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '6',@AdhSystemID,'3','D','40','6',NULL,'Coverage Level Code',NULL,NULL,'"drvHD05_CoverageLevelCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','41','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_348"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','41','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_348"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','41','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_348"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','41','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_348"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','42','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_349"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','42','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_349"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','42','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_349"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','42','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_349"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','43','1',NULL,'DTP Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvDTP00_DateTime_303"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','43','2',NULL,'Date/Time Qualifier',NULL,NULL,'"drvDTP01_DateTimeQualifier_303"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'3','D','43','3',NULL,'Date/Time Format',NULL,NULL,'"drvDTP02_DateTimeFormatQual_303"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '4',@AdhSystemID,'35','D','43','4',NULL,'Date/Time Period',NULL,NULL,'"drvDTP03_DateTimePeriod_303"','(''UD112''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','45','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL,'"drvREF00_RefNumberQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','45','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','45','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','46','1',NULL,'REF Segment ID (Loop 2300)',NULL,NULL,'"drvREF00_RefNumberQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','46','2',NULL,'Reference Number Identificatio',NULL,NULL,'"drvREF01_RefNumberQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','46','3',NULL,'Reference Number',NULL,NULL,'"drvREF02_RefNumberQual2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','50','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','50','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'18','D','50','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount1"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','51','1',NULL,'AMT Segment ID (Loop 2300) - Loop 1',NULL,NULL,'"drvAMT00_AmountQualifierCode2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','51','2',NULL,'Amount Qualifier Code',NULL,NULL,'"drvAMT01_AmountQualifierCode2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'18','D','51','3',NULL,'Monetary Amount',NULL,NULL,'"drvAMT02_MonetaryAmount2"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','80','1',NULL,'LS Segment ID (Loop 2700)',NULL,NULL,'"LS"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','D','80','2',NULL,'Loop ID Code',NULL,NULL,'"drvLS01_LoopIDCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','81','1',NULL,'LX Segment ID (Loop 2700)',NULL,NULL,'"LX"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','D','81','2',NULL,'Assigned Number',NULL,NULL,'"drvLX01_AssignedNumber"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','D','85','1',NULL,'N1 Segment ID (Loop 2750)',NULL,NULL,'"N1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','85','2',NULL,'Entity Identifier Code',NULL,NULL,'"drvN101_EntityIDCodeSponsor"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'60','D','85','3',NULL,'Name',NULL,NULL,'"drvN102_Name"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','86','1',NULL,'REF Segment ID (Loop 2750)',NULL,NULL,'"REF"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'3','D','86','2',NULL,'Reference Identification Quali',NULL,NULL,'"drvREF01_RefNumberQual"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'50','D','86','3',NULL,'Reference Identification Descr',NULL,NULL,'"drvREF02_RefNumberDesc"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','D','87','1',NULL,'LE Segment ID (Loop 2750)',NULL,NULL,'"LE"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','D','87','2',NULL,'Loop ID Code',NULL,NULL,'"drvLE01_LoopIDCode"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','T','90','1',NULL,'SE Segment ID (Trailer)',NULL,NULL,'"SE"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'10','T','90','2',NULL,'Number of Included Segments',NULL,NULL,'"drvSE01_SegmentCount"','(''UA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','90','3',NULL,'Transaction Set Control Number',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'2','T','91','1',NULL,'GE Segment ID (Trailer)',NULL,NULL,'"GE"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'6','T','91','2',NULL,'Number of Transaction Sets Inc',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','91','3',NULL,'Group Control Number',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '1',@AdhSystemID,'3','T','92','1',NULL,'IEA Segment ID (Trailer)',NULL,NULL,'"IEA"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '2',@AdhSystemID,'5','T','92','2',NULL,'Number of Functional Groups In',NULL,NULL,'"1"','(''DA''=''T*'')';
INSERT INTO [dbo].[iAscDefF] (AdfFieldNumber,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType,AdfExpression,AdfForCond) SELECT '3',@AdhSystemID,'9','T','92','3',NULL,'Interchange Control Number',NULL,NULL,'"1"','(''DA''=''T*'')';
-- Uncomment this line if a changes only version is needed
--INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Changes Only File',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','CHANGES','Oct  1 2018 12:00AM','ENBTUHCMDV',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Test File Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','TEST_XOE','Oct  1 2018 12:00AM','ENBTUHCMDV',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
--INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Full File Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','FULL_XOE','Oct  1 2018 12:00AM','ENBTUHCMDV',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'On-Demand Only',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ONDM_XOE','Oct  1 2018 12:00AM','ENBTUHCMDV',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEACTIVE','Oct  1 2018 12:00AM','ENBTUHCMDV',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment',CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','OEPASSIVE','Oct  1 2018 12:00AM','ENBTUHCMDV',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expCOIDList,expIEXSystemID) SELECT 'File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,@FixedFormatName2,CONVERT(CHAR(8),GETDATE(),112) + '9','EMPEXPORT','ENBTUH','Oct  1 2018 12:00AM','ENBTUHCMDV',NULL,NULL,NULL,CONVERT(CHAR(8),GETDATE(),112) + '9','Oct  1 2018 12:00AM','Dec 30 1899 12:00AM',CONVERT(CHAR(8),GETDATE(),112) + '1',NULL,'','',CONVERT(CHAR(8),GETDATE(),112) + '1',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL,NULL;
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','834LineFeed','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','InitialSort','C','LEFT(drvInitialSort,20)');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','Is834','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ENBTUHCMDV','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H01','U_ENBTUHCMDV_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H02','U_ENBTUHCMDV_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H03','U_ENBTUHCMDV_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H04','U_ENBTUHCMDV_HdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H05','U_ENBTUHCMDV_HdrTbl','ISNULL(drvREF01_RefNumberQual,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H06','U_ENBTUHCMDV_HdrTbl','ISNULL(drvDTP00_DateTime0,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H07','U_ENBTUHCMDV_HdrTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H08','U_ENBTUHCMDV_HdrTbl','ISNULL(drvQTY01_QuantityQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H09','U_ENBTUHCMDV_HdrTbl','ISNULL(drvQTY01_QuantityQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H10','U_ENBTUHCMDV_HdrTbl','ISNULL(drvQTY01_QuantityQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H11','U_ENBTUHCMDV_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','H12','U_ENBTUHCMDV_HdrTbl','ISNULL(drvN101_EntityIDCodeSponsor2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D13','U_ENBTUHCMDV_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D14','U_ENBTUHCMDV_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D15','U_ENBTUHCMDV_DrvTbl','ISNULL(drvREF01_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D16','U_ENBTUHCMDV_DrvTbl','ISNULL(drvREF01_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D17','U_ENBTUHCMDV_DrvTbl','ISNULL(drvREF01_RefNumberQual3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D18','U_ENBTUHCMDV_DrvTbl','ISNULL(drvREF01_RefNumberQual4,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D19','U_ENBTUHCMDV_DrvTbl','ISNULL(drvDTP00_DateTime1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D20','U_ENBTUHCMDV_DrvTbl','ISNULL(drvDTP00_DateTime2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D21','U_ENBTUHCMDV_DrvTbl','ISNULL(drvDTP00_DateTime3,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D22','U_ENBTUHCMDV_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D23','U_ENBTUHCMDV_DrvTbl','ISNULL(drvPER03_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER05_CommNumberQualifier,'''') <> '''' OR ISNULL(drvPER07_CommNumberQualifier,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D24','U_ENBTUHCMDV_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D25','U_ENBTUHCMDV_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D26','U_ENBTUHCMDV_DrvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D27','U_ENBTUHCMDV_DrvTbl','ISNULL(drvICM01_FrequencyCode,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D28','U_ENBTUHCMDV_DrvTbl','ISNULL(drvAMT00_SegmentID1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D29','U_ENBTUHCMDV_DrvTbl','ISNULL(drvAMT00_SegmentID2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D30','U_ENBTUHCMDV_DrvTbl','ISNULL(drvHLH00_SegmentID,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D40','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D41','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_348,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D42','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_349,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D43','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvDTP00_DateTime_303,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D45','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D46','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvREF00_RefNumberQual2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D50','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode1,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D51','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvHD00_HealthCoverage,'''') <> '''' AND ISNULL(drvAMT00_AmountQualifierCode2,'''') <> ''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D80','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvLS01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D81','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvLX01_AssignedNumber,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D85','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvN101_EntityIDCodeSponsor,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D86','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvREF01_RefNumberQual,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','D87','U_ENBTUHCMDV_DrvTbl_2300','ISNULL(drvLE01_LoopIDCode,'''') <>''''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','T90','U_ENBTUHCMDV_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','T91','U_ENBTUHCMDV_TrlTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ENBTUHCMDV','T92','U_ENBTUHCMDV_TrlTbl',NULL);
GO
DECLARE @ISWEB CHAR(1) = 'Y';
DECLARE @FormatCode VARCHAR(10) = 'ENBTUHCMDV'
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
    UPDATE dbo.AscExp SET expAscFileName = @FilePath + @FileName WHERE expFormatCode = 'ENBTUHCMDV';

    DELETE FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENBTUHCMDV' AND CfgName IN ('TestPath','UDESPath');
END
GO
IF OBJECT_ID('U_ENBTUHCMDV_EEList') IS NULL
CREATE TABLE [dbo].[U_ENBTUHCMDV_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ENBTUHCMDV_File') IS NULL
CREATE TABLE [dbo].[U_ENBTUHCMDV_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(50) NOT NULL,
    [SubSort] varchar(50) NOT NULL,
    [SubSort2] varchar(50) NULL,
    [SubSort3] varchar(50) NULL,
    [Data] varchar(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_AfterCollect_ENBTUHCMDV]
AS
SET NOCOUNT ON;
/************************************************************
Client: NetBrain Technologies, Inc.

Created By: Marie Waters
Create Date: 09/13/2013
ChangePoint Request Number: TekP-2023-05-03-03

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
    WHILE (SELECT COUNT(*) FROM dbo.U_ENBTUHCMDV_File WHERE RIGHT(DATA,2) = '*~') > 0
    BEGIN
        UPDATE dbo.U_ENBTUHCMDV_File SET DATA = REPLACE(DATA,'*~','~') WHERE RIGHT(RTRIM(DATA),2) = '*~';
    END;

    --========================================
    -- Remove Extra Records from PER Segment
    --========================================
    UPDATE dbo.U_ENBTUHCMDV_File SET DATA = REPLACE(DATA,'HP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%HP**%';
    UPDATE dbo.U_ENBTUHCMDV_File SET DATA = REPLACE(DATA,'WP**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%WP**%';
    UPDATE dbo.U_ENBTUHCMDV_File SET DATA = REPLACE(DATA,'EM**','') WHERE LEFT(DATA,3) = 'PER' AND DATA LIKE '%EM**%';

    --====================================
    -- Update Record Count in SE Segment
    --====================================
    DECLARE @RecordCount INT;
    SET @RecordCount = (SELECT COUNT(*) FROM dbo.U_ENBTUHCMDV_File WHERE LEFT(Data, CHARINDEX('*',Data) - 1) NOT IN ('ISA','GS','IEA','GE'));

    UPDATE dbo.U_ENBTUHCMDV_File
    SET Data = REPLACE(Data,'9999',@RecordCount)
    WHERE LEFT(Data,2) = 'SE';

END
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ENBTUHCMDV]
    @systemid CHAR(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client: NetBrain Technologies, Inc.

Created By: Marie Waters
Business Analyst: Dawn Ross
Create Date: 09/13/2013
Service Request Number: TekP-2023-05-03-03

Purpose: @CustomFormatName

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/20XX     SR-20XX-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'ENBTUHCMDV';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'ENBTUHCMDV';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'ENBTUHCMDV';
SELECT * FROM dbo.AscExp WHERE expFormatCode = 'ENBTUHCMDV';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'ENBTUHCMDV' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENBTUHCMDV', 'ONDM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENBTUHCMDV', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENBTUHCMDV', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENBTUHCMDV', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'ENBTUHCMDV', 'ENBTUH';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'ENBTUHCMDV';

EXEC dbo._dsi_usp_ExportRipOut_V7_4 @FormatCode = 'ENBTUHCMDV', @AllObjects = 'Y', @IsWeb = 'Y';
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
        ,@FileMinCovDate  = '06/01/2023'
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = 'ENBTUHCMDV';

    --==========================================
    -- Deduction Code List
    --==========================================
    DECLARE @DedList VARCHAR(MAX);
    SET @DedList = 'PPO,PPOS,DEN,VIS';

    IF OBJECT_ID('U_ENBTUHCMDV_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_ENBTUHCMDV_DedList;
    SELECT DedCode = DedDedCode
        ,DedLongDesc
        ,DedType = DedDedType
    INTO dbo.U_ENBTUHCMDV_DedList
    FROM dbo.dsi_BDM_fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- Clean EE List
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_ENBTUHCMDV_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCoID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_ENBTUHCMDV_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    IF @ExportCode LIKE 'OE%'
    BEGIN
        -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
        DELETE FROM dbo.U_ENBTUHCMDV_EEList
        WHERE NOT EXISTS (SELECT 1 FROM dbo.EmpDed JOIN dbo.U_ENBTUHCMDV_DedList ON DedCode = EedDeDCode WHERE EedEEID = xEEID);
    END;

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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,DPC,LGN,STC');
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
    FROM dbo.U_dsi_bdm_ENBTUHCMDV D
    JOIN dbo.U_dsi_bdm_ENBTUHCMDV E
        ON E.BdmEEID = D.BdmEEID
        AND E.BdmCOID = D.BdmCOID
        AND E.BdmDedCode = D.BdmDedCode
    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';

    --=====================================================
    -- Update BdmUSGField2 with EmpDedTVID for Employees
    --=====================================================
    UPDATE dbo.U_dsi_bdm_ENBTUHCMDV
        SET BdmUSGField2 = EedEmpDedTVID
    FROM dbo.U_dsi_bdm_ENBTUHCMDV
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = BdmEEID
        AND EedCOID = BdmCOID
        AND EedDedCode = BdmDedCode
    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';

    --=======================================================
    -- Update BdmUSGField2 with DepBPlanTVID for Dependents
    --=======================================================
    UPDATE dbo.U_dsi_bdm_ENBTUHCMDV
        SET BdmUSGField2 = DbnDepBPlanTVID
    FROM dbo.U_dsi_bdm_ENBTUHCMDV
    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)
        ON DbnEEID = BdmEEID
        AND DbnCOID = BdmCOID
        AND DbnDedCode = BdmDedCode
    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';

    --======================================================
    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)
    --======================================================
    UPDATE dbo.U_dsi_bdm_ENBTUHCMDV
        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)
    FROM dbo.U_dsi_bdm_ENBTUHCMDV
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
    IF OBJECT_ID('U_ENBTUHCMDV_HdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENBTUHCMDV_HdrTbl;
    SELECT DISTINCT drvISA05_SenderIDQual = '30'
        ,drvISA06_SenderID = CmmFedtaxId
        ,drvISA07_ReceiverIDQual = '30'
        ,drvISA08_ReceiverID = '411289245'
        ,drvISA09_InterchangeDate = RIGHT(@RunDate,6)
        ,drvISA10_InterchangeTime = @RunTime
        ,drvISA15_UsageIndicator = CASE WHEN @ExportCode LIKE '%TEST%' THEN 'T' ELSE 'P' END
        ,drvISA16_ComponentSeprator = ':'
        ,drvGS02_SenderID = CmmFedtaxId
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
        ,drvREF02_RefNumberQual = 'NETBF'
        ,drvDTP00_DateTime0 = ''
        ,drvDTP01_DateTimeQualifier0 = ''
        ,drvDTP02_DateTimeFormatQual0 = ''
        ,drvDTP03_DateTimePeriod0 = ''
        ,drvDTP00_DateTime1 = ''
        ,drvDTP01_DateTimeQualifier1 = ''
        ,drvDTP02_DateTimeFormatQual1 = ''
        ,drvDTP03_DateTimePeriod1 = ''
        ,drvQTY01_QuantityQual1 = ''
        ,drvQTY02_Quantity1 = ''
        ,drvQTY01_QuantityQual2 = ''
        ,drvQTY02_Quantity2 = ''
        ,drvQTY01_QuantityQual3 = ''
        ,drvQTY02_Quantity3 = ''
        ,drvN101_EntityIDCodeSponsor1 = 'P5'
        ,drvN102_Name1 = 'NetBrain Technologies'
        ,drvN103_IDCodeQual1 = 'FI'
        ,drvN104_IDCode1 = CmmFedtaxId
        ,drvN101_EntityIDCodeSponsor2 = 'IN'
        ,drvN102_Name2 = 'UNITEDHEALTH GROUP'
        ,drvN103_IDCodeQual2 = 'FI'
        ,drvN104_IDCode2 = '411289245'
    INTO dbo.U_ENBTUHCMDV_HdrTbl
    FROM dbo.U_ENBTUHCMDV_EELIST WITH (NOLOCK)
    JOIN dbo.U_dsi_bdm_ENBTUHCMDV WITH (NOLOCK)
        ON BdmEEID = xEEID
        AND BdmCOID = xCOID
	JOIN Company WITH (NOLOCK)
        ON cmpCOID = xCOID
    JOIN CompMast WITH (NOLOCK)
        ON CmpMasterCoID = cmpMasterCOID;

    /**************************************************************************************************************
        DETAIL RECORDS
            -- LOOP 2000 RECORDS - INS, REF, DTP Segments
            -- LOOP 2100A RECORDS - NM1, PER, N3, N4, DMG, ICM Segments
            -- LOOP 2100B RECORDS - NM1, DMG Segments
    ***************************************************************************************************************/

    -------------------
    -- DETAIL RECORD 
    -------------------
    IF OBJECT_ID('U_ENBTUHCMDV_DrvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_ENBTUHCMDV_DrvTbl;
    SELECT DISTINCT
        --=====================
        --LOOP 2000 RECORDS
        --=====================
        drvINS01_YesNoCond = CASE BdmRecType
                                 WHEN 'EMP' THEN 'Y'
                                 ELSE 'N'
                             END
        ,drvINS02_RelationshipCode =    CASE WHEN BdmRecType = 'EMP' THEN '18'
                                        ELSE
                                            CASE WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('SPS')) THEN '01'
                                            WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('DP')) THEN '53'
											WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('LGN')) THEN '15'
                                            WHEN ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('CHL,DPC,STC')) THEN '19'
                                            ELSE '19'
                                            END
                                        END
        ,drvINS03_MaintTypeCode = '030' --Audit or Compare
        ,drvINS04_MaintReasonCode = 'XN' --Notification Only
        ,drvINS05_BenefitStatusCode = 'A'
        ,drvINS0601_MEDICAREPLANCODE = ''
        ,drvINS0602_EligibilityRsnCode = ''
        ,drvINS07_COBRAQualEventCode = ''
        ,drvINS08_EmploymentStatusCode = CASE WHEN BdmRecType = 'EMP' THEN 'FT' 
                                                --CASE WHEN EecEmplStatus = 'T' THEN 'TE' --Termination
                                                --     WHEN EecFullTimeOrPartTime = 'F' THEN 'FT' --Full time active employee
                                                --     WHEN EecFullTimeOrPartTime = 'P' THEN 'PT' --Part time active employee
                                                --END
                                         END
        ,drvINS09_StudentStatusCode = ''--CASE WHEN BdmRecType = 'DEP' THEN
                                      --          CASE WHEN ConIsStudent = 'Y' THEN 'F' END --Full-time
                                      --END
        ,drvINS10_ResponseCode = CASE --WHEN BdmRecType = 'EMP' THEN
                                        --CASE WHEN EepIsDisabled = 'Y' THEN 'Y'
                                        --     ELSE 'N'
                                        --END
                                      WHEN BdmRecType = 'DEP' and ConRelationship IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('CHL,DPC,STC, LGN'))THEN 
                                        CASE WHEN ConIsDisabled = 'Y' THEN 'Y'
                                             ELSE 'N'
                                        END
                                END
        ,drvINS11_DateTimeFormatQual = CASE WHEN ISNULL(EepDateDeceased, '') <> '' or ISNULL(ConDeathDate , '') <> '' THEN 'D8' END
        ,drvINS12_DateTimePeriod = CASE WHEN ISNULL(EepDateDeceased, '') <> '' THEN CONVERT(VARCHAR(8),EepDateDeceased,112) 
										WHEN ISNULL(ConDeathDate , '') <> ''THEN CONVERT(VARCHAR(8),ConDeathDate,112)   END
        -- If drvREF01_RefNumberQual1 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual1 = ''
        ,drvREF02_RefNumberQual1 = EEPSSN
        -- If drvREF01_RefNumberQual2 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual2 = '1L'
        ,drvREF02_RefNumberQual2 = '0931179'
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual3 = ''
        ,drvREF02_RefNumberQual3 = ''
        -- If drvREF01_RefNumberQual3 is Populated, then send REF Segment
        ,drvREF01_RefNumberQual4 = ''
        ,drvREF02_RefNumberQual4 = ''
        -- If drvDTP00_DateTime1 is Populated, then send DTP Segment
        ,drvDTP00_DateTime1 = CASE WHEN  EecEmplStatus = 'T' and eecTermReason = '202' then 'DTP' END
        ,drvDTP01_DateTimeQualifier1 = CASE WHEN  EecEmplStatus = 'T' and eecTermReason = '202' then '286' END
        ,drvDTP02_DateTimeFormatQual1 = CASE WHEN  EecEmplStatus = 'T' and eecTermReason = '202' then 'D8' END
        ,drvDTP03_DateTimePeriod1 = CASE WHEN  EecEmplStatus = 'T' and eecTermReason = '202' then EecDateofTermination END
        -- If drvDTP00_DateTime2 is Populated, then send DTP Segment
        ,drvDTP00_DateTime2 = 'DTP'
        ,drvDTP01_DateTimeQualifier2 = '336'
        ,drvDTP02_DateTimeFormatQual2 = 'D8'
        ,drvDTP03_DateTimePeriod2 = EecDateOfLastHire
        -- If drvDTP00_DateTime3 is Populated, then send DTP Segment
        ,drvDTP00_DateTime3 = ''
        ,drvDTP01_DateTimeQualifier3 = ''
        ,drvDTP02_DateTimeFormatQual3 = ''
        ,drvDTP03_DateTimePeriod3 = ''
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
        ,drvNM106_NamePrefix1 = ''--CASE WHEN BdmRecType = 'EMP' THEN EepNamePrefix END
        ,drvNM107_NameSuffix1 = CASE WHEN BdmRecType = 'EMP' AND EepNameSuffix <> 'Z'THEN EepNameSuffix
                                     WHEN BdmRecType = 'DEP' AND ConNameSuffix <> 'Z' THEN ConNameSuffix
                                END
        ,drvNM108_IDCodeQualifier1 =    CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN '34'
                                            WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '111111111','888888888', '123456789') OR RIGHT(ConSSN, 3) IN ('111','000','999','998')) THEN '34'
                                        END        
        ,drvNM109_IDCode1 = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                WHEN BdmRecType = 'DEP' AND NOT (ConSSN IN ('000000000','999999999', '111111111','888888888', '123456789') OR RIGHT(ConSSN, 3) IN ('111','000','999','998')) THEN ConSSN
                            END
        ,drvPER02_Name = ''
        ,drvPER03_CommNumberQualifier = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN 'HP'
                                            WHEN BdmRecType = 'EMP' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM'
                                        END
        ,drvPER04_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' THEN EepPhoneHomeNumber
                                            WHEN BdmRecType = 'EMP' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail
                                        END
        ,drvPER05_CommNumberQualifier =    CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN 'EM' END
        ,drvPER06_CommunicationNumber = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepPhoneHomeNumber, '') <> '' AND ISNULL(eepAddressEMail, '') <> '' THEN eepAddressEMail END
        ,drvPER07_CommNumberQualifier = '' 
        ,drvPER08_CommunicationNumber = '' 
        ,drvN301_AddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvN302_AddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvN401_City = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvN402_State = EepAddressState
        ,drvN403_Zip = EepAddressZipCode
        ,drvN404_CountryCode = ''--CASE WHEN EepAddressCountry NOT IN ('US','USA') THEN EepAddressCountry END
        ,drvDMG02_DateTimePeriod1 = CASE WHEN BdmRecType = 'EMP' THEN CONVERT(VARCHAR(8),EepDateOfBirth,112)
                                         WHEN BdmRecType = 'DEP' THEN CONVERT(VARCHAR(8),ConDateOfBirth,112)
                                    END
        ,drvDMG03_GenderCode1 = CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                     WHEN BdmRecType = 'DEP' THEN ConGender
                                END
        ,drvDMG04_MaritalStatusCode1 = CASE WHEN BdmRecType = 'EMP' THEN
                                           CASE WHEN EepMaritalStatus =  'S' THEN 'I' 
												WHEN ISNULL(EepMaritalStatus,'') NOT IN ('', 'Z', 'S') THEN EepMaritalStatus 
											ELSE 'U' 
										  END
                                       END
        --If drvICM01_FrequencyCode is Populated, then send ICM Segment
        ,drvICM01_FrequencyCode = ''--CASE WHEN BdmRecType = 'EMP' THEN '' END --'7'
        ,drvICM02_MonetaryAmount = ''--CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecAnnSalary) END
        ,drvICM03_Quantity = ''--CASE WHEN BdmRecType = 'EMP' THEN CONVERT(MONEY,EecScheduledWorkHrs) END
        ,drvICM04_LocationID = ''--CASE WHEN BdmRecType = 'EMP' THEN
                                      --  CASE WHEN YEAR(EecDateOfLastHire) = YEAR(GETDATE()) THEN CONVERT(VARCHAR(8),EecDateOfLastHire,112)
                                       --     ELSE CONVERT(CHAR(4),YEAR(GETDATE())) + '0101'
                                      --  END
                              -- END
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
        ,drvHLH01_HealthRelatedCode = ''--CASE WHEN BdmRecType = 'EMP' THEN
                                      --          CASE EepIsSmoker
                                      --               WHEN 'Y' THEN 'T' --Tobacco Use
                                      --               ELSE 'N' --None
                                      --          END
                                      --     WHEN BdmRecType = 'DEP' THEN
                                      --          CASE ConIsSmoker
                                      --               WHEN 'Y' THEN 'T' --Tobacco Use
                                      --               ELSE 'N' --None
                                      --          END
                                      --END
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
    INTO dbo.U_ENBTUHCMDV_DrvTbl
    FROM dbo.U_ENBTUHCMDV_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.Location WITH (NOLOCK)
        ON LocCode = EecLocation
    JOIN dbo.U_dsi_bdm_ENBTUHCMDV WITH (NOLOCK)
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
    IF OBJECT_ID('U_ENBTUHCMDV_DrvTbl_2300','U') IS NOT NULL
        DROP TABLE dbo.U_ENBTUHCMDV_DrvTbl_2300;
    SELECT DISTINCT
        -- If drvHD00_HealthCoverage Populated, then send HD Segment
        drvHD00_HealthCoverage = 'HD'
        ,drvHD01_MaintTypeCode = '030' --Audit or Compare
        ,drvHD02_MaintReasonCode = ''
        ,drvHD03_InsuranceLineCode = CASE WHEN BdmDedType IN ('MED') THEN 'HLT'
                                           WHEN BdmDedType IN ('DEN') THEN 'DEN'
                                           WHEN BdmDedType IN ('VIS') THEN 'VIS'
                                           ELSE ''
                                     END
        ,drvHD04_PlanCoverageDesc = CASE Bdmdedcode 
											WHEN 'DEN'  then '00030003TT'
											WHEN 'VIS'  then '00040004TT'
											WHEN 'PPO'  then '00010001TT'
											WHEN 'PPOS' then '00020002TT'
											WHEN 'HMO'  then '00050005TT'
										END

        ,drvHD05_CoverageLevelCode = 
                                                CASE WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EE')) THEN 'EMP'
                                                     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EE, EEDP')) THEN 'ESP'
                                                     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EEC')) THEN 'ECH'
                                                     WHEN BdmBenOption IN (SELECT * FROM dbo.dsi_BDM_fn_ListToTable('EEF,EEDPF')) THEN 'FAM'
                                                END
                                     
        -- If drvDTP00_DateTime_348 Populated, then send DTP*348 Segment
        ,drvDTP00_DateTime_348 = 'DTP'
        ,drvDTP01_DateTimeQualifier_348 = '348'
        ,drvDTP02_DateTimeFormatQual_348 = 'D8'
        ,drvDTP03_DateTimePeriod_348 = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, @FileMinCovDate) 
        -- If drvDTP00_DateTime_349 Populated, then send DTP*349 Segment
        ,drvDTP00_DateTime_349 = CASE WHEN BdmBenStopDate IS NOT NULL THEN 'DTP' END
        ,drvDTP01_DateTimeQualifier_349 = CASE WHEN BdmBenStopDate IS NOT NULL THEN '349' END
        ,drvDTP02_DateTimeFormatQual_349 = CASE WHEN BdmBenStopDate IS NOT NULL THEN 'D8' END
        ,drvDTP03_DateTimePeriod_349 = BdmBenStopDate 
        -- If drvDTP00_DateTime_303 = 'DTP', then Send DTP*303 Segment
        ,drvDTP00_DateTime_303 = ''
        ,drvDTP01_DateTimeQualifier_303 = ''--'303'
        ,drvDTP02_DateTimeFormatQual_303 = ''--'D8'
        ,drvDTP03_DateTimePeriod_303 = ''--dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStatusDate, @FileMinCovDate)
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
    INTO dbo.U_ENBTUHCMDV_DrvTbl_2300
    FROM dbo.U_ENBTUHCMDV_EELIST WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_ENBTUHCMDV WITH (NOLOCK)
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
    IF OBJECT_ID('U_ENBTUHCMDV_TrlTbl') IS NOT NULL
        DROP TABLE dbo.U_ENBTUHCMDV_TrlTbl;
    SELECT DISTINCT drvSE01_SegmentCount = '9999'
    INTO dbo.U_ENBTUHCMDV_TrlTbl;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable('ENBTUHCMDV','UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = 'NET1008_ENBTUHCMDV_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
        WHERE FormatCode = 'ENBTUHCMDV';
    END;

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwENBTUHCMDV_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_ENBTUHCMDV_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO

--Check out iAscDefF
SELECT * FROM dbo.iAscDefF
WHERE AdfHeaderSystemID LIKE 'ENBTUHCMDV%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET ExpLastStartPerControl = '201810011'
       ,ExpStartPerControl     = '201810011'
       ,ExpLastEndPerControl   = '201810019'
       ,ExpEndPerControl       = '201810019'
WHERE ExpFormatCode = 'ENBTUHCMDV';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwENBTUHCMDV_Export AS
    SELECT TOP 20000000 DATA FROM dbo.U_ENBTUHCMDV_File (NOLOCK)
    ORDER BY CASE LEFT(Recordset,1) WHEN 'H' THEN 1 WHEN 'D' THEN 2 ELSE 3 END, InitialSort, SubSort, RIGHT(Recordset,2)
GO