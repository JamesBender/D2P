SET NOCOUNT ON;
IF OBJECT_ID('U_EDISTFHFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISTFHFSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISTFHFSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISTFHFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISTFHFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISTFHFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISTFHFSA];
GO
IF OBJECT_ID('U_EDISTFHFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_PEarHist];
GO
IF OBJECT_ID('U_EDISTFHFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_PDedHist];
GO
IF OBJECT_ID('U_EDISTFHFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_Header];
GO
IF OBJECT_ID('U_EDISTFHFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_File];
GO
IF OBJECT_ID('U_EDISTFHFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_EEList];
GO
IF OBJECT_ID('U_EDISTFHFSA_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_drvTrailer];
GO
IF OBJECT_ID('U_EDISTFHFSA_drvParticipant') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_drvParticipant];
GO
IF OBJECT_ID('U_EDISTFHFSA_drvEnrollment') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_drvEnrollment];
GO
IF OBJECT_ID('U_EDISTFHFSA_drvContribution') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_drvContribution];
GO
IF OBJECT_ID('U_EDISTFHFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISTFHFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISTFHFSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISTFHFSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISTFHFSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISTFHFSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISTFHFSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISTFHFSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EDISTFHFSA','Discovery Benefits HSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EDISTFHFSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISTFHFSA' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderRecordType"','1','(''UA''=''T|'')','EDISTFHFSAZ0','2','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderAdminCode"','2','(''UA''=''T|'')','EDISTFHFSAZ0','3','H','01','4',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderEmployerCode"','3','(''UA''=''T|'')','EDISTFHFSAZ0','6','H','01','8',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSyncFlag"','4','(''UA''=''T|'')','EDISTFHFSAZ0','1','H','01','15',NULL,'Synchronize Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSubmittedDate"','5','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','H','01','17',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSubmittedTime"','6','(''UDHMS''=''T|'')','EDISTFHFSAZ0','6','H','01','26',NULL,'Submitted Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderFileVersion"','7','(''UA''=''T'')','EDISTFHFSAZ0','6','H','01','33',NULL,'File Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCRLF"','8','(''UA''=''T'')','EDISTFHFSAZ0','6','H','01','33',NULL,'CRLF',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRecType"','1','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPatFileImportId"','2','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','4',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmployerId"','3','(''UA''=''T|'')','EDISTFHFSAZ0','20','D','10','55',NULL,'Employer Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmployerNumber"','4','(''UA''=''T|'')','EDISTFHFSAZ0','15','D','10','76',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLastName"','5','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','10','92',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFirstName"','6','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','10','123',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMiddleInitial"','7','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','10','154',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartGender"','8','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','10','156',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMaritalStatus"','9','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','10','158',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMothersMaidenName"','10','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','160',NULL,'Mothers Maiden Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDateofBirth"','11','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','211',NULL,'Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','12','(''UA''=''T|'')','EDISTFHFSAZ0','9','D','10','220',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine1"','13','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','230',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine2"','14','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','281',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine3"','15','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','332',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine4"','16','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','383',NULL,'Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCity"','17','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','10','434',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartState"','18','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','10','465',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartZipCode"','19','(''UA''=''T|'')','EDISTFHFSAZ0','10','D','10','468',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCountry"','20','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','10','479',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHomePhone"','21','(''UA''=''T|'')','EDISTFHFSAZ0','10','D','10','482',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartWorkPhone"','22','(''UA''=''T|'')','EDISTFHFSAZ0','10','D','10','493',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartWorkPhoneExt"','23','(''UA''=''T|'')','EDISTFHFSAZ0','6','D','10','504',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmailAddress"','24','(''UA''=''T|'')','EDISTFHFSAZ0','125','D','10','511',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartUserName"','25','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','637',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPassword"','26','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','738',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHireDate"','27','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','839',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDivision"','28','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','848',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoursPerWeek"','29','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','10','949',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmpClass"','30','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','952',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrollFreq"','31','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','1053',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrollFreEffDate"','32','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','1154',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPartStatus"','33','(''UA''=''T|'')','EDISTFHFSAZ0','20','D','10','1163',NULL,'Participant Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartStatusEffDate"','34','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','1184',NULL,'Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoldPayrollDed"','35','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','10','1193',NULL,'Hold Payroll Deductions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoldERContributions"','36','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','10','1195',NULL,'Hold Employer Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIncurServices"','37','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','10','1197',NULL,'Incur Services',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFinalPayrollProDate"','38','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','1199',NULL,'Final Payroll Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFinalContribProDate"','39','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','1208',NULL,'Final Contribution Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHSACustodian"','40','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','1217',NULL,'HSA Custodian',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMedicareBen"','41','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','10','1318',NULL,'Medicare Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMedId"','42','(''UA''=''T|'')','EDISTFHFSAZ0','12','D','10','1320',NULL,'Medicare ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartExcIntegId"','43','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','1333',NULL,'Exchange Integration ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel1"','44','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','1384',NULL,'Reporting Hierarchy Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel2"','45','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','1485',NULL,'Reporting Hierarchy Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel3"','46','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','1586',NULL,'Reporting Hierarchy Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel4"','47','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','10','1687',NULL,'Reporting Hierarchy Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDCitizenship"','48','(''UA''=''T|'')','EDISTFHFSAZ0','20','D','10','1788',NULL,'CDD_Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDCountry"','49','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','10','1809',NULL,'CDD_Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDEmploymentStats"','50','(''UA''=''T|'')','EDISTFHFSAZ0','20','D','10','1812',NULL,'CDD_Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDEmployer"','51','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','10','1833',NULL,'CDD_Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDJObTitle"','52','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','10','1864',NULL,'CDD_JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartClassEffDate"','53','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','1895',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDType"','54','(''UA''=''T|'')','EDISTFHFSAZ0','20','D','10','1904',NULL,'ID_Identification Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDNumber"','55','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','10','1925',NULL,'ID_Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDState"','56','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','10','1956',NULL,'ID_IssuingState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDIssuer"','57','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','10','1959',NULL,'ID_Issuer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDIssueDate"','58','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','2010',NULL,'ID_IssueDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDExpirationDate"','59','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','10','2019',NULL,'ID_ExpirationDa te',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMobileCarrier"','60','(''UA''=''T|'')','EDISTFHFSAZ0','20','D','10','2028',NULL,'Mobile Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMobileNumber"','61','(''UA''=''T|'')','EDISTFHFSAZ0','10','D','10','2049',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTimezone"','62','(''UA''=''T'')','EDISTFHFSAZ0','15','D','10','2060',NULL,'Time Zone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCRLF"','63','(''UA''=''T'')','EDISTFHFSAZ0','6','D','10','2070',NULL,'CRLF',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENRecordType"','1','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPartFileImportId"','2','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','20','4',NULL,'Participant File Import Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPlanName"','3','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','20','55',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENEffectiveDate"','4','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','20','156',NULL,'Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPartElectionAmt"','5','(''UA''=''T|'')','EDISTFHFSAZ0','8','D','20','165',NULL,'Participant Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTerminationDate"','6','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','20','174',NULL,'Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTERContribLEvel"','7','(''UA''=''T|'')','EDISTFHFSAZ0','10','D','20','183',NULL,'Employer Contribution Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTERContAmt"','8','(''UA''=''T|'')','EDISTFHFSAZ0','8','D','20','194',NULL,'Employer Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTPrimaryReimburse"','9','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','20','203',NULL,'Primary Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTAlternateReimburse"','10','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','20','234',NULL,'Alternate Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTEnrolledInClaims"','11','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','20','265',NULL,'Enrolled In Claims Exchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTElectionAmtInd"','12','(''UA''=''T|'')','EDISTFHFSAZ0','8','D','20','267',NULL,'Election Amount Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTHDHPCovLevel"','13','(''UA''=''T|'')','EDISTFHFSAZ0','6','D','20','276',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTPlanYearStartDate"','14','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','20','283',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAccept"','15','(''UA''=''T|'')','EDISTFHFSAZ0','1','D','20','292',NULL,'Terms and Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAcceptDate"','16','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','20','294',NULL,'Date Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAcceptTime"','17','(''HMS''=''T|'')','EDISTFHFSAZ0','6','D','20','303',NULL,'Time Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTChangeDate"','18','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','20','310',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTSpendDown"','19','(''UA''=''T'')','EDISTFHFSAZ0','1','D','20','319',NULL,'Spend Down',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCRLF"','20','(''UA''=''T'')','EDISTFHFSAZ0','6','D','20','358',NULL,'CRLF',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTRecordType"','1','(''UA''=''T|'')','EDISTFHFSAZ0','2','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTPartFileImportId"','2','(''UA''=''T|'')','EDISTFHFSAZ0','50','D','30','4',NULL,'Participant File Import Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTPlanName"','3','(''UA''=''T|'')','EDISTFHFSAZ0','100','D','30','55',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCONTDate"','4','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','D','30','156',NULL,'Contribution Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOntDesc"','5','(''UA''=''T|'')','EDISTFHFSAZ0','30','D','30','165',NULL,'Contribution Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOntAmt"','6','(''UA''=''T|'')','EDISTFHFSAZ0','9','D','30','196',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOntAmountType"','7','(''UA''=''T|'')','EDISTFHFSAZ0','6','D','30','206',NULL,'Amount Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContTaxYear"','8','(''UA''=''T'')','EDISTFHFSAZ0','7','D','30','213',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCRLF"','9','(''UA''=''T'')','EDISTFHFSAZ0','6','D','30','358',NULL,'CRLF',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecordType"','1','(''UA''=''T|'')','EDISTFHFSAZ0','2','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecCount"','2','(''UA''=''T|'')','EDISTFHFSAZ0','20','T','90','4',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerAdminCode"','3','(''UA''=''T|'')','EDISTFHFSAZ0','3','T','90','25',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerEmployerCode"','4','(''UA''=''T|'')','EDISTFHFSAZ0','6','T','90','29',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerSubmittedDate"','5','(''UDMDY''=''T|'')','EDISTFHFSAZ0','8','T','90','36',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTraillerSubmitedTime"','6','(''UDHMS''=''T'')','EDISTFHFSAZ0','6','T','90','45',NULL,'Submitted Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCRLF"','7','(''UA''=''T'')','EDISTFHFSAZ0','6','T','90','51',NULL,'CRLF',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EDISTFHFSA_20210406.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,'4AW0Z',NULL,NULL,NULL,'Scheduled Session','202002129','EMPEXPORT','DLS_SCHED','Feb 12 2020 12:00AM','EDISTFHFSA',NULL,NULL,NULL,'202002129','Feb 12 2020 12:00AM','Dec 30 1899 12:00AM','201901301',NULL,'','','201901301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202001309','EMPEXPORT','OEACTIVE',NULL,'EDISTFHFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202001309','EMPEXPORT','OEPASSIVE',NULL,'EDISTFHFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Eligibility Expo','202001309','EMPEXPORT','ONDEMAND',NULL,'EDISTFHFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','KG0G0',NULL,NULL,NULL,'Test Purposes Only','202103191','EMPEXPORT','TEST','Mar 25 2021  4:32PM','EDISTFHFSA',NULL,NULL,NULL,'202103191','Mar 19 2021 12:00AM','Mar 13 2021 12:00AM','202103191','96','eecPayGroup','BWCRTX','202103191',dbo.fn_GetTimedKey(),NULL,'us3cPeTHI1001',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISTFHFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISTFHFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISTFHFSA','InitialSort','C','initialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISTFHFSA','SubSort','C','subSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISTFHFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISTFHFSA','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EDISTFHFSA' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EDISTFHFSA' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EDISTFHFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISTFHFSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISTFHFSA','H01','dbo.U_EDISTFHFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISTFHFSA','D10','dbo.U_EDISTFHFSA_drvParticipant',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISTFHFSA','D20','dbo.U_EDISTFHFSA_drvEnrollment',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISTFHFSA','D30','dbo.U_EDISTFHFSA_drvContribution',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISTFHFSA','T90','dbo.U_EDISTFHFSA_drvTrailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISTFHFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISTFHFSA] (
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
IF OBJECT_ID('U_EDISTFHFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISTFHFSA_drvContribution') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_drvContribution] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [initialSort] varchar(12) NULL,
    [subSort] varchar(1) NOT NULL,
    [Pdhdedcode] char(5) NOT NULL,
    [drvCONTRecordType] varchar(2) NOT NULL,
    [drvCONTPartFileImportId] char(11) NULL,
    [drvCONTPlanName] varchar(22) NULL,
    [drvCONTDate] datetime NULL,
    [drvCOntDesc] varchar(21) NULL,
    [drvCOntAmt] varchar(12) NULL,
    [drvCOntAmountType] varchar(6) NOT NULL,
    [drvContTaxYear] varchar(7) NOT NULL,
    [drvCRLF] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISTFHFSA_drvEnrollment') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_drvEnrollment] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [initialSort] varchar(12) NULL,
    [subSort] varchar(1) NOT NULL,
    [drvENRecordType] varchar(2) NOT NULL,
    [drvENPartFileImportId] char(11) NULL,
    [drvENPlanName] varchar(22) NOT NULL,
    [drvENEffectiveDate] datetime NULL,
    [drvENPartElectionAmt] varchar(1) NOT NULL,
    [drvENTerminationDate] datetime NULL,
    [drvENTERContribLEvel] varchar(1) NOT NULL,
    [drvENTERContAmt] varchar(1) NOT NULL,
    [drvENTPrimaryReimburse] varchar(1) NOT NULL,
    [drvENTAlternateReimburse] varchar(1) NOT NULL,
    [drvENTEnrolledInClaims] varchar(1) NOT NULL,
    [drvENTElectionAmtInd] varchar(6) NOT NULL,
    [drvENTHDHPCovLevel] varchar(6) NULL,
    [drvENTPlanYearStartDate] varchar(1) NOT NULL,
    [drvENTermsCondAccept] varchar(1) NOT NULL,
    [drvENTermsCondAcceptDate] varchar(1) NOT NULL,
    [drvENTChangeDate] varchar(1) NOT NULL,
    [drvENTSpendDown] varchar(1) NOT NULL,
    [drvCRLF] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISTFHFSA_drvParticipant') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_drvParticipant] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [initialSort] varchar(12) NULL,
    [subSort] varchar(1) NOT NULL,
    [drvPartRecType] varchar(2) NOT NULL,
    [drvPatFileImportId] char(11) NULL,
    [drvPartEmployerId] varchar(1) NOT NULL,
    [drvPartEmployerNumber] char(9) NULL,
    [drvPartLastName] varchar(100) NULL,
    [drvPartFirstName] varchar(100) NULL,
    [drvPartMiddleInitial] varchar(1) NULL,
    [drvPartGender] char(1) NULL,
    [drvPartMaritalStatus] char(1) NULL,
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
    [drvPartCountry] varchar(1) NOT NULL,
    [drvPartHomePhone] varchar(50) NULL,
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
    [drvPartStatusEffDateBefore] datetime NULL,
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
    [drvPartMobileNumber] varchar(50) NULL,
    [drvPartTimezone] varchar(1) NOT NULL,
    [drvCRLF] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISTFHFSA_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_drvTrailer] (
    [drvTrailerRecordType] varchar(2) NOT NULL,
    [drvTrailerRecCount] varchar(20) NULL,
    [drvTrailerAdminCode] varchar(3) NOT NULL,
    [drvTrailerEmployerCode] varchar(5) NOT NULL,
    [drvTrailerSubmittedDate] datetime NOT NULL,
    [drvTraillerSubmitedTime] datetime NOT NULL,
    [drvCRLF] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISTFHFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISTFHFSA_File') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(3000) NULL
);
IF OBJECT_ID('U_EDISTFHFSA_Header') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_Header] (
    [drvHeaderRecordType] varchar(2) NOT NULL,
    [drvHeaderAdminCode] varchar(3) NOT NULL,
    [drvHeaderEmployerCode] varchar(5) NOT NULL,
    [drvHeaderSyncFlag] varchar(1) NOT NULL,
    [drvHeaderSubmittedDate] datetime NOT NULL,
    [drvHeaderSubmittedTime] datetime NOT NULL,
    [drvHeaderFileVersion] varchar(3) NOT NULL,
    [drvCRLF] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISTFHFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [PdhDedCode] char(5) NOT NULL,
    [PdhEEAmount] money NULL
);
IF OBJECT_ID('U_EDISTFHFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISTFHFSA_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISTFHFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: TF Holdings, Inc.

Created By: Marco Lagrosa
Business Analyst: Cheryl Petitti
Create Date: 02/24/2021
Service Request Number: TekP-2020-12-17-0003

Purpose: Discovery FSA Enrollment and Payroll Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISTFHFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISTFHFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISTFHFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISTFHFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISTFHFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISTFHFSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISTFHFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISTFHFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISTFHFSA', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISTFHFSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISTFHFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISTFHFSA';

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
    DELETE FROM dbo.U_EDISTFHFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISTFHFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSAE,HSAEC,HSAF,HSAFC,HSAER';

    IF OBJECT_ID('U_EDISTFHFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISTFHFSA_DedList
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
    --INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AllowMultiDedType', 'Y')
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
    IF OBJECT_ID('U_EDISTFHFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        ,PdhDedCode  
        -- Categorize Payroll Amounts
        ,PdhEEAmount    = SUM(PdhEECurAmt)
           
    INTO dbo.U_EDISTFHFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EDISTFHFSA_DedList WITH (NOLOCK)
        ON DedCode = PdhDedCode
    WHERE LEFT(PdhPerControl,4) = LEFT(@EndPerControl,4)
    AND PdhPerControl <= @EndPerControl
    AND PdhPerControl BETWEEN @StartPerControl AND @EndPerControl -- Filter for Current Payroll Dates. If you need YTD Totals, then remove or comment out this line.
    GROUP BY PdhEEID,PdhDedCode
    HAVING (SUM(PdhEECurAmt) <> 0.00
        OR SUM(PdhERCurAmt) <> 0.00
    );


    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EDISTFHFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_PEarHist;
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
    INTO dbo.U_EDISTFHFSA_PEarHist
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
    -- DETAIL RECORD - U_EDISTFHFSA_drvParticipant
    ---------------------------------
    IF OBJECT_ID('U_EDISTFHFSA_drvParticipant','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_drvParticipant;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,initialSort = '2' + eepSSN
        ,subSort = '1'
        -- standard fields above and additional driver fields below
        ,drvPartRecType = 'PT'
        ,drvPatFileImportId = eepSSN
        ,drvPartEmployerId = ''
        ,drvPartEmployerNumber = eecEmpNo
        ,drvPartLastName = EepNameLast
        ,drvPartFirstName = EepNameFirst
        ,drvPartMiddleInitial = LEFT(ISNULL(EepNameMiddle,''),1)
        ,drvPartGender = CASE WHEN EepGender in ('M','F') THEN EepGender END 
        ,drvPartMaritalStatus = CASE WHEN eepMaritalStatus in ('S','M') THEN eepMaritalStatus END
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
        ,drvPartCountry = ''
        ,drvPartHomePhone = EepPhoneHomeNumber
        ,drvPartWorkPhone = ''
        ,drvPartWorkPhoneExt = ''
        ,drvPartEmailAddress = EepAddressEMail
        ,drvPartUserName = ''
        ,drvPartPassword = ''
        ,drvPartHireDate = EecDateOfOriginalHire
        ,drvPartDivision = ''
        ,drvPartHoursPerWeek = ''
        ,drvPartEmpClass = 'E'
        ,drvPartPayrollFreq = 'Payroll'
        ,drvPartPayrollFreEffDate = ''
        ,drvPartPartStatus = CASE WHEN EecEmplStatus = 'T' then 'Terminated' ELSE 'Active' END
        ,drvPartStatusEffDateBefore = CASE WHEN EecEmplStatus = 'T' then dateadd(DAY,1,eomonth(eecdateoftermination)) ELSE  dbo.dsi_fnGetMinMaxDates('MAX',eecdateoflasthire, CAST('01/01/2021' as datetime) )  END
        ,drvPartStatusEffDate = CASE WHEN EecEmplStatus = 'T' then dateadd(DAY,1,eomonth(eecdateoftermination)) ELSE  EecDateOfSeniority  END
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
        ,drvPartMobileCarrier =  ''
        ,drvPartMobileNumber = (Select top 1 efoPhoneNumber from  dbo.EmpMPhon where efoeeid = xeeid and efoPhoneType  ='CEL')
        ,drvPartTimezone = ''
        ,drvCRLF = ''
    INTO dbo.U_EDISTFHFSA_drvParticipant
    FROM dbo.U_EDISTFHFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN (Select bdmeeid,bdmcoid from dbo.U_dsi_BDM_EDISTFHFSA WITH (NOLOCK)) A
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISTFHFSA_drvEnrollment
    ---------------------------------
    IF OBJECT_ID('U_EDISTFHFSA_drvEnrollment','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_drvEnrollment;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,initialSort = '2' + eepSSN
        ,subSort = '2'
        -- standard fields above and additional driver fields below
        ,drvENRecordType = 'EN'
        ,drvENPartFileImportId = eepSSN
        ,drvENPlanName = 'Health Savings Account'
        ,drvENEffectiveDate = dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, CAST('01/01/2021' as datetime)  )
        ,drvENPartElectionAmt = ''
        ,drvENTerminationDate = CASE WHEN EecEmplStatus = 'T' THEN bdmBenStopDate END
        ,drvENTERContribLEvel = ''
        ,drvENTERContAmt = ''
        ,drvENTPrimaryReimburse = ''
        ,drvENTAlternateReimburse = ''
        ,drvENTEnrolledInClaims = ''
        ,drvENTElectionAmtInd = 'PerPay'
        ,drvENTHDHPCovLevel = CASE WHEN bdmdedcode in ('HSAF','HSAFC') THEN 'Family'
                                   WHEN bdmdedcode in ('HSAE', 'HSAEC') THEN 'Single'
                               END
        ,drvENTPlanYearStartDate = ''--CAST('01/01/' + CAST(Year(GETDATE())  as varchar(4)) as Datetime)
        ,drvENTermsCondAccept = ''
        ,drvENTermsCondAcceptDate = ''
        ,drvENTChangeDate = ''
        ,drvENTSpendDown = ''
        ,drvCRLF  = ''
    INTO dbo.U_EDISTFHFSA_drvEnrollment
    FROM dbo.U_EDISTFHFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN (Select max(bdmbenstartdate) as bdmbenstartdate ,max(bdmbenstopdate) as bdmbenstopdate, bdmeeid, bdmcoid , max(bdmdedcode) as bdmdedcode from dbo.U_dsi_BDM_EDISTFHFSA WITH (NOLOCK)
    where bdmbenstartdate is not null 
         group by bdmeeid, bdmcoid  )  A
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        on eepeeid = xeeid

    

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISTFHFSA_drvContribution
    ---------------------------------
    IF OBJECT_ID('U_EDISTFHFSA_drvContribution','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_drvContribution;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,initialSort = '2' + eepSSN
        ,subSort = '3'
        ,Pdhdedcode
        -- standard fields above and additional driver fields below
        ,drvCONTRecordType = 'CT'
        ,drvCONTPartFileImportId = eepSSN
        ,drvCONTPlanName = CASE WHEN Pdhdedcode in ('HSAE','HSAEC','HSAF','HSAFC','HSAER') THEN 'Health Savings Account' END
        ,drvCONTDate = PrgPayDate
        ,drvCOntDesc = CASE WHEN Pdhdedcode in ('HSAE','HSAEC','HSAF','HSAFC') THEN 'Payroll Deduction'
                            WHEN Pdhdedcode in ('HSAER') THEN 'Employer Contribution'
                        END
                    
        ,drvCOntAmt = CAST(CONVERT(DECIMAL(10,2),PdhEECurAmt) as VARCHAR(12))
        ,drvCOntAmountType = 'Actual'
        ,drvContTaxYear = 'Current'
        ,drvCRLF = ''
    INTO dbo.U_EDISTFHFSA_drvContribution
    FROM dbo.U_EDISTFHFSA_EEList WITH (NOLOCK)
    JOIN dbo.U_EDISTFHFSA_PDedHist WITH (NOLOCK)
        ON PdhEEID =  XEEID
    LEFT JOIN dbo.U_EDISTFHFSA_PEarHist WITH (NOLOCK)
        on PehEEID = XEEID
    JOIN dbo.EmpPers WITH (NOLOCK)
        on eepeeid = xeeid;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISTFHFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_Header;
    SELECT DISTINCT
         drvHeaderRecordType = 'FH'
        ,drvHeaderAdminCode = 'DBI'
        ,drvHeaderEmployerCode = '40056'
        ,drvHeaderSyncFlag = 'N'
        ,drvHeaderSubmittedDate = GETDATE()
        ,drvHeaderSubmittedTime =  GETDATE()
        ,drvHeaderFileVersion = '3.5'
        ,drvCRLF = ''
    INTO dbo.U_EDISTFHFSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISTFHFSA_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDISTFHFSA_drvTrailer;
    SELECT DISTINCT
         drvTrailerRecordType = 'FF'
        ,drvTrailerRecCount = CAST( (Select (Select count(*) from U_EDISTFHFSA_drvEnrollment)  + (Select count(*) from U_EDISTFHFSA_drvContribution) + (select count(*) from U_EDISTFHFSA_drvParticipant )) as varchar(20))
        ,drvTrailerAdminCode = 'DBI'
        ,drvTrailerEmployerCode = '40056'
        ,drvTrailerSubmittedDate = GETDATE()
        ,drvTraillerSubmitedTime = GETDATE()
        ,drvCRLF  =''
    INTO dbo.U_EDISTFHFSA_drvTrailer
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
ALTER VIEW dbo.dsi_vwEDISTFHFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISTFHFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISTFHFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001231'
       ,expStartPerControl     = '202001231'
       ,expLastEndPerControl   = '202001309'
       ,expEndPerControl       = '202001309'
WHERE expFormatCode = 'EDISTFHFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISTFHFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISTFHFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;