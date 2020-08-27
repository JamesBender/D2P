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
@CustomFormatCode - Replace with Format Code (i.e., ETIAACREF)
@CustomFormatName - Replace with Name of Interface (AdfFormatName) (i.e., TIAA-CREF Payroll Export)
@IsWebFlag - Replace with 'Y' (Yes) or 'N' (No) for Web Interface Settings

-- Data parameters
@PlanNumber - Enter the 6-Byte Plan Number assigned by TIAA

-- File parameters
@FileExportPath - Replace with the Export Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@TestFilePath - Replace with the Test Path where the Error Report generates to (i.e., \\us.saas\e1\Public\[Client ARNum]\Exports\[Vendor]\)
@UDESFilePath - Replace with the UDES Path where the Error Report generates to (i.e., \\us.saas\e0\data_exchange\[Client ARNum]\Exports\)

*/
SET NOCOUNT ON;
IF OBJECT_ID('dsi_vw@CustomFormatCode_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vw@CustomFormatCode_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_@CustomFormatCode') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode];
GO
IF OBJECT_ID('U_@CustomFormatCode_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PEarHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_PDedHist];
GO
IF OBJECT_ID('U_@CustomFormatCode_Members') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Members];
GO
IF OBJECT_ID('U_@CustomFormatCode_Header_00') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_Header_00];
GO
IF OBJECT_ID('U_@CustomFormatCode_File') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_File];
GO
IF OBJECT_ID('U_@CustomFormatCode_EmpDed') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EmpDed];
GO
IF OBJECT_ID('U_@CustomFormatCode_EEList') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_EEList];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl36') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl36];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl33') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl33];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl23') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl23];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl22') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl22];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl14') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl14];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl05') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl05];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl04') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl04];
GO
IF OBJECT_ID('U_@CustomFormatCode_DrvTbl01') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_DrvTbl01];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_99') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_99];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_98') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_98];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_88') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_88];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_55') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_55];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_40') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_40];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_39') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_39];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_38') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_38];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_37') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_37];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_36') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_36];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_33') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_33];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_23') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_23];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_22') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_22];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_17') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_17];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_14') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_14];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_11') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_11];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_10') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_10];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_09') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_09];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_08') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_08];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_07') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_07];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_06') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_06];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_05') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_05];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_04') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_04];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_02') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_02];
GO
IF OBJECT_ID('U_@CustomFormatCode_drvTbl_01') IS NOT NULL DROP TABLE [dbo].[U_@CustomFormatCode_drvTbl_01];
GO
IF OBJECT_ID('U_dsi_BDM_@CustomFormatCode') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_@CustomFormatCode];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_RecordSetDetails] FROM [dbo].[U_dsi_RecordSetDetails] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = '@CustomFormatCode';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = '@CustomFormatCode';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = '@CustomFormatCode';
GO

DECLARE @AdhSystemID VARCHAR(12), @FixedFormatName VARCHAR(50);
SET @AdhSystemID = LEFT('@CustomFormatCode' + REPLICATE('0',10),10) + 'Z0';
SET @FixedFormatName = LEFT('@CustomFormatName',50);

INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) SELECT 'N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','SDF','@CustomFormatCode',@FixedFormatName,'N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','160','N','S','N',@AdhSystemID,'N','Jan  1 1900 12:00AM','C','N';
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanNumber"','1','(''UA''=''F'')',@AdhSystemID,'6','H','01','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','H','01','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000000000"','3','(''DA''=''F'')',@AdhSystemID,'9','H','01','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00"','4','(''DA''=''F'')',@AdhSystemID,'2','H','01','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','11','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','11','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','11','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"01"','4','(''DA''=''F'')',@AdhSystemID,'2','D','11','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvName"','5','(''UA''=''F'')',@AdhSystemID,'30','D','11','20',NULL,'Name',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMaritalStatus"','6','(''UA''=''F'')',@AdhSystemID,'1','D','11','50',NULL,'Marital Status',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvGender"','7','(''UA''=''F'')',@AdhSystemID,'1','D','11','51',NULL,'Gender',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeID"','8','(''UA''=''F'')',@AdhSystemID,'13','D','11','52',NULL,'Employee ID',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTitle"','9','(''UA''=''F'')',@AdhSystemID,'5','D','11','65',NULL,'Title',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'1','D','11','70',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','12','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','12','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','12','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"02"','4','(''DA''=''F'')',@AdhSystemID,'2','D','12','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEMailAddress"','5','(''UA''=''F'')',@AdhSystemID,'50','D','12','20',NULL,'E-Mail Address',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDayPhone"','6','(''UA''=''F'')',@AdhSystemID,'10','D','12','70',NULL,'Day Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEveningPhone"','7','(''UA''=''F'')',@AdhSystemID,'10','D','12','80',NULL,'Evening Phone',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','12','90',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','14','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','14','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','14','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"04"','4','(''DA''=''F'')',@AdhSystemID,'2','D','14','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLineNumber"','5','(''UA''=''F'')',@AdhSystemID,'1','D','14','20',NULL,'Address Line Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine"','6','(''UA''=''F'')',@AdhSystemID,'40','D','14','21',NULL,'Address Line',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'1','D','14','61',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','15','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','15','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','15','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"05"','4','(''DA''=''F'')',@AdhSystemID,'2','D','15','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','5','(''UA''=''F'')',@AdhSystemID,'28','D','15','20',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','6','(''UA''=''F'')',@AdhSystemID,'3','D','15','48',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZip"','7','(''SS''=''F'')',@AdhSystemID,'9','D','15','51',NULL,'Zip +4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','15','60',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','16','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','16','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','16','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"06"','4','(''DA''=''F'')',@AdhSystemID,'2','D','16','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLineNumber"','5','(''UA''=''F'')',@AdhSystemID,'1','D','16','20',NULL,'Address Line Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine"','6','(''UA''=''F'')',@AdhSystemID,'40','D','16','21',NULL,'Address Line',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'1','D','16','61',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','17','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','17','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','17','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"07"','4','(''DA''=''F'')',@AdhSystemID,'2','D','17','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','5','(''UA''=''F'')',@AdhSystemID,'28','D','17','20',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','6','(''UA''=''F'')',@AdhSystemID,'3','D','17','48',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZip"','7','(''UA''=''F'')',@AdhSystemID,'9','D','17','51',NULL,'Zip +4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','17','60',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','18','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','18','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','18','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"08"','4','(''DA''=''F'')',@AdhSystemID,'2','D','18','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLineNumber"','5','(''UA''=''F'')',@AdhSystemID,'1','D','18','20',NULL,'Address Line Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAddressLine"','6','(''UA''=''F'')',@AdhSystemID,'40','D','18','21',NULL,'Address Line',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PT900"','7','(''DA''=''F'')',@AdhSystemID,'5','D','18','61',NULL,'Alternate Address Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','18','66',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','19','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','19','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','19','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"09"','4','(''DA''=''F'')',@AdhSystemID,'2','D','19','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCity"','5','(''UA''=''F'')',@AdhSystemID,'28','D','19','20',NULL,'City',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvState"','6','(''UA''=''F'')',@AdhSystemID,'3','D','19','48',NULL,'State',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvZip"','7','(''UA''=''F'')',@AdhSystemID,'9','D','19','51',NULL,'Zip +4',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"PT900"','8','(''DA''=''F'')',@AdhSystemID,'5','D','19','60',NULL,'Alternate Address Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','9','(''SS''=''F'')',@AdhSystemID,'1','D','19','65',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','20','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','20','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','20','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"10"','4','(''DA''=''F'')',@AdhSystemID,'2','D','20','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCountryCode"','5','(''UA''=''F'')',@AdhSystemID,'3','D','20','20',NULL,'Country Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'1','D','20','23',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','21','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','21','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','21','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"11"','4','(''DA''=''F'')',@AdhSystemID,'2','D','21','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivisionLocationCode"','5','(''UA''=''F'')',@AdhSystemID,'4','D','21','20',NULL,'Division/Location Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'1','D','21','24',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','24','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','24','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','24','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"14"','4','(''DA''=''F'')',@AdhSystemID,'2','D','24','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLoanNumber"','5','(''UA''=''F'')',@AdhSystemID,'13','D','24','20',NULL,'Loan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPaymentAmount * 100"','6','(''UN00''=''F'')',@AdhSystemID,'11','D','24','33',NULL,'Payment Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPaymentType"','7','(''UA''=''F'')',@AdhSystemID,'1','D','24','44',NULL,'Payment Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollFrequency"','8','(''UA''=''F'')',@AdhSystemID,'1','D','24','45',NULL,'Payroll Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDate"','9','(''UD112''=''F'')',@AdhSystemID,'8','D','24','46',NULL,'Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','27','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','27','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','27','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"17"','4','(''DA''=''F'')',@AdhSystemID,'2','D','27','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHighlyCompFlag"','5','(''UA''=''F'')',@AdhSystemID,'1','D','27','20',NULL,'Highly Comp Flag',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOwnership"','6','(''UA''=''F'')',@AdhSystemID,'1','D','27','21',NULL,'Ownership %',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOfficerIndicator"','7','(''UA''=''F'')',@AdhSystemID,'1','D','27','22',NULL,'Officer Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','27','23',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','32','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','32','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','32','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"22"','4','(''DA''=''F'')',@AdhSystemID,'2','D','32','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvStatusCode"','5','(''UA''=''F'')',@AdhSystemID,'2','D','32','20',NULL,'Status Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvReasonCode"','6','(''UA''=''F'')',@AdhSystemID,'2','D','32','22',NULL,'Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeeType"','7','(''UA''=''F'')',@AdhSystemID,'1','D','32','24',NULL,'Employee Type',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','8','(''SS''=''F'')',@AdhSystemID,'1','D','32','25',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvParticipantReasonCode"','9','(''UA''=''F'')',@AdhSystemID,'1','D','32','26',NULL,'Participant Reason Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmployeePlanStatusCode"','10','(''UA''=''F'')',@AdhSystemID,'1','D','32','27',NULL,'Employee Plan Status Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAltFICAOBRAParticipationID"','11','(''UA''=''F'')',@AdhSystemID,'1','D','32','28',NULL,'Alt FICA/OBRA participation indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'14','D','32','29',NULL,'A-Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0000000000000000"','13','(''DA''=''F'')',@AdhSystemID,'16','D','32','43',NULL,'B-Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','33','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','33','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','33','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"23"','4','(''DA''=''F'')',@AdhSystemID,'2','D','33','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofBirth"','5','(''UD112''=''F'')',@AdhSystemID,'8','D','33','20',NULL,'Date of Birth',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEmploymentDate"','6','(''UD112''=''F'')',@AdhSystemID,'8','D','33','28',NULL,'Employment Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanEntryDate"','7','(''UD112''=''F'')',@AdhSystemID,'8','D','33','36',NULL,'Plan Entry Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDisabilityDate"','8','(''UD112''=''F'')',@AdhSystemID,'8','D','33','44',NULL,'Disability Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvRehireDate"','9','(''UD112''=''F'')',@AdhSystemID,'8','D','33','52',NULL,'Rehire Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTerminationDate"','10','(''UD112''=''F'')',@AdhSystemID,'8','D','33','60',NULL,'Termination Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'1','D','33','68',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDateofDeath"','12','(''UD112''=''F'')',@AdhSystemID,'8','D','33','69',NULL,'Date of Death',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAdjDateofHire"','13','(''UD112''=''F'')',@AdhSystemID,'8','D','33','77',NULL,'Adj Date of Hire',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvLeaveofAbsencedate"','14','(''UD112''=''F'')',@AdhSystemID,'8','D','33','85',NULL,'Leave of Absence date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000000000000000000000000"','15','(''DA''=''F'')',@AdhSystemID,'24','D','33','93',NULL,'A-Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','43','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','43','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','43','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"33"','4','(''DA''=''F'')',@AdhSystemID,'2','D','43','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvMode"','5','(''UA''=''F'')',@AdhSystemID,'3','D','43','20',NULL,'Mode',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollFrequency"','6','(''UA''=''F'')',@AdhSystemID,'1','D','43','23',NULL,'Payroll Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDate"','7','(''UD112''=''F'')',@AdhSystemID,'8','D','43','24',NULL,'Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSource"','8','(''UA''=''F'')',@AdhSystemID,'1','D','43','32',NULL,'Source',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAmount * 100"','9','(''UN00''=''F'')',@AdhSystemID,'11','D','43','33',NULL,'Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSubPlan"','10','(''UA''=''F'')',@AdhSystemID,'3','D','43','44',NULL,'Sub Plan',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAutoEnrollment"','11','(''UA''=''F'')',@AdhSystemID,'1','D','43','47',NULL,'Auto Enrollment',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'9','D','43','48',NULL,'Filler A',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000000000"','13','(''DA''=''F'')',@AdhSystemID,'9','D','43','57',NULL,'Filler B',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','46','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','46','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','46','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"36"','4','(''DA''=''F'')',@AdhSystemID,'2','D','46','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayPeriodHours * 100"','5','(''UN00''=''F'')',@AdhSystemID,'7','D','46','20',NULL,'Pay Period Hours',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYTDHours * 100"','6','(''UN00''=''F'')',@AdhSystemID,'7','D','46','27',NULL,'YTD Hours',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollFrequency"','7','(''UA''=''F'')',@AdhSystemID,'1','D','46','34',NULL,'Payroll Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDate"','8','(''UD112''=''F'')',@AdhSystemID,'8','D','46','35',NULL,'Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00"','9','(''DA''=''F'')',@AdhSystemID,'2','D','46','43',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'3','D','46','45',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAlternateVestingDate"','11','(''UD112''=''F'')',@AdhSystemID,'8','D','46','48',NULL,'Alternate Vesting Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','12','(''SS''=''F'')',@AdhSystemID,'6','D','46','56',NULL,'Filler A',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVestingSource"','13','(''UA''=''F'')',@AdhSystemID,'1','D','46','62',NULL,'Vesting Source',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000"','14','(''DA''=''F'')',@AdhSystemID,'3','D','46','63',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYearsofService"','15','(''UA''=''F'')',@AdhSystemID,'2','D','46','66',NULL,'Years of Service',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvVestingPercent * 100"','16','(''UN00''=''F'')',@AdhSystemID,'4','D','46','68',NULL,'Vesting Percent',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000000"','17','(''DA''=''F'')',@AdhSystemID,'6','D','46','72',NULL,'Filler B',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','47','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','47','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','47','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"37"','4','(''DA''=''F'')',@AdhSystemID,'2','D','47','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOptOutWithdrawalFlag"','5','(''UA''=''F'')',@AdhSystemID,'1','D','47','20',NULL,'Opt Out – Withdrawal Flag',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'8','D','47','21',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvOptOutNotifyDate"','7','(''UD112''=''F'')',@AdhSystemID,'8','D','47','29',NULL,'Opt Out Notify Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInitialRothContribDate"','8','(''UD112''=''F'')',@AdhSystemID,'8','D','47','37',NULL,'Initial Roth Contribution Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvInitialRothContribSubPlan"','9','(''UA''=''F'')',@AdhSystemID,'3','D','47','45',NULL,'Initial Roth Contribution Sub Plan',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'89','D','47','48',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','48','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','48','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','48','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"38"','4','(''DA''=''F'')',@AdhSystemID,'2','D','48','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferralSource"','5','(''UA''=''F'')',@AdhSystemID,'1','D','48','20',NULL,'Deferral Source',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferralAmount * 100"','6','(''UN00''=''F'')',@AdhSystemID,'10','D','48','21',NULL,'Deferral Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferralPercentage * 100"','7','(''UN00''=''F'')',@AdhSystemID,'5','D','48','31',NULL,'Deferral Percentage',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00"','8','(''DA''=''F'')',@AdhSystemID,'2','D','48','36',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanAnnualSalary * 100"','9','(''UN00''=''F'')',@AdhSystemID,'10','D','48','38',NULL,'Plan Annual Salary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDate"','10','(''UD112''=''F'')',@AdhSystemID,'8','D','48','48',NULL,'Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'16','D','48','56',NULL,'A-Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"0000000000000000"','12','(''DA''=''F'')',@AdhSystemID,'16','D','48','72',NULL,'B-Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','49','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','49','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','49','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"39"','4','(''DA''=''F'')',@AdhSystemID,'2','D','49','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEligibilitySourceCode1"','5','(''UA''=''F'')',@AdhSystemID,'1','D','49','20',NULL,'Eligibility Source Code 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEligibilityDate1"','6','(''UD112''=''F'')',@AdhSystemID,'8','D','49','21',NULL,'Eligibility Date 1',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEligibilitySourceCode2"','7','(''UA''=''F'')',@AdhSystemID,'1','D','49','29',NULL,'Eligibility Source Code 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEligibilityDate2"','8','(''UD112''=''F'')',@AdhSystemID,'8','D','49','30',NULL,'Eligibility Date 2',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanEntryDate"','9','(''UD112''=''F'')',@AdhSystemID,'9','D','49','38',NULL,'Plan Entry Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','10','(''SS''=''F'')',@AdhSystemID,'3','D','49','47',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','11','(''SS''=''F'')',@AdhSystemID,'41','D','49','50',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','50','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','50','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','50','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"40"','4','(''DA''=''F'')',@AdhSystemID,'2','D','50','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAutoSaveEnrollmentID"','5','(''UA''=''F'')',@AdhSystemID,'1','D','50','20',NULL,'Auto Save Enrollment Indicator',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAutoSaveIncreaseOption"','6','(''UA''=''F'')',@AdhSystemID,'1','D','50','21',NULL,'Auto Save Increase Option',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAutoSaveIncreaseAmount * 100"','7','(''UN00''=''F'')',@AdhSystemID,'11','D','50','22',NULL,'Auto Save Increase Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAutoSaveIncreaseDate"','8','(''UD112''=''F'')',@AdhSystemID,'4','D','50','33',NULL,'Auto Save Increase Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDeferMaxFlag"','9','(''UA''=''F'')',@AdhSystemID,'1','D','50','37',NULL,'Defer Max Flag',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCurrentDeferralPercentage * 100"','10','(''UN00''=''F'')',@AdhSystemID,'11','D','50','38',NULL,'Current Deferral Percentage',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCurrentDeferralAmount * 100"','11','(''UN00''=''F'')',@AdhSystemID,'11','D','50','49',NULL,'Current Deferral Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTypeofEmployee"','12','(''UA''=''F'')',@AdhSystemID,'1','D','50','60',NULL,'Type of Employee',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvEffDateOfCurrentDeferral"','13','(''UD112''=''F'')',@AdhSystemID,'8','D','50','61',NULL,'Effective Date of Current Deferral',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAnnualSalary * 100"','14','(''UN00''=''F'')',@AdhSystemID,'11','D','50','69',NULL,'Annual Salary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAutoSaveEnrollmentDate"','15','(''UD112''=''F'')',@AdhSystemID,'8','D','50','80',NULL,'AutoSave Enrollment Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAutoSaveCancellationDate"','16','(''UD112''=''F'')',@AdhSystemID,'8','D','50','88',NULL,'Auto Save Cancellation Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollCycle"','17','(''UA''=''F'')',@AdhSystemID,'1','D','50','96',NULL,'Payroll Cycle',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','18','(''SS''=''F'')',@AdhSystemID,'50','D','50','97',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','65','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','65','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','65','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"55"','4','(''DA''=''F'')',@AdhSystemID,'2','D','65','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayPeriodCompensation * 100"','5','(''UN00''=''F'')',@AdhSystemID,'15','D','65','20',NULL,'Pay Period Compensation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYTDGrossCompensation * 100"','6','(''UN00''=''F'')',@AdhSystemID,'15','D','65','35',NULL,'YTD Gross Compensation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPlanCompensation * 100"','7','(''UN00''=''F'')',@AdhSystemID,'15','D','65','50',NULL,'Plan Compensation',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollFrequency"','8','(''UA''=''F'')',@AdhSystemID,'1','D','65','65',NULL,'Payroll Frequency',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvPayrollDate"','9','(''UD112''=''F'')',@AdhSystemID,'8','D','65','66',NULL,'Payroll Date',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvAnnualSalary * 100"','10','(''UN00''=''F'')',@AdhSystemID,'11','D','65','74',NULL,'Annual Salary',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvCashBonus * 100"','11','(''UN00''=''F'')',@AdhSystemID,'11','D','65','85',NULL,'Cash Bonus',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYTDBaseCompensationAmt * 100"','12','(''UN00''=''F'')',@AdhSystemID,'11','D','65','96',NULL,'YTD Base Compensation Amt',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvHRSubArea"','13','(''UA''=''F'')',@AdhSystemID,'10','D','65','107',NULL,'HR Sub Area',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','14','(''SS''=''F'')',@AdhSystemID,'1','D','65','117',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"00000000000"','15','(''DA''=''F'')',@AdhSystemID,'11','D','65','118',NULL,'Employee Match Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','16','(''SS''=''F'')',@AdhSystemID,'32','D','65','129',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','80','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','80','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"000000000"','3','(''DA''=''F'')',@AdhSystemID,'9','D','80','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"88"','4','(''DA''=''F'')',@AdhSystemID,'2','D','80','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotalContributionRecCount * 100"','5','(''UN00''=''F'')',@AdhSystemID,'9','D','80','20',NULL,'Total Contribution record count',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvTotalContributionAmount * 100"','6','(''UN00''=''F'')',@AdhSystemID,'13','D','80','29',NULL,'Total Contribution Amount',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','7','(''SS''=''F'')',@AdhSystemID,'100','D','80','42',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','81','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','81','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','81','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"98"','4','(''DA''=''F'')',@AdhSystemID,'2','D','81','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvDivLocCode"','5','(''UA''=''F'')',@AdhSystemID,'4','D','81','20',NULL,'Div/Loc Code',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','6','(''SS''=''F'')',@AdhSystemID,'137','D','81','24',NULL,'Filler',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"@PlanNumber"','1','(''DA''=''F'')',@AdhSystemID,'6','D','82','1',NULL,'Plan Number',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '""','2','(''SS''=''F'')',@AdhSystemID,'2','D','82','7',NULL,'Reserved',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvSSN"','3','(''UA''=''F'')',@AdhSystemID,'9','D','82','9',NULL,'SSN',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"99"','4','(''DA''=''F'')',@AdhSystemID,'2','D','82','18',NULL,'Record Identifier',NULL,NULL;
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) SELECT '"drvYearsofService"','5','(''UA''=''F'')',@AdhSystemID,'5','D','82','20',NULL,'Years of Service',NULL,NULL;
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TIAA-CREF Export','201707259','EMPEXPORT','ONDEMAND',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707259','Jul 25 2017  9:27AM','Jul 25 2017  9:27AM','201707251',NULL,'','','201707251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201707259','EMPEXPORT','OEACTIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707259','Jul 25 2017  9:27AM','Jul 25 2017  9:27AM','201707251',NULL,'','','201707251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201707259','EMPEXPORT','OEPASSIVE',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707259','Jul 25 2017  9:27AM','Jul 25 2017  9:27AM','201707251',NULL,'','','201707251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('File Name is Auto Generated',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201707259','EMPEXPORT','TEST',NULL,'@CustomFormatCode',NULL,NULL,NULL,'201707259','Jul 25 2017  9:27AM','Jul 25 2017  9:27AM','201707251',NULL,'','','201707251',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','ExportPath','V','@FileExportPath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','TestPath','V','@TestFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UDESPath','V','@UDESFilePath');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('@CustomFormatCode','UseFileName','V','N');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','H01','dbo.U_@CustomFormatCode_Header_00','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D11','dbo.U_@CustomFormatCode_drvTbl_01','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D12','dbo.U_@CustomFormatCode_drvTbl_02','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D14','dbo.U_@CustomFormatCode_drvTbl_04','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D15','dbo.U_@CustomFormatCode_drvTbl_05','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D16','dbo.U_@CustomFormatCode_drvTbl_06','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D17','dbo.U_@CustomFormatCode_drvTbl_07','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D18','dbo.U_@CustomFormatCode_drvTbl_08','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D19','dbo.U_@CustomFormatCode_drvTbl_09','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D20','dbo.U_@CustomFormatCode_drvTbl_10','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D21','dbo.U_@CustomFormatCode_drvTbl_11','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D24','dbo.U_@CustomFormatCode_drvTbl_14','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D27','dbo.U_@CustomFormatCode_drvTbl_17','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D32','dbo.U_@CustomFormatCode_drvTbl_22','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D33','dbo.U_@CustomFormatCode_drvTbl_23','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D43','dbo.U_@CustomFormatCode_drvTbl_33','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D46','dbo.U_@CustomFormatCode_drvTbl_36','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D47','dbo.U_@CustomFormatCode_drvTbl_37','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D48','dbo.U_@CustomFormatCode_drvTbl_38','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D49','dbo.U_@CustomFormatCode_drvTbl_39','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D50','dbo.U_@CustomFormatCode_drvTbl_40','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D65','dbo.U_@CustomFormatCode_drvTbl_55','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D80','dbo.U_@CustomFormatCode_drvTbl_88','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D81','dbo.U_@CustomFormatCode_drvTbl_98','drvSendRecord = ''Y''');
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('@CustomFormatCode','D82','dbo.U_@CustomFormatCode_drvTbl_99','drvSendRecord = ''Y''');
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
    [Data] char(160) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_@CustomFormatCode]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: @ClientName

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
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = '@CustomFormatCode';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = '@CustomFormatCode' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 '@CustomFormatCode', 'OEPASSIVE';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = '@CustomFormatCode', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = '@CustomFormatCode';

    -- Declare dates from Parameter file
    SELECT
         @StartPerControl = StartPerControl
        ,@EndPerControl   = EndPerControl
        ,@StartDate       = LEFT(StartPerControl,8)
        ,@EndDate         = DATEADD(S,-1,DATEADD(D,1,LEFT(EndPerControl,8)))
        ,@ExportCode      = ExportCode
    FROM dbo.U_dsi_Parameters WITH (NOLOCK)
    WHERE FormatCode = @FormatCode;

    --==========================================
    -- Clean EE List 
    -- Caution: Careful of cleaning EE List if including paycheck data
    --==========================================

    -- Cleans EE List of terms where EE active in another company (transfer), or active in more than one company
    DELETE FROM dbo.U_@CustomFormatCode_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_@CustomFormatCode_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes','<enter deduction codes>');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');

    -- Non-Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');

    -- Required OE parameters
    IF @ExportCode LIKE '%PASSIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','PASSIVE');
    END;

    IF @ExportCode LIKE '%ACTIVE'
    BEGIN
        INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'OEType','ACTIVE');
    END;

    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    ------------------------------------------------------
    -- Working Table - Employee and Benefit Information
    ------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Members','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Members;
    SELECT xEEID
        ,xCOID
        ,EepSSN
        ,EepNameFirst
        ,EepNameMiddle
        ,EepNameLast
        ,EepNameSuffix = NULLIF(EepNameSuffix,'Z')
        ,EepMaritalStatus
        ,EepGender
        ,EepAddressLine1
        ,EepAddressLine2
        ,EepAddressLine3
        ,EepAddressCity
        ,EepAddressState
        ,EepAddressZipCode
        ,EepAddressCountry
        ,EepAddressEmail
        ,EepPhoneHomeNumber
        ,EepDateOfBirth
        ,EepDateDeceased
        ,EecEmpNo
        ,EecJobTitle
        ,EecPhoneBusinessNumber
        ,EecOrgLvl1
        ,EecOrgLvl2
        ,EecOrgLvl3
        ,EecOrgLvl4
        ,EecLocation
        ,EecPayPeriod
        ,EecIsHighlyComp
        ,EecIsKeyEmployee
        ,EecSUIIsOfficer
        ,EecEmplStatus
        ,EecTermReason
        ,EecLeaveReason
        ,EecDateOfOriginalHire
        ,EecDateOfLastHire
        ,EecDateOfTermination
        ,EecEmplStatusStartDate
        ,EecAnnSalary
        ,EecFullTimeOrPartTime
        ,TchType
        ,BdmBenStartDate = (SELECT MIN(BdmBenStartDate) FROM dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmCOID = xCOID)
    INTO dbo.U_@CustomFormatCode_Members
    FROM dbo.U_@CustomFormatCode_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.TrmReasn WITH (NOLOCK)
        ON TchCode = EecTermReason
	WHERE EXISTS (SELECT 1 FROM dbo.U_dsi_BDM_@CustomFormatCode WITH (NOLOCK) WHERE BdmEEID = xEEID AND BdmCOID = xCOID);

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhPayDate = MAX(PdhPayDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        ,PdhSource = CASE WHEN PdhDedCode IN ('401K') THEN 'E' --E = Employee Pre-tax
                          WHEN PdhDedCode IN ('ROTH') THEN '2' --2 = Roth
                          WHEN PdhERCurAmt > 0.00 THEN 'F' --F = Employer
                     END
    INTO dbo.U_@CustomFormatCode_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhDedCode IN ('401K','ROTH')
    GROUP BY PdhEEID
        ,CASE WHEN PdhDedCode IN ('401K') THEN 'E' --E = Employee Pre-tax
              WHEN PdhDedCode IN ('ROTH') THEN '2' --2 = Roth
              WHEN PdhERCurAmt > 0.00 THEN 'F' --F = Employer
        END
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_@CustomFormatCode_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PehPayDate             = MAX(PehPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y'THEN PehCurHrs END)
    INTO dbo.U_@CustomFormatCode_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;

    --==========================================
    -- Build Driver Tables
    --==========================================

    -------------------------------------------------------
    -- Header Record - Record Type 00: Test Header Record
    -------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_Header_00','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_Header_00;
    SELECT DISTINCT
          drvSendRecord = CASE -- Y = Yes | N = No
                               WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Y' 
                               WHEN @ExportCode = 'TEST' THEN 'Y' 
                               ELSE 'N'
                          END
         ,drvPlanNumber = '@PlanNumber'
    INTO dbo.U_@CustomFormatCode_Header_00;

    ------------------------------------------------------------------
    -- Detail Record - Record Type 01: Participant Name (Required)
    ------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_01','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_01;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'Y' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvName = RTRIM(EepNameLast) + ',' + LTRIM(RTRIM(EepNameFirst)) + SPACE(1) + LEFT(EepNameMiddle,1)
        ,drvMaritalStatus = CASE EepMaritalStatus
                                 WHEN 'S' THEN '1' --Single
                                 WHEN 'M' THEN '2' --Married
                                 ELSE '0' --Unknown
                            END
        ,drvGender = CASE EepGender
                          WHEN 'M' THEN '1' --Male
                          WHEN 'F' THEN '2' --Female
                     END
        ,drvEmployeeID = EecEmpNo
        ,drvTitle = EepNameSuffix
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '01'
    INTO dbo.U_@CustomFormatCode_drvTbl_01
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    -----------------------------------------------------------------------
    -- Detail Record - Record Type 02: Participant Contact Information
    -----------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_02','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_02;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEMailAddress = EepAddressEMail
        ,drvDayPhone = EecPhoneBusinessNumber
        ,drvEveningPhone = EepPhoneHomeNumber
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '02'
    INTO dbo.U_@CustomFormatCode_drvTbl_02
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ---------------------------------
    -- Detail Record - Record Type 04: Participant Resident Address (Required)
    ---------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_04','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_04;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'Y' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvAddressLineNumber = ''
        ,drvAddressLine = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '04'
    INTO dbo.U_@CustomFormatCode_drvTbl_04
    FROM (-- Get Address Lines# 1 - 3
        SELECT xEEID, xCOID, EepSSN
            ,AddressLineNumber = '1'
            ,AddressLine = EepAddressLine1
        FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK)
        WHERE NULLIF(EepAddressLine1,'') IS NOT NULL

        UNION ALL

        SELECT xEEID, xCOID, EepSSN
            ,AddressLineNumber = '2'
            ,AddressLine = EepAddressLine2
        FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK)
        WHERE NULLIF(EepAddressLine2,'') IS NOT NULL

        UNION ALL

        SELECT xEEID, xCOID, EepSSN
            ,AddressLineNumber = '3'
            ,AddressLine = EepAddressLine3
        FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK)
        WHERE NULLIF(EepAddressLine3,'') IS NOT NULL
    ) Members;

    ------------------------------------------------------------------------------------------
    -- Detail Record - Record Type 05: Participant Resident City, State and Zip (Required)
    ------------------------------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_05','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_05;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'Y' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCity = EepAddressCity
        ,drvState = CASE WHEN EepAddressCountry = 'CAN' THEN 'CN' --Canadian Address
                         WHEN EepAddressCountry <> 'USA' THEN 'FN' --Foreign Address
                         ELSE EepAddressState
                    END
        ,drvZip = CASE WHEN EepAddressCountry = 'CAN' THEN 'CANAD' --Canadian Address
                       WHEN EepAddressCountry <> 'USA' THEN 'FORGN' --Foreign Address
                       ELSE EepAddressZipCode
                  END
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '05'
    INTO dbo.U_@CustomFormatCode_drvTbl_05
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ------------------------------------------------------------------
    -- Detail Record - Record Type 06: Participant Mailing Address
    ------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_06','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_06;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvAddressLineNumber = ''
        ,drvAddressLine = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '06'
    INTO dbo.U_@CustomFormatCode_drvTbl_06
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    -------------------------------------------------------------------------------
    -- Detail Record - Record Type 07: Participant Mailing City, State and Zip
    -------------------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_07','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_07;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCity = ''
        ,drvState = ''
        ,drvZip = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '07'
    INTO dbo.U_@CustomFormatCode_drvTbl_07
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    --------------------------------------------------------
    -- Detail Record - Record Type 08: Alternate Address
    --------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_08','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_08;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvAddressLineNumber = ''
        ,drvAddressLine = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '08'
    INTO dbo.U_@CustomFormatCode_drvTbl_08
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    -------------------------------------------------------------------
    -- Detail Record - Record Type 09: Alternate City, State and Zip
    -------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_09','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_09;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCity = ''
        ,drvState = ''
        ,drvZip = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '09'
    INTO dbo.U_@CustomFormatCode_drvTbl_09
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    -------------------------------------------------------
    -- Detail Record - Record Type 10: Foreign Country
    -------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_10','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_10;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvCountryCode = cicCountryISOCode
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '10'
    INTO dbo.U_@CustomFormatCode_drvTbl_10
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK)
    JOIN [ULTIPRO_SYSTEM].[dbo].[CountryISOCode] WITH (NOLOCK)
        ON cicCountryCode = EepAddressCountry
    WHERE EepAddressCountry <> 'USA';

    --------------------------------------------------------
    -- Detail Record - Record Type 11: Division/Location
    --------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_11','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_11;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDivisionLocationCode = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '11'
    INTO dbo.U_@CustomFormatCode_drvTbl_11
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ------------------------------------------------------
    -- Detail Record - Record Type 14: Loan Repayments
    ------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_14','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_14;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvLoanNumber = ''
        ,drvPaymentAmount = NULL
        ,drvPaymentType = ''
        ,drvPayrollFrequency = ''
        ,drvPayrollDate = NULL
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '14'
    INTO dbo.U_@CustomFormatCode_drvTbl_14
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    -------------------------------------------------------------------
    -- Detail Record - Record Type 17: Compliance Testing Indicators
    -------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_17','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_17;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvHighlyCompFlag = EecIsHighlyComp
        ,drvOwnership = EecIsKeyEmployee
        ,drvOfficerIndicator = EecSUIIsOfficer
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '17'
    INTO dbo.U_@CustomFormatCode_drvTbl_17
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ---------------------------------------------------------------------------
    -- Detail Record - Record Type 22: Participant Employment Status Codes
    ---------------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_22','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_22;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvStatusCode = EecEmplStatus
        ,drvReasonCode = CASE WHEN EecTermReason = '202' THEN '51' --“51” = Retirement
                              WHEN EecTermReason = '203' THEN '56' --“56” = Death
                              WHEN EecTermReason IN ('204','205','206','207') THEN '57' --“57” = With Cause
                              WHEN TchType = 'V' THEN '52' --“52” = Voluntary
                              WHEN TchType = 'I' THEN '53' --“53” = Laid Off
                         END
        ,drvEmployeeType = CASE WHEN EecEmplStatus = 'T' THEN '9' --“9” = Inactive
                                WHEN EecFullTimeOrPartTime = 'F' THEN '1' --“1” = Full Time
                                WHEN EecFullTimeOrPartTime = 'P' THEN '2' --“2” = Part Time
                           END
        ,drvParticipantReasonCode = ''
        ,drvEmployeePlanStatusCode = 'P' --“P” – Eligible and participating (self-elected)
        ,drvAltFICAOBRAParticipationID = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '22'
    INTO dbo.U_@CustomFormatCode_drvTbl_22
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ------------------------------------------------------------------
    -- Detail Record - Record Type 23: Participant Dates (Required)
    ------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_23','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_23;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'Y' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDateofBirth = EepDateOfBirth
        ,drvEmploymentDate = EecDateOfOriginalHire
        ,drvPlanEntryDate = BdmBenStartDate
        ,drvDisabilityDate = NULL
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <> EecDateOfLastHire THEN EecDateOfLastHire END
        ,drvTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvDateofDeath = EepDateDeceased
        ,drvAdjDateofHire = EecDateOfLastHire
        ,drvLeaveofAbsencedate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '23'
    INTO dbo.U_@CustomFormatCode_drvTbl_23
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ---------------------------------------------------------------
    -- Detail Record - Record Type 33: Contributions (Required)
    ---------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_33','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_33;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'Y' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvMode = ''
        ,drvPayrollFrequency = CASE EecPayPeriod
                                    WHEN 'M' THEN '4' --“4” = Monthly
                                    WHEN 'S' THEN '5' --“5” = Semi-Monthly
                                    WHEN 'B' THEN '6' --“6” = Bi-Weekly
                                    WHEN 'W' THEN '7' --“7” = Weekly
                               END
        ,drvPayrollDate = PdhPayDate
        ,drvSource = PdhSource
        ,drvAmount = PdhEECurAmt
        ,drvSubPlan = ''
        ,drvAutoEnrollment = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '33'
    INTO dbo.U_@CustomFormatCode_drvTbl_33
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_PDedHist WITH (NOLOCK)
        ON PdhEEID = xEEID;

    -------------------------------------------------------------------------------------------------
    -- Detail Record - Record Type 36: Vesting – Used to allow Omni OmniPlus to calculate Vesting
    -------------------------------------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_36','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_36;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvPayPeriodHours = PehCurHrs
        ,drvYTDHours = PehCurHrsYTD
        ,drvPayrollFrequency = CASE EecPayPeriod
                                    WHEN 'M' THEN '4' --“4” = Monthly
                                    WHEN 'S' THEN '5' --“5” = Semi-Monthly
                                    WHEN 'B' THEN '6' --“6” = Bi-Weekly
                                    WHEN 'W' THEN '7' --“7” = Weekly
                               END
        ,drvPayrollDate = PehPayDate
        ,drvAlternateVestingDate = NULL
        ,drvVestingSource = ''
        ,drvYearsofService = ''
        ,drvVestingPercent = NULL
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '36'
    INTO dbo.U_@CustomFormatCode_drvTbl_36
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_PEarHist WITH (NOLOCK)
        ON PehEEID = xEEID;

    ----------------------------------------------------
    -- Detail Record - Record Type 37: Process Record
    ----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_37','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_37;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvOptOutWithdrawalFlag = ''
        ,drvOptOutNotifyDate = NULL
        ,drvInitialRothContribDate = NULL
        ,drvInitialRothContribSubPlan = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '37'
    INTO dbo.U_@CustomFormatCode_drvTbl_37
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ----------------------------------------------------
    -- Detail Record - Record Type 38: Deferral Data
    ----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_38','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_38;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDeferralSource = ''
        ,drvDeferralAmount = NULL
        ,drvDeferralPercentage = NULL
        ,drvPlanAnnualSalary = EecAnnSalary
        ,drvPayrollDate = NULL
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '38'
    INTO dbo.U_@CustomFormatCode_drvTbl_38
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    -----------------------------------------------------
    -- Detail Record - Record Type 39: Eligibilty Data
    -----------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_39','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_39;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEligibilitySourceCode1 = ''
        ,drvEligibilityDate1 = NULL
        ,drvEligibilitySourceCode2 = ''
        ,drvEligibilityDate2 = NULL
        ,drvPlanEntryDate = NULL
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '39'
    INTO dbo.U_@CustomFormatCode_drvTbl_39
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    ----------------------------------------------
    -- Detail Record - Record Type 40: AutoSave
    ----------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_40','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_40;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvAutoSaveEnrollmentID = ''
        ,drvAutoSaveIncreaseOption = ''
        ,drvAutoSaveIncreaseAmount = NULL
        ,drvAutoSaveIncreaseDate = NULL
        ,drvDeferMaxFlag = ''
        ,drvCurrentDeferralPercentage = NULL
        ,drvCurrentDeferralAmount = NULL
        ,drvTypeofEmployee = ''
        ,drvEffDateOfCurrentDeferral = ''
        ,drvAnnualSalary = EecAnnSalary
        ,drvAutoSaveEnrollmentDate = NULL
        ,drvAutoSaveCancellationDate = NULL
        ,drvPayrollCycle = CASE EecPayPeriod
                                WHEN 'M' THEN '4' --Monthly
                                WHEN 'S' THEN '5' --Semi Monthly
                                WHEN 'B' THEN '6' --Bi Weekly
                                WHEN 'W' THEN '7' --Weekly
                           END
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '40'
    INTO dbo.U_@CustomFormatCode_drvTbl_40
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    --------------------------------------------------------------------------------------------------------------
    -- Detail Record - Record Type 55: Compensation as related to Vesting calculations and contribution limits
    --------------------------------------------------------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_55','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_55;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvPayPeriodCompensation = PehCurAmt
        ,drvYTDGrossCompensation = PehCurAmtYTD
        ,drvPlanCompensation = PehInclInDefCompYTD
        ,drvPayrollFrequency = CASE EecPayPeriod
                                    WHEN 'M' THEN '4' --“4” = Monthly
                                    WHEN 'S' THEN '5' --“5” = Semi-Monthly
                                    WHEN 'B' THEN '6' --“6” = Bi-Weekly
                                    WHEN 'W' THEN '7' --“7” = Weekly
                               END
        ,drvPayrollDate = PehPayDate
        ,drvAnnualSalary = EecAnnSalary
        ,drvCashBonus = NULL
        ,drvYTDBaseCompensationAmt = PehInclInDefCompYTD
        ,drvHRSubArea = ''
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '55'
    INTO dbo.U_@CustomFormatCode_drvTbl_55
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK)
    JOIN dbo.U_@CustomFormatCode_PEarHist WITH (NOLOCK)
        ON PehEEId = xEEID;

    ---------------------------------------------------------
    -- Detail Record - Record Type 88: Confirmation Record
    ---------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_88','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_88;
    SELECT DISTINCT
         drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvTotalContributionRecCount = COUNT(*)
        ,drvTotalContributionAmount = SUM(drvAmount)
        ,drvInitialSort
        ,drvSubSort = '88'
    INTO dbo.U_@CustomFormatCode_drvTbl_88
    FROM dbo.U_@CustomFormatCode_drvTbl_33 WITH (NOLOCK)
    GROUP BY drvInitialSort;

    --------------------------------------------------------
    -- Detail Record - Record Type 98: Seed File Record
    --------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_98','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_98;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvDivLocCode = EecLocation
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '98'
    INTO dbo.U_@CustomFormatCode_drvTbl_98
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    -------------------------------------------------------------
    -- Detail Record - Record Type 99: Initial Service Record
    -------------------------------------------------------------
    IF OBJECT_ID('U_@CustomFormatCode_drvTbl_99','U') IS NOT NULL
        DROP TABLE dbo.U_@CustomFormatCode_drvTbl_99;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvSendRecord = 'N' -- Y = Yes | N = No
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvYearsofService = DATEDIFF(YEAR,EecDateOfLastHire,@EndDate)
        ,drvInitialSort = RTRIM(EepSSN)
        ,drvSubSort = '99'
    INTO dbo.U_@CustomFormatCode_drvTbl_99
    FROM dbo.U_@CustomFormatCode_Members WITH (NOLOCK);

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'TEST_@PlanNumber_' + CONVERT(VARCHAR(8),GETDATE(),112) + 'A.TST'
                                  ELSE '@PlanNumber_' + CONVERT(VARCHAR(8),GETDATE(),112) + 'A.TXT'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE '@CustomFormatCode%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201707141'
       ,expStartPerControl     = '201707141'
       ,expLastEndPerControl   = '201707219'
       ,expEndPerControl       = '201707219'
WHERE expFormatCode = '@CustomFormatCode';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vw@CustomFormatCode_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_@CustomFormatCode_File (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;