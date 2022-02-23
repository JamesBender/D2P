SET NOCOUNT ON;
IF OBJECT_ID('U_EDISUSOFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISUSOFSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISUSOFSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISUSOFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISUSOFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISUSOFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISUSOFSA];
GO
IF OBJECT_ID('U_EDISUSOFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_PEarHist];
GO
IF OBJECT_ID('U_EDISUSOFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_PDedHist];
GO
IF OBJECT_ID('U_EDISUSOFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_Header];
GO
IF OBJECT_ID('U_EDISUSOFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_File];
GO
IF OBJECT_ID('U_EDISUSOFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_EEList];
GO
IF OBJECT_ID('U_EDISUSOFSA_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_drvTrailer];
GO
IF OBJECT_ID('U_EDISUSOFSA_drvParticipant') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_drvParticipant];
GO
IF OBJECT_ID('U_EDISUSOFSA_drvEnrollment') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_drvEnrollment];
GO
IF OBJECT_ID('U_EDISUSOFSA_drvContribution') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_drvContribution];
GO
IF OBJECT_ID('U_EDISUSOFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISUSOFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISUSOFSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISUSOFSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISUSOFSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISUSOFSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISUSOFSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISUSOFSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EDISUSOFSA','Discovery FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EDISUSOFSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISUSOFSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderRecordType"','1','(''UA''=''T|'')','EDISUSOFSAZ0','2','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderAdminCode"','2','(''UA''=''T|'')','EDISUSOFSAZ0','3','H','01','4',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderEmployerCode"','3','(''UA''=''T|'')','EDISUSOFSAZ0','6','H','01','8',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSyncFlag"','4','(''UA''=''T|'')','EDISUSOFSAZ0','1','H','01','15',NULL,'Synchronize Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSubmittedDate"','5','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','H','01','17',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSubmittedTime"','6','(''UDHMS''=''T|'')','EDISUSOFSAZ0','6','H','01','26',NULL,'Submitted Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderFileVersion"','7','(''UA''=''T'')','EDISUSOFSAZ0','6','H','01','33',NULL,'File Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRecType"','1','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPatFileImportId"','2','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','4',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmployerId"','3','(''UA''=''T|'')','EDISUSOFSAZ0','20','D','10','55',NULL,'Employer Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmployerNumber"','4','(''UA''=''T|'')','EDISUSOFSAZ0','15','D','10','76',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLastName"','5','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','10','92',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFirstName"','6','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','10','123',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMiddleInitial"','7','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','10','154',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartGender"','8','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','10','156',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMaritalStatus"','9','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','10','158',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMothersMaidenName"','10','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','160',NULL,'Mothers Maiden Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDateofBirth"','11','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','211',NULL,'Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','12','(''UA''=''T|'')','EDISUSOFSAZ0','9','D','10','220',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine1"','13','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','230',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine2"','14','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','281',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine3"','15','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','332',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine4"','16','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','383',NULL,'Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCity"','17','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','10','434',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartState"','18','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','10','465',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartZipCode"','19','(''UA''=''T|'')','EDISUSOFSAZ0','10','D','10','468',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCountry"','20','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','10','479',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHomePhone"','21','(''UA''=''T|'')','EDISUSOFSAZ0','10','D','10','482',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartWorkPhone"','22','(''UA''=''T|'')','EDISUSOFSAZ0','10','D','10','493',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartWorkPhoneExt"','23','(''UA''=''T|'')','EDISUSOFSAZ0','6','D','10','504',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmailAddress"','24','(''UA''=''T|'')','EDISUSOFSAZ0','125','D','10','511',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartUserName"','25','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','637',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPassword"','26','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','738',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHireDate"','27','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','839',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDivision"','28','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','848',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoursPerWeek"','29','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','10','949',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmpClass"','30','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','952',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrollFreq"','31','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','1053',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrollFreEffDate"','32','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','1154',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPartStatus"','33','(''UA''=''T|'')','EDISUSOFSAZ0','20','D','10','1163',NULL,'Participant Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartStatusEffDate"','34','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','1184',NULL,'Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoldPayrollDed"','35','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','10','1193',NULL,'Hold Payroll Deductions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoldERContributions"','36','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','10','1195',NULL,'Hold Employer Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIncurServices"','37','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','10','1197',NULL,'Incur Services',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFinalPayrollProDate"','38','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','1199',NULL,'Final Payroll Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFinalContribProDate"','39','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','1208',NULL,'Final Contribution Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHSACustodian"','40','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','1217',NULL,'HSA Custodian',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMedicareBen"','41','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','10','1318',NULL,'Medicare Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMedId"','42','(''UA''=''T|'')','EDISUSOFSAZ0','12','D','10','1320',NULL,'Medicare ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartExcIntegId"','43','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','1333',NULL,'Exchange Integration ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel1"','44','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','1384',NULL,'Reporting Hierarchy Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel2"','45','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','1485',NULL,'Reporting Hierarchy Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel3"','46','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','1586',NULL,'Reporting Hierarchy Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel4"','47','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','10','1687',NULL,'Reporting Hierarchy Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDCitizenship"','48','(''UA''=''T|'')','EDISUSOFSAZ0','20','D','10','1788',NULL,'CDD_Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDCountry"','49','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','10','1809',NULL,'CDD_Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDEmploymentStats"','50','(''UA''=''T|'')','EDISUSOFSAZ0','20','D','10','1812',NULL,'CDD_Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDEmployer"','51','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','10','1833',NULL,'CDD_Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDJObTitle"','52','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','10','1864',NULL,'CDD_JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartClassEffDate"','53','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','1895',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDType"','54','(''UA''=''T|'')','EDISUSOFSAZ0','20','D','10','1904',NULL,'ID_Identification Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDNumber"','55','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','10','1925',NULL,'ID_Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDState"','56','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','10','1956',NULL,'ID_IssuingState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDIssuer"','57','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','10','1959',NULL,'ID_Issuer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDIssueDate"','58','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','2010',NULL,'ID_IssueDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDExpirationDate"','59','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','10','2019',NULL,'ID_ExpirationDa te',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMobileCarrier"','60','(''UA''=''T|'')','EDISUSOFSAZ0','20','D','10','2028',NULL,'Mobile Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMobileNumber"','61','(''UA''=''T|'')','EDISUSOFSAZ0','10','D','10','2049',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTimezone"','62','(''UA''=''T'')','EDISUSOFSAZ0','15','D','10','2060',NULL,'Time Zone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENRecordType"','1','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPartFileImportId"','2','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','20','4',NULL,'Participant File Import Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPlanName"','3','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','20','55',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENEffectiveDate"','4','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','20','156',NULL,'Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPartElectionAmt"','5','(''UA''=''T|'')','EDISUSOFSAZ0','8','D','20','165',NULL,'Participant Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTerminationDate"','6','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','20','174',NULL,'Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTERContribLEvel"','7','(''UA''=''T|'')','EDISUSOFSAZ0','10','D','20','183',NULL,'Employer Contribution Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTERContAmt"','8','(''UA''=''T|'')','EDISUSOFSAZ0','8','D','20','194',NULL,'Employer Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTPrimaryReimburse"','9','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','20','203',NULL,'Primary Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTAlternateReimburse"','10','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','20','234',NULL,'Alternate Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTEnrolledInClaims"','11','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','20','265',NULL,'Enrolled In Claims Exchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTElectionAmtInd"','12','(''UA''=''T|'')','EDISUSOFSAZ0','8','D','20','267',NULL,'Election Amount Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTHDHPCovLevel"','13','(''UA''=''T|'')','EDISUSOFSAZ0','6','D','20','276',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTPlanYearStartDate"','14','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','20','283',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAccept"','15','(''UA''=''T|'')','EDISUSOFSAZ0','1','D','20','292',NULL,'Terms and Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAcceptDate"','16','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','20','294',NULL,'Date Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAcceptTime"','17','(''HMS''=''T|'')','EDISUSOFSAZ0','6','D','20','303',NULL,'Time Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTChangeDate"','18','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','20','310',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTSpendDown"','19','(''UA''=''T'')','EDISUSOFSAZ0','1','D','20','319',NULL,'Spend Down',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRecordType"','1','(''UA''=''T|'')','EDISUSOFSAZ0','2','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTPartFileImportId"','2','(''UA''=''T|'')','EDISUSOFSAZ0','50','D','30','4',NULL,'Participant File Import Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTPlanName"','3','(''UA''=''T|'')','EDISUSOFSAZ0','100','D','30','55',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTDate"','4','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','D','30','156',NULL,'Contribution Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOntDesc"','5','(''UA''=''T|'')','EDISUSOFSAZ0','30','D','30','165',NULL,'Contribution Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOntAmt"','6','(''UA''=''T|'')','EDISUSOFSAZ0','9','D','30','196',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOntAmountType"','7','(''UA''=''T|'')','EDISUSOFSAZ0','6','D','30','206',NULL,'Amount Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContTaxYear"','8','(''UA''=''T'')','EDISUSOFSAZ0','7','D','30','213',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecordType"','1','(''UA''=''T|'')','EDISUSOFSAZ0','2','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecCount"','2','(''UA''=''T|'')','EDISUSOFSAZ0','20','T','90','4',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerAdminCode"','3','(''UA''=''T|'')','EDISUSOFSAZ0','3','T','90','25',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerEmployerCode"','4','(''UA''=''T|'')','EDISUSOFSAZ0','6','T','90','29',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerSubmittedDate"','5','(''UDMDY''=''T|'')','EDISUSOFSAZ0','8','T','90','36',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTraillerSubmitedTime"','6','(''UDHMS''=''T'')','EDISUSOFSAZ0','6','T','90','45',NULL,'Submitted Time',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISUSOFSA_20210113.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Active Open Enrollment Export','202101019','EMPEXPORT','OEACTIVE','Dec 21 2020 11:00AM','EDISUSOFSA',NULL,NULL,NULL,'202101019','Jan  1 2021 12:00AM','Dec 30 1899 12:00AM','202101011','535','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3mLaUSO1001',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202001309','EMPEXPORT','OEPASSIVE',NULL,'EDISUSOFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Eligibility Expo','202001309','EMPEXPORT','ONDEMAND',NULL,'EDISUSOFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','202001309','EMPEXPORT','SCHEDULED',NULL,'EDISUSOFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202101159','EMPEXPORT','TEST','Jan 13 2021  8:58AM','EDISUSOFSA',NULL,NULL,NULL,'202101159','Jan 15 2021 12:00AM','Dec 30 1899 12:00AM','202101151','975','','','202101151',dbo.fn_GetTimedKey(),NULL,'us3lKiUSO1001A',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISUSOFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISUSOFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISUSOFSA','InitialSort','C','initialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISUSOFSA','SubSort','C','subSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISUSOFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISUSOFSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISUSOFSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISUSOFSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISUSOFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISUSOFSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISUSOFSA','H01','dbo.U_EDISUSOFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISUSOFSA','D10','dbo.U_EDISUSOFSA_drvParticipant',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISUSOFSA','D20','dbo.U_EDISUSOFSA_drvEnrollment',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISUSOFSA','D30','dbo.U_EDISUSOFSA_drvContribution',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISUSOFSA','T90','dbo.U_EDISUSOFSA_drvTrailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISUSOFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISUSOFSA] (
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
IF OBJECT_ID('U_EDISUSOFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISUSOFSA_drvContribution') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_drvContribution] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [initialSort] varchar(12) NULL,
    [subSort] varchar(1) NOT NULL,
    [drvCONTRecordType] varchar(2) NOT NULL,
    [drvCONTPartFileImportId] varchar(9) NULL,
    [drvCONTPlanName] varchar(22) NULL,
    [drvCONTDate] datetime NULL,
    [drvCOntDesc] varchar(21) NOT NULL,
    [drvCOntAmt] varchar(12) NULL,
    [drvCOntAmountType] varchar(6) NOT NULL,
    [drvContTaxYear] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISUSOFSA_drvEnrollment') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_drvEnrollment] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [initialSort] varchar(12) NULL,
    [subSort] varchar(1) NOT NULL,
    [drvENRecordType] varchar(2) NOT NULL,
    [drvENPartFileImportId] varchar(9) NULL,
    [drvENPlanName] varchar(22) NULL,
    [drvENEffectiveDate] datetime NULL,
    [drvENPartElectionAmt] varchar(12) NULL,
    [drvENTerminationDate] datetime NULL,
    [drvENTERContribLEvel] varchar(1) NOT NULL,
    [drvENTERContAmt] varchar(1) NOT NULL,
    [drvENTPrimaryReimburse] varchar(1) NOT NULL,
    [drvENTAlternateReimburse] varchar(1) NOT NULL,
    [drvENTEnrolledInClaims] varchar(1) NOT NULL,
    [drvENTElectionAmtInd] varchar(8) NULL,
    [drvENTHDHPCovLevel] varchar(6) NULL,
    [drvENTPlanYearStartDate] datetime NULL,
    [drvENTermsCondAccept] varchar(1) NOT NULL,
    [drvENTermsCondAcceptDate] varchar(1) NOT NULL,
    [drvENTChangeDate] varchar(1) NOT NULL,
    [drvENTSpendDown] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISUSOFSA_drvParticipant') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_drvParticipant] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [initialSort] varchar(12) NULL,
    [subSort] varchar(1) NOT NULL,
    [drvPartRecType] varchar(2) NOT NULL,
    [drvPatFileImportId] varchar(9) NULL,
    [drvPartEmployerId] varchar(1) NOT NULL,
    [drvPartEmployerNumber] varchar(9) NULL,
    [drvPartLastName] varchar(100) NULL,
    [drvPartFirstName] varchar(100) NULL,
    [drvPartMiddleInitial] varchar(1) NULL,
    [drvPartGender] char(1) NULL,
    [drvPartMaritalStatus] varchar(1) NOT NULL,
    [drvPartMothersMaidenName] varchar(1) NOT NULL,
    [drvPartDateofBirth] datetime NULL,
    [drvPartSSN] char(11) NULL,
    [drvPartAddressLine1] varchar(6000) NULL,
    [drvPartAddressLine2] varchar(6000) NULL,
    [drvPartAddressLine3] varchar(1) NOT NULL,
    [drvPartAddressLine4] varchar(1) NOT NULL,
    [drvPartCity] varchar(6000) NULL,
    [drvPartState] varchar(255) NULL,
    [drvPartZipCode] varchar(50) NULL,
    [drvPartCountry] varchar(2) NOT NULL,
    [drvPartHomePhone] varchar(1) NOT NULL,
    [drvPartWorkPhone] varchar(1) NOT NULL,
    [drvPartWorkPhoneExt] varchar(1) NOT NULL,
    [drvPartEmailAddress] varchar(50) NULL,
    [drvPartUserName] varchar(1) NOT NULL,
    [drvPartPassword] varchar(1) NOT NULL,
    [drvPartHireDate] datetime NULL,
    [drvPartDivision] varchar(1) NOT NULL,
    [drvPartHoursPerWeek] varchar(1) NOT NULL,
    [drvPartEmpClass] varchar(1) NOT NULL,
    [drvPartPayrollFreq] varchar(7) NOT NULL,
    [drvPartPayrollFreEffDate] varchar(1) NOT NULL,
    [drvPartPartStatus] varchar(10) NOT NULL,
    [drvPartStatusEffDate] datetime NULL,
    [drvPartHoldPayrollDed] varchar(1) NOT NULL,
    [drvPartHoldERContributions] varchar(1) NOT NULL,
    [drvPartIncurServices] varchar(1) NOT NULL,
    [drvPartFinalPayrollProDate] datetime NULL,
    [drvPartFinalContribProDate] datetime NULL,
    [drvPartHSACustodian] varchar(1) NOT NULL,
    [drvPartMedicareBen] varchar(1) NOT NULL,
    [drvPartMedId] varchar(1) NOT NULL,
    [drvPartExcIntegId] varchar(1) NOT NULL,
    [drvReportHierLevel1] varchar(1) NOT NULL,
    [drvReportHierLevel2] varchar(1) NOT NULL,
    [drvReportHierLevel3] varchar(1) NOT NULL,
    [drvReportHierLevel4] varchar(1) NOT NULL,
    [drvPartCCDCitizenship] varchar(1) NOT NULL,
    [drvPartCCDCountry] varchar(1) NOT NULL,
    [drvPartCCDEmploymentStats] varchar(1) NOT NULL,
    [drvPartCCDEmployer] varchar(1) NOT NULL,
    [drvPartCCDJObTitle] varchar(1) NOT NULL,
    [drvPartClassEffDate] varchar(1) NOT NULL,
    [drvPartIDType] varchar(1) NOT NULL,
    [drvPartIDNumber] varchar(1) NOT NULL,
    [drvPartIDState] varchar(1) NOT NULL,
    [drvPartIDIssuer] varchar(1) NOT NULL,
    [drvPartIDIssueDate] varchar(1) NOT NULL,
    [drvPartIDExpirationDate] varchar(1) NOT NULL,
    [drvPartMobileCarrier] varchar(1) NOT NULL,
    [drvPartMobileNumber] varchar(1) NOT NULL,
    [drvPartTimezone] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISUSOFSA_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_drvTrailer] (
    [drvTrailerRecordType] varchar(2) NOT NULL,
    [drvTrailerRecCount] varchar(20) NULL,
    [drvTrailerAdminCode] varchar(3) NOT NULL,
    [drvTrailerEmployerCode] varchar(5) NOT NULL,
    [drvTrailerSubmittedDate] datetime NOT NULL,
    [drvTraillerSubmitedTime] datetime NOT NULL
);
IF OBJECT_ID('U_EDISUSOFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISUSOFSA_File') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);
IF OBJECT_ID('U_EDISUSOFSA_Header') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_Header] (
    [drvHeaderRecordType] varchar(2) NOT NULL,
    [drvHeaderAdminCode] varchar(3) NOT NULL,
    [drvHeaderEmployerCode] varchar(5) NOT NULL,
    [drvHeaderSyncFlag] varchar(1) NOT NULL,
    [drvHeaderSubmittedDate] datetime NOT NULL,
    [drvHeaderSubmittedTime] datetime NOT NULL,
    [drvHeaderFileVersion] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EDISUSOFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [DedCode] varchar(5) NULL,
    [HFSA] numeric NULL,
    [DCFSA] numeric NULL,
    [LPFSA] numeric NULL,
    [DBMST] numeric NULL,
    [DBPKG] numeric NULL,
    [ERHSA] numeric NULL,
    [HSA] numeric NULL
);
IF OBJECT_ID('U_EDISUSOFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISUSOFSA_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISUSOFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: US Olympic Committee

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 01/30/2020
Service Request Number: TekP-2019-11-26-001

Purpose: Discovery FSA Eligibility Export V2

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISUSOFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISUSOFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISUSOFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISUSOFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISUSOFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISUSOFSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISUSOFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISUSOFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISUSOFSA', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISUSOFSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISUSOFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISUSOFSA';

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
    DELETE FROM dbo.U_EDISUSOFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISUSOFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'DCFSA,HFSA,LPFSA,DBPKG,DBMST,HSAEE, HSAFM, HSFCU, HSICU,ERHSA';

    IF OBJECT_ID('U_EDISUSOFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISUSOFSA_DedList
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
    
    IF @ExportCode LIKE '%PASSIVE' or @ExportCode LIKE '%ACTIVE'
    BEGIN
       Delete from dbo.U_dsi_BDM_EDISUSOFSA where ISNULL(bdmbenstatus,'') <> 'A'
    END;
    
    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EDISUSOFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,DedCode =  CASE WHEN PdhDedCode IN ('HFSA') THEN 'HFSA'
                         WHEN PdhDedCode IN ('DCFSA') THEN 'DCFSA'
                         WHEN PdhDedCode IN ('LPFSA') THEN 'LPFSA'
                         WHEN PdhDedCode IN ('LPFSA') THEN 'LPFSA'
                         WHEN PdhDedCode IN ('DBMST') THEN 'DBMST'
                         WHEN PdhDedCode IN ('DBPKG') THEN 'DBPKG'
                         WHEN PdhDedCode IN ('ERHSA') THEN 'ERHSA'
                         WHEN PdhDedCode IN ('HSAEE','HSAFM','HSFCU','HSICU') THEN 'HSA'
                    END
        ,HFSA     = SUM(CASE WHEN PdhDedCode IN ('HFSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,DCFSA     = SUM(CASE WHEN PdhDedCode IN ('DCFSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,LPFSA     = SUM(CASE WHEN PdhDedCode IN ('LPFSA') THEN PdhEECurAmt ELSE 0.00 END)        
        ,DBMST     = SUM(CASE WHEN PdhDedCode IN ('DBMST') THEN PdhEECurAmt ELSE 0.00 END)      
        ,DBPKG      = SUM(CASE WHEN PdhDedCode IN ('DBPKG') THEN PdhEECurAmt ELSE 0.00 END) 
        ,ERHSA      = SUM(CASE WHEN PdhDedCode IN ('ERHSA') THEN PdhEECurAmt ELSE 0.00 END) 
        ,HSA      =  SUM(CASE WHEN PdhDedCode IN ('HSAEE','HSAFM','HSFCU','HSICU') THEN PdhEECurAmt ELSE 0.00 END) 

        
    INTO dbo.U_EDISUSOFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDISUSOFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID,CASE WHEN PdhDedCode IN ('HFSA') THEN 'HFSA'
                         WHEN PdhDedCode IN ('DCFSA') THEN 'DCFSA'
                         WHEN PdhDedCode IN ('LPFSA') THEN 'LPFSA'
                         WHEN PdhDedCode IN ('LPFSA') THEN 'LPFSA'
                         WHEN PdhDedCode IN ('DBMST') THEN 'DBMST'
                         WHEN PdhDedCode IN ('DBPKG') THEN 'DBPKG'
                         WHEN PdhDedCode IN ('ERHSA') THEN 'ERHSA'
                         WHEN PdhDedCode IN ('HSAEE','HSAFM','HSFCU','HSICU') THEN 'HSA'
                    END
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EDISUSOFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_PEarHist;
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
    INTO dbo.U_EDISUSOFSA_PEarHist
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
    ---------------------------------
    -- DETAIL RECORD - U_EDISUSOFSA_drvParticipant
    ---------------------------------
    IF OBJECT_ID('U_EDISUSOFSA_drvParticipant','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_drvParticipant;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,initialSort = '2' + eepSSN
        ,subSort = '1'
        -- standard fields above and additional driver fields below
        ,drvPartRecType = 'PT'
        ,drvPatFileImportId = substring(eecEmpNo, patindex('%[^0]%',eecEmpNo), 10)
        ,drvPartEmployerId = ''
        ,drvPartEmployerNumber =  substring(eecEmpNo, patindex('%[^0]%',eecEmpNo), 10)
        ,drvPartLastName = EepNameLast
        ,drvPartFirstName = EepNameFirst
        ,drvPartMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvPartGender = EepGender
        ,drvPartMaritalStatus = ''
        ,drvPartMothersMaidenName = ''
        ,drvPartDateofBirth = EepDateOfBirth
        ,drvPartSSN = eepSSN
        ,drvPartAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvPartAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvPartAddressLine3 = ''
        ,drvPartAddressLine4 = ''
        ,drvPartCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity) 
        ,drvPartState = EepAddressState
        ,drvPartZipCode = EepAddressZipCode
        ,drvPartCountry = 'US'
        ,drvPartHomePhone = ''
        ,drvPartWorkPhone = ''
        ,drvPartWorkPhoneExt = ''
        ,drvPartEmailAddress = EepAddressEMail
        ,drvPartUserName = ''
        ,drvPartPassword = ''
        ,drvPartHireDate = EecDateOfLastHire
        ,drvPartDivision = ''
        ,drvPartHoursPerWeek = ''
        ,drvPartEmpClass = 'E'
        ,drvPartPayrollFreq = 'Payroll'
        ,drvPartPayrollFreEffDate = ''
        ,drvPartPartStatus = CASE WHEN EecEmplStatus = 'T' then 'Terminated' ELSE 'Active' END
        ,drvPartStatusEffDate = CASE WHEN EecEmplStatus = 'T' then eecdateoftermination ELSE eecdateoflasthire END
        ,drvPartHoldPayrollDed = ''
        ,drvPartHoldERContributions = ''
        ,drvPartIncurServices = ''
        ,drvPartFinalPayrollProDate = CASE WHEN EecEmplStatus = 'T' then DateAdd(day,30,eecdateoftermination)  END
        ,drvPartFinalContribProDate = CASE WHEN EecEmplStatus = 'T' then DateAdd(day,30,eecdateoftermination)  END
        ,drvPartHSACustodian = ''
        ,drvPartMedicareBen = ''
        ,drvPartMedId = ''
        ,drvPartExcIntegId = ''
        ,drvReportHierLevel1 = ''
        ,drvReportHierLevel2 = ''
        ,drvReportHierLevel3 = ''
        ,drvReportHierLevel4 = ''
        ,drvPartCCDCitizenship = ''
        ,drvPartCCDCountry = ''
        ,drvPartCCDEmploymentStats = ''
        ,drvPartCCDEmployer = ''
        ,drvPartCCDJObTitle = ''
        ,drvPartClassEffDate = ''
        ,drvPartIDType = ''
        ,drvPartIDNumber = ''
        ,drvPartIDState = ''
        ,drvPartIDIssuer = ''
        ,drvPartIDIssueDate = ''
        ,drvPartIDExpirationDate = ''
        ,drvPartMobileCarrier = ''
        ,drvPartMobileNumber = ''
        ,drvPartTimezone = ''
    INTO dbo.U_EDISUSOFSA_drvParticipant
    FROM dbo.U_EDISUSOFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EDISUSOFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        
        --and ISNULL(bdmbenstatus,'') = 'A'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISUSOFSA_drvEnrollment
    ---------------------------------
    IF OBJECT_ID('U_EDISUSOFSA_drvEnrollment','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_drvEnrollment;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,initialSort = '2' + eepSSN
        ,subSort = '2'
        -- standard fields above and additional driver fields below
        ,drvENRecordType = 'EN'
        ,drvENPartFileImportId =  substring(eecEmpNo, patindex('%[^0]%',eecEmpNo), 10)
        ,drvENPlanName = CASE WHEN BdmDedCode in ('HFSA') THEN 'Medical FSA'
                              WHEN BdmDedCode in ('DCFSA') THEN 'Dependent Care'
                              WHEN BdmDedCode in ('LPFSA') THEN 'Limited Medical FSA'
                              WHEN BdmDedCode in ('DBMST') THEN 'Mass Transit'
                              WHEN BdmDedCode in ('DBPKG') THEN 'Parking'
                              WHEN BdmDedCode in ('HSAEE', 'HSAFM', 'HSFCU', 'HSICU') THEN 'Health Savings Account'

                                                            

                         END
        ,drvENEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate,  CAST( ('01/01/' + CAST( YEAR(GETDATE()) as varchar(4))) as DateTime))

        ,drvENPartElectionAmt = CASE WHEN bdmdedcode in ('HFSA','DCFSA','LPFSA') THEN  CAST(CONVERT(Decimal(10,2),bdmEEGoalAmt) as varchar(12))
                                    WHEN bdmdedcode in ('DBMST','DBPKG','LPFSA') THEN  CAST(CONVERT(Decimal(10,2),bdmEEGoalAmt / 12 ) as varchar(12))
                                     END
        ,drvENTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN bdmBenStopDate END
        ,drvENTERContribLEvel = ''
        ,drvENTERContAmt = ''
        ,drvENTPrimaryReimburse = ''
        ,drvENTAlternateReimburse = ''
        ,drvENTEnrolledInClaims = ''
        ,drvENTElectionAmtInd = CASE WHEN bdmDedcode in ('DBMST','DBPKG') THEN 'PerMonth' 
                                     WHEN BdmDedCode in ('HSAEE', 'HSAFM', 'HSFCU', 'HSICU') THEN 'PerPay'

                                    End
        ,drvENTHDHPCovLevel = CASE
                                     WHEN BdmDedCode in ('HSAEE', 'HSICU') THEN 'Single'
                                     WHEN BdmDedCode in ( 'HSAFM', 'HSFCU') THEN 'Family'

                                    End
        ,drvENTPlanYearStartDate =  CAST( ('01/01/' + CAST( YEAR(@EndDate) as varchar(4))) as DateTime)
        ,drvENTermsCondAccept = ''
        ,drvENTermsCondAcceptDate = ''
        ,drvENTChangeDate = ''
        ,drvENTSpendDown = ''
    INTO dbo.U_EDISUSOFSA_drvEnrollment
    FROM dbo.U_EDISUSOFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISUSOFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        and bdmdedcode not in ('ERHSA')
        --And eecdateoftermination >= CAST('1/1/2021' as datetime)

        --and ISNULL(bdmbenstatus,'') = 'A'

    Delete from dbo.U_EDISUSOFSA_drvParticipant where drvPartPartStatus = 'Terminated' and drvPartStatusEffDate <= CAST('1/1/2021' as datetime)
    Delete from dbo.U_EDISUSOFSA_drvEnrollment where drveeid not in (Select drveeid from dbo.U_EDISUSOFSA_drvParticipant )
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISUSOFSA_drvContribution
    ---------------------------------
    IF OBJECT_ID('U_EDISUSOFSA_drvContribution','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_drvContribution;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,initialSort = '2' + eepSSN
        ,subSort = '3'
        -- standard fields above and additional driver fields below
        ,drvCONTRecordType = 'CT'
        ,drvCONTPartFileImportId =  substring(eecEmpNo, patindex('%[^0]%',eecEmpNo), 10)
        ,drvCONTPlanName = CASE WHEN dedcode in ('HFSA') THEN 'Medical FSA'
                              WHEN dedcode in ('DCFSA') THEN 'Dependent Care'
                              WHEN dedcode in ('LPFSA') THEN 'Limited Medical FSA'
                              WHEN dedcode in ('DBMST') THEN 'Mass Transit'
                              WHEN dedcode in ('DBPKG ') THEN 'Parking'
                              WHEN dedcode in ('HSA','ERHSA') THEN 'Health Savings Account'

                         END
        ,drvCONTDate = PrgPayDate
        ,drvCOntDesc = CASE WHEN dedcode = 'ERHSA' and ERHSA > 0 THEN 'Employer Contribution' ELSE 'Payroll Deduction' END
        ,drvCOntAmt = CASE WHEN dedcode in ('HFSA') THEN CAST(CONVERT(Decimal(10,2),HFSA) as VARCHAR(12))
                              WHEN dedcode in ('DCFSA') THEN CAST(CONVERT(Decimal(10,2),DCFSA) as VARCHAR(12))
                              WHEN dedcode in ('LPFSA') THEN CAST(CONVERT(Decimal(10,2),LPFSA) as VARCHAR(12))
                              WHEN dedcode in ('DBMST') THEN CAST(CONVERT(Decimal(10,2),DBMST) as VARCHAR(12))
                              WHEN dedcode in ('DBPKG') THEN CAST(CONVERT(Decimal(10,2),DBPKG) as VARCHAR(12))
                              WHEN dedcode in ('HSA') THEN CAST(CONVERT(Decimal(10,2),HSA) as VARCHAR(12))
                              WHEN dedcode in ('ERHSA') THEN CAST(CONVERT(Decimal(10,2),ERHSA) as VARCHAR(12))

                         END
        ,drvCOntAmountType = 'Actual'
        ,drvContTaxYear = ''
    INTO dbo.U_EDISUSOFSA_drvContribution
    FROM dbo.U_EDISUSOFSA_EEList WITH (NOLOCK)
    --JOIN dbo.U_dsi_BDM_EDISUSOFSA WITH (NOLOCK)
    --   ON BdmEEID = xEEID 
    --   AND BdmCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EDISUSOFSA_PDedHist WITH (NOLOCK)
       ON PdhEEID =  XEEID
    LEFT JOIN dbo.U_EDISUSOFSA_PEarHist WITH (NOLOCK)
        on PehEEID = XEEID
        JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    ;

    Delete from dbo.U_EDISUSOFSA_drvContribution where drvContAmt = '0.00' or drvContAmt is null
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISUSOFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_Header;
    SELECT DISTINCT
         drvHeaderRecordType = 'FH'
        ,drvHeaderAdminCode = 'DBI'
        ,drvHeaderEmployerCode = '35566'
        ,drvHeaderSyncFlag = 'N'
        ,drvHeaderSubmittedDate = GETDATE()
        ,drvHeaderSubmittedTime =  GETDATE()
        ,drvHeaderFileVersion = '3.5'
    INTO dbo.U_EDISUSOFSA_Header

    Delete from U_EDISUSOFSA_drvContribution where drvContAmt  is null;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISUSOFSA_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDISUSOFSA_drvTrailer;
    SELECT DISTINCT
         drvTrailerRecordType = 'FF'
        ,drvTrailerRecCount = CAST( (Select (Select count(*) from U_EDISUSOFSA_drvEnrollment)  + (Select count(*) from U_EDISUSOFSA_drvContribution) + (select count(*) from U_EDISUSOFSA_drvParticipant )) as varchar(20))
        ,drvTrailerAdminCode = 'DBI'
        ,drvTrailerEmployerCode = '35566'
        ,drvTrailerSubmittedDate = GETDATE()
        ,drvTraillerSubmitedTime = GETDATE()
    INTO dbo.U_EDISUSOFSA_drvTrailer
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
ALTER VIEW dbo.dsi_vwEDISUSOFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISUSOFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISUSOFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001231'
       ,expStartPerControl     = '202001231'
       ,expLastEndPerControl   = '202001309'
       ,expEndPerControl       = '202001309'
WHERE expFormatCode = 'EDISUSOFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISUSOFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISUSOFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;