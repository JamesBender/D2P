SET NOCOUNT ON;
IF OBJECT_ID('U_EDISCFSATO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISCFSATO_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISCFSATO' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISCFSATO_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISCFSATO_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISCFSATO') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCFSATO];
GO
IF OBJECT_ID('U_EDISCFSATO_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_trlTbl];
GO
IF OBJECT_ID('U_EDISCFSATO_ptTbl') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_ptTbl];
GO
IF OBJECT_ID('U_EDISCFSATO_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_PEarHist];
GO
IF OBJECT_ID('U_EDISCFSATO_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_PDedHist];
GO
IF OBJECT_ID('U_EDISCFSATO_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_hdrTbl];
GO
IF OBJECT_ID('U_EDISCFSATO_File') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_File];
GO
IF OBJECT_ID('U_EDISCFSATO_enTbl') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_enTbl];
GO
IF OBJECT_ID('U_EDISCFSATO_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_EEList];
GO
IF OBJECT_ID('U_EDISCFSATO_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_DedList];
GO
IF OBJECT_ID('U_EDISCFSATO_ctTbl') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_ctTbl];
GO
IF OBJECT_ID('U_dsi_BDM_EDISCFSATO') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISCFSATO];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISCFSATO';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISCFSATO';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISCFSATO';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISCFSATO';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISCFSATO';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISCFSATO','Discovery FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','4000','S','N','EDISCFSATOZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISCFSATO' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RecordType"','1','(''UA''=''T|'')','EDISCFSATOZ0','50','H','01','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AdminCode"','2','(''UA''=''T|'')','EDISCFSATOZ0','50','H','01','2',NULL,'AdminCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpCode"','3','(''UA''=''T|'')','EDISCFSATOZ0','50','H','01','3',NULL,'EmpCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SyncFlag"','4','(''UA''=''T|'')','EDISCFSATOZ0','50','H','01','4',NULL,'SyncFlag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SubmitDate"','5','(''UDMDY''=''T|'')','EDISCFSATOZ0','50','H','01','5',NULL,'SubmitDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SubmitTime"','6','(''UA''=''T|'')','EDISCFSATOZ0','50','H','01','6',NULL,'SubmitTime',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FileVersion"','7','(''UA''=''T'')','EDISCFSATOZ0','50','H','01','7',NULL,'FileVersion',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RecordType"','1','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PartFileImpId"','2','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','2',NULL,'PartFileImpId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployerEmpId"','3','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','3',NULL,'EmployerEmpId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpNum"','4','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','4',NULL,'EmpNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LastName"','5','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','5',NULL,'LastName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FirstName"','6','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','6',NULL,'FirstName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MiddleIni"','7','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','7',NULL,'MiddleIni',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','8','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','8',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MaritalStat"','9','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','9',NULL,'MaritalStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MothersMaidName"','10','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','10',NULL,'MothersMaidName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','11','(''UDMDY''=''T|'')','EDISCFSATOZ0','50','D','10','11',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','12','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','12',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1"','13','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','13',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2"','14','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','14',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address3"','15','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','15',NULL,'Address3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address4"','16','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','16',NULL,'Address4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','17','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','17',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','18','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','18',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','19','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','19',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','20','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','20',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HomePhone"','21','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','21',NULL,'HomePhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkPhone"','22','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','22',NULL,'WorkPhone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WorkPhoneExt"','23','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','23',NULL,'WorkPhoneExt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Email"','24','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','24',NULL,'Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Username"','25','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','25',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PW"','26','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','26',NULL,'PW',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HireDate"','27','(''UDMDY''=''T|'')','EDISCFSATOZ0','50','D','10','27',NULL,'HireDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Division"','28','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','28',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HoursPerWeek"','29','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','29',NULL,'HoursPerWeek',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmpClass"','30','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','30',NULL,'EmpClass',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayrollFreq"','31','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','31',NULL,'PayrollFreq',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PayFreqEffDate"','32','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','32',NULL,'PayFreqEffDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PartStat"','33','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','33',NULL,'PartStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"StatEffDate"','34','(''UDMDY''=''T|'')','EDISCFSATOZ0','50','D','10','34',NULL,'StatEffDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HoldPayrollDed"','35','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','35',NULL,'HoldPayrollDed',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HoldEmployerCont"','36','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','36',NULL,'HoldEmployerCont',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IncurServ"','37','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','37',NULL,'IncurServ',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FinalPayrollProcDate"','38','(''UDMDY''=''T|'')','EDISCFSATOZ0','50','D','10','38',NULL,'FinalPayrollProcDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FinalContProcDate"','39','(''UDMDY''=''T|'')','EDISCFSATOZ0','50','D','10','39',NULL,'FinalContProcDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HSACustodian"','40','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','40',NULL,'HSACustodian',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MedicareBen"','41','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','41',NULL,'MedicareBen',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MedicareId"','42','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','42',NULL,'MedicareId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ExchangeIntId"','43','(''UA''=''T|'')','EDISCFSATOZ0','50','D','10','43',NULL,'ExchangeIntId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RepHierarchyLevel1"','44','(''UA''=''T|'')','EDISCFSATOZ0','51','D','10','44',NULL,'RepHierarchyLevel1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RepHierarchyLevel2"','45','(''UA''=''T|'')','EDISCFSATOZ0','52','D','10','45',NULL,'RepHierarchyLevel2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RepHierarchyLevel3"','46','(''UA''=''T|'')','EDISCFSATOZ0','53','D','10','46',NULL,'RepHierarchyLevel3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RepHierarchyLevel4"','47','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','47',NULL,'RepHierarchyLevel4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CDDCitizenship"','48','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','48',NULL,'CDDCitizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CDDCountry"','49','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','49',NULL,'CDDCountry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CCEmploymentStat"','50','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','50',NULL,'CCEmploymentStat',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CDDEmployer"','51','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','51',NULL,'CDDEmployer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CDDJobTitle"','52','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','52',NULL,'CDDJobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ClassEffDate"','53','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','53',NULL,'ClassEffDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IdIdentType"','54','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','54',NULL,'IdIdentType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IdIdentNum"','55','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','55',NULL,'IdIdentNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IdIssuingState"','56','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','56',NULL,'IdIssuingState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IdIssuer"','57','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','57',NULL,'IdIssuer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IdIssueDate"','58','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','58',NULL,'IdIssueDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IdExpDate"','59','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','59',NULL,'IdExpDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MobileCarrier"','60','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','60',NULL,'MobileCarrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MobileNum"','61','(''UA''=''T|'')','EDISCFSATOZ0','54','D','10','61',NULL,'MobileNum',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TimeZone"','62','(''UA''=''T'')','EDISCFSATOZ0','54','D','10','62',NULL,'TimeZone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RecordType"','1','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PartFileImpId"','2','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','2',NULL,'PartFileImpId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanName"','3','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','3',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EnrollEffDate"','4','(''UDMDY''=''T|'')','EDISCFSATOZ0','54','D','20','4',NULL,'EnrollEffDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PartElectAmt"','5','(''UDMDY''=''T|'')','EDISCFSATOZ0','54','D','20','5',NULL,'PartElectAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EnrollTermDate"','6','(''UDMDY''=''T|'')','EDISCFSATOZ0','54','D','20','6',NULL,'EnrollTermDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployerContLevel"','7','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','7',NULL,'EmployerContLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployerContAmt"','8','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','8',NULL,'EmployerContAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PrimaryReimbursement"','9','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','9',NULL,'PrimaryReimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AlternateReimbursement"','10','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','10',NULL,'AlternateReimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EnrolledInClaimsExchange"','11','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','11',NULL,'EnrolledInClaimsExchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ElectionAmtIndicator"','12','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','12',NULL,'ElectionAmtIndicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HDHPCovLevel"','13','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','13',NULL,'HDHPCovLevel',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanYearStartDate"','14','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','14',NULL,'PlanYearStartDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TermAndCondAcc"','15','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','15',NULL,'TermAndCondAcc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DateTermsCondAcc"','16','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','16',NULL,'DateTermsCondAcc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TimTermsCondAcc"','17','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','17',NULL,'TimTermsCondAcc',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ChangeDate"','18','(''UA''=''T|'')','EDISCFSATOZ0','54','D','20','18',NULL,'ChangeDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SpendDown"','19','(''UA''=''T'')','EDISCFSATOZ0','54','D','20','19',NULL,'SpendDown',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RecordType"','1','(''UA''=''T|'')','EDISCFSATOZ0','54','D','30','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PartFileImpId"','2','(''UA''=''T|'')','EDISCFSATOZ0','54','D','30','2',NULL,'PartFileImpId',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PlanName"','3','(''UA''=''T|'')','EDISCFSATOZ0','54','D','30','3',NULL,'PlanName',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ContDate"','4','(''UDMDY''=''T|'')','EDISCFSATOZ0','54','D','30','4',NULL,'ContDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ContDescription"','5','(''UA''=''T|'')','EDISCFSATOZ0','54','D','30','5',NULL,'ContDescription',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ContAmt"','6','(''UA''=''T|'')','EDISCFSATOZ0','54','D','30','6',NULL,'ContAmt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AmtType"','7','(''UA''=''T|'')','EDISCFSATOZ0','54','D','30','7',NULL,'AmtType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TaxYear"','8','(''UA''=''T'')','EDISCFSATOZ0','54','D','30','8',NULL,'TaxYear',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RecordType"','1','(''UA''=''T|'')','EDISCFSATOZ0','54','T','90','1',NULL,'RecordType',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"RecordCount"','2','(''UA''=''T|'')','EDISCFSATOZ0','54','T','90','2',NULL,'RecordCount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AdminCode"','3','(''UA''=''T|'')','EDISCFSATOZ0','54','T','90','3',NULL,'AdminCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EmployerCode"','4','(''UA''=''T|'')','EDISCFSATOZ0','54','T','90','4',NULL,'EmployerCode',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SubmitDate"','5','(''UDMDY''=''T|'')','EDISCFSATOZ0','54','T','90','5',NULL,'SubmitDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SubmitTime"','6','(''UA''=''T'')','EDISCFSATOZ0','54','T','90','6',NULL,'SubmitTime',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISCFSATO_20210603.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202105249','EMPEXPORT','OEACTIVE',NULL,'EDISCFSATO',NULL,NULL,NULL,'202105249','May 24 2021  6:47PM','May 24 2021  6:47PM','202105241',NULL,'','','202105241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202105249','EMPEXPORT','OEPASSIVE',NULL,'EDISCFSATO',NULL,NULL,NULL,'202105249','May 24 2021  6:47PM','May 24 2021  6:47PM','202105241',NULL,'','','202105241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Export','202105249','EMPEXPORT','ONDEM_XOE',NULL,'EDISCFSATO',NULL,NULL,NULL,'202105249','May 24 2021  6:47PM','May 24 2021  6:47PM','202105241',NULL,'','','202105241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Export-Sched','202105249','EMPEXPORT','SCH_EDISCF',NULL,'EDISCFSATO',NULL,NULL,NULL,'202105249','May 24 2021  6:47PM','May 24 2021  6:47PM','202105241',NULL,'','','202105241',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Discovery FSA Export-Test','202106011','EMPEXPORT','TEST_XOE','May 31 2021  3:03PM','EDISCFSATO',NULL,NULL,NULL,'202106011','Jun  1 2021 12:00AM','May 31 2021 12:00AM','202106011','135','eecPayGroup','CRTEAM','202106011',dbo.fn_GetTimedKey(),NULL,'us3cPeTOP1004',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSATO','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSATO','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSATO','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSATO','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSATO','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISCFSATO','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISCFSATO' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISCFSATO' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISCFSATO_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISCFSATO_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSATO','H01','dbo.U_EDISCFSATO_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSATO','D10','dbo.U_EDISCFSATO_ptTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSATO','D20','dbo.U_EDISCFSATO_enTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSATO','D30','dbo.U_EDISCFSATO_ctTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISCFSATO','T90','dbo.U_EDISCFSATO_trlTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISCFSATO') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISCFSATO] (
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
IF OBJECT_ID('U_EDISCFSATO_ctTbl') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_ctTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [RecordType] varchar(2) NOT NULL,
    [PartFileImpId] char(11) NULL,
    [PlanName] varchar(22) NULL,
    [ContDate] datetime NULL,
    [ContDescription] varchar(17) NULL,
    [ContAmt] varchar(30) NULL,
    [AmtType] varchar(6) NOT NULL,
    [TaxYear] varchar(7) NOT NULL,
	drvInitialSort varchar(10) NOT NULL,
	drvSubSort varchar(5) NOT NULL
);
IF OBJECT_ID('U_EDISCFSATO_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISCFSATO_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISCFSATO_enTbl') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_enTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [RecordType] varchar(2) NOT NULL,
    [PartFileImpId] char(11) NULL,
    [PlanName] varchar(22) NULL,
    [EnrollEffDate] varchar(8000) NOT NULL,
    [PartElectAmt] money NULL,
    [EnrollTermDate] datetime NULL,
    [EmployerContLevel] varchar(8000) NOT NULL,
    [EmployerContAmt] varchar(1) NOT NULL,
    [PrimaryReimbursement] varchar(1) NOT NULL,
    [AlternateReimbursement] varchar(1) NOT NULL,
    [EnrolledInClaimsExchange] varchar(1) NOT NULL,
    [ElectionAmtIndicator] varchar(8) NOT NULL,
    [HDHPCovLevel] varchar(1) NOT NULL,
    [PlanYearStartDate] varchar(1) NOT NULL,
    [TermAndCondAcc] varchar(1) NOT NULL,
    [DateTermsCondAcc] varchar(1) NOT NULL,
    [TimTermsCondAcc] varchar(1) NOT NULL,
    [ChangeDate] varchar(1) NOT NULL,
    [SpendDown] varchar(1) NOT NULL,
	drvInitialSort varchar(10) NOT NULL,
	drvSubSort varchar(5) NOT NULL
);
IF OBJECT_ID('U_EDISCFSATO_File') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(4000) NULL
);
IF OBJECT_ID('U_EDISCFSATO_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_hdrTbl] (
    [RecordType] varchar(2) NOT NULL,
    [AdminCode] varchar(3) NOT NULL,
    [EmpCode] varchar(5) NOT NULL,
    [SyncFlag] varchar(1) NOT NULL,
    [SubmitDate] datetime NOT NULL,
    [SubmitTime] varchar(8000) NULL,
    [FileVersion] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EDISCFSATO_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhCOID] char(5) NOT NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhPayDate] datetime NULL,
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
IF OBJECT_ID('U_EDISCFSATO_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_PEarHist] (
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
IF OBJECT_ID('U_EDISCFSATO_ptTbl') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_ptTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [RecordType] varchar(2) NOT NULL,
    [PartFileImpId] char(11) NULL,
    [EmployerEmpId] varchar(1) NOT NULL,
    [EmpNum] char(9) NULL,
    [LastName] varchar(100) NULL,
    [FirstName] varchar(100) NULL,
    [MiddleIni] varchar(1) NULL,
    [Gender] varchar(1) NOT NULL,
    [MaritalStat] varchar(1) NOT NULL,
    [MothersMaidName] varchar(1) NOT NULL,
    [DOB] datetime NULL,
    [SSN] char(11) NULL,
    [Address1] varchar(255) NULL,
    [Address2] varchar(255) NULL,
    [Address3] varchar(1) NOT NULL,
    [Address4] varchar(1) NOT NULL,
    [City] varchar(255) NULL,
    [State] varchar(255) NULL,
    [Zip] varchar(50) NULL,
    [Country] varchar(1) NOT NULL,
    [HomePhone] varchar(50) NULL,
    [WorkPhone] varchar(1) NOT NULL,
    [WorkPhoneExt] varchar(1) NOT NULL,
    [Email] varchar(50) NULL,
    [Username] varchar(1) NOT NULL,
    [PW] varchar(1) NOT NULL,
    [HireDate] datetime NULL,
    [Division] varchar(6) NOT NULL,
    [HoursPerWeek] varchar(1) NOT NULL,
    [EmpClass] varchar(1) NOT NULL,
    [PayrollFreq] varchar(7) NOT NULL,
    [PayFreqEffDate] varchar(1) NOT NULL,
    [PartStat] varchar(10) NOT NULL,
    [StatEffDate] datetime NULL,
    [HoldPayrollDed] varchar(1) NOT NULL,
    [HoldEmployerCont] varchar(1) NOT NULL,
    [IncurServ] varchar(1) NOT NULL,
    [FinalPayrollProcDate] varchar(8000) NOT NULL,
    [FinalContProcDate] varchar(8000) NOT NULL,
    [HSACustodian] varchar(1) NOT NULL,
    [MedicareBen] varchar(1) NOT NULL,
    [MedicareId] varchar(1) NOT NULL,
    [ExchangeIntId] varchar(1) NOT NULL,
    [RepHierarchyLevel1] varchar(1) NOT NULL,
    [RepHierarchyLevel2] varchar(1) NOT NULL,
    [RepHierarchyLevel3] varchar(1) NOT NULL,
    [RepHierarchyLevel4] varchar(1) NOT NULL,
    [CDDCitizenship] varchar(1) NOT NULL,
    [CDDCountry] char(3) NULL,
    [CCEmploymentStat] varchar(1) NOT NULL,
    [CDDEmployer] varchar(1) NOT NULL,
    [CDDJobTitle] varchar(1) NOT NULL,
    [ClassEffDate] varchar(1) NOT NULL,
    [IdIdentType] varchar(1) NOT NULL,
    [IdIdentNum] varchar(1) NOT NULL,
    [IdIssuingState] varchar(255) NULL,
    [IdIssuer] varchar(1) NOT NULL,
    [IdIssueDate] varchar(1) NOT NULL,
    [IdExpDate] varchar(1) NOT NULL,
    [MobileCarrier] varchar(1) NOT NULL,
    [MobileNum] varchar(50) NULL,
    [TimeZone] varchar(1) NOT NULL,
	drvInitialSort varchar(10) NOT NULL,
	drvSubSort varchar(5) NOT NULL
);
IF OBJECT_ID('U_EDISCFSATO_trlTbl') IS NULL
CREATE TABLE [dbo].[U_EDISCFSATO_trlTbl] (
    [RecordType] varchar(2) NOT NULL,
    [RecordCount] int NULL,
    [AdminCode] varchar(3) NOT NULL,
    [EmployerCode] varchar(5) NOT NULL,
    [SubmitDate] datetime NOT NULL,
    [SubmitTime] varchar(8000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISCFSATO]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Toptal, LLC

Created By: Andy Pineda
Business Analyst: Cheryl Petitti
Create Date: 05/24/2021
Service Request Number: TekP-2021-03-02-0006

Purpose: Discovery FSA Export

Revision History
----------------
06/03/2021 by AP:
		- Fixed DOB in PT record.
		- CDD country field and ID issuing country field set to BLANK.
		- Updated enrollment effective date field in EN record.
		- Partiticpant election amount no longer has ','.
		- HDHP logic updated.
		- Sort order fixed.

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISCFSATO';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISCFSATO';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISCFSATO';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISCFSATO';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISCFSATO' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSATO', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSATO', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSATO', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSATO', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISCFSATO', 'SCH_EDISCF';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISCFSATO';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISCFSATO', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISCFSATO';

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
    DELETE FROM dbo.U_EDISCFSATO_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISCFSATO_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA, DCFSA, HSACF, HSACI, HSAF, HSAI, CMTR, CMPK';

    IF OBJECT_ID('U_EDISCFSATO_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISCFSATO_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CalcBenOptionDate','2');

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
    IF OBJECT_ID('U_EDISCFSATO_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_PDedHist;
    SELECT DISTINCT
         PdhEEID
        ,PdhCOID
        ,PdhDedCode
        ,PdhPayDate        = MAX(PdhPayDate)
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,PdhSource1     = SUM(CASE WHEN PdhDedCode IN ('401K') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource2     = SUM(CASE WHEN PdhDedCode IN ('ROTH') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource3     = SUM(CASE WHEN PdhDedCode IN ('MATCH') THEN PdhERCurAmt ELSE 0.00 END)        
        ,PdhSource4     = SUM(CASE WHEN PdhDedCode IN ('401CU') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource5     = SUM(CASE WHEN PdhDedCode IN ('ROTHC') THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhSource6     = SUM(CASE WHEN PdhDedCode IN ('401KL1') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource7     = SUM(CASE WHEN PdhDedCode IN ('401KL2') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource8     = SUM(CASE WHEN PdhDedCode IN ('401KL3') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource9     = SUM(CASE WHEN PdhDedCode IN ('401KL4') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
        ,PdhSource10    = SUM(CASE WHEN PdhDedCode IN ('401KL5') THEN ISNULL(PdhEECurAmt, 0) ELSE 0.00 END)
    INTO dbo.U_EDISCFSATO_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDISCFSATO_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID, PdhCOID, PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EDISCFSATO_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_PEarHist;
    SELECT DISTINCT
         PehEEID
        ,PrgPayDate             = MAX(PrgPayDate)
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
        ,PehInclInDefCompHrsYTD = SUM(CASE WHEN PehInclInDefCompHrs = 'Y' THEN PehCurHrs END)
    INTO dbo.U_EDISCFSATO_PEarHist
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
    -- DETAIL RECORD - U_EDISCFSATO_ptTbl
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSATO_ptTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_ptTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,RecordType = 'PT'
        ,PartFileImpId = EepSSN
        ,EmployerEmpId = ''
        ,EmpNum = EecEmpNo
        ,LastName = EepNameLast
        ,FirstName = EepNameFirst
        ,MiddleIni = LEFT(EepNameMiddle, 1)
        ,Gender = CASE EepGender
                    WHEN 'M' THEN 'M'
                    WHEN 'F' THEN 'F'
                    ELSE '' END
        ,MaritalStat = CASE EepMaritalStatus 
                        WHEN 'S' THEN 'S'
                        WHEN 'M' THEN 'M' 
                        ELSE '' END
        ,MothersMaidName = ''
        ,DOB = EepDateOfBirth
        ,SSN = EepSSN
        ,Address1 = EepAddressLine1
        ,Address2 = EepAddressLine2
        ,Address3 = ''
        ,Address4 = ''
        ,City = EepAddressCity
        ,[State] = EepAddressState
        ,Zip = EepAddressZipCode
        ,Country = ''
        ,HomePhone = EepPhoneHomeNumber
        ,WorkPhone = ''
        ,WorkPhoneExt = ''
        ,Email = EepAddressEMail
        ,Username = ''
        ,PW = ''
        ,HireDate = EecDateOfOriginalHire
        ,Division = CASE EepAddressState
                        WHEN 'CA' THEN 'FT-CA'
                        WHEN 'NY' THEN 'FT-NY'
                        ELSE 'FT-OOS' END
        ,HoursPerWeek = ''
        ,EmpClass = 'E'
        ,PayrollFreq = 'Payroll'
        ,PayFreqEffDate = ''
        ,PartStat = CASE EecEmplStatus
                        WHEN 'T' THEN 'Terminated'
                        ELSE 'Active'
                        END
        ,StatEffDate = CASE EecEmplStatus
                        WHEN 'T' THEN EecDateOfTermination
                        ELSE EecDateOfLastHire
                        END
        ,HoldPayrollDed = ''
        ,HoldEmployerCont = ''
        ,IncurServ = ''
        ,FinalPayrollProcDate = ISNULL((CASE WHEN EecEmplStatus = 'T' THEN REPLACE(CONVERT (CHAR(10), DATEADD(DAY, 30, EecDateOfTermination), 101),'/','') END), '')
        ,FinalContProcDate = ISNULL((CASE WHEN EecEmplStatus = 'T' THEN REPLACE(CONVERT (CHAR(10), DATEADD(DAY, 30, EecDateOfTermination), 101),'/','') END), '')
        ,HSACustodian = ''
        ,MedicareBen = ''
        ,MedicareId = ''
        ,ExchangeIntId = ''
        ,RepHierarchyLevel1 = ''
        ,RepHierarchyLevel2 = ''
        ,RepHierarchyLevel3 = ''
        ,RepHierarchyLevel4 = ''
        ,CDDCitizenship = ''
        ,CDDCountry = ''
        ,CCEmploymentStat = ''
        ,CDDEmployer = ''
        ,CDDJobTitle = ''
        ,ClassEffDate = ''
        ,IdIdentType = ''
        ,IdIdentNum = ''
        ,IdIssuingState = ''
        ,IdIssuer = ''
        ,IdIssueDate = ''
        ,IdExpDate = ''
        ,MobileCarrier = ''
        ,MobileNum = M.EfoPhoneNumber
        ,TimeZone = ''
		,drvInitialSort = LTRIM(RTRIM(EepSSN))
		,drvSubSort = '1'
    INTO dbo.U_EDISCFSATO_ptTbl
    FROM dbo.U_EDISCFSATO_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedValidForExport = 'Y'
        AND EedFormatCode = @FormatCode
    LEFT JOIN (SELECT TOP 1 EfoEEID, EfoPhoneNumber FROM dbo.EmpMPhon WITH(NOLOCK) WHERE efoPhoneType = 'CEL') as M on M.EfoEEID = xEEID

    WHERE CAST(EedBenStartDate AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-01-01' -- Always starting on January 1st of current year 
    AND EecEEType NOT IN ('TES', 'Z')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCFSATO_enTbl
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSATO_enTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_enTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,RecordType = 'EN'
        ,PartFileImpId = EepSSN
        ,PlanName = CASE WHEN EedDedCode = 'FSA' THEN 'Medical FSA'
                        WHEN EedDedCode = 'DCFSA' THEN 'Dependent Care FSA'
                        WHEN EedDedCode = 'CMTR' THEN 'Mass Transit'
                        WHEN EedDedCode = 'CMPK' THEN 'Parking'
                        WHEN EedDedCode IN ('HSACF', 'HSACI', 'HSAF', 'HSAI') THEN 'Health Savings Account' END
        ,EnrollEffDate = ISNULL((CASE WHEN EedDedCode IN ('FSA', 'DCFSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'PARK', 'CMT') THEN REPLACE(CONVERT (CHAR(10), EedBenStartDate, 101),'/','') END), '')
        ,PartElectAmt = CASE WHEN EedDedCode IN ('DCFSA', 'FSA', 'CMTR', 'CMPK') THEN REPLACE(EedEEGoalAmt, ',', '') ELSE '' END -- might need to convert
        ,EnrollTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,EmployerContLevel = ISNULL((CASE WHEN EecEmplStatus <> 'T' AND EedDedCode IN ('DCFSA', 'FSA', 'CMTR', 'CMPK') THEN REPLACE(CONVERT (CHAR(10), EedBenStopDate, 101),'/','') END), '')
        ,EmployerContAmt = ''
        ,PrimaryReimbursement = ''
        ,AlternateReimbursement = ''
        ,EnrolledInClaimsExchange = ''
        ,ElectionAmtIndicator = CASE WHEN EedDedCode IN ('HSACF', 'HSACI', 'HSAF', 'HSAI') THEN 'PerPay'
                                        WHEN EedDedCode IN ('PARK', 'CMT') THEN 'PerMonth' ELSE '' END
        ,HDHPCovLevel = CASE WHEN EedDedCode IN ('HSACF', 'HSAF') THEN 'Family' 
							WHEN EedDedcode IN ('HSACI', 'HSAI') THEN 'Single' ELSE '' END
        ,PlanYearStartDate = ''
        ,TermAndCondAcc = ''
        ,DateTermsCondAcc = ''
        ,TimTermsCondAcc = ''
        ,ChangeDate = ''
        ,SpendDown = ''
		,drvInitialSort = LTRIM(RTRIM(EepSSN))
		,drvSubSort = '2'
    INTO dbo.U_EDISCFSATO_enTbl
    FROM dbo.U_EDISCFSATO_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedValidForExport = 'Y'
        AND EedFormatCode = @FormatCode

    WHERE CAST(EedBenStartDate AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-01-01' -- Always starting on January 1st of current year
    AND EecEEType NOT IN ('TES', 'Z')
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISCFSATO_ctTbl
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSATO_ctTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_ctTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,RecordType = 'CT'
        ,PartFileImpId = EepSSN
        ,PlanName = CASE WHEN EedDedCode = 'FSA' THEN 'Medical FSA'
                        WHEN EedDedCode = 'DCFSA' THEN 'Dependent Care FSA'
                        WHEN EedDedCode = 'CMTR' THEN 'Mass Transit'
                        WHEN EedDedCode = 'CMPK' THEN 'Parking'
                        WHEN EedDedCode IN ('HSACF', 'HSACI', 'HSAER', 'HSAF', 'HSAI') THEN 'Health Savings Account' END
        ,ContDate = PdhPayDate
        ,ContDescription = CASE WHEN EedDedCode IN ('DCFSA', 'FSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'CMTR', 'CMPK') THEN 'Payroll Deduction' END
        ,ContAmt = CAST(CASE WHEN PdhDedCode IN ('DCFSA', 'FSA', 'HSACF', 'HSACI', 'HSAF', 'HSAI', 'HSAER', 'PARK', 'CMT') AND PdhEECurAmt > 0 THEN PdhEECurAmt END AS VARCHAR)
        ,AmtType = 'Actual'
        ,TaxYear = 'Current'
		,drvInitialSort = LTRIM(RTRIM(EepSSN))
		,drvSubSort = '3'
    INTO dbo.U_EDISCFSATO_ctTbl
    FROM dbo.U_EDISCFSATO_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH(NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.U_EDISCFSATO_PDedHist WITH(NOLOCK)
        ON xEEID = PdhEEID
        AND xCOID = PdhCOID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedValidForExport = 'Y'
        AND EedFormatCode = @FormatCode
        AND PdhDedCode = EedDedCode

    WHERE CAST(EedBenStartDate AS DATE) >= CAST(YEAR(GETDATE()) AS VARCHAR) + '-01-01' -- Always starting on January 1st of current year
    AND EecEEType NOT IN ('TES', 'Z')
    ;
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSATO_hdrTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_hdrTbl;
    SELECT DISTINCT
         RecordType = 'FH'
        ,AdminCode = 'DBI'
        ,EmpCode = '28576'
        ,SyncFlag = 'N'
        ,SubmitDate = GETDATE()
        ,SubmitTime = REPLACE(CONVERT(VARCHAR(10), GETDATE(), 108), ':', '')
        ,FileVersion = '3.5'
    INTO dbo.U_EDISCFSATO_hdrTbl
    FROM dbo.U_EDISCFSATO_EEList WITH (NOLOCK)
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISCFSATO_trlTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EDISCFSATO_trlTbl;
    SELECT DISTINCT
         RecordType = 'FF'
        ,RecordCount = (SELECT COUNT(1) FROM dbo.U_EDISCFSATO_ptTbl) + (SELECT COUNT(1) FROM dbo.U_EDISCFSATO_enTbl) + (SELECT COUNT(1) FROM dbo.U_EDISCFSATO_ctTbl)
        ,AdminCode = 'DBI'
        ,EmployerCode = '28576'
        ,SubmitDate = GETDATE()
        ,SubmitTime = REPLACE(CONVERT(VARCHAR(10), GETDATE(), 108), ':', '')
    INTO dbo.U_EDISCFSATO_trlTbl
    FROM dbo.U_EDISCFSATO_EEList WITH (NOLOCK)
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
ALTER VIEW dbo.dsi_vwEDISCFSATO_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISCFSATO_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISCFSATO%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202105171'
       ,expStartPerControl     = '202105171'
       ,expLastEndPerControl   = '202105249'
       ,expEndPerControl       = '202105249'
WHERE expFormatCode = 'EDISCFSATO';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISCFSATO_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EDISCFSATO_File WITH (NOLOCK)
    ORDER BY CASE WHEN LEFT(RecordSet,1) = 'D' THEN 10 ELSE RIGHT(RecordSet,2) END, InitialSort, SubSort;
