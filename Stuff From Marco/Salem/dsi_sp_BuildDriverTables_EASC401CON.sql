SET NOCOUNT ON;
IF OBJECT_ID('U_EASC401CON_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EASC401CON_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EASC401CON' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEASC401CON_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEASC401CON_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EASC401CON') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASC401CON];
GO
IF OBJECT_ID('U_EASC401CON_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_Trailer];
GO
IF OBJECT_ID('U_EASC401CON_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_PEarHist];
GO
IF OBJECT_ID('U_EASC401CON_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_PDedHist];
GO
IF OBJECT_ID('U_EASC401CON_Header') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_Header];
GO
IF OBJECT_ID('U_EASC401CON_File') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_File];
GO
IF OBJECT_ID('U_EASC401CON_EEList') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_EEList];
GO
IF OBJECT_ID('U_EASC401CON_drvInfo') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_drvInfo];
GO
IF OBJECT_ID('U_EASC401CON_drvDtl') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_drvDtl];
GO
IF OBJECT_ID('U_EASC401CON_DedList') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EASC401CON') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EASC401CON];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EASC401CON';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EASC401CON';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EASC401CON';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EASC401CON';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EASC401CON';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EASC401CON','Ascensus 401k Contribution Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EASC401CONZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EASC401CON' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDR"','1','(''UA''=''F'')','EASC401CONZ0','5','H','01','1',NULL,'drvHDR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCont"','2','(''UA''=''F'')','EASC401CONZ0','12','H','01','2',NULL,'drvCont',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientId"','3','(''UA''=''F'')','EASC401CONZ0','20','H','01','3',NULL,'drvClientId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBlankSpace1"','4','(''UA''=''F'')','EASC401CONZ0','2','H','01','4',NULL,'drvBlankSpace1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvClientName"','5','(''UA''=''F'')','EASC401CONZ0','15','H','01','5',NULL,'drvClientName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSiteCode"','6','(''UA''=''F'')','EASC401CONZ0','12','H','01','6',NULL,'drvSiteCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollBeginDate"','7','(''UDMDY''=''F'')','EASC401CONZ0','12','H','01','7',NULL,'drvPayrollBeginDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEndDate"','8','(''UDMDY''=''F'')','EASC401CONZ0','12','H','01','8',NULL,'drvPayrollEndDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayrollEffectiveMonth"','9','(''UA''=''F'')','EASC401CONZ0','12','H','01','9',NULL,'drvPayrollEffectiveMonth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBlankSpace2"','10','(''UA''=''F'')','EASC401CONZ0','120','H','01','10',NULL,'drvBlankSpace2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1BlankSpace3"','1','(''UA''=''F'')','EASC401CONZ0','5','D','10','1',NULL,'drvSec1BlankSpace3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1SSN"','2','(''UA''=''F'')','EASC401CONZ0','12','D','10','2',NULL,'drvSec1SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1LastName"','3','(''UA''=''F'')','EASC401CONZ0','20','D','10','3',NULL,'drvSec1LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1MI"','4','(''UA''=''F'')','EASC401CONZ0','2','D','10','4',NULL,'drvSec1MI',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1FirstName"','5','(''UA''=''F'')','EASC401CONZ0','15','D','10','5',NULL,'drvSec1FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1PayPeriodGrossComp"','6','(''UA''=''F'')','EASC401CONZ0','12','D','10','6',NULL,'drvSec1PayPeriodGrossCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1YTDGrossCompensation"','7','(''UA''=''F'')','EASC401CONZ0','12','D','10','7',NULL,'drvSec1YTDGrossCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1Hours"','8','(''UA''=''F'')','EASC401CONZ0','12','D','10','8',NULL,'drvSec1Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1EEContributions"','9','(''UA''=''F'')','EASC401CONZ0','12','D','10','9',NULL,'drvSec1EEContributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1ERMatch"','10','(''UA''=''F'')','EASC401CONZ0','12','D','10','10',NULL,'drvSec1ERMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1ProfitSharing"','11','(''UA''=''F'')','EASC401CONZ0','12','D','10','11',NULL,'drvSec1ProfitSharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1SpecialContribution1"','12','(''UA''=''F'')','EASC401CONZ0','12','D','10','12',NULL,'drvSec1SpecialContribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1SpecialContribution2"','13','(''UA''=''F'')','EASC401CONZ0','12','D','10','13',NULL,'drvSec1SpecialContribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1SpecialContribution3"','14','(''UA''=''F'')','EASC401CONZ0','12','D','10','14',NULL,'drvSec1SpecialContribution',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1Loan1"','15','(''UA''=''F'')','EASC401CONZ0','12','D','10','15',NULL,'drvSec1Loan1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1Loan2"','16','(''UA''=''F'')','EASC401CONZ0','12','D','10','16',NULL,'drvSec1Loan2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1Loan3"','17','(''UA''=''F'')','EASC401CONZ0','12','D','10','17',NULL,'drvSec1Loan3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1Loan4"','18','(''UA''=''F'')','EASC401CONZ0','12','D','10','18',NULL,'drvSec1Loan4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSec1Loan5"','19','(''UA''=''F'')','EASC401CONZ0','12','D','10','19',NULL,'drvSec1Loan5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlDTL"','1','(''UA''=''F'')','EASC401CONZ0','5','D','20','1',NULL,'drvDtlDTL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlSSN"','2','(''UA''=''F'')','EASC401CONZ0','12','D','20','2',NULL,'drvDtlSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlLastName"','3','(''UA''=''F'')','EASC401CONZ0','20','D','20','3',NULL,'drvDtlLastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlMiddleInitial"','4','(''UA''=''F'')','EASC401CONZ0','2','D','20','4',NULL,'drvDtlMiddleInitial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlFirstName"','5','(''UA''=''F'')','EASC401CONZ0','15','D','20','5',NULL,'drvDtlFirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlPayperiodCompensation"','6','(''UA''=''F'')','EASC401CONZ0','12','D','20','6',NULL,'drvDtlPayperiodCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlYTDCompensation"','7','(''UA''=''F'')','EASC401CONZ0','12','D','20','7',NULL,'drvDtlYTDCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlHours"','8','(''UA''=''F'')','EASC401CONZ0','12','D','20','8',NULL,'drvDtlHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlEmployeeDeferral401k"','9','(''UA''=''F'')','EASC401CONZ0','12','D','20','9',NULL,'drvDtlEmployeeDeferral401k',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlEmployerMatch"','10','(''UA''=''F'')','EASC401CONZ0','12','D','20','10',NULL,'drvDtlEmployerMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlEmployerProfitSharing"','11','(''UA''=''F'')','EASC401CONZ0','12','D','20','11',NULL,'drvDtlEmployerProfitSharing',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlSpecial1"','12','(''UA''=''F'')','EASC401CONZ0','12','D','20','12',NULL,'drvDtlSpecial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlSpecial2"','13','(''UA''=''F'')','EASC401CONZ0','12','D','20','13',NULL,'drvDtlSpecial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlSpecial3"','14','(''UA''=''F'')','EASC401CONZ0','12','D','20','14',NULL,'drvDtlSpecial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlLoan1"','15','(''UA''=''F'')','EASC401CONZ0','12','D','20','15',NULL,'drvDtlLoan1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlLoan2"','16','(''UA''=''F'')','EASC401CONZ0','12','D','20','16',NULL,'drvDtlLoan2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlLoan3"','17','(''UA''=''F'')','EASC401CONZ0','12','D','20','17',NULL,'drvDtlLoan3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlLoan4"','18','(''UA''=''F'')','EASC401CONZ0','12','D','20','18',NULL,'drvDtlLoan4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDtlLoan5"','19','(''UA''=''F'')','EASC401CONZ0','12','D','20','19',NULL,'drvDtlLoan5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotTOT"','1','(''UA''=''F'')','EASC401CONZ0','5','T','90','1',NULL,'drvTotTOT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotTotalNumberofRecords"','2','(''UA''=''F'')','EASC401CONZ0','12','T','90','2',NULL,'drvTotTotalNumberofRecords',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotBlankSpace1"','3','(''UA''=''F'')','EASC401CONZ0','20','T','90','3',NULL,'drvTotBlankSpace1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotBlankSpace2"','4','(''UA''=''F'')','EASC401CONZ0','2','T','90','4',NULL,'drvTotBlankSpace2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotBlankSpace3"','5','(''UA''=''F'')','EASC401CONZ0','15','T','90','5',NULL,'drvTotBlankSpace3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalPayPeriodComp"','6','(''UA''=''F'')','EASC401CONZ0','12','T','90','6',NULL,'drvTotGrandTotalPayPeriodCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalYTDComp"','7','(''UA''=''F'')','EASC401CONZ0','12','T','90','7',NULL,'drvTotGrandTotalYTDCompensation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalHours"','8','(''UA''=''F'')','EASC401CONZ0','12','T','90','8',NULL,'drvTotGrandTotalHours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalEmployee401k"','9','(''UA''=''F'')','EASC401CONZ0','12','T','90','9',NULL,'drvTotGrandTotalEmployee401k',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalEmployerMatch"','10','(''UA''=''F'')','EASC401CONZ0','12','T','90','10',NULL,'drvTotGrandTotalEmployerMatch',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalEmployerPS"','11','(''UA''=''F'')','EASC401CONZ0','12','T','90','11',NULL,'drvTotGrandTotalEmployerProfitShare',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotSpecial1"','12','(''UA''=''F'')','EASC401CONZ0','12','T','90','12',NULL,'drvTotSpecial1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotSpecial2"','13','(''UA''=''F'')','EASC401CONZ0','12','T','90','13',NULL,'drvTotSpecial2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotSpecial3"','14','(''UA''=''F'')','EASC401CONZ0','12','T','90','14',NULL,'drvTotSpecial3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalLoan1"','15','(''UA''=''F'')','EASC401CONZ0','12','T','90','15',NULL,'drvTotGrandTotalLoan1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalLoan2"','16','(''UA''=''F'')','EASC401CONZ0','12','T','90','16',NULL,'drvTotGrandTotalLoan2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalLoan3"','17','(''UA''=''F'')','EASC401CONZ0','12','T','90','17',NULL,'drvTotGrandTotalLoan3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalLoan4"','18','(''UA''=''F'')','EASC401CONZ0','12','T','90','18',NULL,'drvTotGrandTotalLoan4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTotGrandTotalLoan5"','19','(''UA''=''F'')','EASC401CONZ0','12','T','90','19',NULL,'drvTotGrandTotalLoan5',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EASC401CON_20210416.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202101289','EMPEXPORT','OEACTIVE',NULL,'EASC401CON',NULL,NULL,NULL,'202101289','Jan 28 2021  1:04PM','Jan 28 2021  1:04PM','202101281',NULL,'','','202101281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202101289','EMPEXPORT','OEPASSIVE',NULL,'EASC401CON',NULL,NULL,NULL,'202101289','Jan 28 2021  1:04PM','Jan 28 2021  1:04PM','202101281',NULL,'','','202101281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Ascensus 401k Export','202101289','EMPEXPORT','ONDEMAND',NULL,'EASC401CON',NULL,NULL,NULL,'202101289','Jan 28 2021  1:04PM','Jan 28 2021  1:04PM','202101281',NULL,'','','202101281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202101289','EMPEXPORT','SCH_ASC401',NULL,'EASC401CON',NULL,NULL,NULL,'202101289','Jan 28 2021  1:04PM','Jan 28 2021  1:04PM','202101281',NULL,'','','202101281',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202104021','EMPEXPORT','TEST','Apr 13 2021 12:10PM','EASC401CON',NULL,NULL,NULL,'202104021','Apr  2 2021 12:00AM','Mar 27 2021 12:00AM','202104021','284','','','202104021',dbo.fn_GetTimedKey(),NULL,'us3rVaSAL1011',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CON','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CON','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CON','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CON','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CON','SubSort2','C','drvSubsort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CON','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EASC401CON','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EASC401CON' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EASC401CON' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EASC401CON_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EASC401CON_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASC401CON','H01','dbo.U_EASC401CON_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASC401CON','D10','dbo.U_EASC401CON_drvInfo',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASC401CON','D20','dbo.U_EASC401CON_drvDtl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EASC401CON','T90','dbo.U_EASC401CON_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EASC401CON') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EASC401CON] (
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
IF OBJECT_ID('U_EASC401CON_DedList') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EASC401CON_drvDtl') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_drvDtl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] varchar(12) NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvDtlDTL] varchar(3) NOT NULL,
    [drvDtlSSN] char(11) NULL,
    [drvDtlLastName] varchar(100) NULL,
    [drvDtlMiddleInitial] varchar(1) NOT NULL,
    [drvDtlFirstName] varchar(100) NULL,
    [drvDtlPayperiodCompensation] varchar(30) NULL,
    [drvDtlPayperiodCompensationRaw] numeric NULL,
    [drvDtlYTDCompensation] varchar(30) NULL,
    [drvDtlYTDCompensationRaw] numeric NULL,
    [drvDtlHours] varchar(30) NULL,
    [drvDtlHoursRaw] decimal NULL,
    [drvDtlEmployeeDeferral401k] varchar(30) NULL,
    [drvDtlEmployeeDeferral401kRaw] numeric NULL,
    [drvDtlEmployerMatch] varchar(1) NOT NULL,
    [drvDtlEmployerProfitSharing] varchar(1) NOT NULL,
    [drvDtlSpecialRaw1] numeric NULL,
    [drvDtlSpecial1] varchar(30) NULL,
    [drvDtlSpecial2] varchar(1) NOT NULL,
    [drvDtlSpecial3] varchar(1) NOT NULL,
    [drvDtlLoan1] varchar(30) NULL,
    [drvDtlLoan1Raw] numeric NULL,
    [drvDtlLoan2] varchar(1) NOT NULL,
    [drvDtlLoan3] varchar(1) NOT NULL,
    [drvDtlLoan4] varchar(1) NOT NULL,
    [drvDtlLoan5] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EASC401CON_drvInfo') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_drvInfo] (
    [drvEEID] varchar(6) NOT NULL,
    [drvCoID] varchar(7) NOT NULL,
    [drvInitialSort] varchar(9) NOT NULL,
    [drvSubSort] varchar(9) NOT NULL,
    [drvSubsort2] varchar(1) NOT NULL,
    [drvSec1BlankSpace3] varchar(1) NOT NULL,
    [drvSec1SSN] varchar(10) NOT NULL,
    [drvSec1LastName] varchar(9) NOT NULL,
    [drvSec1MI] varchar(2) NOT NULL,
    [drvSec1FirstName] varchar(10) NOT NULL,
    [drvSec1PayPeriodGrossComp] varchar(10) NOT NULL,
    [drvSec1YTDGrossCompensation] varchar(7) NOT NULL,
    [drvSec1Hours] varchar(5) NOT NULL,
    [drvSec1EEContributions] varchar(7) NOT NULL,
    [drvSec1ERMatch] varchar(8) NOT NULL,
    [drvSec1ProfitSharing] varchar(8) NOT NULL,
    [drvSec1SpecialContribution1] varchar(7) NOT NULL,
    [drvSec1SpecialContribution2] varchar(7) NOT NULL,
    [drvSec1SpecialContribution3] varchar(7) NOT NULL,
    [drvSec1Loan1] varchar(6) NOT NULL,
    [drvSec1Loan2] varchar(6) NOT NULL,
    [drvSec1Loan3] varchar(6) NOT NULL,
    [drvSec1Loan4] varchar(6) NOT NULL,
    [drvSec1Loan5] varchar(6) NOT NULL
);
IF OBJECT_ID('U_EASC401CON_EEList') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EASC401CON_File') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(1000) NULL
);
IF OBJECT_ID('U_EASC401CON_Header') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_Header] (
    [drvHDR] varchar(3) NOT NULL,
    [drvCont] varchar(4) NOT NULL,
    [drvClientId] varchar(6) NOT NULL,
    [drvBlankSpace1] varchar(1) NOT NULL,
    [drvClientName] varchar(21) NOT NULL,
    [drvSiteCode] varchar(1) NOT NULL,
    [drvPayrollBeginDate] datetime NULL,
    [drvPayrollEndDate] datetime NULL,
    [drvPayrollEffectiveMonth] datetime NULL,
    [drvBlankSpace2] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EASC401CON_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [Pdh401K] numeric NULL,
    [pdhLoan1] numeric NULL,
    [pdhRoth] numeric NULL
);
IF OBJECT_ID('U_EASC401CON_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_PEarHist] (
    [PehEEID] char(12) NOT NULL,
    [PrgPayDate] datetime NULL,
    [PehCurAmt] numeric NULL,
    [PehCurAmtWithoutGTIMP] numeric NULL,
    [PehCurAmtDtlP] numeric NULL,
    [PehCurHrs] decimal NULL,
    [PehCurHrsDTL] decimal NULL,
    [PehCurAmtYTD] money NULL,
    [PehCurHrsYTD] decimal NULL,
    [PehCurAmtWithoutGTIMPYTD] numeric NULL,
    [PehCurAmtDtlPYTD] numeric NULL,
    [PehInclInDefComp] money NULL,
    [PehInclInDefCompHrs] decimal NULL,
    [PehInclInDefCompYTD] money NULL,
    [PehInclInDefCompHrsYTD] decimal NULL
);
IF OBJECT_ID('U_EASC401CON_Trailer') IS NULL
CREATE TABLE [dbo].[U_EASC401CON_Trailer] (
    [drvTotTOT] varchar(3) NOT NULL,
    [drvTotTotalNumberofRecords] int NULL,
    [drvTotBlankSpace1] varchar(1) NOT NULL,
    [drvTotBlankSpace2] varchar(1) NOT NULL,
    [drvTotBlankSpace3] varchar(1) NOT NULL,
    [drvTotGrandTotalPayPeriodComp] varchar(30) NULL,
    [drvTotGrandTotalYTDComp] varchar(30) NULL,
    [drvTotGrandTotalHours] varchar(30) NULL,
    [drvTotGrandTotalEmployee401k] varchar(30) NULL,
    [drvTotGrandTotalEmployerMatch] varchar(1) NOT NULL,
    [drvTotGrandTotalEmployerPS] varchar(1) NOT NULL,
    [drvTotSpecial1] varchar(30) NULL,
    [drvTotSpecial2] varchar(1) NOT NULL,
    [drvTotSpecial3] varchar(1) NOT NULL,
    [drvTotGrandTotalLoan1] varchar(30) NULL,
    [drvTotGrandTotalLoan2] varchar(1) NOT NULL,
    [drvTotGrandTotalLoan3] varchar(1) NOT NULL,
    [drvTotGrandTotalLoan4] varchar(1) NOT NULL,
    [drvTotGrandTotalLoan5] varchar(1) NOT NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EASC401CON]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Salem Medical Center

Created By: Marco Lagrosa
Business Analyst: Richard Vars
Create Date: 01/28/2021
Service Request Number: TekP-2020-10-06-0001

Purpose: Ascensus 401k Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EASC401CON';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EASC401CON';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EASC401CON';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EASC401CON';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EASC401CON' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CON', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CON', 'TEST';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CON', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CON', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EASC401CON', 'SCHEDULED';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EASC401CON';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EASC401CON', @AllObjects = 'Y', @IsWeb = 'Y'
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
            ,@PayDate            DATETIME
            ,@PeriodStartdate    DATETIME
            ,@PeriodEnddate    DATETIME
    -- Set FormatCode
    SELECT @FormatCode = 'EASC401CON';

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
    DELETE FROM dbo.U_EASC401CON_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EASC401CON_EEList GROUP BY xEEID HAVING COUNT(1) > 1);


    SELECT @PayDate = LEFT(MAX(PgpPeriodControl),8), @PeriodStartdate = MAX(PgpPeriodStartDate) , @PeriodEnddate = MAX(PgpPeriodEndDate)  
                   FROM dbo.PgPayPer WITH (NOLOCK)
                   WHERE PgpPeriodControl BETWEEN @StartPerControl AND @EndPerControl 
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '401K,401CU,401LN,RTHCU,ROTHD,ROTH';

    IF OBJECT_ID('U_EASC401CON_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CON_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EASC401CON_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;


    --==========================================
    -- BDM Section
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
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

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EASC401CON_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CON_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,Pdh401K     = SUM(CASE WHEN PdhDedCode IN ('401K','401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhLoan1     = SUM(CASE WHEN PdhDedCode IN ('401LN') THEN PdhEECurAmt ELSE 0.00 END)
        ,pdhRoth    = SUM(CASE WHEN PdhDedCode IN ('RTHCU', 'ROTHD', 'ROTH') THEN PdhEECurAmt ELSE 0.00 END)

    INTO dbo.U_EASC401CON_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EASC401CON_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EASC401CON_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CON_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
        -- Current Payroll Amount/Hours
        ,PehCurAmt              = SUM(CASE WHEN PehPerControl >= @StartPerControl  THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtWithoutGTIMP  = SUM(CASE WHEN PehPerControl >= @StartPerControl and pehearncode <> 'GTIMP' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtDtlP          = SUM(CASE WHEN PehPerControl >= @StartPerControl  and pehearncode in ('BNCB', 'CHRG','CHRG5','FLOAT','IC20','IC300','IC500','OC10','OC3','OC5','OT','OTP','OTPS2','OTPS3','PTO','PTOCA','REG','REG2','REG3','RP','SALEM','TRIN2','TRINS','TROR2','TROR3','TRORI') THEN PehCurAmt ELSE 0.00 END)
        ,PehCurHrs              = SUM(CASE WHEN PehPerControl >= @StartPerControl THEN PehCurHrs ELSE 0.00 END)
        ,PehCurHrsDTL              = SUM(CASE WHEN PehPerControl >= @StartPerControl and pehearncode in ('REG') THEN PehCurHrs ELSE 0.00 END)

        -- YTD Payroll Amount/Hours
        ,PehCurAmtYTD           = SUM(PehCurAmt)
        ,PehCurHrsYTD           = SUM(PehCurHrs)
        ,PehCurAmtWithoutGTIMPYTD  = SUM(CASE WHEN pehearncode <> 'GTIMP' THEN PehCurAmt ELSE 0.00 END)
        ,PehCurAmtDtlPYTD          = SUM(CASE WHEN pehearncode in ('BNCB', 'CHRG','CHRG5','FLOAT','IC20','IC300','IC500','OC10','OC3','OC5','OT','OTP','OTPS2','OTPS3','PTO','PTOCA','REG','REG2','REG3','RP','SALEM','TRIN2','TRINS','TROR2','TROR3','TRORI') THEN PehCurAmt ELSE 0.00 END)


        -- Current Include Deferred Comp Amount/Hours
        ,PehInclInDefComp       = SUM(CASE WHEN PehInclInDefComp = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurAmt END)
        ,PehInclInDefCompHrs    = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' AND PehPerControl >= @StartPerControl THEN PehCurHrs END)
        -- YTD Include Deferred Comp Amount/Hours
        ,PehInclInDefCompYTD    = SUM(CASE WHEN PehInclInDefComp = 'Y' THEN PehCurAmt END)
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EASC401CON_PEarHist
    FROM dbo.vw_int_PayReg WITH (NOLOCK)
    JOIN dbo.vw_int_PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EASC401CON_drvInfo
    ---------------------------------
    IF OBJECT_ID('U_EASC401CON_drvInfo','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CON_drvInfo;
    SELECT DISTINCT
         drvEEID = '000000'
        ,drvCoID =  '0000000'
        ,drvInitialSort = '2' + '00000000'
        ,drvSubSort =  '2'  + '00000000'
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvSec1BlankSpace3 = ''
        ,drvSec1SSN = 'Soc. Sec #'
        ,drvSec1LastName = 'Last Name'
        ,drvSec1MI = 'MI'
        ,drvSec1FirstName = 'First Name'
        ,drvSec1PayPeriodGrossComp =  'PeriodComp'
        ,drvSec1YTDGrossCompensation =  'YTDComp'
        ,drvSec1Hours = 'Hours'
        ,drvSec1EEContributions = 'EE Cont'
        ,drvSec1ERMatch = 'ER Match'
        ,drvSec1ProfitSharing = 'PSharing'
        ,drvSec1SpecialContribution1 = 'SpcCont'
        ,drvSec1SpecialContribution2 = 'SpcCont'
        ,drvSec1SpecialContribution3 = 'SpcCont'
        ,drvSec1Loan1 = 'Loan 1'
        ,drvSec1Loan2 = 'Loan 2'
        ,drvSec1Loan3 = 'Loan 3'
        ,drvSec1Loan4 = 'Loan 4'
        ,drvSec1Loan5 = 'Loan 5'
    INTO dbo.U_EASC401CON_drvInfo;
    ---------------------------------
    -- DETAIL RECORD - U_EASC401CON_drvDtl
    ---------------------------------
    IF OBJECT_ID('U_EASC401CON_drvDtl','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CON_drvDtl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort ='2'  + eepssn
        ,drvSubSort = '2'  + eepssn
        ,drvSubsort2 = ''
        -- standard fields above and additional driver fields below
        ,drvDtlDTL = 'DTL'
        ,drvDtlSSN = eepSSN
        ,drvDtlLastName = EepNameLast
        ,drvDtlMiddleInitial = ''
        ,drvDtlFirstName = EepNameFirst
        ,drvDtlPayperiodCompensation = CAST(CONVERT(DECIMAL(10,2),CASE WHEN PehCurAmtDtlP > 0   THEN PehCurAmtDtlP ELSE 0  END) as varchar)
        ,drvDtlPayperiodCompensationRaw = CASE WHEN PehCurAmtDtlP > 0   THEN PehCurAmtDtlP ELSE 0  END

        ,drvDtlYTDCompensation = CAST(CONVERT(DECIMAL(10,2),CASE WHEN PehCurAmtDtlPYTD > 0 THEN PehCurAmtDtlPYTD ELSe 0  END) as varchar)
        ,drvDtlYTDCompensationRaw = CASE WHEN PehCurAmtDtlPYTD > 0 THEN PehCurAmtDtlPYTD ELSe 0  END

        ,drvDtlHours = CAST(CONVERT(DECIMAL(10,0),CASE WHEN PehCurHrsDTL > 0 THEN PehCurHrsDTL ELSE 0 END ) as varchar)
        ,drvDtlHoursRaw = CASE WHEN PehCurHrsDTL > 0 THEN PehCurHrsDTL ELSE 0 END

        ,drvDtlEmployeeDeferral401k = CAST(CONVERT(DECIMAL(10,2),CASE WHEN Pdh401K > 0 THEN Pdh401K ELSE 0 END) as varchar)
        ,drvDtlEmployeeDeferral401kRaw = CASE WHEN Pdh401K > 0 THEN Pdh401K ELSE 0 END

        ,drvDtlEmployerMatch = ''
        ,drvDtlEmployerProfitSharing = ''
        ,drvDtlSpecialRaw1 = CASE WHEN pdhROth > 0 THEN pdhROth ELSE 0 END 

        ,drvDtlSpecial1 =  CAST(CONVERT(DECIMAL(10,2), CASE WHEN pdhROth > 0 THEN pdhROth ELSE 0 END) as varchar)
        ,drvDtlSpecial2 = ''
        ,drvDtlSpecial3 = ''
        ,drvDtlLoan1 = CAST(CONVERT(DECIMAL(10,2),CASE WHEN pdhLoan1 > 0 THEN pdhLoan1 ELSE 0 END ) as varchar)
        ,drvDtlLoan1Raw = CASE WHEN pdhLoan1 > 0 THEN pdhLoan1 ELSE 0 END

        ,drvDtlLoan2 = ''
        ,drvDtlLoan3 = ''
        ,drvDtlLoan4 = ''
        ,drvDtlLoan5 = ''
    INTO dbo.U_EASC401CON_drvDtl
    FROM dbo.U_EASC401CON_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_EASC401CON_PDedHist WITH (NOLOCK)
        on pdheeid = xeeid
    LEFT JOIN dbo.U_EASC401CON_PEarHist WITH (NOLOCK)
        on peheeid = xeeid
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASC401CON_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CON_Header;
    SELECT DISTINCT
         drvHDR = 'HDR'
        ,drvCont = 'Cont'
        ,drvClientId = '258952'
        ,drvBlankSpace1 = ''
        ,drvClientName = 'SALEM COUNTY HOSPITAL'
        ,drvSiteCode = 'A'
        ,drvPayrollBeginDate = @PeriodStartdate
        ,drvPayrollEndDate = (Select max(PrgPayDate) from dbo.U_EASC401CON_PEarHist)
        ,drvPayrollEffectiveMonth = @PeriodEnddate
        ,drvBlankSpace2 = ''
    INTO dbo.U_EASC401CON_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EASC401CON_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EASC401CON_Trailer;
    SELECT DISTINCT
         drvTotTOT = 'TOT'
        ,drvTotTotalNumberofRecords = ( (Select count(*) from U_EASC401CON_drvInfo) + (Select count(*) from U_EASC401CON_drvDtl))
        ,drvTotBlankSpace1 = ''
        ,drvTotBlankSpace2 = ''
        ,drvTotBlankSpace3 = ''
        ,drvTotGrandTotalPayPeriodComp =  CAST(CONVERT(DECIMAL(10,2),GrandTotalComp) as varchar)
        ,drvTotGrandTotalYTDComp = CAST(CONVERT(DECIMAL(10,2),GrandTotalCompYTD) as varchar)
        ,drvTotGrandTotalHours = CAST(CONVERT(DECIMAL(10,2),TotalHours) as varchar)
        ,drvTotGrandTotalEmployee401k = CAST(CONVERT(DECIMAL(10,2),drv401K) as varchar)
        ,drvTotGrandTotalEmployerMatch = ''
        ,drvTotGrandTotalEmployerPS = ''
        ,drvTotSpecial1 = CAST(CONVERT(DECIMAL(10,2),drvDtlSpecialRaw1TRotal) as varchar) 
        ,drvTotSpecial2 = ''
        ,drvTotSpecial3 = ''
        ,drvTotGrandTotalLoan1 = CAST(CONVERT(DECIMAL(10,2),loanraw) as varchar)
        ,drvTotGrandTotalLoan2 = ''
        ,drvTotGrandTotalLoan3 = ''
        ,drvTotGrandTotalLoan4 = ''
        ,drvTotGrandTotalLoan5 = ''
    INTO dbo.U_EASC401CON_Trailer
    FROM 
    (Select sum(drvDtlPayperiodCompensationRaw) as GrandTotalComp, sum(drvDtlYTDCompensationRaw) as GrandTotalCompYTD, sum(drvDtlHoursRaw) as TotalHours, sum(drvDtlEmployeeDeferral401kRaw) as drv401K , sum(drvDtlLoan1Raw) as loanraw, sum(drvDtlSpecialRaw1) as drvDtlSpecialRaw1TRotal from U_EASC401CON_drvDtl)
    as Totals


    ;

    --==========================================
    -- Set FileName
    --==========================================
    IF (dbo.dsi_fnVariable(@FormatCode,'UseFileName') = 'N')
    BEGIN
        UPDATE dbo.U_dsi_Parameters
            SET ExportFile = CASE WHEN dbo.dsi_fnVariable(@FormatCode,'Testing') = 'Y' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE '%TEST%' THEN 'Test_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  WHEN @ExportCode LIKE 'OE%' THEN 'OE_Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                                  ELSE 'Filename_' + CONVERT(VARCHAR(8),GETDATE(),112) + '.txt'
                             END
        WHERE FormatCode = @FormatCode;
    END

END;
/**********************************************************************************

--Alter the View
ALTER VIEW dbo.dsi_vwEASC401CON_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASC401CON_File (NOLOCK)
    ORDER BY  InitialSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EASC401CON%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202101211'
       ,expStartPerControl     = '202101211'
       ,expLastEndPerControl   = '202101289'
       ,expEndPerControl       = '202101289'
WHERE expFormatCode = 'EASC401CON';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEASC401CON_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EASC401CON_File (NOLOCK)
    ORDER BY  InitialSort;