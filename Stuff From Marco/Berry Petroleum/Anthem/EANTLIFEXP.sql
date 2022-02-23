SET NOCOUNT ON;
IF OBJECT_ID('U_EANTLIFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EANTLIFEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EANTLIFEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEANTLIFEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEANTLIFEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EANTLIFEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTLIFEXP];
GO
IF OBJECT_ID('U_U_EANTLIFEXP_BdmConsolidated') IS NOT NULL DROP TABLE [dbo].[U_U_EANTLIFEXP_BdmConsolidated];
GO
IF OBJECT_ID('U_EANTLIFEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_PEarHist];
GO
IF OBJECT_ID('U_EANTLIFEXP_PDedHist') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_PDedHist];
GO
IF OBJECT_ID('U_EANTLIFEXP_Header') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_Header];
GO
IF OBJECT_ID('U_EANTLIFEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_File];
GO
IF OBJECT_ID('U_EANTLIFEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_EEList];
GO
IF OBJECT_ID('U_EANTLIFEXP_drvTrailer') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_drvTrailer];
GO
IF OBJECT_ID('U_EANTLIFEXP_drvSpecialty') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_drvSpecialty];
GO
IF OBJECT_ID('U_EANTLIFEXP_drvMember') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_drvMember];
GO
IF OBJECT_ID('U_EANTLIFEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_DedList];
GO
IF OBJECT_ID('U_dsi_BDM_EANTLIFEXP_VOL') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EANTLIFEXP_VOL];
GO
IF OBJECT_ID('U_dsi_BDM_EANTLIFEXP') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EANTLIFEXP];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EANTLIFEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EANTLIFEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EANTLIFEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EANTLIFEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EANTLIFEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','SDF','EANTLIFEXP','Anthem VOL Plans Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','1000','S','N','EANTLIFEXPZ0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDRFiller1"','1','(''UA''=''F'')','EANTLIFEXPZ0','9','H','01','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDRCaseNumber"','2','(''UA''=''F'')','EANTLIFEXPZ0','10','H','01','10',NULL,'Case Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDRFiller2"','3','(''UA''=''F'')','EANTLIFEXPZ0','12','H','01','20',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDRRecType"','4','(''UA''=''F'')','EANTLIFEXPZ0','1','H','01','32',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDREffDate"','5','(''UD112''=''F'')','EANTLIFEXPZ0','8','H','01','33',NULL,'Header Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDRFileDate"','6','(''UD112''=''F'')','EANTLIFEXPZ0','8','H','01','41',NULL,'File Creation Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDRFileInd"','7','(''UA''=''F'')','EANTLIFEXPZ0','1','H','01','49',NULL,'Full File/Change Only Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHDRFiller3"','8','(''UA''=''F'')','EANTLIFEXPZ0','951','H','01','50',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSubsId"','1','(''UA''=''F'')','EANTLIFEXPZ0','9','D','10','1',NULL,'Subscriber ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemGrpNumber"','2','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','10',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemGrpNumSuffix"','3','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','20',NULL,'Group Number Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemActionCode"','4','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','30',NULL,'Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemRelIndicator"','5','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','31',NULL,'Relationship Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemRecType"','6','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','32',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemDOB"','7','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','33',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFname"','8','(''UA''=''F'')','EANTLIFEXPZ0','12','D','10','41',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMiddleName"','9','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','53',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemLastName"','10','(''UA''=''F'')','EANTLIFEXPZ0','16','D','10','54',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemGender"','11','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','70',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemRelCode"','12','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','71',NULL,'Relationship Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller1"','13','(''UA''=''F'')','EANTLIFEXPZ0','45','D','10','74',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCovEffDat"','14','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','119',NULL,'Coverage Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCovTermDate"','15','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','127',NULL,'Coverage Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemTermCode"','16','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','135',NULL,'Coverage Termination Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemDOH"','17','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','137',NULL,'Date of Hire',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMedQualInd"','18','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','145',NULL,'Medicare Qualifying Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemRehireDate"','19','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','147',NULL,'Retire Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller2"','20','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','155',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemRunInInd"','21','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','156',NULL,'Run-In Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller3"','22','(''UA''=''F'')','EANTLIFEXPZ0','19','D','10','157',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemLangInd"','23','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','176',NULL,'Language Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSSN"','24','(''UA''=''F'')','EANTLIFEXPZ0','9','D','10','177',NULL,'Member SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller4"','25','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','186',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemAddressLine1"','26','(''UA''=''F'')','EANTLIFEXPZ0','25','D','10','196',NULL,'Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCity"','27','(''UA''=''F'')','EANTLIFEXPZ0','13','D','10','221',NULL,'City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemState"','28','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','234',NULL,'State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemZipCode"','29','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','236',NULL,'Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemZipCodePlus4"','30','(''UA''=''F'')','EANTLIFEXPZ0','4','D','10','241',NULL,'Zip Code + 4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemZipCodePlus2"','31','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','245',NULL,'Zip Code + 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemAddressLine2"','32','(''UA''=''F'')','EANTLIFEXPZ0','24','D','10','247',NULL,'Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemPhoneNbr"','33','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','271',NULL,'Phone Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemPhoneNbrExt"','34','(''UA''=''F'')','EANTLIFEXPZ0','4','D','10','281',NULL,'Phone Number  Ext.',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCountryCode"','35','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','285',NULL,'Country Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemForeignPostalCode"','36','(''UA''=''F'')','EANTLIFEXPZ0','15','D','10','287',NULL,'Foreign Postal Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemNetworkTermRsn"','37','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','302',NULL,'Network Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemNetworkTermEffDate"','38','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','304',NULL,'Network Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemNetworkId"','39','(''UA''=''F'')','EANTLIFEXPZ0','8','D','10','312',NULL,'Network ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemIPAPCPPMG"','40','(''UA''=''F'')','EANTLIFEXPZ0','9','D','10','320',NULL,'IPA/PCP/PMG/PDO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemPMPTrmRsn"','41','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','329',NULL,'PMG Termination Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemProvEffDate"','42','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','331',NULL,'Provider Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemEffDateChange"','43','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','339',NULL,'Department/Employee Number Effective Date Change',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemExistPatInd"','44','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','347',NULL,'Existing Patient Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller5"','45','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','348',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemDeptNumber"','46','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','349',NULL,'Department Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemEmpNumber"','47','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','359',NULL,'Employee Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemDepTermDate"','48','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','369',NULL,'Department/Employee Number Termination Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemClaimCatNbr"','49','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','377',NULL,'Claim Category Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemClaimRept1"','50','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','380',NULL,'Claim Reporting Field 1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemClaimRept2"','51','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','385',NULL,'Claim Reporting Field 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemClaimRept3"','52','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','390',NULL,'Claim Reporting Field 3',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCrossRefSubsId"','53','(''UA''=''F'')','EANTLIFEXPZ0','11','D','10','395',NULL,'Cross Reference Subscriber ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCrossRefSubsType"','54','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','406',NULL,'Cross Reference Subscriber Tyep',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller6"','55','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','407',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCaseNumber"','56','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','410',NULL,'Case Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller7"','57','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','420',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller8"','58','(''UA''=''F'')','EANTLIFEXPZ0','7','D','10','423',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSalFreq"','59','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','430',NULL,'Salary Frequency',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSalary"','60','(''UA''=''F'')','EANTLIFEXPZ0','11','D','10','431',NULL,'Salary',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSalMulti"','61','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','442',NULL,'Salary Multiplier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSubsCvgAmt"','62','(''UA''=''F'')','EANTLIFEXPZ0','11','D','10','447',NULL,'Subscriber Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller9"','63','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','458',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller10"','64','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','459',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemClientDataField"','65','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','469',NULL,'Client Data Field',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller11"','66','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','479',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller12"','67','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','480',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemPreExIndic"','68','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','490',NULL,'Pre-existing Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemPreExEffDate"','69','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','491',NULL,'Pre-existing Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCoordBenefits"','70','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','499',NULL,'Coordination of Benefits',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemDisableInd"','71','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','500',NULL,'Disabled Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCobraInd"','72','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','501',NULL,'COBRA Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCobraBeginDate"','73','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','502',NULL,'COBRA Begin Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCobraEndDate"','74','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','510',NULL,'COBRA End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemCobraEventCode"','75','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','518',NULL,'COBRA Event Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMedIndPartA"','76','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','520',NULL,'Medicare Indicator Part A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMedIndPartADate"','77','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','521',NULL,'Medicare Effective Date Part A',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMedIndPartB"','78','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','529',NULL,'Medicare Indicator Part B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMedIndPartBDate"','79','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','530',NULL,'Medicare Effective Date Part B',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemHIBNbr"','80','(''UA''=''F'')','EANTLIFEXPZ0','12','D','10','538',NULL,'Medicare HIB Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemVIPInd"','81','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','550',NULL,'VIP Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemClaimFreeInd"','82','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','551',NULL,'Claims Free Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMedFlexSA"','83','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','552',NULL,'Medical Flex Spending Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemDepFlexSA"','84','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','553',NULL,'Dependent Flex Spending Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMedSVA"','85','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','554',NULL,'Medical Savings Account',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemDepIndType"','86','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','555',NULL,'Dependent Indicator Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemHealthCareID"','87','(''UA''=''F'')','EANTLIFEXPZ0','20','D','10','558',NULL,'Health Care Identification Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMailingAddress1"','88','(''UA''=''F'')','EANTLIFEXPZ0','25','D','10','578',NULL,'Mailing Street Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMailingCity"','89','(''UA''=''F'')','EANTLIFEXPZ0','13','D','10','603',NULL,'Mailing City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMailingState"','90','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','616',NULL,'Mailing State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMailingZip"','91','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','618',NULL,'Mailing Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMailingZipPlus4"','92','(''UA''=''F'')','EANTLIFEXPZ0','4','D','10','623',NULL,'Mailing Zip Code +4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMailingZip2"','93','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','627',NULL,'Mailing Zip Code  -2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemMailingAddress2"','94','(''UA''=''F'')','EANTLIFEXPZ0','24','D','10','629',NULL,'Mailing Street Address 2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller13"','95','(''UA''=''F'')','EANTLIFEXPZ0','62','D','10','653',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSpokenLang"','96','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','715',NULL,'Spoken Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemWritenLang"','97','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','718',NULL,'Written Language Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemRaceCode"','98','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','721',NULL,'Race Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemEthnicCode"','99','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','726',NULL,'Ethnicity Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemHeathFamMainType"','100','(''UA''=''F'')','EANTLIFEXPZ0','3','D','10','731',NULL,'Healthy Families Maintenance Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemHeathFamMainRsn"','101','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','734',NULL,'Healthy Families Maintencne Reason',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemNatID"','102','(''UA''=''F'')','EANTLIFEXPZ0','40','D','10','736',NULL,'National Provide Identifier',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEMProvCity"','103','(''UA''=''F'')','EANTLIFEXPZ0','30','D','10','776',NULL,'Provider City',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEMProvState"','104','(''UA''=''F'')','EANTLIFEXPZ0','2','D','10','806',NULL,'Provide State',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEMProvZip"','105','(''UA''=''F'')','EANTLIFEXPZ0','5','D','10','808',NULL,'Provider Zip Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEMProvZip4"','106','(''UA''=''F'')','EANTLIFEXPZ0','4','D','10','813',NULL,'Provider Zip Code+4',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEMProvEndDate"','107','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','10','817',NULL,'Provider End Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller14"','108','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','825',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemSubsEmailAdd"','109','(''UA''=''F'')','EANTLIFEXPZ0','106','D','10','835',NULL,'Subscriber E-mail Address',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEmNPITaxId"','110','(''UA''=''F'')','EANTLIFEXPZ0','10','D','10','941',NULL,'NPI Tax ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEMCovFamilyId"','111','(''UA''=''F'')','EANTLIFEXPZ0','15','D','10','951',NULL,'Covered Family ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMEMCovCompanionId"','112','(''UA''=''F'')','EANTLIFEXPZ0','20','D','10','966',NULL,'Covered Companion ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemPregInd"','113','(''UA''=''F'')','EANTLIFEXPZ0','1','D','10','986',NULL,'Pregnancy indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMemFiller15"','114','(''UA''=''F'')','EANTLIFEXPZ0','14','D','10','987',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPESubsID"','1','(''UA''=''F'')','EANTLIFEXPZ0','9','D','20','1',NULL,'Subscriber ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEGrpNbr"','2','(''UA''=''F'')','EANTLIFEXPZ0','10','D','20','10',NULL,'Group Number',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEGRPNbrSfx"','3','(''UA''=''F'')','EANTLIFEXPZ0','10','D','20','20',NULL,'Group Number Suffix',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEActionCd"','4','(''UA''=''F'')','EANTLIFEXPZ0','1','D','20','30',NULL,'Action Code',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPERelInd"','5','(''UA''=''F'')','EANTLIFEXPZ0','1','D','20','31',NULL,'Relationship Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPERecType"','6','(''UA''=''F'')','EANTLIFEXPZ0','1','D','20','32',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEDOB"','7','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','20','33',NULL,'Birth Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEFirstName"','8','(''UA''=''F'')','EANTLIFEXPZ0','12','D','20','41',NULL,'First Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEMiddleName"','9','(''UA''=''F'')','EANTLIFEXPZ0','1','D','20','53',NULL,'Middle Initial',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPELastName"','10','(''UA''=''F'')','EANTLIFEXPZ0','16','D','20','54',NULL,'Last Name',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEGender"','11','(''UA''=''F'')','EANTLIFEXPZ0','1','D','20','70',NULL,'Sex',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEBenChangeEffDate"','12','(''UD112''=''F'')','EANTLIFEXPZ0','8','D','20','71',NULL,'Benefit Change Effective Date',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPESalMultiSps"','13','(''UA''=''F'')','EANTLIFEXPZ0','5','D','20','79',NULL,'Salary Multiplier for Spouse',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPESPSCovAmt"','14','(''UA''=''F'')','EANTLIFEXPZ0','11','D','20','84',NULL,'Spouse Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEChlCovAmt"','15','(''UA''=''F'')','EANTLIFEXPZ0','11','D','20','95',NULL,'Child Coverage Amount',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEFiller1"','16','(''UA''=''F'')','EANTLIFEXPZ0','895','D','20','106',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSPEFiller2"','1','(''UA''=''F'')','EANTLIFEXPZ0','31','T','90','1',NULL,'Filler',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTRARecType"','2','(''UA''=''F'')','EANTLIFEXPZ0','1','T','90','32',NULL,'Record Type',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTRARecCount"','3','(''UA''=''F'')','EANTLIFEXPZ0','7','T','90','33',NULL,'Record Count',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTRAFiller1"','4','(''UA''=''F'')','EANTLIFEXPZ0','961','T','90','40',NULL,'Filler',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EANTLIFEXP_20200629.txt',NULL,'','',NULL,NULL,NULL,NULL,'Anthem VOL Plans Export','202003129','EMPEXPORT','ONDEMAND',NULL,'EANTLIFEXP',NULL,NULL,NULL,'202003129','Mar 12 2020  3:24PM','Mar 12 2020  3:24PM','202003121',NULL,'','','202003121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EANTLIFEXP_20200629.txt',NULL,'','','',NULL,NULL,NULL,'Scheduled Session','202003129','EMPEXPORT','SCH_ANTXP','Mar 16 2020  4:47PM','EANTLIFEXP',NULL,NULL,NULL,'202003129','Mar 12 2020  3:24PM','Mar 12 2020  3:24PM','202003121','8362','','','202003121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EANTLIFEXP_20200629.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','202003129','EMPEXPORT','OEACTIVE',NULL,'EANTLIFEXP',NULL,NULL,NULL,'202003129','Mar 12 2020  3:24PM','Mar 12 2020  3:24PM','202003121',NULL,'','','202003121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EANTLIFEXP_20200629.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','202003129','EMPEXPORT','OEPASSIVE',NULL,'EANTLIFEXP',NULL,NULL,NULL,'202003129','Mar 12 2020  3:24PM','Mar 12 2020  3:24PM','202003121',NULL,'','','202003121',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EANTLIFEXP_20200629.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202006269','EMPEXPORT','TEST','Jun 29 2020  1:07PM','EANTLIFEXP',NULL,NULL,NULL,'202006269','Jun 26 2020 12:00AM','Dec 30 1899 12:00AM','202001221','3756','','','202001221',dbo.fn_GetTimedKey(),NULL,'us3mLaBER1020',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EANTLIFEXP_20200629.txt' END WHERE expFormatCode = 'EANTLIFEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','InitialSort','C','drvInitialSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','SubSort','C','drvSubSort');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','SubSort2','C','drvSubSort2');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','SubSort3','C','drvSubSort3');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EANTLIFEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EANTLIFEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EANTLIFEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EANTLIFEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EANTLIFEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTLIFEXP','H01','dbo.U_EANTLIFEXP_Header',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTLIFEXP','D10','dbo.U_EANTLIFEXP_drvMember',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTLIFEXP','D20','dbo.U_EANTLIFEXP_drvSpecialty',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EANTLIFEXP','T90','dbo.U_EANTLIFEXP_drvTrailer',NULL);
IF OBJECT_ID('U_dsi_BDM_EANTLIFEXP') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EANTLIFEXP] (
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
IF OBJECT_ID('U_dsi_BDM_EANTLIFEXP_VOL') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EANTLIFEXP_VOL] (
    [bdmeeid] char(12) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmdeprecid] char(12) NULL,
    [bdmrectype] varchar(3) NOT NULL,
    [bdmdedcode] char(5) NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmbenstartdate] datetime NULL,
    [VCL] varchar(1) NOT NULL,
    [VSL] varchar(1) NOT NULL,
    [VCLAMT] varchar(13) NULL,
    [VSLAMT] varchar(13) NULL
);
IF OBJECT_ID('U_EANTLIFEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EANTLIFEXP_drvMember') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_drvMember] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvSubSort2] varchar(10) NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvMemSubsId] char(11) NULL,
    [drvMemGrpNumber] varchar(10) NULL,
    [drvMemGrpNumSuffix] varchar(1) NOT NULL,
    [drvMemActionCode] varchar(1) NOT NULL,
    [drvMemRelIndicator] varchar(1) NULL,
    [drvMemRecType] varchar(1) NOT NULL,
    [drvMemDOB] datetime NULL,
    [drvMemFname] varchar(6000) NULL,
    [drvMemMiddleName] varchar(6000) NULL,
    [drvMemLastName] varchar(6000) NULL,
    [drvMemGender] varchar(6000) NULL,
    [drvMemRelCode] varchar(6000) NULL,
    [drvMemFiller1] varchar(1) NOT NULL,
    [drvMemCovEffDat] datetime NULL,
    [drvMemCovTermDate] datetime NULL,
    [drvMemTermCode] varchar(1) NOT NULL,
    [drvMemDOH] varchar(1) NOT NULL,
    [drvMemMedQualInd] varchar(1) NOT NULL,
    [drvMemRehireDate] datetime NULL,
    [drvMemFiller2] varchar(1) NOT NULL,
    [drvMemRunInInd] varchar(1) NOT NULL,
    [drvMemFiller3] varchar(1) NOT NULL,
    [drvMemLangInd] varchar(1) NOT NULL,
    [drvMemSSN] char(11) NULL,
    [drvMemFiller4] varchar(1) NOT NULL,
    [drvMemAddressLine1] varchar(6000) NULL,
    [drvMemCity] varchar(6000) NULL,
    [drvMemState] varchar(6000) NULL,
    [drvMemZipCode] varchar(5) NULL,
    [drvMemZipCodePlus4] varchar(1) NOT NULL,
    [drvMemZipCodePlus2] varchar(1) NOT NULL,
    [drvMemAddressLine2] varchar(6000) NULL,
    [drvMemPhoneNbr] varchar(1) NOT NULL,
    [drvMemPhoneNbrExt] varchar(1) NOT NULL,
    [drvMemCountryCode] varchar(1) NOT NULL,
    [drvMemForeignPostalCode] varchar(1) NOT NULL,
    [drvMemNetworkTermRsn] varchar(1) NOT NULL,
    [drvMemNetworkTermEffDate] varchar(1) NOT NULL,
    [drvMemNetworkId] varchar(1) NOT NULL,
    [drvMemIPAPCPPMG] varchar(1) NOT NULL,
    [drvMemPMPTrmRsn] varchar(1) NOT NULL,
    [drvMemProvEffDate] varchar(1) NOT NULL,
    [drvMemEffDateChange] varchar(1) NOT NULL,
    [drvMemExistPatInd] varchar(1) NOT NULL,
    [drvMemFiller5] varchar(1) NOT NULL,
    [drvMemDeptNumber] char(6) NULL,
    [drvMemEmpNumber] varchar(1) NOT NULL,
    [drvMemDepTermDate] varchar(1) NOT NULL,
    [drvMemClaimCatNbr] varchar(1) NOT NULL,
    [drvMemClaimRept1] varchar(1) NOT NULL,
    [drvMemClaimRept2] varchar(1) NOT NULL,
    [drvMemClaimRept3] varchar(1) NOT NULL,
    [drvMemCrossRefSubsId] varchar(1) NOT NULL,
    [drvMemCrossRefSubsType] varchar(1) NOT NULL,
    [drvMemFiller6] varchar(1) NOT NULL,
    [drvMemCaseNumber] varchar(6) NOT NULL,
    [drvMemFiller7] varchar(1) NOT NULL,
    [drvMemFiller8] varchar(1) NOT NULL,
    [drvMemSalFreq] varchar(1) NULL,
    [drvMemSalary] varchar(30) NULL,
    [drvMemSalMulti] varchar(30) NULL,
    [drvMemSubsCvgAmt] varchar(1) NOT NULL,
    [drvMemSubsCvgAmtRaw] varchar(256) NULL,
    [drvMemFiller9] varchar(1) NOT NULL,
    [drvMemFiller10] varchar(1) NOT NULL,
    [drvMemClientDataField] varchar(1) NOT NULL,
    [drvMemFiller11] varchar(1) NOT NULL,
    [drvMemFiller12] varchar(1) NOT NULL,
    [drvMemPreExIndic] varchar(1) NOT NULL,
    [drvMemPreExEffDate] varchar(1) NOT NULL,
    [drvMemCoordBenefits] varchar(1) NOT NULL,
    [drvMemDisableInd] varchar(1) NOT NULL,
    [drvMemCobraInd] varchar(1) NOT NULL,
    [drvMemCobraBeginDate] varchar(1) NOT NULL,
    [drvMemCobraEndDate] varchar(1) NOT NULL,
    [drvMemCobraEventCode] varchar(1) NOT NULL,
    [drvMemMedIndPartA] varchar(1) NOT NULL,
    [drvMemMedIndPartADate] varchar(1) NOT NULL,
    [drvMemMedIndPartB] varchar(1) NOT NULL,
    [drvMemMedIndPartBDate] varchar(1) NOT NULL,
    [drvMemHIBNbr] varchar(1) NOT NULL,
    [drvMemVIPInd] varchar(1) NOT NULL,
    [drvMemClaimFreeInd] varchar(1) NOT NULL,
    [drvMemMedFlexSA] varchar(1) NOT NULL,
    [drvMemDepFlexSA] varchar(1) NOT NULL,
    [drvMemMedSVA] varchar(1) NOT NULL,
    [drvMemDepIndType] varchar(1) NOT NULL,
    [drvMemHealthCareID] varchar(1) NOT NULL,
    [drvMemMailingAddress1] varchar(1) NOT NULL,
    [drvMemMailingCity] varchar(1) NOT NULL,
    [drvMemMailingState] varchar(1) NOT NULL,
    [drvMemMailingZip] varchar(1) NOT NULL,
    [drvMemMailingZipPlus4] varchar(1) NOT NULL,
    [drvMemMailingZip2] varchar(1) NOT NULL,
    [drvMemMailingAddress2] varchar(1) NOT NULL,
    [drvMemFiller13] varchar(1) NOT NULL,
    [drvMemSpokenLang] varchar(1) NOT NULL,
    [drvMemWritenLang] varchar(1) NOT NULL,
    [drvMemRaceCode] varchar(1) NOT NULL,
    [drvMemEthnicCode] varchar(1) NOT NULL,
    [drvMemHeathFamMainType] varchar(1) NOT NULL,
    [drvMemHeathFamMainRsn] varchar(1) NOT NULL,
    [drvMemNatID] varchar(1) NOT NULL,
    [drvMEMProvCity] varchar(1) NOT NULL,
    [drvMEMProvState] varchar(1) NOT NULL,
    [drvMEMProvZip] varchar(1) NOT NULL,
    [drvMEMProvZip4] varchar(1) NOT NULL,
    [drvMEMProvEndDate] varchar(1) NOT NULL,
    [drvMemFiller14] varchar(1) NOT NULL,
    [drvMemSubsEmailAdd] varchar(1) NOT NULL,
    [drvMEmNPITaxId] varchar(1) NOT NULL,
    [drvMEMCovFamilyId] varchar(1) NOT NULL,
    [drvMEMCovCompanionId] varchar(1) NOT NULL,
    [drvMemPregInd] varchar(1) NOT NULL,
    [drvMemFiller15] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTLIFEXP_drvSpecialty') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_drvSpecialty] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] char(12) NULL,
    [drvInitialSort] varchar(12) NULL,
    [drvSubSort] char(12) NULL,
    [drvSubSort2] varchar(10) NULL,
    [drvSubSort3] varchar(1) NOT NULL,
    [drvSPESubsID] char(11) NULL,
    [drvSPEGrpNbr] varchar(10) NULL,
    [drvSPEGRPNbrSfx] varchar(1) NOT NULL,
    [drvSPEActionCd] varchar(1) NOT NULL,
    [drvSPERelInd] varchar(1) NULL,
    [drvSPERecType] varchar(1) NOT NULL,
    [drvSPEDOB] datetime NULL,
    [drvSPEFirstName] varchar(6000) NULL,
    [drvSPEMiddleName] varchar(6000) NULL,
    [drvSPELastName] varchar(6000) NULL,
    [drvSPEGender] varchar(6000) NULL,
    [drvSPEBenChangeEffDate] datetime NULL,
    [drvSPESalMultiSps] varchar(1) NOT NULL,
    [drvSPESPSCovAmt] varchar(30) NULL,
    [drvSPEChlCovAmt] varchar(30) NULL,
    [drvSPEFiller1] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTLIFEXP_drvTrailer') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_drvTrailer] (
    [drvSPEFiller2] varchar(1) NOT NULL,
    [drvTRARecType] varchar(1) NOT NULL,
    [drvTRARecCount] varchar(7) NULL,
    [drvTRAFiller1] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTLIFEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EANTLIFEXP_File') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(1000) NULL
);
IF OBJECT_ID('U_EANTLIFEXP_Header') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_Header] (
    [drvHDRFiller1] varchar(1) NOT NULL,
    [drvHDRCaseNumber] varchar(6) NOT NULL,
    [drvHDRFiller2] varchar(1) NOT NULL,
    [drvHDRRecType] varchar(1) NOT NULL,
    [drvHDREffDate] datetime NOT NULL,
    [drvHDRFileDate] datetime NOT NULL,
    [drvHDRFileInd] varchar(1) NOT NULL,
    [drvHDRFiller3] varchar(1) NOT NULL
);
IF OBJECT_ID('U_EANTLIFEXP_PDedHist') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_PDedHist] (
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
IF OBJECT_ID('U_EANTLIFEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EANTLIFEXP_PEarHist] (
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
IF OBJECT_ID('U_U_EANTLIFEXP_BdmConsolidated') IS NULL
CREATE TABLE [dbo].[U_U_EANTLIFEXP_BdmConsolidated] (
    [bdmrectype] varchar(3) NOT NULL,
    [bdmcoid] char(5) NULL,
    [bdmeeid] char(12) NOT NULL,
    [bdmdeprecid] char(12) NULL,
    [bdmrelationship] char(3) NULL,
    [bdmdedcode] char(5) NULL,
    [VCL] varchar(1) NOT NULL,
    [VSL] varchar(1) NOT NULL,
    [BdmUSGField1] varchar(256) NULL,
    [bdmbenstartdate] datetime NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EANTLIFEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Berry Petroleum

Created By: Marco Lagrosa
Business Analyst: Lea King
Create Date: 03/12/2020
Service Request Number: TekP-2019-11-21-0001

Purpose: Anthem VOL Plans Export

Revision History
----------------
Update By           Date           Request Num        Desc
XXXX                XX/XX/2020     SR-2020-000XXXXX   XXXXX

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EANTLIFEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EANTLIFEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EANTLIFEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EANTLIFEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EANTLIFEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTLIFEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTLIFEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTLIFEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EANTLIFEXP', 'TEST';


EXEC dbo.dsi_BDM_sp_ErrorCheck 'EANTLIFEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EANTLIFEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EANTLIFEXP';

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
    DELETE FROM dbo.U_EANTLIFEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EANTLIFEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'ACCD,CILLC,CILLF,CILLD,CILLE,GLIFE,HOSP,LTD,STD,HDHP,PPO,HMO';

    IF OBJECT_ID('U_EANTLIFEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EANTLIFEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EANTLIFEXP_DedList
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
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'BuildConsolidatedTable','Standard');

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




    UPDATE D

        SET D.BdmChangeReason = E.BdmChangeReason

    FROM dbo.U_dsi_bdm_EANTLIFEXP D

    JOIN dbo.U_dsi_bdm_EANTLIFEXP E

        ON E.BdmEEID = D.BdmEEID

        AND E.BdmCOID = D.BdmCOID

        AND E.BdmDedCode = D.BdmDedCode

    WHERE D.BdmRecType = 'DEP' AND E.BdmRecType = 'EMP';



    --=====================================================

    -- Update BdmUSGField2 with EmpDedTVID for Employees

    --=====================================================

    UPDATE dbo.U_dsi_bdm_EANTLIFEXP

        SET BdmUSGField2 = EedEmpDedTVID

    FROM dbo.U_dsi_bdm_EANTLIFEXP

    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)

        ON EedEEID = BdmEEID

        AND EedCOID = BdmCOID

        AND EedDedCode = BdmDedCode

    WHERE BdmRecType = 'EMP' AND EedFormatCode = @FormatCode AND EedValidForExport = 'Y';



    --=======================================================

    -- Update BdmUSGField2 with DepBPlanTVID for Dependents

    --=======================================================

    UPDATE dbo.U_dsi_bdm_EANTLIFEXP

        SET BdmUSGField2 = DbnDepBPlanTVID

    FROM dbo.U_dsi_bdm_EANTLIFEXP

    JOIN dbo.U_dsi_BDM_DepDeductions WITH (NOLOCK)

        ON DbnEEID = BdmEEID

        AND DbnCOID = BdmCOID

        AND DbnDedCode = BdmDedCode

    WHERE BdmRecType = 'DEP' AND DbnFormatCode = @FormatCode AND DbnValidForExport = 'Y';



    --======================================================

    -- Update BdmUSGField1 with Benefit Amount (EedBenAmt)

    --======================================================

    UPDATE dbo.U_dsi_bdm_EANTLIFEXP

        SET BdmUSGField1 = CONVERT(VARCHAR(20),EedBenAmt)

    FROM dbo.U_dsi_bdm_EANTLIFEXP

    JOIN dbo.EmpDedFull WITH (NOLOCK)

        ON EedEmpDedTVID = BdmUSGField2;
    --==========================================
    -- Build Working Tables
    --==========================================

    ---------------------------------
    -- Working Table - U_dsi_BDM_EANTLIFEXP_VOL
    ---------------------------------
    IF OBJECT_ID('U_dsi_BDM_EANTLIFEXP_VOL','U') IS NOT NULL
        DROP TABLE dbo.U_dsi_BDM_EANTLIFEXP_VOL;

        select bdmeeid
             ,bdmcoid
               ,bdmdeprecid
               ,bdmrectype
               ,bdmdedcode
               ,BdmUSGField1
               ,max(bdmbenstartdate) as bdmbenstartdate
               ,'0' as VCL
               ,'0' as VSL
                ,Convert(varchar(13),'') as VCLAMT
               ,Convert(varchar(13),'') as VSLAMT
            INTO dbo.U_dsi_BDM_EANTLIFEXP_VOL
            from dbo.U_dsi_BDM_EANTLIFEXP
        where bdmdedcode in ('VOL')
        group by bdmeeid,bdmcoid,bdmdeprecid,bdmrectype,bdmdedcode,BdmUSGField1

        Update dbo.U_dsi_BDM_EANTLIFEXP_VOL set VCL = ISNULL(B.VCL,'0'), VSL = ISNULL(B.VSL,'0'),
         VCLAMT = ISNULL(B.VCLAMT,'0'), VSLAMT = ISNULL(B.VSLAMT,'0')
        FROM dbo.U_dsi_BDM_EANTLIFEXP_VOL A
        Join (
        select bdmeeid
             ,bdmcoid
               ,bdmdeprecid
               ,bdmrectype
               ,Max(Case WHEN bdmDedCode = 'VCL'THEN '1' END) as VCL 
               ,Max(Case WHEN bdmDedCode = 'VSL'THEN '1' END) as VSL
                ,Max(Case WHEN bdmDedCode = 'VCL'THEN BdmUSGField1 END) as VCLAMT
               ,Max(Case WHEN bdmDedCode = 'VSL'THEN BdmUSGField1 END) as VSLAMT
            from dbo.U_dsi_BDM_EANTLIFEXP
        where bdmdedcode in ('VSL','VCL') and bdmrectype = 'EMP'
        group by bdmeeid,bdmcoid,bdmdeprecid,bdmrectype) as B
        on A.Bdmeeid = B.BdmEEID
        and A.bdmcoid  = B.bdmcoid


    -----------------------------
    -- Working Table - PDedHist
    -----------------------------
    IF OBJECT_ID('U_EANTLIFEXP_PDedHist','U') IS NOT NULL
        DROP TABLE dbo.U_EANTLIFEXP_PDedHist;
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
    INTO dbo.U_EANTLIFEXP_PDedHist
    FROM dbo.PDedHist WITH (NOLOCK)
    JOIN dbo.U_EANTLIFEXP_DedList WITH (NOLOCK)
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
    IF OBJECT_ID('U_EANTLIFEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EANTLIFEXP_PEarHist;
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
    INTO dbo.U_EANTLIFEXP_PEarHist
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
    -- DETAIL RECORD - U_EANTLIFEXP_drvMember
    ---------------------------------
    IF OBJECT_ID('U_EANTLIFEXP_drvMember','U') IS NOT NULL
        DROP TABLE dbo.U_EANTLIFEXP_drvMember;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2' + eepSSN
        ,drvSubSort = BdmDepRecID
        ,drvSubSort2 = cast(bdmdedcode as varchar(10))
        ,drvSubSort3 = '1'
        -- standard fields above and additional driver fields below
        ,drvMemSubsId = eepSSN
        ,drvMemGrpNumber = CASE WHEN bdmDedcode in ('ACCD') THEN '282032X001'
                                WHEN bdmDedcode in ('CILLC', 'CILLF', 'CILLD', 'CILLE') THEN '282032Y001'
                                WHEN bdmDedcode in ('HOSP') THEN '282032Z001'
                                WHEN bdmDedcode in ('STD') THEN '282032W001'
                                WHEN bdmDedcode in ('LTD') THEN '282032L001'
                                WHEN bdmDedcode in ('GLIFE') THEN '282032B001'
                                WHEN bdmDedcode in ('VOL') THEN '282032S001'
                                WHEN bdmDedcode in ('VSL') THEN '282032S002'
                                WHEN bdmDedcode in ('VCL') THEN '282032SF01'
                                WHEN bdmDedcode in ('HDHP') and EepAddressState  = 'CA' and bdmbenoption  = 'EE' THEN '282032M004'
                                WHEN bdmDedcode in ('HDHP') and EepAddressState  = 'CA' and bdmbenoption  IN ('EEC', 'EEF', 'EES') THEN '282032M007'
                                WHEN bdmDedcode in ('HDHP') and EepAddressState  <> 'CA' and bdmbenoption  IN ('EE') THEN '282032M013'
                                WHEN bdmDedcode in ('HDHP') and EepAddressState  <> 'CA' and bdmbenoption  IN ('EEC', 'EEF', 'EES') THEN '282032M016'
                                WHEN bdmDedcode in ('PPO') and EepAddressState  = 'CA' THEN '282032M001'
                                WHEN bdmDedcode in ('PPO') and EepAddressState  <> 'CA' THEN '282032M010'
                                WHEN bdmDedcode in ('HMO') THEN '282032H001'
                           END
        ,drvMemGrpNumSuffix = '' /*CASE WHEN bdmDedcode in ('ACCD') THEN '282032X001'
                                WHEN bdmDedcode in ('CILLC', 'CILLF', 'CILLD', 'CILLE') THEN '282032Y001'
                                WHEN bdmDedcode in ('HOSP') THEN '282032Z001'
                                WHEN bdmDedcode in ('STD') THEN '282032W001'
                                WHEN bdmDedcode in ('LTD') THEN '282032L001'
                                WHEN bdmDedcode in ('GLIFE') THEN '282032B001'
                                WHEN bdmDedcode in ('VOL') THEN '282032S001'
                                WHEN bdmDedcode in ('VSL') THEN '282032S002'
                                WHEN bdmDedcode in ('VCL') THEN '282032SF01'
                           END */
        ,drvMemActionCode = ''
        ,drvMemRelIndicator = CASE WHEN BdmRecType = 'EMP' THEN '1'
                                   WHEN BdmRecType = 'DEP' THEN 
                                    CASE WHEN ConRelationship in ('SPS', 'DP') THEN '2'
                                         WHEN ConRelationship in ('CHL', 'DPC','STC' ) THEN '3'
                                         WHEN ConRelationship in ('DIS' ) THEN '5'
                                    END
                              END
        ,drvMemRecType = '1'
        ,drvMemDOB = CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvMemFname = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                   WHEN BdmRecType = 'DEP' THEN ConNameFirst
                              END)
        ,drvMemMiddleName =dbo.dsi_fnRemoveChars('.,/-',
                                CASE WHEN BdmRecType = 'EMP' THEN LEFT(ISNULL(EepNameMiddle,''),1)
                                    WHEN BdmRecType = 'DEP' THEN LEFT(ISNULL(ConNameMiddle,''),1)
                                END)
        ,drvMemLastName = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END)
        ,drvMemGender = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                   WHEN BdmRecType = 'DEP' THEN ConGender
                              END)
        ,drvMemRelCode = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN 'SUB'
                                   WHEN BdmRecType = 'DEP' THEN 
                                   CASE WHEN ConRelationship in ('SPS', 'DP') THEN 'SPS'
                                         WHEN ConRelationship in ('CHL', 'DPC','STC','LEG' ) THEN 'CHD'
                                         WHEN ConRelationship in ('DIS' ) THEN 'HCH'
                                    END
                              END)
        ,drvMemFiller1 = ''
        ,drvMemCovEffDat =  CASE WHEN BdmDedcode in ('STD','LTD','GLIFE') THEN 
                                     dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, cast('07/01/2020' as datetime)) 
                                    ELSE  bdmBenStartDate 
                                  END 
        ,drvMemCovTermDate = CASE WHEN EecEmplStatus = 'T' THEN EecDateOfTermination END
        ,drvMemTermCode = ''
        ,drvMemDOH = ''
        ,drvMemMedQualInd = ''
        ,drvMemRehireDate = eecdateoflasthire
        ,drvMemFiller2 = ''
        ,drvMemRunInInd = ''
        ,drvMemFiller3 = ''
        ,drvMemLangInd = 'E'
        ,drvMemSSN = CASE WHEN BdmRecType = 'EMP' AND ISNULL(EepSSN, '') <> '' THEN EepSSN
                                 WHEN BdmRecType = 'DEP' AND ISNULL(ConSSN, '') <> '' THEN ConSSN
                            END
        ,drvMemFiller4 = ''
        ,drvMemAddressLine1 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1)
        ,drvMemCity = dbo.dsi_fnRemoveChars('.,/-',EepAddressCity)
        ,drvMemState = dbo.dsi_fnRemoveChars('.,/-',EepAddressState)
        ,drvMemZipCode = LEFT(EepAddressZipCode,5)
        ,drvMemZipCodePlus4 = ''
        ,drvMemZipCodePlus2 = ''
        ,drvMemAddressLine2 = dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2)
        ,drvMemPhoneNbr = ''
        ,drvMemPhoneNbrExt = ''
        ,drvMemCountryCode = ''
        ,drvMemForeignPostalCode = ''
        ,drvMemNetworkTermRsn = ''
        ,drvMemNetworkTermEffDate = ''
        ,drvMemNetworkId = ''
        ,drvMemIPAPCPPMG = ''
        ,drvMemPMPTrmRsn = ''
        ,drvMemProvEffDate = ''
        ,drvMemEffDateChange = ''
        ,drvMemExistPatInd = ''
        ,drvMemFiller5 = ''
        ,drvMemDeptNumber = eecorglvl1
        ,drvMemEmpNumber = ''
        ,drvMemDepTermDate = ''
        ,drvMemClaimCatNbr = ''
        ,drvMemClaimRept1 = ''
        ,drvMemClaimRept2 = ''
        ,drvMemClaimRept3 = ''
        ,drvMemCrossRefSubsId = ''
        ,drvMemCrossRefSubsType = ''
        ,drvMemFiller6 = ''
        ,drvMemCaseNumber = '282032'
        ,drvMemFiller7 = ''
        ,drvMemFiller8 = ''
        ,drvMemSalFreq = CASE WHEN BdmDedcode in ('STD','LTD','GLIFE','GLIFE') THEN 'A' END
        ,drvMemSalary = CASE WHEN BdmDedcode in ('STD','LTD','GLIFE','GLIFE') THEN 
                            CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (eecAnnsalary as money) *100,10,0))
                        END

        ,drvMemSalMulti = CONVERT(VARCHAR,dbo.dsi_fnPadZero((CASE WHEN BdmdedCode in ('GLIFE') THEN 2
                               WHEN BdmdedCode in ('STD','LTD') THEN 0.6
                          END                          ) *1000,5,0))
        ,drvMemSubsCvgAmt = '' --CASE WHEN bdmdedcode in ('VOL','VSL','VCL') THEN  CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (BdmUSGField1 as money) ,11,0)) END  
        ,drvMemSubsCvgAmtRaw = CASE WHEN bdmdedcode in ('VOL','VSL','VCL') THEN BdmUSGField1
                           END  
        ,drvMemFiller9 = ''
        ,drvMemFiller10 = ''
        ,drvMemClientDataField = ''
        ,drvMemFiller11 = ''
        ,drvMemFiller12 = ''
        ,drvMemPreExIndic = ''
        ,drvMemPreExEffDate = ''
        ,drvMemCoordBenefits = ''
        ,drvMemDisableInd = CASE WHEN ConRelationship in ('CHL','DPC','CHD','STC','LEG') and ConIsDisabled = 'Y' THEN 'Y' ELSE  'N' END
        ,drvMemCobraInd = ''
        ,drvMemCobraBeginDate = ''
        ,drvMemCobraEndDate = ''
        ,drvMemCobraEventCode = ''
        ,drvMemMedIndPartA = ''
        ,drvMemMedIndPartADate = ''
        ,drvMemMedIndPartB = ''
        ,drvMemMedIndPartBDate = ''
        ,drvMemHIBNbr = ''
        ,drvMemVIPInd = ''
        ,drvMemClaimFreeInd = ''
        ,drvMemMedFlexSA = ''
        ,drvMemDepFlexSA = ''
        ,drvMemMedSVA = ''
        ,drvMemDepIndType = ''
        ,drvMemHealthCareID = ''
        ,drvMemMailingAddress1 = ''
        ,drvMemMailingCity = ''
        ,drvMemMailingState = ''
        ,drvMemMailingZip = ''
        ,drvMemMailingZipPlus4 = ''
        ,drvMemMailingZip2 = ''
        ,drvMemMailingAddress2 = ''
        ,drvMemFiller13 = ''
        ,drvMemSpokenLang = ''
        ,drvMemWritenLang = ''
        ,drvMemRaceCode = ''
        ,drvMemEthnicCode = ''
        ,drvMemHeathFamMainType = ''
        ,drvMemHeathFamMainRsn = ''
        ,drvMemNatID = ''
        ,drvMEMProvCity = ''
        ,drvMEMProvState = ''
        ,drvMEMProvZip = ''
        ,drvMEMProvZip4 = ''
        ,drvMEMProvEndDate = ''
        ,drvMemFiller14 = ''
        ,drvMemSubsEmailAdd = ''
        ,drvMEmNPITaxId = ''
        ,drvMEMCovFamilyId = ''
        ,drvMEMCovCompanionId = ''
        ,drvMemPregInd = ''
        ,drvMemFiller15 = ''
    INTO dbo.U_EANTLIFEXP_drvMember
    FROM dbo.U_EANTLIFEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EANTLIFEXP WITH (NOLOCK)
        ON bdmeeid = xEEID 
        AND bdmcoid = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID;
    ;

        --Remove VCL and VSL 
    Delete from dbo.U_EANTLIFEXP_drvMember where drvMemGrpNumber in ('282032S002','282032SF01') and drvMemRelIndicator = '1'
    and drveeid in (Select distinct bdmeeid from U_dsi_BDM_EANTLIFEXP_VOL where VCL = '1' or  VSL = '1')


    Update dbo.U_EANTLIFEXP_drvMember
    set drvMemGrpNumber =  CASE WHEN VCL = '1' and VSL = '0' THEN '282032S002'
                                WHEN VCL = '1' or VSL = '1' THEN '282032SF01'
                                WHEN VCL = '0' and VSL = '0' THEN '282032S001'
                            END
    FROM dbo.U_EANTLIFEXP_drvMember
    JOIN dbo.U_dsi_BDM_EANTLIFEXP_VOL
    ON drveeid = bdmeeid
    and drvMemGrpNumber in ('282032S001') and drvMemRelIndicator = '1'


    Delete from dbo.U_EANTLIFEXP_drvMember where drvMemGrpNumber in ('282032W001','282032L001','282032B001','282032C001','282032S001','282032S002','282032N001','282032SF01','282032NF01') and drvDepREcid is not null
    ---------------------------------
    -- DETAIL RECORD - U_EANTLIFEXP_drvSpecialty
    ---------------------------------
    IF OBJECT_ID('U_EANTLIFEXP_drvSpecialty','U') IS NOT NULL
        DROP TABLE dbo.U_EANTLIFEXP_drvSpecialty;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = BdmDepRecID --DELETE IF NOT USING DEPENDENT DATA
        ,drvInitialSort = '2'+ eepssn
        ,drvSubSort = BdmDepRecID
        ,drvSubSort2 = cast(bdmdedcode as varchar(10))
        ,drvSubSort3 = '2'
        -- standard fields above and additional driver fields below
        ,drvSPESubsID = eepssn
        ,drvSPEGrpNbr = CASE WHEN bdmDedcode in ('ACCD') THEN '282032X001'
                                WHEN bdmDedcode in ('CILLC', 'CILLF', 'CILLD', 'CILLE') THEN '282032Y001'
                                WHEN bdmDedcode in ('HOSP') THEN '282032Z001'
                                WHEN bdmDedcode in ('STD') THEN '282032W001'
                                WHEN bdmDedcode in ('LTD') THEN '282032L001'
                                WHEN bdmDedcode in ('GLIFE') THEN '282032B001'
                                WHEN bdmDedcode in ('VOL') THEN '282032S001'
                                WHEN bdmDedcode in ('VSL') THEN '282032S002'
                                WHEN bdmDedcode in ('VCL') THEN '282032SF01'
                           END
        ,drvSPEGRPNbrSfx =  '' /*(CASE WHEN bdmDedcode in ('ACCD') THEN '282032X001'
                                WHEN bdmDedcode in ('CILLC', 'CILLF', 'CILLD', 'CILLE') THEN '282032Y001'
                                WHEN bdmDedcode in ('HOSP') THEN '282032Z001'
                                WHEN bdmDedcode in ('STD') THEN '282032W001'
                                WHEN bdmDedcode in ('LTD') THEN '282032L001'
                                WHEN bdmDedcode in ('GLIFE') THEN '282032B001'
                                WHEN bdmDedcode in ('VOL') THEN '282032S001'
                                WHEN bdmDedcode in ('VSL') THEN '282032S002'
                                WHEN bdmDedcode in ('VCL') THEN '282032SF01'
                           END*/
        ,drvSPEActionCd = ''
        ,drvSPERelInd =  CASE WHEN BdmRecType = 'EMP' THEN '1'
                                   WHEN BdmRecType = 'DEP' THEN 
                                    CASE WHEN ConRelationship in ('SPS', 'DP') THEN '2'
                                         WHEN ConRelationship in ('CHL', 'DPC','STC' ) THEN '3'
                                         WHEN ConRelationship in ('DIS' ) THEN '5'
                                    END
                              END 
        ,drvSPERecType = '5'
        ,drvSPEDOB =  CASE WHEN BdmRecType = 'EMP' THEN EepDateOfBirth ELSE ConDateOfBirth END
        ,drvSPEFirstName = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameFirst
                                   WHEN BdmRecType = 'DEP' THEN ConNameFirst
                              END)
        ,drvSPEMiddleName = dbo.dsi_fnRemoveChars('.,/-',
                                CASE WHEN BdmRecType = 'EMP' THEN LEFT(ISNULL(EepNameMiddle,''),1)
                                    WHEN BdmRecType = 'DEP' THEN LEFT(ISNULL(ConNameMiddle,''),1)
                                END)
        ,drvSPELastName = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepNameLast
                                   WHEN BdmRecType = 'DEP' THEN ConNameLast
                              END)
        ,drvSPEGender = dbo.dsi_fnRemoveChars('.,/-',
                              CASE WHEN BdmRecType = 'EMP' THEN EepGender
                                   WHEN BdmRecType = 'DEP' THEN ConGender
                              END)
        ,drvSPEBenChangeEffDate = CASE WHEN BdmDedcode in ('STD','LTD','GLIFE') THEN 
                                     dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, CAST('07/01/2020' as datetime) ) 

                                    ELSE  dbo.dsi_fnGetMinMaxDates('MAX',BdmBenStartDate, dbo.dsi_fnlib_GetAnnSalary_EffDate_WithStartDate(EecEEID, EecCOID, bdmbenstartdate,EecDateOfLastHire)) 
                                  END
        ,drvSPESalMultiSps = ''
        ,drvSPESPSCovAmt = CASE WHEN BdmDedcode in ('VSL') then CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (BdmUSGField1 as money) ,11,0)) ELSE CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (0 as money) ,11,0))  end
        ,drvSPEChlCovAmt = CASE WHEN BdmDedcode in ('VCL') then  CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (BdmUSGField1 as money),11,0)) ELSE CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (0 as money),11,0)) end
        ,drvSPEFiller1 = ''
    INTO dbo.U_EANTLIFEXP_drvSpecialty
    FROM dbo.U_EANTLIFEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
        JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.U_dsi_BDM_EANTLIFEXP WITH (NOLOCK)
        ON bdmeeid = xEEID 
        AND bdmcoid = xCoID
    LEFT JOIN dbo.Contacts WITH (NOLOCK)
        ON ConEEID = xEEID
        AND ConSystemID = BdmDepRecID
    WHERE bdmdedcode in ('ACCD','CILLC', 'CILLF', 'CILLD', 'CILLE','HOSP')
    ;

            --Remove VCL and VSL Specialty
    Delete from dbo.U_EANTLIFEXP_drvSpecialty where drvSPEGrpNbr in ('282032S002','282032SF01') and drvDepRecId is null
    and drveeid in (Select distinct bdmeeid from U_dsi_BDM_EANTLIFEXP_VOL where VCL = '1' or  VSL = '1')


    Update dbo.U_EANTLIFEXP_drvSpecialty
    set drvSPEGrpNbr =  CASE WHEN VCL = '1' and VSL = '0' THEN '282032S002'
                                WHEN VCL = '1' or VSL = '1' THEN '282032SF01'
                                WHEN VCL = '0' and VSL = '0' THEN '282032S001'
                            END
        ,drvSPESPSCovAmt = CASE WHEN VSL = '1' THEN  CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (VSLAMT as money) ,11,0)) END
        ,drvSPEChlCovAmt = CASE WHEN VCL = '1' THEN  CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (VCLAMT as money) ,11,0)) END
    FROM dbo.U_EANTLIFEXP_drvSpecialty
    JOIN dbo.U_dsi_BDM_EANTLIFEXP_VOL
    ON drveeid = bdmeeid
    and drvSPEGrpNbr in ('282032S001') and  drvDepRecId is null


    Delete from dbo.U_EANTLIFEXP_drvSpecialty where drvSPEGrpNbr in ('282032S002','282032SF01') and drvDepRecId is  not null

    INSERT INTO dbo.U_EANTLIFEXP_drvSpecialty
SELECT DISTINCT
         drvEEID
        ,drvCoID 
        ,drvDepRecID
        ,drvInitialSort 
        ,drvSubSort 
        ,drvSubSort2  = cast(drvSubSort2 + '2' as varchar(10))
        ,drvSubSort3
        -- standard fields above and additional driver fields below
        ,drvSPESubsID 
        ,drvSPEGrpNbr  =  CASE WHEN drvSPEGrpNbr = '282032B001' THEN '282032C001'
                                WHEN drvSPEGrpNbr = '282032S001' THEN '282032N001'
                                WHEN drvSPEGrpNbr IN ('282032S002','282032SF01') THEN '282032NF01'
                           END
        ,drvSPEGRPNbrSfx 
        ,drvSPEActionCd 
        ,drvSPERelInd 
        ,drvSPERecType 
        ,drvSPEDOB 
        ,drvSPEFirstName 
        ,drvSPEMiddleName 
        ,drvSPELastName
        ,drvSPEGender 
        ,drvSPEBenChangeEffDate 
        ,drvSPESalMultiSps 
        ,drvSPESPSCovAmt = CASE WHEN drvSPESPSCovAmt is null then CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (0 as money),11,0)) ELSE drvSPESPSCovAmt END
        ,drvSPEChlCovAmt  = CASE WHEN drvSPEChlCovAmt is null then CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (0 as money),11,0)) ELSE drvSPEChlCovAmt END
        ,drvSPEFiller1 
    FROM dbo.U_EANTLIFEXP_drvSpecialty
     Join dbo.U_dsi_BDM_EANTLIFEXP_VOL
     on  drveeid = bdmeeid
     and drvcoid = bdmcoid
        Where drvSPEGrpNbr In ('282032B001','282032S001','282032S002','282032SF01') -- and  VCL = '0' or  VSL = '0'



    Update dbo.U_EANTLIFEXP_drvSpecialty set  
        drvSPESPSCovAmt = CASE WHEN drvSPESPSCovAmt is null then CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (0 as money),11,0)) ELSE drvSPESPSCovAmt  END
        ,drvSPEChlCovAmt  = CASE WHEN drvSPEChlCovAmt is null then CONVERT(VARCHAR,dbo.dsi_fnPadZero(CAST (0 as money),11,0)) ELSE drvSPEChlCovAmt  END
    From dbo.U_EANTLIFEXP_drvSpecialty;
    
    Update  dbo.U_EANTLIFEXP_drvSpecialty set drvSPESPSCovAmt = '' ,  drvSPEChlCovAmt = ''   where isnull(drvSPESPSCovAmt,'00000000000') = '00000000000' and  isnull(drvSPEChlCovAmt,'00000000000') = '00000000000' 


    INSERT INTO U_EANTLIFEXP_drvMember
SELECT DISTINCT
         drvEEID
        ,drvCoID 
        ,drvDepRecID 
        ,drvInitialSort 
        ,drvSubSort 
        ,drvSubSort2  = cast(drvSubSort2 + '2' as varchar(10))
        ,drvSubSort3 
        -- standard fields above and additional driver fields below
        ,drvMemSubsId 
        ,drvMemGrpNumber = CASE WHEN drvMemGrpNumber = '282032B001' THEN '282032C001'
                                WHEN drvMemGrpNumber = '282032S001' THEN '282032N001'
                                WHEN drvMemGrpNumber IN ('282032S002','282032SF01') THEN '282032NF01'
                           END
        ,drvMemGrpNumSuffix = ''
        ,drvMemActionCode
        ,drvMemRelIndicator 
        ,drvMemRecType 
        ,drvMemDOB 
        ,drvMemFname
        ,drvMemMiddleName
        ,drvMemLastName
        ,drvMemGender 
        ,drvMemRelCode
        ,drvMemFiller1 
        ,drvMemCovEffDat 
        ,drvMemCovTermDate
        ,drvMemTermCode
        ,drvMemDOH
        ,drvMemMedQualInd
        ,drvMemRehireDate 
        ,drvMemFiller2
        ,drvMemRunInInd
        ,drvMemFiller3
        ,drvMemLangInd 
        ,drvMemSSN 
        ,drvMemFiller4
        ,drvMemAddressLine1 
        ,drvMemCity 
        ,drvMemState 
        ,drvMemZipCode 
        ,drvMemZipCodePlus4
        ,drvMemZipCodePlus2
        ,drvMemAddressLine2 
        ,drvMemPhoneNbr
        ,drvMemPhoneNbrExt
        ,drvMemCountryCode
        ,drvMemForeignPostalCode
        ,drvMemNetworkTermRsn
        ,drvMemNetworkTermEffDate
        ,drvMemNetworkId
        ,drvMemIPAPCPPMG
        ,drvMemPMPTrmRsn
        ,drvMemProvEffDate
        ,drvMemEffDateChange
        ,drvMemExistPatInd
        ,drvMemFiller5
        ,drvMemDeptNumber
        ,drvMemEmpNumber
        ,drvMemDepTermDate
        ,drvMemClaimCatNbr
        ,drvMemClaimRept1
        ,drvMemClaimRept2
        ,drvMemClaimRept3
        ,drvMemCrossRefSubsId
        ,drvMemCrossRefSubsType
        ,drvMemFiller6
        ,drvMemCaseNumber 
        ,drvMemFiller7
        ,drvMemFiller8
        ,drvMemSalFreq 
        ,drvMemSalary 
        ,drvMemSalMulti
        ,drvMemSubsCvgAmt
        ,drvMemSubsCvgAmtRaw
        ,drvMemFiller9
        ,drvMemFiller10
        ,drvMemClientDataField
        ,drvMemFiller11
        ,drvMemFiller12
        ,drvMemPreExIndic
        ,drvMemPreExEffDate
        ,drvMemCoordBenefits
        ,drvMemDisableInd
        ,drvMemCobraInd
        ,drvMemCobraBeginDate
        ,drvMemCobraEndDate
        ,drvMemCobraEventCode
        ,drvMemMedIndPartA
        ,drvMemMedIndPartADate
        ,drvMemMedIndPartB
        ,drvMemMedIndPartBDate
        ,drvMemHIBNbr
        ,drvMemVIPInd
        ,drvMemClaimFreeInd
        ,drvMemMedFlexSA
        ,drvMemDepFlexSA
        ,drvMemMedSVA
        ,drvMemDepIndType
        ,drvMemHealthCareID
        ,drvMemMailingAddress1
        ,drvMemMailingCity
        ,drvMemMailingState
        ,drvMemMailingZip
        ,drvMemMailingZipPlus4
        ,drvMemMailingZip2
        ,drvMemMailingAddress2
        ,drvMemFiller13
        ,drvMemSpokenLang
        ,drvMemWritenLang
        ,drvMemRaceCode
        ,drvMemEthnicCode
        ,drvMemHeathFamMainType
        ,drvMemHeathFamMainRsn
        ,drvMemNatID
        ,drvMEMProvCity
        ,drvMEMProvState
        ,drvMEMProvZip
        ,drvMEMProvZip4
        ,drvMEMProvEndDate
        ,drvMemFiller14
        ,drvMemSubsEmailAdd
        ,drvMEmNPITaxId
        ,drvMEMCovFamilyId
        ,drvMEMCovCompanionId
        ,drvMemPregInd
        ,drvMemFiller15
    FROM  dbo.U_EANTLIFEXP_drvMember

    Where drvMemGrpNumber In ('282032B001','282032S001','282032S002','282032SF01')


    Delete from dbo.U_EANTLIFEXP_drvMember where drvMemGrpNumber in ('282032W001','282032L001','282032B001','282032C001','282032S001','282032S002','282032N001','282032SF01','282032NF01') and drvDepREcid is not null
    Delete from dbo.U_EANTLIFEXP_drvSpecialty where drvSPEGrpNbr is null
    Delete from dbo.U_EANTLIFEXP_drvMember where 
    drvSubSort2 in ('STD','LTD','GLIFE','GLIFE2')  and  CAST(drvMemCovTermDate as datetime)  < cast(drvMemCovEffDat as datetime)
    ---------------------------------
    -- HEADER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTLIFEXP_Header','U') IS NOT NULL
        DROP TABLE dbo.U_EANTLIFEXP_Header;
    SELECT DISTINCT
         drvHDRFiller1 = ''
        ,drvHDRCaseNumber = '282032'
        ,drvHDRFiller2 = ''
        ,drvHDRRecType = '0'
        ,drvHDREffDate = GETDATE()
        ,drvHDRFileDate  = GETDATE()
        ,drvHDRFileInd =  'F'
        ,drvHDRFiller3 = ''
    INTO dbo.U_EANTLIFEXP_Header
    ;
    ---------------------------------
    -- TRAILER RECORD
    ---------------------------------
    IF OBJECT_ID('U_EANTLIFEXP_drvTrailer','U') IS NOT NULL
        DROP TABLE dbo.U_EANTLIFEXP_drvTrailer;
    SELECT DISTINCT
         drvSPEFiller2 = ''
        ,drvTRARecType = '9'
        ,drvTRARecCount = CAST( ((select count(*) from dbo.U_EANTLIFEXP_drvSpecialty) + (select count(*) from dbo.U_EANTLIFEXP_drvMember)) as varchar(7))
        ,drvTRAFiller1 = ''
    INTO dbo.U_EANTLIFEXP_drvTrailer
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
ALTER VIEW dbo.dsi_vwEANTLIFEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EANTLIFEXP_File (NOLOCK)
    ORDER BY  InitialSort,SubSort2,Subsort,Subsort3;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EANTLIFEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202003051'
       ,expStartPerControl     = '202003051'
       ,expLastEndPerControl   = '202003129'
       ,expEndPerControl       = '202003129'
WHERE expFormatCode = 'EANTLIFEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEANTLIFEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EANTLIFEXP_File (NOLOCK)
    ORDER BY  InitialSort,SubSort2,Subsort,Subsort3;