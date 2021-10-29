SET NOCOUNT ON;
IF OBJECT_ID('U_E401PENTRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_E401PENTRA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'E401PENTRA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwE401PENTRA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwE401PENTRA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_E401PENTRA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E401PENTRA];
GO
IF OBJECT_ID('U_E401PENTRA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_PDedHist];
GO
IF OBJECT_ID('U_E401PENTRA_File') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_File];
GO
IF OBJECT_ID('U_E401PENTRA_EEList') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_EEList];
GO
IF OBJECT_ID('U_E401PENTRA_drvTermTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvTermTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvTerm') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvTerm];
GO
IF OBJECT_ID('U_E401PENTRA_drvRehireTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvRehireTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvRehire') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvRehire];
GO
IF OBJECT_ID('U_E401PENTRA_drvNewEnrollTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvNewEnrollTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvNewEnroll') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvNewEnroll];
GO
IF OBJECT_ID('U_E401PENTRA_drvMaintTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvMaintTrl];
GO
IF OBJECT_ID('U_E401PENTRA_drvMaintData') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvMaintData];
GO
IF OBJECT_ID('U_E401PENTRA_drvGTTrl') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_drvGTTrl];
GO
IF OBJECT_ID('U_E401PENTRA_DedList') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_DedList];
GO
IF OBJECT_ID('U_E401PENTRA_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_AuditFields];
GO
IF OBJECT_ID('U_E401PENTRA_Audit') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_E401PENTRA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_E401PENTRA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'E401PENTRA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'E401PENTRA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'E401PENTRA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'E401PENTRA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'E401PENTRA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCreateTClockBatches,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhRespectZeroPayRate,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhThirdPartyPay) VALUES ('N','C','Y','0','',NULL,'','N','','N','','013010','EMPEXPORT','SDF','E401PENTRA','401a Pension Elig Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','N','S','N','E401PENTRAZ0','N','Jan  1 1900 12:00AM','C','N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'E401PENTRA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','10','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','10','7',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','10','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','10','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartName"','5','(''UA''=''F'')','E401PENTRAZ0','30','D','10','26',NULL,'Participant Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','E401PENTRAZ0','12','D','10','56',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvForeignAddressCode"','7','(''UA''=''F'')','E401PENTRAZ0','3','D','10','68',NULL,'Foreign Address Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd1"','8','(''UA''=''F'')','E401PENTRAZ0','30','D','10','71',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd2"','9','(''UA''=''F'')','E401PENTRAZ0','30','D','10','101',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''F'')','E401PENTRAZ0','18','D','10','131',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''F'')','E401PENTRAZ0','3','D','10','149',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','12','(''UA''=''F'')','E401PENTRAZ0','9','D','10','152',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','13','(''UA''=''F'')','E401PENTRAZ0','1','D','10','161',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','14','(''UD112''=''F'')','E401PENTRAZ0','8','D','10','162',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','15','(''UD112''=''F'')','E401PENTRAZ0','8','D','10','170',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligPlanEntry"','16','(''UD112''=''F'')','E401PENTRAZ0','8','D','10','178',NULL,'Eligible Plan Entry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStat"','17','(''UA''=''F'')','E401PENTRAZ0','1','D','10','186',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePh"','18','(''UA''=''F'')','E401PENTRAZ0','12','D','10','187',NULL,'Home Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatCode"','19','(''UA''=''F'')','E401PENTRAZ0','2','D','10','199',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','E401PENTRAZ0','32','D','10','201',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPh"','21','(''UA''=''F'')','E401PENTRAZ0','12','D','10','233',NULL,'Work Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','22','(''UA''=''F'')','E401PENTRAZ0','26','D','10','245',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''F'')','E401PENTRAZ0','4','D','10','271',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','24','(''UA''=''F'')','E401PENTRAZ0','11','D','10','275',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmail"','25','(''UA''=''F'')','E401PENTRAZ0','60','D','10','286',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''SS''=''F'')','E401PENTRAZ0','155','D','10','346',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','20','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','20','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','20','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','20','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','E401PENTRAZ0','475','D','20','26',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','30','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','30','7',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','30','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','30','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartName"','5','(''UA''=''F'')','E401PENTRAZ0','30','D','30','26',NULL,'Participant Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','E401PENTRAZ0','12','D','30','56',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','7','(''SS''=''F'')','E401PENTRAZ0','3','D','30','68',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd1"','8','(''UA''=''F'')','E401PENTRAZ0','30','D','30','71',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd2"','9','(''UA''=''F'')','E401PENTRAZ0','30','D','30','101',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCit"','10','(''UA''=''F'')','E401PENTRAZ0','18','D','30','131',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''F'')','E401PENTRAZ0','3','D','30','149',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','12','(''UA''=''F'')','E401PENTRAZ0','9','D','30','152',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','13','(''UA''=''F'')','E401PENTRAZ0','1','D','30','161',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','14','(''UD112''=''F'')','E401PENTRAZ0','8','D','30','162',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','15','(''UD112''=''F'')','E401PENTRAZ0','8','D','30','170',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEntryDt"','16','(''UD112''=''F'')','E401PENTRAZ0','8','D','30','178',NULL,'Plan Entry Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStat"','17','(''UA''=''F'')','E401PENTRAZ0','1','D','30','186',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePh"','18','(''UA''=''F'')','E401PENTRAZ0','12','D','30','187',NULL,'Home Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','19','(''SS''=''F'')','E401PENTRAZ0','2','D','30','199',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','E401PENTRAZ0','32','D','30','201',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPh"','21','(''UA''=''F'')','E401PENTRAZ0','12','D','30','233',NULL,'Work Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','22','(''UA''=''F'')','E401PENTRAZ0','26','D','30','245',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''F'')','E401PENTRAZ0','4','D','30','271',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','24','(''UA''=''F'')','E401PENTRAZ0','11','D','30','275',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''F'')','E401PENTRAZ0','60','D','30','286',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTaxDefAmt"','26','(''UA''=''F'')','E401PENTRAZ0','8','D','30','346',NULL,'Pre-Tax Deferral Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPreTaxDefPrcnt"','27','(''UA''=''F'')','E401PENTRAZ0','8','D','30','354',NULL,'Pre-Tax Deferral Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxDefAmt"','28','(''UA''=''F'')','E401PENTRAZ0','8','D','30','362',NULL,'Post-Tax Deferral Amt',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPostTaxDefPrcnt"','29','(''UA''=''F'')','E401PENTRAZ0','8','D','30','370',NULL,'Post-Tax Deferral Percent',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''SS''=''F'')','E401PENTRAZ0','123','D','30','378',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','40','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','40','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','40','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','40','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','E401PENTRAZ0','475','D','40','26',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','50','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','50','7',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','50','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','50','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','E401PENTRAZ0','45','D','50','26',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd1"','6','(''UA''=''F'')','E401PENTRAZ0','30','D','50','71',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd2"','7','(''UA''=''F'')','E401PENTRAZ0','30','D','50','101',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','8','(''UA''=''F'')','E401PENTRAZ0','18','D','50','131',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','9','(''UA''=''F'')','E401PENTRAZ0','3','D','50','149',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','10','(''UA''=''F'')','E401PENTRAZ0','9','D','50','152',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''SS''=''F'')','E401PENTRAZ0','1','D','50','161',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','12','(''UD112''=''F'')','E401PENTRAZ0','8','D','50','162',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','13','(''SS''=''F'')','E401PENTRAZ0','29','D','50','170',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatCode"','14','(''UA''=''F'')','E401PENTRAZ0','8','D','50','199',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfSep"','15','(''UD112''=''F'')','E401PENTRAZ0','8','D','50','207',NULL,'Date of Separation',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermReasonCode"','16','(''UA''=''F'')','E401PENTRAZ0','1','D','50','215',NULL,'Term Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''SS''=''F'')','E401PENTRAZ0','276','D','50','216',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','60','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','60','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','60','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','60','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','E401PENTRAZ0','475','D','60','26',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','70','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','70','7',NULL,'Participant SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','70','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','70','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartName"','5','(''UA''=''F'')','E401PENTRAZ0','30','D','70','26',NULL,'Participant Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','6','(''SS''=''F'')','E401PENTRAZ0','12','D','70','56',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvForeignAddressCode"','7','(''UA''=''F'')','E401PENTRAZ0','3','D','70','68',NULL,'Foreign Address Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd1"','8','(''UA''=''F'')','E401PENTRAZ0','30','D','70','71',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAdd2"','9','(''UA''=''F'')','E401PENTRAZ0','30','D','70','101',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','10','(''UA''=''F'')','E401PENTRAZ0','18','D','70','131',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','11','(''UA''=''F'')','E401PENTRAZ0','3','D','70','149',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','12','(''UA''=''F'')','E401PENTRAZ0','9','D','70','152',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','13','(''UA''=''F'')','E401PENTRAZ0','1','D','70','161',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBirthDate"','14','(''UD112''=''F'')','E401PENTRAZ0','8','D','70','162',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOH"','15','(''UD112''=''F'')','E401PENTRAZ0','8','D','70','170',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligPlanEntry"','16','(''UD112''=''F'')','E401PENTRAZ0','8','D','70','178',NULL,'Eligible Plan Entry',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStat"','17','(''UA''=''F'')','E401PENTRAZ0','1','D','70','186',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePh"','18','(''UA''=''F'')','E401PENTRAZ0','12','D','70','187',NULL,'Home Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatCode"','19','(''UA''=''F'')','E401PENTRAZ0','2','D','70','199',NULL,'Status Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','20','(''SS''=''F'')','E401PENTRAZ0','32','D','70','201',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPh"','21','(''UA''=''F'')','E401PENTRAZ0','12','D','70','233',NULL,'Work Phone #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvJobTitle"','22','(''UA''=''F'')','E401PENTRAZ0','26','D','70','245',NULL,'Job Title',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','23','(''SS''=''F'')','E401PENTRAZ0','4','D','70','271',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','24','(''UA''=''F'')','E401PENTRAZ0','11','D','70','275',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','25','(''SS''=''F'')','E401PENTRAZ0','215','D','70','286',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','D','80','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','D','80','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','D','80','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','D','80','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','E401PENTRAZ0','475','D','80','26',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRCPlanNum"','1','(''UA''=''F'')','E401PENTRAZ0','6','T','90','1',NULL,'ICMA-RC Plan Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','2','(''UA''=''F'')','E401PENTRAZ0','9','T','90','7',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeqNum"','3','(''UA''=''F'')','E401PENTRAZ0','9','T','90','16',NULL,'Sequence #',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransCode"','4','(''UA''=''F'')','E401PENTRAZ0','1','T','90','25',NULL,'Transaction Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''SS''=''F'')','E401PENTRAZ0','475','T','90','26',NULL,'Filler',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'E401PENTRA_20211027.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'401a Pension Elig Export','202110269','EMPEXPORT','ONDEM_XOE',NULL,'E401PENTRA',NULL,NULL,NULL,'202110269','Oct 26 2021  5:03PM','Oct 26 2021  5:03PM','202110261',NULL,'','','202110261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'401a Pension Elig Export-Sched','202110269','EMPEXPORT','SCH_E401PE',NULL,'E401PENTRA',NULL,NULL,NULL,'202110269','Oct 26 2021  5:03PM','Oct 26 2021  5:03PM','202110261',NULL,'','','202110261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'401a Pension Elig Export-Test','202110269','EMPEXPORT','TEST_XOE',NULL,'E401PENTRA',NULL,NULL,NULL,'202110269','Oct 26 2021  5:03PM','Oct 26 2021  5:03PM','202110261',NULL,'','','202110261',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('E401PENTRA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'E401PENTRA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'E401PENTRA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_E401PENTRA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_E401PENTRA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D10','dbo.U_E401PENTRA_drvNewEnroll',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D20','dbo.U_E401PENTRA_drvNewEnrollTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D30','dbo.U_E401PENTRA_drvMaintData',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D40','dbo.U_E401PENTRA_drvMaintTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D50','dbo.U_E401PENTRA_drvTerm',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D60','dbo.U_E401PENTRA_drvTermTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D70','dbo.U_E401PENTRA_drvRehire',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','D80','dbo.U_E401PENTRA_drvRehireTrl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('E401PENTRA','T90','dbo.U_E401PENTRA_drvGTTrl',NULL);
IF OBJECT_ID('U_dsi_BDM_E401PENTRA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_E401PENTRA] (
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
IF OBJECT_ID('U_E401PENTRA_Audit') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audKey2] varchar(255) NOT NULL,
    [audKey3] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL,
    [audNewHire] varchar(1) NOT NULL,
    [audReHire] varchar(1) NOT NULL,
    [audTerm] varchar(1) NOT NULL,
    [audSalaryChange] varchar(1) NOT NULL,
    [audBenefitChange] varchar(1) NOT NULL
);
IF OBJECT_ID('U_E401PENTRA_AuditFields') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_E401PENTRA_DedList') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_E401PENTRA_drvGTTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvGTTrl] (
    [drvRCPlanNum] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvSeqNum] varchar(1) NOT NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvMaintData') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvMaintData] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] varchar(1) NOT NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvPartName] varchar(1) NOT NULL,
    [drvAdd1] varchar(1) NOT NULL,
    [drvAdd2] varchar(1) NOT NULL,
    [drvCit] varchar(1) NOT NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvDOH] varchar(1) NOT NULL,
    [drvPlanEntryDt] varchar(1) NOT NULL,
    [drvMaritalStat] varchar(1) NOT NULL,
    [drvHomePh] varchar(1) NOT NULL,
    [drvWorkPh] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvSalary] varchar(1) NOT NULL,
    [drvPreTaxDefAmt] varchar(1) NOT NULL,
    [drvPreTaxDefPrcnt] varchar(1) NOT NULL,
    [drvPostTaxDefAmt] varchar(1) NOT NULL,
    [drvPostTaxDefPrcnt] varchar(1) NOT NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvMaintTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvMaintTrl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvSeqNum] varchar(1) NOT NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvNewEnroll') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvNewEnroll] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] bigint NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvPartName] varchar(204) NULL,
    [drvForeignAddressCode] varchar(1) NOT NULL,
    [drvAdd1] varchar(255) NULL,
    [drvAdd2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvBirthDate] datetime NULL,
    [drvDOH] datetime NULL,
    [drvEligPlanEntry] datetime NULL,
    [drvMaritalStat] varchar(1) NOT NULL,
    [drvHomePh] varchar(50) NULL,
    [drvStatCode] varchar(2) NOT NULL,
    [drvWorkPh] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvSalary] money NULL,
    [drvEmail] varchar(50) NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvNewEnrollTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvNewEnrollTrl] (
    [drvEEID] varchar(1) NOT NULL,
    [drvCoID] varchar(1) NOT NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(6) NOT NULL,
    [drvSSN] varchar(9) NOT NULL,
    [drvSeqNum] int NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvRehire') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvRehire] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] varchar(1) NOT NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvPartName] varchar(1) NOT NULL,
    [drvForeignAddressCode] varchar(1) NOT NULL,
    [drvAdd1] varchar(1) NOT NULL,
    [drvAdd2] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvBirthDate] datetime NULL,
    [drvDOH] varchar(1) NOT NULL,
    [drvEligPlanEntry] varchar(1) NOT NULL,
    [drvMaritalStat] varchar(1) NOT NULL,
    [drvHomePh] varchar(1) NOT NULL,
    [drvStatCode] varchar(1) NOT NULL,
    [drvWorkPh] varchar(1) NOT NULL,
    [drvJobTitle] varchar(1) NOT NULL,
    [drvSalary] varchar(1) NOT NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvRehireTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvRehireTrl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvSeqNum] varchar(1) NOT NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvTerm') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvTerm] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(1) NOT NULL,
    [drvPartSSN] char(11) NULL,
    [drvSeqNum] varchar(1) NOT NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvAdd1] varchar(1) NOT NULL,
    [drvAdd2] varchar(1) NOT NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(1) NOT NULL,
    [drvBirthDate] datetime NULL,
    [drvStatCode] varchar(1) NOT NULL,
    [drvDateOfSep] varchar(1) NOT NULL,
    [drvTermReasonCode] char(6) NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_drvTermTrl') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_drvTermTrl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvRCPlanNum] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvSeqNum] varchar(1) NOT NULL,
    [drvTransCode] varchar(1) NOT NULL,
    [drvInitialSort] varchar(10) NULL,
    [drvSubSort] varchar(10) NULL
);
IF OBJECT_ID('U_E401PENTRA_EEList') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_E401PENTRA_File') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_E401PENTRA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_E401PENTRA_PDedHist] (
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
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_E401PENTRA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Trinity River Authority of Texas

Created By: Andy Pineda
Business Analyst: Lea King
Create Date: 10/26/2021
Service Request Number: TekP-2021-09-16-0004

Purpose: 401a Pension Elig Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2021     SR-2021-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'E401PENTRA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'E401PENTRA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'E401PENTRA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'E401PENTRA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'E401PENTRA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E401PENTRA', 'ONDEM_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E401PENTRA', 'TEST_XOE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'E401PENTRA', 'SCH_E401PE';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'E401PENTRA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'E401PENTRA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'E401PENTRA';

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
    DELETE FROM dbo.U_E401PENTRA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_E401PENTRA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'BCPA,BCPN';

    IF OBJECT_ID('U_E401PENTRA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_E401PENTRA_DedList
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
    -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_E401PENTRA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_PDedHist;
    SELECT DISTINCT
         PdhEEID
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
    INTO dbo.U_E401PENTRA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_E401PENTRA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );

      --==========================================
    -- Audit Section
    --==========================================
    -- Get data from audit fields table. Add fields here if auditing
    IF OBJECT_ID('U_E401PENTRA_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_AuditFields;
    CREATE TABLE dbo.U_E401PENTRA_AuditFields (aTableName varchar(30),aFieldName varchar(30));
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecAnnSalary');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecDateOfLastHire');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecDateOfOriginalHire');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecDateOfTermination');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecEmplStatus');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecFullTimeOrPartTime');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecHourlyPayRate');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecSalaryOrHourly');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecScheduledWorkHrs');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpComp','EecTermReason');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpDed','EedBenStartDate');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpDed','EedBenStopDate');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepDateOfBirth');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepGender');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameFirst');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameLast');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameMiddle');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepNameSuffix');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepOldSSN');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpPers','EepSSN');
    INSERT INTO dbo.U_E401PENTRA_AuditFields VALUES ('EmpDedFull', 'EedBenStartDate');

    -- Create audit table based on fields defined above
    IF OBJECT_ID('U_E401PENTRA_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_Audit;
    SELECT 
        audEEID  = audKey1Value
        ,audKey2 = audKey2Value
        ,audKey3 = audKey3Value
        ,audTableName
        ,audFieldName
        ,audAction
        ,audDateTime
        ,audOldValue
        ,audNewValue
        ,audRowNo = ROW_NUMBER() OVER (PARTITION BY audKey1Value, audKey2Value, audKey3Value, audFieldName ORDER BY audDateTime DESC)
        ,audNewHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = '' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audReHire = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audOldValue,'') = 'T' AND ISNULL(audNewValue,'') = 'A' THEN 'Y' ELSE 'N' END
        ,audTerm = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecEmplStatus' AND ISNULL(audNewValue,'') = 'T' THEN 'Y' ELSE 'N' END
        ,audSalaryChange = CASE WHEN audTableName = 'EmpComp' AND audFieldName = 'EecAnnSalary' AND ISNULL(audNewValue,'') <> '' THEN 'Y' ELSE 'N' END
        ,audBenefitChange = CASE WHEN audTableName = 'EmpDedFull' AND audFieldName = 'EedBenStartDate' AND ISNULL(audOldValue, '') <> ISNULL(audNewValue, '') THEN 'Y' ELSE 'N' END
    INTO dbo.U_E401PENTRA_Audit
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.vw_AuditData WITH (NOLOCK) 
        ON audKey1Value = xEEID
    JOIN dbo.U_E401PENTRA_AuditFields WITH (NOLOCK) 
        ON audTableName = aTableName
        AND audFieldName = aFieldName
    WHERE audDateTime BETWEEN @StartDate AND @EndDate
    AND audAction <> 'DELETE'
    AND ISNULL(audNewValue,'') <> '';


    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvNewEnroll
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvNewEnroll','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvNewEnroll;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = '00000000' + ROW_NUMBER() OVER(PARTITION BY xEEID ORDER BY xEEID) 
        ,drvTransCode = 'E'
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '')
        ,drvForeignAddressCode = ''
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvBirthDate = EepDateOfBirth
        ,drvDOH = EecDateOfLastHire
        ,drvEligPlanEntry = EedBenStartDate
        ,drvMaritalStat = CASE WHEN EepMaritalStatus = 'M' THEN '2' ELSE '1' END
        ,drvHomePh = EepPhoneHomeNumber
        ,drvStatCode = '00'
        ,drvWorkPh = ''
        ,drvJobTitle = ''
        ,drvSalary = EecAnnSalary
        ,drvEmail = EepAddressEMail
        ,drvInitialSort = '1'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvNewEnroll
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.U_E401PENTRA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audNewHire = 'Y' 
		AND audReHire = 'N'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvNewEnrollTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvNewEnrollTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvNewEnrollTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvNewEnroll WITH(NOLOCK))
        ,drvTransCode = 'E'
        ,drvInitialSort = '1'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvNewEnrollTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvMaintData
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvMaintData','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvMaintData;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = '00000000' + ROW_NUMBER() OVER(PARTITION BY xEEID ORDER BY xEEID) 
        ,drvTransCode = 'M'
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '')
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCit = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvBirthDate = EepDateOfBirth
        ,drvDOH = EecDateOfLastHire
        ,drvPlanEntryDt = EedBenStartDate
        ,drvMaritalStat = CASE WHEN EepMaritalStatus = 'M' THEN '2' ELSE '1' END
        ,drvHomePh = EepPhoneHomeNumber
        ,drvWorkPh = ''
        ,drvJobTitle = ''
        ,drvSalary = EecAnnSalary
        ,drvPreTaxDefAmt = ''
        ,drvPreTaxDefPrcnt = ''
        ,drvPostTaxDefAmt = ''
        ,drvPostTaxDefPrcnt = ''
        ,drvInitialSort = '2'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvMaintData
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.U_E401PENTRA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audBenefitChange = 'Y'
        AND audNewHire = 'N'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvMaintTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvMaintTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvMaintTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvMaintData WITH(NOLOCK))
        ,drvTransCode = 'M'
        ,drvInitialSort = '2'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvMaintTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvTerm
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvTerm','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvTerm;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = '00000000' + ROW_NUMBER() OVER(PARTITION BY xEEID ORDER BY xEEID) 
        ,drvTransCode = 'T'
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvBirthDate = EepDateOfBirth
        ,drvStatCode = '30'
        ,drvDateOfSep = EecDateOfTermination
        ,drvTermReasonCode = 'V'
        ,drvInitialSort = '3'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvTerm
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.vw_int_EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.U_E401PENTRA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audTerm = 'Y'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvTermTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvTermTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvTermTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvTerm WITH(NOLOCK))
        ,drvTransCode = 'T'
        ,drvInitialSort = '3'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvTermTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvRehire
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvRehire','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvRehire;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvPartSSN = eepSSN
        ,drvSeqNum = '00000000' + ROW_NUMBER() OVER(PARTITION BY xEEID ORDER BY xEEID) 
        ,drvTransCode = 'R'
        ,drvPartName = LTRIM(RTRIM(EepNameLast)) + ', ' + LTRIM(RTRIM(EepNameFirst)) + ' ' + ISNULL(LEFT(EepNameMiddle, 1), '')
        ,drvForeignAddressCode = ''
        ,drvAdd1 = EepAddressLine1
        ,drvAdd2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvGender = CASE WHEN EepGender = 'M' THEN '1' ELSE '2' END
        ,drvBirthDate = EepDateOfBirth
        ,drvDOH = EecDateOfLastHire
        ,drvEligPlanEntry = EedBenStartDate
        ,drvMaritalStat = CASE WHEN EepMaritalStatus = 'M' THEN '2' ELSE '1' END
        ,drvHomePh = EepPhoneHomeNumber
        ,drvStatCode = '00'
        ,drvWorkPh = ''
        ,drvJobTitle = ''
        ,drvSalary = EecAnnSalary
        ,drvInitialSort = '4'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvRehire
    FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.EmpComp WITH(NOLOCK)
        ON EecEEID = xEEID
        AND EecCOID = xCOID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_bdm_EmpDeductions WITH(NOLOCK)
        ON EedEEID = xEEID
        AND EedCOID = xCOID
        AND EedFormatCode = @FormatCode
        AND EedValidForExport = 'Y'
    JOIN dbo.U_E401PENTRA_Audit WITH(NOLOCK)
        ON audEEID = xEEID
        AND audKey2 = xCOID
        AND audRehire = 'Y'
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID

    ;
    ---------------------------------
    -- DETAIL RECORD - U_E401PENTRA_drvRehireTrl
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvRehireTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvRehireTrl;
    SELECT DISTINCT
         drvEEID = '1'
        ,drvCoID = '1'
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvRehire WITH(NOLOCK))
        ,drvTransCode = 'R'
        ,drvInitialSort = '4'
        ,drvSubSort = '1'
    INTO dbo.U_E401PENTRA_drvRehireTrl
   -- FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_E401PENTRA_drvGTTrl','U') IS NOT NULL
        DROP TABLE dbo.U_E401PENTRA_drvGTTrl;
    SELECT DISTINCT
         drvRCPlanNum = '100226'
        ,drvSSN = '000000000'
        ,drvSeqNum = (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvNewEnroll WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvMaintData WITH(NOLOCK))
                        + (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvTerm WITH(NOLOCK)) + (SELECT COUNT(1) FROM dbo.U_E401PENTRA_drvRehire WITH(NOLOCK))
        ,drvTransCode = '*'
        ,drvInitialSort = '5'
        ,drvSubSort = '0'
    INTO dbo.U_E401PENTRA_drvGTTrl
    --FROM dbo.U_E401PENTRA_EEList WITH (NOLOCK)
    --JOIN dbo.EmpPers WITH (NOLOCK)
    --    ON EepEEID = xEEID
    --JOIN dbo.EmpComp WITH(NOLOCK)
    --    ON EecEEID = xEEID
    --    AND EecCOID = xCOID
    --JOIN dbo.U_dsi_BDM_E401PENTRA WITH (NOLOCK)
    --    ON BdmEEID = xEEID 
    --    AND BdmCoID = xCoID
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
ALTER VIEW dbo.dsi_vwE401PENTRA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_E401PENTRA_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'E401PENTRA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202110191'
       ,expStartPerControl     = '202110191'
       ,expLastEndPerControl   = '202110269'
       ,expEndPerControl       = '202110269'
WHERE expFormatCode = 'E401PENTRA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwE401PENTRA_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_E401PENTRA_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort