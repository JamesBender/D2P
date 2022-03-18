SET NOCOUNT ON;
IF OBJECT_ID('U_EHSAELEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHSAELEXP_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EHSAELEXP_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EHSAELEXP' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEHSAELEXP_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEHSAELEXP_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EHSAELEXP') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHSAELEXP];
GO
IF OBJECT_ID('U_EHSAELEXP_PEarHist') IS NOT NULL DROP TABLE [dbo].[U_EHSAELEXP_PEarHist];
GO
IF OBJECT_ID('U_EHSAELEXP_File') IS NOT NULL DROP TABLE [dbo].[U_EHSAELEXP_File];
GO
IF OBJECT_ID('U_EHSAELEXP_EEList') IS NOT NULL DROP TABLE [dbo].[U_EHSAELEXP_EEList];
GO
IF OBJECT_ID('U_EHSAELEXP_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_EHSAELEXP_drvTbl];
GO
IF OBJECT_ID('U_EHSAELEXP_DedList') IS NOT NULL DROP TABLE [dbo].[U_EHSAELEXP_DedList];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EHSAELEXP';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EHSAELEXP';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EHSAELEXP';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EHSAELEXP';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EHSAELEXP';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0','','','N','','N','','013010','EMPEXPORT','CDE','EHSAELEXP','HSA Eligibilty Export','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EHSAELEXP0Z0','N','Jan  1 1900 12:00AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','1','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BIRTHDATE"','2','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','2',NULL,'BIRTHDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LASTNAME"','3','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','3',NULL,'LASTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRSTNAME"','4','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','4',NULL,'FIRSTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TITLE"','5','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','5',NULL,'TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDINIT"','6','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','6',NULL,'MIDINIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPTYPE"','7','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','7',NULL,'EMPTYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGETYPE"','8','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','8',NULL,'COVERAGETYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COVERAGETYPE_EFFDate"','9','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','9',NULL,'COVERAGETYPE_EFFDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HEALTHPLAN_EFFDate"','10','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','10',NULL,'HEALTHPLAN_EFFDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"COUNTRY OF CITIZENSHIP"','11','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','11',NULL,'COUNTRY OF CITIZENSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMPLOYER EIN "','12','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','12',NULL,'EMPLOYER EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TERMINATION DATE"','13','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','13',NULL,'TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHYSICALADDRESS"','14','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','14',NULL,'PHYSICALADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHYSICALADDRESS2"','15','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','15',NULL,'PHYSICALADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHYSICALCITY"','16','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','16',NULL,'PHYSICALCITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHYSICALSTATE"','17','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','17',NULL,'PHYSICALSTATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHYSICALZIP5"','18','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','18',NULL,'PHYSICALZIP5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MAILINGADDRESS1"','19','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','19',NULL,'MAILINGADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MAILINGADDRESS2"','20','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','20',NULL,'MAILINGADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MAILINGCITY"','21','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','21',NULL,'MAILINGCITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MAILINGSTATE"','22','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','22',NULL,'MAILINGSTATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MAILINGZIP"','23','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','23',NULL,'MAILINGZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PRIMARYPHONE"','24','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','24',NULL,'PRIMARYPHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ALTPHONE"','25','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','25',NULL,'ALTPHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EMAILADDRESS"','26','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','26',NULL,'EMAILADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AUTH_FIRSTNAME"','27','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','27',NULL,'AUTH_FIRSTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AUTH_MIDDLEINITIAL"','28','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','28',NULL,'AUTH_MIDDLEINITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AUTH_LASTNAME"','29','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','29',NULL,'AUTH_LASTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AUTH_DOB"','30','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','30',NULL,'AUTH_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"AUTH_SSN"','31','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','31',NULL,'AUTH_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NUMBEROFCARDS"','32','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','32',NULL,'NUMBEROFCARDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"INTEGRATEDSETTLEMENT"','33','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','33',NULL,'INTEGRATEDSETTLEMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLAN_ID"','34','(''DA''=''T,'')','EHSAELEXP0Z0','50','H','01','34',NULL,'PLAN_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"HIREDATE"','35','(''DA''=''T'')','EHSAELEXP0Z0','50','H','01','35',NULL,'HIREDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','1','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','1',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBIRTHDATE"','2','(''UD101''=''T,'')','EHSAELEXP0Z0','50','D','10','2',NULL,'BIRTHDATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLASTNAME"','3','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','3',NULL,'LASTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFIRSTNAME"','4','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','4',NULL,'FIRSTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTITLE"','5','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','5',NULL,'TITLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMIDINIT"','6','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','6',NULL,'MIDINIT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPTYPE"','7','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','7',NULL,'EMPTYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOVERAGETYPE"','8','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','8',NULL,'COVERAGETYPE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOVERAGETYPE_EFFDate"','9','(''UD101''=''T,'')','EHSAELEXP0Z0','50','D','10','9',NULL,'COVERAGETYPE_EFFDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHEALTHPLAN_EFFDate"','10','(''UD101''=''T,'')','EHSAELEXP0Z0','50','D','10','10',NULL,'HEALTHPLAN_EFFDate',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCOUNTRYOFCITIZENSHIP"','11','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','11',NULL,'COUNTRY OF CITIZENSHIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMPLOYEREIN"','12','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','12',NULL,'EMPLOYER EIN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTERMINATIONDATE"','13','(''UD101''=''T,'')','EHSAELEXP0Z0','50','D','10','13',NULL,'TERMINATION DATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPHYSICALADDRESS"','14','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','14',NULL,'PHYSICALADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPHYSICALADDRESS2"','15','(''UA''=''T,'')','EHSAELEXP0Z0','50','D','10','15',NULL,'PHYSICALADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPHYSICALCITY"','16','(''UA''=''T,'')','EHSAELEXP0Z0','51','D','10','16',NULL,'PHYSICALCITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPHYSICALSTATE"','17','(''UA''=''T,'')','EHSAELEXP0Z0','52','D','10','17',NULL,'PHYSICALSTATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPHYSICALZIP5"','18','(''UA''=''T,'')','EHSAELEXP0Z0','53','D','10','18',NULL,'PHYSICALZIP5',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMAILINGADDRESS1"','19','(''UA''=''T,'')','EHSAELEXP0Z0','54','D','10','19',NULL,'MAILINGADDRESS1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMAILINGADDRESS2"','20','(''UA''=''T,'')','EHSAELEXP0Z0','55','D','10','20',NULL,'MAILINGADDRESS2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMAILINGCITY"','21','(''UA''=''T,'')','EHSAELEXP0Z0','56','D','10','21',NULL,'MAILINGCITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMAILINGSTATE"','22','(''UA''=''T,'')','EHSAELEXP0Z0','57','D','10','22',NULL,'MAILINGSTATE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMAILINGZIP"','23','(''UA''=''T,'')','EHSAELEXP0Z0','58','D','10','23',NULL,'MAILINGZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPRIMARYPHONE"','24','(''UA''=''T,'')','EHSAELEXP0Z0','59','D','10','24',NULL,'PRIMARYPHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvALTPHONE"','25','(''UA''=''T,'')','EHSAELEXP0Z0','60','D','10','25',NULL,'ALTPHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEMAILADDRESS"','26','(''UA''=''T,'')','EHSAELEXP0Z0','61','D','10','26',NULL,'EMAILADDRESS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAUTH_FIRSTNAME"','27','(''UA''=''T,'')','EHSAELEXP0Z0','62','D','10','27',NULL,'AUTH_FIRSTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAUTH_MIDDLEINITIAL"','28','(''UA''=''T,'')','EHSAELEXP0Z0','63','D','10','28',NULL,'AUTH_MIDDLEINITIAL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAUTH_LASTNAME"','29','(''UA''=''T,'')','EHSAELEXP0Z0','64','D','10','29',NULL,'AUTH_LASTNAME',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAUTH_DOB"','30','(''UD101''=''T,'')','EHSAELEXP0Z0','65','D','10','30',NULL,'AUTH_DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAUTH_SSN"','31','(''UA''=''T,'')','EHSAELEXP0Z0','66','D','10','31',NULL,'AUTH_SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNUMBEROFCARDS"','32','(''UA''=''T,'')','EHSAELEXP0Z0','67','D','10','32',NULL,'NUMBEROFCARDS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvINTEGRATEDSETTLEMENT"','33','(''UA''=''T,'')','EHSAELEXP0Z0','68','D','10','33',NULL,'INTEGRATEDSETTLEMENT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLAN_ID"','34','(''UA''=''T,'')','EHSAELEXP0Z0','69','D','10','34',NULL,'PLAN_ID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHIREDATE"','35','(''UD101''=''T'')','EHSAELEXP0Z0','70','D','10','35',NULL,'HIREDATE',NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAELEXP_20200109.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'HSA Eligibilty Export','201910319','EMPEXPORT','ONDEMAND',NULL,'EHSAELEXP',NULL,NULL,NULL,'201910319','Oct 31 2019  1:01PM','Oct 31 2019  1:01PM','201910311',NULL,'','','201910311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAELEXP_20200109.txt',NULL,'','',NULL,NULL,NULL,NULL,'Scheduled Session','201910319','EMPEXPORT','SCHEDULED',NULL,'EHSAELEXP',NULL,NULL,NULL,'201910319','Oct 31 2019  1:01PM','Oct 31 2019  1:01PM','201910311',NULL,'','','201910311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAELEXP_20200109.txt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Active Open Enrollment Export','201910319','EMPEXPORT','OEACTIVE',NULL,'EHSAELEXP',NULL,NULL,NULL,'201910319','Oct 31 2019  1:01PM','Oct 31 2019  1:01PM','201910311',NULL,'','','201910311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAELEXP_20200109.txt',NULL,'','',NULL,NULL,NULL,NULL,'Passive Open Enrollment Export','201910319','EMPEXPORT','OEPASSIVE',NULL,'EHSAELEXP',NULL,NULL,NULL,'201910319','Oct 31 2019  1:01PM','Oct 31 2019  1:01PM','201910311',NULL,'','','201910311',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_EHSAELEXP_20200109.txt',NULL,'','','',NULL,NULL,NULL,'Test Purposes Only','202001079','EMPEXPORT','TEST','Jan  7 2020  1:56PM','EHSAELEXP',NULL,NULL,NULL,'202001079','Jan  7 2020 12:00AM','Dec 30 1899 12:00AM','202001011','319','','','202001011',dbo.fn_GetTimedKey(),NULL,'us3lKiDIA1002',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_EHSAELEXP_20200109.txt' END WHERE expFormatCode = 'EHSAELEXP';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAELEXP','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAELEXP','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAELEXP','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EHSAELEXP','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'EHSAELEXP' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EHSAELEXP' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_EHSAELEXP_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EHSAELEXP_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHSAELEXP','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EHSAELEXP','D10','dbo.U_EHSAELEXP_drvTbl',NULL);
IF OBJECT_ID('U_EHSAELEXP_DedList') IS NULL
CREATE TABLE [dbo].[U_EHSAELEXP_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EHSAELEXP_drvTbl') IS NULL
CREATE TABLE [dbo].[U_EHSAELEXP_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvDepRecID] varchar(12) NULL,
    [drvSSN] char(11) NULL,
    [drvBIRTHDATE] datetime NULL,
    [drvLASTNAME] varchar(100) NULL,
    [drvFIRSTNAME] varchar(100) NULL,
    [drvTITLE] varchar(1) NOT NULL,
    [drvMIDINIT] varchar(1) NOT NULL,
    [drvEMPTYPE] varchar(1) NOT NULL,
    [drvCOVERAGETYPE] varchar(1) NOT NULL,
    [drvCOVERAGETYPE_EFFDate] datetime NULL,
    [drvHEALTHPLAN_EFFDate] datetime NULL,
    [drvCOUNTRYOFCITIZENSHIP] varchar(3) NOT NULL,
    [drvEMPLOYEREIN] varchar(1) NOT NULL,
    [drvTERMINATIONDATE] datetime NULL,
    [drvPHYSICALADDRESS] varchar(6000) NULL,
    [drvPHYSICALADDRESS2] varchar(1) NOT NULL,
    [drvPHYSICALCITY] varchar(6000) NULL,
    [drvPHYSICALSTATE] varchar(6000) NULL,
    [drvPHYSICALZIP5] varchar(6000) NULL,
    [drvMAILINGADDRESS1] varchar(6000) NULL,
    [drvMAILINGADDRESS2] varchar(1) NOT NULL,
    [drvMAILINGCITY] varchar(6000) NULL,
    [drvMAILINGSTATE] varchar(6000) NULL,
    [drvMAILINGZIP] varchar(6000) NULL,
    [drvPRIMARYPHONE] varchar(10) NULL,
    [drvALTPHONE] varchar(1) NOT NULL,
    [drvEMAILADDRESS] varchar(50) NOT NULL,
    [drvAUTH_FIRSTNAME] varchar(1) NOT NULL,
    [drvAUTH_MIDDLEINITIAL] varchar(1) NOT NULL,
    [drvAUTH_LASTNAME] varchar(1) NOT NULL,
    [drvAUTH_DOB] varchar(1) NOT NULL,
    [drvAUTH_SSN] varchar(1) NOT NULL,
    [drvNUMBEROFCARDS] varchar(1) NOT NULL,
    [drvINTEGRATEDSETTLEMENT] varchar(1) NOT NULL,
    [drvPLAN_ID] varchar(9) NOT NULL,
    [drvHIREDATE] datetime NULL
);
IF OBJECT_ID('U_EHSAELEXP_EEList') IS NULL
CREATE TABLE [dbo].[U_EHSAELEXP_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EHSAELEXP_File') IS NULL
CREATE TABLE [dbo].[U_EHSAELEXP_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] varchar(2000) NULL
);
IF OBJECT_ID('U_EHSAELEXP_PEarHist') IS NULL
CREATE TABLE [dbo].[U_EHSAELEXP_PEarHist] (
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
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EHSAELEXP]
    @SystemID char(12)
AS
SET NOCOUNT ON;
/**********************************************************************************
Client Name: Diamond Healthcare

Created By: Inshan Singh
Business Analyst: Lea King
Create Date: 10/31/2019
Service Request Number: TekP-2019-10-25-0006

Purpose: HSA Eligibilty Export

Revision History
----------------
Update By           Date           Request Num           Desc
Inshan Singh       10/31/2019     TekP-2019-10-25-0006   Initial Development

SELECT * FROM dbo.U_dsi_Configuration WHERE FormatCode = 'EHSAELEXP';
SELECT * FROM dbo.U_dsi_SqlClauses WHERE FormatCode = 'EHSAELEXP';
SELECT * FROM dbo.U_dsi_Parameters WHERE FormatCode = 'EHSAELEXP';
SELECT ExpFormatCode, ExpExportCode, ExpStartPerControl, ExpEndPerControl,* FROM dbo.AscExp WHERE expFormatCode = 'EHSAELEXP';
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EHSAELEXP' ORDER BY RunID DESC;

Execute Export
--------------
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAELEXP', 'ONDEMAND';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAELEXP', 'OEPASSIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAELEXP', 'OEACTIVE';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAELEXP', 'SCHEDULED';
EXEC dbo.dsi_sp_TestSwitchbox_v2 'EHSAELEXP', 'TEST';

EXEC dbo.dsi_BDM_sp_ErrorCheck 'EHSAELEXP';

EXEC dbo._dsi_usp_ExportRipOut @FormatCode = 'EHSAELEXP', @AllObjects = 'Y', @IsWeb = 'Y'
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
    SELECT @FormatCode = 'EHSAELEXP';

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
    DELETE FROM dbo.U_EHSAELEXP_EEList
    WHERE xCoID <> dbo.dsi_BDM_fn_GetCurrentCOID(xEEID)
    AND xEEID IN (SELECT xEEID FROM dbo.U_EHSAELEXP_EEList GROUP BY xEEID HAVING COUNT(1) > 1);

    -- Remove Employees that Do Not Have a Benefit Plan in Deduction Code List
    DELETE FROM dbo.U_EHSAELEXP_EEList
    WHERE xEEID IN (SELECT eecEEID FROM EmpComp WITH(NOLOCK) WHERE eecEEType = 'TES' );

    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList = 'HSAF,HSAS';

    IF OBJECT_ID('U_EHSAELEXP_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAELEXP_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EHSAELEXP_DedList
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

    -----------------------------
    -- Working Table - PEarHist
    -----------------------------
    IF OBJECT_ID('U_EHSAELEXP_PEarHist','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAELEXP_PEarHist;
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
    INTO dbo.U_EHSAELEXP_PEarHist
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
    -- DETAIL RECORD - U_EHSAELEXP_drvTbl
    ---------------------------------
    IF OBJECT_ID('U_EHSAELEXP_drvTbl','U') IS NOT NULL
        DROP TABLE dbo.U_EHSAELEXP_drvTbl;
    SELECT DISTINCT
         drvEEID = xEEID
        ,drvCoID = xCoID
        ,drvDepRecID = CONVERT(varchar(12),'1') --DELETE IF NOT USING DEPENDENT DATA
        -- standard fields above and additional driver fields below
        ,drvSSN = eepSSN
        ,drvBIRTHDATE = EepDateOfBirth
        ,drvLASTNAME = EepNameLast
        ,drvFIRSTNAME = EepNameFirst
        ,drvTITLE = ''
        ,drvMIDINIT = ''
        ,drvEMPTYPE = 'E'
        ,drvCOVERAGETYPE = CASE EedDedCode WHEN 'HSAS' THEN '1' ELSE '2' END
        ,drvCOVERAGETYPE_EFFDate = EedBenStatusDate
        ,drvHEALTHPLAN_EFFDate = EedBenStatusDate
        ,drvCOUNTRYOFCITIZENSHIP = 'USA'
        ,drvEMPLOYEREIN = ''
        ,drvTERMINATIONDATE = DATEADD(day,30,EedBenStopDate) 
        ,drvPHYSICALADDRESS =    CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                        OR PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                        OR PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2))) > 0 
                                        OR PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine2))) > 0 THEN '701 East Byrd Street 15FL' 
                                ELSE dbo.dsi_fnRemoveChars('.,/-', ISNULL(EepAddressLine1, '') + ' ' + ISNULL(EepAddressLine2, '')) 
                                END
                                
        ,drvPHYSICALADDRESS2 =  ''
        ,drvPHYSICALCITY =    CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                    OR PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                    AND dbo.dsi_fnRemoveChars('.,/-',ISNULL(EepAddressLine2,'')) = '' THEN 'Richmond' 
                                ELSE dbo.dsi_fnRemoveChars('.,/-',EepAddressCity) 
                            END 
        ,drvPHYSICALSTATE =    CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                    OR PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                    AND dbo.dsi_fnRemoveChars('.,/-',ISNULL(EepAddressLine2,'')) = '' THEN 'VA' 
                                ELSE dbo.dsi_fnRemoveChars('.,/-',EepAddressState) 
                            END  
        ,drvPHYSICALZIP5 =    CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                    OR PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 
                                    AND dbo.dsi_fnRemoveChars('.,/-',ISNULL(EepAddressLine2,'')) = '' THEN '23219' 
                                ELSE dbo.dsi_fnRemoveChars('.,/-',LEFT(EepAddressZipCode,5)) 
                            END  
        ,drvMAILINGADDRESS1 = CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 or PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 THEN dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1) ELSE '' END
        ,drvMAILINGADDRESS2 = ''
        ,drvMAILINGCITY = CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 or PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0  THEN dbo.dsi_fnRemoveChars('.,/-',EepAddressCity) ELSE ''  END 
        ,drvMAILINGSTATE = CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 or PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 THEN dbo.dsi_fnRemoveChars('.,/-',EepAddressState) ELSE '' END  
        ,drvMAILINGZIP = CASE WHEN PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0  or PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',EepAddressLine1))) > 0 THEN dbo.dsi_fnRemoveChars('.,/-',LEFT(EepAddressZipCode,5)) ELSE  '' END  
        ,drvPRIMARYPHONE = CASE WHEN ISNULL(EecPhoneBusinessNumber, '') <> '' AND EecPhoneBusinessNumber <> '' THEN EecPhoneBusinessNumber
                            ELSE '9999999999'
                            END
        ,drvALTPHONE = ''
        ,drvEMAILADDRESS = ISNULL(EepAddressEMail,'noemail@healthsavings.com')
        ,drvAUTH_FIRSTNAME = ''
        ,drvAUTH_MIDDLEINITIAL = ''
        ,drvAUTH_LASTNAME = ''
        ,drvAUTH_DOB = ''
        ,drvAUTH_SSN = ''
        ,drvNUMBEROFCARDS = '1'
        ,drvINTEGRATEDSETTLEMENT = ''
        ,drvPLAN_ID = 'DiamondHe'
        ,drvHIREDATE = EecDateOfLastHire
    INTO dbo.U_EHSAELEXP_drvTbl
    FROM dbo.U_EHSAELEXP_EEList WITH (NOLOCK)
    JOIN dbo.EmpComp WITH (NOLOCK)
        ON EecEEID = xEEID 
        AND EecCoID = xCoID
    JOIN dbo.EmpPers WITH (NOLOCK)
        ON EepEEID = xEEID
    JOIN dbo.U_dsi_BDM_EmpDeductions WITH (NOLOCK)
        ON EedEEID = xEEID 
        AND EedCoID = xCoID
        AND EedFormatCode = @FormatCode 
        AND EedValidForExport = 'Y'
    ;

    --Update the drive table to set blank for address with po box
    UPDATE U_EHSAELEXP_drvTbl set drvPHYSICALADDRESS = '',drvPHYSICALADDRESS2 = '',drvPHYSICALCITY = '',drvPHYSICALSTATE = '',drvPHYSICALZIP5 = '' 
   Where PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',drvPhysicalAddress2))) > 0 or PATINDEX('%po box%',lower(dbo.dsi_fnRemoveChars('.,/-',drvPhysicalAddress))) > 0 or PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',drvPhysicalAddress2))) > 0 or PATINDEX('%p o box%',lower(dbo.dsi_fnRemoveChars('.,/-',drvPhysicalAddress))) > 0

    --Update addressline 2 that starts with # to be replace to Apt example values #123 to Apt 123
    --Update U_EHSAELEXP_drvTbl set drvPHYSICALADDRESS2 =  REplace(drvPHYSICALADDRESS2,'#','Apt ')  where  LEFT(drvPHYSICALADDRESS2,1) = '#'

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
ALTER VIEW dbo.dsi_vwEHSAELEXP_Export AS
    SELECT TOP 20000000 Data FROM dbo.U_EHSAELEXP_File (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort, SubSort;

--Check out AscDefF
SELECT * FROM dbo.AscDefF
WHERE AdfHeaderSystemID LIKE 'EHSAELEXP%'
ORDER BY AdfSetNumber, AdfFieldNumber;

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '201910241'
       ,expStartPerControl     = '201910241'
       ,expLastEndPerControl   = '201910319'
       ,expEndPerControl       = '201910319'
WHERE expFormatCode = 'EHSAELEXP';

**********************************************************************************/
GO
CREATE VIEW dbo.dsi_vwEHSAELEXP_Export AS 
    SELECT TOP 200000000 Data FROM dbo.U_EHSAELEXP_File WITH (NOLOCK)
    ORDER BY RIGHT(RecordSet,2), InitialSort