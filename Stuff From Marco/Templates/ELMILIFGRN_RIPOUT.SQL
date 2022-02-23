SET NOCOUNT ON;
SELECT FormatCode svFormatCode, CfgName svCfgName, CfgValue svCfgValue INTO dbo.U_ELMILIFGRN_SavePath FROM dbo.U_dsi_Configuration WITH (NOLOCK) WHERE FormatCode = 'ELMILIFGRN' AND CfgName LIKE '%Path';
IF OBJECT_ID('dsi_vwELMILIFGRN_Export') IS NOT NULL DROP VIEW [dbo].[dsi_vwELMILIFGRN_Export];
GO
IF OBJECT_ID('dsi_sp_BuildDriverTables_ELMILIFGRN') IS NOT NULL DROP PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELMILIFGRN];
GO
IF OBJECT_ID('U_ELMILIFGRN_File') IS NOT NULL DROP TABLE [dbo].[U_ELMILIFGRN_File];
GO
IF OBJECT_ID('U_ELMILIFGRN_EEList') IS NOT NULL DROP TABLE [dbo].[U_ELMILIFGRN_EEList];
GO
IF OBJECT_ID('U_dsi_ELMILIFGRN_trlTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELMILIFGRN_trlTbl];
GO
IF OBJECT_ID('U_dsi_ELMILIFGRN_hdrTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELMILIFGRN_hdrTbl];
GO
IF OBJECT_ID('U_dsi_ELMILIFGRN_drvTbl') IS NOT NULL DROP TABLE [dbo].[U_dsi_ELMILIFGRN_drvTbl];
GO
IF OBJECT_ID('U_ds_ELMILIFGRN_EarnHist') IS NOT NULL DROP TABLE [dbo].[U_ds_ELMILIFGRN_EarnHist];
GO
DELETE [dbo].[U_dsi_SQLClauses] FROM [dbo].[U_dsi_SQLClauses] WHERE FormatCode = 'ELMILIFGRN';
DELETE [dbo].[U_dsi_Configuration] FROM [dbo].[U_dsi_Configuration] WHERE FormatCode = 'ELMILIFGRN';
DELETE [dbo].[AscExp] FROM [dbo].[AscExp] WHERE expFormatCode = 'ELMILIFGRN';
DELETE [dbo].[AscDefF] FROM [dbo].[AscDefF] JOIN AscDefH ON AdfHeaderSystemID = AdhSystemID WHERE AdhFormatCode = 'ELMILIFGRN';
DELETE [dbo].[AscDefH] FROM [dbo].[AscDefH] WHERE AdhFormatCode = 'ELMILIFGRN';
INSERT INTO [dbo].[AscDefH] (AdhAccrCodesUsed,AdhAggregateAtLevel,AdhAuditStaticFields,AdhChildTable,AdhClientTableList,AdhCustomDLLFileName,AdhDedCodesUsed,AdhDelimiter,AdhEarnCodesUsed,AdhEEIdentifier,AdhEndOfRecord,AdhEngine,AdhFileFormat,AdhFormatCode,AdhFormatName,AdhFundCodesUsed,AdhImportExport,AdhInputFormName,AdhIsAuditFormat,AdhIsSQLExport,AdhModifyStamp,AdhOutputMediaType,AdhPreProcessSQL,AdhRecordSize,AdhSortBy,AdhSysFormat,AdhSystemID,AdhTaxCodesUsed,AdhYearStartFixedDate,AdhYearStartOption,AdhRespectZeroPayRate,AdhCreateTClockBatches,AdhThirdPartyPay) VALUES ('N','C','Y','0',NULL,NULL,'N',NULL,'N',NULL,'013010','EMPEXPORT','SDF','ELMILIFGRN','Liberty Mutual - STD/LTD/FMLA','N','E','FORM_EMPEXPORT','N','C',dbo.fn_GetTimedKey(),'D','dbo.dsi_sp_Switchbox_v2','2999','S','N','0C5548630380','N','Jan  6 2016 10:46AM','C','N',NULL,'N');
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCustID"','1','(''UA''=''F'')','0C5548630380','9','H','01','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"DrvRecordNo"','2','(''UA''=''F'')','0C5548630380','7','H','01','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFileDate"','3','(''UD112''=''F'')','0C5548630380','10','H','01','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecLength"','4','(''UA''=''F'')','0C5548630380','7','H','01','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','5','(''SS''=''F'')','0C5548630380','2965','H','01','34',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvRecordType"','1','(''UA''=''F'')','0C5548630380','1','D','02','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAccountNo"','2','(''UA''=''F'')','0C5548630380','6','D','02','2',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvVerification"','3','(''UA''=''F'')','0C5548630380','6','D','02','8',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisabilityID"','4','(''UA''=''F'')','0C5548630380','9','D','02','14',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','5','(''SS''=''F'')','0C5548630380','30','D','02','23',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','6','(''SS''=''F'')','0C5548630380','30','D','02','53',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','7','(''SS''=''F'')','0C5548630380','30','D','02','83',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','8','(''SS''=''F'')','0C5548630380','30','D','02','113',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','9','(''SS''=''F'')','0C5548630380','30','D','02','143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','10','(''SS''=''F'')','0C5548630380','30','D','02','173',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','11','(''SS''=''F'')','0C5548630380','30','D','02','203',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','12','(''SS''=''F'')','0C5548630380','30','D','02','233',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','13','(''SS''=''F'')','0C5548630380','30','D','02','263',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','14','(''SS''=''F'')','0C5548630380','30','D','02','293',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWCLoc"','15','(''UA''=''F'')','0C5548630380','30','D','02','323',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSubCode"','16','(''UA''=''F'')','0C5548630380','4','D','02','353',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgI"','17','(''UA''=''F'')','0C5548630380','30','D','02','357',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOrgII"','18','(''UA''=''F'')','0C5548630380','30','D','02','387',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDivCode"','19','(''UA''=''F'')','0C5548630380','10','D','02','417',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeptCode"','20','(''UA''=''F'')','0C5548630380','10','D','02','427',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPosition"','21','(''UA''=''F'')','0C5548630380','10','D','02','437',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisContactType"','22','(''UA''=''F'')','0C5548630380','1','D','02','447',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisNameFirst"','23','(''UA''=''F'')','0C5548630380','35','D','02','448',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisNameLast"','24','(''UA''=''F'')','0C5548630380','35','D','02','483',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisNameSuffix"','25','(''UA''=''F'')','0C5548630380','5','D','02','518',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisAddress1"','26','(''UA''=''F'')','0C5548630380','30','D','02','523',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisAddress2"','27','(''UA''=''F'')','0C5548630380','30','D','02','553',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisCity"','28','(''UA''=''F'')','0C5548630380','20','D','02','583',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisState"','29','(''UA''=''F'')','0C5548630380','2','D','02','603',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisZIP"','30','(''UA''=''F'')','0C5548630380','9','D','02','605',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisCountry"','31','(''UA''=''F'')','0C5548630380','3','D','02','614',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisEmail"','32','(''UA''=''F'')','0C5548630380','100','D','02','617',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisPhoneArea"','33','(''UA''=''F'')','0C5548630380','3','D','02','717',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisPhoneExchange"','34','(''UA''=''F'')','0C5548630380','3','D','02','720',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisPhoneRange"','35','(''UA''=''F'')','0C5548630380','4','D','02','723',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisPhoneExt"','36','(''UA''=''F'')','0C5548630380','8','D','02','727',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupvFirst"','37','(''UA''=''F'')','0C5548630380','35','D','02','735',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupvLast"','38','(''UA''=''F'')','0C5548630380','35','D','02','770',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupvMI"','39','(''UA''=''F'')','0C5548630380','1','D','02','805',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupvSuffix"','40','(''UA''=''F'')','0C5548630380','5','D','02','806',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupvPhoneArea"','41','(''UA''=''F'')','0C5548630380','3','D','02','811',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupvPhoneExchange"','42','(''UA''=''F'')','0C5548630380','3','D','02','814',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSupvPhoneRange"','43','(''UA''=''F'')','0C5548630380','4','D','02','817',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpNo"','44','(''UA''=''F'')','0C5548630380','11','D','02','821',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEEState"','45','(''UA''=''F'')','0C5548630380','2','D','02','832',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisLocCode"','46','(''UA''=''F'')','0C5548630380','8','D','02','834',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDeptName"','47','(''UA''=''F'')','0C5548630380','15','D','02','842',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationCode"','48','(''UA''=''F'')','0C5548630380','4','D','02','857',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvOccupationDesc"','49','(''UA''=''F'')','0C5548630380','50','D','02','861',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhysDemands"','50','(''UA''=''F'')','0C5548630380','1','D','02','911',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameFirst"','51','(''UA''=''F'')','0C5548630380','35','D','02','912',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameLast"','52','(''UA''=''F'')','0C5548630380','35','D','02','947',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameMI"','53','(''UA''=''F'')','0C5548630380','1','D','02','982',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNameSuffix"','54','(''UA''=''F'')','0C5548630380','5','D','02','983',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress1"','55','(''UA''=''F'')','0C5548630380','30','D','02','988',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddress2"','56','(''UA''=''F'')','0C5548630380','30','D','02','1018',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCity"','57','(''UA''=''F'')','0C5548630380','20','D','02','1048',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressState"','58','(''UA''=''F'')','0C5548630380','2','D','02','1068',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressZIP"','59','(''UA''=''F'')','0C5548630380','9','D','02','1070',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountry"','60','(''UA''=''F'')','0C5548630380','3','D','02','1079',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAddressCountryName"','61','(''UA''=''F'')','0C5548630380','30','D','02','1082',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneArea"','62','(''UA''=''F'')','0C5548630380','3','D','02','1112',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneExchange"','63','(''UA''=''F'')','0C5548630380','3','D','02','1115',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvPhoneRange"','64','(''UA''=''F'')','0C5548630380','4','D','02','1118',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSN"','65','(''UA''=''F'')','0C5548630380','11','D','02','1122',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSSNType"','66','(''UA''=''F'')','0C5548630380','1','D','02','1133',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvGender"','67','(''UA''=''F'')','0C5548630380','1','D','02','1134',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfBirth"','68','(''UD112''=''F'')','0C5548630380','8','D','02','1135',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalCode"','69','(''UA''=''F'')','0C5548630380','1','D','02','1143',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMaritalTaxCode"','70','(''UA''=''F'')','0C5548630380','1','D','02','1144',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSpouseBirthdate"','71','(''UA''=''F'')','0C5548630380','8','D','02','1145',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDependentCount"','72','(''UA''=''F'')','0C5548630380','2','D','02','1153',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDepsUnder18Count"','73','(''UA''=''F'')','0C5548630380','2','D','02','1155',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEducationLevel"','74','(''UA''=''F'')','0C5548630380','3','D','02','1157',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalary"','75','(''UA''=''F'')','0C5548630380','10','D','02','1160',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHourlySal"','76','(''UA''=''F'')','0C5548630380','10','D','02','1170',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalDate"','77','(''UD112''=''F'')','0C5548630380','8','D','02','1180',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalType"','78','(''UA''=''F'')','0C5548630380','2','D','02','1188',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvBonusAmt"','79','(''UA''=''F'')','0C5548630380','10','D','02','1190',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCommissionAmt"','80','(''UA''=''F'')','0C5548630380','10','D','02','1200',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSalaryMode"','81','(''UA''=''F'')','0C5548630380','1','D','02','1210',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvYTDWages"','82','(''UA''=''F'')','0C5548630380','10','D','02','1211',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvW4Withholding"','83','(''UA''=''F'')','0C5548630380','2','D','02','1221',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE1"','84','(''UA''=''F'')','0C5548630380','80','D','02','1223',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE2"','85','(''UA''=''F'')','0C5548630380','80','D','02','1303',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE3"','86','(''UA''=''F'')','0C5548630380','80','D','02','1383',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE4"','87','(''UA''=''F'')','0C5548630380','80','D','02','1463',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE5"','88','(''UA''=''F'')','0C5548630380','80','D','02','1543',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE6"','89','(''UA''=''F'')','0C5548630380','80','D','02','1623',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE7"','90','(''UA''=''F'')','0C5548630380','80','D','02','1703',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE8"','91','(''UA''=''F'')','0C5548630380','80','D','02','1783',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE9"','92','(''UA''=''F'')','0C5548630380','80','D','02','1863',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEE10"','93','(''UA''=''F'')','0C5548630380','80','D','02','1943',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEmpType"','94','(''UA''=''F'')','0C5548630380','1','D','02','2023',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceMonths"','95','(''UA''=''F'')','0C5548630380','4','D','02','2024',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfOrigHire"','96','(''UD112''=''F'')','0C5548630380','8','D','02','2028',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHireState"','97','(''UA''=''F'')','0C5548630380','2','D','02','2036',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvStatus"','98','(''UA''=''F'')','0C5548630380','1','D','02','2038',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfTerm"','99','(''UA''=''F'')','0C5548630380','8','D','02','2039',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursLast12Mos"','100','(''UA''=''F'')','0C5548630380','6','D','02','2047',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerWeek"','101','(''UA''=''F'')','0C5548630380','10','D','02','2053',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHoursPerDay"','102','(''UA''=''F'')','0C5548630380','9','D','02','2063',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDaysPerWeek"','103','(''UA''=''F'')','0C5548630380','8','D','02','2072',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMon"','104','(''UA''=''F'')','0C5548630380','1','D','02','2080',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTues"','105','(''UA''=''F'')','0C5548630380','1','D','02','2081',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWed"','106','(''UA''=''F'')','0C5548630380','1','D','02','2082',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvThurs"','107','(''UA''=''F'')','0C5548630380','1','D','02','2083',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFri"','108','(''UA''=''F'')','0C5548630380','1','D','02','2084',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSat"','109','(''UA''=''F'')','0C5548630380','1','D','02','2085',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvSun"','110','(''UA''=''F'')','0C5548630380','1','D','02','2086',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvMedCompany"','111','(''UA''=''F'')','0C5548630380','60','D','02','2087',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis1Code"','112','(''UA''=''F'')','0C5548630380','5','D','02','2147',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis1Type"','113','(''UA''=''F'')','0C5548630380','5','D','02','2152',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis1Stat"','114','(''UA''=''F'')','0C5548630380','1','D','02','2157',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis1Date"','115','(''UA''=''F'')','0C5548630380','8','D','02','2158',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis1Contr"','116','(''UA''=''F'')','0C5548630380','3','D','02','2166',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis1Level"','117','(''UA''=''F'')','0C5548630380','3','D','02','2169',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis2Code"','118','(''UA''=''F'')','0C5548630380','5','D','02','2172',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis2Type"','119','(''UA''=''F'')','0C5548630380','5','D','02','2177',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis2Stat"','120','(''UA''=''F'')','0C5548630380','1','D','02','2182',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis2Date"','121','(''UA''=''F'')','0C5548630380','8','D','02','2183',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis2Contr"','122','(''UA''=''F'')','0C5548630380','3','D','02','2191',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis2level"','123','(''UA''=''F'')','0C5548630380','3','D','02','2194',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis3Code"','124','(''UA''=''F'')','0C5548630380','5','D','02','2197',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis3Type"','125','(''UA''=''F'')','0C5548630380','5','D','02','2202',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis3Stat"','126','(''UA''=''F'')','0C5548630380','1','D','02','2207',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis3Date"','127','(''UA''=''F'')','0C5548630380','8','D','02','2208',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis3Contr"','128','(''UA''=''F'')','0C5548630380','3','D','02','2216',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis3Level"','129','(''UA''=''F'')','0C5548630380','3','D','02','2219',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis4Code"','130','(''UA''=''F'')','0C5548630380','5','D','02','2222',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis4Type"','131','(''UA''=''F'')','0C5548630380','5','D','02','2227',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis4Stat"','132','(''UA''=''F'')','0C5548630380','1','D','02','2232',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis4Date"','133','(''UA''=''F'')','0C5548630380','8','D','02','2233',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis4Contr"','134','(''UA''=''F'')','0C5548630380','3','D','02','2241',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis4Level"','135','(''UA''=''F'')','0C5548630380','3','D','02','2244',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis5Code"','136','(''UA''=''F'')','0C5548630380','5','D','02','2247',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis5Type"','137','(''UA''=''F'')','0C5548630380','5','D','02','2252',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis5Stat"','138','(''UA''=''F'')','0C5548630380','1','D','02','2257',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis5Date"','139','(''UA''=''F'')','0C5548630380','8','D','02','2258',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis5Contr"','140','(''UA''=''F'')','0C5548630380','3','D','02','2266',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis5Level"','141','(''UA''=''F'')','0C5548630380','3','D','02','2269',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis6Code"','142','(''UA''=''F'')','0C5548630380','5','D','02','2272',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis6Type"','143','(''UA''=''F'')','0C5548630380','5','D','02','2277',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis6Stat"','144','(''UA''=''F'')','0C5548630380','1','D','02','2282',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis6Date"','145','(''UA''=''F'')','0C5548630380','8','D','02','2283',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis6Contr"','146','(''UA''=''F'')','0C5548630380','3','D','02','2291',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis6Level"','147','(''UA''=''F'')','0C5548630380','3','D','02','2294',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis7Code"','148','(''UA''=''F'')','0C5548630380','5','D','02','2297',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis7Type"','149','(''UA''=''F'')','0C5548630380','5','D','02','2302',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis7Stat"','150','(''UA''=''F'')','0C5548630380','1','D','02','2307',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis7Date"','151','(''UA''=''F'')','0C5548630380','8','D','02','2308',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis7Contr"','152','(''UA''=''F'')','0C5548630380','3','D','02','2316',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis7Level"','153','(''UA''=''F'')','0C5548630380','3','D','02','2319',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis8Code"','154','(''UA''=''F'')','0C5548630380','5','D','02','2322',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis8Type"','155','(''UA''=''F'')','0C5548630380','5','D','02','2327',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis8Stat"','156','(''UA''=''F'')','0C5548630380','1','D','02','2332',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis8Date"','157','(''UA''=''F'')','0C5548630380','8','D','02','2333',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis8Contr"','158','(''UA''=''F'')','0C5548630380','3','D','02','2341',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDis8Level"','159','(''UA''=''F'')','0C5548630380','3','D','02','2344',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDurationType"','160','(''UA''=''F'')','0C5548630380','1','D','02','2347',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvFixedStartDate"','161','(''UA''=''F'')','0C5548630380','4','D','02','2348',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligAmtMode"','162','(''UA''=''F'')','0C5548630380','1','D','02','2352',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligAmtDuration"','163','(''UA''=''F'')','0C5548630380','11','D','02','2353',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligReviewPeriodMode"','164','(''UA''=''F'')','0C5548630380','1','D','02','2364',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvEligReviewDuration"','165','(''UA''=''F'')','0C5548630380','3','D','02','2365',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceMode"','166','(''UA''=''F'')','0C5548630380','1','D','02','2368',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvServiceAmt"','167','(''UA''=''F'')','0C5548630380','12','D','02','2369',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvNonEligLocInd"','168','(''UA''=''F'')','0C5548630380','1','D','02','2381',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvWorkSchedDate"','169','(''UA''=''F'')','0C5548630380','8','D','02','2382',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsMon"','170','(''UA''=''F'')','0C5548630380','9','D','02','2390',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsTues"','171','(''UA''=''F'')','0C5548630380','9','D','02','2399',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsWed"','172','(''UA''=''F'')','0C5548630380','9','D','02','2408',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsThurs"','173','(''UA''=''F'')','0C5548630380','9','D','02','2417',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsFri"','174','(''UA''=''F'')','0C5548630380','9','D','02','2426',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSat"','175','(''UA''=''F'')','0C5548630380','9','D','02','2435',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvHrsSun"','176','(''UA''=''F'')','0C5548630380','9','D','02','2444',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvAcqDate"','177','(''UA''=''F'')','0C5548630380','8','D','02','2453',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDateOfLastHire"','178','(''UA''=''F'')','0C5548630380','8','D','02','2461',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvKeyEmp"','179','(''UA''=''F'')','0C5548630380','1','D','02','2469',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvUnionEmp"','180','(''UA''=''F'')','0C5548630380','1','D','02','2470',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"ervExempt"','181','(''UA''=''F'')','0C5548630380','1','D','02','2471',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvCoWorkerSpouseSSN"','182','(''UA''=''F'')','0C5548630380','11','D','02','2472',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDate"','183','(''UD112''=''F'')','0C5548630380','8','D','02','2483',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','184','(''SS''=''F'')','0C5548630380','508','D','02','2491',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDisCustID"','1','(''UA''=''F'')','0C5548630380','9','T','03','1',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTDefault"','2','(''UA''=''F'')','0C5548630380','7','T','03','10',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvTDate"','3','(''UD112''=''F'')','0C5548630380','10','T','03','17',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"drvDetailRecCount"','4','(''UN00''=''F'')','0C5548630380','7','T','03','27',NULL,NULL,NULL,NULL);
INSERT INTO [dbo].[AscDefF] (AdfExpression,AdfFieldNumber,AdfForCond,AdfHeaderSystemID,AdfLen,AdfRecType,AdfSetNumber,AdfStartPos,AdfTableName,AdfTargetField,AdfVariableName,AdfVariableType) VALUES ('"filler"','5','(''SS''=''F'')','0C5548630380','2965','T','03','34',NULL,NULL,NULL,NULL);
DECLARE @UDENV varchar(3) = (SELECT CASE WHEN LEFT(@@SERVERNAME,3) IN ('WP1','WP2','WP3','WP4','WP5') THEN 'WP' ELSE LEFT(@@SERVERNAME,3) END);
DECLARE @ARNUM varchar(12) = (SELECT RTRIM(CmmContractNo) FROM dbo.CompMast);
DECLARE @UDSERVER varchar(5) = (SELECT RTRIM(LEFT(@@SERVERNAME,PATINDEX('%[0-9]%',@@SERVERNAME)) + SUBSTRING(@@SERVERNAME,PATINDEX('%UP[0-9]%',@@SERVERNAME)+2,1)));
SELECT @UDSERVER = CASE WHEN @UDSERVER = 'EW21' THEN 'WP6' WHEN @UDSERVER = 'EW22' THEN 'WP7' ELSE @UDSERVER END;
DECLARE @UDCOCODE varchar(5) = (SELECT RTRIM(CmmCompanyCode) FROM dbo.CompMast);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELMILIFGRN_20171116.txt',NULL,'Null','N','IAGFG',NULL,NULL,NULL,'ELMILIFGRN export','201710119','EMPEXPORT','ELMILIFGRN','Oct 13 2017 12:00AM','ELMILIFGRN',NULL,NULL,NULL,'201710119','Oct 11 2017 12:00AM','Dec 30 1899 12:00AM','201710041','489','','','201710041',dbo.fn_GetTimedKey(),NULL,'ULTI_WPGRNSK',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELMILIFGRN_20171116.txt',NULL,NULL,NULL,'IAGFG',NULL,NULL,NULL,'OE Active','201612309','EMPEXPORT','OEACTIVE','Oct 13 2017 12:00AM','ELMILIFGRN',NULL,NULL,NULL,'201612309','Dec 30 2016 12:00AM','Dec 30 1899 12:00AM','201610311',NULL,'','','201610311',dbo.fn_GetTimedKey(),NULL,'ULTI_WPGRNSK',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELMILIFGRN_20171116.txt',NULL,NULL,NULL,',IAGFG',NULL,NULL,NULL,'OE Passive','201701019','EMPEXPORT','OEPASSIVE','Oct 13 2017 12:00AM','ELMILIFGRN',NULL,NULL,NULL,'201701019','Jan  1 2017 12:00AM','Dec 30 1899 12:00AM','201701011',NULL,'','','201701011',dbo.fn_GetTimedKey(),NULL,'ULTI_WPGRNSK',NULL);
INSERT INTO [dbo].[AscExp] (expAscFileName,expAsOfDate,expCOID,expCOIDAllCompanies,expCOIDList,expDateOrPerControl,expDateTimeRangeEnd,expDateTimeRangeStart,expDesc,expEndPerControl,expEngine,expExportCode,expExported,expFormatCode,expGLCodeTypes,expGLCodeTypesAll,expGroupBy,expLastEndPerControl,expLastPayDate,expLastPeriodEndDate,expLastStartPerControl,expNoOfRecords,expSelectByField,expSelectByList,expStartPerControl,expSystemID,expTaxCalcGroupID,expUser,expIEXSystemID) VALUES ('\\us.saas\[UDENV]\[UDSERVER]\Downloads\V10\Exports\[UDCOCODE]\EmployeeHistoryExport\[UDCOCODE]_ELMILIFGRN_20171116.txt',NULL,'','','',NULL,NULL,NULL,'TEST','201710279','EMPEXPORT','TEST','Oct 27 2017  7:15PM','ELMILIFGRN',NULL,NULL,NULL,'201710279','Oct 27 2017 12:00AM','Dec 30 1899 12:00AM','201710271','963','','','201710271',dbo.fn_GetTimedKey(),NULL,'ULTI_WPGRNSK',NULL);
UPDATE dbo.AscExp SET expAscFileName = CASE WHEN LEFT(@UDENV,2) IN ('NW','EW','WP') THEN REPLACE(REPLACE(REPLACE(expAscFileName,'[UDENV]',@UDENV),'[UDSERVER]',@UDSERVER),'[UDCOCODE]',@UDCOCODE) ELSE '\\us.saas\' + LEFT(@UDENV,2) + '\Public\' + @ARNUM + '\Exports\' + @UDCOCODE + '_ELMILIFGRN_20171116.txt' END WHERE expFormatCode = 'ELMILIFGRN';
IF LEFT(@UDENV,2) = 'NW' UPDATE dbo.AscExp SET expAscFileName = REPLACE(expAscFileName,'Exports\',SPACE(0)) WHERE expFormatCode = 'ELMILIFGRN';
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','CountFilter','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','EEList','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','ExportDescription','C','Liberty Mutual Life - HEALI');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','ExportPath','V',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','InitialSort','C','drvSSN');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','MaxFileLength','C','3000');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','SubSort','C',NULL);
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','SystemID','V','1D8249FBE47B');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','Testing','V','Y');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','UseAudit','V','N');
INSERT INTO [dbo].[U_dsi_Configuration] (FormatCode,CfgName,CfgType,CfgValue) VALUES ('ELMILIFGRN','UseFileName','V','Y');
UPDATE dbo.U_dsi_Configuration SET CfgValue = CASE WHEN CfgName = 'UseFileName' THEN 'Y' ELSE NULL END WHERE FormatCode = 'ELMILIFGRN' AND CfgName IN ('UseFileName','ExportPath');
INSERT INTO dbo.CustomTemplates (CreationDate,Engine,EngineCode,IsActive,ModifiedDate) SELECT CreationDate = GETDATE(), Engine = AdhEngine, EngineCode = AdhFormatCode, IsActive = 1, ModifiedDate = GETDATE() FROM dbo.AscDefH WITH (NOLOCK) WHERE AdhFormatCode = 'ELMILIFGRN' AND NOT EXISTS(SELECT 1 FROM dbo.CustomTemplates WHERE EngineCode = AdhFormatCode);
IF OBJECT_ID('U_ELMILIFGRN_SavePath') IS NOT NULL DROP TABLE [dbo].[U_ELMILIFGRN_SavePath];
GO
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELMILIFGRN','H01','dbo.U_dsi_ELMILIFGRN_hdrTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELMILIFGRN','D02','dbo.U_dsi_ELMILIFGRN_drvTbl',NULL);
INSERT INTO [dbo].[U_dsi_SQLClauses] (FormatCode,RecordSet,FromClause,WhereClause) VALUES ('ELMILIFGRN','T03','dbo.U_dsi_ELMILIFGRN_trlTbl',NULL);
IF OBJECT_ID('U_ds_ELMILIFGRN_EarnHist') IS NULL
CREATE TABLE [dbo].[U_ds_ELMILIFGRN_EarnHist] (
    [eeid] char(12) NULL,
    [ecoid] char(5) NULL,
    [eamt] money NULL,
    [ehrs] decimal NULL,
    [ecode] char(5) NOT NULL
);
IF OBJECT_ID('U_dsi_ELMILIFGRN_drvTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELMILIFGRN_drvTbl] (
    [drvEEID] char(12) NULL,
    [drvcoid] char(5) NULL,
    [drvdepid] varchar(30) NULL,
    [drvrectype] varchar(1) NOT NULL,
    [drvRecordType] varchar(1) NOT NULL,
    [drvAccountNo] varchar(6) NOT NULL,
    [drvVerification] varchar(6) NOT NULL,
    [drvDisabilityID] varchar(9) NOT NULL,
    [drvWCLoc] varchar(1) NOT NULL,
    [drvSubCode] varchar(4) NOT NULL,
    [drvOrgI] varchar(1) NOT NULL,
    [drvOrgII] varchar(1) NOT NULL,
    [drvDivCode] varchar(1) NOT NULL,
    [drvDeptCode] varchar(1) NOT NULL,
    [drvPosition] varchar(1) NOT NULL,
    [drvDisContactType] varchar(1) NOT NULL,
    [drvDisNameFirst] varchar(100) NULL,
    [drvDisNameLast] varchar(100) NULL,
    [drvDisNameSuffix] varchar(1) NOT NULL,
    [drvDisAddress1] varchar(1) NOT NULL,
    [drvDisAddress2] varchar(1) NOT NULL,
    [drvDisCity] varchar(1) NOT NULL,
    [drvDisState] varchar(1) NOT NULL,
    [drvDisZIP] varchar(1) NOT NULL,
    [drvDisCountry] varchar(1) NOT NULL,
    [drvDisEmail] varchar(50) NULL,
    [drvDisPhoneArea] varchar(1) NOT NULL,
    [drvDisPhoneExchange] varchar(1) NOT NULL,
    [drvDisPhoneRange] varchar(1) NOT NULL,
    [drvDisPhoneExt] varchar(1) NOT NULL,
    [drvSupvFirst] varchar(1) NOT NULL,
    [drvSupvLast] varchar(1) NOT NULL,
    [drvSupvMI] varchar(1) NOT NULL,
    [drvSupvSuffix] varchar(1) NOT NULL,
    [drvSupvPhoneArea] varchar(1) NOT NULL,
    [drvSupvPhoneExchange] varchar(1) NOT NULL,
    [drvSupvPhoneRange] varchar(1) NOT NULL,
    [drvEmpNo] char(9) NULL,
    [drvEEState] char(2) NULL,
    [drvDisLocCode] varchar(8) NOT NULL,
    [drvDeptName] varchar(1) NOT NULL,
    [drvOccupationCode] varchar(1) NOT NULL,
    [drvOccupationDesc] varchar(25) NOT NULL,
    [drvPhysDemands] varchar(1) NOT NULL,
    [drvNameFirst] varchar(100) NULL,
    [drvNameLast] varchar(100) NULL,
    [drvNameMI] varchar(1) NULL,
    [drvNameSuffix] varchar(30) NULL,
    [drvAddress1] varchar(255) NULL,
    [drvAddress2] varchar(255) NULL,
    [drvAddressCity] varchar(255) NULL,
    [drvAddressState] varchar(255) NULL,
    [drvAddressZIP] varchar(50) NULL,
    [drvAddressCountry] char(3) NULL,
    [drvAddressCountryName] varchar(1) NOT NULL,
    [drvPhoneArea] varchar(1) NOT NULL,
    [drvPhoneExchange] varchar(1) NOT NULL,
    [drvPhoneRange] varchar(1) NOT NULL,
    [drvSSN] char(11) NULL,
    [drvSSNType] varchar(1) NOT NULL,
    [drvGender] char(1) NULL,
    [drvDateOfBirth] varchar(10) NULL,
    [drvMaritalCode] int NOT NULL,
    [drvMaritalTaxCode] varchar(1) NOT NULL,
    [drvSpouseBirthdate] varchar(1) NOT NULL,
    [drvDependentCount] varchar(2) NOT NULL,
    [drvDepsUnder18Count] varchar(2) NOT NULL,
    [drvEducationLevel] varchar(1) NOT NULL,
    [drvSalary] money NULL,
    [drvHourlySal] varchar(30) NULL,
    [drvSalDate] varchar(10) NULL,
    [drvSalType] varchar(2) NOT NULL,
    [drvBonusAmt] varchar(3) NOT NULL,
    [drvCommissionAmt] varchar(3) NOT NULL,
    [drvSalaryMode] varchar(1) NOT NULL,
    [drvYTDWages] varchar(3) NOT NULL,
    [drvW4Withholding] varchar(2) NOT NULL,
    [drvEE1] varchar(50) NOT NULL,
    [drvEE2] varchar(44) NOT NULL,
    [drvEE3] varchar(1) NOT NULL,
    [drvEE4] varchar(1) NOT NULL,
    [drvEE5] varchar(1) NOT NULL,
    [drvEE6] varchar(1) NOT NULL,
    [drvEE7] varchar(1) NOT NULL,
    [drvEE8] varchar(1) NOT NULL,
    [drvEE9] varchar(1) NOT NULL,
    [drvEE10] varchar(1) NOT NULL,
    [drvEmpType] varchar(1) NOT NULL,
    [drvServiceMonths] varchar(4) NOT NULL,
    [drvDateOfOrigHire] varchar(10) NULL,
    [drvHireState] varchar(1) NOT NULL,
    [drvStatus] varchar(1) NOT NULL,
    [drvDateOfTerm] varchar(10) NULL,
    [drvHoursLast12Mos] varchar(3) NOT NULL,
    [drvHoursPerWeek] varchar(3) NOT NULL,
    [drvHoursPerDay] varchar(3) NOT NULL,
    [drvDaysPerWeek] varchar(3) NOT NULL,
    [drvMon] varchar(1) NOT NULL,
    [drvTues] varchar(1) NOT NULL,
    [drvWed] varchar(1) NOT NULL,
    [drvThurs] varchar(1) NOT NULL,
    [drvFri] varchar(1) NOT NULL,
    [drvSat] varchar(1) NOT NULL,
    [drvSun] varchar(1) NOT NULL,
    [drvMedCompany] varchar(1) NOT NULL,
    [drvDis1Code] varchar(3) NULL,
    [drvDis1Type] varchar(5) NULL,
    [drvDis1Stat] char(1) NULL,
    [drvDis1Date] varchar(10) NULL,
    [drvDis1Contr] varchar(3) NOT NULL,
    [drvDis1Level] varchar(3) NOT NULL,
    [drvDis2Code] varchar(3) NULL,
    [drvDis2Type] varchar(5) NULL,
    [drvDis2Stat] char(1) NULL,
    [drvDis2Date] varchar(10) NULL,
    [drvDis2Contr] varchar(3) NOT NULL,
    [drvDis2level] varchar(3) NOT NULL,
    [drvDis3Code] varchar(5) NOT NULL,
    [drvDis3Type] varchar(5) NOT NULL,
    [drvDis3Stat] varchar(1) NOT NULL,
    [drvDis3Date] varchar(10) NULL,
    [drvDis3Contr] varchar(3) NOT NULL,
    [drvDis3Level] varchar(3) NOT NULL,
    [drvDis4Code] varchar(1) NOT NULL,
    [drvDis4Type] varchar(1) NOT NULL,
    [drvDis4Stat] varchar(1) NOT NULL,
    [drvDis4Date] varchar(1) NOT NULL,
    [drvDis4Contr] varchar(3) NOT NULL,
    [drvDis4Level] varchar(3) NOT NULL,
    [drvDis5Code] varchar(1) NOT NULL,
    [drvDis5Type] varchar(1) NOT NULL,
    [drvDis5Stat] varchar(1) NOT NULL,
    [drvDis5Date] varchar(1) NOT NULL,
    [drvDis5Contr] varchar(3) NOT NULL,
    [drvDis5Level] varchar(3) NOT NULL,
    [drvDis6Code] varchar(1) NOT NULL,
    [drvDis6Type] varchar(1) NOT NULL,
    [drvDis6Stat] varchar(1) NOT NULL,
    [drvDis6Date] varchar(1) NOT NULL,
    [drvDis6Contr] varchar(3) NOT NULL,
    [drvDis6Level] varchar(3) NOT NULL,
    [drvDis7Code] varchar(1) NOT NULL,
    [drvDis7Type] varchar(1) NOT NULL,
    [drvDis7Stat] varchar(1) NOT NULL,
    [drvDis7Date] varchar(1) NOT NULL,
    [drvDis7Contr] varchar(3) NOT NULL,
    [drvDis7Level] varchar(3) NOT NULL,
    [drvDis8Code] varchar(1) NOT NULL,
    [drvDis8Type] varchar(1) NOT NULL,
    [drvDis8Stat] varchar(1) NOT NULL,
    [drvDis8Date] varchar(1) NOT NULL,
    [drvDis8Contr] varchar(3) NOT NULL,
    [drvDis8Level] varchar(3) NOT NULL,
    [drvDurationType] varchar(1) NOT NULL,
    [drvFixedStartDate] varchar(1) NOT NULL,
    [drvEligAmtMode] varchar(1) NOT NULL,
    [drvEligAmtDuration] varchar(30) NULL,
    [drvEligReviewPeriodMode] varchar(1) NOT NULL,
    [drvEligReviewDuration] varchar(3) NOT NULL,
    [drvServiceMode] varchar(1) NOT NULL,
    [drvServiceAmt] varchar(30) NULL,
    [drvNonEligLocInd] varchar(1) NOT NULL,
    [drvWorkSchedDate] varchar(1) NOT NULL,
    [drvHrsMon] varchar(24) NULL,
    [drvHrsTues] varchar(24) NULL,
    [drvHrsWed] varchar(24) NULL,
    [drvHrsThurs] varchar(24) NULL,
    [drvHrsFri] varchar(24) NULL,
    [drvHrsSat] varchar(24) NULL,
    [drvHrsSun] varchar(24) NULL,
    [drvAcqDate] varchar(1) NOT NULL,
    [drvDateOfLastHire] varchar(10) NULL,
    [drvKeyEmp] char(1) NULL,
    [drvUnionEmp] varchar(1) NOT NULL,
    [ervExempt] varchar(1) NOT NULL,
    [drvCoWorkerSpouseSSN] varchar(1) NOT NULL,
    [drvDate] datetime NOT NULL
);
IF OBJECT_ID('U_dsi_ELMILIFGRN_hdrTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELMILIFGRN_hdrTbl] (
    [drvCustID] varchar(9) NOT NULL,
    [DrvRecordNo] varchar(7) NOT NULL,
    [drvFileDate] datetime NOT NULL,
    [drvRecLength] varchar(4) NOT NULL
);
IF OBJECT_ID('U_dsi_ELMILIFGRN_trlTbl') IS NULL
CREATE TABLE [dbo].[U_dsi_ELMILIFGRN_trlTbl] (
    [drvDisCustID] varchar(9) NOT NULL,
    [drvTDefault] varchar(7) NOT NULL,
    [drvTDate] datetime NOT NULL,
    [drvDetailRecCount] int NULL
);
IF OBJECT_ID('U_ELMILIFGRN_EEList') IS NULL
CREATE TABLE [dbo].[U_ELMILIFGRN_EEList] (
    [xCOID] char(5) NULL,
    [xEEID] char(12) NULL
);
IF OBJECT_ID('U_ELMILIFGRN_File') IS NULL
CREATE TABLE [dbo].[U_ELMILIFGRN_File] (
    [RecordSet] char(3) NOT NULL,
    [InitialSort] varchar(100) NOT NULL,
    [SubSort] varchar(100) NOT NULL,
    [SubSort2] varchar(100) NULL,
    [SubSort3] varchar(100) NULL,
    [Data] char(2999) NULL
);
GO
/* 
delete from dbo.U_dsi_TOC
  where tocItem = 'dsi_sp_BuildDriverTables_ELMILIFGRN'
insert into dbo.U_dsi_TOC(tocItem, tocLastUpdated, tocType, tocVersion)
  select 'dsi_sp_BuildDriverTables_ELMILIFGRN',getdate(),'P','V1.TD'
*/

CREATE PROCEDURE [dbo].[dsi_sp_BuildDriverTables_ELMILIFGRN]
 @systemid varchar(12) = ''
AS
Begin

/*************************************************************************************************
DRIVER TABLE SP FOR:  Liberty Mutual Life - Fixed Length 3000
BUILT FOR:     Greensky, LLC
ORIGINAL BUILD (V-1.0): 2017.10.13 - BMitch
PROJECT: GRE1032-2017-00173693-Interface File
REVISIONS:

*************************************************************************************************/

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
        @ExportFile char(200)

    --    Declare @Systemid char(12) 
    --    set @Systemid = '6DWPQL0000K0'

    SELECT 
        @StartDate = CONVERT(DATETIME, LEFT(StartPerControl, 8) ),
        @EndDate = CONVERT(DATETIME, LEFT(EndPerControl , 8)  ),
        @StartPerControl = startpercontrol,
        @EndPerControl  = endpercontrol,
        @FormatCode = rtrim(formatcode),
        @ExportCode = Exportcode,
        @Exportfile = ExportFile

    FROM dbo.U_Dsi_Parameters 
    WHERE SystemID = @SystemID

-- dedcodes

declare @DedList varchar(200) 
select @DedList = 'x'    --no longer used

-- change variables below as needed
declare @daysstopped int   
declare @useaudit char(1)
declare @includeoe char(1)

declare @showalldeds char(1)
declare @allcomp char(1)
declare @onerecperemp char(1)
declare @showstoppedoe  char(1)
declare @oetype char(1)
set @daysstopped = 90    -- set number of days if looking for only showing deds stopped within certain days
set @useaudit = 'Y'    -- Y or N  indicates if this export uses audit to determine data to pull
set @includeoe = 'N'   -- Y or N  indicates if this export will include open enrollment
set @showalldeds = 'N' -- Y or N  indicates if this export shows stopped and active ded of same type
set @allcomp = 'Y'     -- Y or N  indicates if this export pull deds for all companies for an employee
set @onerecperemp = 'Y'  -- Y or N indicate if the export should show only one record per employee
set @showstoppedoe = 'N' -- Y or N  indicates if stopped open enrollment deductions should be shown
set @oetype = 'F'        -- P or F indicates if this export is for a passive or full(active) oe

-- clean up EELIST if needed

-- clean up list if not using all companies
if @allcomp = 'N'
begin
            delete dbo.u_ELMILIFGRN_EELIST
            from dbo.u_ELMILIFGRN_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

end

--BDM
-- replace Esssssssss with the OE session if applicable

DELETE FROM U_dsi_bdm_Configuration WHERE FormatCode = @FormatCode

/*
ACCID - ACCID
GLIFE - Basic Life & AD&D
LTD   - Long Term Disability
LIFEC - Voluntary Life Child
DLIFE - Voluntary Domestic Partner Life
LIFES - Voluntary Spousal Life
LIFEE - Voluntary Employee Life
STD   - Short Term Disability

*/

--INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','ACCID,GLIFE,LTD,LIFEC,DLIFE,LIFES,LIFEE,STD')
INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'DedCodes','LTD,STD')
IF @ExportCode NOT IN ('OEACTIVE','OEPASSIVE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@EndDate - @daysstopped)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END
IF @ExportCode IN ('OEACTIVE','OEPASSIVE') BEGIN
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'StartDateTime',@StartDate)
    INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'EndDateTime',@EndDate)
END

INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'TermSelectionOption', 'AuditDate')    --'ActiveOnly')    --'stoptdate')    --'AuditDate')

IF @ExportCode = 'OEPASSIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Passive')
END
IF @ExportCode = 'OEACTIVE' BEGIN
   INSERT INTO U_dsi_bdm_Configuration VALUES (@FormatCode, 'OEType', 'Active')
END

EXEC dbo.dsi_bdm_sp_PopulateDeductionsTable @FormatCode

-- Step20 Clean up eelist if needed to only include employees with deductions
--            delete dbo.u_ELMILIFGRN_eelist
--            from dbo.u_ELMILIFGRN_eelist a
--            where not exists(select 1 from U_dsi_bdm_EmpDeductions
--                            where a.xeeid = eedeeid
--                            and a.xcoid = eedcoid
--                            and eedformatcode = @formatcode
--                            and eedvalidforexport = 'Y')

-- Clean up eelist if only one record per employee
if @onerecperemp = 'Y'
begin
            delete dbo.u_ELMILIFGRN_EELIST
            from dbo.u_ELMILIFGRN_EELIST
            join empcomp t with (nolock) on xeeid = eeceeid and xcoid = eeccoid
            where t.eecemplstatus = 'T'
            and exists(select 1 from empcomp a where a.eeceeid = t.eeceeid
                and a.eecemplstatus <> 'T')

            delete dbo.u_ELMILIFGRN_eelist
            from dbo.u_ELMILIFGRN_eelist a
            join emppers with (nolock) on xeeid = eepeeid
            where eephomecoid <> xcoid
            and exists(select 1 from dbo.u_ELMILIFGRN_eelist b where a.xeeid = b.xeeid
            having count(*) > 1)
end

delete dbo.u_ELMILIFGRN_EELIST
where xeeid+xcoid in (select eeceeid+eeccoid from empcomp where eecemplstatus = 'T' and DATEDIFF(dd,eecdateoftermination,@EndDate) > @daysstopped)

--dbo.dsi_sp_TestSwitchbox 'ELMILIFGRN','ELMILIFGRN'

/****Create Table: U_ds_ELMILIFGRN_EarnHist***/

if object_id('dbo.U_ds_ELMILIFGRN_EarnHist') is not null
  drop table dbo.U_ds_ELMILIFGRN_EarnHist

Select
    xEEID eeid,
    xCOID ecoid,
    SUM(ISNULL(pehCurAmt,0.00)) AS eamt,
    SUM(ISNULL(pehCurHrs,0.00)) AS ehrs,
    pehearncode ecode

    Into    dbo.U_ds_ELMILIFGRN_EarnHist
From    dbo.u_ELMILIFGRN_EELIST
join    PEARHIST (nolock) on xeeid = pehEEID and xcoid = pehCOID
    --and pehpaydate between getdate()-365 and getdate() --TD 2/19/16 removed client advised to report hours worked since employment (not YTD)
    and pehearncode not in ('PTO','HOL','BEREV','JURY','PTOPO','UPTO') --TD 1/7/16 exclude these earnings codes
group by xEEID, xCOID, pehearncode

--select * from dbo.U_ds_ELMILIFGRN_EarnHist

-- Populate Source for Employees

if object_id('dbo.U_dsi_ELMILIFGRN_drvTbl') is not null
  drop table dbo.U_dsi_ELMILIFGRN_drvTbl

-- EE Detail

  select distinct
    drvEEID = xEEID, 
    drvcoid = xcoid,
    drvdepid = cast(null as varchar),
    drvrectype = 'E',
-- standard fields above and additional driver fields below
    drvRecordType = 'D',
    drvAccountNo = '333214',
    drvVerification = '352078',
    drvDisabilityID = '05-292091',
    drvWCLoc = '',
    drvSubCode = CASE WHEN eecLocation = 'KY' THEN 'NOKY' ELSE '0ATL' END, --'0000',
    drvOrgI = '',--eecOrgLvl1,
    drvOrgII = '',--eecOrgLvl2,
    drvDivCode = '',--eecOrgLvl3,
    drvDeptCode = '',
    drvPosition = '',--eecJobCode,
    drvDisContactType = 'M',
    drvDisNameFirst = SV.eepNameFirst,
    drvDisNameLast = SV.eepNameLast,
    drvDisNameSuffix = '',
    drvDisAddress1 = '',
    drvDisAddress2 = '',
    drvDisCity = '',
    drvDisState = '',
    drvDisZIP = '',
    drvDisCountry = '',
    drvDisEmail = SV.eepAddressEmail,
    drvDisPhoneArea = '',
    drvDisPhoneExchange = '',
    drvDisPhoneRange = '',
    drvDisPhoneExt = '',
    drvSupvFirst = '',
    drvSupvLast = '',
    drvSupvMI = '',
    drvSupvSuffix = '',
    drvSupvPhoneArea = '',
    drvSupvPhoneExchange = '',
    drvSupvPhoneRange = '',
    drvEmpNo = eecEmpNo,
    drvEEState = eecWCState,
    drvDisLocCode = '00000000',
    drvDeptName = '',
    drvOccupationCode = '',
    drvOccupationDesc = JbcDesc,--dbo.fn_getCodeDesc(jbceeocategory,'EEOCATEGORY'),
    drvPhysDemands = '',
    drvNameFirst = rtrim(EP.eepNameFirst),
    drvNameLast = rtrim(EP.eepNameLast),
    drvNameMI = case when EP.eepNameMiddle <> 'Z' then substring(EP.eepNameMiddle,1,1) else '' end,
    drvNameSuffix = case when EP.eepNameSuffix <> 'Z' then EP.eepNameSuffix else '' end,
    drvAddress1 = EP.eepAddressLine1,
    drvAddress2 = EP.eepAddressLine2,
    drvAddressCity = EP.eepAddressCity,
    drvAddressState = EP.eepAddressState,
    drvAddressZIP = EP.eepAddressZipCode,
    drvAddressCountry = EP.eepAddressCountry,
    drvAddressCountryName = '',
    drvPhoneArea = '',
    drvPhoneExchange = '',
    drvPhoneRange = '',
    drvSSN = EP.eepSSN,
    drvSSNType = case when EP.eepAddressCountry = 'USA' then '1'
                      when EP.eepAddressCountry = 'CAN' then '2' else '' end,
    drvGender = EP.eepGender,
    drvDateOfBirth = CONVERT(varchar(10), EP.eepDateOfBirth, 112),
    drvMaritalCode = case EP.eepMaritalStatus
                when 'S' then 1
                when 'M' then 2
                when 'W' then 3
                when 'D' then 4
                when 'Z' then 6
                else 6 end,
    drvMaritalTaxCode = '',
    drvSpouseBirthdate = '',
    drvDependentCount = '0 ',
    drvDepsUnder18Count = '0 ',
    drvEducationLevel = '',
    drvSalary = eecAnnSalary,
    drvHourlySal = cast(cast(EecHourlyPayRate as decimal(6,1)) as varchar),
    drvSalDate = CONVERT(varchar(10), coalesce(jh.jobeffdate,eecdateoflasthire,eecdateoforiginalhire), 112),
    drvSalType = CASE WHEN eecSalaryOrHourly = 'S' THEN 'SL' ELSE 'HR' END,
    drvBonusAmt = '0.0',
    drvCommissionAmt = '0.0',
    drvSalaryMode = '6',--Annual
    drvYTDWages = '0.0',
    drvW4Withholding = '0 ',
    drvEE1 ='Kelly;Blackwell;kelly.blackwell@greenskycredit.com',
    drvEE2 = 'Liz;Phillips;liz.phillips@greenskycredit.com',
    drvEE3 = '',
    drvEE4 = '',
    drvEE5 = '',
    drvEE6 = '',
    drvEE7 = '',
    drvEE8 = '',
    drvEE9 = '',
    drvEE10 = '',
    drvEmpType = case eecfulltimeorparttime
                    when 'F' then '1'
                    when 'P' then '2' else 'U' end,
    drvServiceMonths = '0   ',
    drvDateOfOrigHire = CONVERT(varchar(10), eecDateOfOriginalHire, 112),
    drvHireState = '',
    drvStatus = case when eecEmplStatus = 'T' then 'T' else 'A' end,
    drvDateOfTerm = case when eecDateOfTermination is not null then CONVERT(varchar(10), eecDateOfTermination, 112) else '' end,
    drvHoursLast12Mos = '0.0',
    drvHoursPerWeek = '0.0',
    drvHoursPerDay = '0.0',
    drvDaysPerWeek = '0.0',
    drvMon = '',
    drvTues = '',
    drvWed = '',
    drvThurs = '',
    drvFri = '',
    drvSat = '',
    drvSun = '',
    drvMedCompany = '',
--STD
    drvDis1Code = std.disCode, --Field.112 @pos.2147
    drvDis1Type = std.disType,
    drvDis1Stat = std.disStat,
    drvDis1Date = case when isnull(std.dcode,'') <> '' then
                       case when EecDateOfLastHire < CAST('20180101' as datetime) then CONVERT(varchar(10), eecDateOfLastHire, 112)
                       else CONVERT(varchar(10), DATEADD(dd,-(DAY(DATEADD(mm,1,eecdateoflasthire+90))-1),DATEADD(mm,1,eecdateoflasthire+90)), 112) end
                  else null end, --TD 3/22/16 changes per client 

    drvDis1Contr = isnull(std.disContr,'0  '),
    drvDis1Level = isnull(std.disLevel,'0  '),
--LTD
    drvDis2Code = ltd.disCode,
    drvDis2Type = ltd.disType,
    drvDis2Stat = ltd.disStat,
    drvDis2Date = case when isnull(ltd.dcode,'') <> '' then
                       case when EecDateOfLastHire < CAST('20180101' as datetime) then CONVERT(varchar(10), eecDateOfLastHire, 112)
                       else CONVERT(varchar(10), DATEADD(dd,-(DAY(DATEADD(mm,1,eecdateoflasthire+90))-1),DATEADD(mm,1,eecdateoflasthire+90)), 112) end
                  else null end,--TD 3/22/16 changes per client
    drvDis2Contr = isnull(ltd.disContr,'0  '),
    drvDis2level = isnull(ltd.disLevel,'0  '),
--LEAVE
    drvDis3Code = 'LEAVE',
    drvDis3Type = 'FMLA ',
    drvDis3Stat = 'A',
    drvDis3Date = CONVERT(varchar(10), eecDateOfLastHire, 112),
    drvDis3Contr = '000',
    drvDis3Level = '000',
--Not Used
    drvDis4Code = '',
    drvDis4Type = '',
    drvDis4Stat = '',
    drvDis4Date = '',
    drvDis4Contr = '0  ',
    drvDis4Level = '0  ',
    drvDis5Code = '',
    drvDis5Type = '',
    drvDis5Stat = '',
    drvDis5Date = '',
    drvDis5Contr = '0  ',
    drvDis5Level = '0  ',
    drvDis6Code = '',
    drvDis6Type = '',
    drvDis6Stat = '',
    drvDis6Date = '',
    drvDis6Contr = '0  ',
    drvDis6Level = '0  ',
    drvDis7Code = '',
    drvDis7Type = '',
    drvDis7Stat = '',
    drvDis7Date = '',
    drvDis7Contr = '0  ',
    drvDis7Level = '0  ',
    drvDis8Code = '',
    drvDis8Type = '',
    drvDis8Stat = '',
    drvDis8Date = '',
    drvDis8Contr = '0  ',
    drvDis8Level = '0  ',
--FMLA
    drvDurationType = ' ',
    drvFixedStartDate = '',
    drvEligAmtMode = 'H',
    drvEligAmtDuration = cast(eh.hours as varchar),
    drvEligReviewPeriodMode = 'M',
    drvEligReviewDuration = '012',
    drvServiceMode = 'M',
    drvServiceAmt = case when eecdateoftermination is null then cast(DATEDIFF(d,eecdateoforiginalhire,getdate())/30.0 as varchar)
                         else cast(DATEDIFF(d,eecdateoforiginalhire,eecdateoftermination)/30.0 as varchar) end,
    drvNonEligLocInd = '',
    drvWorkSchedDate = '',
    drvHrsMon = case when eecfulltimeorparttime = 'F' then dbo.fn_padzero('8.0',9,6) else dbo.fn_padzero('5.0',9,6) end,--dbo.fn_padzero(cast(round((eecscheduledworkhrs/15),6,1) as varchar),9,6),
    drvHrsTues = case when eecfulltimeorparttime = 'F' then dbo.fn_padzero('8.0',9,6) else dbo.fn_padzero('5.0',9,6) end,--dbo.fn_padzero(cast(round((eecscheduledworkhrs/15),6,1) as varchar),9,6),
    drvHrsWed = case when eecfulltimeorparttime = 'F' then dbo.fn_padzero('8.0',9,6) else dbo.fn_padzero('5.0',9,6) end,--dbo.fn_padzero(cast(round((eecscheduledworkhrs/15),6,1) as varchar),9,6),
    drvHrsThurs = case when eecfulltimeorparttime = 'F' then dbo.fn_padzero('8.0',9,6) else dbo.fn_padzero('5.0',9,6) end,--dbo.fn_padzero(cast(round((eecscheduledworkhrs/15),6,1) as varchar),9,6),
    drvHrsFri = case when eecfulltimeorparttime = 'F' then dbo.fn_padzero('8.0',9,6) else dbo.fn_padzero('5.0',9,6) end,--dbo.fn_padzero(cast(round((eecscheduledworkhrs/15),6,1) as varchar),9,6),
    drvHrsSat = dbo.fn_padzero('0.0',9,6),--dbo.fn_padzero(cast(round((eecscheduledworkhrs/15),6,1) as varchar),9,6),
    drvHrsSun = dbo.fn_padzero('0.0',9,6),--dbo.fn_padzero(cast(round((eecscheduledworkhrs/15),6,1) as varchar),9,6),
    drvAcqDate = '',
    drvDateOfLastHire = CONVERT(varchar(10), eecDateOfLastHire, 112),
    drvKeyEmp = eecIsKeyEmployee,
    drvUnionEmp = '',--case when eecunionlocal = 'UAP' then 'Y' else 'N' end,
    ervExempt = case when jbcflsatype = 'E' then 'Y' else 'N' end,
    drvCoWorkerSpouseSSN = '',
    drvDate = getdate()
    --SELECT * FROM dbo.U_dsi_ELMILIFGRN_drvTbl
  into dbo.U_dsi_ELMILIFGRN_drvTbl
  from dbo.u_ELMILIFGRN_eelist with (nolock)
    join empPers EP with (nolock) on xEEID = eepEEID
    join empcomp EC with (nolock) on xEEID = eecEEid and xCOID = eecCOID
    join jobcode with (nolock) on eecJobCode = jbcJobCode
    --LEFT JOIN (SELECT eepEEID, eepNamefirst,eepNameLast,eepAddressEmail 
    --            FROM EmpPers WHERE eepEEID IN (SELECT Distinct eecSupervisorID FROM EmpComp WHERE eecEmplStatus <>'T')) SV ON SV.eepEEID = EC.eecSupervisorID
    LEFT JOIN EmpPers SV ON SV.eepEEID = EC.eecSupervisorID AND SV.eepHomeCOID = EC.eecCOID
    left join (select ejheeid, ejhcoid, max(ejhjobeffdate) jobeffdate
        from emphjob where ejhisratechange = 'Y' group by ejheeid,ejhcoid) jh on jh.ejheeid = xeeid and jh.ejhcoid = xcoid

    left join (select eeid eheeid, ecoid ehcoid, sum(ehrs) hours
        from dbo.U_ds_ELMILIFGRN_EarnHist group by eeid, ecoid) eh on eh.eheeid = xeeid and eh.ehcoid = xcoid

    left join (select eedeeid eeid, eedcoid coid, EedDedCode dcode, 'STD' disCode,'STD01' disType, 
                      EedBenStatus disStat,'000' disContr, '060' disLevel
        from dbo.U_dsi_bdm_EmpDeductions where eeddedcode IN ('STD') --02/20/17 BJ ADD: STD1 REMOVE: STD
        and EedFormatCode = 'ELMILIFGRN' and EedValidForExport = 'Y') std on std.eeid = xeeid and std.coid = xcoid

    left join (select eedeeid eeid, eedcoid coid, EedDedCode dcode, 'LTD' disCode, 'LTD01' disType, --02/20/17 BJ ADD: LTD; 
                      --case 
                          --when EedDedCode = 'LTD1' then 'LTD01' --02/20/17 BJ REMOVE: LTD1
                          --when EedDedCode = 'LTD2' then 'LTD02' --02/20/17 BJ REMOVE: LTD2
                           --end disType, 
                      EedBenStatus disStat,'000' disContr, '060' disLevel
        from dbo.U_dsi_bdm_EmpDeductions where eeddedcode IN ('LTD') and EedFormatCode = 'ELMILIFGRN' and EedValidForExport = 'Y'--02/13/17 BJ ADD: LTD; REMOVE:'LTD1','LTD2'
        and EedBenStatus <> 'C') ltd on ltd.eeid = xeeid and ltd.coid = xcoid

---- Dependents
-- 
--insert into dbo.U_dsi_ELMILIFGRN_drvTbl 
--  select distinct 
--    drvEEID = dbneeid, 
--    drvcoid = '',
--    drvdepid = dbnDepRecID,
--    drvrectype = 'D',
---- standard fields above and additional driver fields below
--
--
--from dbo.U_dsi_bdm_DepDeductions
--    join dbo.U_dsi_ELMILIFGRN_drvTbl on dbneeid = drveeid and drvdepid is null
--    join emppers on dbneeid = eepeeid
--    join empcomp on dbneeid = eeceeid
--    join contacts on dbneeid = coneeid and dbndeprecid = consystemid
--where DbnFormatCode = @FormatCode
--    and dbnvalidforexport = 'Y'
--
----select * from dbo.U_dsi_bdm_DepDeductions

-- Create Headers

if object_id('dbo.U_dsi_ELMILIFGRN_hdrTbl') is not null
  drop table dbo.U_dsi_ELMILIFGRN_hdrTbl

SELECT
    drvCustID = '05-292091',
    DrvRecordNo = '0000000',
    drvFileDate = getdate(),
    drvRecLength = '3000'

INTO dbo.U_dsi_ELMILIFGRN_hdrTbl

-- Create Trailers

if object_id('dbo.U_dsi_ELMILIFGRN_trlTbl') is not null
  drop table dbo.U_dsi_ELMILIFGRN_trlTbl

SELECT
    drvDisCustID  = '05-292091',
    drvTDefault = '9999999',
    drvTDate = getdate(),
    drvDetailRecCount = cnt.dtlcount

INTO dbo.U_dsi_ELMILIFGRN_trlTbl
from (select count(*) dtlcount from dbo.U_dsi_ELMILIFGRN_drvTbl ) cnt

-- Set FileName  
if (dbo.dsi_fnVariable('ELMILIFGRN','UseFileName') = 'N')
  update dbo.U_dsi_Parameters
    set ExportFile =  'GRNSK_LibMutual_' + convert(char(8),getdate(),112) + '.txt'
    where FormatCode = 'ELMILIFGRN'

-- Remember to alter view for correct sorting
/*
 ALTER  View dbo.dsi_vwELMILIFGRN_Export as
        select top 2000000 Data from dbo.U_ELMILIFGRN_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 else 3 end,
            initialsort, subsort, substring(Recordset,2,2)

*/

--select len(data) from dsi_vwELMILIFGRN_Export

--Used for testing
--dbo.dsi_sp_TestSwitchbox_v2 'ELMILIFGRN','ELMILIFGRN'
--dbo.dsi_sp_TestSwitchbox_v2 'ELMILIFGRN','TEST'

END
GO
CREATE  View dbo.dsi_vwELMILIFGRN_Export as
        select top 2000000 Data from dbo.U_ELMILIFGRN_File with (nolock)
         order by case when substring(Recordset,1,1) = 'H' then 1 
                       when substring(Recordset,1,1) = 'D' then 2 else 3 end,
            initialsort, subsort, substring(Recordset,2,2)