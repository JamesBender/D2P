SET NOCOUNT ON;
IF OBJECT_ID('U_EDISROSFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EDISROSFSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EDISROSFSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEDISROSFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEDISROSFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EDISROSFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISROSFSA];
GO
IF OBJECT_ID('U_EDISROSFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_PEarHist];
GO
IF OBJECT_ID('U_EDISROSFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_Header];
GO
IF OBJECT_ID('U_EDISROSFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_File];
GO
IF OBJECT_ID('U_EDISROSFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_EEList];
GO
IF OBJECT_ID('U_EDISROSFSA_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_drvTrailer];
GO
IF OBJECT_ID('U_EDISROSFSA_drvParticipant') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_drvParticipant];
GO
IF OBJECT_ID('U_EDISROSFSA_drvEnrollment') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_drvEnrollment];
GO
IF OBJECT_ID('U_EDISROSFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EDISROSFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EDISROSFSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EDISROSFSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EDISROSFSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EDISROSFSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EDISROSFSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EDISROSFSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EDISROSFSA','Discovery FSA Eligibility Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','3000','S','N','EDISROSFSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderRecordType"','1','(''UA''=''T|'')','EDISROSFSAZ0','2','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderAdminCode"','2','(''UA''=''T|'')','EDISROSFSAZ0','3','H','01','4',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderEmployerCode"','3','(''UA''=''T|'')','EDISROSFSAZ0','6','H','01','8',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSyncFlag"','4','(''UA''=''T|'')','EDISROSFSAZ0','1','H','01','15',NULL,'Synchronize Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSubmittedDate"','5','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','H','01','17',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderSubmittedTime"','6','(''UDHMS''=''T|'')','EDISROSFSAZ0','6','H','01','26',NULL,'Submitted Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHeaderFileVersion"','7','(''UA''=''T'')','EDISROSFSAZ0','6','H','01','33',NULL,'File Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartRecType"','1','(''UA''=''T|'')','EDISROSFSAZ0','2','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPatFileImportId"','2','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','4',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmployerId"','3','(''UA''=''T|'')','EDISROSFSAZ0','20','D','10','55',NULL,'Employer Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmployerNumber"','4','(''UA''=''T|'')','EDISROSFSAZ0','15','D','10','76',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartLastName"','5','(''UA''=''T|'')','EDISROSFSAZ0','30','D','10','92',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFirstName"','6','(''UA''=''T|'')','EDISROSFSAZ0','30','D','10','123',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMiddleInitial"','7','(''UA''=''T|'')','EDISROSFSAZ0','1','D','10','154',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartGender"','8','(''UA''=''T|'')','EDISROSFSAZ0','1','D','10','156',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMaritalStatus"','9','(''UA''=''T|'')','EDISROSFSAZ0','1','D','10','158',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMothersMaidenName"','10','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','160',NULL,'Mothers Maiden Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDateofBirth"','11','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','211',NULL,'Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartSSN"','12','(''UA''=''T|'')','EDISROSFSAZ0','9','D','10','220',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine1"','13','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','230',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine2"','14','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','281',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine3"','15','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','332',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartAddressLine4"','16','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','383',NULL,'Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCity"','17','(''UA''=''T|'')','EDISROSFSAZ0','30','D','10','434',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartState"','18','(''UA''=''T|'')','EDISROSFSAZ0','2','D','10','465',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartZipCode"','19','(''UA''=''T|'')','EDISROSFSAZ0','10','D','10','468',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCountry"','20','(''UA''=''T|'')','EDISROSFSAZ0','2','D','10','479',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHomePhone"','21','(''UA''=''T|'')','EDISROSFSAZ0','10','D','10','482',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartWorkPhone"','22','(''UA''=''T|'')','EDISROSFSAZ0','10','D','10','493',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartWorkPhoneExt"','23','(''UA''=''T|'')','EDISROSFSAZ0','6','D','10','504',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmailAddress"','24','(''UA''=''T|'')','EDISROSFSAZ0','125','D','10','511',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartUserName"','25','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','637',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPassword"','26','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','738',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHireDate"','27','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','839',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartDivision"','28','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','848',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoursPerWeek"','29','(''UA''=''T|'')','EDISROSFSAZ0','2','D','10','949',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartEmpClass"','30','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','952',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrollFreq"','31','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','1053',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPayrollFreEffDate"','32','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','1154',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartPartStatus"','33','(''UA''=''T|'')','EDISROSFSAZ0','20','D','10','1163',NULL,'Participant Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartStatusEffDate"','34','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','1184',NULL,'Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoldPayrollDed"','35','(''UA''=''T|'')','EDISROSFSAZ0','1','D','10','1193',NULL,'Hold Payroll Deductions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHoldERContributions"','36','(''UA''=''T|'')','EDISROSFSAZ0','1','D','10','1195',NULL,'Hold Employer Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIncurServices"','37','(''UA''=''T|'')','EDISROSFSAZ0','1','D','10','1197',NULL,'Incur Services',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFinalPayrollProDate"','38','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','1199',NULL,'Final Payroll Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFinalContribProDate"','39','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','1208',NULL,'Final Contribution Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartHSACustodian"','40','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','1217',NULL,'HSA Custodian',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMedicareBen"','41','(''UA''=''T|'')','EDISROSFSAZ0','1','D','10','1318',NULL,'Medicare Beneficiary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMedId"','42','(''UA''=''T|'')','EDISROSFSAZ0','12','D','10','1320',NULL,'Medicare ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartExcIntegId"','43','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','1333',NULL,'Exchange Integration ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel1"','44','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','1384',NULL,'Reporting Hierarchy Level 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel2"','45','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','1485',NULL,'Reporting Hierarchy Level 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel3"','46','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','1586',NULL,'Reporting Hierarchy Level 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReportHierLevel4"','47','(''UA''=''T|'')','EDISROSFSAZ0','100','D','10','1687',NULL,'Reporting Hierarchy Level 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDCitizenship"','48','(''UA''=''T|'')','EDISROSFSAZ0','20','D','10','1788',NULL,'CDD_Citizenship',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDCountry"','49','(''UA''=''T|'')','EDISROSFSAZ0','2','D','10','1809',NULL,'CDD_Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDEmploymentStats"','50','(''UA''=''T|'')','EDISROSFSAZ0','20','D','10','1812',NULL,'CDD_Employment Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDEmployer"','51','(''UA''=''T|'')','EDISROSFSAZ0','30','D','10','1833',NULL,'CDD_Employer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartCCDJObTitle"','52','(''UA''=''T|'')','EDISROSFSAZ0','30','D','10','1864',NULL,'CDD_JobTitle',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartClassEffDate"','53','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','1895',NULL,'Class Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDType"','54','(''UA''=''T|'')','EDISROSFSAZ0','20','D','10','1904',NULL,'ID_Identification Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDNumber"','55','(''UA''=''T|'')','EDISROSFSAZ0','30','D','10','1925',NULL,'ID_Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDState"','56','(''UA''=''T|'')','EDISROSFSAZ0','2','D','10','1956',NULL,'ID_IssuingState',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDIssuer"','57','(''UA''=''T|'')','EDISROSFSAZ0','50','D','10','1959',NULL,'ID_Issuer',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDIssueDate"','58','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','2010',NULL,'ID_IssueDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartIDExpirationDate"','59','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','10','2019',NULL,'ID_ExpirationDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMobileCarrier"','60','(''UA''=''T|'')','EDISROSFSAZ0','20','D','10','2028',NULL,'Mobile Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartMobileNumber"','61','(''UA''=''T|'')','EDISROSFSAZ0','10','D','10','2049',NULL,'Mobile Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartTimezone"','62','(''UA''=''T'')','EDISROSFSAZ0','15','D','10','2060',NULL,'Time Zone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENRecordType"','1','(''UA''=''T|'')','EDISROSFSAZ0','2','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPartFileImportId"','2','(''UA''=''T|'')','EDISROSFSAZ0','50','D','20','4',NULL,'Participant File Import Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPlanName"','3','(''UA''=''T|'')','EDISROSFSAZ0','100','D','20','55',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENEffectiveDate"','4','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','20','156',NULL,'Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENPartElectionAmt"','5','(''UA''=''T|'')','EDISROSFSAZ0','8','D','20','165',NULL,'Participant Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTerminationDate"','6','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','20','174',NULL,'Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTERContribLEvel"','7','(''UA''=''T|'')','EDISROSFSAZ0','10','D','20','183',NULL,'Employer Contribution Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTERContAmt"','8','(''UA''=''T|'')','EDISROSFSAZ0','8','D','20','194',NULL,'Employer Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTPrimaryReimburse"','9','(''UA''=''T|'')','EDISROSFSAZ0','30','D','20','203',NULL,'Primary Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTAlternateReimburse"','10','(''UA''=''T|'')','EDISROSFSAZ0','30','D','20','234',NULL,'Alternate Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTEnrolledInClaims"','11','(''UA''=''T|'')','EDISROSFSAZ0','1','D','20','265',NULL,'Enrolled In Claims Exchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTElectionAmtInd"','12','(''UA''=''T|'')','EDISROSFSAZ0','8','D','20','267',NULL,'Election Amount Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTHDHPCovLevel"','13','(''UA''=''T|'')','EDISROSFSAZ0','6','D','20','276',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTPlanYearStartDate"','14','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','20','283',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAccept"','15','(''UA''=''T|'')','EDISROSFSAZ0','1','D','20','292',NULL,'Terms and Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAcceptDate"','16','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','20','294',NULL,'Date Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTermsCondAcceptTime"','17','(''HMS''=''T|'')','EDISROSFSAZ0','6','D','20','303',NULL,'Time Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTChangeDate"','18','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','D','20','310',NULL,'Change Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvENTSpendDown"','19','(''UA''=''T'')','EDISROSFSAZ0','1','D','20','319',NULL,'Spend Down',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecordType"','1','(''UA''=''T|'')','EDISROSFSAZ0','2','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecCount"','2','(''UA''=''T|'')','EDISROSFSAZ0','20','T','90','4',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerAdminCode"','3','(''UA''=''T|'')','EDISROSFSAZ0','3','T','90','25',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerEmployerCode"','4','(''UA''=''T|'')','EDISROSFSAZ0','6','T','90','29',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerSubmittedDate"','5','(''UDMDY''=''T|'')','EDISROSFSAZ0','8','T','90','36',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTraillerSubmitedTime"','6','(''UDHMS''=''T'')','EDISROSFSAZ0','6','T','90','45',NULL,'Submitted Time',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISROSFSA_20200320.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Discovery FSA Eligibility Expo','202001309','EMPEXPORT','ONDEMAND',NULL,'EDISROSFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISROSFSA_20200320.txt',NULL,'Null','N',',BW64W',NULL,NULL,NULL,'Discovery FSA Elig-Wed 8am','202001309','EMPEXPORT','DIS_SCHED',NULL,'EDISROSFSA',NULL,NULL,NULL,'202003189','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202003111',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISROSFSA_20200320.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202001309','EMPEXPORT','OEACTIVE',NULL,'EDISROSFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISROSFSA_20200320.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202001309','EMPEXPORT','OEPASSIVE',NULL,'EDISROSFSA',NULL,NULL,NULL,'202001309','Jan 30 2020  2:52PM','Jan 30 2020  2:52PM','202001301',NULL,'','','202001301',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EDISROSFSA_20200320.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202002109','EMPEXPORT','TEST','Feb 10 2020 12:00PM','EDISROSFSA',NULL,NULL,NULL,'202002109','Feb 10 2020 12:00AM','Dec 30 1899 12:00AM','202001271','281','','','202001271',dbo.fn_GetTimedKey(),NULL,'us3lKiROS1004',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EDISROSFSA_20200320.txt' END WHERE expFormatCode = 'EDISROSFSA';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISROSFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISROSFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISROSFSA','InitialSort','C','initialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISROSFSA','SubSort','C','subSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISROSFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EDISROSFSA','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EDISROSFSA' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EDISROSFSA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EDISROSFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EDISROSFSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISROSFSA','H01','dbo.U_EDISROSFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISROSFSA','D10','dbo.U_EDISROSFSA_drvParticipant',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISROSFSA','D20','dbo.U_EDISROSFSA_drvEnrollment',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EDISROSFSA','T90','dbo.U_EDISROSFSA_drvTrailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EDISROSFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EDISROSFSA] (
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
IF OBJECT_ID('U_EDISROSFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EDISROSFSA_drvEnrollment') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_drvEnrollment] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [initialSort] varchar(12) NULL,
    [subSort] varchar(1) NOT NULL,
    [drvENRecordType] varchar(2) NOT NULL,
    [drvENPartFileImportId] char(11) NULL,
    [drvENPlanName] varchar(19) NULL,
    [drvENEffectiveDate] datetime NULL,
    [drvENPartElectionAmt] varchar(12) NULL,
    [drvENTerminationDate] datetime NULL,
    [drvENTERContribLEvel] varchar(1) NOT NULL,
    [drvENTERContAmt] varchar(1) NOT NULL,
    [drvENTPrimaryReimburse] varchar(1) NOT NULL,
    [drvENTAlternateReimburse] varchar(1) NOT NULL,
    [drvENTEnrolledInClaims] varchar(1) NOT NULL,
    [drvENTElectionAmtInd] varchar(8) NULL,
    [drvENTHDHPCovLevel] varchar(1) NOT NULL,
    [drvENTPlanYearStartDate] datetime NULL,
    [drvENTermsCondAccept] varchar(1) NOT NULL,
    [drvENTermsCondAcceptDate] varchar(1) NOT NULL,
    [drvENTChangeDate] varchar(1) NOT NULL,
    [drvENTSpendDown] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISROSFSA_drvParticipant') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_drvParticipant] (
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
    [drvPartPayrollFreq] varchar(12) NOT NULL,
    [drvPartPayrollFreEffDate] varchar(1) NOT NULL,
    [drvPartPartStatus] varchar(10) NOT NULL,
    [drvPartStatusEffDate] datetime NULL,
    [drvPartHoldPayrollDed] varchar(1) NOT NULL,
    [drvPartHoldERContributions] varchar(1) NOT NULL,
    [drvPartIncurServices] varchar(1) NOT NULL,
    [drvPartFinalPayrollProDate] int NULL,
    [drvPartFinalContribProDate] int NULL,
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
    [drvPartTimezone] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EDISROSFSA_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_drvTrailer] (
    [drvTrailerRecordType] varchar(2) NOT NULL,
    [drvTrailerRecCount] varchar(20) NULL,
    [drvTrailerAdminCode] varchar(3) NOT NULL,
    [drvTrailerEmployerCode] varchar(5) NOT NULL,
    [drvTrailerSubmittedDate] datetime NOT NULL,
    [drvTraillerSubmitedTime] datetime NOT NULL
);
IF OBJECT_ID('U_EDISROSFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EDISROSFSA_File') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(3000) NULL
);
IF OBJECT_ID('U_EDISROSFSA_Header') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_Header] (
    [drvHeaderRecordType] varchar(2) NOT NULL,
    [drvHeaderAdminCode] varchar(3) NOT NULL,
    [drvHeaderEmployerCode] varchar(5) NOT NULL,
    [drvHeaderSyncFlag] varchar(1) NOT NULL,
    [drvHeaderSubmittedDate] datetime NOT NULL,
    [drvHeaderSubmittedTime] datetime NOT NULL,
    [drvHeaderFileVersion] varchar(3) NOT NULL
);
IF OBJECT_ID('U_EDISROSFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EDISROSFSA_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EDISROSFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Roscoe Properties

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 02/05/2020
Service Request Number: TekP-2019-11-26-001

Purpose: Discovery FSA Eligibility Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EDISROSFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EDISROSFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EDISROSFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EDISROSFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EDISROSFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISROSFSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISROSFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISROSFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EDISROSFSA', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EDISROSFSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EDISROSFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EDISROSFSA';

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
    DELETE FROM dbo.U_EDISROSFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EDISROSFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSAD,FSALT';

    IF OBJECT_ID('U_EDISROSFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EDISROSFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EDISROSFSA_DedList
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
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EDISROSFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EDISROSFSA_PEarHist;
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
    INTO dbo.U_EDISROSFSA_PEarHist
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
    -- DETAIL RECORD - U_EDISROSFSA_drvParticipant
    ---------------------------------
    IF OBJECT_ID('U_EDISROSFSA_drvParticipant','U') IS NOT NULL
        DROP TABLE dbo.U_EDISROSFSA_drvParticipant;
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
        ,drvPartHireDate = eecdateoflasthire
        ,drvPartDivision = ''
        ,drvPartHoursPerWeek = ''
        ,drvPartEmpClass = 'E'
        ,drvPartPayrollFreq = 'Bi-Weekly 26'
        ,drvPartPayrollFreEffDate = ''
        ,drvPartPartStatus = CASE WHEN EecEmplStatus = 'T' then 'Terminated' ELSE 'Active' END
        ,drvPartStatusEffDate = CASE WHEN EecEmplStatus = 'T' then eecdateoftermination ELSE eecdateoflasthire END
        ,drvPartHoldPayrollDed = ''
        ,drvPartHoldERContributions = ''
        ,drvPartIncurServices = ''
        ,drvPartFinalPayrollProDate = NULL
        ,drvPartFinalContribProDate = NULL
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
        ,drvPartMobileNumber =ISNULL( (Select top 1 efoPhoneNumber from EmpMPhon where efoPhoneType = 'CEL' and efoEEID = xeeid), EepPhoneHomeNumber)
        ,drvPartTimezone = ''
    INTO dbo.U_EDISROSFSA_drvParticipant
    FROM dbo.U_EDISROSFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.JobCode WITH (NOLOCK)
        ON JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_BDM_EDISROSFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID

    ;
    ---------------------------------
    -- DETAIL RECORD - U_EDISROSFSA_drvEnrollment
    ---------------------------------
    IF OBJECT_ID('U_EDISROSFSA_drvEnrollment','U') IS NOT NULL
        DROP TABLE dbo.U_EDISROSFSA_drvEnrollment;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,initialSort = '2' + eepSSN
        ,subSort = '2'
        -- standard fields above and additional driver fields below
        ,drvENRecordType = 'EN'
        ,drvENPartFileImportId = eepSSN
        ,drvENPlanName = CASE WHEN BdmDedCode in ('FSA') THEN 'Medical FSA'
                              WHEN BdmDedCode in ('FSAD') THEN 'Dependent Care FSA'
                              WHEN BdmDedCode in ('FSALT') THEN 'Limited Medical FSA'
                         END
        ,drvENEffectiveDate = bdmBenStartDate
        ,drvENPartElectionAmt = CAST(CONVERT(Decimal(10,2),bdmEEGoalAmt) as varchar(12))
        ,drvENTerminationDate = CASE WHEN EecEmplStatus <> 'T' THEN dbo.dsi_fnGetMinMaxDates('MAX', lastpaydate,(dbo.dsi_fnGetMinMaxDates('MAX',bdmBenStopDate,EedEEDedLstPaid)))

                                      END
        ,drvENTERContribLEvel = ''
        ,drvENTERContAmt = ''
        ,drvENTPrimaryReimburse = ''
        ,drvENTAlternateReimburse = ''
        ,drvENTEnrolledInClaims = ''
        ,drvENTElectionAmtInd = CASE WHEN bdmDedcode in ('DBMST','DBPKG') THEN 'PerMonth' End
        ,drvENTHDHPCovLevel = ''
        ,drvENTPlanYearStartDate =  CAST( ('01/01/' + CAST( YEAR(GETDATE()) as varchar(4))) as DateTime)
        ,drvENTermsCondAccept = ''
        ,drvENTermsCondAcceptDate = ''
        ,drvENTChangeDate = ''
        ,drvENTSpendDown = ''
    INTO dbo.U_EDISROSFSA_drvEnrollment
    FROM dbo.U_EDISROSFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
     JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EDISROSFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
        LEFT JOIN (
    select eedeeid,eedcoid,eeddedcode,max(EedEEDedLstPaid) as EedEEDedLstPaid  from dbo.empded WITH (NOLOCK) group by eedeeid,eedcoid,eeddedcode
    ) LP ON LP.EEDeeid =  xCoID
      AND LP.eedcoid = xCoID
      LEFT JOIN (
Select max(prgpaydate) as lastpaydate,peheeid as peheeid from   dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist A WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    Group by peheeid) as LatestPay
    on LatestPay.peheeid =  xeeid
    ;

    
    Delete from dbo.U_EDISROSFSA_drvEnrollment where drveeid in (
        select distinct drveeid from dbo.U_EDISROSFSA_drvParticipant where drvPartPartStatus = 'Terminated'
    ) 

    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISROSFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EDISROSFSA_Header;
    SELECT DISTINCT
         drvHeaderRecordType = 'FH'
        ,drvHeaderAdminCode = 'DBI'
        ,drvHeaderEmployerCode = '35707'
        ,drvHeaderSyncFlag = 'N'
        ,drvHeaderSubmittedDate = GETDATE()
        ,drvHeaderSubmittedTime =  GETDATE()
        ,drvHeaderFileVersion = '3.5'
    INTO dbo.U_EDISROSFSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EDISROSFSA_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EDISROSFSA_drvTrailer;
    SELECT DISTINCT
         drvTrailerRecordType = 'FF'
        ,drvTrailerRecCount = CAST( (Select (Select count(*) from U_EDISROSFSA_drvEnrollment)  + (select count(*) from U_EDISROSFSA_drvParticipant )) as varchar(20))
        ,drvTrailerAdminCode = 'DBI'
        ,drvTrailerEmployerCode = '35707'
        ,drvTrailerSubmittedDate = GETDATE()
        ,drvTraillerSubmitedTime = GETDATE()
    INTO dbo.U_EDISROSFSA_drvTrailer
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
ALTER VIEW dbo.dsi_vwEDISROSFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISROSFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EDISROSFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202001231'
       ,expStartPerControl     = '202001231'
       ,expLastEndPerControl   = '202001309'
       ,expEndPerControl       = '202001309'
WHERE expFormatCode = 'EDISROSFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEDISROSFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EDISROSFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;