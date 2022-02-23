SET NOCOUNT ON;
IF OBJECT_ID('U_EPNGCOBRAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EPNGCOBRAX_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EPNGCOBRAX' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEPNGCOBRAX_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEPNGCOBRAX_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EPNGCOBRAX') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPNGCOBRAX];
GO
IF OBJECT_ID('U_EPNGCOBRAX_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_PEarHist];
GO
IF OBJECT_ID('U_EPNGCOBRAX_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_PDedHist];
GO
IF OBJECT_ID('U_EPNGCOBRAX_Header') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_Header];
GO
IF OBJECT_ID('U_EPNGCOBRAX_File') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_File];
GO
IF OBJECT_ID('U_EPNGCOBRAX_EEList') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_EEList];
GO
IF OBJECT_ID('U_EPNGCOBRAX_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_drvTrailer];
GO
IF OBJECT_ID('U_EPNGCOBRAX_drvPcr') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_drvPcr];
GO
IF OBJECT_ID('U_EPNGCOBRAX_drvEmp') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_drvEmp];
GO
IF OBJECT_ID('U_EPNGCOBRAX_drvCov') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_drvCov];
GO
IF OBJECT_ID('U_EPNGCOBRAX_DedList') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EPNGCOBRAX') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EPNGCOBRAX];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EPNGCOBRAX';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EPNGCOBRAX';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EPNGCOBRAX';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EPNGCOBRAX';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EPNGCOBRAX';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EPNGCOBRAX','P&A Group Cobra Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EPNGCOBRAXZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordTypeHeader"','1','(''UA''=''T,'')','EPNGCOBRAXZ0','3','H','01','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate"','2','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','H','01','5',NULL,'File Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginator"','3','(''UA''=''T,'')','EPNGCOBRAXZ0','30','H','01','16',NULL,'Originator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOriginatorEmail"','4','(''UA''=''T'')','EPNGCOBRAXZ0','100','H','01','47',NULL,'File Origination Email',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordTypeEmp"','1','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','10','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyNumber"','2','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','10','5',NULL,'Company  Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeSSN"','3','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','10','16',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeId"','4','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','10','28',NULL,'Filler/ Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentBeneId"','5','(''UA''=''T,'')','EPNGCOBRAXZ0','2','D','10','40',NULL,'Filler/ Dependent Beneficiary ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeAssociationId"','6','(''UA''=''T,'')','EPNGCOBRAXZ0','9','D','10','43',NULL,'Filler/ Employee Association ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','7','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','10','53',NULL,'Employee Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFirstName"','8','(''UA''=''T,'')','EPNGCOBRAXZ0','50','D','10','64',NULL,'Employee First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMiddleInitial"','9','(''UA''=''T,'')','EPNGCOBRAXZ0','1','D','10','115',NULL,'Employee Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLastName"','10','(''UA''=''T,'')','EPNGCOBRAXZ0','50','D','10','117',NULL,'Employee Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','11','(''UA''=''T,'')','EPNGCOBRAXZ0','1','D','10','168',NULL,'Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLocation"','12','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','10','170',NULL,'Location / Division',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBenefitProgram"','13','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','10','181',NULL,'Filler/ Employee Benefit Program',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmployeeUnion"','14','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','10','185',NULL,'Filler/ Employee Union',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDistAgencyCode"','15','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','10','196',NULL,'Filler/ Distribution Agency Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCompanyName"','16','(''UA''=''T'')','EPNGCOBRAXZ0','30','D','10','207',NULL,'Company Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenRecordType"','1','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','20','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEmpSSN"','2','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','20','5',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBenEmpId"','3','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','20','17',NULL,'Filler/ Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpBeneId"','4','(''UA''=''T,'')','EPNGCOBRAXZ0','2','D','20','29',NULL,'Filler/ Dependent Beneficiary ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpAssociationId"','5','(''UA''=''T,'')','EPNGCOBRAXZ0','9','D','20','32',NULL,'Filler/ Employee Association ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBSSN"','6','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','20','42',NULL,'Qualifying Beneficiary SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBDateofBirth"','7','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','20','54',NULL,'Qualifying Beneficiary Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBFirstName"','8','(''UA''=''T,'')','EPNGCOBRAXZ0','50','D','20','65',NULL,'Qualifying Beneficiary First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBMiddleName"','9','(''UA''=''T,'')','EPNGCOBRAXZ0','1','D','20','116',NULL,'Qualifying Beneficiary Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvQBLastName"','10','(''UA''=''T,'')','EPNGCOBRAXZ0','50','D','20','118',NULL,'Qualifying BeneficiaryB Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvForeignIndicator"','11','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','20','169',NULL,'Foreign Address Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','12','(''UA''=''T,'')','EPNGCOBRAXZ0','55','D','20','173',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','13','(''UA''=''T,'')','EPNGCOBRAXZ0','55','D','20','229',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','14','(''UA''=''T,'')','EPNGCOBRAXZ0','35','D','20','285',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','15','(''UA''=''T,'')','EPNGCOBRAXZ0','2','D','20','321',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZipCode"','16','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','20','324',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountryCode"','17','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','20','335',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRelationCode"','18','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','20','339',NULL,'Relation Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLifeEventDate"','19','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','20','350',NULL,'Life Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEventReasonCode"','20','(''UA''=''T,'')','EPNGCOBRAXZ0','35','D','20','361',NULL,'Event Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabled"','21','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','20','397',NULL,'Disabled',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','22','(''UA''=''T,'')','EPNGCOBRAXZ0','1','D','20','401',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSeveranceFlag"','23','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','20','403',NULL,'Filler/ Severance Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSevStartDate"','24','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','20','407',NULL,'Filler/ Severance Start Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSevEndDate"','25','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','20','418',NULL,'Filler/ Severance End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedIndicator"','26','(''UA''=''T,'')','EPNGCOBRAXZ0','1','D','20','429',NULL,'Filler/ Medicare Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedicareDate"','27','(''UD101''=''T'')','EPNGCOBRAXZ0','10','D','20','431',NULL,'Filler/ Medicare Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPcrRecordType"','1','(''UA''=''T,'')','EPNGCOBRAXZ0','3','D','30','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPcrEmpSSN"','2','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','30','5',NULL,'Employee SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPcrEmpId"','3','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','30','17',NULL,'Filler/ Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPcrBenificiaryId"','4','(''UA''=''T,'')','EPNGCOBRAXZ0','2','D','30','29',NULL,'Filler/ Dependent Beneficiary ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPcrEmpAssociationId"','5','(''UA''=''T,'')','EPNGCOBRAXZ0','9','D','30','32',NULL,'Filler/ Employee Association ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRDependentSSN"','6','(''UA''=''T,'')','EPNGCOBRAXZ0','11','D','30','42',NULL,'Dependent SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRCarrier"','7','(''UA''=''T,'')','EPNGCOBRAXZ0','15','D','30','54',NULL,'Carrier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRCategory"','8','(''UA''=''T,'')','EPNGCOBRAXZ0','15','D','30','70',NULL,'Category',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRPlanName"','9','(''UA''=''T,'')','EPNGCOBRAXZ0','30','D','30','86',NULL,'Plan Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRPlanType"','10','(''UA''=''T,'')','EPNGCOBRAXZ0','12','D','30','117',NULL,'Plan Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRGroupNumber"','11','(''UA''=''T,'')','EPNGCOBRAXZ0','30','D','30','130',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRSubGroupNumber"','12','(''UA''=''T,'')','EPNGCOBRAXZ0','30','D','30','161',NULL,'Sub Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRBranchGroupNumber"','13','(''UA''=''T,'')','EPNGCOBRAXZ0','30','D','30','192',NULL,'Branch Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRTierLevel"','14','(''UA''=''T,'')','EPNGCOBRAXZ0','15','D','30','223',NULL,'Tier Level',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRPCT"','15','(''UA''=''T,'')','EPNGCOBRAXZ0','2','D','30','239',NULL,'Filler/ LTD PCT%',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRPAIAmount"','16','(''UA''=''T,'')','EPNGCOBRAXZ0','7','D','30','242',NULL,'Filler/ PAI Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRELFAmount"','17','(''UA''=''T,'')','EPNGCOBRAXZ0','7','D','30','250',NULL,'Filler/ ELF Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRCovCeaseDate"','18','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','30','258',NULL,'Coverage Cease Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRLifeEventDate"','19','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','30','269',NULL,'Life Event Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRCoverageEffectiveDate"','20','(''UD101''=''T,'')','EPNGCOBRAXZ0','10','D','30','280',NULL,'Active Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRHRAElectionAmt"','21','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','30','317',NULL,'FSA Monthly Premium',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRPayrollDedAmt"','22','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','30','328',NULL,'FSA Monthly Cost',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRFiller"','23','(''UA''=''T,'')','EPNGCOBRAXZ0','10','D','30','339',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPCRHRAYTDClaims"','24','(''UA''=''T'')','EPNGCOBRAXZ0','10','D','30','350',NULL,'FSA Annual Election Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTrailerRecordType"','1','(''UA''=''T,'')','EPNGCOBRAXZ0','3','T','90','1',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNumberofRecordsInFile"','2','(''UA''=''T'')','EPNGCOBRAXZ0','6','T','90','5',NULL,'Number of records in file',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPNGCOBRAX_20200226.txt',NULL,'','',NULL,NULL,NULL,NULL,'P&A Group Cobra Export','201911079','EMPEXPORT','ONDEMAND',NULL,'EPNGCOBRAX',NULL,NULL,NULL,'201911079','Nov  7 2019  1:11PM','Nov  7 2019  1:11PM','201911071',NULL,'','','201911071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPNGCOBRAX_20200226.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scheduled Session','201911079','EMPEXPORT','SCHEDULED',NULL,'EPNGCOBRAX',NULL,NULL,NULL,'201911079','Nov  7 2019  1:11PM','Nov  7 2019  1:11PM','201911071',NULL,'','','201911071',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EPNGCOBRAX_20200226.txt',NULL,'','','WXL0D,IAGFG',NULL,NULL,NULL,'Test Purposes Only','202003319','EMPEXPORT','TEST','Feb 14 2020 12:34PM','EPNGCOBRAX',NULL,NULL,NULL,'202003319','Mar 31 2020 12:00AM','Dec 30 1899 12:00AM','202002011','46','','','202002011',dbo.fn_GetTimedKey(),NULL,'us3lKiNIS1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EPNGCOBRAX_20200226.txt' END WHERE expFormatCode = 'EPNGCOBRAX';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNGCOBRAX','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNGCOBRAX','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNGCOBRAX','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNGCOBRAX','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNGCOBRAX','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EPNGCOBRAX','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EPNGCOBRAX' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EPNGCOBRAX' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EPNGCOBRAX_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EPNGCOBRAX_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPNGCOBRAX','H01','dbo.U_EPNGCOBRAX_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPNGCOBRAX','D10','dbo.U_EPNGCOBRAX_drvEmp',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPNGCOBRAX','D20','dbo.U_EPNGCOBRAX_drvCov',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPNGCOBRAX','D30','dbo.U_EPNGCOBRAX_drvPcr',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EPNGCOBRAX','T90','dbo.U_EPNGCOBRAX_drvTrailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EPNGCOBRAX') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EPNGCOBRAX] (
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
IF OBJECT_ID('U_EPNGCOBRAX_DedList') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_drvCov') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_drvCov] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvBenRecordType] varchar(3) NOT NULL,
    [drvBenEmpSSN] varchar(11) NULL,
    [drvBenEmpId] char(9) NULL,
    [drvEmpBeneId] varchar(1) NOT NULL,
    [drvEmpAssociationId] varchar(1) NOT NULL,
    [drvQBSSN] varchar(11) NULL,
    [drvQBDateofBirth] datetime NULL,
    [drvQBFirstName] varchar(100) NULL,
    [drvQBMiddleName] varchar(1) NULL,
    [drvQBLastName] varchar(100) NULL,
    [drvForeignIndicator] varchar(2) NOT NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZipCode] varchar(50) NULL,
    [drvCountryCode] char(3) NULL,
    [drvRelationCode] varchar(2) NULL,
    [drvLifeEventDate] datetime NULL,
    [drvEventReasonCode] varchar(10) NOT NULL,
    [drvDisabled] varchar(3) NULL,
    [drvGender] char(1) NULL,
    [drvSeveranceFlag] varchar(1) NOT NULL,
    [drvSevStartDate] varchar(1) NOT NULL,
    [drvSevEndDate] varchar(1) NOT NULL,
    [drvMedIndicator] varchar(1) NOT NULL,
    [drvMedicareDate] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_drvEmp') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_drvEmp] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvRecordTypeEmp] varchar(3) NOT NULL,
    [drvCompanyNumber] varchar(4) NOT NULL,
    [drvEmployeeSSN] varchar(11) NULL,
    [drvEmployeeId] char(9) NULL,
    [drvDependentBeneId] varchar(1) NOT NULL,
    [drvEmployeeAssociationId] varchar(1) NOT NULL,
    [drvDateOfBirth] datetime NULL,
    [drvFirstName] varchar(100) NULL,
    [drvMiddleInitial] varchar(1) NULL,
    [drvLastName] varchar(100) NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvLocation] varchar(7) NOT NULL,
    [drvEmpBenefitProgram] varchar(1) NOT NULL,
    [drvEmployeeUnion] varchar(1) NOT NULL,
    [drvDistAgencyCode] varchar(1) NOT NULL,
    [drvCompanyName] varchar(30) NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_drvPcr') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_drvPcr] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvSSN] char(11) NULL,
    [drvInitialSort] char(11) NULL,
    [drvSubSort] varchar(1) NOT NULL,
    [drvPcrRecordType] varchar(3) NOT NULL,
    [drvPcrEmpSSN] varchar(11) NULL,
    [drvPcrEmpId] char(9) NULL,
    [drvPcrBenificiaryId] varchar(1) NOT NULL,
    [drvPcrEmpAssociationId] varchar(1) NOT NULL,
    [drvPCRDependentSSN] varchar(11) NULL,
    [drvPCRCarrier] varchar(7) NULL,
    [drvPCRCategory] varchar(7) NULL,
    [drvPCRPlanName] varchar(9) NULL,
    [drvPCRPlanType] varchar(7) NULL,
    [drvPCRGroupNumber] varchar(1) NOT NULL,
    [drvPCRSubGroupNumber] varchar(1) NOT NULL,
    [drvPCRBranchGroupNumber] varchar(1) NOT NULL,
    [drvPCRTierLevel] varchar(6) NULL,
    [drvPCRPCT] varchar(1) NOT NULL,
    [drvPCRPAIAmount] varchar(1) NOT NULL,
    [drvPCRELFAmount] varchar(1) NOT NULL,
    [drvPCRCovCeaseDate] datetime NULL,
    [drvPCRLifeEventDate] datetime NULL,
    [drvPCRCoverageEffectiveDate] datetime NULL,
    [drvPCRHRAElectionAmt] money NULL,
    [drvPCRPayrollDedAmt] money NULL,
    [drvPCRFiller] varchar(1) NOT NULL,
    [drvPCRHRAYTDClaims] money NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_drvTrailer] (
    [drvTrailerRecordType] varchar(3) NOT NULL,
    [drvNumberofRecordsInFile] varchar(10) NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_EEList') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_File') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_Header') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_Header] (
    [drvRecordTypeHeader] varchar(3) NOT NULL,
    [drvFileDate] datetime NOT NULL,
    [drvOriginator] varchar(11) NOT NULL,
    [drvOriginatorEmail] varchar(34) NOT NULL
);
IF OBJECT_ID('U_EPNGCOBRAX_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_PDedHist] (
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
IF OBJECT_ID('U_EPNGCOBRAX_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EPNGCOBRAX_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EPNGCOBRAX]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: UniCarriers Americas Corporation

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 11/07/2019
Service Request Number: TekP-2019-10-18-0004

Purpose: P&A Group Cobra Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EPNGCOBRAX';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EPNGCOBRAX';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EPNGCOBRAX';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EPNGCOBRAX';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EPNGCOBRAX' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPNGCOBRAX', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EPNGCOBRAX', 'TEST';
EXEC dbo.dsi_BDM_sp_ErrorCheck 'EPNGCOBRAX';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EPNGCOBRAX', @AllObjects = 'Y', @IsWeb = 'Y'
**********************************************************************************/
BEGIN

    --==========================================
    -- Declare variables
    --==========================================
    DECLARE  @FormatCode        VARCHAR(10)
             ,@FormatCode2        VARCHAR(10)
            ,@ExportCode        VARCHAR(10)
            ,@StartDate         DATETIME
            ,@EndDate           DATETIME
            ,@StartPerControl   VARCHAR(9)
            ,@EndPerControl     VARCHAR(9);

    -- Set FormatCode
    SELECT @FormatCode = 'EPNGCOBRAX';
    SELECT @FormatCode2 = 'EPNGCOBRAN';

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
    DELETE FROM dbo.U_EPNGCOBRAX_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EPNGCOBRAX_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = '201,202,203,205,206,207,220,280,95';

    IF OBJECT_ID('U_EPNGCOBRAX_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EPNGCOBRAX_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
            -- NPM parameters

    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'NPM')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'NewEnrolleeType','3'); -- All new enrollees where no previous plan exists
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'TableType','EMP'); -- Only include employees on NPM file
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'UseCobraCoveredDeds','Y'); -- DedIsCobraCovered = 'Y'

        -- Run BDM Module
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsEmp', '201,204,LEVNT3,LEVNT4,206,207,203,200,208') 
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'CobraReasonsDep', '201,204,LEVNT3,LEVNT4,206,207,203,200,208')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraType','3'); -- Eep/ConCobraReason first, then EdhChangeReason. Include CHGRP for elig. ben groups
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraDate','2'); -- EedBenStopDate and DbnBenStopDate, unless Eep/ConDateOfCOBRAEvent exist
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraPQBType','1'); -- If no EE or spouse, ALL children are PQB (not just oldest)
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CobraReasonsDepPQB','201,204,LEVNT3,LEVNT4,206,207,203,200'); -- Valid dependent PQB reasons
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidCobraReasonsEmp','201,204,LEVNT3,LEVNT4,206,207,203,200'); -- Invalidate employee when Cobra Reason is a dependent PQB reason
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'InvalidTermReasonsEmp','203'); -- Invalidate employee when Cobra Reason is "Death"
   
    --INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'ConCobraReasonPCF','DependentCOBRAReason'); -- Valid dependent PQB reasons
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'CountDependents','Y');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsChild','CHL,STC')
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES (@FormatCode,'BuildConsolidatedTable','Standard');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'RunID', 'QB')
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'AddToPreviousRun', 'Y')
    EXEC dbo.dsi_BDM_sp_PopulateDeductionsTable @FormatCode;




        ---------------------------------

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EPNGCOBRAX_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_PDedHist;
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
    INTO dbo.U_EPNGCOBRAX_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EPNGCOBRAX_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EPNGCOBRAX_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_PEarHist;
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
    INTO dbo.U_EPNGCOBRAX_PEarHist
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
    -- DETAIL RECORD - U_EPNGCOBRAX_drvEmp
    ---------------------------------
    IF OBJECT_ID('U_EPNGCOBRAX_drvEmp','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_drvEmp;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSSN = eepSSN
        ,drvInitialSort = eepSSN
        ,drvSubSort = '2'
        -- standard fields above and additional driver fields below
        ,drvRecordTypeEmp = 'EMP'
        ,drvCompanyNumber = '1633'
        ,drvEmployeeSSN = SUBSTRING(eepssn, 1, 3)+'-'+ SUBSTRING(eepssn, 4, 2)+'-'+ SUBSTRING(eepssn, 3, 4)
        ,drvEmployeeId = EecEmpNo
        ,drvDependentBeneId = ''
        ,drvEmployeeAssociationId = ''
        ,drvDateOfBirth = EepDateOfBirth
        ,drvFirstName = EepNameFirst
        ,drvMiddleInitial = LEFT(EepNameMiddle,1)
        ,drvLastName = EepNameLast
        ,drvStatus = CASE WHEN EecEmplStatus = 'T' and EecTermReason = '202' THEN 'R' else  'A' END
        ,drvLocation = 'MARENGO'
        ,drvEmpBenefitProgram = ''
        ,drvEmployeeUnion = ''
        ,drvDistAgencyCode = ''
        ,drvCompanyName = LEFT(CmpCompanyName,30)
    INTO dbo.U_EPNGCOBRAX_drvEmp
    FROM dbo.U_EPNGCOBRAX_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.Company WITH (NOLOCK)
        ON CmpCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EPNGCOBRAX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCOID = xCoID
        WHERE BdmRecType = 'EMP'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPNGCOBRAX_drvCov
    ---------------------------------
    IF OBJECT_ID('U_EPNGCOBRAX_drvCov','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_drvCov;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID --DELETE IF NOT USING DEPENDENT DATA
        ,drvSSN = eepSSN
        ,drvInitialSort = eepSSN
        ,drvSubSort = '3'
        -- standard fields above and additional driver fields below
        ,drvBenRecordType = 'QBR'
        ,drvBenEmpSSN = SUBSTRING(eepssn, 1, 3)+'-'+ SUBSTRING(eepssn, 4, 2)+'-'+ SUBSTRING(eepssn, 3, 4)
        ,drvBenEmpId = EecEmpNo
        ,drvEmpBeneId = ''
        ,drvEmpAssociationId =''
        ,drvQBSSN =  CASE WHEN BdmRecType = 'DEP' THEN SUBSTRING(ConSSN, 1, 3)+'-'+ SUBSTRING(ConSSN, 4, 2)+'-'+ SUBSTRING(ConSSN, 3, 4)  ELSE SUBSTRING(eepssn, 1, 3)+'-'+ SUBSTRING(eepssn, 4, 2)+'-'+ SUBSTRING(eepssn, 3, 4) END
        ,drvQBDateofBirth =  CASE WHEN BdmRecType = 'DEP' THEN ConDateOfBirth ELSE EepDateOfBirth END
        ,drvQBFirstName =  CASE WHEN BdmRecType = 'DEP' THEN ConNameFirst ELSE EepNameFirst END
        ,drvQBMiddleName = CASE WHEN BdmRecType = 'DEP' THEN LEFT(ISNULL(ConnameMiddle,''),1) ELSE  LEFT(ISNULL(EepNameMiddle,''),1) END
        ,drvQBLastName = CASE WHEN BdmRecType = 'DEP' THEN ConNameLast ELSE EepNameLast END
        ,drvForeignIndicator = 'No'
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZipCode = EepAddressZipCode
        ,drvCountryCode = EepAddressCountry

        ,drvRelationCode = CASE WHEN BdmREcType = 'EMP' THEN  'EE'
                                WHEN BdmREcType = 'DEP' THEN  
                                    CASE WHEN ConRelationship IN ('SPS') THEN 'SP'
                                          WHEN ConRelationship IN ('DP') THEN 'DP'
                                          WHEN ConRelationship IN ('CHL','STC') THEN 'CH'
                                    END
                            END
        ,drvLifeEventDate = CASE WHEN BdmRunID = 'NPM' THEN 
                                CASE WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT1') and EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN eecdateoflasthire
                                            WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT4') and  EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN BdmDateOfCobraEvent
                                            WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT2') and  EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN BdmDateOfCobraEvent
                                            ELSE eecdateoflasthire

                                        END
                                 ELSE BdmDateOfCobraEvent
                            END
        /*if EecEmplStatus = T and EecTermReason = 203 send DEATH
if EecEmplStatus = T and EecTermReason = 200 send LAYOFF
if EecEmplStatus = T and EecTermReason does not = 200 or 203 send TERM 
if EecEmplStatus = A and ConCOBRAReason = 201 or LEVNT3 send CEASE-A
if EecEmplStatus = A and ConCOBRAReason = 204 or LEVNT4 send DIVORCE
if EecEmplStatus = A and eepCOBRAReason = 205 send MEDICARE
if eepCOBRAReason = 207 send MILITARY
if EecEmplStatus = A and eepCOBRAReason = 203 send REDUCE
else send TERM
*/
        ,drvEventReasonCode =    CASE WHEN BdmRunID = 'NPM' THEN
                                        CASE WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT1') and EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN 'NEW HIRE'
                                            WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT4') and  EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN 'NEW MEMBER'
                                            WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT2') and  EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN 'NEW MEMBER'
                                            ELSE 'NEW HIRE'

                                        END
                                ELSE
                                        
                                             CASE WHEN EecEmplStatus = 'T' and EecTermReason = '203' THEN 'DEATH'
                                                   WHEN EecEmplStatus = 'T' and EecTermReason = '200' THEN 'LAYOFF'
                                                   WHEN EecEmplStatus = 'T' and EecTermReason NOT IN ('203','200') THEN 'TERM'
                                                   WHEN EecEmplStatus = 'A' and BdmCobraReason IN ('204','LEVNT4') THEN 'DIVORCE'
                                                   WHEN EecEmplStatus = 'A' and BdmCobraReason IN ('201','LEVNT3') THEN 'CEASE-A'
                                                   WHEN EecEmplStatus = 'A' and BdmCobraReason IN ('205') THEN 'MEDICARE'
                                                   WHEN EecEmplStatus = 'A' and BdmCobraReason IN ('203') THEN 'REDUCE'
                                                   WHEN BdmCobraReason IN ('207') THEN 'MILITARY'
                                                   ELSE 'TERM'

                                            END 
                                                 
                                END
                        
        ,drvDisabled = CASE WHEN BdmRecType = 'EMP' and eepIsDisabled = 'Y' THEN 'Yes' 
                            WHEN BdmRecType = 'EMP' and eepIsDisabled = 'N' THEN  'No'
                            WHEN BdmRecType = 'DEP' and ConIsDisabled = 'Y' THEN 'Yes' 
                            WHEN BdmRecType = 'DEP' and ConIsDisabled = 'N' THEN 'No' 
                         END  --If eepIsDisabled or ConIsDisabled = Y, send Yes, else send NO
        ,drvGender = EepGender
        ,drvSeveranceFlag = ''
        ,drvSevStartDate = ''
        ,drvSevEndDate = ''
        ,drvMedIndicator = ''
        ,drvMedicareDate = ''
    INTO dbo.U_EPNGCOBRAX_drvCov
    FROM dbo.U_EPNGCOBRAX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPNGCOBRAX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCOID = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
    --WHERE BdmRunID = 'QB'
    ;
    ---------------------------------
    -- DETAIL RECORD - U_EPNGCOBRAX_drvPcr
    ---------------------------------
    IF OBJECT_ID('U_EPNGCOBRAX_drvPcr','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_drvPcr;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = ConSystemID --DELETE IF NOT USING DEPENDENT DATA
        ,drvSSN = eepSSN
        ,drvInitialSort = eepSSN
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvPcrRecordType = 'PCR'
        ,drvPcrEmpSSN = SUBSTRING(eepssn, 1, 3)+'-'+ SUBSTRING(eepssn, 4, 2)+'-'+ SUBSTRING(eepssn, 3, 4)
        ,drvPcrEmpId = eecEmpNo
        ,drvPcrBenificiaryId = ''
        ,drvPcrEmpAssociationId = ''
        ,drvPCRDependentSSN = CASE WHEN BdmRecType = 'DEP' THEN SUBSTRING(ConSSN, 1, 3)+'-'+ SUBSTRING(ConSSN, 4, 2)+'-'+ SUBSTRING(ConSSN, 3, 4)  ELSE SUBSTRING(eepssn, 1, 3)+'-'+ SUBSTRING(eepssn, 4, 2)+'-'+ SUBSTRING(eepssn, 3, 4) END 
        ,drvPCRCarrier = Case 
                             WHEN BdmRunId = 'NPM' THEN 'INITIAL'
                             when BdmDedCode in ('95') THEN 'VSP'
                             when BdmDedCode in ('205', '206', '207') THEN 'UHC'
                             when BdmDedCode in ('201', '202', '203') THEN 'UHC'
                             when BdmDedCode in ('220') THEN 'P&A'
                             when BdmDedCode in ('280') THEN 'DELTA'
                            
                         END
        ,drvPCRCategory = Case 
                              WHEN BdmRunId = 'NPM' THEN 'INITIAL'
                             when BdmDedCode in ('95') THEN 'VISION'
                             when BdmDedCode in ('205', '206', '207') THEN 'HEALTH'
                             when BdmDedCode in ('201', '202', '203') THEN 'HEALTH'
                             when BdmDedCode in ('220') THEN 'FSA'
                             when BdmDedCode in ('280') THEN 'DENTAL'
                             
                         END
        ,drvPCRPlanName =  Case when BdmDedCode in ('95') THEN 'VOLUNTARY'
                             when BdmDedCode in ('205', '206', '207') THEN 'PPO'
                             when BdmDedCode in ('201', '202', '203') THEN 'HDHP'
                             when BdmDedCode in ('220') THEN 'FSA'
                             when BdmDedCode in ('280') THEN 'PPO'
                             WHEN BdmRunId = 'NPM' THEN 'INITIAL'
                         END
        ,drvPCRPlanType = Case 
                             WHEN BdmRunId = 'NPM' THEN 'INITIAL'
                             when BdmDedCode in ('95') THEN 'VISION'
                             when BdmDedCode in ('205', '206', '207') THEN 'MEDICAL'
                             when BdmDedCode in ('201', '202', '203') THEN 'HSA'
                             when BdmDedCode in ('220') THEN ''
                             when BdmDedCode in ('280') THEN 'DENTAL'
                            
                         END
        ,drvPCRGroupNumber = ''
        ,drvPCRSubGroupNumber = ''
        ,drvPCRBranchGroupNumber = ''
        ,drvPCRTierLevel = CASE WHEN bdmBenOption = 'EE' THEN 'SINGLE'
                                WHEN bdmBenOption IN('EES','EEDP') THEN 'EE+SP'
                                WHEN bdmBenOption IN('EEC') THEN 'EE+CH'
                                WHEN bdmBenOption IN('EEF','EEDPF') THEN 'FAMILY'
                           END
        ,drvPCRPCT = ''
        ,drvPCRPAIAmount = ''
        ,drvPCRELFAmount = ''
        ,drvPCRCovCeaseDate = BdmBenStopDate
        ,drvPCRLifeEventDate = BdmDateOfCOBRAEvent
        ,drvPCRCoverageEffectiveDate = DATEADD(day,1,BdmBenStopDate)
        ,drvPCRHRAElectionAmt = CASE WHEN (SELECT top 1 pgrPayFrequency FROM pAYgROUP WHERE pgrPayGroup = eecPayGroup) = 'S' and bdmdedcode = '220' THEN (bdmEEAMT * 2) 
                                     WHEN (SELECT top 1 pgrPayFrequency FROM pAYgROUP WHERE pgrPayGroup = eecPayGroup)  = 'W' and bdmdedcode = '220' THEN ((bdmEEAMT * 52) /12) 
                                END
        ,drvPCRPayrollDedAmt = CASE WHEN (SELECT top 1 pgrPayFrequency FROM pAYgROUP WHERE pgrPayGroup = eecPayGroup) = 'S' and bdmdedcode = '220' THEN (bdmEEAMT *2) 
                                     WHEN (SELECT top 1 pgrPayFrequency FROM pAYgROUP WHERE pgrPayGroup = eecPayGroup) = 'W' and bdmdedcode = '220' THEN ((bdmEEAMT * 52) /12) 
                                END
        ,drvPCRFiller = ''
        ,drvPCRHRAYTDClaims = CASE WHEN bdmDedCode in ('220') Then  bdmEEGoalAmt END
    INTO dbo.U_EPNGCOBRAX_drvPcr
    FROM dbo.U_EPNGCOBRAX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPNGCOBRAX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCOID = xCoID
        AND BdmRunID  = 'QB'
    
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
            ON ConEEID = BdmEEID
           AND ConSystemID = BdmDepRecID
    
    ;

    
    --Record for NPM
    INSERT  INTO dbo.U_EPNGCOBRAX_drvPcr
     SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        ,drvSSN = eepSSN
        ,drvInitialSort = eepSSN
        ,drvSubSort = '4'
        -- standard fields above and additional driver fields below
        ,drvPcrRecordType = 'PCR'
        ,drvPcrEmpSSN = SUBSTRING(eepssn, 1, 3)+'-'+ SUBSTRING(eepssn, 4, 2)+'-'+ SUBSTRING(eepssn, 3, 4)
        ,drvPcrEmpId = eecEmpNo
        ,drvPcrBenificiaryId = ''
        ,drvPcrEmpAssociationId = ''
        ,drvPCRDependentSSN =  SUBSTRING(eepssn, 1, 3)+'-'+ SUBSTRING(eepssn, 4, 2)+'-'+ SUBSTRING(eepssn, 3, 4) 
        ,drvPCRCarrier = 'INITIAL'
        ,drvPCRCategory = 'INITIAL'
        ,drvPCRPlanName =  'INITIAL'
        ,drvPCRPlanType = 'INITIAL'
        ,drvPCRGroupNumber = ''
        ,drvPCRSubGroupNumber = ''
        ,drvPCRBranchGroupNumber = ''
        ,drvPCRTierLevel = CASE WHEN bdmBenOption = 'EE' THEN 'SINGLE'
                                WHEN bdmBenOption IN('EES','EEDP') THEN 'EE+SP'
                                WHEN bdmBenOption IN('EEC') THEN 'EE+CH'
                                WHEN bdmBenOption IN('EEF','EEDPF') THEN 'FAMILY'
                           END
        ,drvPCRPCT = ''
        ,drvPCRPAIAmount = ''
        ,drvPCRELFAmount = ''
        ,drvPCRCovCeaseDate = BdmBenStopDate
        ,drvPCRLifeEventDate = eecdateoflasthire
        ,drvPCRCoverageEffectiveDate = CASE WHEN BdmRunID = 'NPM' THEN 
                                CASE WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT1') and EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN cast( (cast(month(dateadd(mm,1,eecdateoflasthire))  as varchar(2)) +  '/01/' +  cast( year(dateadd(mm,1,eecdateoflasthire)) as varchar(40))) as datetime)
                                            WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT4') and  EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN DATEADD(day,1,BdmBenStopDate) 
                                            WHEN EXISTS( select * from EmpHDed where EdhEEID =xEEID and edhcoid = xCOID and EdhChangeReason in ('LEVNT2') and  EdhDedCode in (select dedcode from U_EPNGCOBRAX_DedList) ) THEN DATEADD(day,1,BdmBenStopDate) 
                                            ELSE cast( (cast(month(dateadd(mm,1,eecdateoflasthire))  as varchar(2)) +  '/01/' +  cast( year(dateadd(mm,1,eecdateoflasthire)) as varchar(40))) as datetime)
                                        END
                            END
                       

        ,drvPCRHRAElectionAmt = ''
        ,drvPCRPayrollDedAmt = ''
        ,drvPCRFiller = ''
        ,drvPCRHRAYTDClaims = ''
    FROM dbo.U_EPNGCOBRAX_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
     JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EPNGCOBRAX WITH (NOLOCK)
        ON BdmEEID = xEEID 
        AND BdmCOID = xCoID
        AND BdmRunID  = 'NPM'
    ;


    

--Delete from U_EPNGCOBRAX_drvPcr where drveeid in (select distinct drveeid from U_EPNGCOBRAX_drvCov where drvEventReasonCode  in ('DIVORCE','CEASE-A') and drvDepRecid is null) and drvdeprecid is null
--Delete from U_EPNGCOBRAX_drvCov where drvEventReasonCode  in ('DIVORCE','CEASE-A') and drvDepRecid is null
    
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPNGCOBRAX_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_Header;
    SELECT DISTINCT
         drvRecordTypeHeader = 'HDR'
        ,drvFileDate = GETDATE()
        ,drvOriginator = 'UniCarriers'
        ,drvOriginatorEmail = 'HQuebbeman@unicarriersamericas.com'
    INTO dbo.U_EPNGCOBRAX_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EPNGCOBRAX_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EPNGCOBRAX_drvTrailer;
    SELECT DISTINCT
         drvTrailerRecordType = 'TLR'
        ,drvNumberofRecordsInFile = CAST( ( (Select count(*) from dbo.U_EPNGCOBRAX_drvPcr) +   (Select count(*) from dbo.U_EPNGCOBRAX_drvCov ) +  (Select count(*) from dbo.U_EPNGCOBRAX_drvEmp ) ) as varchar(10))
    INTO dbo.U_EPNGCOBRAX_drvTrailer
   
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
ALTER VIEW dbo.dsi_vwEPNGCOBRAX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPNGCOBRAX_File (NOLOCK)
    ORDER by  InitialSort,SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EPNGCOBRAX%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910311'
       ,expStartPerControl     = '201910311'
       ,expLastEndPerControl   = '201911079'
       ,expEndPerControl       = '201911079'
WHERE expFormatCode = 'EPNGCOBRAX';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEPNGCOBRAX_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EPNGCOBRAX_File (NOLOCK)
    ORDER by  InitialSort,SubSort;