SET NOCOUNT ON;
IF OBJECT_ID('U_EYCFHISEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EYCFHISEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EYCFHISEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEYCFHISEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEYCFHISEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EYCFHISEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EYCFHISEXP];
GO
IF OBJECT_ID('U_EYCFHISEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_PEarHist];
GO
IF OBJECT_ID('U_EYCFHISEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_PDedHist];
GO
IF OBJECT_ID('U_EYCFHISEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_File];
GO
IF OBJECT_ID('U_EYCFHISEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_EEList];
GO
IF OBJECT_ID('U_EYCFHISEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_drvTbl];
GO
IF OBJECT_ID('U_EYCFHISEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EYCFHISEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EYCFHISEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EYCFHISEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EYCFHISEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EYCFHISEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EYCFHISEXP','Careworks FMLA Historical Data','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EYCFHISEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','2','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','3','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','4','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employer"','5','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','5',NULL,'Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Case Open Date"','6','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','6',NULL,'Case Open Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Case Closed Date"','7','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','7',NULL,'Case Closed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Case Status"','8','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','8',NULL,'Case Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Status Date"','9','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','9',NULL,'Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Work Related"','10','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','10',NULL,'Work Related',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Absence Event Start"','11','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','11',NULL,'Absence Event Start',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Absence Event End"','12','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','12',NULL,'Absence Event End',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Est RTW Date"','13','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','13',NULL,'Est RTW Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"* Actual RTW Date"','14','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','14',NULL,'Actual RTW Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Request Start"','15','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','15',NULL,'Benefit Request Start',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Benefit Request End"','16','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','16',NULL,'Benefit Request End',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave Status"','17','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','17',NULL,'Leave Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave Status Reason"','18','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','18',NULL,'Leave Status Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave Status Date"','19','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','19',NULL,'Leave Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Policy Name"','20','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','20',NULL,'Policy Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave Type"','21','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','21',NULL,'Leave Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave Reason"','22','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','22',NULL,'Leave Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"* Leave Relationship"','23','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','23',NULL,'Leave Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave Start Date"','24','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','24',NULL,'Leave Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave End Date"','25','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','25',NULL,'Leave End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Utilization Start Date"','26','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','26',NULL,'Utilization Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Utilization End Date"','27','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','27',NULL,'Utilization End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Leave Date"','28','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','28',NULL,'Leave Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hours Used"','29','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','29',NULL,'Hours Used',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Monday Hours"','30','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','30',NULL,'Monday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Tuesday Hours"','31','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','31',NULL,'Tuesday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Wednesday Hours"','32','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','32',NULL,'Wednesday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Thursday Hours"','33','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','33',NULL,'Thursday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Friday Hours"','34','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','34',NULL,'Friday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Saturday Hours"','35','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','35',NULL,'Saturday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sunday Hours"','36','(''DA''=''T,'')','EYCFHISEXPZ0','50','H','01','36',NULL,'Sunday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Comments"','37','(''DA''=''T'')','EYCFHISEXPZ0','50','H','01','37',NULL,'Comments',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','2','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','2',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','3','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','3',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleName"','4','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','4',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployer"','5','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','5',NULL,'Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaseOpenDate"','6','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','6',NULL,'Case Open Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaseCloseDate"','7','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','7',NULL,'Case Closed Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCaseStatus"','8','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','8',NULL,'Case Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusDate"','9','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','9',NULL,'Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkRelated"','10','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','10',NULL,'Work Related',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAbsenceEvenStartDate"','11','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','11',NULL,'Absence Event Start',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAbsenceEvenceEndDate"','12','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','12',NULL,'Absence Event End',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drEstRtwDate"','13','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','13',NULL,'Est RTW Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvActualRTWDate"','14','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','14',NULL,'Actual RTW Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRequestStartDate"','15','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','15',NULL,'Benefit Request Start',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRequestEndDate"','16','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','16',NULL,'Benefit Request End',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveStatus"','17','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','17',NULL,'Leave Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveStatusReason"','18','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','18',NULL,'Leave Status Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveStatusDate"','19','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','19',NULL,'Leave Status Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPolicyName"','20','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','20',NULL,'Policy Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveType"','21','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','21',NULL,'Leave Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveReason"','22','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','22',NULL,'Leave Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveRelationship"','23','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','23',NULL,'Leave Relationship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveStartDate"','24','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','24',NULL,'Leave Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveEndDate"','25','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','25',NULL,'Leave End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUtilizationStartDate"','26','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','26',NULL,'Utilization Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUtilizationEndDate"','27','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','27',NULL,'Utilization End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLeaveDate"','28','(''UD101''=''T,'')','EYCFHISEXPZ0','50','D','10','28',NULL,'Leave Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursUsed"','29','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','29',NULL,'Hours Used',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMonday"','30','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','30',NULL,'Monday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTuesday"','31','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','31',NULL,'Tuesday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWednesday"','32','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','32',NULL,'Wednesday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvThursday"','33','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','33',NULL,'Thursday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFridayHours"','34','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','34',NULL,'Friday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSaturdayHours"','35','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','35',NULL,'Saturday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSundayHours"','36','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','36',NULL,'Sunday Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvComments"','37','(''UA''=''T,'')','EYCFHISEXPZ0','50','D','10','37',NULL,'Comments',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EYCFHISEXP_20191029.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Test Purposes Only','201910289','EMPEXPORT','TEST','Oct 29 2019 11:47AM','EYCFHISEXP',NULL,NULL,NULL,'201910289','Oct 28 2019 12:00AM','Dec 30 1899 12:00AM','201910281','11143','','','201910281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EYCFHISEXP_20191029.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Careworks FMLA Historical Data','201910289','EMPEXPORT','ONDEMAND','Oct 28 2019  3:55PM','EYCFHISEXP',NULL,NULL,NULL,'201910289','Oct 28 2019 12:00AM','Dec 30 1899 12:00AM','201910281','110','','','201910281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EYCFHISEXP_20191029.txt' END WHERE expFormatCode = 'EYCFHISEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYCFHISEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYCFHISEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYCFHISEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EYCFHISEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EYCFHISEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EYCFHISEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EYCFHISEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EYCFHISEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EYCFHISEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EYCFHISEXP','D10','dbo.U_EYCFHISEXP_drvTbl',NULL);
IF OBJECT_ID('U_EYCFHISEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EYCFHISEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EYCFHISEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EYCFHISEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvLastName] varchar(100) NULL,
    [drvMiddleName] varchar(100) NULL,
    [drvEmployer] varchar(40) NULL,
    [drvCaseOpenDate] datetime NULL,
    [drvCaseCloseDate] datetime NULL,
    [drvCaseStatus] varchar(1) NOT NULL,
    [drvStatusDate] varchar(1) NOT NULL,
    [drvWorkRelated] varchar(1) NOT NULL,
    [drvAbsenceEvenStartDate] datetime NULL,
    [drvAbsenceEvenceEndDate] datetime NULL,
    [drEstRtwDate] varchar(1) NOT NULL,
    [drvActualRTWDate] datetime NULL,
    [drvBenRequestStartDate] datetime NULL,
    [drvBenRequestEndDate] datetime NULL,
    [drvLeaveStatus] varchar(1) NOT NULL,
    [drvLeaveStatusReason] varchar(1) NOT NULL,
    [drvLeaveStatusDate] datetime NULL,
    [drvPolicyName] varchar(1) NOT NULL,
    [drvLeaveType] varchar(1) NOT NULL,
    [drvLeaveReason] varchar(1) NOT NULL,
    [drvLeaveRelationship] varchar(1) NOT NULL,
    [drvLeaveStartDate] datetime NULL,
    [drvLeaveEndDate] datetime NULL,
    [drvUtilizationStartDate] datetime NULL,
    [drvUtilizationEndDate] datetime NULL,
    [drvLeaveDate] datetime NULL,
    [drvHoursUsed] varchar(1) NOT NULL,
    [drvMonday] varchar(1) NOT NULL,
    [drvTuesday] varchar(1) NOT NULL,
    [drvWednesday] varchar(1) NOT NULL,
    [drvThursday] varchar(1) NOT NULL,
    [drvFridayHours] varchar(1) NOT NULL,
    [drvSaturdayHours] varchar(1) NOT NULL,
    [drvSundayHours] varchar(1) NOT NULL,
    [drvComments] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EYCFHISEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EYCFHISEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EYCFHISEXP_File') IS NULL
CREATE TABLE [dbo].[U_EYCFHISEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EYCFHISEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EYCFHISEXP_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhSource1] numeric NULL,
    [PdhSource2] numeric NULL,
    [PdhSource3] numeric NULL,
    [PdhSource4] numeric NULL,
    [PdhSource5] numeric NULL,
    [PdhSource6] numeric NULL,
    [PdhSource7] numeric NULL,
    [PdhSource8] numeric NULL,
    [PdhSource9] numeric NULL,
    [PdhSource10] numeric NULL
);
IF OBJECT_ID('U_EYCFHISEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EYCFHISEXP_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EYCFHISEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Ogletree Deakins Law Firm

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 10/28/2019
Service Request Number: 

Purpose: Careworks FMLA Historical Data

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EYCFHISEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EYCFHISEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EYCFHISEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EYCFHISEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EYCFHISEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EYCFHISEXP', 'ONDEMAND';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EYCFHISEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EYCFHISEXP';

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
    DELETE FROM dbo.U_EYCFHISEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EYCFHISEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    
    --Delete employee that is not REG and eecEmpStatus = L
    DELETE FROM dbo.U_EYCFHISEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT eeceeid FROM dbo.EmpComp (NOLOCK) where eeceetype <> 'REG' and EecEmplStatus <> 'L');


    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DED1,DED2';

    IF OBJECT_ID('U_EYCFHISEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EYCFHISEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EYCFHISEXP_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EYCFHISEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EYCFHISEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EYCFHISEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvEmployeeId = EecEmpNo
        ,drvLastName = EepNameLast
        ,drvMiddleName = EepNameFirst
        ,drvEmployer = cmpcompanyname
        ,drvCaseOpenDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvCaseCloseDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStopDate END
        ,drvCaseStatus = ''
        ,drvStatusDate = ''
        ,drvWorkRelated = ''
        ,drvAbsenceEvenStartDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvAbsenceEvenceEndDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStopDate END
        ,drEstRtwDate = ''
        ,drvActualRTWDate = CASE WHEN EshEmplStatus = 'A' THEN EshStatusStartDate END
        ,drvBenRequestStartDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStartDate END    
        ,drvBenRequestEndDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStopDate END    
        ,drvLeaveStatus = ''
        ,drvLeaveStatusReason = ''
        ,drvLeaveStatusDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStartDate END    
        ,drvPolicyName = ''
        ,drvLeaveType = ''
        ,drvLeaveReason = ''
        ,drvLeaveRelationship = ''
        ,drvLeaveStartDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStartDate END    
        ,drvLeaveEndDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStopDate END    
        ,drvUtilizationStartDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStopDate END    
        ,drvUtilizationEndDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStartDate END
        ,drvLeaveDate = CASE WHEN EshEmplStatus = 'L' THEN EshStatusStartDate END    
        ,drvHoursUsed = ''
        ,drvMonday = ''
        ,drvTuesday = ''
        ,drvWednesday = ''
        ,drvThursday = ''
        ,drvFridayHours = ''
        ,drvSaturdayHours = ''
        ,drvSundayHours = ''
        ,drvComments = ''
    INTO dbo.U_EYCFHISEXP_drvTbl
    FROM dbo.U_EYCFHISEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.Company WITH (NOLOCK)
        on cmpCoid = xCoid
    JOIN EmpHStat
        ON esheeid = xeeid
        AND eshcoid = xcoid
    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEYCFHISEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EYCFHISEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EYCFHISEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910211'
       ,expStartPerControl     = '201910211'
       ,expLastEndPerControl   = '201910289'
       ,expEndPerControl       = '201910289'
WHERE expFormatCode = 'EYCFHISEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEYCFHISEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EYCFHISEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort