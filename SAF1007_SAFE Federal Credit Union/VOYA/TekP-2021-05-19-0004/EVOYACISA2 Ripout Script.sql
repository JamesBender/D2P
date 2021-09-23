SET NOCOUNT ON;
IF OBJECT_ID('U_EVOYACISA2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_SavePath];
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_EVOYACISA2_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'EVOYACISA2' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwEVOYACISA2_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwEVOYACISA2_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_EVOYACISA2') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYACISA2];
GO
IF OBJECT_ID('U_EVOYACISA2_File') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_File];
GO
IF OBJECT_ID('U_EVOYACISA2_EEList') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_EEList];
GO
IF OBJECT_ID('U_EVOYACISA2_DepList') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_DepList];
GO
IF OBJECT_ID('U_EVOYACISA2_DedList') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_DedList];
GO
IF OBJECT_ID('U_EVOYACISA2_AuditFields') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_AuditFields];
GO
IF OBJECT_ID('U_EVOYACISA2_Audit') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_Audit];
GO
IF OBJECT_ID('U_dsi_EVOYACISA2_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_EVOYACISA2_drvTbl];
GO
IF OBJECT_ID('U_dsi_BDM_EVOYACISA2') IS NOT NULL DROP TABLE [dbo].[U_dsi_BDM_EVOYACISA2];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'EVOYACISA2';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'EVOYACISA2';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'EVOYACISA2';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'EVOYACISA2';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'EVOYACISA2';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','EVOYACISA2','Voya - Accident & Critical Illness','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2000','S','N','EVOYACISA2Z0','N','Jan 17 2020  3:26PM','C','N',NULL,'N');
/*01*/ INSERT INTO dbo.CustomTemplates (Engine,EngineCode) SELECT Engine = AdhEngine, EngineCode = AdhFormatCode FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'EVOYACISA2' AND AdhEngine = 'EMPEXPORT' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode AND Engine = AdhEngine); /* Insert field into CustomTemplates table */
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GBPID"','1','(''DA''=''T,'')','EVOYACISA2Z0','5','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ACCT"','2','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','6',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EEID"','3','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"REL"','4','(''DA''=''T,'')','EVOYACISA2Z0','3','H','01','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SSN"','5','(''DA''=''T,'')','EVOYACISA2Z0','3','H','01','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"LASTNM"','6','(''DA''=''T,'')','EVOYACISA2Z0','6','H','01','20',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"FIRSTNM"','7','(''DA''=''T,'')','EVOYACISA2Z0','7','H','01','26',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"MIDDLE"','8','(''DA''=''T,'')','EVOYACISA2Z0','6','H','01','33',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"NMSUFFIX"','9','(''DA''=''T,'')','EVOYACISA2Z0','8','H','01','39',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD1"','10','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','47',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ADD2"','11','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','51',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CITY"','12','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','55',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ST"','13','(''DA''=''T,'')','EVOYACISA2Z0','2','H','01','59',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ZIP"','14','(''DA''=''T,'')','EVOYACISA2Z0','3','H','01','61',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DOB"','15','(''DA''=''T,'')','EVOYACISA2Z0','3','H','01','64',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"GENDER"','16','(''DA''=''T,'')','EVOYACISA2Z0','6','H','01','67',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PHONE"','17','(''DA''=''T,'')','EVOYACISA2Z0','5','H','01','73',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EEST"','18','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','78',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EEDOH"','19','(''DA''=''T,'')','EVOYACISA2Z0','5','H','01','82',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ETD"','20','(''DA''=''T,'')','EVOYACISA2Z0','3','H','01','87',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EERHD"','21','(''DA''=''T,'')','EVOYACISA2Z0','5','H','01','90',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TKVR"','22','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','95',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EEJT"','23','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','99',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"WRKL"','24','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','103',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"CHGSSN"','25','(''DA''=''T,'')','EVOYACISA2Z0','6','H','01','107',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"PLTP"','26','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BFCLS"','27','(''DA''=''T,'')','EVOYACISA2Z0','5','H','01','117',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"VOYAED"','28','(''DA''=''T,'')','EVOYACISA2Z0','6','H','01','122',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ERPD"','29','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','128',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"EEPD"','30','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','132',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"BTD"','31','(''DA''=''T,'')','EVOYACISA2Z0','3','H','01','136',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"OCED"','32','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','139',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TIER"','33','(''DA''=''T,'')','EVOYACISA2Z0','4','H','01','143',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"SINFO"','34','(''DA''=''T,'')','EVOYACISA2Z0','5','H','01','147',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"TOB"','35','(''DA''=''T,'')','EVOYACISA2Z0','3','H','01','152',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Disability Indicator"','36','(''DA''=''T,'')','EVOYACISA2Z0','20','H','01','155',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"Address Country"','37','(''DA''=''T'')','EVOYACISA2Z0','15','H','01','175',NULL,'',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGBPID"','1','(''UA''=''T,'')','EVOYACISA2Z0','8','D','02','1',NULL,'GBPID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvACCT"','2','(''UA''=''T,'')','EVOYACISA2Z0','4','D','02','9',NULL,'ACCT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEID"','3','(''UA''=''T,'')','EVOYACISA2Z0','9','D','02','13',NULL,'EEID',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvREL"','4','(''UA''=''T,'')','EVOYACISA2Z0','2','D','02','22',NULL,'REL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','5','(''UA''=''T,'')','EVOYACISA2Z0','9','D','02','24',NULL,'SSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvLASTNM"','6','(''UA''=''T,'')','EVOYACISA2Z0','30','D','02','33',NULL,'LASTNM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFIRSTNM"','7','(''UA''=''T,'')','EVOYACISA2Z0','20','D','02','63',NULL,'FIRSTNM',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMIDDLE"','8','(''UA''=''T,'')','EVOYACISA2Z0','10','D','02','83',NULL,'MIDDLE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNMSUFFIX"','9','(''UA''=''T,'')','EVOYACISA2Z0','10','D','02','93',NULL,'NMSUFFIX',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADD1"','10','(''UA''=''Q,'')','EVOYACISA2Z0','30','D','02','103',NULL,'ADD1',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvADD2"','11','(''UA''=''Q,'')','EVOYACISA2Z0','30','D','02','133',NULL,'ADD2',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCITY"','12','(''UA''=''Q,'')','EVOYACISA2Z0','30','D','02','163',NULL,'CITY',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvST"','13','(''UA''=''Q,'')','EVOYACISA2Z0','2','D','02','193',NULL,'ST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvZIP"','14','(''UA''=''Q,'')','EVOYACISA2Z0','9','D','02','195',NULL,'ZIP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDOB"','15','(''UDMDY''=''T,'')','EVOYACISA2Z0','8','D','02','204',NULL,'DOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGENDER"','16','(''UA''=''T,'')','EVOYACISA2Z0','1','D','02','212',NULL,'GENDER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPHONE"','17','(''UA''=''T,'')','EVOYACISA2Z0','13','D','02','213',NULL,'PHONE',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEST"','18','(''UA''=''T,'')','EVOYACISA2Z0','1','D','02','226',NULL,'EEST',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEDOH"','19','(''UDMDY''=''T,'')','EVOYACISA2Z0','8','D','02','227',NULL,'EEDOH',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvETD"','20','(''UDMDY''=''T,'')','EVOYACISA2Z0','8','D','02','235',NULL,'ETD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEERHD"','21','(''UDMDY''=''T,'')','EVOYACISA2Z0','8','D','02','243',NULL,'EERHD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTKVR"','22','(''UA''=''T,'')','EVOYACISA2Z0','1','D','02','251',NULL,'TKVR',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEJT"','23','(''UA''=''Q,'')','EVOYACISA2Z0','30','D','02','252',NULL,'EEJT',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWRKL"','24','(''UA''=''T,'')','EVOYACISA2Z0','10','D','02','282',NULL,'WRKL',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCHGSSN"','25','(''UA''=''T,'')','EVOYACISA2Z0','1','D','02','292',NULL,'CHGSSN',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPLTP"','26','(''UA''=''T,'')','EVOYACISA2Z0','4','D','02','293',NULL,'PLTP',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBFCLS"','27','(''UA''=''T,'')','EVOYACISA2Z0','30','D','02','297',NULL,'BFCLS',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVOYAED"','28','(''UDMDY''=''T,'')','EVOYACISA2Z0','8','D','02','327',NULL,'VOYAED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvERPD"','29','(''UA''=''T,'')','EVOYACISA2Z0','6','D','02','335',NULL,'ERPD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEPD"','30','(''UA''=''T,'')','EVOYACISA2Z0','6','D','02','341',NULL,'EEPD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBTD"','31','(''UDMDY''=''T,'')','EVOYACISA2Z0','8','D','02','347',NULL,'BTD',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOCED"','32','(''UDMDY''=''T,'')','EVOYACISA2Z0','8','D','02','355',NULL,'OCED',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTIER"','33','(''UA''=''T,'')','EVOYACISA2Z0','3','D','02','363',NULL,'TIER',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSINFO"','34','(''UA''=''T,'')','EVOYACISA2Z0','50','D','02','366',NULL,'SINFO',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTOB"','35','(''UA''=''T,'')','EVOYACISA2Z0','3','D','02','416',NULL,'TOB',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisInd"','36','(''UA''=''T,'')','EVOYACISA2Z0','50','D','02','419',NULL,'Disability Indicator',NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCountry"','37','(''UA''=''T'')','EVOYACISA2Z0','20','D','02','469',NULL,'Address Country',NULL,NULL);
/*01*/ DECLARE @COUNTRY char(2) = (SELECT CASE WHEN LEFT(@@SERVERNAME,1) = 'T' THEN 'ca' ELSE 'us' END);
/*02*/ DECLARE @SERVER varchar(6) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' WHEN LEFT(@@SERVERNAME,2) IN ('NW','EW','WP') THEN LEFT(@@SERVERNAME,3) ELSE LEFT(@@SERVERNAME,2) END);
/*03*/ SET @SERVER = CASE WHEN LEFT(@@SERVERNAME,2) IN ('NZ','EZ') THEN @SERVER + '\' + LEFT(@@SERVERNAME,3) ELSE @SERVER END;
/*04*/ DECLARE @UDARNUM varchar(10) = (SELECT LTRIM(RTRIM(CmmContractNo)) FROM dbo.CompMast);
/*05*/ DECLARE @ENVIRONMENT varchar(7) = (SELECT CASE WHEN SUBSTRING(@@SERVERNAME,3,1) = 'D' THEN @UDARNUM WHEN SUBSTRING(@@SERVERNAME,4,1) = 'D' THEN LEFT(@@SERVERNAME,3) + 'Z' ELSE RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)) END);
/*06*/ SET @ENVIRONMENT = CASE WHEN @ENVIRONMENT = 'EW21' THEN 'WP6' WHEN @ENVIRONMENT = 'EW22' THEN 'WP7' ELSE @ENVIRONMENT END;
/*07*/ DECLARE @COCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
/*08*/ DECLARE @FILENAME varchar(1000) = 'EVOYACISA2_20210922.txt';
/*09*/ DECLARE @FILEPATH varchar(1000) = '\\' + @COUNTRY + '.saas\' + @SERVER + '\' + @ENVIRONMENT + '\Downloads\V10\Exports\' + @COCODE + '\EmployeeHistoryExport\';
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'XXXa Active OE file','202107281','EMPEXPORT','ACTIVEOE','Jul 28 2021 12:00AM','EVOYACISA2',NULL,NULL,NULL,'202107281','Jul 28 2021 12:00AM','Dec 30 1899 12:00AM','202107281',NULL,'','','202107281',dbo.fn_GetTimedKey(),NULL,'us3rVaSAF1007',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'XXXa Accident/CI','202108249','EMPEXPORT','EVOYACISA2','Aug 24 2021  1:20PM','EVOYACISA2',NULL,NULL,NULL,'202108249','Aug 24 2021 12:00AM','Dec 30 1899 12:00AM','202003051','313','','','202003051',dbo.fn_GetTimedKey(),NULL,'us3rVaSAF1007',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,'XXXa Passive OE file','202003199','EMPEXPORT','PASSIVEOE',NULL,'EVOYACISA2',NULL,NULL,NULL,'202003199',NULL,NULL,'202003051',NULL,NULL,NULL,'202003051',dbo.fn_GetTimedKey(),NULL,'ULTI',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'','','',NULL,NULL,NULL,'XXXT Voya Accident/CI','202112319','EMPEXPORT','TEST','Sep 20 2021 10:50AM','EVOYACISA2',NULL,NULL,NULL,'202112319','Aug 31 2021 12:00AM','Dec 30 1899 12:00AM','202101011','334','','','202101011',dbo.fn_GetTimedKey(),NULL,'us3rVaSAF1007',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES (RTRIM(@FILEPATH) + LTRIM(RTRIM(@FILENAME)),NULL,'Null','N','XILGW',NULL,NULL,NULL,'XXXA PROD WKLY TUE 5.3 am EST','202005319','EMPEXPORT','VOYACISAF',NULL,'EVOYACISA2',NULL,NULL,NULL,'202107269',NULL,NULL,'202107121',NULL,'','','202005171',dbo.fn_GetTimedKey(),NULL,NULL,NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','ExportDescription','C','Voya - Accident & Critical Illness');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','FileType','C','txt');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','InitialSort','C','drvEEID');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','MaxFileLength','C','2000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','SystemID','V','0865965CE604');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','Testing','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('EVOYACISA2','UseFileName','V','Y');
/*01*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = NULL WHERE FormatCode = 'EVOYACISA2' AND CfgName LIKE '%Path' AND CfgType = 'V'; /* Set paths to NULL for Web Exports */
/*02*/ UPDATE dbo.U_dsi_Configuration SET CfgValue = 'Y'  WHERE FormatCode = 'EVOYACISA2' AND CfgName = 'UseFileName'; /* Set UseFileName to 'Y' for Web Exports */
IF OBJECT_ID('U_EVOYACISA2_SavePath') IS NOT NULL DROP TABLE [dbo].[U_EVOYACISA2_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYACISA2','H01','None',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('EVOYACISA2','D02','dbo.U_dsi_EVOYACISA2_drvTbl',NULL);
IF OBJECT_ID('U_dsi_BDM_EVOYACISA2') IS NULL
CREATE TABLE [dbo].[U_dsi_BDM_EVOYACISA2] (
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
IF OBJECT_ID('U_dsi_EVOYACISA2_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_EVOYACISA2_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvCoID] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvdedcode] char(5) NOT NULL,
    [drvGBPID] varchar(8) NOT NULL,
    [drvACCT] varchar(4) NOT NULL,
    [drvEEIDempNo] char(9) NULL,
    [drvREL] varchar(2) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvLASTNM] varchar(100) NULL,
    [drvFIRSTNM] varchar(100) NULL,
    [drvMIDDLE] varchar(50) NULL,
    [drvNMSUFFIX] varchar(30) NULL,
    [drvADD1] varchar(8000) NULL,
    [drvADD2] varchar(8000) NULL,
    [drvCITY] varchar(8000) NULL,
    [drvST] varchar(255) NULL,
    [drvZIP] varchar(50) NULL,
    [drvDOB] varchar(8000) NULL,
    [drvGENDER] char(1) NULL,
    [drvPHONE] varchar(50) NULL,
    [drvEEST] varchar(1) NOT NULL,
    [drvEEDOH] varchar(8000) NULL,
    [drvETD] varchar(8000) NULL,
    [drvEERHD] varchar(8000) NULL,
    [drvTKVR] varchar(1) NOT NULL,
    [drvEEJT] varchar(1) NOT NULL,
    [drvWRKL] varchar(10) NULL,
    [drvCHGSSN] varchar(1) NOT NULL,
    [drvPLTP] varchar(2) NOT NULL,
    [drvBFCLS] varchar(1) NOT NULL,
    [drvVOYAED] varchar(8000) NULL,
    [drvERPD] varchar(1) NOT NULL,
    [drvEEPD] varchar(30) NULL,
    [drvBTD] varchar(8000) NULL,
    [drvOCED] varchar(1) NOT NULL,
    [drvTIER] varchar(3) NOT NULL,
    [drvSINFO] varchar(2) NULL,
    [drvTOB] varchar(3) NOT NULL,
    [drvDisInd] varchar(1) NOT NULL,
    [drvCountry] varchar(13) NOT NULL
);
IF OBJECT_ID('U_EVOYACISA2_Audit') IS NULL
CREATE TABLE [dbo].[U_EVOYACISA2_Audit] (
    [audEEID] varchar(255) NOT NULL,
    [audCOID] varchar(255) NOT NULL,
    [audDedCode] varchar(255) NOT NULL,
    [audTableName] varchar(128) NOT NULL,
    [audFieldName] varchar(128) NOT NULL,
    [audAction] varchar(6) NOT NULL,
    [audDateTime] datetime NOT NULL,
    [audOldValue] varchar(2000) NULL,
    [audNewValue] varchar(2000) NULL,
    [audRowNo] bigint NULL
);
IF OBJECT_ID('U_EVOYACISA2_AuditFields') IS NULL
CREATE TABLE [dbo].[U_EVOYACISA2_AuditFields] (
    [aTableName] varchar(30) NULL,
    [aFieldName] varchar(30) NULL
);
IF OBJECT_ID('U_EVOYACISA2_DedList') IS NULL
CREATE TABLE [dbo].[U_EVOYACISA2_DedList] (
    [DedCode] char(5) NOT NULL,
    [DedType] char(4) NOT NULL
);
IF OBJECT_ID('U_EVOYACISA2_DepList') IS NULL
CREATE TABLE [dbo].[U_EVOYACISA2_DepList] (
    [deeid] char(12) NOT NULL,
    [ddepid] char(12) NOT NULL
);
IF OBJECT_ID('U_EVOYACISA2_EEList') IS NULL
CREATE TABLE [dbo].[U_EVOYACISA2_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_EVOYACISA2_File') IS NULL
CREATE TABLE [dbo].[U_EVOYACISA2_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2000) NULL
);
GO
CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_EVOYACISA2]
 @systemid varchar(12) = ''
AS
Begin

/**********************************************************************
Client Name: SAFE Federal Credit Union
Vendor: Voya Accident & Critical illness File (CSV)
Created By: Tony DiMaio
Business Analyst: Bettye Haynes
Create Date: 01/17/2020
Service Request Number: SF 00258977

Changes:
MM/DD/YYYY        INITIALS    NAME HERE            SF 09999999                    Comments Here
07/28/2021        KJM            Keary McCutchen        SR-2021-00315460            Add Logic to Send Terms 1 time.
                                                TekP-2021-05-19-0004

_dsi_usp_ExportRipout 'EVOYACISA2','Y' 

select * from dbo.U_dsi_Configuration where FormatCode = 'EVOYACISA2' ORDER BY LEN(CfgName) DESC
select * from dbo.U_dsi_SQLClauses where FormatCode = 'EVOYACISA2'
select * from dbo.U_dsi_Parameters where FormatCode = 'EVOYACISA2'
SELECT * FROM dbo.U_dsi_InterfaceActivityLog WHERE FormatCode = 'EVOYACISA2' ORDER BY RunID DESC;

select * from AscDefH where AdhFormatCode = 'EVOYACISA2'
select * from AscExp where expFormatCode = 'EVOYACISA2'
select * from ascdeff where AdfHeaderSystemID = 'EVOYACISA2Z0' order by adfrectype, AdfSetNumber, AdfFieldNumber 

DSI_SP_TESTSWITCHBOX_V2 'EVOYACISA2', 'EVOYACISA2'
DSI_SP_TESTSWITCHBOX_V2 'EVOYACISA2', 'TEST'

To turn off/on TESTEDT header record: 
Update U_Dsi_Configuration set CfgValue = 'N' WHERE FormatCode = 'EVOYACISA2' AND CfgName = 'TESTING'

**************************/


-- Collect the @Start and @End Percontrol/PayDates upfront

    /***************************
    COLLECT DATE PARAMETERS
    ****************************/
    DECLARE 
        @StartDate DATETIME,
        @EndDate DATETIME,
        @StartPerControl Char(9),
        @EndPerControl Char(9),
        @FormatCode Char(10),
        @ExportCode Char(10),
        @ExportFile char(200),
        @PlanDate DATETIME;

    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

        -- Set FormatCode
    SELECT @FormatCode = 'EVOYACISA2';

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile,
        @PlanDate = convert(varchar(4), year(@EndDate)) + '0101'--'20180101' 

    FROM dbo.U_Dsi_Parameters 
    WHERE formatcode = @FormatCode;


-- change variables below as needed
declare @daysstopped int;   
declare @useaudit char(1);
declare @includeoe char(1);

declare @showalldeds char(1);
declare @allcomp char(1);
declare @onerecperemp char(1);
declare @showstoppedoe  char(1);
declare @oetype char(1);
set @daysstopped = 14;    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y';    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N';   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N'; -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y';     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y';  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N'; -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F';        -- P or F indicates if this export is for a passive or full(active) oe


---- clean up EELIST if needed

----REMOVED KJM 7/28/2021
---- clean up list if not using all companies
----if @allcomp = 'N'
----begin
--            --delete dbo.u_EVOYACISA2_EELIST
--            --from dbo.u_EVOYACISA2_EELIST
--            --join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
--            --where t.eecemplstatus = 'T'
--            --and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
--            --    and a.eecemplstatus <> 'T');
----end;

----BDM
---- replace OE with the OE session if applicable

--DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode;

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','PACCI,CIIEE,CIISP,CIICH')  
  
--IF @ExportCode not in ('ACTIVEOE','PASSIVEOE') BEGIN
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate/* @EndDate - @daysstopped*/);    --@EndDate - @daysstopped)
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
--END;
--IF @ExportCode in ('ACTIVEOE','PASSIVEOE') BEGIN
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate);
--    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate);
--END;

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption','StopDate');        -- 'stopdate');    --'ActiveOnly')    --'stopdate')

--INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'GetChangeReason','Y');


--IF @ExportCode = 'PASSIVEOE' BEGIN
--   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive');
--END;
--IF @ExportCode = 'ACTIVEOE' BEGIN
--   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active');
--END;

--EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode;

--EXEC dbo.dsi_bdm_sp_CalculateBenefitAmounts @FormatCode;
    --==========================================
    -- Create Deduction List
    --==========================================
    DECLARE @DedList VARCHAR(MAX)
    SET @DedList =' PACCI,CIIEE,CIISP,CIICH';

    IF OBJECT_ID('U_EVOYACISA2_DedList','U') IS NOT NULL
        DROP TABLE dbo.U_EVOYACISA2_DedList;
    SELECT DISTINCT
         DedCode = DedDedCode
        ,DedType = DedDedType
    INTO dbo.U_EVOYACISA2_DedList
    FROM dbo.fn_ListToTable(@DedList)
    JOIN dbo.DedCode WITH (NOLOCK)
        ON DedDedCode = Item;

    --==========================================
    -- BDM Section KJM
    --==========================================
    DELETE FROM dbo.U_dsi_BDM_Configuration WHERE FormatCode = @FormatCode;

    -- Required parameters
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'DedCodes',@DedList);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'StartDateTime',@StartDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'EndDateTime',@EndDate);
    INSERT INTO dbo.U_dsi_BDM_Configuration VALUES(@FormatCode,'TermSelectionOption','AuditDate');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStartDateDays', '120');
    INSERT INTO dbo.U_dsi_bdm_Configuration VALUES (@FormatCode, 'FutureDatedStopDateDays', '120');

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
 

-- Step20 Clean up eelist if needed to only include employees with deductions
            delete dbo.u_EVOYACISA2_eelist
            from dbo.u_EVOYACISA2_eelist a
            where not exists(select 1 from U_dsi_bdm_EmpDeductions
                            where a.xeeid = eedeeid
                            and a.xcoid = eedcoid
                            and eedformatcode = @formatcode
                            and eedvalidforexport = 'Y'
                            );
                
-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            --UPDATED 7/28/2021 KJM
            --delete dbo.u_EVOYACISA2_EELIST
            --from dbo.u_EVOYACISA2_EELIST
            --join vw_int_EmpComp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            --where t.eecemplstatus = 'T'
            --and exists(select 1 from vw_int_EmpComp a where a.eeceeid = t.eeceeid
            --    and a.eecemplstatus <> 'T');

            delete dbo.u_EVOYACISA2_eelist
            from dbo.u_EVOYACISA2_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_EVOYACISA2_eelist b where a.xeeid = b.xeeid
            having count(*) > 1);


             
end;

update U_dsi_bdm_EmpDeductions
set EedBenAmt = bcabenamt
from U_dsi_bdm_EmpDeductions
join U_dsi_bdm_BenCalculationAmounts on EedEEID = bcaeeid and EedCoID = bcacoid
and EedDedCode = bcadedcode and EedFormatCode = bcaformatcode
and BcaDepRecID is null
where EedFormatCode = @FormatCode and EedValidForExport = 'Y';

-- Populate Source for Employees

if object_id('U_dsi_EVOYACISA2_drvTbl') is not null
  drop table dbo.U_dsi_EVOYACISA2_drvTbl;

-- EE Detail

  select distinct
     drvEEID = xEEID
    ,drvCoID = xCoID
    ,drvdepid = cast(null as varchar)
    ,drvrectype = 'E'
    ,drvdedcode = EedDedCode
-- standard fields above and additional driver fields below
    ,drvGBPID = '00681059'
    ,drvACCT = '0001'
    ,drvEEIDempNo = EecEmpNo
    ,drvREL = 'EE'
    ,drvSSN = EepSSN
    ,drvLASTNM = EepNameLast
    ,drvFIRSTNM = EepNameFirst
    ,drvMIDDLE = EepNameMiddle
    ,drvNMSUFFIX = NULLIF(EepNameSuffix,'Z')
    ,drvADD1 = replace(EepAddressLine1,',','')
    ,drvADD2 = replace(EepAddressLine2,',','')
    ,drvCITY = replace(EepAddressCity,',','')
    ,drvST = EepAddressState
    ,drvZIP = EepAddressZipCode
    ,drvDOB = replace(convert(varchar(10),EepDateOfBirth,101),'/','')
    ,drvGENDER = EepGender
    ,drvPHONE = eepPhoneHomeNumber
    ,drvEEST = case when EecEmplStatus = 'T' then 'T' else 'A' end 
    ,drvEEDOH = replace(convert(varchar(10),EecDateOfLastHire,101),'/','')
    ,drvETD = case when EecEmplStatus = 'T' then replace(convert(varchar(10),EecDateOfTermination,101),'/','') end 
    ,drvEERHD = case when EecDateOfOriginalHire <> EecDateOfLastHire  then replace(convert(varchar(10),EecDateOfLastHire,101),'/','') end
    ,drvTKVR = 'N'
    ,drvEEJT = '' --Leave Blank 
    ,drvWRKL = isnull(eecOrgLvl2,eecOrgLvl3) --UD Spec: send org3 when org2 is null
    ,drvCHGSSN = ''    
    ,drvPLTP = Case When eeddedcode='PACCI' then 'AC' else 'CI' end
    ,drvBFCLS =  ''--Leave Blank
    --,drvVOYAED = Case when EedBenStartDate < @PlanDate then @PlanDate else replace(convert(varchar(10),EedBenStartDate,101),'/','') end 
    ,drvVOYAED = replace(convert(varchar(10),Case when EedBenStartDate < @PlanDate then @PlanDate else EedBenStartDate end,101),'/','') 
    ,drvERPD = ''
    ,drvEEPD =     --Field 30 = coverage amount (hard coded per structure document):
                 cast(case 
                            when EedDedCode = 'CIICH' and eedBenOption = '1K' then '1000.00'
                            when EedDedCode = 'CIICH' and eedBenOption = '2K5' then '2500.00'
                            when EedDedCode = 'CIICH' and eedBenOption = '5K' then '5000.00'
                            when EedDedCode = 'CIICH' and eedBenOption = '10K' then '10000.00'
                            when EedDedCode = 'PACCI' then NULL --leave blank (not 0.00) for Accident records
                      else case when eedBenAmt > 0 then eedBenAmt else DedEEBenAmt end
                      end as varchar)
    ,drvBTD = case when eedbenStatus ='T' and isnull(eedbenstopdate,'') <> '' then replace(convert(varchar(10),EOMONTH(EedBenStopDate),101),'/','')  end
    ,drvOCED = ''
    ,drvTIER =  case when EedDedCode IN ('PACCI') and eedBenOption in ('EE') then 'EMP'
                     when EedDedCode IN ('PACCI') and eedBenOption in ('EEC') then 'ECH'
                     when EedDedCode IN ('PACCI') and eedBenOption in ('EES') then 'ESP'
                     when EedDedCode IN ('PACCI') and eedBenOption in ('EEF') then 'FAM'
                     when EedDedCode IN ('CIISP') then 'ESP'
                     when EedDedCode IN ('CIICH') then 'ECH'       
                     when EedDedCode IN ('CIIEE') then 'EMP'       
                 else '' end
    ,drvSINFO = case eecpayperiod
                     when 'W' then '52'
                     when 'S' then '24'
                     when 'B' then '26'
                     when 'M' then '12'
                end
    ,drvTOB = case  when eedDedCode = 'CIIEE' and eepIsSmoker = 'Y' then 'Y'
                    when eedDedCode = 'CIIEE' and eepIsSmoker = 'N' then 'N'
              else 'N/A' end 
    ,drvDisInd = '' 
    ,drvCountry = 'United States'

  into dbo.U_dsi_EVOYACISA2_drvTbl
  from dbo.u_EVOYACISA2_eelist with (nolock)
    join empPers with (nolock) on xEEID = eepEEID
    join vw_int_EmpComp with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join JobCode with (nolock) on JbcJobCode = EecJobCode
    JOIN dbo.U_dsi_bdm_EmpDeductions ON EedFormatCode = @FormatCode
            AND EedValidForExport = 'Y' 
            and eeddedcode in ('PACCI','CIIEE') --only send DEP record for SP and CH 'CI' --,'CIISP','CIICH') 
            AND EedCOID = xCOID AND EedEEID = xEEID 

   --left join (select eedeeid eeid, eedcoid coid, SUM(eedbenamt) benamt
   --             from U_dsi_bdm_EmpDeductions
   --             where EedFormatCode = @FormatCode
   --                 AND EedValidForExport = 'Y' 
   --                 and EedDedCode in ('PACCI')
            --     group by EedEEID, EedCoID) acamt on acamt.eeid = xEEID and acamt.coid = xCOID
   -- left join (select eedeeid eeid, eedcoid coid, SUM(eedbenamt) benamt
   --             from U_dsi_bdm_EmpDeductions
   --             where EedFormatCode = @FormatCode
   --                 AND EedValidForExport = 'Y' 
   --                 and EedDedCode in ('CIIEE')
   --             group by EedEEID, EedCoID) eeamt on eeamt.eeid = xEEID and eeamt.coid = xCOID
   -- left join (select eedeeid eeid, eedcoid coid, SUM(eedbenamt) benamt
   --             from U_dsi_bdm_EmpDeductions
   --             where EedFormatCode = @FormatCode
   --                 AND EedValidForExport = 'Y' 
   --                 and EedDedCode in ('CIISP')
   --             group by EedEEID, EedCoID) spamt on spamt.eeid = xEEID and spamt.coid = xCOID
   -- left join (select eedeeid eeid, eedcoid coid, SUM(eedbenamt) benamt
   --             from U_dsi_bdm_EmpDeductions
   --             where EedFormatCode = @FormatCode
   --                 AND EedValidForExport = 'Y' 
   --                 and EedDedCode in ('CIISP')
   --             group by EedEEID, EedCoID) chamt on chamt.eeid = xEEID and chamt.coid = xCOID



-- Dependents

--deps with extra active benefits that the emp doens't have
update dbo.U_dsi_bdm_DepDeductions  
set dbnvalidforexport = 'N'
from dbo.U_dsi_bdm_DepDeductions D
join contacts on consystemid = dbndeprecid
join emppers on eepeeid = dbneeid
join dbo.u_EVOYACISA2_EELIST on xeeid = dbneeid
where dbnformatcode = @FormatCode
AND dbnvalidforexport = 'y'
and not exists (select 1 from dbo.U_dsi_bdm_EmpDeductions 
                where eedformatcode = @FormatCode
                and eedvalidforexport = 'y'
                and eedeeid = dbneeid
                and eeddedcode = dbndedcode);

-- Build Dependent List
if object_id('dbo.U_EVOYACISA2_DepList') is not null
  drop table dbo.U_EVOYACISA2_DepList;

select distinct dbneeid deeid, dbndeprecid ddepid
into dbo.U_EVOYACISA2_DepList 
from U_dsi_bdm_DepDeductions with (nolock)
where DbnFormatCode = @FormatCode
and dbnvalidforexport = 'Y';


-- Build Dependent List

insert into dbo.U_dsi_EVOYACISA2_drvTbl 
  select distinct 
    drvEEID = deeid 
    ,drvcoid = ''
    ,drvdepid = cast(null as varchar)
    ,drvrectype = 'D'
    ,drvdedcode = dbndedcode
-- standard fields above and additional driver fields below
    ,drvGBPID = '00681059'
    ,drvACCT = '0001'
    ,drvEEIDempNo = EecEmpNo
    ,drvREL = case    when ConRelationShip in ('SPS','DP') then 'SP'
                    when ConRelationShip in ('CHL','DPC','STC','DCH') then 'CH'
              else '' end
    ,drvSSN = Case when LEFT(ConSSN,5) not in ('00000','99999') then ConSSN else '' end
    ,drvLASTNM = dbo.dsi_fnRemoveChars(',',ConNameLast)
    ,drvFIRSTNM = dbo.dsi_fnRemoveChars(',',ConNameFirst)
    ,drvMIDDLE = dbo.dsi_fnRemoveChars(',',ConNameMiddle)
    ,drvNMSUFFIX = case when ConNameSuffix = 'Z' then '' else dbo.dsi_fnRemoveChars(',',ConNameSuffix) end
    ,drvADD1 = dbo.dsi_fnRemoveChars(',',isnull(ConAddressLine1,EepAddressLine1))
    ,drvADD2 = dbo.dsi_fnRemoveChars(',',isnull(ConAddressLine2,EepAddressLine2))
    ,drvCITY = dbo.dsi_fnRemoveChars(',',isnull(ConAddressCity,EepAddressCity))
    ,drvST = dbo.dsi_fnRemoveChars(',',isnull(ConAddressState,EepAddressState))
    ,drvZIP = isnull(ConAddressZipCode,EepAddressZipCode)
    ,drvDOB = replace(convert(varchar(10),ConDateOfBirth,101),'/','')
    ,drvGENDER = ConGender
    ,drvPHONE = ConPhoneHomeNumber
    ,drvEEST = ''
    ,drvEEDOH = ''
    ,drvETD = ''
    ,drvEERHD = ''
    ,drvTKVR = 'N'
    ,drvEEJT = ''
    ,drvWRKL = ''
    ,drvCHGSSN = ''    
    ,drvPLTP = Case When dbndedcode='PACCI' then 'AC' else 'CI' end
    ,drvBFCLS =  ''--Leave Blank
    ,drvVOYAED = replace(convert(varchar(10),Case when DbnBenStartDate < @PlanDate then @PlanDate else DbnBenStartDate end,101),'/','') 
    ,drvERPD = ''
    ,drvEEPD =     --Field 30 = coverage amount (hard coded per structure document):
                 cast(case 
                            when DbnDedCode = 'CIICH' and DbnBenOption = '1K' then '1000.00'
                            when DbnDedCode = 'CIICH' and DbnBenOption = '2K5' then '2500.00'
                            when DbnDedCode = 'CIICH' and DbnBenOption = '5K' then '5000.00'
                            when DbnDedCode = 'CIICH' and DbnBenOption = '10K' then '10000.00'
                            when DbnDedCode = 'CIISP' then case when spci.benamt > 0 then spci.benamt else DedEEBenAmt end
                            when DbnDedCode = 'PACCI' then NULL --leave blank (not 0.00) for Accident records
                 end as varchar)

    ,drvBTD =   replace(convert(varchar(10),DbnBenStopDate,101),'/','') 
    ,drvOCED = ''
    ,drvTIER =  case when DbnDedCode IN ('CRTCH','CRTSP') then '' --Leave blank for CRTEE, CRTCH & CRTSP
                          when DbnBenOption in ('EE') then 'EMP' 
                          when DbnBenOption in ('EEC') then 'ECH' 
                          when DbnBenOption in ('EES') then 'ESP'
                          when DbnBenOption in ('EEF') then 'FAM'
                     else '' end
    ,drvSINFO = ''
    --,drvTOB = CONVERT(VARCHAR,case when ConIsSmoker = 'Y' then 'Y' else 'N' end)
    ,drvTOB = case  when DbnDedCode = 'CIISP' and conIsSmoker = 'Y' then 'Y' --UD Spec: only for spouse CIISP
                    when DbnDedCode = 'CIISP' and conIsSmoker = 'N' then 'N'
              else 'N/A' end 

    ,drvDisInd = case when conisdisabled = 'Y' then --'Disabled' (only if dep is 26 or older):
                      case when (datediff(yy,eepdateofbirth,getdate()) - case when 100 * month(getdate()) < 100 * month(eepdateofbirth) then 1 else 0 end) >=26 then 'Disabled'
                      else '' end
                 else '' end
    ,drvCountry = 'United States'

from dbo.U_EVOYACISA2_DepList
    join emppers on deeid = eepeeid
    join vw_int_EmpComp on deeid = eeceeid
    join contacts on coneeid = deeid and consystemid = ddepid and conrelationship in ('SPS','DP','CHL','DPC','STC','DCH') --TD 4/21/20 only send spouse and child relationship dependents 
    join dbo.U_dsi_bdm_DepDeductions on DbnFormatCode = @FormatCode
        and DbnValidForExport = 'Y' and dbndedcode in ('PACCI','CIISP','CIICH') 
        and DbnEEID = deeid and DbnDepRecID = ddepid
    left join (select eedeeid eeid, eedcoid coid, eedbenamt benamt
                from U_dsi_bdm_EmpDeductions
                where EedFormatCode = @FormatCode
                    AND EedValidForExport = 'Y' 
                    and EedDedCode in ('CIISP') ) spci on spci.eeid = deeid

    left  join U_dsi_bdm_BenCalculationAmounts on DbnEEID = bcaeeid and DbnCoID = bcacoid
        and DbnDedCode = bcadedcode and DbnFormatCode = bcaformatcode
        and BcaDepRecID is NULL    
    left join U_dsi_EVOYACISA2_drvTbl on drvEEID = DbnEEID and drvdedcode = DbnDedCode
    where DbnFormatCode = @FormatCode and DbnValidForExport = 'Y'

-- Set FileName 
/* 
--if (dbo.dsi_fnVariable('EVOYACISA2','UseFileName') = 'N')
--  update dbo.U_dsi_Parameters
--    set ExportFile =  'ISCO_VOYA_AccidentCI' + convert(char(8),getdate(),112) + '.csv'
--    where FormatCode = 'EVOYACISA2';

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwEVOYACISA2_Export as
        select top 2000000 rtrim(Data) as Data
        from dbo.U_EVOYACISA2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 else 3 end,
            initialsort, subsort, substring(Recordset,2,2)

select expformatcode, expexportcode, expstartpercontrol, expendpercontrol, *
from ascexp where expformatcode = 'EVOYACISA2'
*/

--Used for testing
dbo.dsi_sp_testswitchbox_v2 'EVOYACISA2','EVOYACISA2'
dbo.dsi_sp_testswitchbox_v2 'EVOYACISA2','ACTIVEOE'
dbo.dsi_sp_testswitchbox_v2 'EVOYACISA2','PASSIVEOE'
dbo.dsi_sp_testswitchbox_v2 'EVOYACISA2','TEST'

--Update Dates
UPDATE dbo.AscExp
    SET expLastStartPerControl = '202107011'
       ,expStartPerControl     = '202107011'
       ,expLastEndPerControl   = '202107199'
       ,expEndPerControl       = '202107199'
WHERE expFormatCode = 'EVOYACISA2' and expExportCode = 'TEST';
*/
END
GO
CREATE  View dbo.dsi_vwEVOYACISA2_Export as
        select top 2000000 rtrim(Data) as Data
        from dbo.U_EVOYACISA2_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 else 3 end,
            initialsort, subsort, substring(Recordset,2,2)