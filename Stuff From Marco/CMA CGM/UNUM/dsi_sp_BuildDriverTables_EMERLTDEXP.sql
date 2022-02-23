SET NOCOUNT ON;
IF OBJECT_ID('U_EMERLTDEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EMERLTDEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EMERLTDEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEMERLTDEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEMERLTDEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EMERLTDEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMERLTDEXP];
GO
IF OBJECT_ID('U_EMERLTDEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_PEarHist];
GO
IF OBJECT_ID('U_EMERLTDEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_PDedHist];
GO
IF OBJECT_ID('U_EMERLTDEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_File];
GO
IF OBJECT_ID('U_EMERLTDEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_EEList];
GO
IF OBJECT_ID('U_EMERLTDEXP_drvTblTrailer') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_drvTblTrailer];
GO
IF OBJECT_ID('U_EMERLTDEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_drvTbl];
GO
IF OBJECT_ID('U_EMERLTDEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_DedList];
GO
IF OBJECT_ID('U_EMERLTDEXP_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_AuditFields];
GO
IF OBJECT_ID('U_EMERLTDEXP_Audit') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_Audit];
GO
IF OBJECT_ID('U_dsi_BDM_EMERLTDEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EMERLTDEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EMERLTDEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EMERLTDEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EMERLTDEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EMERLTDEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EMERLTDEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EMERLTDEXP','Mercer Pension Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EMERLTDEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Social Security Number"','1','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Employee ID"','2','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','52',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"First Name"','3','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','103',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Middle Name"','4','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','154',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Last Name"','5','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','205',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address1"','6','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','256',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address2"','7','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','307',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"City"','8','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','358',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"State"','9','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','409',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Zip"','10','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','460',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Country"','11','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','511',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Gender"','12','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','562',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Date of Birth"','13','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','613',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Hire Date"','14','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','664',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Rehire Date"','15','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','715',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Disability Date"','16','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','766',NULL,'Disability Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Transfer Date"','17','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','817',NULL,'Transfer Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pension Status"','18','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','868',NULL,'Pension Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Pension Accrual End Date"','19','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','919',NULL,'Pension Accrual End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Reason Code"','20','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','970',NULL,'Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Union Code"','21','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1021',NULL,'Union Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FTE Status"','22','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1072',NULL,'FTE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Plan Year"','23','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1123',NULL,'Period Plan Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Period Plan Month"','24','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1174',NULL,'Period Plan Month',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Hours"','25','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1225',NULL,'Plan Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Earnings"','26','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1276',NULL,'Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Plan Earnings Effective Date"','27','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1327',NULL,'Plan Earnings Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Final Term Flag"','28','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1378',NULL,'Final Term Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Marital Status"','29','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1429',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Date of Birth"','30','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1480',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse First Name"','31','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1531',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Middle Name"','32','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1582',NULL,'Spouse Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Spouse Last Name"','33','(''DA''=''T|'')','EMERLTDEXPZ0','50','H','01','1633',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MEBA"','34','(''DA''=''T'')','EMERLTDEXPZ0','50','H','01','1633',NULL,'MEBA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1',NULL,'Social Security Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpId"','2','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','52',NULL,'Employee ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','3','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','103',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMiddle"','4','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','154',NULL,'Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','5','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','205',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine1"','6','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','256',NULL,'Address1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressLine2"','7','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','307',NULL,'Address2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCity"','8','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','358',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvState"','9','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','409',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZip"','10','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','460',NULL,'Zip',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','11','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','511',NULL,'Country',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','12','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','562',NULL,'Gender',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateofBirth"','13','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','613',NULL,'Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireDate"','14','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','664',NULL,'Hire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRehireDate"','15','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','715',NULL,'Rehire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilityDate"','16','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','766',NULL,'Disability Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTransferDate"','17','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','817',NULL,'Transfer Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPensionStatus"','18','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','868',NULL,'Pension Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPensionAccEndDate"','19','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','919',NULL,'Pension Accrual End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvReasonCode"','20','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','970',NULL,'Reason Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionCode"','21','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1021',NULL,'Union Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFTEStatus"','22','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1072',NULL,'FTE Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodPlanYear"','23','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1123',NULL,'Period Plan Year',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPeriodPlanMonth"','24','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1174',NULL,'Period Plan Month',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanHours"','25','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1225',NULL,'Plan Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEarnings"','26','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','1276',NULL,'Plan Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPlanEarningEffectiveDate"','27','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','1327',NULL,'Plan Earnings Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFinalTermFlag"','28','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1378',NULL,'Final Term Flag',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalStatus"','29','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1429',NULL,'Marital Status',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseDateOfBirth"','30','(''UD101''=''T|'')','EMERLTDEXPZ0','50','D','10','1480',NULL,'Spouse Date of Birth',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseFirstName"','31','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1531',NULL,'Spouse First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseMiddleName"','32','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1582',NULL,'Spouse Middle Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseLastName"','33','(''UA''=''T|'')','EMERLTDEXPZ0','50','D','10','1633',NULL,'Spouse Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEBA"','34','(''UA''=''T'')','EMERLTDEXPZ0','50','D','10','1633',NULL,'MEBA',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Counts of Active"','1','(''DA''=''T|'')','EMERLTDEXPZ0','50','T','90','1',NULL,'Counts of Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountsofActive"','2','(''UA''=''T'')','EMERLTDEXPZ0','50','T','90','50',NULL,'Counts of Active',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Counts of Terminated"','1','(''DA''=''T|'')','EMERLTDEXPZ0','50','T','91','1',NULL,'Counts of Terminated',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountsofTerminated"','2','(''UA''=''T'')','EMERLTDEXPZ0','50','T','91','50',NULL,'Counts of Terminated',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Counts of Deceased"','1','(''DA''=''T|'')','EMERLTDEXPZ0','50','T','92','1',NULL,'Counts of Deceased',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountsofDeceased"','2','(''UA''=''T'')','EMERLTDEXPZ0','50','T','92','50',NULL,'Counts of Deceased',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sum of Hours"','1','(''DA''=''T|'')','EMERLTDEXPZ0','50','T','93','1',NULL,'Sum of Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSumOfHours"','2','(''UA''=''T'')','EMERLTDEXPZ0','50','T','93','50',NULL,'Sum of Hours',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Sum of Earnings"','1','(''DA''=''T|'')','EMERLTDEXPZ0','50','T','94','1',NULL,'Sum of Earnings',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSumOfEarnings"','2','(''UA''=''T'')','EMERLTDEXPZ0','50','T','94','50',NULL,'Sum of Earnings',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERLTDEXP_20200528.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Merce Pension Export','201912319','EMPEXPORT','ONDEMAND',NULL,'EMERLTDEXP',NULL,NULL,NULL,'201912319','Dec 31 2019  5:03PM','Dec 31 2019  5:03PM','201912311',NULL,'','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERLTDEXP_20200528.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201912319','EMPEXPORT','OEPASSIVE',NULL,'EMERLTDEXP',NULL,NULL,NULL,'201912319','Dec 31 2019  5:03PM','Dec 31 2019  5:03PM','201912311',NULL,'','','201912311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERLTDEXP_20200528.txt',NULL,NULL,NULL,'MLWSW,Y0SOB,MLWA8',NULL,NULL,NULL,'Active Open Enrollment Export','202002059','EMPEXPORT','OEACTIVE','Feb 10 2020 12:00AM','EMERLTDEXP',NULL,NULL,NULL,'202002059','Feb  5 2020 12:00AM','Dec 30 1899 12:00AM','202001211',NULL,'','','202001211',dbo.fn_GetTimedKey(),NULL,'us3tKiCMA1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERLTDEXP_20200528.txt',NULL,'Null','N','MLMTS,MLWSW,Y0SOB,MLWA8',NULL,NULL,NULL,'Mercer Data File Monthly 15th','202002269','EMPEXPORT','SCH_MERS','Feb 26 2020  3:42PM','EMERLTDEXP',NULL,NULL,NULL,'202004309','Feb 26 2020 12:00AM','Dec 30 1899 12:00AM','202004011','1206','','','201912311',dbo.fn_GetTimedKey(),NULL,'us3mLaCMA1000',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EMERLTDEXP_20200528.txt',NULL,'','','MLMTS,MLWSW,Y0SOB,MLWA8',NULL,NULL,NULL,'Test Purposes Only','202003319','EMPEXPORT','TEST','Apr 21 2020 12:16PM','EMERLTDEXP',NULL,NULL,NULL,'202003319','Mar 31 2020 12:00AM','Dec 30 1899 12:00AM','202003011','805','','','202003011',dbo.fn_GetTimedKey(),NULL,'us3lKiCMA1000',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EMERLTDEXP_20200528.txt' END WHERE expFormatCode = 'EMERLTDEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EMERLTDEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EMERLTDEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EMERLTDEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EMERLTDEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EMERLTDEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','H01','NONE',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','D10','dbo.U_EMERLTDEXP_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T90','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T91','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T92','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T93','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EMERLTDEXP','T94','dbo.U_EMERLTDEXP_drvTblTrailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EMERLTDEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EMERLTDEXP] (
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
IF OBJECT_ID('U_EMERLTDEXP_Audit') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_Audit] (
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audKey1Value] varchar(255) NOT NULL,
    [audKey2Value] varchar(255) NOT NULL,
    [audKey3Value] varchar(255) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EMERLTDEXP_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_AuditFields] (
    [aTableName] varchar(128) NULL,
    [aFieldName] varchar(128) NULL
);
IF OBJECT_ID('U_EMERLTDEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EMERLTDEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvEmpId] char(9) NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameMiddle] varchar(1) NULL,
    [drvNameLast] varchar(101) NULL,
    [drvAddressLine1] varchar(255) NULL,
    [drvAddressLine2] varchar(255) NULL,
    [drvCity] varchar(255) NULL,
    [drvState] varchar(255) NULL,
    [drvZip] varchar(50) NULL,
    [drvCountry] char(3) NULL,
    [drvGender] char(1) NULL,
    [drvDateofBirth] datetime NULL,
    [drvHireDate] datetime NULL,
    [drvRehireDate] datetime NULL,
    [drvDisabilityDate] datetime NULL,
    [drvTransferDate] datetime NULL,
    [drvPensionStatus] varchar(1) NOT NULL,
    [drvPensionAccEndDate] datetime NULL,
    [drvReasonCode] varchar(25) NULL,
    [drvUnionCode] varchar(6) NULL,
    [drvFTEStatus] varchar(4) NOT NULL,
    [drvPeriodPlanYear] int NULL,
    [drvPeriodPlanMonth] int NULL,
    [drvPlanHours] varchar(12) NULL,
    [drvPlanHoursRaw] decimal NULL,
    [drvPlanEarnings] varchar(12) NULL,
    [drvPlanEarningsRaw] decimal NULL,
    [drvPlanEarningEffectiveDate] datetime NULL,
    [drvFinalTermFlag] varchar(1) NOT NULL,
    [drvMaritalStatus] varchar(1) NOT NULL,
    [drvSpouseDateOfBirth] datetime NULL,
    [drvSpouseFirstName] varchar(100) NULL,
    [drvSpouseMiddleName] varchar(50) NULL,
    [drvSpouseLastName] varchar(100) NULL,
    [drvMEBA] varchar(4) NULL,
    [drvInitialSort] char(11) NULL,
    [drvDateofLastHire] datetime NULL
);
IF OBJECT_ID('U_EMERLTDEXP_drvTblTrailer') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_drvTblTrailer] (
    [drvCountsofActive] varchar(12) NULL,
    [drvCountsofTerminated] varchar(12) NULL,
    [drvCountsofDeceased] varchar(12) NULL,
    [drvSumOfHours] varchar(15) NULL,
    [drvSumOfEarnings] varchar(15) NULL
);
IF OBJECT_ID('U_EMERLTDEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EMERLTDEXP_File') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
IF OBJECT_ID('U_EMERLTDEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_PDedHist] (
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
IF OBJECT_ID('U_EMERLTDEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EMERLTDEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EMERLTDEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: CMA CGM (America) LLC

Created By: Marco Lagrosa
Business Analyst: Trena King
Create Date: 12/31/2019
Service Request Number: SR-2019-00223916

Purpose: Merce Pension Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2019     SR-2019-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EMERLTDEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EMERLTDEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EMERLTDEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EMERLTDEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EMERLTDEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EMERLTDEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EMERLTDEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EMERLTDEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EMERLTDEXP';

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

    -- Cleans EE List of employee not in the following company.
    --APL America LLC - MLWSW
    --APL GUAM LTD -  Y0SOB
    --APL Maritime Limited - MLWA8
    --Delete from U_EMERLTDEXP_EEList where xcoid not in ('MLWSW','Y0SOB','MLWA8')


    DELETE FROM dbo.U_EMERLTDEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EMERLTDEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    Delete from dbo.U_EMERLTDEXP_EEList
    where xeeid in (Select eeceeid from empcomp where EecEEType = 'TES')


    Delete from dbo.U_EMERLTDEXP_EEList
    where xeeid in (    Select eeceeid from empcomp where eecempno in ('0003','2525','2717','0004','4228','2723','4929')
    )


    Delete from dbo.U_EMERLTDEXP_EEList
    where xeeid in (        Select distinct eeceeid from empcomp where EecJobCode  = 'APLDW01'
    )

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'LTD';

    IF OBJECT_ID('U_EMERLTDEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EMERLTDEXP_DedList
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
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsSpouse','SPS');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode,'RelationshipsDomPartner','DP');



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



    IF OBJECT_ID('U_EMERLTDEXP_AuditFields','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_AuditFields;
    CREATE TABLE dbo.U_EMERLTDEXP_AuditFields (aTableName varchar(128),aFieldName varchar(128));
    
    -- Insert tables/fields to be audited
    INSERT INTO dbo.U_EMERLTDEXP_AuditFields VALUES ('empcomp','eecemplstatus');    
    
    -- Create audit table
    IF OBJECT_ID('U_EMERLTDEXP_Audit','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_Audit;
    SELECT
         audTableName = adrTableName
        ,audFieldName = adfFieldName
        ,audKey1Value = ISNULL(adrKey1,'')
        ,audKey2Value = ISNULL(adrKey2,'')
        ,audKey3Value = ISNULL(adrKey3,'')
        ,audDateTime  = adrProcessedDateTime
        ,audOldValue  = adfOldData
        ,audNewValue  = adfNewData
        ,audRowNo     = ROW_NUMBER() OVER(PARTITION BY adrKey1, adrKey2, adrKey3, adfFieldName ORDER BY adrRecID DESC)
    INTO dbo.U_EMERLTDEXP_Audit
    FROM (SELECT *
          FROM dbo.AuditRecords WITH (NOLOCK)
          WHERE adrTableName IN (SELECT aTableName FROM dbo.U_EMERLTDEXP_AuditFields WITH (NOLOCK))) ADR
    JOIN (SELECT *
          FROM dbo.AuditFields WITH (NOLOCK)
          WHERE adfFieldName IN (SELECT aFieldName FROM dbo.U_EMERLTDEXP_AuditFields WITH (NOLOCK))) ADF
        ON adrSystemID = adfSystemID
       AND adrKey = adfKey
    WHERE adrType IN (1,2,5,6) -- Insert/Update; remove this to include Deletes and Viewed
      AND adrProcessedDateTime BETWEEN DateAdd(year,-2,@StartDate)  AND @EndDate;
    
    -- Create Index
    CREATE CLUSTERED INDEX CDX_U_EMERLTDEXP_Audit ON dbo.U_EMERLTDEXP_Audit (audKey1Value, audKey2Value);

    --==========================================
    -- Build Working Tables
    --==========================================

    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EMERLTDEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_PDedHist;
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
    INTO dbo.U_EMERLTDEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EMERLTDEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EMERLTDEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_PEarHist;
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
    INTO dbo.U_EMERLTDEXP_PEarHist
    FROM dbo.PayReg WITH (NOLOCK)
    JOIN dbo.PEarHist WITH (NOLOCK)
        ON PehGenNumber = PrgGenNumber
    JOIN dbo.EARNCODE WITH (NOLOCK)
        on ErnEarncode = PehEarnCode
    WHERE LEFT(PehPerControl,4) = LEFT(@EndPerControl,4)
    AND PehPerControl <= @EndPerControl
    AND erncalcrule = '01'
    GROUP BY PehEEID
    HAVING SUM(PehCurAmt) <> 0.00;
    --==========================================
    -- Build Driver Tables
    --==========================================
    ---------------------------------
    -- DETAIL RECORD - U_EMERLTDEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EMERLTDEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = ISNULL(eepSSN,EinNationalID)
        ,drvEmpId = eecEmpNo
        ,drvNameFirst = EepNameFirst
        ,drvNameMiddle = LEFT(EepNameMiddle,1)
        ,drvNameLast = Left(Isnull(eepnameLast,''),1) + Lower(SUBSTRING(eepnamelast, 2, len(eepnamelast)))
        ,drvAddressLine1 = EepAddressLine1
        ,drvAddressLine2 = EepAddressLine2
        ,drvCity = EepAddressCity
        ,drvState = EepAddressState
        ,drvZip = EepAddressZipCode
        ,drvCountry = EepAddressCountry
        ,drvGender = EepGender
        ,drvDateofBirth = EepDateOfBirth
        ,drvHireDate = EecDateOfOriginalHire
        ,drvRehireDate = CASE WHEN EecDateOfOriginalHire <>  EecDateOfLastHire THEN EecDateOfLastHire END 
        ,drvDisabilityDate = CASE WHEN EecEmplStatus = 'L' THEN EecEmplStatusStartDate END
        ,drvTransferDate = CASE WHEN EecJobChangeReason = 'TRI' THEN EecDateInJob  END
        ,drvPensionStatus = CASE WHEN EecEmplStatus = 'T' THEN
                                            CASE WHEN EecTermReason = '203' THEN 'D'
                                                 ELSE 'T'
                                            END
                                WHEN  EecEmplStatus = 'A' THEN 'A'
                                WHEN  EecEmplStatus = 'L' THEN 'L'
                                ELSE 'A'
                            END
        ,drvPensionAccEndDate = EecDateOfTermination
        ,drvReasonCode = (select top 1 tchDesc from TrmReasn where tchcode =  EecTermReason)
        ,drvUnionCode = CASE WHEN eecorglvl4 = 'U' THEN eecorglvl4 ELSE '' END
        ,drvFTEStatus = CASE WHEN EecFullTimeOrPartTime = 'F' THEN '1.00' ELSE '0.50' END
        ,drvPeriodPlanYear = YEAR(GETDATE())
        ,drvPeriodPlanMonth = MONTH(GETDATE())
        ,drvPlanHours = CAST(CONVERT(DECIMAL(10,2),PehCurHrsYTD) as varchar(12))
        ,drvPlanHoursRaw = CONVERT(DECIMAL(10,2),PehCurHrsYTD)
        ,drvPlanEarnings =  CAST(CONVERT(DECIMAL(10,2),EecAnnSalary) as varchar(12))
        ,drvPlanEarningsRaw = CONVERT(DECIMAL(10,2),EecAnnSalary)
        ,drvPlanEarningEffectiveDate = dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(xeeid, xcoid, GetDate(),EecDateOfLastHire)  
        ,drvFinalTermFlag = CASE WHEN (Select Max(prgpaydate) from PayReg where prgEEID = xeeid) > EecDateOfTermination THEN 'Y' ELSE 'N' END
        ,drvMaritalStatus = CASE WHEN eepMaritalStatus = 'M' THEN 'M' ELSE 'S' END 
        ,drvSpouseDateOfBirth =  CASE WHEN eepMaritalStatus = 'M' THEN (select top 1 condateofbirth from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvSpouseFirstName =   CASE WHEN eepMaritalStatus = 'M' THEN (select top 1 ConNameFirst from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvSpouseMiddleName =  CASE WHEN eepMaritalStatus = 'M' THEN  (select top 1 ConNameMiddle from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvSpouseLastName =   CASE WHEN eepMaritalStatus = 'M' THEN (select top 1 ConNameLast from contacts where ConEEID =  xeeid and conrelationship in ('SPS') ) END
        ,drvMEBA = CASE WHEN CHARINDEX('MEBA',(select top 1 UniLongDesc from dbo.LabUnion where UniCode = EecUnionLocal)) > 0 THEN 'MEBA' END    
        ,drvInitialSort = eepSSN
        ,drvDateofLastHire = EecDateOfLastHire
    INTO dbo.U_EMERLTDEXP_drvTbl
    FROM dbo.U_EMERLTDEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
        and (eecemplstatus <> 'T' OR (eecemplstatus= 'T' and eectermreason <>'TRO' 
                                      and EXISTS(select 1 from dbo.U_EMERLTDEXP_Audit where  audKey1Value = xEEID AND audKey2Value = xcoid and audfieldname = 'eecemplstatus' and audNewValue = 'T')))
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    LEFT JOIN dbo.U_EMERLTDEXP_PEarHist WITH (NOLOCK)
        ON PehEEID = XEEID

    LEFT JOIN dbo.EmpIntl WITH (NOLOCK)
        on eineeid = xeeid;

    
    Delete from U_EMERLTDEXP_drvTbl
    where drvDateofLastHire >=  CAST( EOMONTH(dateadd( month, -1, (@StartDate))) as datetime)



    Update U_EMERLTDEXP_drvTbl set drvMaritalStatus = '' where drvMaritalStatus is null or drvMaritalStatus in ('','Z')  
    Delete from U_EMERLTDEXP_drvTbl where YEAR(drvPensionAccEndDate) <= YEAR(DATEADD(YY, - 2, @EndDate)) 

     IF OBJECT_ID('U_EMERLTDEXP_drvTblTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EMERLTDEXP_drvTblTrailer;
    SELECT DISTINCT
            drvCountsofActive = CAST((Select count(*) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)  WHERE drvPensionStatus IN('A','L')) as varchar(12))
            ,drvCountsofTerminated = CAST((Select count(*) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)  WHERE drvPensionStatus = 'T' ) as varchar(12))
            ,drvCountsofDeceased = CAST((Select count(*) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)  WHERE drvPensionStatus = 'D' ) as varchar(12))
            ,drvSumOfHours = CAST(CONVERT(DECIMAL(13,2),(Select Sum(drvPlanHoursRaw) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK)))as varchar(15))
            ,drvSumOfEarnings = CAST(CONVERT(DECIMAL(13,2),(Select Sum(drvPlanEarningsRaw) from dbo.U_EMERLTDEXP_drvTbl  WITH (NOLOCK))) as varchar(15))
    INTO dbo.U_EMERLTDEXP_drvTblTrailer

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
ALTER VIEW dbo.dsi_vwEMERLTDEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EMERLTDEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EMERLTDEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201912241'
       ,expStartPerControl     = '201912241'
       ,expLastEndPerControl   = '201912319'
       ,expEndPerControl       = '201912319'
WHERE expFormatCode = 'EMERLTDEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEMERLTDEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EMERLTDEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort