SET NOCOUNT ON;
IF OBJECT_ID('U_EINFINSFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EINFINSFSA_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EINFINSFSA' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEINFINSFSA_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEINFINSFSA_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EINFINSFSA') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINFINSFSA];
GO
IF OBJECT_ID('U_EINFINSFSA_Trailer') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_Trailer];
GO
IF OBJECT_ID('U_EINFINSFSA_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_PEarHist];
GO
IF OBJECT_ID('U_EINFINSFSA_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_PDedHist];
GO
IF OBJECT_ID('U_EINFINSFSA_Header') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_Header];
GO
IF OBJECT_ID('U_EINFINSFSA_File') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_File];
GO
IF OBJECT_ID('U_EINFINSFSA_EEList') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_EEList];
GO
IF OBJECT_ID('U_EINFINSFSA_drvTbl_30') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_drvTbl_30];
GO
IF OBJECT_ID('U_EINFINSFSA_drvTbl_20') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_drvTbl_20];
GO
IF OBJECT_ID('U_EINFINSFSA_drvTbl_10') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_drvTbl_10];
GO
IF OBJECT_ID('U_EINFINSFSA_DedList') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EINFINSFSA') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EINFINSFSA];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EINFINSFSA';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EINFINSFSA';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EINFINSFSA';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EINFINSFSA';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EINFINSFSA';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EINFINSFSA','Infinisource FSA Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EINFINSFSAZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FH"','1','(''DA''=''T|'')','EINFINSFSAZ0','50','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IFS"','2','(''DA''=''T|'')','EINFINSFSAZ0','50','H','01','2',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*"','3','(''DA''=''T|'')','EINFINSFSAZ0','50','H','01','3',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','4','(''DA''=''T|'')','EINFINSFSAZ0','50','H','01','4',NULL,'Synchronize Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentDate"','5','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','H','01','5',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCurrentTime"','6','(''UA''=''T|'')','EINFINSFSAZ0','50','H','01','6',NULL,'Submitted Time',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"2.0"','7','(''DA''=''T'')','EINFINSFSAZ0','50','H','01','7',NULL,'File Version',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N99136"','1','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','1',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PT"','2','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileId"','3','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','3',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','4','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','4',NULL,'Employer Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','5','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','5',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','6','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','6',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','7','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','7',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMI"','8','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','8',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','9','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','9',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','10','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','10',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','11','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','11',NULL,'Mothers Maiden Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','12','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','10','12',NULL,'Date Of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSsn"','13','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','13',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','14','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','14',NULL,'Address Line 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','15','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','15',NULL,'Address Line 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','16','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','16',NULL,'Address Line 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','17','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','17',NULL,'Address Line 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','18','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','18',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','19','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','19',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZipCode"','20','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','20',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','21','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','21',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHomePhone"','22','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','22',NULL,'Home Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkPhone"','23','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','23',NULL,'Work Phone',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkExt"','24','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','24',NULL,'Work Phone Extension',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmailAddress"','25','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','25',NULL,'Email Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','26','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','26',NULL,'Username',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','27','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','27',NULL,'Password',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','28','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','10','28',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','29','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','29',NULL,'Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','30','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','30',NULL,'Hours Per Week',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"All"','31','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','31',NULL,'Employee Class',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPayFrequency"','32','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','32',NULL,'Payroll Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','33','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','33',NULL,'Payroll Frequency Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartStatus"','34','(''UA''=''T|'')','EINFINSFSAZ0','50','D','10','34',NULL,'Participant Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatusEffDate"','35','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','10','35',NULL,'Status Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N"','36','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','36',NULL,'Hold Payroll Deductions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','37','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','37',NULL,'Hold Employer Contributions',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Y"','38','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','38',NULL,'Incur Services',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','39','(''DA''=''T|'')','EINFINSFSAZ0','50','D','10','39',NULL,'Final Payroll Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('""','40','(''DA''=''T'')','EINFINSFSAZ0','50','D','10','40',NULL,'Final Contribution Process Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N99136"','1','(''DA''=''T|'')','EINFINSFSAZ0','50','D','20','1',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EN"','2','(''DA''=''T|'')','EINFINSFSAZ0','50','D','20','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileId"','3','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','3',NULL,'Participant File Import Id',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','4','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','4',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollEffDate"','5','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','20','5',NULL,'Enrollment Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartElectionAmt"','6','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','6',NULL,'ParticipantElection Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrollTermDate"','7','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','20','7',NULL,'Enrollment Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContribLvl"','8','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','8',NULL,'Employer Contribution Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpContrivAmt"','9','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','9',NULL,'Employer Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPrimaryReimb"','10','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','10',NULL,'Primary Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAltReimb"','11','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','11',NULL,'Alternate Reimbursement',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEnrolInClaimExch"','12','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','12',NULL,'Enrolled in Claims Exchange',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvElectAmtInd"','13','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','13',NULL,'Election Amount Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHdhpCoverLvl"','14','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','14',NULL,'HDHP Coverage Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlayYearStartDate"','15','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','20','15',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTermsAndCondAccpt"','16','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','16',NULL,'Terms and Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateTermsAccept"','17','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','17',NULL,'Date Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTimeTermsAccept"','18','(''UA''=''T|'')','EINFINSFSAZ0','50','D','20','18',NULL,'Time Terms Conditions Accepted',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvChangeDate"','19','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','20','19',NULL,'Chagne Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpendDown"','20','(''UA''=''T'')','EINFINSFSAZ0','50','D','20','20',NULL,'Spend Down',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"N99136"','1','(''DA''=''T|'')','EINFINSFSAZ0','50','D','30','1',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CT"','2','(''DA''=''T|'')','EINFINSFSAZ0','50','D','30','2',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPartFileId"','3','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','3',NULL,'Participant File Import ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanName"','4','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','4',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribDate"','5','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','30','5',NULL,'Contribution Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribDesc"','6','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','6',NULL,'Contribution Description',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvContribAmt"','7','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','7',NULL,'Contribution Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAmountType"','8','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','8',NULL,'Amount Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTaxYear"','9','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','9',NULL,'Tax Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNotes"','10','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','10',NULL,'Notes',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearStartDate"','11','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','30','11',NULL,'Plan Year Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanYearEndDate"','12','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','D','30','12',NULL,'Plan Year End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','13','(''UA''=''T|'')','EINFINSFSAZ0','50','D','30','13',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','14','(''UA''=''T'')','EINFINSFSAZ0','50','D','30','14',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FF"','1','(''DA''=''T|'')','EINFINSFSAZ0','50','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailRecordCount"','2','(''UA''=''T|'')','EINFINSFSAZ0','50','T','90','2',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"IFS"','3','(''DA''=''T|'')','EINFINSFSAZ0','50','T','90','3',NULL,'Administrator Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"*"','4','(''DA''=''T|'')','EINFINSFSAZ0','50','T','90','4',NULL,'Employer Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmitDate"','5','(''UDMDY''=''T|'')','EINFINSFSAZ0','50','T','90','5',NULL,'Submitted Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubmitTime"','6','(''UA''=''T'')','EINFINSFSAZ0','50','T','90','6',NULL,'Submitted Time',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFINSFSA_20200413.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Infinisource FSA & Cobra expor','201912119','EMPEXPORT','ONDEMAND',NULL,'EINFINSFSA',NULL,NULL,NULL,'201912119','Dec 11 2019  8:40AM','Dec 11 2019  8:40AM','201912111',NULL,'','','201912111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFINSFSA_20200413.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201912119','EMPEXPORT','SCHEDULED',NULL,'EINFINSFSA',NULL,NULL,NULL,'201912119','Dec 11 2019  8:40AM','Dec 11 2019  8:40AM','201912111',NULL,'','','201912111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFINSFSA_20200413.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201912119','EMPEXPORT','OEACTIVE',NULL,'EINFINSFSA',NULL,NULL,NULL,'201912119','Dec 11 2019  8:40AM','Dec 11 2019  8:40AM','201912111',NULL,'','','201912111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFINSFSA_20200413.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201912119','EMPEXPORT','OEPASSIVE',NULL,'EINFINSFSA',NULL,NULL,NULL,'201912119','Dec 11 2019  8:40AM','Dec 11 2019  8:40AM','201912111',NULL,'','','201912111',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EINFINSFSA_20200413.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202003319','EMPEXPORT','TEST','Mar 27 2020 12:54PM','EINFINSFSA',NULL,NULL,NULL,'202003319','Mar 31 2020 12:00AM','Dec 30 1899 12:00AM','202003311','384','','','202003311',dbo.fn_GetTimedKey(),NULL,'us3lKiINS1016',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EINFINSFSA_20200413.txt' END WHERE expFormatCode = 'EINFINSFSA';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFINSFSA','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFINSFSA','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFINSFSA','InitialSort','C','drvSort1');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFINSFSA','SubSort','C','drvSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFINSFSA','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EINFINSFSA','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EINFINSFSA' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EINFINSFSA' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EINFINSFSA_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EINFINSFSA_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFINSFSA','H01','dbo.U_EINFINSFSA_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFINSFSA','D10','dbo.U_EINFINSFSA_drvTbl_10',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFINSFSA','D20','dbo.U_EINFINSFSA_drvTbl_20',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFINSFSA','D30','dbo.U_EINFINSFSA_drvTbl_30',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EINFINSFSA','T90','dbo.U_EINFINSFSA_Trailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EINFINSFSA') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EINFINSFSA] (
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
IF OBJECT_ID('U_EINFINSFSA_DedList') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EINFINSFSA_drvTbl_10') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_drvTbl_10] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] varchar(12) NULL,
    [drvSort2] varchar(1) NOT NULL,
    [drvPartFileId] char(11) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMI] varchar(1) NULL,
    [drvGender] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvSsn] char(11) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZipCode] varchar(50) NULL,
    [drvCountry] varchar(2) NOT NULL,
    [drvHomePhone] varchar(1) NOT NULL,
    [drvWorkPhone] varchar(1) NOT NULL,
    [drvWorkExt] varchar(1) NOT NULL,
    [drvEmailAddress] varchar(50) NULL,
    [drvDateOfLastHire] datetime NULL,
    [drvPayFrequency] varchar(12) NOT NULL,
    [drvPartStatus] varchar(10) NOT NULL,
    [drvStatusEffDate] datetime NULL
);
IF OBJECT_ID('U_EINFINSFSA_drvTbl_20') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_drvTbl_20] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] varchar(12) NULL,
    [drvSort2] varchar(1) NOT NULL,
    [drvPartFileId] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvEnrollEffDate] datetime NULL,
    [drvPartElectionAmt] varchar(12) NULL,
    [drvEnrollTermDate] datetime NULL,
    [drvEmpContribLvl] varchar(1) NOT NULL,
    [drvEmpContrivAmt] varchar(1) NOT NULL,
    [drvPrimaryReimb] varchar(1) NOT NULL,
    [drvAltReimb] varchar(1) NOT NULL,
    [drvEnrolInClaimExch] varchar(1) NOT NULL,
    [drvElectAmtInd] varchar(8) NOT NULL,
    [drvHdhpCoverLvl] varchar(1) NOT NULL,
    [drvPlayYearStartDate] varchar(1) NOT NULL,
    [drvTermsAndCondAccpt] varchar(1) NOT NULL,
    [drvDateTermsAccept] varchar(1) NOT NULL,
    [drvTimeTermsAccept] varchar(1) NOT NULL,
    [drvChangeDate] varchar(1) NOT NULL,
    [drvSpendDown] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EINFINSFSA_drvTbl_30') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_drvTbl_30] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSort1] varchar(12) NULL,
    [drvSort2] varchar(1) NOT NULL,
    [drvPartFileId] char(11) NULL,
    [drvPlanName] varchar(19) NULL,
    [drvContribDate] datetime NULL,
    [drvContribDesc] varchar(17) NOT NULL,
    [drvContribAmt] varchar(12) NULL,
    [drvAmountType] varchar(6) NOT NULL,
    [drvTaxYear] varchar(1) NOT NULL,
    [drvNotes] varchar(1) NOT NULL,
    [drvPlanYearStartDate] varchar(1) NOT NULL,
    [drvPlanYearEndDate] varchar(1) NOT NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameFirst] varchar(100) NULL
);
IF OBJECT_ID('U_EINFINSFSA_EEList') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EINFINSFSA_File') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EINFINSFSA_Header') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_Header] (
    [drvCurrentDate] datetime NOT NULL,
    [drvCurrentTime] varchar(8000) NULL
);
IF OBJECT_ID('U_EINFINSFSA_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_PDedHist] (
    [PdhEEID] char(12) NOT NULL,
    [PdhEECurAmt] numeric NULL,
    [PdhERCurAmt] numeric NULL,
    [PdhEECurAmtYTD] money NULL,
    [PdhERCurAmtYTD] money NULL,
    [FSA] numeric NULL,
    [FSADC] numeric NULL,
    [FSAL] numeric NULL
);
IF OBJECT_ID('U_EINFINSFSA_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_PEarHist] (
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
IF OBJECT_ID('U_EINFINSFSA_Trailer') IS NULL
CREATE TABLE [dbo].[U_EINFINSFSA_Trailer] (
    [drvDetailRecordCount] varchar(20) NULL,
    [drvSubmitDate] datetime NOT NULL,
    [drvSubmitTime] varchar(8000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EINFINSFSA]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Institute of Nuclear Power Operations

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 12/11/2019
Service Request Number: TekP-2019-10-22-0002

Purpose: Infinisource FSA & Cobra export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EINFINSFSA';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EINFINSFSA';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EINFINSFSA';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EINFINSFSA';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EINFINSFSA' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFINSFSA', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFINSFSA', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFINSFSA', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EINFINSFSA', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EINFINSFSA';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EINFINSFSA', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EINFINSFSA';

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
    DELETE FROM dbo.U_EINFINSFSA_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EINFINSFSA_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'FSA,FSADC,FSAL';

    IF OBJECT_ID('U_EINFINSFSA_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EINFINSFSA_DedList
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
    IF OBJECT_ID('U_EINFINSFSA_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_PDedHist;
    SELECT DISTINCT
         PdhEEID
        -- Current Payroll Amounts
        ,PdhEECurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhEECurAmt ELSE 0.00 END)
        ,PdhERCurAmt    = SUM(CASE WHEN PdhPerControl BETWEEN @StartPerControl AND @EndPerControl THEN PdhERCurAmt ELSE 0.00 END)
        -- YTD Payroll Amounts
        ,PdhEECurAmtYTD = SUM(PdhEECurAmt)
        ,PdhERCurAmtYTD = SUM(PdhERCurAmt)
        -- Categorize Payroll Amounts
        ,FSA     = SUM(CASE WHEN PdhDedCode IN ('FSA') THEN PdhEECurAmt ELSE 0.00 END)
        ,FSADC     = SUM(CASE WHEN PdhDedCode IN ('FSADC') THEN PdhEECurAmt ELSE 0.00 END)
        ,FSAL     = SUM(CASE WHEN PdhDedCode IN ('FSAL') THEN PdhEECurAmt ELSE 0.00 END)        
    INTO dbo.U_EINFINSFSA_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EINFINSFSA_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EINFINSFSA_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_PEarHist;
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
    INTO dbo.U_EINFINSFSA_PEarHist
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
    -- DETAIL RECORD - U_EINFINSFSA_drvTbl_10
    ---------------------------------
    IF OBJECT_ID('U_EINFINSFSA_drvTbl_10','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_drvTbl_10;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = '2' + eepSSN
        ,drvSort2 = '2'
        -- standard fields above and additional driver fields below
        ,drvPartFileId = eepSSN
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
        ,drvNameMI = LEFT(ISNULL(EepNameFirst,''),1)
        ,drvGender = ''
        ,drvMaritalStatus = ''
        ,drvDateOfBirth = EepDateOfBirth
        ,drvSsn = eepSSN
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvAddressCity = EepAddressCity
        ,drvAddressState = EepAddressState
        ,drvAddressZipCode = EepAddressZipCode
        ,drvCountry= 'US'
        ,drvHomePhone = ''
        ,drvWorkPhone = ''
        ,drvWorkExt = ''
        ,drvEmailAddress = eepaddressemail
        ,drvDateOfLastHire = EecDateOfLastHire
        ,drvPayFrequency = 'Semi-Monthly'

        ,drvPartStatus = CASE WHEN EecEmplStatus = 'L' THEN 'LOA'
                              WHEN EecEmplStatus = 'T' THEN 'Terminated'
                              ELSE 'Active'
                         END
        ,drvStatusEffDate = EecEmplStatusStartDate
    INTO dbo.U_EINFINSFSA_drvTbl_10
    FROM dbo.U_EINFINSFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EINFINSFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EINFINSFSA_PDedHist WITH (NOLOCK)
        ON Pdheeid = Xeeid
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EINFINSFSA_drvTbl_20
    ---------------------------------
    IF OBJECT_ID('U_EINFINSFSA_drvTbl_20','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_drvTbl_20;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = '2' + eepSSN
        ,drvSort2 = '3'
        -- standard fields above and additional driver fields below
        ,drvPartFileId = eepSSN
        ,drvPlanName = CASE WHEN BdmDedCode = 'FSA'  THEN 'Health Care Account'
                            WHEN BdmDedCode = 'FSADC'THEN 'Dependent Care'
                            WHEN BdmDedCode = 'FSAL' THEN 'Limited FSA'
                       END
        ,drvEnrollEffDate =   bdmBenStartDate
        ,drvPartElectionAmt = CAST( CONVERT(DECIMAL(10,2),bdmeegoalamt) as varchar(12))
        ,drvEnrollTermDate =  CASE WHEN EecEmplStatus = 'A' THEN bdmBenStopDate ELSE  NULL END
        ,drvEmpContribLvl = ''
        ,drvEmpContrivAmt = ''
        ,drvPrimaryReimb = ''
        ,drvAltReimb = ''
        ,drvEnrolInClaimExch = ''
        ,drvElectAmtInd = 'PlanYear'
        ,drvHdhpCoverLvl = ''
        ,drvPlayYearStartDate = ''
        ,drvTermsAndCondAccpt = ''
        ,drvDateTermsAccept = ''
        ,drvTimeTermsAccept = ''
        ,drvChangeDate = ''
        ,drvSpendDown = ''
    INTO dbo.U_EINFINSFSA_drvTbl_20
    FROM dbo.U_EINFINSFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN (Select bdmeeid,bdmcoid,bdmdedcode,max(bdmbenstartdate) as bdmbenstartdate,max(bdmbenstopdate) as bdmbenstopdate,sum(bdmeegoalamt) as bdmeegoalamt from dbo.U_dsi_BDM_EINFINSFSA WITH (NOLOCK) group by  bdmeeid,bdmcoid,bdmdedcode) as BdmConsolidated
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    JOIN dbo.U_EINFINSFSA_PDedHist WITH (NOLOCK)
        ON Pdheeid = Xeeid
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EINFINSFSA_drvTbl_30
    ---------------------------------
    IF OBJECT_ID('U_EINFINSFSA_drvTbl_30','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_drvTbl_30;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSort1 = '2' + eepSSN
        ,drvSort2 = '4'
        -- standard fields above and additional driver fields below
        ,drvPartFileId = eepssn
        ,drvPlanName = CASE WHEN BdmDedCode = 'FSA'  THEN 'Health Care Account'
                            WHEN BdmDedCode = 'FSADC'  THEN 'Dependent Care'
                            WHEN BdmDedCode = 'FSAL'  THEN 'Limited FSA'
                       END
        ,drvContribDate = PrgPayDate
        ,drvContribDesc = 'Payroll Deduction'
        ,drvContribAmt = CASE  WHEN BdmDedCode = 'FSA'  THEN  CAST(CONVERT(DECIMAL(10,2),FSA) as VARCHAR(12))
                            WHEN BdmDedCode = 'FSADC'   THEN  CAST(CONVERT(DECIMAL(10,2),FSADC) as VARCHAR(12))
                             WHEN BdmDedCode = 'FSAL'  THEN  CAST(CONVERT(DECIMAL(10,2),FSAL) as VARCHAR(12))
                       END
                      
        ,drvAmountType = 'Actual'
        ,drvTaxYear = ''
        ,drvNotes = ''
        ,drvPlanYearStartDate = ''
        ,drvPlanYearEndDate = ''
        ,drvNameLast = EepNameLast
        ,drvNameFirst = EepNameFirst
    INTO dbo.U_EINFINSFSA_drvTbl_30
    FROM dbo.U_EINFINSFSA_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_dsi_BDM_EINFINSFSA WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCoID = xCoID
    LEFT JOIN dbo.U_EINFINSFSA_PEarHist  WITH (NOLOCK)
        ON PehEEID = XEEID
    JOIN dbo.U_EINFINSFSA_PDedHist  WITH (NOLOCK)
        ON PdhEEID = XEEID
    ;
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINFINSFSA_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_Header;
    SELECT DISTINCT
         drvCurrentDate = GETDATE()
        ,drvCurrentTime = REPLACE(CONVERT(VARCHAR(8),CAST(GETDATE() AS TIME), 108),':','')
    INTO dbo.U_EINFINSFSA_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EINFINSFSA_Trailer','U') IS NOT NULL
        DROP TABLE dbo.U_EINFINSFSA_Trailer;
    SELECT DISTINCT
         drvDetailRecordCount =  CAST( ( (Select count(*)   from U_EINFINSFSA_drvTbl_10)  + (Select count(*)   from U_EINFINSFSA_drvTbl_20)  + (Select count(*)   from U_EINFINSFSA_drvTbl_30 )) as varchar(20))
        ,drvSubmitDate = GETDATE()
        ,drvSubmitTime =  REPLACE(CONVERT(VARCHAR(8),CAST(GETDATE() AS TIME), 108),':','')
    INTO dbo.U_EINFINSFSA_Trailer
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
ALTER VIEW dbo.dsi_vwEINFINSFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EINFINSFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EINFINSFSA%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912041'
       ,expStartPerControl     = '201912041'
       ,expLastEndPerControl   = '201912119'
       ,expEndPerControl       = '201912119'
WHERE expFormatCode = 'EINFINSFSA';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEINFINSFSA_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EINFINSFSA_File (NOLOCK)
    ORDER BY  InitialSort, SubSort;